<#
    Claude Code notification script for Windows.
    Windows counterpart to ccnotify.sh (macOS). Shows a native toast when
    Claude Code events occur.

    Usage: ccnotify.ps1 -Event Stop|Notification   (hook JSON on stdin)

    WinRT toast APIs are unreachable from PowerShell 7, which dropped the
    implicit WinRT projection, so the toast is dispatched through the
    in-box Windows PowerShell 5.1 instead.
#>
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('Stop', 'Notification')]
    [string]$Event,

    # Bound only when the script is piped to in-process. The hook runs it as a
    # subprocess, where stdin arrives on Console.In instead.
    [Parameter(ValueFromPipeline = $true)]
    [AllowEmptyString()]
    [string[]]$StdIn
)

begin {
    $piped = [System.Collections.Generic.List[string]]::new()
}

process {
    foreach ($line in $StdIn) { $piped.Add($line) }
}

end {
    $ErrorActionPreference = 'Stop'

    # Never let a notification failure break the session.
    trap { exit 0 }

    if ($env:OS -ne 'Windows_NT') { exit 0 }

    $psDesktop = Join-Path $env:SystemRoot 'System32\WindowsPowerShell\v1.0\powershell.exe'
    if (-not (Test-Path $psDesktop)) { exit 0 }

    $raw = if ($piped.Count) { $piped -join "`n" }
           elseif ([Console]::IsInputRedirected) { [Console]::In.ReadToEnd() }
           else { '' }

    if ([string]::IsNullOrWhiteSpace($raw)) { $raw = '{}' }
    try { $hook = $raw | ConvertFrom-Json } catch { $hook = [pscustomobject]@{} }

    function Show-Toast {
        param([string]$Title, [string]$Message)

        # Toasts must be dispatched under a registered AppUserModelID; the in-box
        # Windows PowerShell shortcut id is the one available without installing.
        $appId = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'

        $body = @'
param($AppId, $Title, $Message)
[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType=WindowsRuntime] > $null
[Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom, ContentType=WindowsRuntime] > $null
$doc = New-Object Windows.Data.Xml.Dom.XmlDocument
$doc.LoadXml("<toast><visual><binding template=""ToastGeneric""><text>$([System.Security.SecurityElement]::Escape($Title))</text><text>$([System.Security.SecurityElement]::Escape($Message))</text></binding></visual></toast>")
$toast = New-Object Windows.UI.Notifications.ToastNotification $doc
[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($AppId).Show($toast)
'@

        $call = "& { $body } '$($appId -replace "'","''")' '$($Title -replace "'","''")' '$($Message -replace "'","''")'"
        $encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($call))

        & $psDesktop -NoProfile -NonInteractive -EncodedCommand $encoded 2>$null | Out-Null
    }

    function Get-TranscriptSummary {
        param([string]$Path)

        if ([string]::IsNullOrWhiteSpace($Path) -or -not (Test-Path -LiteralPath $Path)) { return '' }

        $entries = foreach ($line in [IO.File]::ReadLines($Path)) {
            if (-not [string]::IsNullOrWhiteSpace($line)) {
                try { $line | ConvertFrom-Json } catch { }
            }
        }
        if (-not $entries) { return '' }

        $stamps = foreach ($e in $entries) {
            $parsed = [datetime]::MinValue
            if ($e.timestamp -and [datetime]::TryParse(
                    $e.timestamp, [cultureinfo]::InvariantCulture,
                    [Globalization.DateTimeStyles]::AdjustToUniversal, [ref]$parsed)) { $parsed }
        }

        $duration = ''
        if (@($stamps).Count -ge 2) {
            $span = ($stamps | Measure-Object -Maximum).Maximum - ($stamps | Measure-Object -Minimum).Minimum
            $duration = if ($span.TotalSeconds -ge 60) {
                '{0}m {1}s' -f [int]$span.TotalMinutes, $span.Seconds
            } else {
                '{0}s' -f [int]$span.TotalSeconds
            }
        }

        $tools = foreach ($e in $entries) {
            foreach ($c in @($e.message.content)) {
                if ($c.type -eq 'tool_use') { $c }
            }
        }

        $parts = @()

        $files = @($tools | Where-Object { $_.name -in 'Edit', 'Write' } |
            ForEach-Object { $_.input.file_path } |
            Where-Object { $_ } | ForEach-Object { Split-Path $_ -Leaf } |
            Select-Object -Unique)

        if ($files.Count -eq 1) { $parts += "Edited $($files[0])" }
        elseif ($files.Count -gt 1) { $parts += "Edited $($files.Count) files" }

        $cmds = @($tools | Where-Object { $_.name -eq 'Bash' } |
            ForEach-Object { ($_.input.command -split '\s+')[0] } |
            Where-Object { $_ } | Select-Object -Unique -First 2)

        if ($cmds) { $parts += "Ran $($cmds -join ', ')" }

        $summary = $parts -join ' | '
        if ($summary -and $duration) { return "$summary ($duration)" }
        if ($summary) { return $summary }
        return $duration
    }

    switch ($Event) {
        'Stop' {
            $message = Get-TranscriptSummary -Path $hook.transcript_path
            if (-not $message) { $message = 'Task completed' }
            Show-Toast -Title 'Claude Code' -Message $message
        }
        'Notification' {
            $message = if ($hook.message) { $hook.message } else { 'Notification' }
            Show-Toast -Title 'Claude Code' -Message $message
        }
    }

    exit 0
}
