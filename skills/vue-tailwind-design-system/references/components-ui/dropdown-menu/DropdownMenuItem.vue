<script setup lang="ts">
import { DropdownMenuItem as DropdownMenuItemImpl } from "reka-ui";
import { cn } from "@/lib/utils";

const props = defineProps<{ destructive?: boolean; class?: unknown }>();
</script>

<template>
  <DropdownMenuItemImpl
    :class="
      cn(
        'relative flex cursor-pointer select-none items-center gap-2 rounded-sm px-2 py-1.5 text-sm outline-none transition-colors',
        'focus:bg-surface focus:text-ink-display data-[disabled]:pointer-events-none data-[disabled]:opacity-50',
        props.destructive
          ? 'text-danger-display focus:bg-danger-faded focus:text-danger-display'
          : 'text-ink-body',
        '[&_svg]:h-4 [&_svg]:w-4 [&_svg]:shrink-0 [&_svg]:text-ink-muted',
        props.class,
      )
    "
  >
    <slot />
  </DropdownMenuItemImpl>
</template>
