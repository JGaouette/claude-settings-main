# Addition brain dump

Capture what the user wants to add, in their own words. Free-form text response — no AskUserQuestion here.

If the user already described the addition when they invoked the skill (e.g. "add team sharing to this app"), you have your brain dump. Don't make them repeat it.

If they didn't, ask: what do you want to add, and what problem does it solve for your users? One short question, no preamble.

## What to listen for

As you read the brain dump, note which of these the addition touches — it tells you how long the rest of the interview needs to be:

- **New user-facing capability** → feature scoping phase has real work to do
- **A new external service** (AI, email, payments, storage, SMS) → integration delta phase matters
- **New things the app must remember**, or new attributes on things it already remembers → data model delta phase matters
- **Something the PRD explicitly listed as out of scope** → flag it in the feature scoping phase

An addition that touches only one of these is a short interview. Say so implicitly by moving fast, not by announcing it.

## Restate before moving on

Play the addition back in one or two sentences, framed as a capability the user will have. Confirm it's right, then move to feature scoping.

If the brain dump is actually several unrelated additions, split them into a numbered list and confirm the list. Each one gets its own pass in the feature scoping phase.

## When the addition doesn't fit the plan

Two cases to raise now rather than later:

- **It contradicts the locked core purpose.** If the addition would make the app a fundamentally different product, say so plainly and ask whether they want to extend this PRD or start a new one. Don't refuse — just make sure it's a deliberate choice.
- **It requires a stack change.** If the addition can't be built on the current stack (e.g. it needs a mobile app and the PRD is a web app), flag it as a real decision and get an explicit answer before continuing.
