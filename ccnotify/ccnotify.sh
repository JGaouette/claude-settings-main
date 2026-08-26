#!/bin/bash
# Claude Code notification script for macOS.
# Shows notification when Claude Code events occur.

EVENT="$1"

# Read hook data from stdin
HOOK_DATA=$(cat)

show_notification() {
    local title="$1"
    local message="$2"

    if command -v terminal-notifier &> /dev/null; then
        terminal-notifier -title "$title" -message "$message" -sound default
    fi
}

parse_transcript() {
    local transcript_path="$1"

    if [ -z "$transcript_path" ] || [ ! -f "$transcript_path" ]; then
        echo ""
        return
    fi

    # Calculate duration from first and last timestamps
    local first_ts last_ts
    first_ts=$(head -1 "$transcript_path" | jq -r '.timestamp // empty' 2>/dev/null)
    last_ts=$(tail -1 "$transcript_path" | jq -r '.timestamp // empty' 2>/dev/null)

    local duration=""
    if [ -n "$first_ts" ] && [ -n "$last_ts" ]; then
        # Convert ISO timestamps to epoch seconds
        local first_epoch last_epoch
        first_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S" "${first_ts%%.*}" "+%s" 2>/dev/null)
        last_epoch=$(date -j -f "%Y-%m-%dT%H:%M:%S" "${last_ts%%.*}" "+%s" 2>/dev/null)

        if [ -n "$first_epoch" ] && [ -n "$last_epoch" ]; then
            local elapsed=$((last_epoch - first_epoch))
            if [ "$elapsed" -ge 60 ]; then
                local minutes=$((elapsed / 60))
                local seconds=$((elapsed % 60))
                duration="${minutes}m ${seconds}s"
            else
                duration="${elapsed}s"
            fi
        fi
    fi

    # Extract recent edits and commands
    local edits commands summary_parts
    edits=$(tac "$transcript_path" | jq -r '
        .message.content[]? |
        select(.type == "tool_use") |
        select(.name == "Edit" or .name == "Write") |
        .input.file_path // empty
    ' 2>/dev/null | xargs -I{} basename {} | sort -u | head -3)

    commands=$(tac "$transcript_path" | jq -r '
        .message.content[]? |
        select(.type == "tool_use") |
        select(.name == "Bash") |
        .input.command // empty
    ' 2>/dev/null | awk '{print $1}' | sort -u | head -2)

    summary_parts=()

    local edit_count
    edit_count=$(echo "$edits" | grep -c . 2>/dev/null || echo 0)
    if [ "$edit_count" -eq 1 ] && [ -n "$edits" ]; then
        summary_parts+=("Edited $edits")
    elif [ "$edit_count" -gt 1 ]; then
        summary_parts+=("Edited $edit_count files")
    fi

    if [ -n "$commands" ]; then
        local cmd_list
        cmd_list=$(echo "$commands" | tr '\n' ', ' | sed 's/,$//')
        summary_parts+=("Ran $cmd_list")
    fi

    local summary=""
    if [ ${#summary_parts[@]} -gt 0 ]; then
        summary=$(IFS=" | "; echo "${summary_parts[*]}")
    fi

    # Combine summary and duration
    local result=""
    if [ -n "$summary" ]; then
        result="$summary"
    fi
    if [ -n "$duration" ]; then
        if [ -n "$result" ]; then
            result="$result ($duration)"
        else
            result="$duration"
        fi
    fi

    echo "$result"
}

case "$EVENT" in
    Stop)
        transcript_path=$(echo "$HOOK_DATA" | jq -r '.transcript_path // empty')
        message=$(parse_transcript "$transcript_path")

        if [ -z "$message" ]; then
            message="Task completed"
        fi

        show_notification "Claude Code" "$message"
        ;;
    Notification)
        message=$(echo "$HOOK_DATA" | jq -r '.message // "Notification"')
        show_notification "Claude Code" "$message"
        ;;
esac
