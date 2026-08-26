<script setup lang="ts">
import { cn } from "@/lib/utils";
const props = defineProps<{ class?: unknown }>();
</script>

<template>
  <div :class="cn('modal-footer', props.class)">
    <slot />
  </div>
</template>
