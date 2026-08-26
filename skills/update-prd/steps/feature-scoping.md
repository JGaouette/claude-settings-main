# Feature scoping

Lock the detailed scope of each new feature, one at a time. For each feature, focus on **user-facing decisions only** — what the user sees, does, and experiences. Do NOT discuss technical implementation (libraries, methods, error handling, timeouts, parsing logic). Those are the agent's job to plan later.

For each feature:

1. Propose the specific user-facing sub-features and capabilities that ARE in scope: what does the user see on screen, what can they do, what UI elements exist, what happens after they take an action, what does the output look like.
2. Propose the specific user-facing sub-features and capabilities that are NOT in scope: things a more ambitious version of this feature would have but this round won't (e.g., editing after sending, history, analytics, advanced filters, preview images, attachments, multi-recipient, etc.).
3. Ask the user to confirm or adjust.

Example of the right level of specificity (for a "share by email" feature):
- In scope: a "Share" button on each item; a small form with recipient email, pre-filled subject, pre-filled body the user can edit; one-shot send action; recipient sees a readable email with the item's details.
- Out of scope: tracking opens or clicks, share history, sharing to multiple recipients at once, attaching files, scheduled sends.

What does NOT belong here: which mailer library to use, what queue backend, retry behavior, timeout values, how the email template is rendered. The agent decides all of that in plan mode.

Move through features one at a time. Don't batch.

## Checks unique to updating an existing PRD

Three things to check per feature that a from-scratch interview wouldn't have to:

### 1. Does this pull something back from out of scope?

Cross-reference the PRD's existing top-level out-of-scope list. If the addition brings back an item that was explicitly cut, say so directly:

> "Team sharing was listed as out of scope in the original PRD — this addition brings it back in. Confirming that's intentional."

Get an explicit yes. When confirmed, note that the item must be **removed** from the out-of-scope list during the write phase — leaving a feature in both lists makes the PRD contradict itself.

### 2. Does it change how an existing feature behaves?

The addition may alter something already built. If so, describe the change in user-facing terms and confirm it:

> "Right now any signed-in user sees every project. With team scoping they'd only see projects in their team — that's a visible change to existing behavior."

This matters because the milestone that delivers the addition will also have to modify shipped code. Capture the changed behavior as part of the feature's in-scope list so it lands in the PRD and the milestone prompt.

### 3. Does it overlap something already shipped?

Check the `milestone-log.md` files you read in the load-state phase. If part of the addition already exists, say so and narrow the scope to the genuinely new part rather than re-specifying work that's done.

## Also update the headline lists

While scoping, note in passing:

- The one-line headline for each new feature, for the PRD's "What the app does" list
- Any new use cases the addition serves, for the "What use cases the app helps users with" list
- Any new top-level out-of-scope items the addition introduces

You don't need a separate phase or question for these — derive them from the scoping conversation and include them when you write the files. Only ask if genuinely ambiguous.
