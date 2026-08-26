<script setup lang="ts">
import { cn } from "@/lib/utils";
const props = defineProps<{ title?: string; class?: unknown }>();
</script>

<template>
  <div
    :class="
      cn('grid gap-1 py-4 md:grid-cols-4 md:gap-6 xl:grid-cols-5', props.class)
    "
  >
    <dt class="text-sm font-medium text-ink-muted md:col-span-1 md:pt-0.5">
      <slot name="title">{{ props.title }}</slot>
    </dt>
    <dd class="text-ink-body md:col-span-3 xl:col-span-4"><slot /></dd>
  </div>
</template>
