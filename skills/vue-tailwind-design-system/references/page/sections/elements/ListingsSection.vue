<script setup lang="ts">
import SectionShell from "@/components/design-system/SectionShell.vue";
import { Badge } from "@/components/ui/badge";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Ellipsis, Folder } from "lucide-vue-next";

const code = `<ul class="divide-y divide-hairline overflow-hidden rounded-md border border-hairline bg-page">
  <li v-for="item in items" :key="item.id">
    <div class="flex items-center gap-3 px-4 py-3 hover:bg-surface">
      <a :href="item.href" class="flex min-w-0 flex-1 items-center gap-3 no-underline">
        <Folder class="h-4 w-4 text-ink-muted" />
        <div class="min-w-0 flex-1">
          <div class="truncate text-sm font-medium text-ink-display">{{ item.title }}</div>
          <div class="truncate text-xs text-ink-muted">{{ item.subtitle }}</div>
        </div>
        <Badge tone="muted">{{ item.status }}</Badge>
      </a>
      <!-- Standard item settings dropdown — see Dropdown menu section. -->
      <DropdownMenu>
        <DropdownMenuTrigger as-child>
          <button
            type="button"
            aria-label="Settings"
            class="inline-flex cursor-pointer items-center justify-center text-ink-muted transition-colors hover:text-ink-body focus:outline-none focus-visible:text-ink-body"
          >
            <Ellipsis class="h-4 w-4" :stroke-width="1.5" />
          </button>
        </DropdownMenuTrigger>
        <DropdownMenuContent align="end">
          <DropdownMenuItem>Deactivate</DropdownMenuItem>
          <DropdownMenuItem destructive>Delete</DropdownMenuItem>
        </DropdownMenuContent>
      </DropdownMenu>
    </div>
  </li>
</ul>`;

const ITEMS = [
  { id: 1, title: "Onboarding redesign", subtitle: "Updated 2h ago · Marie", status: "Active" },
  { id: 2, title: "Q2 marketing rollout", subtitle: "Updated yesterday · Jordan", status: "Active" },
  { id: 3, title: "API v2 migration", subtitle: "Updated 3d ago · Priya", status: "Draft" },
  { id: 4, title: "Mobile launch checklist", subtitle: "Archived last week", status: "Archived" },
];
</script>

<template>
  <SectionShell id="listings" title="Listings" :code="code">
    <template #description>
      A vertical list of selectable rows — the workhorse of dashboards and
      resource indexes. Each row composes an icon, a title, supporting metadata,
      an optional Badge, a chevron affordance, and (for items in a collection) a
      standard settings dropdown.
    </template>
    <template #whenToUse>
      <ul>
        <li>Lists of resources (projects, files, members).</li>
        <li>Search results, recent activity feeds.</li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>Dense, multi-column tabular data — use a table.</li>
        <li>Inline option lists in dropdowns — use a menu primitive.</li>
      </ul>
    </template>
    <template #preview>
      <ul class="divide-y divide-hairline overflow-hidden rounded-md border border-hairline bg-page">
        <li v-for="item in ITEMS" :key="item.id">
          <div class="flex items-center gap-3 px-4 py-3 hover:bg-surface">
            <div class="flex min-w-0 flex-1 items-center gap-3">
              <Folder class="h-4 w-4 text-ink-muted" />
              <div class="min-w-0 flex-1">
                <div class="truncate text-sm font-medium text-ink-display">
                  {{ item.title }}
                </div>
                <div class="truncate text-xs text-ink-muted">{{ item.subtitle }}</div>
              </div>
              <Badge :tone="item.status === 'Active' ? 'accent' : 'muted'">
                {{ item.status }}
              </Badge>
            </div>
            <DropdownMenu>
              <DropdownMenuTrigger as-child>
                <button
                  type="button"
                  aria-label="Settings"
                  class="inline-flex cursor-pointer items-center justify-center text-ink-muted transition-colors hover:text-ink-body focus:outline-none focus-visible:text-ink-body"
                >
                  <Ellipsis class="h-4 w-4" :stroke-width="1.5" />
                </button>
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end">
                <DropdownMenuItem>Deactivate</DropdownMenuItem>
                <DropdownMenuItem destructive>Delete</DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          </div>
        </li>
      </ul>
    </template>
    <template #options>
      <ul class="list-disc pl-5">
        <li>Wrap rows in <code>&lt;a&gt;</code> for navigation, or <code>&lt;button&gt;</code> for in-page selection.</li>
        <li>Drop the chevron when the row is non-navigable.</li>
        <li>Use <code>truncate</code> on title and subtitle to prevent overflow.</li>
        <li>
          <strong>Settings dropdown by default.</strong> When listings render
          items in a collection (the typical case), include our standard
          settings dropdown at the right edge of each row — see
          <a href="#dropdown-menu">Dropdown menu</a> for the trigger pattern
          (bare <code>Ellipsis</code>, no border).
        </li>
      </ul>
    </template>
  </SectionShell>
</template>
