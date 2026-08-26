#!/bin/bash
# Injects base branch info into Claude's context

if ! git rev-parse --is-inside-work-tree &>/dev/null 2>&1; then
    exit 0
fi

HOOK_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

CURRENT=$(git branch --show-current 2>/dev/null)
BASE=$("$HOOK_DIR/git-base-branch.sh")

if [ -n "$CURRENT" ] && [ "$BASE" != "unknown" ]; then
    echo "[Git] Branch: $CURRENT | Base: $BASE"
fi

exit 0
