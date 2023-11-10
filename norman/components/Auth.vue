<script setup>
import classique_button from './classique_button.vue';
import gsap from 'gsap';
import userModule from '/composables/user';
import useAuth from "~/composables/useAuth";

const host = 'localhost'
const url_base = `http://${host}:3000/`
const user = userModule();
const auth = useAuth();
const creation_utilisateur = async () => {
	try {
    await user.createUser('employee', signInData.username, signInData.email, signInData.password, "connexion");
  }catch (e) {
    console.log(e)
  }
};

const log = async () => {
  try {
    console.log(loginData)
    await auth.login(loginData.email, loginData.password);
  }catch (e) {
    console.log(e);
    console.log("problème sur la connexion")
  }
}

const choiceContainerOne = ref(null);
const choiceContainerTwo = ref(null);
const choiceConnexionSection = ref(null);
const choiceCreateSection = ref(null);
const closeButton = ref(null);

const circleOne = ref(null);
const circleTwo = ref(null);
const circleThree = ref(null);

const loginData = reactive({
	email: '',
	password: '',
});

const signInData = reactive({
	username: '',
	password: '',
	email: '',
});

const choiceConnexion = () => {
	const tl = gsap.timeline();
	tl.to(choiceContainerOne.value, { duration: 1, xPercent: -100, pointerEvents: 'none', ease: 'power3.out' });
	tl.to(choiceContainerTwo.value, { duration: 1, xPercent: 100, pointerEvents: 'none', ease: 'power3.out' }, '<');
	tl.to([choiceConnexionSection.value, closeButton.value], { duration: 0.5, opacity: 1, pointerEvents: 'all' });
	tl.to([circleOne.value, circleTwo.value, circleThree.value], {
		duration: 1,
		scale: 1,
		ease: 'power3.out',
		stagger: 0.1,
	}, '<');
};

const choiceCreate = () => {
	const tl = gsap.timeline();
	tl.to(choiceContainerOne.value, { duration: 1, xPercent: -100, pointerEvents: 'none', ease: 'power3.out' });
	tl.to(choiceContainerTwo.value, { duration: 1, xPercent: 100, pointerEvents: 'none', ease: 'power3.out' }, '<');
	tl.to([choiceCreateSection.value, closeButton.value], { duration: 0.5, opacity: 1, pointerEvents: 'all' });
	tl.to([circleOne.value, circleTwo.value, circleThree.value], {
		duration: 1,
		scale: 1,
		ease: 'power3.out',
		stagger: 0.1,
	}, '<');
};

const backIndex = () => {
	const tl = gsap.timeline();
	tl.to([choiceConnexionSection.value, choiceCreateSection.value, closeButton.value], {
		duration: 0.5,
		opacity: 0,
		pointerEvents: 'none',
	});
	tl.to([circleOne.value, circleTwo.value, circleThree.value], {
		duration: 1,
		scale: 0,
		ease: 'power3.out',
		stagger: 0.1,
	}, '<');
	tl.to(choiceContainerOne.value, { duration: 1, xPercent: 0, pointerEvents: 'all', ease: 'power3.out' });
	tl.to(choiceContainerTwo.value, { duration: 1, xPercent: 0, pointerEvents: 'all', ease: 'power3.out' }, '<');
};

</script>

<template>
	<section class='module login'>
		<div class='circle one' ref='circleOne'></div>
		<div class='circle two' ref='circleTwo'></div>
		<div class='circle three' ref='circleThree'></div>
		<div class='choice-container' ref='choiceContainer'>
			<div class='connexion-choice choice-part' ref='choiceContainerOne' @click='choiceConnexion'>
				<h2 class='choice-text'>Connexion</h2>
				<img src='assets/images/connexion.png' alt='connexion' />
			</div>
			<div class='create-choice choice-part' ref='choiceContainerTwo' @click='choiceCreate'>
				<h2 class='choice-text'>Création de compte</h2>
				<img src='assets/images/create.png' alt='create' />
			</div>
		</div>
		<div class='container-login connexion' ref='choiceConnexionSection'>
			<h1>Connexion</h1>
			<form>
				<div class='form-data'>
					<div class='input-data'>
						<input class='text' type='text' required v-model='loginData.email' />
						<div class='underline'></div>
						<label class='text'>Email</label>
					</div>
					<div class='input-data'>
						<input class='text' type='password' required v-model='loginData.password' />
						<div class='underline'></div>
						<label class='text'>Mot de passe</label>
					</div>
				</div>
			</form>
			<classique_button text='Se Connecter' @click='log' />
		</div>
		<div class='container-login create' ref='choiceCreateSection'>
			<h1>Création de compte</h1>
			<form>
				<div class='form-data'>
					<div class='input-data'>
						<input class='text' type='text' id='identifiant' required v-model='signInData.username' />
						<div class='underline'></div>
						<label class='text'>Identifiant</label>
					</div>
					<div class='input-data'>
						<input class='text' type='text' id='email' required v-model='signInData.password' />
						<div class='underline'></div>
						<label class='text'>Email</label>
					</div>
				</div>
				<div class='form-data'>
					<div class='input-data'>
						<input class='text' type='password' id='password' required v-model='signInData.email' />
						<div class='underline'></div>
						<label class='text'>Mot de passe</label>
					</div>
				</div>
			</form>
			<classique_button text='Se Connecter' @click='creation_utilisateur' />
		</div>
		<div class='close-button' @click='backIndex' ref='closeButton'>Retour</div>
	</section>
</template>

<style scoped lang='scss'>
.module.login {
	position: relative;
	height: 100vh;
	display: flex;
	align-items: center;
	justify-content: center;
	overflow: hidden;
	width: 100%;

	.circle {
		position: absolute;
		border-radius: 50%;
		background: $darkblue;
		width: 100rem;
		height: 100rem;

		@include tablet {
			width: 20vh;
			height: 20vh;
		}

		@include desktop {
			width: 40vh;
			height: 40vh;
		}

		&.one {
			top: 20%;
			left: 0;
			transform: translate3d(-70%, -80%, 0) scale(0);
		}

		&.two {
			top: 50%;
			right: 0;
			transform: translate3d(70%, -50%, 0) scale(0);
		}

		&.three {
			bottom: 0;
			left: 50%;
			transform: translate3d(-50%, 65%, 0) scale(0);
		}
	}

	.choice-container {
		display: flex;
		height: 100%;
		width: 100%;

		.choice-part {
			position: relative;
			flex: 1 1 0px;
			cursor: pointer;
			display: flex;
			align-items: center;
			justify-content: center;
			overflow: hidden;

			&:hover {
				img {
					transform: scale3d(1.1, 1.1, 1.1);
					transition: transform 1s $immg-zoomOut;
				}
			}

			.choice-text {
				@include SuisseIntl;
				color: $white;
				font-weight: 500;
				z-index: 1;
				text-align: center;
				font-size: 30rem;

				@include tablet {
					font-size: 5vh;
				}

				@include desktop {
					font-size: 8vh;
				}
			}

			img {
				pointer-events: none;
				position: absolute;
				top: 0;
				left: 0;
				width: 100%;
				height: 100%;
				object-fit: cover;
				transition: transform 0.8s $immg-zoomIn;
			}
		}
	}

	.container-login {
		display: flex;
		flex-direction: column;
		align-items: center;
		position: absolute;
		min-height: 50vh;
		padding: 50px;
		border: solid 1px $darkblue;
		min-width: 70vw;
		border-radius: 20px;
		gap: 40px;
		opacity: 0;
		pointer-events: none;

		@include tablet {
			gap: 50rem;
		}

		@include desktop {
			gap: 70rem;
		}

		h1 {
			@include GT-America;
			font-size: 30rem;
			text-transform: uppercase;
			color: $darkblue;

			@include tablet {
				font-size: 50rem;
			}

			@include desktop {
				font-size: 70rem;
			}
		}
	}

	.close-button {
		font-size: 14rem;
		@include SuisseIntl;
		position: absolute;
		top: 20rem;
		right: 20rem;
		color: $darkblue;
		cursor: pointer;
		pointer-events: none;
		opacity: 0;
	}
}
</style>
