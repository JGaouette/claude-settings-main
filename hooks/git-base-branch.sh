#!/bin/bash
# Returns base branch for current git branch

# Try PR base first (most accurate)
if command -v gh &>/dev/null; then
    PR_BASE=$(gh pr view --json baseRefName -q '.baseRefName' 2>/dev/null)
    if [ -n "$PR_BASE" ]; then
        echo "$PR_BASE"
        exit 0
    fi
fi

# Try git tracking config
TRACKING=$(git rev-parse --abbrev-ref @{upstream} 2>/dev/null)
if [ -n "$TRACKING" ]; then
    echo "${TRACKING#origin/}"
    exit 0
fi

# Fallback: heuristic detection
for base in master main develop; do
    if git show-ref --verify --quiet "refs/remotes/origin/$base" 2>/dev/null; then
        echo "$base"
        exit 0
    fi
done

echo "unknown"
