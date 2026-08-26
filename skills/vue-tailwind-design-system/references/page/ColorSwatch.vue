<script setup lang="ts">
import { computed, onMounted, onUnmounted, ref } from "vue";
import CopyableHex from "./CopyableHex.vue";

const props = defineProps<{
  name: string;
  utility: string;
  hexLight: string;
  hexDark: string;
}>();

const isDark = ref(false);
let observer: MutationObserver | null = null;

onMounted(() => {
  const root = document.documentElement;
  const update = () => (isDark.value = root.classList.contains("dark"));
  update();
  observer = new MutationObserver(update);
  observer.observe(root, { attributes: true, attributeFilter: ["class"] });
});

onUnmounted(() => observer?.disconnect());

const currentHex = computed(() =>
  isDark.value ? props.hexDark : props.hexLight,
);
</script>

<template>
  <div class="flex flex-col gap-2">
    <div
      class="aspect-[2/1] rounded-md border border-hairline"
      :style="{ backgroundColor: currentHex }"
      :aria-label="`${name} (${isDark ? 'dark' : 'light'} mode preview)`"
    />
    <div class="text-xs">
      <div class="font-medium text-ink-display">{{ name }}</div>
      <div class="font-mono text-ink-muted">{{ utility }}</div>
      <div class="mt-1 flex flex-col gap-0.5">
        <CopyableHex label="Light" :hex="hexLight" :is-active="!isDark" />
        <CopyableHex label="Dark" :hex="hexDark" :is-active="isDark" />
      </div>
    </div>
  </div>
</template>
