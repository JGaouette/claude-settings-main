<script setup lang="ts">
import SectionShell from "@/components/design-system/SectionShell.vue";
import { ButtonDropdown } from "@/components/ui/button-dropdown";
import {
  DropdownMenuItem,
  DropdownMenuSeparator,
} from "@/components/ui/dropdown-menu";
import { ArrowRight, Copy, Pause, Trash2 } from "lucide-vue-next";

const noop = () => {};

const code = `import { ButtonDropdown } from "@/components/ui/button-dropdown";
import { DropdownMenuItem, DropdownMenuSeparator } from "@/components/ui/dropdown-menu";
import { ArrowRight, Pause, Trash2 } from "lucide-vue-next";

<ButtonDropdown @click="doPrimary">
  <template #action>Greenlight <ArrowRight class="h-4 w-4" /></template>
  <DropdownMenuItem @select="doPark"><Pause /> Park</DropdownMenuItem>
  <DropdownMenuSeparator />
  <DropdownMenuItem destructive @select="doDiscard"><Trash2 /> Discard</DropdownMenuItem>
</ButtonDropdown>

<ButtonDropdown variant="secondary" @click="doDuplicate">
  <template #action>Duplicate</template>
  <DropdownMenuItem @select="doDuplicateAs">Duplicate as draft</DropdownMenuItem>
  <DropdownMenuItem @select="doExport">Export</DropdownMenuItem>
</ButtonDropdown>`;
</script>

<template>
  <SectionShell id="button-dropdown" title="Button dropdown" :code="code">
    <template #description>
      A split button — a primary action on the left and a chevron end-cap on the
      right that opens a dropdown of related secondary actions. The two halves
      render as one shape with a thin currentColor-tinted divider between them,
      so it works on any variant (and on custom backgrounds set via
      <code>class</code>). The menu uses the same dropdown primitive documented
      below.
    </template>
    <template #whenToUse>
      <ul>
        <li>
          One action is the obvious next step but a small set of related
          secondary actions belong in the same spot.
        </li>
        <li>
          Page-header action boxes where the primary action lives next to
          "park / discard / reset"-style alternates.
        </li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>
          The actions don't share intent — use separate buttons (or a plain
          <code>DropdownMenu</code> if none of them is the obvious primary).
        </li>
        <li>There's only the main action — use a plain <code>Button</code>.</li>
        <li>
          The menu is a list of navigation destinations rather than secondary
          actions — use a plain <code>DropdownMenu</code>.
        </li>
      </ul>
    </template>
    <template #preview>
      <div class="flex flex-wrap items-center gap-4">
        <ButtonDropdown @click="noop">
          <template #action>Greenlight <ArrowRight class="h-4 w-4" /></template>
          <DropdownMenuItem @select="noop"><Pause /> Park</DropdownMenuItem>
          <DropdownMenuSeparator />
          <DropdownMenuItem destructive @select="noop">
            <Trash2 /> Discard
          </DropdownMenuItem>
        </ButtonDropdown>

        <ButtonDropdown variant="secondary" @click="noop">
          <template #action><Copy class="h-4 w-4" /> Duplicate</template>
          <DropdownMenuItem @select="noop">Duplicate as draft</DropdownMenuItem>
          <DropdownMenuItem @select="noop">Export</DropdownMenuItem>
        </ButtonDropdown>

        <ButtonDropdown variant="danger" @click="noop">
          <template #action>Delete</template>
          <DropdownMenuItem @select="noop">Move to trash</DropdownMenuItem>
          <DropdownMenuItem @select="noop">Archive</DropdownMenuItem>
        </ButtonDropdown>
      </div>
    </template>
    <template #options>
      <ul class="list-disc pl-5">
        <li>
          <code>#action</code> slot: content of the left (primary) button.
          Plain text or any markup.
        </li>
        <li>
          <code>@click</code>: handler for the primary action. The toggle
          (chevron) opens the menu and is independent.
        </li>
        <li>
          <code>variant</code>: any <code>Button</code> variant —
          <code>primary</code> (default), <code>secondary</code>,
          <code>ghost</code>, <code>soft</code>, <code>danger</code>,
          <code>link</code>.
        </li>
        <li><code>size</code>: <code>sm</code> | <code>md</code> (default) | <code>lg</code>.</li>
        <li>
          <code>class</code> / <code>toggle-class</code>: extra classes for each
          half. Useful for custom-colored buttons. <code>toggle-class</code>
          defaults to mirror <code>class</code>.
        </li>
        <li>
          <code>menu-align</code>: <code>start | center | end</code> (default
          <code>end</code>) — forwarded to <code>DropdownMenuContent</code>.
        </li>
        <li>
          <code>toggle-aria-label</code>: aria-label for the chevron half.
          Default <code>"More actions"</code>.
        </li>
        <li>
          <strong>Default slot</strong>: pass <code>DropdownMenuItem</code> /
          <code>DropdownMenuSeparator</code> children — the standard
          dropdown-menu primitives.
        </li>
      </ul>
    </template>
  </SectionShell>
</template>
