export function authenticityToken() {
  const metaTags = document.head.querySelectorAll("meta");
  return (
    Array.from(metaTags).find((meta) => meta.name === "csrf-token")?.content ||
    ""
  );
}
