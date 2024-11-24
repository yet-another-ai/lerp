<template lang="pug">
#resources
  h1 {{ t("resources.types.book") }}
  t-form
    t-form-item
      t-button(theme="primary", @click="create") {{ t("resources.create") }}
    t-form-item(:label="t('resources.name')")
      t-input(v-model="form.name")
    t-form-item(:label="t('resources.isbn')")
      t-input(v-model="form.isbn")
    t-form-item
      t-space
        t-button(theme="primary", @click="submit") {{ t("resources.search") }}
        t-button(theme="warning", @click="reset") {{ t("resources.reset") }}
  t-table.table(:data="books", row-key="id", :columns="columns", stripe)
</template>

<script lang="tsx" setup>
import { router } from '@inertiajs/vue3'
import { ref, reactive } from "vue";
import { useI18n } from "vue-i18n";
import type { TableProps } from 'tdesign-vue-next';

import { submitForm } from "@/utils/form";
import type { Book, BookSearch } from "@/types";
import { books_path,new_book_path } from "@/routes";

const { t } = useI18n();

const props = defineProps<{
  books: Book[];
}>();

const form = reactive<BookSearch>({
  name: "",
  isbn: "",
});

const columns = ref<TableProps["columns"]>([
  { title: t("resources.name"), colKey: "name" },
  { title: t("resources.isbn"), colKey: "isbn" },
  { title: t("resources.description"), colKey: "description" },
  { cell: (h, { row }) => {
    return (<t-button>Inspect</t-button>);
  }},
]);

const submit = () => {
  submitForm("get", books_path(), { search_params: form });
};

const reset = () => {
  form.name = "";
  form.isbn = "";
};

const create = () => {
  router.visit(new_book_path());
};
</script>

<style lang="stylus" scoped>
.table
  margin-top: 2rem
</style>
