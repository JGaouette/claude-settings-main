<script setup lang="ts">
import {
  DropdownMenuContent as DropdownMenuContentImpl,
  DropdownMenuPortal,
} from "reka-ui";
import { cn } from "@/lib/utils";

const props = withDefaults(
  defineProps<{
    sideOffset?: number;
    align?: "start" | "center" | "end";
    side?: "top" | "right" | "bottom" | "left";
    class?: unknown;
  }>(),
  { sideOffset: 6 },
);
</script>

<template>
  <DropdownMenuPortal>
    <DropdownMenuContentImpl
      :side-offset="props.sideOffset"
      :align="props.align"
      :side="props.side"
      :class="
        cn(
          'z-50 min-w-[12rem] overflow-hidden rounded-md border border-hairline bg-page p-1 text-ink-body shadow-lg',
          'data-[state=open]:animate-in data-[state=closed]:animate-out data-[state=closed]:fade-out-0 data-[state=open]:fade-in-0 data-[state=closed]:zoom-out-95 data-[state=open]:zoom-in-95',
          props.class,
        )
      "
    >
      <slot />
    </DropdownMenuContentImpl>
  </DropdownMenuPortal>
</template>
