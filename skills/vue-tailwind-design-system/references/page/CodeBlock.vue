<script setup lang="ts">
import { ref } from "vue";
import { Check, Copy } from "lucide-vue-next";

const props = withDefaults(
  defineProps<{ code: string; language?: string }>(),
  { language: "vue" },
);

const copied = ref(false);

async function handleCopy() {
  await navigator.clipboard.writeText(props.code);
  copied.value = true;
  setTimeout(() => (copied.value = false), 1500);
}
</script>

<template>
  <div class="relative">
    <pre
      class="overflow-x-auto rounded-md border border-hairline bg-page p-4 text-xs leading-relaxed"
    ><code :class="`language-${props.language} text-ink-body`">{{ props.code }}</code></pre>
    <button
      type="button"
      class="absolute right-2 top-2 inline-flex h-7 cursor-pointer items-center gap-1 rounded border border-hairline bg-surface px-2 text-xs text-ink-muted hover:text-ink-display"
      aria-label="Copy code"
      @click="handleCopy"
    >
      <template v-if="copied"><Check class="h-3 w-3" /> Copied</template>
      <template v-else><Copy class="h-3 w-3" /> Copy</template>
    </button>
  </div>
</template>
