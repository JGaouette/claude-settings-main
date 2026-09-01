#!/bin/bash
# Prints plan usage for each rolling limit window, e.g. "5h 24% 7d 41%".
# Reads the status line JSON on stdin. Prints nothing when the payload carries
# no rate limit data, which is the case before the session's first API response
# and for accounts that report no plan windows.

node -e '
let raw = "";
process.stdin.on("data", (c) => (raw += c));
process.stdin.on("end", () => {
    let limits;
    try {
        limits = JSON.parse(raw).rate_limits;
    } catch {
        return;
    }
    if (!limits) return;

    const window = (data, label) => {
        if (typeof data?.used_percentage !== "number") return null;
        return `${label} ${Math.round(data.used_percentage)}%`;
    };

    const parts = [
        window(limits.five_hour, "5h"),
        window(limits.seven_day, "7d"),
        window(limits.spend_limit, "spend"),
    ].filter(Boolean);

    if (parts.length) process.stdout.write(parts.join(" "));
});
' 2>/dev/null
