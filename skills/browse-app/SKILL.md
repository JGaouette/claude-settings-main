---
name: browse-app
description: Use when you need to drive the app in a real browser - verifying a front-end change works, reproducing a UI bug, checking a form submission or page navigation end to end, reading browser console errors, or taking a screenshot. Activate when Jeremy asks you to "test it in the browser", "check the UI", "click through", "see if it works", or reports a visual or interactive problem you cannot confirm from code alone.
user_invocable: true
---

# Browse the app

Browser control comes from the `playwright` MCP server, installed at **user scope**, so it is available
in every project with no per-project `.mcp.json`. It drives real Chrome with a shared persistent profile
at `%LOCALAPPDATA%\claude-playwright\profile`. Cookies are domain-scoped, so a login to one `.test` site
persists across sessions and does not leak into another site.

If the `playwright` tools are missing, the server was never installed on this machine. Reinstall with:

```
claude mcp add --scope user playwright -- npx -y @playwright/mcp@latest \
  --browser chrome \
  --user-data-dir "%LOCALAPPDATA%/claude-playwright/profile" \
  --output-dir "%LOCALAPPDATA%/claude-playwright/output" \
  --viewport-size 1440x900 --test-id-attribute data-testid --idle-timeout 900000
```

Then restart Claude Code — MCP servers load at startup.

## Step 1 — Find the real base URL. Do not guess.

Jeremy's projects are served by **Laravel Herd**, not `artisan serve`. Resolve the URL before navigating:

```
~/.config/herd/bin/herd.bat parked
```

Match the current project directory to a row and use that row's URL (typically `http://<dir-name>.test`).

- **`APP_URL` in `.env` is not authoritative.** It is frequently a stale `http://localhost:8000` left over
  from the starter kit. Trust the Herd table over `.env`.
- Confirm the site answers before doing anything else. A failed navigation from a wrong URL wastes a
  whole exchange.
- If the project is not in the parked list, it is not Herd-served. Ask Jeremy for the URL rather than
  assuming a port.

## Step 2 — Check the asset pipeline, not the PHP server

Herd already serves PHP. The only process Jeremy starts by hand is Vite:

```
npm run dev
```

- **Never suggest `composer run dev` or `php artisan serve`.** Both are redundant under Herd, and
  `composer run dev` fatals on his machine anyway (see the PHP version trap below).
- If assets 404 or the Vite manifest is missing, that is `npm run dev` / `npm run build` — not a code bug.
  Ask him to start it rather than debugging the application.

## The PHP version trap

The `php` on the PATH is **8.2.27** (`C:\php\php-8.2.27\php.exe`), while most of his projects require
PHP 8.4+. Anything that boots `vendor/autoload.php` under that binary dies immediately in
`vendor/composer/platform_check.php` with a `RuntimeException`, which reads like a broken project but
is not. `composer` itself runs on 8.2, so every composer script using `@php` inherits the failure.

Run artisan and vendor binaries through Herd's matching PHP instead:

```
C:/Users/jeremy.gaouette_apex/.config/herd/bin/php84/php.exe artisan ...
```

The `herd parked` table lists each site's PHP version — use the `php8X` directory that matches. This
same trap is what silently breaks `php artisan`-based MCP servers such as Laravel Boost; if one reports
only "Connection closed", check its configured `command` before anything else.

## Step 3 — Log in

Most routes sit behind `auth`. Check `database/seeders/` for the seeded accounts; Laravel's default
`UserFactory` hashes the password to `password` unless the project overrides it.

**Pick the account whose permissions match what you are testing.** Permission bugs are invisible if you
always drive as an admin — if the project seeds read-only or inactive users, use them to verify that
controls are correctly hidden, disabled, or refused.

If the seeded users do not exist, the database has not been seeded. `migrate:fresh --seed` destroys
local data, so ask Jeremy before running it.

## How to drive

- **Snapshot before you act.** Take an accessibility snapshot and click the element refs it returns.
  Never guess at coordinates, and never assume the page looks the way it reads in the component file.
- **Assert on what the page shows**, not on the absence of an error. After a form submit, confirm the
  redirect landed, the flash message rendered, and the new row is visible.
- **Read the console after every meaningful action.** SPA frameworks swallow a lot — a silent component
  error or a 422 on an XHR only surfaces there. Report console errors even when the visible behaviour
  looked correct.
- **Screenshots** land in `%LOCALAPPDATA%\claude-playwright\output`. Take one when reporting a visual
  problem or when Jeremy asks to see something.
- Test IDs resolve from `data-testid`.

## Data safety

The browser points at the real local development database, not the test database. Creating and editing
records while exploring is fine. **Deleting records or triggering any other destructive action gets
confirmed with Jeremy first** — there is no transaction rollback here the way there is in tests.

## This does not replace tests

Browser verification is a supplement, not a substitute. When you confirm a fix in the browser, still
write or update the automated test and run it. A change verified only by clicking is not covered.
