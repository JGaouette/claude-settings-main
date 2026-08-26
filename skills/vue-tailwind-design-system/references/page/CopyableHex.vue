<script setup lang="ts">
import { ref } from "vue";
import { Check, Copy } from "lucide-vue-next";

const props = defineProps<{ label: string; hex: string; isActive: boolean }>();

const copied = ref(false);

async function onClick() {
  try {
    await navigator.clipboard.writeText(props.hex);
    copied.value = true;
    window.setTimeout(() => (copied.value = false), 1200);
  } catch {
    // ignore
  }
}
</script>

<template>
  <button
    type="button"
    :aria-label="`Copy ${label} mode hex ${hex}`"
    :class="
      [
        'group flex w-full cursor-pointer items-center justify-between gap-2 rounded-md px-1.5 py-1 font-mono text-[10px] transition-colors',
        'hover:bg-surface',
        isActive ? 'text-ink-display' : 'text-ink-muted',
      ].join(' ')
    "
    @click="onClick"
  >
    <span class="text-ink-muted">{{ label }}</span>
    <span class="flex items-center gap-1.5">
      <span>{{ hex }}</span>
      <Check v-if="copied" class="h-3 w-3 text-accent" aria-hidden="true" />
      <Copy
        v-else
        class="h-3 w-3 opacity-0 transition-opacity group-hover:opacity-100"
        aria-hidden="true"
      />
    </span>
  </button>
</template>
