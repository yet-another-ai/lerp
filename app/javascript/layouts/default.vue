<template lang="pug">
t-layout
  t-header
    t-head-menu
      template(#logo)
        i-link.logo(:href="root_path()")
          h2 Lerp
      template(#operations)
        t-space
          t-select(:value="props.current_locale", @change="switchLocale")
            t-option(key="en", label="English", value="en")
            t-option(key="zh_CN", label="简体中文", value="zh_CN")
          t-button(variant="text", shape="square")
            template(#icon)
              t-icon(name="search")
          t-button(variant="text", @click="switchRoute(sessions_path())")
            template(#icon)
              t-icon(name="user")
            | {{ current_user?.email }}
          t-button(variant="text", shape="square", @click="logout")
            template(#icon)
              t-icon(name="logout")
  t-layout
    t-aside.sidebar
      t-menu(v-model="pathname", :collapsed="collapsed", @change="switchRoute")
        t-menu-item(:value="root_path()", :router="{}")
          template(#icon)
            t-icon(name="app")
          | {{ t("home") }}
        t-submenu(:title="t('resources.resources')")
          template(#icon)
            t-icon(name="outbox")
          t-menu-item(:value="books_path()", :router="{}")
            template(#icon)
              t-icon(name="book")
            | {{ t("resources.types.book") }}
        template(#operations)
          t-button(variant="text", shape="square", @click="collapsed = !collapsed")
            template(#icon)
              t-icon(v-if="collapsed", name="chevron-right")
              t-icon(v-else, name="chevron-left")
    t-layout
      t-content.content
        slot
      t-footer
        | © {{ new Date().getFullYear() }} Yet Another AI Ltd.
</template>

<script lang="ts" setup>
import { router } from "@inertiajs/vue3";
import { useForm } from "@inertiajs/vue3";
import { onMounted, ref, watch } from "vue";
import { useI18n } from "vue-i18n";

import {
  auth_index_path,
  books_path,
  locale_index_path,
  root_path,
  sessions_path,
} from "@/routes";

const props = defineProps<{
  current_user: {
    id: number;
    email: string;
  };
  current_locale: string;
}>();

const { t, locale } = useI18n();

const collapsed = ref(true);
const pathname = ref(window.location.pathname);
router.on("navigate", (event) => (pathname.value = event.detail.page.url));

const switchRoute = (value: string) => router.visit(value);

const logout = () => useForm({}).delete(sessions_path());

const switchLocale = (locale: string) => {
  useForm({ locale }).patch(locale_index_path());
};

onMounted(() => {
  if (!props.current_user) router.visit(auth_index_path());

  locale.value = props.current_locale;
});

watch(
  () => props.current_locale,
  (value) => {
    locale.value = value;
  },
);
</script>

<style lang="stylus" scoped>
.logo
  text-decoration none
  color inherit

.content
  min-height calc(100vh - 126px)
  padding 20px

.sidebar
  width auto
</style>
