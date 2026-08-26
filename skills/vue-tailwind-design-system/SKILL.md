---
name: vue-tailwind-design-system
description: Guides you through creating and implementing a design system for your application.
user_invocable: true
---

# Design System Builder

You are guiding a builder through scaffolding a complete design system into a Vue + Tailwind v4 codebase. The output is a single-page reference at `/admin/design-system` that previews and documents every primitive, plus a small set of reusable Reka UI–based components, plus instructions appended to `AGENTS.md` (or `CLAUDE.md`) so future agents always defer to the design system instead of drifting.

## Audience assumption

The user wants a complete, opinionated design system scaffolded into their app with as few decisions as possible. Colors and fonts ship with locked defaults — don't ask the user to pick them. Whenever a technical concept appears in a phase that *does* take input (route, scope, migration), briefly explain it in plain language before asking.

## Core interaction principles

1. **Use the AskUserQuestion tool for decisions with discrete options.** The user is likely on mobile — tappable options beat typing. For free-form input (custom hex codes, custom font names) use a normal chat message.

2. **One decision at a time, in sequence.** Walk through phases in order. Lock each phase before moving to the next.

3. **Keep your prose tight.** Short framings, no preamble. The user is making decisions, not reading essays.

4. **The design system is opinionated, not exhaustive.** Ship a small, useful, beautiful set of primitives with locked defaults. The user can extend by editing the scaffolded files or re-running the skill later.

## Hard assumptions

- The target codebase uses **Vue 3** (Composition API, `<script setup>` single-file components).
- The target codebase uses **Tailwind CSS v4 or later**. (v4 uses `@theme` directive in CSS instead of `tailwind.config.js`.)
- If either assumption is violated, stop and tell the user what's missing.

## Phase 0 — Detect target codebase state

Before talking to the user, inspect the codebase silently and form a picture.

**Framework detection** (in order — first match wins):

1. **Vite + Vue** — `vite.config.ts` / `vite.config.js` / `vite.config.mts` exists at repo root AND the project uses Vue (`@vitejs/plugin-vue` in `package.json`, or `.vue` files present).
2. **Laravel + Inertia (Vue)** — `composer.json` contains `inertiajs/inertia-laravel` AND `resources/js/Pages/` exists AND `@inertiajs/vue3` is in `package.json`.
3. **Unknown** — none of the above. Continue but tell the user the route registration step will be a manual snippet they paste.

**Tailwind v4 check:**

- Look for `@import "tailwindcss"` in any CSS file under common entry paths (`src/`, `resources/css/`).
- Or `@tailwindcss/vite`, `@tailwindcss/postcss`, or `tailwindcss@^4` in `package.json`.
- If none found, or if you find Tailwind v3 markers (`tailwind.config.js`, `@tailwind base;`), **stop**: print "This skill requires Tailwind CSS v4 or later. Please upgrade first — see https://tailwindcss.com/docs/upgrade-guide — and re-run." and exit.

**Existing-system detection (sets first-run vs re-run mode):**

- Does the route already exist? Look for files matching the framework's convention for `/admin/design-system`.
- Does `src/components/ui/` (or framework-equivalent) already exist?
- Does the project's main CSS file already have a `@theme` block?
- Does the project have a `vue-design-system:start` marker in `AGENTS.md` or `CLAUDE.md`?

If any of those are true → **re-run mode**. Otherwise → **first-run mode**.

**Agent instruction file:**

- Check for `AGENTS.md` at repo root.
- Check for `CLAUDE.md` at repo root.
- Note which exists (or neither).

State a brief summary of what you found before moving on. Example:
> Detected: Vite + Vue + Tailwind v4. No existing design system. `CLAUDE.md` present, `AGENTS.md` absent. I'll scaffold from scratch.

## Phase 1 — Confirm route

Default route: **`/admin/design-system`**.

Use AskUserQuestion:

- Question: "Where should the design system reference page live?"
- Options: `Use /admin/design-system (recommended)`, `Use /design-system (no admin prefix)`, `Use /styleguide`

If the user picks Other and provides a custom path, accept it (must start with `/`).

Save the chosen route as `routePath` for downstream phases.

## Phase 2 — Branding defaults

Colors and fonts ship locked. Do **not** ask the user to pick them. Announce what's coming in one short summary, then move on:

> Going with these defaults — the design system page will preview them all and you can edit the scaffolded CSS later if you want to tweak:
>
> - **Display font:** Inter
> - **Body font:** DM Sans
> - **Accent:** ApexO blue (`#003967`)
> - **Signal:** Amber light (`#fcd34d`) — same shade in light and dark
> - **Neutral:** Slate

Use the values below for substitution in Phase 4. Don't ask the user to confirm — just proceed.

### Fonts

| Role     | Family    | Google Fonts import URL                                                                | CSS stack                                            |
|----------|-----------|----------------------------------------------------------------------------------------|------------------------------------------------------|
| display  | Inter     | `https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap`     | `'Inter', ui-sans-serif, system-ui, sans-serif`      |
| body     | DM Sans   | `https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600&display=swap`       | `'DM Sans', ui-sans-serif, system-ui, sans-serif`    |

### Resolved palette

Derived from accent `#003967`, signal `#fcd34d` (light shade pinned in both modes), and the Slate neutral scale, per the rules in `references/derive-palette.md`:

Unlike `signal`, the accent is **not** pinned across modes. `#003967` is dark enough (oklch L=34%) that it reaches only 1.71:1 against the dark page, so dark mode uses a lighter tint of the same hue.

| Token          | Light     | Dark      |
|----------------|-----------|-----------|
| page           | `#ffffff` | `#020617` |
| surface        | `#f8fafc` | `#0f172a` |
| hairline       | `#e2e8f0` | `#1e293b` |
| ink-body       | `#334155` | `#e2e8f0` |
| ink-display    | `#0f172a` | `#f8fafc` |
| ink-muted      | `#64748b` | `#94a3b8` |
| accent         | `#003967` | `#67a3e0` |
| accent-faded   | `#e0e7ed` | `#081c2f` |
| accent-darker  | `#002956` | `#a4d6ff` |
| signal         | `#fcd34d` | `#fcd34d` |
| signal-faded   | `#fffaea` | `#2f2b21` |
| signal-darker  | `#b45309` | `#b45309` |

Save these as `palette` and `fonts` for Phase 4.

## Phase 3 — (re-run only) Scope

Skip this phase on first run.

If re-run mode, after Phase 2 ask:

- Question: "What do you want to update?"
- Options: `Refresh tokens to current defaults`, `Add new sections to the page`, `Full re-scaffold (overwrites everything inside the vue-design-system markers)`

If "Add new sections", ask which section IDs to add (free-form, comma-separated against the canonical section list below).

If "Full re-scaffold", confirm with a second AskUserQuestion: `Yes, overwrite`, `Cancel`.

## Phase 4 — Write files

This is the "do the work" phase. Don't show drafts; just write the files. The defaults are locked and the user already confirmed the route.

### 4a. Resolve target paths

Pick the path map for the detected framework. The canonical Vite map is:

| Logical path                           | Vite target                                          |
|----------------------------------------|------------------------------------------------------|
| design-system page component           | `src/components/design-system/DesignSystem.vue`      |
| design-system components               | `src/components/design-system/*.vue`                 |
| design-system sections                 | `src/components/design-system/sections/**/*.vue`     |
| ui primitives                          | `src/components/ui/<name>/` (folder per primitive)   |
| utils                                  | `src/lib/utils.ts`                                   |
| theme composable                       | `src/lib/useTheme.ts`                                |
| design-system stylesheet               | `src/styles/design-system.css`                       |
| entry CSS (where to add the import)    | the file containing `@import "tailwindcss"`          |

Per-framework overrides:

- **Laravel + Inertia (Vue)** — components at `resources/js/components/design-system/**` and `resources/js/components/ui/**`; `resources/js/lib/{utils,useTheme}.ts`; stylesheet at `resources/css/design-system.css`; entry CSS at `resources/css/app.css`. Also write a thin **page wrapper** at `resources/js/Pages/Admin/DesignSystem.vue` that imports and renders the design-system component so Inertia can resolve it:
  ```vue
  <script setup lang="ts">
  import DesignSystem from "@/components/design-system/DesignSystem.vue";
  </script>

  <template>
    <DesignSystem />
  </template>
  ```
- **Unknown** — write components into `src/components/...` if `src/` exists, otherwise the project root, and print a manual route registration snippet.

Confirm the project's import alias. `@/` → `src/` is the Vite default and `@/` → `resources/js/` is the Laravel + Inertia default; if the project maps `@` somewhere else (check `vite.config.*` `resolve.alias` and `tsconfig.json` `paths`), adjust the written import paths to match.

### 4b. Copy the templates

(See also Phase 4e for the theme boot script.)

For each template under `references/`, write to its mapped target. Substitute these tokens (string-replace) at write time:

| Token in template                  | Replacement                                          | Appears in                          |
|------------------------------------|------------------------------------------------------|-------------------------------------|
| `__ROUTE_PATH__`                   | the chosen `routePath`                               | `agent-instructions.md`, `routing/*` |
| `__HEADLINE_FONT_URL__`            | the Google Fonts stylesheet URL for the headline font | `styles/font-link-tags.html`        |
| `__BODY_FONT_URL__`                | the Google Fonts stylesheet URL for the body font     | `styles/font-link-tags.html`        |

Those three are the only substitution tokens in the templates. **Colors and font-family names are not tokenized** — they ship baked into `design-system.css` (the `@theme` block) and `palette.ts` at the locked Phase 2 defaults (Inter / DM Sans, ApexO blue accent, amber signal, Slate neutrals). To use different values, edit those two files directly after scaffolding; there are no `__COLOR_*__` / `__*_FONT__` tokens to replace.

Files to write (sources under `references/`):

- `page/DesignSystem.vue` → `components/design-system/DesignSystem.vue`
- `page/{SidebarNav,SectionShell,CodeBlock,ColorSwatch,CopyableHex}.vue` → `components/design-system/`
- `page/palette.ts` → `components/design-system/palette.ts` — ships with the locked default palette + font names baked in (no substitution); it drives the Colors and Typography preview sections
- `page/sections/**/*.vue` → `components/design-system/sections/`. Note: all base-styles sub-sections live in a single `BaseStylesSection.vue` (a fragment of 15 anchored `SectionShell`s); the canonical section list maps to anchors, not files. `structure/MainNavItem.vue` and `structure/MainNavUserMenu.vue` are small preview helpers imported by `MainNavSection.vue`.
- `components-ui/<name>/` → `components/ui/<name>/`. Each primitive is a **folder** containing its `.vue` file(s) plus an `index.ts` barrel that re-exports the component(s) (and any `cva` variants). This keeps `import { Button } from "@/components/ui/button"` working. Primitives: `badge`, `button`, `button-dropdown`, `checkbox`, `data-table`, `dialog`, `dropdown-menu`, `input`, `radio`, `rich-text-field`, `select`, `theme-toggle`. Skip a folder if it already exists and the existing one already comes from this skill — check for a `vue-design-system` marker comment in its `index.ts`; otherwise ask the user before overwriting. Note: `rich-text-field` imports `@milkdown/crepe` + `@milkdown/kit` and `dialog`/`dropdown-menu` import `reka-ui` — make sure the deps in 4f are installed before the user navigates to those sections, or the page will fail to render.
- `styles/design-system.css` → target stylesheet path; ships with the locked tokens baked into its `@theme` block (no substitution)
- `lib/utils.ts` → `lib/utils.ts` only if missing
- `lib/useTheme.ts` → `lib/useTheme.ts` (the `useTheme` composable + helpers backing `<ThemeToggle>`)

### 4c. Wire the stylesheet

Append `@import "./design-system.css";` (or correct relative path) to the project's existing entry CSS, immediately after `@import "tailwindcss";`. If the import is already present, skip. Wrap the import in `vue-design-system:start` / `vue-design-system:end` CSS-comment block markers so re-runs can be non-destructive:

```css
/* vue-design-system:start */
@import "./design-system.css";
/* vue-design-system:end */
```

**Tailwind v4 source detection — split-source projects.** Tailwind v4 normally auto-detects which files contain class names, but the auto-detection doesn't reliably cover projects where the source roots are split across multiple top-level directories. If the entry CSS lives somewhere that doesn't naturally walk up to every directory that contains `.vue` files, classes used in the un-scanned directories will be silently dropped from the build and pages will render unstyled.

For **Laravel + Inertia** (and any other framework where the source roots are split), add an explicit `@source` directive to the entry CSS that walks up to the closest common ancestor of all source roots. For Laravel + Inertia with the entry CSS at `resources/css/app.css`, that's:

```css
@import "tailwindcss";

/* Tailwind v4 auto-detection doesn't reliably reach `resources/js/` from the
   `resources/css/` entry point in this Laravel+Inertia setup, so declare it. */
@source "../js/**/*.{vue,ts,js}";

/* vue-design-system:start */
@import "./design-system.css";
/* vue-design-system:end */
```

Place the `@source` line *between* the `tailwindcss` import and the design-system import. For Vite projects with everything under `src/`, Tailwind's auto-detection works and an explicit `@source` is unnecessary — skip it.

### 4d. Register the route

Use the corresponding snippet under `references/routing/`:

- **Vite + Vue Router** — `references/routing/vite-vue-router.md`. Edit the routes array in place when it can be located confidently (look for `createRouter` / a `routes` array in `src/router/index.ts`, `src/router.ts`, or `src/main.ts`). Otherwise print the snippet.
- **Laravel + Inertia** — `references/routing/laravel-inertia.md`. Print the PHP snippet and tell the user where to paste it; **do not auto-edit PHP files**.
- **Unknown** — print the Vite snippet and tell the user to adapt it to their router.

### 4e. Install the HTML layout head snippets

Two snippets need to land inside the app's HTML layout `<head>`, before any `<script>` that mounts the Vue app (the Vite module script, the Inertia `@vite(...)` tags, etc.):

#### 4e-i. Font `<link>` tags

The `@theme` block defines `--font-display: "Inter", …` and `--font-sans: "DM Sans", …`, but those CSS variables only resolve to the right typeface if the font files are actually loaded. Don't load fonts via `@import url(...)` inside `design-system.css` — bundlers inline that file mid-bundle, after Tailwind's rules. CSS spec says `@import` must come before any other rules, so browsers silently drop those imports and the page renders in the system fallback (`ui-sans-serif`).

Install the link-tag snippet from `references/styles/font-link-tags.html` into the layout's `<head>`. Substitute `__HEADLINE_FONT_URL__` and `__BODY_FONT_URL__` with the URLs picked in Phase 2. When both fonts are Google Fonts, prefer collapsing them into a single `&family=…` stylesheet for one fewer request.

#### 4e-ii. Theme boot script

The `<ThemeToggle>` primitive persists the user's choice to `localStorage["vue-ds-theme"]`, but the composable that reads it (`useTheme` in `lib/useTheme.ts`) only fires when a component using it actually mounts. In real apps the toggle commonly lives inside a teleported dropdown that doesn't mount until the user opens it — so without a boot-time script, every full page load renders in light mode regardless of the saved preference.

Install the inline script from `references/styles/theme-boot-script.html` into the same `<head>`. It reads the same storage key and resolution rules as `lib/useTheme.ts`, then adds (or omits) the `.dark` class on `<html>` synchronously before paint.

#### Per-framework target for both snippets

- **Vite + Vue** — `index.html`, inside `<head>` before `<script type="module" src="/src/main.ts">`.
- **Laravel + Inertia** — `resources/views/app.blade.php`, inside `<head>` before the `@vite([...])` directive.

Wrap each inserted block in `vue-design-system:start` / `vue-design-system:end` HTML comment markers so re-runs can replace them idempotently.

### 4f. Report missing dependencies

Inspect `package.json`. For any of the following that are missing, append them to a single install command and print it (do **not** run npm/yarn/pnpm yourself):

- `reka-ui`
- `lucide-vue-next`
- `class-variance-authority`
- `clsx`
- `tailwind-merge`
- `@milkdown/crepe`
- `@milkdown/kit`

Example:
> Run this to install missing deps:
> `npm install reka-ui lucide-vue-next class-variance-authority clsx tailwind-merge @milkdown/crepe @milkdown/kit`

## Phase 5 — Update agent instructions

Open `AGENTS.md` if it exists, else `CLAUDE.md` if it exists, else create `AGENTS.md`. If both exist, update both the same way so they stay in sync.

### 5a. Reconcile existing UI / styling directives

Before appending the managed block, read the file end-to-end and look for any **pre-existing instructions about UI, CSS, design, styling, color, typography, components, or frontend conventions** that live *outside* a `vue-design-system:start`/`end` block. Examples of what to flag:

- "Use Tailwind classes like `bg-blue-600` for primary buttons"
- "Headings should use Inter / our custom font stack"
- A "Styling" / "Design" / "UI conventions" / "Components" / "Frontend" section
- Per-component rules ("buttons should be rounded-md", "cards use `bg-gray-50`")
- Color palette references, hex codes, font names, spacing scales
- Pointers to other style guides or component libraries

These will conflict with — or quietly override — the new design system if left in place. Resolve every conflict found:

- **If the existing directive is fully superseded** (e.g. a hardcoded color palette, a "use these utilities" list, a font directive), **remove it**.
- **If the existing directive carries non-styling intent worth keeping** (e.g. "all forms must be accessible", "preserve the existing route structure"), **rewrite it** to drop the styling specifics and keep the intent, and add a deferral clause like "follow the design system at `__ROUTE_PATH__` for visual conventions."
- **If you're not sure** whether something should go, surface it to the user in chat — quote the line, say what you'd do, and ask before editing. Default to keeping content when ambiguous.

Make the edits in place, briefly note in chat what you removed or rewrote, then proceed to 5b.

### 5b. Append the managed block

Append (or replace, if the markers already exist) the block from `references/agent-instructions.md`. The block is delimited by HTML comments:

```markdown
<!-- vue-design-system:start -->
…content from references/agent-instructions.md, with __ROUTE_PATH__ substituted…
<!-- vue-design-system:end -->
```

If the file is being created from scratch, also include a one-line top-level title above the block.

## Phase 6 — Scan for existing UI to migrate

After the scaffold is in place, do a quick scan for **user-facing UI that already exists in the codebase** and was not written using the design system. The point is to surface the migration opportunity — not to do it now.

### 6a. Detect

Scan the framework's standard UI locations (skip the design-system page you just wrote, and skip everything under `components/design-system/`, `components/ui/`, and `lib/`):

- **Vite + Vue** — `src/pages/**`, `src/views/**`, `src/components/**` (excluding `src/components/ui/` and `src/components/design-system/`), and any top-level `App.vue`.
- **Laravel + Inertia** — `resources/js/Pages/**` (excluding the design-system page) and `resources/js/components/**` (excluding the ui + design-system dirs).

For each candidate `.vue` file, look for **signals that it renders user-facing UI without the design system**:

- Raw `<button>` / `<a>` / `<input>` / `<select>` / `<form>` elements with their own ad-hoc Tailwind classes (instead of `<Button>`, `<Input>`, `<Select>`, etc.)
- Inline color utilities that bypass tokens — `bg-white`, `bg-gray-50`, `bg-slate-100`, `text-gray-900`, `text-zinc-500`, `border-gray-200`, raw hex via `:style`, etc.
- Page shells / layouts / headers / footers built directly in the template rather than reusing the structure sections
- Nav menus, sidebars, and cards built ad-hoc

Group findings into broad buckets (don't list every file individually — just pattern + count + one or two example paths):

- Pages / routes
- Layouts / shells / headers / footers
- Navigation / menus
- Forms / inputs
- Buttons / links
- Cards / listings / content blocks

If the scan finds **nothing meaningful** (e.g. brand-new project, or everything already follows the system), say so in one sentence and skip 6b. Move on to Phase 7.

### 6b. Offer migration

If there's UI to migrate, summarize what you found in chat — short, scannable. Then ask, using AskUserQuestion:

- Question: "Want me to migrate the existing UI to use the new design system?"
- Options:
  - `Yes, migrate everything now` — agent walks the codebase file-by-file, replacing ad-hoc styles and elements with tokens and primitives. Confirm with the user before each substantial file change.
  - `Yes, but just <bucket>` — narrow scope (e.g. only buttons, only pages). Ask which bucket if they pick this.
  - `Not now` — skip; user can re-run later.

If the user picks a migration option, proceed. Otherwise move on. Do not auto-migrate without explicit user opt-in — design-system migrations touch a lot of code and need explicit consent.

### 6c. Migration guidance (if user opted in)

When migrating:

- Replace raw `<button>` with `<Button>` and pick the closest variant; same for `<input>`, `<select>`, `<a>` styled-as-button, `<form>` field wrappers.
- Replace inline color utilities with tokens — `bg-white` → `bg-page`, `bg-gray-50` → `bg-surface`, `text-gray-900` → `text-ink-display`, `text-gray-500` → `text-ink-muted`, `border-gray-200` → `border-hairline`, `bg-blue-600` → `bg-accent`, etc. When the original color clearly isn't semantic (e.g. a brand-specific color used once), flag it in chat and ask before substituting.
- Convert bound classes carefully — a `:class="[...]"` array or object still uses the same token names; only the color values change.
- Wrap long-form prose blocks in `.body-content`.
- Keep the user in the loop: report progress per file or per bucket, surface anything ambiguous, and stop to ask rather than guessing.
- Do not change behavior or copy — only styles, structure, and primitive substitution.

## Phase 7 — Wrap up

Print a short summary in chat:

- The route URL the user can visit
- How to toggle dark mode (button in the header — also persists in localStorage)
- Which agent file got the managed block
- The install command (if dependencies were missing)
- What was migrated in Phase 6 (or "no migration needed" / "user deferred migration")
- A nudge: "Re-run this skill any time to add new sections, refresh tokens, or re-scan for migration candidates — it detects existing setup and merges non-destructively."

Stop.

## Canonical section list

The page contains these sections, in this order, each with an anchor ID matching the slug:

```
branding/
  colors                #colors
  typography            #typography
structure/
  shells                #shells
  main-navigation       #main-navigation
  sub-navigation        #sub-navigation
  page-headers          #page-headers
  body-content          #body-content
  footers               #footers
elements/
  iconography           #iconography
  buttons               #buttons
  button-dropdown       #button-dropdown
  forms                 #forms
  badges                #badges
  toggle-buttons        #toggle-buttons
  listings              #listings
  data-table            #data-table
  modal                 #modal
  dropdown-menu         #dropdown-menu
  callout               #callout
base-styles/
  heading-scale         #heading-scale
  h1                    #h1
  h2                    #h2
  h3                    #h3
  h4                    #h4
  h5                    #h5
  h6                    #h6
  anchor                #anchor
  paragraph             #paragraph
  strong                #strong
  lists                 #lists
  list-item             #list-item
  blockquote            #blockquote
  label                 #label
  hr                    #hr
```

Each section uses the `<SectionShell>` wrapper which renders five blocks in this order, driven by named slots:

1. **Preview** (`#preview` slot) — the live, fully-styled element(s)
2. **Description** (`#description` slot) — one short paragraph
3. **Use cases** (`#whenToUse` / `#whenNotToUse` slots) — bulleted: when to use, when not to use
4. **Sample code** (`code` prop) — copy-pasteable Vue/HTML
5. **Options / variations** (`#options` slot) — for components with variants (Button sizes/styles, Modal sizes, etc.); omitted for primitives like `<hr>`

## Token derivation reference

See `references/derive-palette.md` for the exact algorithm that turns the locked accent / signal / neutral defaults into the full ten-token light + dark palette.

## Style notes for the scaffolded page

- The page itself uses the design system it documents (eat your own dog food).
- Sidebar is sticky on desktop, collapses to a top sheet (button-triggered) on mobile.
- Each section has a unique `id` matching the canonical slug above for hash-link smooth scrolling.
- All section anchors use `scroll-margin-top` to clear the sticky header.
- Dark mode is class-based on `<html>` (Tailwind v4 `@custom-variant dark` against `.dark`), persisted to `localStorage["vue-ds-theme"]`.
- The page is the **reference**, not the **boundary** — the user can extend it. The reusable primitives in `components/ui/` are the actual API the rest of the app imports.
