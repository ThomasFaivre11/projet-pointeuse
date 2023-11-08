<script>
import formUser from "~/components/formUser.vue";
import workteams from "~/composables/workteams";
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
      await this.print_team();
    });
  },
  methods:{
    print_team: async function () {
      this.workers = [];
      this.workers_data = [];
      const manager_id = localStorage.getItem("user_token");
      const obj_manager = JSON.parse(manager_id);
      const workers = await workteams().getWorkTeamsByManager(obj_manager.user_id);
      this.workers = workers;
      for (const w of workers) {
        this.workers_data.push(await user().getUser(w.worker_id, "", ""));
      }
    },
    add_user: async function (newValue) {
      console.log("catch catch catch");
      console.log(newValue.user.data[0].username);
      const userToAdd = {
        data: {
          email: newValue.user.data[0].email,
          id: newValue.user.data[0].id,
          password: newValue.user.data[0].password,
          type: newValue.user.data[0].type,
          username: newValue.user.data[0].username
        }
      };
      console.log(userToAdd);
      this.workers_data.push(userToAdd);
    }
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
		<formUser @addUser="add_user"/>
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
