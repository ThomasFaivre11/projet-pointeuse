<script setup>
import disconnect_button from '../components/disconnect_button.vue'
import DashboardElements from '~~/components/DashboardElements.vue';


definePageMeta({
	middleware: ['auth'],
});

const user = localStorage.getItem("user_token")
console.log(user)
</script>

<template>
  <disconnect_button />
	<DashboardElements />
</template>

<style lang="scss" scoped></style>
