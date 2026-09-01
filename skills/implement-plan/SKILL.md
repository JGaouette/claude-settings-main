---
name: implement-plan
description: Use when implementing an approved plan, from Plannotator, plan mode, or a plan file. Splits the plan into purpose-scoped commits, then implements them one at a time, stopping after each for review and an explicit go.
user_invocable: true
---

# Implement Plan

Implement an approved plan as a sequence of small, self-contained commits, stopping after every one. The point of the workflow is that Jeremy reviews each change while it is still small enough to reason about. Delivering the whole plan in one pass defeats it.

## Phase 1 — Slice the plan

Before writing any code, split the plan into commits and present the breakdown for approval.

Each slice must:

- Have one purpose, stated in a single line.
- Leave the repository working. Tests and build pass at every slice boundary.
- Be ordered so nothing depends on a later slice.
- Separate pure refactors from behaviour changes. Never mix them.

Three to seven slices is normal. More than eight means the plan is too big for one pass — say so and propose splitting the work rather than producing a long queue.

Present it exactly like this, then stop:

```
Plan: <plan name>

1. <purpose>          <files touched>
2. <purpose>          <files touched>
3. <purpose>          <files touched>

Waiting for your go on this breakdown.
```

Do not start slice 1 until the breakdown is approved. If the approval comes with changes, re-present the revised breakdown and wait again.

## Phase 2 — Implement one slice

Implement only the current slice. Write the code, run the tests, leave the changes in the working tree.

Do not commit. Do not stage. Do not touch anything belonging to a later slice, even a one-line change that would be convenient to make now — note it and let it land in its own commit.

If something in the plan turns out to be wrong or underspecified, stop and raise it rather than guessing.

## Phase 3 — Stop and report

Report in this format and then stop. Do not launch a review tool; Jeremy reviews with whatever he prefers.

```
Commit <n>/<total>: <purpose>
Files: <path> (new, <n> lines)
       <path> (+<added>, -<removed>)
Tests: <result, or "not run" with the reason>
Open question: <question, or "none">

Waiting for your review.
```

Keep the file list factual. Do not summarise the diff line by line, and do not editorialise about quality.

## Phase 4 — Modifications

Apply what the review asks for, then stop again with the same report format. Repeat for as many rounds as the review takes.

Answering a question at a stop is not a reason to resume. Answer it and keep waiting.

## Phase 5 — Commit and advance

On an explicit go, and only then:

1. Commit the slice. Write the message per `skills/commit-message/SKILL.md`.
2. Move to the next slice and return to phase 2.

Do not push. Jeremy asks for a push when he wants one.

After the last slice, report that the series is complete and stop.

## The stop rule

The stop between slices is the whole workflow. It holds even when continuing seems obviously right.

- Finishing a slice is not permission to start the next one.
- Having no open questions is not permission either.
- Never implement two slices in one turn.
- Never commit before the go.
- `looks good`, `nice`, or silence on a question is not a go. Only an instruction to continue is. When it is ambiguous, ask.

If the review shows the remaining slices are wrong, return to phase 1 and re-present the breakdown rather than improvising a new order.
