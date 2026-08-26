<script setup lang="ts">
import SectionShell from "@/components/design-system/SectionShell.vue";

const code = `<footer class="border-t border-hairline bg-page">
  <div class="mx-auto flex max-w-7xl flex-col gap-2 px-4 py-6 text-sm text-ink-muted sm:flex-row sm:items-center sm:justify-between">
    <span>© 2026 Acme</span>
    <nav class="flex gap-4">
      <a href="/privacy" class="no-underline hover:text-ink-display">Privacy</a>
      <a href="/terms" class="no-underline hover:text-ink-display">Terms</a>
    </nav>
  </div>
</footer>`;
</script>

<template>
  <SectionShell id="footers" title="Footers" :code="code">
    <template #description>
      The bottom edge of a shell. Quiet, low-contrast. Holds the copyright, legal
      links, and (sparingly) secondary navigation.
    </template>
    <template #whenToUse>
      <ul>
        <li>Public-facing or marketing pages.</li>
        <li>Authenticated screens that have natural scroll endings.</li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>Dense app screens (dashboards, editors) — they don't need a footer.</li>
        <li>Modals.</li>
      </ul>
    </template>
    <template #preview>
      <footer class="rounded-md border border-hairline bg-page">
        <div class="flex flex-col gap-2 px-4 py-6 text-sm text-ink-muted sm:flex-row sm:items-center sm:justify-between">
          <span>© 2026 Acme</span>
          <nav class="flex gap-4">
            <span>Privacy</span>
            <span>Terms</span>
          </nav>
        </div>
      </footer>
    </template>
  </SectionShell>
</template>
