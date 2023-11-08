<script>
import formUser from './formUser.vue';
import workteams from "~/composables/workteams";
import manager_token from "~/composables/user_token";
import TeamUserCard from "~/components/TeamUserCard.vue";
import user from "~/composables/user";

export default {
	components: {
		formUser,
    TeamUserCard,
  },
  data() {
    return {
      workers: [], // Initialisez le tableau workers
      workers_data: [],
    };
  },
  mounted() {
    this.$nextTick(async () => {
      const manager_id = localStorage.getItem("user_token");
      const obj_manager = JSON.parse(manager_id);
      const workers = await workteams().getWorkTeamsByManager(obj_manager.user_id);
      this.workers = workers;
      for (const w of workers) {
        // Récupération de l'username et du status
        this.workers_data.push(await user().getUser(w.worker_id, "", ""));
      }
    });
  },
};
</script>

<template>
	<div class="container-team">
		<h2>Equipes</h2>
    <div class="team">
      <TeamUserCard
          v-for="worker in workers_data"
          :name_user="worker.data.username"
          :status_user="worker.data.status" />
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
