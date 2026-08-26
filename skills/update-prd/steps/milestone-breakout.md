# Milestone breakout

Break the addition into milestones that continue the existing sequence.

**Numbering continues from the existing folders.** If the highest existing milestone is `N`, the first new one is `N+1`. Never reuse a number, never renumber an existing milestone, never insert between existing ones.

## Propose

Most additions are 1–2 milestones. Propose a default based on a reasonable dependency sequence, plus alternatives at different granularities. For a two-milestone default:

- **Default (recommended):** 2 milestones — Team model & membership → Sharing UI & permissions
- **Alternative A — fewer/bigger:** 1 milestone — everything in one session
- **Alternative B — more/smaller:** 3 milestones — one per screen

If the addition is genuinely one coherent piece of work, propose a single milestone and offer only a split as the alternative. Don't manufacture a three-way choice.

Each milestone must:

- Deliver visible, usable functionality the user can see and test in the browser
- Be a self-contained working session for a coding agent
- Have clear dependencies (later milestones build on earlier ones)
- **Leave the app working.** Every shipped feature still works when the milestone is done. This is stricter than a from-scratch milestone — there's a live app to avoid breaking.

Explain the tradeoff in plain language: fewer milestones = larger one-shot sessions, more risk per session, less control; more milestones = more checkpoints, slower overall, more context-switching.

Use AskUserQuestion to let the user pick. After they pick, propose the actual milestone names and one-line scopes, and confirm.

## Sequencing against unbuilt milestones

If milestone `N` was never built, the new milestones land after it. Point this out once when proposing:

> "Milestone 4 (public pages) is still unbuilt, so these land as 5 and 6 — they'll be built after it."

If the user wants the new work first, the honest answer is that this skill appends only. They can build the new milestones before the older unbuilt one — nothing forces execution in numeric order — as long as the new work doesn't depend on it. Say which it is: if milestone `N+1` depends on unbuilt milestone `N`, they have to do `N` first.

## Changes to shipped behavior

If the feature scoping phase turned up changes to existing behavior, assign each one to a specific milestone and name it in that milestone's "What gets built" list, phrased from the user's side:

> "Projects list now shows only projects in the user's current team."

Otherwise the agent reads the milestone as purely additive and leaves the old behavior in place.
