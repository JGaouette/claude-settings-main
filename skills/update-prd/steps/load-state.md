# Load current state

Before asking the user anything, read the existing plan. Everything the original PRD interview locked is on disk — your job here is to recover it, not to re-ask it.

## 1. Find `_build_plan/`

Look for a `_build_plan/` folder at the codebase root.

**If it doesn't exist**, stop immediately. Tell the user this project has no PRD yet and they should run `create-prd` to create one. Do not start an interview, do not offer to write a PRD from scratch here.

**If it exists but has no `prd.md` or `prd.html`**, stop and tell the user the `_build_plan/` folder is missing its PRD — ask whether they moved or renamed it before you continue.

## 2. Record the output format

Note which PRD files exist:

- `prd.md` only → all output is markdown
- `prd.html` only → all output is HTML
- both → update both, keeping them in sync

**This is the inherited format choice. Never ask the user to pick a format.** They chose it when the PRD was created and the answer is on disk.

## 3. Read the PRD

Read `prd.md` if it exists — it's easier to parse. Read `prd.html` only if it's the only format present.

Extract and hold in mind:

- App name and core purpose
- Tech stack and starter template
- What the starter/existing codebase already provides
- The current "What the app does" feature list
- The current use case list
- The current top-level **out-of-scope** list (you will cross-reference this later)
- External integrations already in the plan, and the credentials they need
- The data model: every entity and its fields
- Every existing milestone: number, name, scope

## 4. Read the milestone folders

List `_build_plan/milestones/*/`. For each folder:

- Parse the leading number from the folder name. The **highest number is `N`** — new milestones start at `N+1`.
- A folder containing `milestone-log.md` is **shipped**. A folder with only `prompt.md` is **planned but not built**.

Read the `## What's new in the app` section of each `milestone-log.md`. This is ground truth for what the running app actually does today, which can differ from what the PRD said would be built. When the log and the PRD disagree, the log wins — it describes reality.

Also skim the rest of each log for decisions made during implementation and anything flagged as relevant to future milestones. If a log recorded a deviation from the PRD, remember it — the addition may be affected.

## 5. Confirm the project

Summarize back to the user in **six lines or fewer**. Something like:

```
{App name} — {one-line purpose}
Stack: {stack}
Shipped: milestones 1–{x} ({names})
Planned, not built: milestone {y} ({name})
PRD format: {markdown / HTML / both}
```

Then ask, in one short sentence, what they want to add. Do not use AskUserQuestion for this — it's a confirmation plus an open question, and the answer is free-form.

If the user says the summary is wrong or that this is the wrong project, stop and sort that out before continuing.

## Sanity checks

Two situations are worth flagging out loud before moving on, because they change what the user should do next:

- **Unbuilt milestones exist.** Mention that milestone `{y}` is still unbuilt, and that the new work will be appended after it — so it'll be built after milestone `{y}`, not instead of it. If the user actually wants to replace or rescope the unbuilt milestone, that's a hand edit to the PRD, not this skill.
- **The last few milestones have no logs but the code looks built.** Say so once. It usually means the logs were skipped, and your picture of what already exists may be incomplete.
