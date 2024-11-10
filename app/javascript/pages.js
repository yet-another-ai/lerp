// NOTE: Optimize the SSR bundle by not splitting by page.
const pages = import.meta.env.SSR
  ? import.meta.globEagerDefault("./pages/**/*.vue", { eager: true })
  : import.meta.glob("./pages/**/*.vue", { eager: true });

export async function resolvePage(name) {
  const page = pages[`./pages/${name}.vue`];

  if (!page) {
    throw new Error(
      `Unknown page ${name}. Is it located under Pages with a .vue extension?`,
    );
  }

  page.default.layout = page.default.layout; // This line
  return import.meta.env.SSR ? page : (await page).default;
}
