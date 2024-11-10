<template lang="pug">
.login
  t-form
    t-form-item
      t-button(type="submit", @click="loginByProvider('developer')")
        | Login by Developer

  form(v-show="false", ref="hiddenForm", :action="auth_path(provider)", method="post")
    input(type="hidden", name="authenticity_token", :value="authenticityToken()")
    button(type="submit")
</template>

<script setup lang="ts">
import { onMounted, ref } from "vue";
import { auth_path } from "@/routes";
import { authenticityToken } from "@/utils/form";
import layout from "@/layouts/minimal.vue";

defineOptions({ layout });

const hiddenForm = ref<HTMLFormElement | null>(null);
const provider = ref<string>('developer');

const loginByProvider = (value: string) => {
  // can't use form.submitForm here because this route returns HTML directly
  provider.value = value;
  hiddenForm.value?.submit();
};
</script>

<style lang="stylus" scoped>
.form
  width 350px
</style>
