<script setup lang="ts">
import SectionShell from "@/components/design-system/SectionShell.vue";

const listsCode = `<!-- unstyled — for nav, sidebars, listings -->
<ul>
  <li>One</li>
  <li>Two</li>
</ul>

<!-- default disc/decimal — for prose -->
<div class="body-content">
  <ul>
    <li>One</li>
    <li>Two</li>
  </ul>
</div>`;

const listItemCode = `<div class="body-content">
  <ul>
    <li>A single list item.</li>
  </ul>
</div>`;

const labelCode = `<label for="email">Email address</label>
<Input id="email" type="email" placeholder="you@example.com" />`;

const headingScaleCode = `<h1>Heading 1</h1>
<h2>Heading 2</h2>
<h3>Heading 3</h3>
<h4>Heading 4</h4>
<h5>Heading 5</h5>
<h6>Heading 6</h6>`;
</script>

<template>
  <SectionShell
    id="heading-scale"
    title="Heading scale"
    :code="headingScaleCode"
  >
    <template #description>
      All six heading levels at their base sizes. Headings inherit the display
      font, semibold weight, and tightened line-height from base styles — no
      utility classes required.
    </template>
    <template #whenToUse>
      <ul>
        <li>Use semantic heading levels for document outline.</li>
        <li>Skip-level only when visual hierarchy demands it.</li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>Don't override <code>font-family</code> or <code>color</code> on headings.</li>
        <li>Don't use a heading element purely for styling.</li>
      </ul>
    </template>
    <template #preview>
      <div class="space-y-3">
        <h1>The quick brown fox</h1>
        <h2>The quick brown fox</h2>
        <h3>The quick brown fox</h3>
        <h4>The quick brown fox</h4>
        <h5>The quick brown fox</h5>
        <h6>The quick brown fox</h6>
      </div>
    </template>
  </SectionShell>

  <SectionShell id="h1" title="H1" code="<h1>Page title</h1>">
    <template #description>Page-level heading. One per page.</template>
    <template #preview><h1>Page title</h1></template>
  </SectionShell>

  <SectionShell id="h2" title="H2" code="<h2>Section heading</h2>">
    <template #description>Major section heading inside a page.</template>
    <template #preview><h2>Section heading</h2></template>
  </SectionShell>

  <SectionShell id="h3" title="H3" code="<h3>Sub-section</h3>">
    <template #description>Sub-section heading.</template>
    <template #preview><h3>Sub-section</h3></template>
  </SectionShell>

  <SectionShell id="h4" title="H4" code="<h4>Minor heading</h4>">
    <template #description>Minor heading inside a sub-section.</template>
    <template #preview><h4>Minor heading</h4></template>
  </SectionShell>

  <SectionShell id="h5" title="H5" code="<h5>Card title</h5>">
    <template #description>Card / inline heading.</template>
    <template #preview><h5>Card title</h5></template>
  </SectionShell>

  <SectionShell id="h6" title="H6" code="<h6>Eyebrow label</h6>">
    <template #description>
      Eyebrow / label-style heading. Uppercase, tracked, muted color.
    </template>
    <template #preview><h6>Eyebrow label</h6></template>
  </SectionShell>

  <SectionShell id="anchor" title="Anchor (a)" code='<a href="/path">Read more</a>'>
    <template #description>
      Inline links use the accent color with no underline. Hover darkens the
      accent slightly.
    </template>
    <template #whenToUse>
      <ul>
        <li>Real navigation in prose.</li>
        <li>External references in body copy.</li>
      </ul>
    </template>
    <template #whenNotToUse>
      <ul>
        <li>For action triggers — use a Button (<code>variant="link"</code>).</li>
        <li>Inside dense UI nav lists — those have their own styles.</li>
      </ul>
    </template>
    <template #preview>
      <p>
        Read more in <a href="#colors">our color tokens</a> or
        <a href="#" target="_blank" rel="noreferrer">on the docs site</a>.
      </p>
    </template>
  </SectionShell>

  <SectionShell
    id="paragraph"
    title="Paragraph (p)"
    code="<p>A paragraph of body text.</p>"
  >
    <template #description>
      Body text element. Inherits color, font, and line-height from base styles.
    </template>
    <template #preview>
      <p>
        A paragraph carries the bulk of textual content. Its color is
        <code>ink-body</code>, its line-height is <code>1.6</code>, and it does
        not need any utility classes for its baseline appearance.
      </p>
    </template>
  </SectionShell>

  <SectionShell
    id="strong"
    title="Strong"
    code="<p>This is <strong>important</strong>.</p>"
  >
    <template #description>
      Emphasized inline text. Bumps weight to 600 and color to
      <code>ink-display</code>.
    </template>
    <template #preview>
      <p>
        Most of this sentence is body weight, but <strong>this part</strong> is
        emphasized.
      </p>
    </template>
  </SectionShell>

  <SectionShell id="lists" title="Lists (ul / ol)" :code="listsCode">
    <template #description>
      Lists are unstyled by default — no bullets, no numbers, no padding — so
      they're safe to use as semantic containers in nav, sidebars, and listings.
      To get default disc/decimal styling back, wrap the list (or its parent) in
      <code>.body-content</code>.
    </template>
    <template #preview>
      <div class="grid gap-6 sm:grid-cols-2">
        <div>
          <div class="mb-2 text-xs font-mono text-ink-muted">ul (default)</div>
          <ul>
            <li>Unstyled first item</li>
            <li>Unstyled second item</li>
            <li>Unstyled third item</li>
          </ul>
        </div>
        <div>
          <div class="mb-2 text-xs font-mono text-ink-muted">
            ul inside .body-content
          </div>
          <div class="body-content">
            <ul>
              <li>Bulleted first item</li>
              <li>Bulleted second item</li>
              <li>Bulleted third item</li>
            </ul>
          </div>
        </div>
        <div>
          <div class="mb-2 text-xs font-mono text-ink-muted">ol (default)</div>
          <ol>
            <li>Unstyled first item</li>
            <li>Unstyled second item</li>
            <li>Unstyled third item</li>
          </ol>
        </div>
        <div>
          <div class="mb-2 text-xs font-mono text-ink-muted">
            ol inside .body-content
          </div>
          <div class="body-content">
            <ol>
              <li>Numbered first item</li>
              <li>Numbered second item</li>
              <li>Numbered third item</li>
            </ol>
          </div>
        </div>
      </div>
    </template>
  </SectionShell>

  <SectionShell id="list-item" title="List item (li)" :code="listItemCode">
    <template #description>
      Individual list item. Unstyled by default; gets disc/decimal markers and
      indentation only when its parent list is inside .body-content.
    </template>
    <template #preview>
      <div class="body-content">
        <ul>
          <li>A single list item inside .body-content.</li>
        </ul>
      </div>
    </template>
  </SectionShell>

  <SectionShell
    id="blockquote"
    title="Blockquote"
    code='<blockquote>"A pithy quote here."</blockquote>'
  >
    <template #description>
      Pull quote with an accent left border and italic, muted color. Use for
      attribution-style quotes inside body content.
    </template>
    <template #preview>
      <blockquote>
        "Make it work, make it right, make it fast — and only after that, make it
        pretty."
      </blockquote>
    </template>
  </SectionShell>

  <SectionShell id="label" title="Label / legend" :code="labelCode">
    <template #description>
      Form-field labels (<code>&lt;label&gt;</code>) and
      <code>&lt;legend&gt;</code> use the design system's standard label style by
      default — small text, medium weight, <code>ink-display</code> color. No
      utility classes needed. The base rule applies to all
      <code>&lt;label&gt;</code> elements; for the special case of a label used
      as a wrapper around a checkbox or radio, add
      <code>font-normal text-ink-body</code> to override.
    </template>
    <template #preview>
      <div class="space-y-2 max-w-sm">
        <label for="ds-label-example">Email address</label>
        <input
          id="ds-label-example"
          class="form-control"
          placeholder="you@example.com"
          type="email"
        />
      </div>
    </template>
  </SectionShell>

  <SectionShell id="hr" title="Horizontal rule" code="<hr />">
    <template #description>
      Visual break between content blocks. Renders as a 1px
      <code>hairline</code> line with vertical margin.
    </template>
    <template #preview>
      <div>
        <p>Above the rule.</p>
        <hr />
        <p>Below the rule.</p>
      </div>
    </template>
  </SectionShell>
</template>
