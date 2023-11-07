<script setup>
import DashboardElements from '~~/components/DashboardElements.vue';

definePageMeta({
	middleware: ['auth'],
});
</script>

<template>
	<DashboardElements />
</template>

<style lang="scss" scoped></style>
