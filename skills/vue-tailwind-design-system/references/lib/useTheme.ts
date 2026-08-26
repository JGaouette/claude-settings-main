// vue-design-system: theme helper
import { onMounted, onUnmounted, ref, watch, type Ref } from "vue";

const STORAGE_KEY = "vue-ds-theme";

export type Theme = "light" | "dark" | "system";

function getSystemPreference(): "light" | "dark" {
  if (typeof window === "undefined") return "light";
  return window.matchMedia("(prefers-color-scheme: dark)").matches
    ? "dark"
    : "light";
}

export function getStoredTheme(): Theme {
  if (typeof window === "undefined") return "system";
  const stored = window.localStorage.getItem(STORAGE_KEY);
  if (stored === "light" || stored === "dark" || stored === "system")
    return stored;
  return "system";
}

export function applyTheme(theme: Theme) {
  if (typeof document === "undefined") return;
  const resolved = theme === "system" ? getSystemPreference() : theme;
  const root = document.documentElement;
  if (resolved === "dark") root.classList.add("dark");
  else root.classList.remove("dark");
}

export function useTheme(): {
  theme: Ref<Theme>;
  setTheme: (next: Theme) => void;
} {
  // Initialize from the stored choice so the first render already reflects it.
  const theme = ref<Theme>(getStoredTheme());
  let mql: MediaQueryList | null = null;
  const onSystemChange = () => applyTheme("system");

  function bindSystemListener() {
    if (mql) mql.removeEventListener("change", onSystemChange);
    mql = null;
    if (theme.value === "system" && typeof window !== "undefined") {
      mql = window.matchMedia("(prefers-color-scheme: dark)");
      mql.addEventListener("change", onSystemChange);
    }
  }

  onMounted(() => {
    // Reapply on mount in case another tab updated localStorage while this
    // component was unmounted, and to ensure the <html> class is consistent
    // even if the inline boot script in the HTML layout was bypassed.
    theme.value = getStoredTheme();
    applyTheme(theme.value);
    bindSystemListener();
  });

  onUnmounted(() => {
    if (mql) mql.removeEventListener("change", onSystemChange);
  });

  watch(theme, () => bindSystemListener());

  function setTheme(next: Theme) {
    theme.value = next;
    if (typeof window !== "undefined")
      window.localStorage.setItem(STORAGE_KEY, next);
    applyTheme(next);
  }

  return { theme, setTheme };
}
