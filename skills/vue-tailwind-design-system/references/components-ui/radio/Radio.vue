<script setup lang="ts">
import { cn } from "@/lib/utils";

defineOptions({ inheritAttrs: false });

const props = defineProps<{ value?: string | number; class?: unknown }>();
// Group value — bind the same v-model to every <Radio> in a group.
const model = defineModel<string | number>();
</script>

<template>
  <input
    type="radio"
    v-bind="$attrs"
    :value="props.value"
    :checked="model === props.value"
    :class="
      cn(
        'h-4 w-4 shrink-0 rounded-full border border-hairline bg-page text-accent',
        'accent-[var(--color-accent)]',
        'focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-accent focus-visible:ring-offset-2 focus-visible:ring-offset-page',
        'disabled:cursor-not-allowed disabled:opacity-50',
        props.class,
      )
    "
    @change="model = props.value"
  />
</template>
