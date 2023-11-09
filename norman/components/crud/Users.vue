<script setup>
import gsap from 'gsap';
import ButtonBlue from '@/components/Button-blue.vue';

const formUser = ref(null);
const wrapperClose = ref(null);
const formContainer = ref(null);

const profilData = reactive({
	username: '',
	email: '',
	password: '',
});

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
</script>

<template>
	<div class="form-user" ref="formContainer">
		<div class="wrapper-close" @click="close" ref="wrapperClose"></div>
		<form ref="formUser" @submit.prevent="addUser">
			<h2>Ajouter un utilisateur</h2>
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
					<input class="text" type="text" required v-model="profilData.password" />
					<div class="underline"></div>
					<label class="text">Mot de passe</label>
				</div>
			</div>
			<ButtonBlue text="Modifier" @click="addUser" />
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
			<!-- Mettre un v-for sur le tr -->
			<tr>
				<td>Greg</td>
				<td>Greg@gmail.com</td>
				<td>Admin</td>
				<td class="button-container">
					<button class="modify-button" @click="open('Greg', 'Greg@gmail.com')">Modifier</button>
					<button class="delete-button">Supprimer</button>
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

			&:hover {
				background-color: $darkblue;
				color: $white;
			}
		}
	}
}
</style>
