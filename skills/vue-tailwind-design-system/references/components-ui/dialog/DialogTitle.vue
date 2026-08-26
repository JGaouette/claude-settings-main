<script setup lang="ts">
import { DialogTitle as DialogTitleImpl } from "reka-ui";
import { cn } from "@/lib/utils";
const props = defineProps<{ class?: unknown }>();
</script>

<template>
  <DialogTitleImpl :class="cn('modal-title', props.class)">
    <slot />
  </DialogTitleImpl>
</template>
