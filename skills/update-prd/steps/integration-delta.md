# Integration delta

Only consider external services the addition needs that the PRD **doesn't already cover**.

First, check the addition against the integrations already in the PRD. If the new feature can run on a service that's already set up — the app already talks to OpenAI and the new feature needs an LLM call, the app already sends via Resend and the new feature sends an email — then there is no new integration. Say so in one line and move to the data model delta:

> "No new integrations — the digest emails go through Resend, which is already set up."

## For each genuinely new integration

1. Explain what the integration does in plain language.
2. Propose a default provider with a one-line reason (cheapest / simplest / most common). Prefer a provider already in the stack's orbit over introducing a new vendor for its own sake.
3. Use AskUserQuestion to confirm the provider or switch.
4. List the credentials the user will need to obtain (API keys, account signups) so they know what to sign up for **before** the agent reaches the milestone that uses the integration. Don't prescribe how the credentials are stored in the codebase — the agent decides that during implementation.

Common cases:

- AI summarization → OpenAI or Anthropic API
- Email sending → Resend, Postmark, SendGrid
- Payments → Stripe
- File uploads → S3 or similar
- SMS → Twilio
- Maps → Google Maps or Mapbox

Lock the integration list before moving on. If a feature requires an integration the user doesn't want to set up, flag it now — that feature may need to drop out of this round's scope.

## Say when setup is needed

Unlike a fresh PRD, the user here has a running app and may start the next milestone the same day. If the addition needs a new account or API key, tell them plainly that this is a prerequisite they have to handle before the milestone can be built, and which milestone it blocks. Keep it to one sentence.
