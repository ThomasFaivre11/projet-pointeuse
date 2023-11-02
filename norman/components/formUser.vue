<script setup>
import gsap from 'gsap';
import ButtonBlue from './Button-blue.vue';

const formUser = ref(null);
const wrapperClose = ref(null);
const formContainer = ref(null);
const blueButton = ref(null);

const profilData = reactive({
	username: '',
	password: '',
	email: '',
});

const close = () => {
	const tl = gsap.timeline();
	tl.to(wrapperClose.value, { opacity: 0, duration: 1 });
	tl.to(formUser.value, { yPercent: -100, duration: 1 }, '<');
	tl.to(formUser.value, { opacity: 0, duration: 0.5 }, '<');
	tl.to(blueButton.value, { opacity: 1, duration: 1 }, '<');
	tl.to(formContainer.value, { display: 'none' });
};

const open = () => {
	const tl = gsap.timeline();
	tl.set(formContainer.value, { display: 'flex' });
	tl.fromTo(formUser.value, { yPercent: -100 }, { yPercent: 0, duration: 1, ease: 'power3.out' });
	tl.to(formUser.value, { opacity: 1, duration: 0.5 }, '<');
	tl.to(wrapperClose.value, { opacity: 0.9, duration: 1 }, '<');
	tl.to(blueButton.value, { opacity: 0, duration: 1 }, '<');
};
</script>

<template>
	<div @click="open" class="blue-button-user" ref="blueButton">
		<ButtonBlue text="Ajouter un utilisateur" />
	</div>
	<div class="form-user" ref="formContainer">
		<div class="wrapper-close" @click="close" ref="wrapperClose"></div>
		<form ref="formUser">
			<h2>Ajouter un utilisateur</h2>
			<div class="form-data">
				<div class="input-data">
					<input class="text" type="text" required v-model="profilData.username" />
					<div class="underline"></div>
					<label class="text">Identifiant</label>
				</div>
				<div class="input-data">
					<input class="text" type="text" required v-model="profilData.password" />
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
			<ButtonBlue text="Modifier" />
		</form>
	</div>
</template>

<style scoped lang="scss">
.blue-button-user {
	position: absolute;
	bottom: 30px;
	right: 30px;
	width: fit-content;
}
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
</style>
