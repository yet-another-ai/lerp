import layout from "./layouts/default.vue";

// eslint-disable-next-line @typescript-eslint/no-explicit-any
const pages: Record<string, any> = import.meta.glob("./pages/**/*.vue", {
  eager: true,
});

export async function resolvePage(name: string) {
  const page = pages[`./pages/${name}.vue`];

  if (!page) {
    throw new Error(
      `Unknown page ${name}. Is it located under Pages with a .vue extension?`,
    );
  }

  page.default.layout = page.default.layout || layout;
  return page;
}
