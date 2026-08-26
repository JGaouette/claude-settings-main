<script setup lang="ts">
import { cn } from "@/lib/utils";
const props = defineProps<{ class?: unknown }>();
</script>

<template>
  <dl :class="cn('divide-y divide-hairline border-y border-hairline', props.class)">
    <slot />
  </dl>
</template>
