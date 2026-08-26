<script setup lang="ts">
import { ref } from "vue";
import SectionShell from "@/components/design-system/SectionShell.vue";

const value = ref("all");
const items = [
  { value: "all", label: "All" },
  { value: "active", label: "Active" },
  { value: "archived", label: "Archived" },
];

const code = `<!-- Class-based: pair .toggle-button with .toggle-button-on for the active state -->
<button type="button" class="toggle-button toggle-button-on">All</button>
<button type="button" class="toggle-button">Active</button>
<button type="button" class="toggle-button">Archived</button>

<!-- Or drive the on state from aria-pressed (preferred for screen readers) -->
<button
  v-for="item in items"
  :key="item.value"
  type="button"
  class="toggle-button"
  :aria-pressed="value === item.value"
  @click="value = item.value"
>
  {{ item.label }}
</button>`;
</script>

<template>
  <SectionShell id="toggle-buttons" title="Toggle buttons" :code="code">
    <template #description>
      Pill-shaped buttons with an on/off state. Use them as a small, inline
      filter or segmented control where one or more options can be active. Built
      as a base class so any <code>&lt;button&gt;</code> can adopt the look — no
      component required.
    </template>
    <template #whenToUse>
      <ul>
        <li>Filter chips above a list ("All / Active / Archived").</li>
        <li>Small segmented choices inside a toolbar.</li>
        <li>Multi-select tag pickers where each pill toggles independently.</li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>For primary actions — use <code>&lt;Button&gt;</code>.</li>
        <li>For yes/no settings — use a switch or checkbox.</li>
        <li>For navigation — use anchors styled as tabs.</li>
      </ul>
    </template>
    <template #preview>
      <div class="flex flex-wrap gap-1.5">
        <button
          v-for="item in items"
          :key="item.value"
          type="button"
          class="toggle-button"
          :aria-pressed="value === item.value"
          @click="value = item.value"
        >
          {{ item.label }}
        </button>
      </div>
    </template>
    <template #options>
      <ul class="list-disc pl-5">
        <li>
          <code>.toggle-button</code> — base pill (off state). Renders on any
          <code>&lt;button&gt;</code>.
        </li>
        <li>
          <code>.toggle-button-on</code> <em>or</em>
          <code>aria-pressed="true"</code> — active state. Both selectors are
          wired up; prefer <code>aria-pressed</code> for assistive tech.
        </li>
        <li>Pair with a small lucide icon as the first child for icon+label pills.</li>
        <li>Disabled state is handled automatically via <code>disabled</code>.</li>
      </ul>
    </template>
  </SectionShell>
</template>
