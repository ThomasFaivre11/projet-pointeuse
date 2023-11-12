<script>
import useAuth from '@/composables/useAuth';
import user from '../composables/user';
import workteams from "~/composables/workteams";

const user_module = user();

export default {
	data() {
		return {
			role: 'manager',// useAuth().get_role(),
		};
	},
	methods: {
		async upgrade_user(utilisateur) {
      const short_user = utilisateur.data;
      await user_module.updateUser(short_user.id, 'manager', short_user.username, '', short_user.email);
      console.log(utilisateur.data.username);
    },
		async remove_user(utilisateur) {
      console.log(utilisateur.data.id)
      await workteams().delete_user_from_workteam(utilisateur.data.id, this.team_name)
		},
	},
	props: {
		worker: Object,
		name_user: String,
		status_user: String,
    team_name: String,
	},
};
</script>

<template>
	<div class='card'>
		<img src='../assets/images/user_profil.png' alt='image profil' class='profil_img' />
		<div class='name_presence'>
			<h1>{{ name_user }}</h1>
			<p v-if='status_user'>Présent</p>
			<p v-else class='abs'>Absent</p>
		</div>
		<div class='management'>
			<button v-if='this.role !== `employe`'><img src='assets/images/raise_user.png' alt='raise user'
														 class='button_manage' @click='upgrade_user(worker)' />
			</button>
			<button v-if='this.role !== `employe`'><img src='assets/images/remove_user.png' alt='remove user'
														 class='button_manage' @click='remove_user(worker)' /></button>
		</div>
	</div>
</template>

<style scoped lang='scss'>
.management {
	display: flex;
	margin-left: 10px;
	align-items: center;
	justify-content: center;
}

.button_manage {
	width: 30px;
	margin-left: 10px;
}

.profil_img {
	width: 50px;
	height: 100%;
}

.card {
	display: flex;
	border-radius: 15px; /* Ajoutez le bord arrondi ici */
	border: 2px solid $black;
	width: fit-content;
	padding-right: 10px;
}

.name_presence {
	@include GT-America;
	color: $black;
	font-size: 11px;
	padding-top: 5px;
	padding-left: 15px;
}

p {
	color: #1e7e34;
}

p.abs {
	color: red;
}
</style>
