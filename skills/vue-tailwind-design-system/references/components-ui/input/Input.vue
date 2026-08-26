<script setup lang="ts">
import { cn } from "@/lib/utils";

defineOptions({ inheritAttrs: false });

const props = defineProps<{ class?: unknown }>();
const model = defineModel<string | number>();
</script>

<template>
  <input
    v-bind="$attrs"
    :value="model"
    :class="cn('form-control', props.class)"
    @input="model = ($event.target as HTMLInputElement).value"
  />
</template>
