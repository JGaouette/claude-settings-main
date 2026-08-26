<script setup lang="ts">
import type { Component } from "vue";

defineProps<{
  icon: Component;
  label: string;
  active?: boolean;
  open: boolean;
}>();
</script>

<template>
  <div class="group/nav-item relative">
    <span
      :class="
        [
          'flex items-center gap-3 rounded-md text-sm',
          open ? 'px-3 py-2' : 'mx-auto h-9 w-9 justify-center',
          active
            ? 'bg-accent-faded text-accent-display'
            : 'text-ink-body hover:bg-surface hover:text-ink-display',
        ]
      "
    >
      <component :is="icon" class="h-4 w-4 shrink-0" />
      <span v-if="open" class="whitespace-nowrap">{{ label }}</span>
    </span>
    <span
      v-if="!open"
      class="pointer-events-none absolute left-full top-1/2 z-50 ml-2 -translate-y-1/2 whitespace-nowrap rounded-md border border-hairline bg-page px-2 py-1 text-xs font-medium text-ink-display opacity-0 shadow-md transition-opacity group-hover/nav-item:opacity-100"
    >
      {{ label }}
    </span>
  </div>
</template>
