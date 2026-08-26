# Palette derivation

Inputs are locked to the defaults declared in Phase 2 of `SKILL.md`:
- `accent` — `#003967` (ApexO blue) — oklch(34% 0.0963 250.1)
- `signal` — `#fcd34d` (Amber light) — same shade in both light and dark modes
- `neutral` — Slate (Tailwind's slate scale: 50 / 100 / 200 / 400 / 500 / 700 / 800 / 900 / 950)

Output: ten tokens × two modes (light + dark) = twenty hex values, written into the `@theme` block of `design-system.css`. The resolved values are pre-computed in Phase 2 of `SKILL.md` — this file documents the algorithm so the skill can re-derive if defaults ever change.

## Slate scale

| Step | Hex       |
|------|-----------|
| 50   | `#f8fafc` |
| 100  | `#f1f5f9` |
| 200  | `#e2e8f0` |
| 400  | `#94a3b8` |
| 500  | `#64748b` |
| 700  | `#334155` |
| 800  | `#1e293b` |
| 900  | `#0f172a` |
| 950  | `#020617` |

## Rules

### Surfaces — driven by `neutral`

| Token       | Light             | Dark              |
|-------------|-------------------|-------------------|
| `page`      | `#ffffff`         | `neutral.950`     |
| `surface`   | `neutral.50`      | `neutral.900`     |
| `hairline`  | `neutral.200`     | `neutral.800`     |

Note: `page` light is pure white (cleaner than `neutral.50`); `page` dark uses `950` for true blackness.

### Text — driven by `neutral`

| Token         | Light          | Dark            |
|---------------|----------------|-----------------|
| `ink-body`    | `neutral.700`  | `neutral.200`   |
| `ink-display` | `neutral.900`  | `neutral.50`    |
| `ink-muted`   | `neutral.500`  | `neutral.400`   |

### Splash — driven by `accent` and `signal`

| Token           | Light                              | Dark                              |
|-----------------|------------------------------------|-----------------------------------|
| `accent`        | accent                             | if the accent's oklch lightness is below 45%, `oklch(70% 0.11 <accent hue>)`; otherwise the accent unchanged |
| `accent-faded`  | accent mixed 12% on `#ffffff`      | `oklch(22% 0.046 <accent hue>)`   |
| `accent-darker` | `oklch(28% <accent chroma> <accent hue>)` | `oklch(86% 0.09 <accent hue>)`    |
| `signal`        | signal                             | signal (same shade — pinned to a light tint) |
| `signal-faded`  | signal mixed 12% on `#ffffff`      | signal mixed 18% on `neutral.950` |
| `signal-darker` | a darker shade of signal with high contrast against `signal` and `signal-faded` backgrounds (e.g. amber-700 `#b45309` for amber-300 signal) | same as light (pinned) |

The `*-darker` tokens are intended for foreground use *on top of* their faded/base counterpart — e.g. `bg-signal text-signal-darker` for a danger button, or `bg-signal-faded text-signal-darker` for a status badge — where contrast against the background needs more depth than the base color provides. In dark mode, where `accent-faded` is itself dark, `accent-darker` inverts to a light tint to keep that contrast.

### Mixing formula

Given a foreground hex `F` and a background hex `B`, mixing `F` at percentage `p` (0..1) on `B`:

```
out.r = round(F.r * p + B.r * (1 - p))
out.g = round(F.g * p + B.g * (1 - p))
out.b = round(F.b * p + B.b * (1 - p))
```

Convert each component to a two-digit hex and concatenate with `#`.

### Worked example

Inputs:
- accent = `#4f46e5` → `(79, 70, 229)`
- neutral = Zinc → `neutral.950` = `#09090b` → `(9, 9, 11)`

`accent-faded` light: `#4f46e5` mixed 12% on `#ffffff`:
- r = round(79*0.12 + 255*0.88) = round(9.48 + 224.4) = 234
- g = round(70*0.12 + 255*0.88) = round(8.4 + 224.4) = 233
- b = round(229*0.12 + 255*0.88) = round(27.48 + 224.4) = 252
- → `#eae9fc`

`signal-faded` dark: signal `#fcd34d` → `(252, 211, 77)` mixed 18% on `#09090b`:
- r = round(252*0.18 + 9*0.82) = round(45.36 + 7.38) = 53
- g = round(211*0.18 + 9*0.82) = round(37.98 + 7.38) = 45
- b = round(77*0.18 + 11*0.82) = round(13.86 + 9.02) = 23
- → `#352d17`

The dark `accent-faded` is not a mix — it's set directly in oklch, because the dark-mode accent may have been lifted away from the light-mode accent (see below).

## Note on the dark-mode accent lift

`accent` is pinned across modes only when it's light enough to read on a dark page. The locked default `#003967` is not: at oklch L=34% it reaches just 1.71:1 against `page` dark (`#020617`), versus 11.79:1 against `page` light. Dark mode therefore uses `oklch(70% 0.11 250)` = `#67a3e0` — the same hue, lifted into a readable range (7.58:1 on `page`, 6.71:1 on `surface`).

The 45% lightness threshold in the Splash table is the trigger: accents above it (mid-tone brand colors) stay pinned, accents below it get lifted.

## Note on the locked signal shade

The signal default (`#fcd34d`) is intentionally a light amber (Tailwind amber-300). It's pinned to the same shade in both modes so badges/callouts/status indicators read consistently. The faded variants on `#ffffff` (light) and `#020617` (dark) compute to `#fffaea` and `#2f2b21` respectively — both are subtle background tints that signal text sits on top of.
