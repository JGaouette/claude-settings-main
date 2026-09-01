---
name: commit-message
description: Use when writing a git commit message. Produces a short, specific subject line and a bullet-point body.
user_invocable: true
---

# Commit Message

## Subject

- One line, imperative mood, sentence case, no trailing period. Target 50 chars, hard cap 72.
- Name the change, not the area touched: `Show plan usage in status line`, not `Update statusline`.
- No Conventional Commits prefixes (`feat:`, `fix:`, `chore:`). This codebase does not use them.
- Optional `Scope: ` prefix when it disambiguates: `ProductModal: Fix property loading`.
- Never vague: `Minor changes`, `A lot of minor fixes`, `More fixes`, `WIP`, or a bare tool name.
- One subject, one idea. Needing "and" twice means the commit should be split.

## Body

Omit it when the subject says everything. Include it when the commit does more than one thing, or when the reason is not visible in the diff.

- One bullet per change, starting with a verb.
- State what changed and why. Never how — the diff already shows how.
- Sacrifice grammar for concision. Drop articles and filler.
- Five bullets maximum. More than five means the commit is too big.
- Wrap at 72 chars.

## Never

- Attribution trailers (`Co-Authored-By`, `Generated with`). `settings.json` sets `attribution.commit` to an empty string to suppress them; do not reintroduce them by hand.
- Temporal or historical framing: `new`, `old`, `legacy`, `improved`, `enhanced`, `refactored`, `moved`. Describe the end state.
- A file-by-file restatement of the diff.

## Squash merges of a feature branch

Feature-branch squashes keep the tracking block instead of bullets:

```
[feature/branch-name] Commits 1-9

Project description: <Linear issue URL>
Developer: <name>
QA: -
```

## Example

```
Show plan usage in status line

- Add hooks/plan-usage.sh, prints "5h 24% 7d 41%" from rate_limits
- Append it to statusline-with-base.sh
- Silent when rate_limits absent
```
