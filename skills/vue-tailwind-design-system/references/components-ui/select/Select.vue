<script setup lang="ts">
import { ChevronDown } from "lucide-vue-next";
import { cn } from "@/lib/utils";

defineOptions({ inheritAttrs: false });

const props = defineProps<{ class?: unknown }>();
const model = defineModel<string | number>();
</script>

<template>
  <div class="relative">
    <select
      v-bind="$attrs"
      :value="model"
      :class="cn('form-control form-control-select', props.class)"
      @change="model = ($event.target as HTMLSelectElement).value"
    >
      <slot />
    </select>
    <ChevronDown
      aria-hidden="true"
      class="pointer-events-none absolute right-3 top-1/2 h-4 w-4 -translate-y-1/2 text-ink-muted"
    />
  </div>
</template>
