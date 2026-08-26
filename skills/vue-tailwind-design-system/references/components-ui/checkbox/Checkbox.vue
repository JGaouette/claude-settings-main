<script setup lang="ts">
import { cn } from "@/lib/utils";

defineOptions({ inheritAttrs: false });

const props = defineProps<{ class?: unknown }>();
const model = defineModel<boolean>();
</script>

<template>
  <input
    type="checkbox"
    v-bind="$attrs"
    :checked="model"
    :class="
      cn(
        'h-4 w-4 shrink-0 rounded-md border border-hairline bg-page text-accent',
        'accent-[var(--color-accent)]',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-accent focus-visible:ring-offset-2 focus-visible:ring-offset-page',
        'disabled:cursor-not-allowed disabled:opacity-50',
        props.class,
      )
    "
    @change="model = ($event.target as HTMLInputElement).checked"
  />
</template>
