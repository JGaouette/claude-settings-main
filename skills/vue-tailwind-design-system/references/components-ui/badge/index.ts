// vue-design-system: badge primitive
import { cva, type VariantProps } from "class-variance-authority";

export { default as Badge } from "./Badge.vue";

export const badgeVariants = cva("badge", {
  variants: {
    tone: {
      neutral: "badge-neutral",
      accent: "badge-accent",
      signal: "badge-signal",
      muted: "badge-muted",
      solid: "badge-solid",
    },
  },
  defaultVariants: {
    tone: "neutral",
  },
});

export type BadgeVariants = VariantProps<typeof badgeVariants>;
