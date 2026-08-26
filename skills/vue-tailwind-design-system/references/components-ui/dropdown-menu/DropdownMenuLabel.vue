<script setup lang="ts">
import { DropdownMenuLabel as DropdownMenuLabelImpl } from "reka-ui";
import { cn } from "@/lib/utils";

const props = defineProps<{ class?: unknown }>();
</script>

<template>
  <DropdownMenuLabelImpl
    :class="
      cn(
        'px-2 py-1.5 text-xs font-semibold uppercase tracking-wider text-ink-muted',
        props.class,
      )
    "
  >
    <slot />
  </DropdownMenuLabelImpl>
</template>
