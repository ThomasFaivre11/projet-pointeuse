<script>
import formUser from './formUser.vue';
import workteams from "~/composables/workteams";
import manager_token from "~/composables/user_token";
import TeamUserCard from "~/components/TeamUserCard.vue";

export default {
	components: {
		formUser,
    TeamUserCard,
  },
  data() {
    return {
      workers: [], // Initialisez le tableau workers
    };
  },
  mounted() {
    this.$nextTick(async () => {
      const manager = await manager_token().search_id_manager(localStorage.getItem("user_token"));
      const workers = await workteams().getWorkTeamsByManager(manager);
      this.workers = workers;
    });
  },
};
</script>

<template>
	<div class="container-team">
		<h2>Equipes</h2>
    <div class="team">
      <TeamUserCard name_user="Zeeee" :status_user=true />
    </div>
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
