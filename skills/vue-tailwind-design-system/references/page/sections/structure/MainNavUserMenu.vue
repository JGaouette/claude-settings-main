<script setup lang="ts">
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { ThemeToggle } from "@/components/ui/theme-toggle";
import { LogOut, Settings, User } from "lucide-vue-next";

defineProps<{ open: boolean }>();

const email = "you@example.com";
</script>

<template>
  <DropdownMenu>
    <DropdownMenuTrigger as-child>
      <button
        type="button"
        :aria-label="open ? undefined : email"
        :class="
          [
            'group/user relative flex w-full cursor-pointer items-center gap-3 rounded-md text-left text-ink-body hover:bg-surface hover:text-ink-display focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-accent',
            open ? 'px-2 py-2' : 'h-10 justify-center',
          ]
        "
      >
        <span
          class="flex h-7 w-7 shrink-0 items-center justify-center rounded-full bg-accent-faded text-xs font-semibold text-accent"
        >
          Y
        </span>
        <span v-if="open" class="min-w-0 flex-1 truncate text-sm">{{ email }}</span>
        <span
          v-else
          class="pointer-events-none absolute left-full top-1/2 z-50 ml-2 -translate-y-1/2 whitespace-nowrap rounded-md border border-hairline bg-page px-2 py-1 text-xs font-medium text-ink-display opacity-0 shadow-md transition-opacity group-hover/user:opacity-100"
        >
          {{ email }}
        </span>
      </button>
    </DropdownMenuTrigger>
    <DropdownMenuContent side="top" align="start" class="w-56">
      <DropdownMenuLabel class="normal-case tracking-normal">
        <span class="block text-[10px] uppercase tracking-wider text-ink-muted">
          Signed in as
        </span>
        <span class="block truncate text-xs font-medium text-ink-display">
          {{ email }}
        </span>
      </DropdownMenuLabel>
      <DropdownMenuSeparator />
      <DropdownMenuItem><User /> Profile</DropdownMenuItem>
      <DropdownMenuItem><Settings /> Settings</DropdownMenuItem>
      <DropdownMenuSeparator />
      <div class="px-2 py-2"><ThemeToggle block /></div>
      <DropdownMenuSeparator />
      <DropdownMenuItem><LogOut /> Sign out</DropdownMenuItem>
    </DropdownMenuContent>
  </DropdownMenu>
</template>
