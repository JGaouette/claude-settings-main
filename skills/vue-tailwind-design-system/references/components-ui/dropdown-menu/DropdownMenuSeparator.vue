<script setup lang="ts">
import { DropdownMenuSeparator as DropdownMenuSeparatorImpl } from "reka-ui";
import { cn } from "@/lib/utils";

const props = defineProps<{ class?: unknown }>();
</script>

<template>
  <DropdownMenuSeparatorImpl :class="cn('-mx-1 my-1 h-px bg-hairline', props.class)" />
</template>
