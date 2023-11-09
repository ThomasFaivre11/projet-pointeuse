<script>
import TeamUserCard from '~/components/TeamUserCard.vue';

export default {
	components: {
		TeamUserCard,
	},
};
</script>

<template>
	<div class="team-container">
		<h3>Nom de la team</h3>
		<div class="manager">nom du manager</div>
		<div class="team">
			<!-- <TeamUserCard v-for="worker in workers_data" :name_user="worker.data.username" :status_user="worker.data.status" /> -->
		</div>
	</div>
</template>

<style scoped lang="scss">
.team-container {
	display: flex;
	align-items: center;
	flex-direction: column;
	gap: 20px;
	@include desktop {
		gap: 30px;
	}

	h3 {
		@include SuisseIntl;
		font-size: 30rem;
		font-weight: 500;
		color: $darkblue;
	}

	.manager {
		@include SuisseIntl;
		font-size: 20rem;
		font-weight: 500;
		color: $darkblue;
	}

	.team {
		display: flex;
		flex-wrap: wrap;
		gap: 20px;
		margin: 0 30px;
	}
}
</style>
