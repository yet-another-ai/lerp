<template lang="pug">
t-layout
  t-header
    t-head-menu(v-model="pathname", @change="switchRoute")
      template(#logo)
        h2 Lerp
      t-menu-item(:value="root_path()", :router="{}")
        | Home
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
  t-layout.content
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

const pathname = ref(window.location.pathname);

router.on('navigate', (event) => {
  pathname.value = event.detail.page.url;
});

const switchRoute = (value: string) => {
  router.visit(value);
};

const logout = () => submitForm('delete', sessions_path(), {});

onMounted(() => {
  if (!props.current_user)
    router.visit(auth_index_path());
});
</script>

<style lang="stylus" scoped>
.content
  min-height calc(100vh - 120px)
</style>
