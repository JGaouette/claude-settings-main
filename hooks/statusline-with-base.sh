#!/bin/bash
# Custom status line that shows base branch

HOOK_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

input=$(cat)

# Get ccstatusline output first
CCSTATUS=$(echo "$input" | npx -y ccstatusline@latest 2>/dev/null)

# Add base branch if in git repo
if git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
    BASE=$("$HOOK_DIR/git-base-branch.sh")
    if [ "$BASE" != "unknown" ]; then
        echo "$CCSTATUS | base: $BASE"
        exit 0
    fi
fi

echo "$CCSTATUS"
