# Vite + Vue Router

Add the route to the project's existing routes array. The skill should:

1. Find the file that creates the router. Common locations: `src/router/index.ts`, `src/router.ts`, or an inline `createRouter(...)` in `src/main.ts`.
2. Add this route to the `routes` array (lazy-loaded so the design-system page and its Milkdown dependency don't weigh down the main bundle):

```ts
{
  path: "__ROUTE_PATH__",
  component: () => import("@/components/design-system/DesignSystem.vue"),
},
```

If the routes array can't be located confidently, print the snippet and tell the user to register it manually.

If the project has **no router at all** (a plain single-view Vite + Vue app), tell the user — the design-system page still works if they render `<DesignSystem />` directly, e.g. temporarily in `App.vue`:

```vue
<script setup lang="ts">
import DesignSystem from "@/components/design-system/DesignSystem.vue";
</script>

<template>
  <DesignSystem />
</template>
```
