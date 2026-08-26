<script setup lang="ts">
import { X } from "lucide-vue-next";
import {
  DialogClose,
  DialogContent as DialogContentImpl,
  DialogOverlay,
  DialogPortal,
} from "reka-ui";
import { cn } from "@/lib/utils";

const props = withDefaults(
  defineProps<{ size?: "sm" | "md" | "lg"; class?: unknown }>(),
  { size: "md" },
);

const sizeClass: Record<"sm" | "md" | "lg", string> = {
  sm: "modal-small",
  md: "",
  lg: "modal-large",
};
</script>

<template>
  <DialogPortal>
    <DialogOverlay class="modal-overlay" />
    <DialogContentImpl :class="cn('modal', sizeClass[props.size], props.class)">
      <slot />
      <DialogClose class="modal-close">
        <X class="h-4 w-4" />
        <span class="sr-only">Close</span>
      </DialogClose>
    </DialogContentImpl>
  </DialogPortal>
</template>
