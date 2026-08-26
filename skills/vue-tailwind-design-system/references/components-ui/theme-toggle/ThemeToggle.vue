<script setup lang="ts">
import type { Component } from "vue";
import { Monitor, Moon, Sun } from "lucide-vue-next";
import { useTheme, type Theme } from "@/lib/useTheme";
import { cn } from "@/lib/utils";

const props = defineProps<{ block?: boolean; class?: unknown }>();

const { theme, setTheme } = useTheme();

const OPTIONS: { value: Theme; label: string; icon: Component }[] = [
  { value: "light", label: "Light mode", icon: Sun },
  { value: "dark", label: "Dark mode", icon: Moon },
  { value: "system", label: "System theme", icon: Monitor },
];
</script>

<template>
  <div
    role="radiogroup"
    aria-label="Theme"
    :class="
      cn(
        'inline-flex items-center gap-0.5 rounded-md border border-hairline bg-surface p-0.5',
        props.block && 'w-full',
        props.class,
      )
    "
  >
    <button
      v-for="opt in OPTIONS"
      :key="opt.value"
      type="button"
      role="radio"
      :aria-checked="theme === opt.value"
      :aria-label="opt.label"
      :title="opt.label"
      :class="
        cn(
          'inline-flex h-7 cursor-pointer items-center justify-center rounded transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-accent',
          props.block ? 'flex-1' : 'w-7',
          theme === opt.value
            ? 'bg-page text-ink-display'
            : 'text-ink-muted hover:text-ink-display',
        )
      "
      @click="setTheme(opt.value)"
    >
      <component :is="opt.icon" class="h-4 w-4" />
    </button>
  </div>
</template>
