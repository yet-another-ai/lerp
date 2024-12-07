import { FlatCompat } from "@eslint/eslintrc";
import prettier from "eslint-config-prettier";
import pluginVue from "eslint-plugin-vue";
import vueTsEslintConfig from "@vue/eslint-config-typescript";

const eslintrc = new FlatCompat();

export default [
  {
    ignores: ["node_modules/**/*", "public/**/*", "app/javascript/routes.js"],
  },
  prettier,
  ...eslintrc.extends("plugin:vue/vue3-recommended"),
  ...eslintrc.extends("plugin:prettier/recommended"),
  ...eslintrc.extends("plugin:vue-pug/base"),
  ...pluginVue.configs["flat/essential"],
  ...vueTsEslintConfig({
    supportedScriptLangs: { ts: true, js: true, jsx: true, tsx: true },
  }),
  {
    files: ["app/**/*.ts", "app/**/*.vue"],
    rules: {
      "vue/multi-word-component-names": "off",
      "@typescript-eslint/no-unused-vars": [
        "error",
        {
          args: "all",
          argsIgnorePattern: "^_",
          caughtErrors: "all",
          caughtErrorsIgnorePattern: "^_",
          destructuredArrayIgnorePattern: "^_",
          varsIgnorePattern: "^_",
          ignoreRestSiblings: true,
        },
      ],
      "sort-imports": [
        "error",
        {
          ignoreCase: false,
          ignoreDeclarationSort: true,
        },
      ],
    },
  },
];
