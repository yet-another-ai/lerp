import { defineConfig } from "vite";
import RubyPlugin from "vite-plugin-ruby";
import vue from "@vitejs/plugin-vue";
import vueDevTools from "vite-plugin-vue-devtools";
import FullReload from "vite-plugin-full-reload";
import AutoImport from "unplugin-auto-import/vite";
import Components from "unplugin-vue-components/vite";

import { TDesignResolver } from "unplugin-vue-components/resolvers"

export default defineConfig({
  plugins: [
    FullReload(["config/routes.rb", "app/views/**/*"], { delay: 200 }),
    RubyPlugin(),
    vue(),
    vueDevTools(),
    AutoImport({
      resolvers: [
        TDesignResolver({
          library: 'vue-next'
        })
      ]
    }),
    Components({
      resolvers: [
        TDesignResolver({
          library: 'vue-next'
        })
      ],
    }),
  ],
  server: {
    hmr: { clientPort: 3036 },
  },
  build: {
    sourcemap: true,
  },
});
