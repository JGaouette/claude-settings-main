<script setup lang="ts">
import SectionShell from "@/components/design-system/SectionShell.vue";
import { Button } from "@/components/ui/button";
import { Plus } from "lucide-vue-next";

const code = `import { Button } from "@/components/ui/button";
import { Plus } from "lucide-vue-next";

<Button>Primary</Button>
<Button variant="secondary">Secondary</Button>
<Button variant="ghost">Ghost</Button>
<Button variant="soft">Soft</Button>
<Button variant="danger">Danger</Button>
<Button variant="link">Link</Button>

<Button size="sm">Small</Button>
<Button size="md">Medium</Button>
<Button size="lg">Large</Button>
<Button size="icon" aria-label="Add"><Plus class="h-4 w-4" /></Button>

<!-- as-child: render a link with button styling -->
<Button as-child>
  <a href="/new">New project</a>
</Button>`;
</script>

<template>
  <SectionShell id="buttons" title="Buttons" :code="code">
    <template #description>
      The <code>&lt;Button&gt;</code> primitive supports six variants and four
      sizes. Use <code>as-child</code> to render as a different element (e.g. an
      <code>&lt;a&gt;</code>) while keeping the styling.
    </template>
    <template #whenToUse>
      <ul>
        <li>Any clickable action — submit, save, navigate, open modal.</li>
        <li>
          One <code>primary</code> per scope; <code>secondary</code>/<code>ghost</code>
          for the rest.
        </li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>For inline links inside prose — use <code>&lt;a&gt;</code>.</li>
        <li>Three or more primary buttons in the same view — collapse to one.</li>
      </ul>
    </template>
    <template #preview>
      <div class="space-y-6">
        <div class="flex flex-wrap items-center gap-3">
          <Button variant="primary">Primary</Button>
          <Button variant="secondary">Secondary</Button>
          <Button variant="ghost">Ghost</Button>
          <Button variant="soft">Soft</Button>
          <Button variant="danger">Danger</Button>
          <Button variant="link">Link</Button>
        </div>
        <div class="flex flex-wrap items-center gap-3">
          <Button size="sm">Small</Button>
          <Button size="md">Medium</Button>
          <Button size="lg">Large</Button>
          <Button size="icon" aria-label="Add">
            <Plus class="h-4 w-4" />
          </Button>
        </div>
        <div class="flex flex-wrap items-center gap-3">
          <Button>
            <Plus class="h-4 w-4" /> With icon
          </Button>
          <Button disabled>Disabled</Button>
        </div>
      </div>
    </template>
    <template #options>
      <ul class="list-disc pl-5">
        <li>
          <code>variant</code>: <code>primary</code> (default) |
          <code>secondary</code> | <code>ghost</code> | <code>soft</code> |
          <code>danger</code> | <code>link</code>
        </li>
        <li>
          <code>size</code>: <code>sm</code> | <code>md</code> (default) |
          <code>lg</code> | <code>icon</code>
        </li>
        <li>
          <code>as-child</code>: merge the styling onto a single child element
          (e.g. an <code>&lt;a&gt;</code>) instead of rendering a
          <code>&lt;button&gt;</code>.
        </li>
      </ul>
    </template>
  </SectionShell>
</template>
