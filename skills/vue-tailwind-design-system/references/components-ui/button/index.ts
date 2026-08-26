// vue-design-system: button primitive
import { cva, type VariantProps } from "class-variance-authority";

export { default as Button } from "./Button.vue";

export const buttonVariants = cva("btn", {
  variants: {
    variant: {
      primary: "btn-primary",
      secondary: "btn-secondary",
      ghost: "btn-ghost",
      soft: "btn-soft",
      danger: "btn-danger",
      link: "btn-link",
    },
    size: {
      sm: "btn-small",
      md: "",
      lg: "btn-large",
      icon: "btn-icon",
    },
  },
  defaultVariants: {
    variant: "primary",
    size: "md",
  },
});

export type ButtonVariants = VariantProps<typeof buttonVariants>;
