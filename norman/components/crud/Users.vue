<script setup>
import { ref } from 'vue';
import gsap from "gsap";
import ButtonBlue from '@/components/Button-blue.vue';
import utilisateur from '../../composables/user';
import workteams from "~/composables/workteams";


const user_module = utilisateur();
const formUser = ref(null);
const wrapperClose = ref(null);
const formContainer = ref(null);

const profilData = reactive({
  action: '',
	username: '',
	email: '',
	password: '',
  team_name:'',
  utilisateur: Object,
});

const users = reactive(await user_module.get_all_users());

const close = () => {
	const tl = gsap.timeline();
	tl.to(wrapperClose.value, { opacity: 0, duration: 1 });
	tl.to(formUser.value, { yPercent: -100, duration: 1 }, '<');
	tl.to(formUser.value, { opacity: 0, duration: 0.5 }, '<');
	tl.to(formContainer.value, { display: 'none' });
};

const open = (username, email) => {
	const tl = gsap.timeline();
	tl.set(formContainer.value, { display: 'flex' });
	tl.fromTo(formUser.value, { yPercent: -100 }, { yPercent: 0, duration: 1, ease: 'power3.out' });
	tl.to(formUser.value, { opacity: 1, duration: 0.5 }, '<');
	tl.to(wrapperClose.value, { opacity: 0.9, duration: 1 }, '<');
	tl.add(() => {
		profilData.username = username;
		profilData.email = email;
	});
};

const ajouter_team = async (user) => {
  profilData.action = "add";
  profilData.utilisateur = user
  open(profilData.username, profilData.email)
}

const update = async (user) => {
  profilData.action = "update";
  open(user.username, user.email)
}

const openModifyDialog = async (user) => {
  if (profilData.action === "update"){
    const index = users[0].findIndex(u => u.email === user.email);
    users[0][index].email = user.email;
    users[0][index].username = user.username;
    users[0][index].password = user.password;
    await user_module.updateUser( users[0][index].id, users[0][index].type, users[0][index].username, users[0][index].password, users[0][index].email,);
  }else {
    let id_manager = '';
    const all_teams = await workteams().get_all_teams();
    all_teams.forEach(item => {
      if (item.team_name === profilData.team_name){
        id_manager = item.manager.data.id
      }
    })
    if (id_manager !== ''){
      await workteams().createWorkTeams(profilData.team_name, id_manager, profilData.utilisateur.id);
    }
  }
  close()
};


const deleteUser = async (user) => {
  const id_user = user.id;
  const user_connected = await user_module.deleteUser(id_user);
  if (user_connected.status === 500){
    alert("l'utilisateur est déjà connecté")
  }else {
    console.log('Supprimer', user);
    const index = users[0].findIndex(u => u.id === id_user);
    if (index !== -1) {
      users[0].splice(index, 1);
    }
  }
};

</script>


<template>
	<div v-if="profilData.action === 'update'" class="form-user" ref="formContainer">
		<div class="wrapper-close" @click="close" ref="wrapperClose"></div>
		<form ref="formUser" @submit.prevent="addUser">
			<h2>Modifier un utilisateur</h2>
			<div class="form-data">
				<div class="input-data">
					<input class="text" type="text" required v-model="profilData.username" />
					<div class="underline"></div>
					<label class="text">Identifiant</label>
				</div>
			</div>
			<div class="form-data">
				<div class="input-data">
					<input class="text" type="text" required v-model="profilData.email" />
					<div class="underline"></div>
					<label class="text">Email</label>
				</div>
			</div>
			<div class="form-data">
				<div class="input-data">
					<input class="text" type="password" required v-model="profilData.password" />
					<div class="underline"></div>
					<label class="text">Mot de passe</label>
				</div>
			</div>
			<ButtonBlue text="Modifier" @click="openModifyDialog(profilData)" />
		</form>
	</div>


  <div v-if="profilData.action === 'add'" class="form-user" ref="formContainer">
		<div class="wrapper-close" @click="close" ref="wrapperClose"></div>
		<form ref="formUser" @submit.prevent="addUser">
			<h2>Ajouter un user à une team</h2>
			<div class="form-data">
				<div class="input-data">
					<input class="text" type="text" required v-model="profilData.team_name" />
					<div class="underline"></div>
					<label class="text">Nom de la Team</label>
				</div>
			</div>
			<ButtonBlue text="Ajouter" @click="openModifyDialog(profilData)" />
		</form>
	</div>
	<table>
		<caption>
			Table des Users
		</caption>
		<thead>
			<tr>
				<th scope="col">Username</th>
				<th scope="col">Email</th>
				<th scope="col">Type</th>
				<th scope="col">Action</th>
			</tr>
		</thead>
		<tbody>
      <tr v-for="user in users[0]" :key="user.id">
        <td>{{ user.username }}</td>
        <td>{{ user.email }}</td>
        <td>{{ user.type }}</td>
        <td class="button-container">
          <button class="modify-button" @click="update(user)">Modifier</button>
          <button class="delete-button" @click="deleteUser(user)">Supprimer</button>
          <button class="add_button" @click="ajouter_team(user)">Add Team</button>
        </td>
      </tr>
		</tbody>
	</table>
</template>

<style scoped lang="scss">
.form-user {
	flex-direction: column;
	justify-content: center;
	align-items: center;
	width: 100%;
	min-height: 100vh;
	padding: 20rem;
	position: absolute;
	top: 0;
	display: none;
	.wrapper-close {
		position: absolute;
		width: 100%;
		height: 100%;
		background: $black;
		opacity: 0;
		cursor: pointer;
	}
	form {
		background: $white;
		border: 1px solid $darkblue;
		border-radius: 10rem;
		padding: 40rem;
		z-index: 1;
		position: relative;
		opacity: 0;

		h2 {
			@include SuisseIntl;
			font-size: 30rem;
			text-transform: uppercase;
			color: $darkblue;
			margin-bottom: 30px;
		}
		.form-data {
			gap: 70rem;
		}
	}
}

table,
th,
td {
	border: 1px solid $darkblue;
	font-size: 10rem;
	padding: 1rem 2rem;
}
table {
	width: 80%;
	margin: 0 auto;
	border-collapse: collapse;
	@include Staff;
	caption {
		font-size: 15rem;
		font-weight: bold;
		padding: 10rem;
		@include Staff;
		color: $white;
		background: $darkblue;
	}
	thead {
		color: $darkblue;
		font-size: 12rem;
		padding: 20rem;
	}
	.button-container {
		display: flex;
		border: none;
		button {
			width: 100%;
			cursor: pointer;
			font-size: 10rem;
			@include Staff;
			transition: color 0.3s linear, background 0.3s linear;

			&.modify-button {
				border-right: 1px solid $darkblue;
			}
      &.add_button {
				border-left: 1px solid $darkblue;
			}

      &.create-button {
        border-left: 1px solid $darkblue;
      }

			&:hover {
				background-color: $darkblue;
				color: $white;
			}
		}
	}
}
</style>
