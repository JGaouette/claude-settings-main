<script setup lang="ts">
import type { Component } from "vue";
import SectionShell from "@/components/design-system/SectionShell.vue";
import {
  Activity,
  ArrowRight,
  Bell,
  Check,
  ChevronRight,
  Folder,
  Plus,
  Search,
  Settings,
  Trash2,
  User,
  X,
} from "lucide-vue-next";

const code = `import { Plus } from "lucide-vue-next";

<Plus class="h-4 w-4" />`;

const ICONS: { icon: Component; name: string }[] = [
  { icon: Activity, name: "Activity" },
  { icon: ArrowRight, name: "ArrowRight" },
  { icon: Bell, name: "Bell" },
  { icon: Check, name: "Check" },
  { icon: ChevronRight, name: "ChevronRight" },
  { icon: Folder, name: "Folder" },
  { icon: Plus, name: "Plus" },
  { icon: Search, name: "Search" },
  { icon: Settings, name: "Settings" },
  { icon: Trash2, name: "Trash2" },
  { icon: User, name: "User" },
  { icon: X, name: "X" },
];
</script>

<template>
  <SectionShell id="iconography" title="Iconography" :code="code">
    <template #description>
      Icons come from <code>lucide-vue-next</code>. Default size is
      <code>h-4 w-4</code> for inline use; <code>h-5 w-5</code> in buttons;
      <code>h-6 w-6</code> for standalone visual anchors.
    </template>
    <template #whenToUse>
      <ul>
        <li>Reinforce a button's label or status.</li>
        <li>Visually anchor empty states and section headers.</li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>Decoratively, with no semantic value.</li>
        <li>Replacing a label entirely (icon-only buttons need an aria-label).</li>
      </ul>
    </template>
    <template #preview>
      <div class="grid grid-cols-3 gap-4 sm:grid-cols-4 md:grid-cols-6">
        <div
          v-for="{ icon, name } in ICONS"
          :key="name"
          class="flex flex-col items-center gap-2 rounded-md border border-hairline bg-page p-3"
        >
          <component :is="icon" class="h-5 w-5 text-ink-display" />
          <span class="font-mono text-[10px] text-ink-muted">{{ name }}</span>
        </div>
      </div>
    </template>
    <template #options>
      <ul class="list-disc pl-5">
        <li>Pick from the full lucide set: https://lucide.dev/icons</li>
        <li>
          Use <code>text-ink-muted</code> for icons that recede;
          <code>text-accent</code> when emphasizing.
        </li>
        <li>Always pair icon-only buttons with <code>aria-label</code>.</li>
      </ul>
    </template>
  </SectionShell>
</template>
