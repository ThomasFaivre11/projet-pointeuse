<script setup>
import TeamUserCard from '~/components/TeamUserCard.vue';
import teams_module from '../../composables/workteams';

const module_teams = teams_module();


const teams = reactive(await module_teams.get_all_teams());
console.log(teams)

</script>

<template>
	<div class='container'>
		<div v-for='team in teams' :key='team.team_name' class='team-container'>
			<div class='flex_title'>
				<h3>Team : {{ team.team_name }}</h3>
				<div class='manager'>Nom du manager : {{ team.manager.data.username }}</div>
			</div>
			<div class='team'>
				<TeamUserCard
					v-for='worker in team.participant' :key='worker.id'
					:worker='worker'
					:name_user='worker.data.email'
					:status_user='worker.data.type' />
			</div>
		</div>
	</div>
</template>

<style scoped lang='scss'>
.container {
	display: flex;
	flex-direction: column;
	gap: 50px;
}

.team-container {
	display: flex;
	align-items: center;
	flex-direction: column;
	gap: 20px;
	@include desktop {
		gap: 30px;
	}

	.flex_title {
		display: flex;
		flex-direction: row;
		gap: 20px;
	}

	h3 {
		@include SuisseIntl;
		font-size: 30rem;
		font-weight: 500;
		color: $darkblue;
	}

	.manager {
		@include SuisseIntl;
		font-size: 30rem;
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
