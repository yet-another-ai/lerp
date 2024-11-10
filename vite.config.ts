import { defineConfig } from "vite";
import RubyPlugin from "vite-plugin-ruby";
import vue from "@vitejs/plugin-vue";
import FullReload from "vite-plugin-full-reload";

export default defineConfig({
  plugins: [
    RubyPlugin(),
    vue(),
    FullReload(["config/routes.rb", "app/views/**/*"], { delay: 200 }),
  ],
  resolve: {
    alias: {
      "@": "/app/javascript",
    },
  },
  server: {
    hmr: { clientPort: 3036 },
  },
});
