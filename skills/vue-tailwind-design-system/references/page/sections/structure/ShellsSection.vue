<script setup lang="ts">
import SectionShell from "@/components/design-system/SectionShell.vue";

const code = `<div class="flex min-h-screen bg-page text-ink-body">
  <!-- Main navigation rail — see Main navigation section. Hidden below lg;
       a hamburger fixed to the top-right opens the mobile drawer instead. -->
  <MainNav />
  <main class="min-w-0 flex-1 px-6 py-8 sm:px-10">
    <div class="mx-auto max-w-4xl">
      <!-- Page header (optional with sub-nav tabs) → page content -->
    </div>
  </main>
</div>`;
</script>

<template>
  <SectionShell id="shells" title="Shells" :code="code">
    <template #description>
      The outermost page frame. A shell is a full-bleed <code>bg-page</code>
      container with the main-navigation rail on the left and a content area on
      the right. The rail toggles between collapsed (<code>w-14</code>) and
      expanded (<code>w-56</code>) via a chevron button (state persisted to
      <code>localStorage</code>), and is hidden entirely below the
      <code>lg</code> breakpoint in favor of a fixed hamburger and slide-in
      drawer. Sub-navigation lives inside page headers as horizontal tabs (not
      in the shell).
    </template>
    <template #whenToUse>
      <ul>
        <li>Every authenticated screen.</li>
        <li>Pair with a Page header at the top of the main content area.</li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>Marketing/landing pages — those use a dedicated marketing shell with a horizontal top nav.</li>
        <li>Modals/sheets — they layer on top of the shell, not replace it.</li>
      </ul>
    </template>
    <template #preview>
      <div class="overflow-hidden rounded-md border border-hairline">
        <div class="flex h-44">
          <div class="w-10 shrink-0 border-r border-hairline bg-page p-2">
            <div class="mb-2 h-6 w-6 rounded bg-accent-faded" />
            <div class="space-y-1.5">
              <div class="h-4 w-6 rounded bg-surface" />
              <div class="h-4 w-6 rounded bg-surface" />
              <div class="h-4 w-6 rounded bg-surface" />
            </div>
          </div>
          <div class="flex-1 bg-surface p-3">
            <div class="mb-3 border-b border-hairline pb-2">
              <div class="h-3 w-24 rounded bg-page" />
            </div>
            <div class="space-y-1.5">
              <div class="h-2 w-3/4 rounded bg-page" />
              <div class="h-2 w-1/2 rounded bg-page" />
              <div class="h-2 w-2/3 rounded bg-page" />
            </div>
          </div>
        </div>
      </div>
    </template>
    <template #options>
      <ul class="list-disc pl-5">
        <li><strong>Rail-only</strong>: just the main-nav rail and a content column. Default for app screens.</li>
        <li>
          <strong>With sub-nav</strong>: page header inside <code>main</code>
          appends sub-navigation tabs — see Page headers "with tabs" variant. No
          second sidebar needed.
        </li>
        <li>
          <strong>Content max-width</strong>: wrap children in
          <code>mx-auto max-w-4xl</code> so long-form content stays readable. The
          shell itself is full-bleed; the constraint lives on the inner container.
        </li>
        <li>
          <strong>Mobile</strong>: hide the rail with <code>hidden lg:flex</code>
          and render a hamburger fixed to the top-right of the viewport
          (<code>fixed right-3 top-3 z-30</code>) that opens the same nav as a
          slide-in drawer overlay.
        </li>
      </ul>
    </template>
  </SectionShell>
</template>
