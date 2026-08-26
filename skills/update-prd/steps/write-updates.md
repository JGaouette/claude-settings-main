# Write updates

Once everything is locked, write the changes. **Just write them.** Don't show a draft for approval first — the user already approved each piece during the interview.

Write only the format(s) that already exist (recorded in the load-state phase). If both `prd.md` and `prd.html` exist, update both — they must describe the same scope. Milestone `prompt.md` files are always markdown regardless of format.

## The one rule that matters

**Edit the PRD surgically. Never regenerate it.**

Use targeted edits to insert and append. Do not rewrite the file from scratch, do not "clean up" prose you didn't touch, do not reword existing sections. The existing milestone sections in particular describe work that may already be built — rewriting them makes the PRD contradict the codebase.

Sections you may modify: revision history, what the app does, use cases, out of scope, integrations, data model, and everything after the last existing milestone. Everything else stays byte-identical.

## `prd.md`

### Revision history

Insert a `## Revision history` section immediately after the disclaimer blockquote and before `## What we're building`. If the section already exists, prepend the new entry inside it — newest first.

```markdown
## Revision history

### {YYYY-MM-DD} — {short title}

- **Added:** {new features, one clause each}
- **Data model:** {new entities, new fields on existing entities — omit the line if nothing changed}
- **Integrations:** {new providers — omit the line if none}
- **Milestones:** {N+1}–{M}
```

Use today's date. Keep the title to a few words ("Team sharing", "Weekly digest emails").

### Body sections

- `### What the app does` — append one bullet per new feature.
- `### What use cases the app helps users with` — append any new use cases.
- `### Out of scope` — add new cuts. **Remove** any item the addition pulled back into scope; a feature listed as both in and out of scope makes the PRD self-contradictory.
- `### Data model` — add headings for new entities; add field bullets to existing entity sections; update the relationship prose where a relationship changed.
- External integrations — add the new provider and its credentials. If the PRD has no integrations section and this addition introduces the first one, add the section after `### Out of scope`.

### Milestones

Append new `## Milestone {N+1} — {Name}` sections at the end of the file, following the existing structure:

```markdown
## Milestone {N} — {Name}

{1–2 sentence framing of what this milestone delivers.}

### What gets built

{Bulleted list of user-facing capabilities and screens delivered in this milestone. Describe what the user can do, see, or experience when this milestone is done — not the technical pieces needed to deliver it. Include any changes to existing behavior, phrased from the user's side.}

### What milestone {N} explicitly does NOT include

{Bulleted list of things a coder might assume should be in this milestone but aren't.}

### Done when

{1–2 sentences describing the verification criteria — what the user should be able to do in the browser when this milestone is complete.}
```

**Milestones 1 through N are not touched.**

## `prd.html`

Same content changes, same surgical rule.

The card and section snippets live in the sibling `create-prd` skill, at `steps/prd-html-template.md` inside it — from this skill's root that's `../create-prd/steps/prd-html-template.md`. Read it for feature cards, use-case blocks, out-of-scope items, integration cards, entity cards, and milestone cards. If that file isn't there, fall back to copying the markup patterns out of the user's existing `prd.html`.

Match the existing markup in the user's file exactly; reuse its Tailwind classes rather than inventing new ones.

Never touch: the `<head>`, the theme-toggle script, the disclaimer block, the header, the footer, or any existing milestone `<article>`.

### Revision history section

Insert immediately after the disclaimer `<div>`, before the hero `<section>`. If it already exists, prepend the new entry inside its `space-y-3` container.

```html
<section>
  <h2 class="text-xs font-semibold uppercase tracking-[0.18em] text-zinc-500 dark:text-zinc-400 flex items-center gap-2">
    <i data-lucide="history" class="w-3.5 h-3.5"></i>Revision history
  </h2>
  <div class="mt-5 space-y-3">
    <!-- repeat per revision, newest first -->
    <div class="print-card rounded-lg border border-zinc-200 dark:border-zinc-800 bg-white dark:bg-zinc-900 p-4">
      <p class="text-sm font-medium text-zinc-900 dark:text-zinc-100">{{DATE}} — {{TITLE}}</p>
      <ul class="mt-2 space-y-1 text-sm text-zinc-600 dark:text-zinc-400 list-none p-0">
        <!-- repeat per change -->
        <li class="flex items-start gap-2"><i data-lucide="plus" class="w-3.5 h-3.5 mt-0.5 shrink-0"></i><span>{{CHANGE}}</span></li>
      </ul>
    </div>
  </div>
</section>
```

### Other sections

- Append `<li>` feature cards, use-case blocks, out-of-scope items, entity cards, and integration cards into their existing containers.
- Delete the `<li>` for any out-of-scope item pulled back into scope.
- Append new milestone `<article>` blocks after the last existing one, inside the milestones container.
- If a section doesn't exist yet (e.g. the addition introduces the first integration), build it from the template scaffold and place it where the template's section order puts it — integrations sit between out-of-scope and data model.

Use only Lucide icon names from the template's icon hints. Never invent icon names; use `circle-dot` if unsure.

## New milestone folders

For each new milestone, create `_build_plan/milestones/{N}-{slug}/prompt.md`. `{slug}` is a short kebab-case name derived from the milestone (e.g. `team-sharing`, `digest-emails`).

Substitute `{PRD_PATH}`: `_build_plan/prd.md` if it exists, otherwise `_build_plan/prd.html`.

```markdown
# Milestone {N} — {Name}

You are entering plan mode to plan and then build milestone {N} of this project.

This milestone extends an app that is already built and running. Understand what exists before you plan.

## Context

- Read `@{PRD_PATH}` for the full project context, scope, data model, and tech stack. The Revision history section at the top tells you which parts of the PRD are recent additions.
- Read every previous milestone log (`@_build_plan/milestones/*/milestone-log.md`) to understand what has already been built, what decisions were made along the way, and what deviated from the PRD.

## Your task

1. Plan the implementation for **only** milestone {N} as defined in the PRD. Do not plan or build anything from other milestones.
2. After the user confirms the plan, build only what is in milestone {N}'s scope.
3. Do not regress existing functionality. Where this milestone changes behavior that already ships, the PRD says so explicitly — change only what it names and leave everything else working as it does today.
4. Verify your work against the "Done when" criteria for milestone {N} in the PRD, and confirm previously shipped features still work.
5. When complete, write a `milestone-log.md` in this folder (`_build_plan/milestones/{N}-{slug}/milestone-log.md`). Structure it as follows:
   - **Start with a `## What's new in the app` section at the very top.** This is a concise, human-readable, bulleted list of the main user-facing features or functionality that were added in this milestone — written so a non-technical reviewer can see at a glance what new things to expect in the app now that this milestone is done. Frame each bullet as a capability the user will now see or be able to do, not as a technical artifact. Keep it short and scannable.
   - Then include the implementation detail sections below for the next milestone's agent to reference:
     - What was built (files created, models added, routes added, etc.)
     - What existing code was modified, and why
     - Any decisions made during implementation that weren't pre-specified in the PRD
     - Anything the next milestone will need to know
     - Any deviations from the PRD and why

Ask me any clarifying questions using AskUserQuestion tool to lock in the implementation plan for this milestone.
```

Existing milestone folders are not modified — not their `prompt.md`, not their `milestone-log.md`.

## Agent instructions note

No change needed. `create-prd` already added the `_build_plan/` section to the project's `CLAUDE.md` or `AGENTS.md`. Only add it if it's genuinely missing, using the wording from the sibling `create-prd` skill's `steps/write-files.md`.

## Closing message

Tell the user, briefly:

- What changed in the PRD (features added, data model changes, out-of-scope items pulled in)
- Which new milestone folders exist
- If `prd.html` was written: `open _build_plan/prd.html` to review — the revision history at the top shows what's new
- Any credentials they need to obtain before the milestone that uses them
- Which `prompt.md` to open to start building

## Style notes

- Match the voice of the existing PRD. Concrete, specific, opinionated: not "the app should probably support X" but "the app supports X."
- New content is specific about user-facing behavior and silent about technical implementation — that's the agent's job in plan mode.
- Out-of-scope lists are valuable — never skip them, never make them generic.
- Data model fields are described in plain language, not as database column definitions.
- Don't add scope to fill out a card grid. If a section gains one bullet, it gains one bullet.
