import { router } from "@inertiajs/vue3";

export function authenticityToken() {
  const metaTags = document.head.querySelectorAll("meta");
  return Array.from(metaTags).find(meta => meta.name === "csrf-token")?.content || "";
};


export function submitForm(method: 'get' | 'post' | 'put' | 'patch' | 'delete', path: string, data: Record<string, string>) {
  router.visit(path, {
    method,
    data: {
      ...data,
      authenticity_token: authenticityToken(),
    },
  });
};

