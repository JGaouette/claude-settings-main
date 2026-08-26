<script setup lang="ts">
import { Primitive } from "reka-ui";
import { cn } from "@/lib/utils";
import { badgeVariants, type BadgeVariants } from ".";

const props = defineProps<{
  tone?: BadgeVariants["tone"];
  as?: string;
  asChild?: boolean;
  class?: unknown;
}>();
</script>

<template>
  <Primitive
    :as="props.as ?? 'span'"
    :as-child="props.asChild"
    :class="cn(badgeVariants({ tone: props.tone }), props.class)"
  >
    <slot />
  </Primitive>
</template>
