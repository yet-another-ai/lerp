<template lang="pug">
t-layout
  t-header
    t-head-menu
      template(#logo)
        i-link.logo(:href="root_path()")
          h2 Lerp
      template(#operations)
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
      t-menu(v-model="pathname", @change="switchRoute", :collapsed="collapsed")
        t-menu-item(:value="root_path()", :router="{}")
          template(#icon)
            t-icon(name="app")
          | Home
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
import { router } from '@inertiajs/vue3'
import { computed, ref, onMounted, watch } from "vue";

import { root_path, auth_index_path, sessions_path } from "@/routes";
import { submitForm } from "@/utils/form";

const props = defineProps<{
  current_user: {
    id: number;
    email: string;
  };
}>();

const collapsed = ref(true);
const pathname = ref(window.location.pathname);

router.on('navigate', (event) => pathname.value = event.detail.page.url);

const switchRoute = (value: string) => router.visit(value);

const logout = () => submitForm('delete', sessions_path(), {});

onMounted(() => {
  if (!props.current_user)
    router.visit(auth_index_path());
});
</script>

<style lang="stylus" scoped>
.logo
  text-decoration none
  color inherit

.content
  min-height calc(100vh - 126px)

.sidebar
  width auto
</style>
