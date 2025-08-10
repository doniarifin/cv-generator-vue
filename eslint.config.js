import pluginVue from "eslint-plugin-vue";
import globals from "globals";

export default [
  // add more generic rulesets here, such as:
  // js.configs.recommended,
  ...pluginVue.configs["flat/essential"],
  // ...pluginVue.configs['flat/vue2-recommended'], // Use this if you are using Vue.js 2.x.
  {
    rules: {
      // override/add rules settings here, such as:
      "vue/no-unused-vars": "warn",
      "vue/no-use-v-if-with-v-for": "off",
      "vue/require-v-for-key": "off",
      "no-undef": "error",
    },
    languageOptions: {
      sourceType: "module",
      globals: {
        ...globals.browser,
      },
    },
  },
];
