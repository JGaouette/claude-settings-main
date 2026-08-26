<script setup lang="ts">
import { ChevronDown } from "lucide-vue-next";
import {
  Button,
  buttonVariants,
  type ButtonVariants,
} from "@/components/ui/button";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { cn } from "@/lib/utils";

defineOptions({ inheritAttrs: false });

const props = withDefaults(
  defineProps<{
    variant?: ButtonVariants["variant"];
    size?: Exclude<ButtonVariants["size"], "icon">;
    /** aria-label for the chevron toggle half. */
    toggleAriaLabel?: string;
    /** Alignment forwarded to the dropdown content. */
    menuAlign?: "start" | "center" | "end";
    /** Extra classes for the action (left) half. */
    class?: unknown;
    /** Extra classes for the toggle (right) half. Defaults to mirror `class`. */
    toggleClass?: unknown;
    /** Extra classes for the outer wrapper. */
    wrapperClass?: unknown;
    disabled?: boolean;
  }>(),
  {
    variant: "primary",
    size: "md",
    toggleAriaLabel: "More actions",
    menuAlign: "end",
  },
);

const emit = defineEmits<{ click: [MouseEvent] }>();
</script>

<template>
  <div :class="cn('btn-dropdown', props.wrapperClass)">
    <Button
      :variant="props.variant"
      :size="props.size"
      :disabled="props.disabled"
      :class="cn('btn-dropdown-action', props.class)"
      @click="emit('click', $event)"
    >
      <slot name="action" />
    </Button>
    <DropdownMenu>
      <DropdownMenuTrigger as-child>
        <button
          type="button"
          :aria-label="props.toggleAriaLabel"
          :disabled="props.disabled"
          :class="
            cn(
              buttonVariants({ variant: props.variant, size: props.size }),
              'btn-dropdown-toggle',
              props.toggleClass ?? props.class,
            )
          "
        >
          <ChevronDown class="h-4 w-4" />
        </button>
      </DropdownMenuTrigger>
      <DropdownMenuContent :align="props.menuAlign">
        <slot />
      </DropdownMenuContent>
    </DropdownMenu>
  </div>
</template>
