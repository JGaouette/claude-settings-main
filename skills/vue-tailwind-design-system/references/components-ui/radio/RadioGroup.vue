<script setup lang="ts">
import { cn } from "@/lib/utils";

const props = withDefaults(
  defineProps<{
    orientation?: "vertical" | "horizontal";
    class?: unknown;
  }>(),
  { orientation: "vertical" },
);
</script>

<template>
  <div
    role="radiogroup"
    :class="
      cn(
        'flex gap-3',
        props.orientation === 'vertical' ? 'flex-col' : 'flex-row flex-wrap',
        props.class,
      )
    "
  >
    <slot />
  </div>
</template>
