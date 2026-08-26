<script setup lang="ts">
import { ref } from "vue";
import { Menu, X } from "lucide-vue-next";
import SidebarNav from "@/components/design-system/SidebarNav.vue";
import { ThemeToggle } from "@/components/ui/theme-toggle";
import ColorsSection from "@/components/design-system/sections/branding/ColorsSection.vue";
import TypographySection from "@/components/design-system/sections/branding/TypographySection.vue";
import ShellsSection from "@/components/design-system/sections/structure/ShellsSection.vue";
import MainNavSection from "@/components/design-system/sections/structure/MainNavSection.vue";
import SubNavSection from "@/components/design-system/sections/structure/SubNavSection.vue";
import PageHeadersSection from "@/components/design-system/sections/structure/PageHeadersSection.vue";
import BodyContentSection from "@/components/design-system/sections/structure/BodyContentSection.vue";
import FootersSection from "@/components/design-system/sections/structure/FootersSection.vue";
import BaseStylesSection from "@/components/design-system/sections/base-styles/BaseStylesSection.vue";
import IconographySection from "@/components/design-system/sections/elements/IconographySection.vue";
import ButtonsSection from "@/components/design-system/sections/elements/ButtonsSection.vue";
import ButtonDropdownSection from "@/components/design-system/sections/elements/ButtonDropdownSection.vue";
import FormsSection from "@/components/design-system/sections/elements/FormsSection.vue";
import BadgesSection from "@/components/design-system/sections/elements/BadgesSection.vue";
import ToggleButtonsSection from "@/components/design-system/sections/elements/ToggleButtonsSection.vue";
import ListingsSection from "@/components/design-system/sections/elements/ListingsSection.vue";
import DataTableSection from "@/components/design-system/sections/elements/DataTableSection.vue";
import ModalSection from "@/components/design-system/sections/elements/ModalSection.vue";
import CalloutSection from "@/components/design-system/sections/elements/CalloutSection.vue";
import DropdownMenuSection from "@/components/design-system/sections/elements/DropdownMenuSection.vue";

const navOpen = ref(false);
</script>

<template>
  <div class="min-h-screen bg-page text-ink-body">
    <header
      class="sticky top-0 z-30 flex h-14 items-center justify-between border-b border-hairline bg-page/80 px-4 backdrop-blur-sm sm:px-6"
    >
      <div class="flex items-center gap-3">
        <button
          type="button"
          class="inline-flex h-9 w-9 cursor-pointer items-center justify-center rounded-md border border-hairline bg-surface text-ink-body lg:hidden"
          aria-label="Open navigation"
          @click="navOpen = true"
        >
          <Menu class="h-4 w-4" />
        </button>
        <span class="font-display text-sm font-semibold text-ink-display">
          Design System
        </span>
      </div>
      <ThemeToggle />
    </header>

    <div class="mx-auto flex max-w-7xl">
      <aside class="hidden w-64 shrink-0 border-r border-hairline lg:block">
        <div
          class="sticky top-14 max-h-[calc(100vh-3.5rem)] overflow-y-auto p-4"
        >
          <SidebarNav />
        </div>
      </aside>

      <div v-if="navOpen" class="fixed inset-0 z-40 lg:hidden">
        <div
          class="absolute inset-0 bg-ink-display/40 backdrop-blur-sm"
          @click="navOpen = false"
        />
        <div
          class="absolute left-0 top-0 h-full w-72 overflow-y-auto bg-page p-4 shadow-xl"
        >
          <div class="mb-4 flex items-center justify-between">
            <span class="font-display text-sm font-semibold text-ink-display">
              Design System
            </span>
            <button
              type="button"
              class="inline-flex h-8 w-8 cursor-pointer items-center justify-center rounded-md text-ink-muted hover:text-ink-display"
              aria-label="Close navigation"
              @click="navOpen = false"
            >
              <X class="h-4 w-4" />
            </button>
          </div>
          <SidebarNav @navigate="navOpen = false" />
        </div>
      </div>

      <main class="min-w-0 flex-1 px-4 py-8 sm:px-8 lg:px-12">
        <div class="mb-12 max-w-2xl">
          <h1 class="text-3xl font-semibold text-ink-display">Design System</h1>
          <p class="mt-2 text-ink-muted">
            Single source of truth for every visual primitive in this app.
            Reuse what's here. Propose additions before building one-offs.
          </p>
        </div>

        <ColorsSection />
        <TypographySection />
        <ShellsSection />
        <MainNavSection />
        <SubNavSection />
        <PageHeadersSection />
        <BodyContentSection />
        <FootersSection />
        <IconographySection />
        <ButtonsSection />
        <ButtonDropdownSection />
        <FormsSection />
        <BadgesSection />
        <ToggleButtonsSection />
        <ListingsSection />
        <DataTableSection />
        <ModalSection />
        <DropdownMenuSection />
        <CalloutSection />
        <BaseStylesSection />
      </main>
    </div>
  </div>
</template>
