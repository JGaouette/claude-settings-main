<script setup lang="ts">
import type { Component } from "vue";
import { onMounted, ref, watch } from "vue";
import SectionShell from "@/components/design-system/SectionShell.vue";
import MainNavItem from "./MainNavItem.vue";
import MainNavUserMenu from "./MainNavUserMenu.vue";
import { ChevronsLeft, ChevronsRight, Folder, Home, Menu, Settings, Users, X } from "lucide-vue-next";

const STORAGE_KEY = "vue-ds-main-nav-open";

const open = ref(true);
const mobileOpen = ref(false);

onMounted(() => {
  const stored = window.localStorage.getItem(STORAGE_KEY);
  if (stored !== null) open.value = stored === "true";
});
watch(open, (v) => window.localStorage.setItem(STORAGE_KEY, String(v)));

const navItems: { icon: Component; label: string; active?: boolean }[] = [
  { icon: Home, label: "Dashboard", active: true },
  { icon: Folder, label: "Projects" },
  { icon: Users, label: "Members" },
  { icon: Settings, label: "Settings" },
];

const code = `<!-- components/MainNav.vue -->
<script setup lang="ts">
import type { Component } from "vue";
import { onMounted, ref, watch } from "vue";
import {
  DropdownMenu, DropdownMenuContent, DropdownMenuItem,
  DropdownMenuLabel, DropdownMenuSeparator, DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { ThemeToggle } from "@/components/ui/theme-toggle";
import {
  ChevronsLeft, ChevronsRight, Folder, Home, LogOut, Menu,
  Settings, User, Users, X,
} from "lucide-vue-next";

const STORAGE_KEY = "main-nav-open";

const open = ref(true);
const mobileOpen = ref(false);
onMounted(() => {
  const stored = localStorage.getItem(STORAGE_KEY);
  if (stored !== null) open.value = stored === "true";
});
watch(open, (v) => localStorage.setItem(STORAGE_KEY, String(v)));

const email = "you@example.com";
const items: { href: string; icon: Component; label: string; active?: boolean }[] = [
  { href: "/dashboard", icon: Home, label: "Dashboard", active: true },
  { href: "/projects", icon: Folder, label: "Projects" },
  { href: "/members", icon: Users, label: "Members" },
  { href: "/settings", icon: Settings, label: "Settings" },
];
<\/script>

<template>
  <!-- Desktop rail — hidden below lg. Nav items, the collapse/expand chevron,
       and a <MainNavUserMenu> live inside; extract them into their own
       components as the rail grows. -->
  <aside
    :class="[
      'sticky top-0 hidden h-screen shrink-0 flex-col border-r border-hairline bg-page transition-[width] duration-200 lg:flex',
      open ? 'w-56' : 'w-14',
    ]"
  >
    <!-- brand row + collapse chevron (when open) -->
    <!-- <nav> of items · expand chevron (when collapsed) · user menu -->
  </aside>

  <!-- Mobile drawer — slides in from the left, dismisses on overlay click -->
  <div v-if="mobileOpen" class="fixed inset-0 z-40 lg:hidden">
    <div class="absolute inset-0 bg-ink-display/40 backdrop-blur-sm" @click="mobileOpen = false" />
    <aside class="absolute left-0 top-0 flex h-full w-64 flex-col bg-page shadow-xl">
      <!-- brand row + close button · nav items · user menu -->
    </aside>
  </div>

  <!-- Mobile hamburger — fixed to the top-right corner of the viewport -->
  <button
    type="button"
    class="fixed right-3 top-3 z-30 inline-flex h-9 w-9 items-center justify-center rounded-md border border-hairline bg-page text-ink-body hover:bg-surface lg:hidden"
    aria-label="Open navigation"
    @click="mobileOpen = true"
  >
    <Menu class="h-4 w-4" />
  </button>
</template>`;
</script>

<template>
  <SectionShell id="main-navigation" title="Main navigation" :code="code">
    <template #description>
      A vertical rail at the left edge of the shell. The rail has two fixed
      widths — collapsed (<code>w-14</code>, icons only) and expanded
      (<code>w-56</code>, icons plus labels) — and a chevron toggle switches
      between them. When expanded, the toggle sits in the brand row at the top;
      when collapsed, an expand chevron sits just above the user menu at the
      bottom of the rail. The choice is persisted to <code>localStorage</code>.
      When collapsed, hovering an item pops a tooltip-style label out to the
      right of the rail without resizing it. A user-account dropdown above the
      bottom edge holds a signed-in-as label, Profile / Settings, the theme
      toggle, and Sign out — and shows the avatar plus email when expanded,
      avatar only when collapsed. On screens narrower than <code>lg</code>, the
      rail is hidden in favor of a hamburger button fixed to the top-right corner
      that opens the same nav as a slide-in drawer.
    </template>
    <template #whenToUse>
      <ul>
        <li>One per shell. Always present and sticky on desktop.</li>
        <li>Top-level destinations only — secondary items belong in sub-nav tabs.</li>
        <li>4–8 items max; beyond that, group with hairline separators.</li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>For deep, multi-level menus — use sub-nav tabs or a command palette.</li>
        <li>Marketing/landing pages — those use a horizontal top nav.</li>
      </ul>
    </template>
    <template #preview>
      <div class="space-y-10">
        <div>
          <p class="mb-2 text-xs uppercase tracking-wider text-ink-muted">
            Desktop — toggle between collapsed and expanded
          </p>
          <div class="relative flex h-96 overflow-hidden rounded-md border border-hairline">
            <aside
              :class="[
                'flex shrink-0 flex-col border-r border-hairline bg-page transition-[width] duration-200',
                open ? 'w-56' : 'w-14',
              ]"
            >
              <div
                :class="[
                  'flex h-14 shrink-0 items-center gap-3 border-b border-hairline px-3',
                  open ? 'justify-between' : 'justify-center',
                ]"
              >
                <span class="flex min-w-0 items-center gap-2 text-ink-display">
                  <span class="flex h-7 w-7 shrink-0 items-center justify-center rounded-md bg-accent-faded font-display text-sm font-semibold text-accent">A</span>
                  <span v-if="open" class="truncate font-display text-sm font-semibold">Acme</span>
                </span>
                <button
                  v-if="open"
                  type="button"
                  class="inline-flex h-8 w-8 shrink-0 cursor-pointer items-center justify-center rounded-md text-ink-muted hover:bg-surface hover:text-ink-display"
                  aria-label="Collapse sidebar"
                  @click="open = false"
                >
                  <ChevronsLeft class="h-4 w-4" />
                </button>
              </div>
              <nav class="flex flex-1 flex-col gap-1 p-2 text-sm">
                <MainNavItem
                  v-for="item in navItems"
                  :key="item.label"
                  :icon="item.icon"
                  :label="item.label"
                  :active="item.active"
                  :open="open"
                />
              </nav>
              <div v-if="!open" class="border-t border-hairline p-2">
                <button
                  type="button"
                  class="flex h-9 w-full cursor-pointer items-center justify-center rounded-md text-ink-muted hover:bg-surface hover:text-ink-display"
                  aria-label="Expand sidebar"
                  @click="open = true"
                >
                  <ChevronsRight class="h-4 w-4" />
                </button>
              </div>
              <div class="border-t border-hairline p-2">
                <MainNavUserMenu :open="open" />
              </div>
            </aside>
            <div class="flex flex-1 items-center justify-center bg-surface px-6 text-center text-xs text-ink-muted">
              {{
                open
                  ? "When expanded, the collapse chevron sits next to the brand. State persists to localStorage."
                  : "When collapsed, hover an icon to pop a tooltip-style label outside the rail."
              }}
            </div>
          </div>
        </div>

        <div>
          <p class="mb-2 text-xs uppercase tracking-wider text-ink-muted">
            Mobile — hamburger fixed to the top-right corner opens a drawer
          </p>
          <div class="relative mx-auto h-96 w-72 overflow-hidden rounded-2xl border border-hairline bg-page shadow-sm">
            <div class="flex h-14 items-center justify-between border-b border-hairline px-4">
              <span class="font-display text-sm font-semibold text-ink-display">Acme</span>
              <button
                type="button"
                class="inline-flex h-9 w-9 cursor-pointer items-center justify-center rounded-md border border-hairline text-ink-body hover:bg-surface"
                aria-label="Open navigation"
                @click="mobileOpen = true"
              >
                <Menu class="h-4 w-4" />
              </button>
            </div>
            <div class="flex h-[calc(100%-3.5rem)] items-center justify-center bg-surface text-xs text-ink-muted">
              Tap the menu to open the drawer
            </div>

            <div v-if="mobileOpen" class="absolute inset-0 z-40">
              <div class="absolute inset-0 bg-ink-display/40 backdrop-blur-sm" @click="mobileOpen = false" />
              <aside class="absolute left-0 top-0 flex h-full w-64 flex-col bg-page shadow-xl">
                <div class="flex h-14 shrink-0 items-center justify-between border-b border-hairline px-4">
                  <span class="font-display text-sm font-semibold text-ink-display">Acme</span>
                  <button
                    type="button"
                    class="inline-flex h-8 w-8 cursor-pointer items-center justify-center rounded-md text-ink-muted hover:bg-surface hover:text-ink-display"
                    aria-label="Close navigation"
                    @click="mobileOpen = false"
                  >
                    <X class="h-4 w-4" />
                  </button>
                </div>
                <nav class="flex flex-1 flex-col gap-1 p-2 text-sm">
                  <MainNavItem
                    v-for="item in navItems"
                    :key="item.label"
                    :icon="item.icon"
                    :label="item.label"
                    :active="item.active"
                    :open="true"
                  />
                </nav>
                <div class="border-t border-hairline p-2">
                  <MainNavUserMenu :open="true" />
                </div>
              </aside>
            </div>
          </div>
        </div>
      </div>
    </template>
    <template #options>
      <ul class="list-disc pl-5">
        <li><strong>Width</strong>: <code>w-14</code> collapsed, <code>w-56</code> expanded. Both are fixed; only the user-toggle changes between them.</li>
        <li>
          <strong>Persistence</strong>: open/closed state is written to
          <code>localStorage</code> under <code>main-nav-open</code> (rename per
          app). Read it inside <code>onMounted</code> and write it in a
          <code>watch</code>.
        </li>
        <li>
          <strong>Toggle position</strong>: the collapse chevron lives in the
          brand row when the rail is expanded (next to the brand on the right).
          When the rail is collapsed there's no room for it there, so the expand
          chevron sits just above the user menu at the bottom of the rail.
        </li>
        <li>
          <strong>Active item highlight (collapsed)</strong>: each item is a 36px
          square pill (<code>h-9 w-9</code>) centered with <code>mx-auto</code>
          inside the 40px-wide nav column — keeps the <code>bg-accent-faded</code>
          highlight as a square rather than a full-width strip.
        </li>
        <li>
          <strong>Floating labels (collapsed)</strong>: each item is its own
          <code>group/nav-item</code> with an <code>absolute left-full</code>
          tooltip-style label. The label is <code>pointer-events-none</code> and
          only opacity-toggles, so the rail width is never disturbed.
        </li>
        <li>
          <strong>Account menu</strong>: a <code>DropdownMenu</code> with
          <code>side="top" align="start"</code> so it slides up from the
          bottom-left corner. Contents (top to bottom): signed-in-as label,
          Profile, Settings, separator, the <code>&lt;ThemeToggle block /&gt;</code>
          primitive, separator, Sign out. Trigger shows avatar + email when
          expanded, avatar only when collapsed.
        </li>
        <li>
          <strong>Mobile</strong>: hide the rail with <code>hidden lg:flex</code>,
          render a hamburger fixed to <code>right-3 top-3</code> with
          <code>z-30</code> and <code>bg-page</code> so it stays readable while
          the page scrolls. The drawer is <code>w-64</code> with its own brand row
          and close button at the top.
        </li>
      </ul>
    </template>
  </SectionShell>
</template>
