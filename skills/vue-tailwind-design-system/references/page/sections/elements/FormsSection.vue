<script setup lang="ts">
import { ref } from "vue";
import SectionShell from "@/components/design-system/SectionShell.vue";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
import { Radio, RadioGroup } from "@/components/ui/radio";
import { Select } from "@/components/ui/select";
import { RichTextField } from "@/components/ui/rich-text-field";

const email = ref("");
const country = ref("");
const plan = ref("free");
const newsletter = ref(true);
const bio = ref("");

const code = `<script setup lang="ts">
import { ref } from "vue";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";
import { Checkbox } from "@/components/ui/checkbox";
import { Radio, RadioGroup } from "@/components/ui/radio";
import { Select } from "@/components/ui/select";
import { RichTextField } from "@/components/ui/rich-text-field";

const email = ref("");
const country = ref("");
const plan = ref("free");
const newsletter = ref(true);
const bio = ref("");
<\/script>

<template>
  <form class="space-y-4" @submit.prevent>
    <!-- Text input -->
    <div class="space-y-2">
      <label for="email">Email</label>
      <Input id="email" v-model="email" type="email" placeholder="you@example.com" />
      <p class="text-xs text-ink-muted">We'll only use this for account notifications.</p>
    </div>

    <!-- Select -->
    <div class="space-y-2">
      <label for="country">Country</label>
      <Select id="country" v-model="country">
        <option value="" disabled>Choose one…</option>
        <option value="us">United States</option>
        <option value="ca">Canada</option>
        <option value="uk">United Kingdom</option>
      </Select>
    </div>

    <!-- Radio group -->
    <fieldset class="space-y-2">
      <legend>Plan</legend>
      <RadioGroup>
        <label class="flex items-center gap-2 text-sm font-normal text-ink-body">
          <Radio name="plan" value="free" v-model="plan" /> Free
        </label>
        <label class="flex items-center gap-2 text-sm font-normal text-ink-body">
          <Radio name="plan" value="pro" v-model="plan" /> Pro
        </label>
        <label class="flex items-center gap-2 text-sm font-normal text-ink-body">
          <Radio name="plan" value="team" v-model="plan" /> Team
        </label>
      </RadioGroup>
    </fieldset>

    <!-- Checkbox -->
    <label class="flex items-start gap-2 text-sm font-normal text-ink-body">
      <Checkbox id="newsletter" v-model="newsletter" class="mt-0.5" />
      <span>
        <span class="font-medium text-ink-display">Send me product updates</span>
        <span class="block text-xs text-ink-muted">Roughly one email per month.</span>
      </span>
    </label>

    <!-- Rich text (milkdown) -->
    <div class="space-y-2">
      <label for="bio">Bio</label>
      <RichTextField v-model="bio" placeholder="Tell us about yourself…" />
    </div>

    <Button type="submit">Save</Button>
  </form>
</template>`;
</script>

<template>
  <SectionShell id="forms" title="Forms" :code="code">
    <template #description>
      Forms compose <code>&lt;Input&gt;</code>, <code>&lt;Select&gt;</code>,
      <code>&lt;Checkbox&gt;</code>, <code>&lt;Radio&gt;</code>,
      <code>&lt;RichTextField&gt;</code> (milkdown), native HTML labels, helper
      text, and <code>&lt;Button&gt;</code>. Vertical spacing between fields uses
      <code>space-y-4</code>; spacing inside a field uses <code>space-y-2</code>.
    </template>
    <template #whenToUse>
      <ul>
        <li>All data-entry surfaces.</li>
        <li>Wrap fields with their own <code>&lt;label&gt;</code> for accessibility.</li>
        <li>Use <code>&lt;fieldset&gt;</code> + <code>&lt;legend&gt;</code> around radio groups.</li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>Inline filters in toolbars — use compact controls instead.</li>
        <li>Single-button calls to action — those don't need a form wrapper unless they POST.</li>
      </ul>
    </template>
    <template #preview>
      <form class="max-w-md space-y-4" @submit.prevent>
        <div class="space-y-2">
          <label for="ds-form-email">Email</label>
          <Input
            id="ds-form-email"
            v-model="email"
            type="email"
            placeholder="you@example.com"
          />
          <p class="text-xs text-ink-muted">
            We'll only use this for account notifications.
          </p>
        </div>

        <div class="space-y-2">
          <label for="ds-form-country">Country</label>
          <Select id="ds-form-country" v-model="country">
            <option value="" disabled>Choose one…</option>
            <option value="us">United States</option>
            <option value="ca">Canada</option>
            <option value="uk">United Kingdom</option>
          </Select>
        </div>

        <fieldset class="space-y-2">
          <legend>Plan</legend>
          <RadioGroup>
            <label class="flex items-center gap-2 text-sm font-normal text-ink-body">
              <Radio name="ds-form-plan" value="free" v-model="plan" /> Free
            </label>
            <label class="flex items-center gap-2 text-sm font-normal text-ink-body">
              <Radio name="ds-form-plan" value="pro" v-model="plan" /> Pro
            </label>
            <label class="flex items-center gap-2 text-sm font-normal text-ink-body">
              <Radio name="ds-form-plan" value="team" v-model="plan" /> Team
            </label>
          </RadioGroup>
        </fieldset>

        <label class="flex items-start gap-2 text-sm font-normal text-ink-body">
          <Checkbox id="ds-form-newsletter" v-model="newsletter" class="mt-0.5" />
          <span>
            <span class="font-medium text-ink-display">Send me product updates</span>
            <span class="block text-xs text-ink-muted">Roughly one email per month.</span>
          </span>
        </label>

        <div class="space-y-2">
          <label for="ds-form-bio">Bio</label>
          <RichTextField v-model="bio" placeholder="Tell us about yourself…" />
        </div>

        <Button type="submit">Save</Button>
      </form>
    </template>
    <template #options>
      <ul class="list-disc pl-5">
        <li>Use HTML <code>&lt;label for&gt;</code> with the field's <code>id</code> for accessibility.</li>
        <li>Helper text uses <code>text-xs text-ink-muted</code> directly under the field.</li>
        <li>Error states: render a <code>text-xs text-danger-display</code> message in the same slot as helper text and add <code>aria-invalid</code> to the field.</li>
        <li>Radio groups: wrap in <code>&lt;fieldset&gt;</code> + <code>&lt;legend&gt;</code>, share a <code>name</code>, and bind the same <code>v-model</code> to every <code>&lt;Radio&gt;</code>.</li>
        <li>Selects: use a disabled empty <code>&lt;option&gt;</code> as a placeholder when no default makes sense.</li>
        <li>Rich text: <code>&lt;RichTextField&gt;</code> wraps milkdown's Crepe — two-way markdown via <code>v-model</code>. Requires <code>@milkdown/crepe</code>.</li>
      </ul>
    </template>
  </SectionShell>
</template>
