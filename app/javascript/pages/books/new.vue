<template lang="pug">
#book
  t-form
    t-form-item(:label="t('resources.name')")
      t-input(v-model="form.name")
    t-form-item(:label="t('resources.description')")
      t-textarea(v-model="form.description")
    t-form-item(:label="t('resources.isbn')")
      t-input(v-model="form.isbn")
    t-form-item
      t-button(@click="create") {{ t("resources.create") }}
</template>

<script lang="ts" setup>
import { ref } from "vue";
import { useI18n } from "vue-i18n";
import { useForm } from "@inertiajs/vue3";

import { books_path } from "@/routes";

const { t } = useI18n();

const form = ref({
  name: "",
  description: "",
  isbn: "",
});

const create = () => {
  useForm({ book: form.value }).post(books_path());
};
</script>
