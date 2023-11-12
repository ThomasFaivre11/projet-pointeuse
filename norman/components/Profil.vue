<script setup>
import ButtonBlue from './Button-blue.vue';
import users from '../composables/user';
const profilData = reactive({
	username: '',
	password: '',
	email: '',
});

const update_user = async () =>{
  const all_users = await users().get_all_users();
  all_users.forEach(item => {
    if (item.email === profilData.email){
      console.log("user updated")
    }
  })
}
</script>

<template>
	<div class="profil-container">
		<h2>Profil</h2>
		<form>
			<div class="form-data">
				<div class="input-data">
					<input class="text" type="text" required v-model="profilData.username" />
					<div class="underline"></div>
					<label class="text">Identifiant</label>
				</div>
				<div class="input-data">
					<input class="text" type="password" required v-model="profilData.password" />
					<div class="underline"></div>
					<label class="text">Mot de passe</label>
				</div>
			</div>
			<div class="form-data">
				<div class="input-data">
					<input class="text" type="text" required v-model="profilData.email" />
					<div class="underline"></div>
					<label class="text">Email</label>
				</div>
			</div>
			<ButtonBlue text="Modifier" @click="update_user"/>
		</form>
	</div>
</template>

<style lang="scss" scoped>
.profil-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
	min-height: 100vh;
	padding: 20rem;
	padding-top: 100px;

	h2 {
		@include SuisseIntl;
		font-size: 70rem;
		font-weight: 500;
		color: $darkblue;
		margin-bottom: 70rem;
	}

	form {
		.form-data {
			gap: 70rem;
		}
	}
}
</style>
