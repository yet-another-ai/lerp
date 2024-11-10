import "tdesign-vue-next/dist/reset.css";
import "tdesign-vue-next/es/style/index.css";

import { Head, Link, createInertiaApp } from "@inertiajs/vue3";
import { createApp, h } from "vue";
import TDesign from "tdesign-vue-next";

import { resolvePage } from "./pages";

export default function () {
  createInertiaApp({
    resolve: resolvePage,
    progress: {
      delay: 50,
      includeCSS: true,
      showSpinner: true,
    },
    setup({ el, App, props, plugin }) {
      const app = createApp({ render: () => h(App, props) });
      app.use(plugin);
      app.use(TDesign);

      app.component("IHead", Head);
      app.component("ILink", Link);

      app.mount(el);
    },
  });
}
