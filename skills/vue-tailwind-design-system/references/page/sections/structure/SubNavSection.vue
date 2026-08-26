<script setup lang="ts">
import { ref } from "vue";
import SectionShell from "@/components/design-system/SectionShell.vue";
import { Select } from "@/components/ui/select";

const active = ref("overview");

const code = `<!-- Mobile (< md): full-width dropdown showing the active tab -->
<div class="md:hidden border-b border-hairline">
  <div class="py-2">
    <Select aria-label="Section" v-model="active" class="w-full">
      <option value="overview">Overview</option>
      <option value="activity">Activity</option>
      <option value="members">Members</option>
      <option value="billing">Billing</option>
    </Select>
  </div>
</div>

<!-- Desktop (md+): horizontal tab strip -->
<nav class="hidden md:flex items-end justify-between gap-4 border-b border-hairline">
  <div class="flex items-center gap-6">
    <a href="#" class="-mb-px cursor-pointer border-b-2 border-accent px-1 py-3 text-sm font-medium text-accent-display no-underline">Overview</a>
    <a href="#" class="-mb-px cursor-pointer border-b-2 border-transparent px-1 py-3 text-sm text-ink-body no-underline hover:text-ink-display">Activity</a>
    <a href="#" class="-mb-px cursor-pointer border-b-2 border-transparent px-1 py-3 text-sm text-ink-body no-underline hover:text-ink-display">Members</a>
    <a href="#" class="-mb-px cursor-pointer border-b-2 border-transparent px-1 py-3 text-sm text-ink-body no-underline hover:text-ink-display">Billing</a>
  </div>

  <!-- Optional right-side slot — secondary links, filters, search, etc. -->
  <div class="flex items-center gap-3 pb-2">
    <a href="#" class="text-sm text-ink-muted no-underline hover:text-ink-display">View all</a>
  </div>
</nav>`;
</script>

<template>
  <SectionShell id="sub-navigation" title="Sub navigation" :code="code">
    <template #description>
      Horizontal tab list for navigating within a single section of the app
      (settings sub-pages, project tabs, profile sections). The active tab's
      underline merges with the row's bottom hairline. An optional right-side
      slot accepts secondary links, filters, search fields, or small actions.
      Below the <code>md</code> breakpoint, the tab strip collapses into a
      full-width dropdown that surfaces the active tab — tap to switch sections
      without horizontal scrolling or wrapped rows.
    </template>
    <template #whenToUse>
      <ul>
        <li>When a page has 3+ sibling sub-views with stable structure.</li>
        <li>Append to a Page header (see the "with tabs" variant).</li>
        <li>Right-side slot is optional — leave empty when not needed.</li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>For 1–2 sub-pages — just link them inline in the page body.</li>
        <li>For dynamic, list-of-things navigation — use a Listing.</li>
        <li>For top-level app destinations — those belong in main navigation.</li>
      </ul>
    </template>
    <template #preview>
      <div class="space-y-8">
        <div>
          <p class="mb-2 text-xs uppercase tracking-wider text-ink-muted">
            Mobile (&lt; md) — full-width dropdown
          </p>
          <div class="max-w-sm border-b border-hairline">
            <div class="py-2">
              <Select aria-label="Section" v-model="active" class="w-full">
                <option value="overview">Overview</option>
                <option value="activity">Activity</option>
                <option value="members">Members</option>
                <option value="billing">Billing</option>
              </Select>
            </div>
          </div>
        </div>

        <div>
          <p class="mb-2 text-xs uppercase tracking-wider text-ink-muted">
            Desktop (md+) — tab strip
          </p>
          <nav class="flex items-end gap-6 border-b border-hairline">
            <span class="-mb-px cursor-pointer border-b-2 border-accent px-1 py-3 text-sm font-medium text-accent-display">Overview</span>
            <span class="-mb-px cursor-pointer border-b-2 border-transparent px-1 py-3 text-sm text-ink-body">Activity</span>
            <span class="-mb-px cursor-pointer border-b-2 border-transparent px-1 py-3 text-sm text-ink-body">Members</span>
            <span class="-mb-px cursor-pointer border-b-2 border-transparent px-1 py-3 text-sm text-ink-body">Billing</span>
          </nav>
        </div>

        <div>
          <p class="mb-2 text-xs uppercase tracking-wider text-ink-muted">
            Desktop — with right-side content
          </p>
          <nav class="flex items-end justify-between gap-4 border-b border-hairline">
            <div class="flex items-center gap-6">
              <span class="-mb-px cursor-pointer border-b-2 border-accent px-1 py-3 text-sm font-medium text-accent-display">Overview</span>
              <span class="-mb-px cursor-pointer border-b-2 border-transparent px-1 py-3 text-sm text-ink-body">Activity</span>
              <span class="-mb-px cursor-pointer border-b-2 border-transparent px-1 py-3 text-sm text-ink-body">Members</span>
            </div>
            <div class="flex items-center gap-3 pb-2">
              <span class="text-sm text-ink-muted">View all</span>
            </div>
          </nav>
        </div>
      </div>
    </template>
    <template #options>
      <ul class="list-disc pl-5">
        <li>
          <strong>Mobile breakpoint</strong>: tabs collapse into a full-width
          <code>&lt;Select&gt;</code> below the <code>md</code> breakpoint. Show
          the dropdown with <code>md:hidden</code> and the tab strip with
          <code>hidden md:flex</code>. The dropdown's current value is the active
          tab so users can see and change sections without horizontal scrolling.
        </li>
        <li>
          <strong>Active state</strong>:
          <code>border-b-2 border-accent text-accent-display font-medium</code>
          on the active tab; <code>-mb-px</code> overlaps the parent's hairline so
          the underlines merge into one line.
        </li>
        <li>
          <strong>Right-side slot</strong>: any flex children — links, filters,
          search fields, small icon buttons. Use <code>pb-2</code> to keep them
          visually centered against the tab text baseline. On mobile, stack
          right-side content above the dropdown trigger (use
          <code>flex flex-col gap-2</code> on the wrapper) so the dropdown remains
          truly full-width.
        </li>
        <li>
          <strong>Pair with Page header</strong>: drop the parent
          <code>border-b</code> off the page header, then place this nav beneath
          it. Result: two horizontal lines.
        </li>
        <li>
          <strong>Rich dropdown variant</strong>: when tabs carry icons or status
          indicators that wouldn't survive a native <code>&lt;select&gt;</code>,
          swap the <code>Select</code> for a <code>DropdownMenu</code> with a
          full-width trigger and matching
          <code>w-[var(--reka-dropdown-menu-trigger-width)]</code> content width.
        </li>
      </ul>
    </template>
  </SectionShell>
</template>
