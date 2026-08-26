<script setup lang="ts">
import { DialogDescription as DialogDescriptionImpl } from "reka-ui";
import { cn } from "@/lib/utils";
const props = defineProps<{ class?: unknown }>();
</script>

<template>
  <DialogDescriptionImpl :class="cn('modal-description', props.class)">
    <slot />
  </DialogDescriptionImpl>
</template>
