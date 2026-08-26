<script setup lang="ts">
import CodeBlock from "./CodeBlock.vue";

defineProps<{ id: string; title: string; code?: string }>();
</script>

<template>
  <section :id="id" class="border-b border-hairline pb-16 pt-8 first:pt-0">
    <header class="mb-6">
      <h2 class="text-2xl font-semibold text-ink-display">{{ title }}</h2>
      <p v-if="$slots.description" class="mt-2 max-w-2xl text-ink-muted">
        <slot name="description" />
      </p>
    </header>

    <div class="rounded-lg border border-hairline bg-transparent p-6">
      <slot name="preview" />
    </div>

    <div
      v-if="$slots.whenToUse || $slots.whenNotToUse"
      class="mt-6 grid gap-4 sm:grid-cols-2"
    >
      <div
        v-if="$slots.whenToUse"
        class="rounded-md border border-hairline bg-page p-4"
      >
        <h3 class="text-sm font-semibold text-ink-display">When to use</h3>
        <div
          class="mt-2 text-sm text-ink-body [&_ul]:mt-1 [&_ul]:list-disc [&_ul]:pl-5 [&_li]:mt-0.5"
        >
          <slot name="whenToUse" />
        </div>
      </div>
      <div
        v-if="$slots.whenNotToUse"
        class="rounded-md border border-hairline bg-page p-4"
      >
        <h3 class="text-sm font-semibold text-ink-display">When not to use</h3>
        <div
          class="mt-2 text-sm text-ink-body [&_ul]:mt-1 [&_ul]:list-disc [&_ul]:pl-5 [&_li]:mt-0.5"
        >
          <slot name="whenNotToUse" />
        </div>
      </div>
    </div>

    <div v-if="code" class="mt-6">
      <h3 class="mb-2 text-sm font-semibold text-ink-display">Sample code</h3>
      <CodeBlock :code="code" />
    </div>

    <div v-if="$slots.options" class="mt-6">
      <h3 class="mb-2 text-sm font-semibold text-ink-display">
        Options &amp; variations
      </h3>
      <div class="text-sm text-ink-body"><slot name="options" /></div>
    </div>

    <slot />
  </section>
</template>
