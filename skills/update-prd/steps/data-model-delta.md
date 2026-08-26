# Data model delta

Propose what the app needs to remember that it doesn't already. Work from the entities you read out of the existing PRD — this is a delta, not a redesign.

Entity and field names are in English, even when the user's input is in French.

Present all three buckets at once, then confirm:

## 1. New entities

Name each one (e.g., Team, Invitation, Digest) and list its fields in plain language — what the app needs to remember about this thing, not database column types. Note its relationships to existing entities.

## 2. New fields on existing entities

For each existing entity that gains fields, name the entity and list only the additions:

> **Project** gains `team_id` — which team the project belongs to.

**Flag these explicitly.** New fields on existing entities mean a change to data that already exists in the running app — the agent will have to decide what the value is for every row already there. Say so in one sentence and, where it isn't obvious, confirm what the existing rows should get:

> "Every project already in the database needs a team. Should existing projects go to their owner's personal team?"

That's a product decision, so it belongs in the PRD. **How** the change is applied — migration mechanics, backfill strategy, downtime — is implementation and belongs to the agent in plan mode. Don't specify it.

## 3. New or changed relationships

Describe them in prose: "each Project belongs to one Team; each Team has many Users."

Call out relationships that **change** an existing one, not just new ones. Going from "each Project belongs to a User" to "each Project belongs to a Team" is a rewrite of an existing relationship and needs to be stated as such.

## Confirm

Use AskUserQuestion:
- Looks right, lock it in
- Mostly right, I'll edit in chat
- Missing something — let me describe

After receiving user input, verify whether the user wants more adjustments before moving on.

## If nothing changes

Some additions need no new data at all. If that's the case, say so in one line and move on to the milestone breakout — don't invent entities to make the phase feel substantial.
