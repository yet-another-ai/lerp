<template lang="pug">
#resources
  h1 {{ t("resources.resources") }}
  t-form
    t-form-item(:label="t('resources.type')")
      t-select(v-model="form.type")
        t-option(value="book") Book
    t-form-item(:label="t('resources.name')")
      t-input(v-model="form.name")
    t-form-item(:label="t('resources.isbn')", v-if="form.type === 'book'")
      t-input(v-model="form.isbn")
    t-form-item
      t-button(type="primary", @click="submitForm") {{ t("resources.search") }}
</template>

<script lang="ts" setup>
import { reactive } from "vue";
import { useI18n } from "vue-i18n";

const { t } = useI18n();

const form = reactive({
  type: null,
  name: "",
  isbn: "",
});

const submitForm = () => {
  console.log(form);
};
</script>
