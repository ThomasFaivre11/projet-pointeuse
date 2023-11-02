<script>
import formUser from './formUser.vue';

export default {
	components: {
		formUser,
	},
};
</script>

<template>
	<div class="container-team">
		<h2>Equipes</h2>
		<formUser />
	</div>
</template>

<style scoped lang="scss">
.container-team {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
	min-height: 100vh;
	padding-top: 100px;

	h2 {
		@include SuisseIntl;
		font-size: 70rem;
		font-weight: 500;
		color: $darkblue;
		margin-bottom: 70rem;
	}
}
</style>
