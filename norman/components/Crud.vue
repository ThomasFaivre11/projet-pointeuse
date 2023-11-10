<script>
import Teams from '@/components/crud/Teams.vue';
import Users from '@/components/crud/Users.vue';
import gsap from "gsap";
import ButtonBlue from "~/components/Button-blue.vue";
import utilisateur from '../composables/user';

const user_module = utilisateur();

const profilData = reactive({
  username: '',
  email: '',
  password: '',
  type: '',
});

export default {
	data() {
		return {
			users: true,
			teams: false,
      profilData: profilData,
		};
	},
	methods: {
    async openModifyDialog(profileData){
      console.log(profileData)
      if (profileData.type !== 'employe' && profileData.type !== 'manager'){
        alert("veuillez vérifier la saisie du role: \n employe OU manager");
      }else {
        await user_module.createUser(profileData.type, profileData.username, profileData.password, profileData.email, '');
      }
      this.close();
    },
    open_Window(){
      const tl = gsap.timeline();
      tl.set(this.$refs.formContainer, { display: 'flex' });
      tl.fromTo(this.$refs.formUser, { yPercent: -100 }, { yPercent: 0, duration: 1, ease: 'power3.out' });
      tl.to(this.$refs.formUser, { opacity: 1, duration: 0.5 }, '<');
      tl.to(this.$refs.wrapperClose, { opacity: 0.9, duration: 1 }, '<');
    },
    close(){
      const tl = gsap.timeline();
      tl.to(this.$refs.wrapperClose, { opacity: 0, duration: 1 });
      tl.to(this.$refs.formUser, { yPercent: -100, duration: 1 }, '<');
      tl.to(this.$refs.formUser, { opacity: 0, duration: 0.5 }, '<');
      tl.to(this.$refs.formContainer, { display: 'none' });
    },
		changeUsers() {
			this.users = true;
			this.teams = false;
		},
		changeTeams() {
			this.users = false;
			this.teams = true;
		},
	},
	components: {
    ButtonBlue,
		Teams,
		Users,
	},
};
</script>

<template>
  <div class="form-user" ref="formContainer">
    <div class="wrapper-close" @click="close" ref="wrapperClose"></div>
    <form  @submit.prevent="addUser" ref="formUser">
      <h2>Créer un utilisateur</h2>
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
      <div class="form-data">
        <div class="input-data">
          <input class="text" type="text" required v-model="profilData.type" />
          <div class="underline"></div>
          <label class="text">Employe / Manager</label>
        </div>
      </div>
      <ButtonBlue text="Créer" @click="this.openModifyDialog(profilData)" />
    </form>
  </div>


	<div class="container-crud">
		<h2>CRUD</h2>
		<div class="container-crud-items">
			<div class="container-crud-items-head">
				<div :class="{ active: this.users }" class="container-crud-items-head-item" @click="changeUsers">users</div>
				<div :class="{ active: this.teams }" class="container-crud-items-head-item" @click="changeTeams">teams</div>
				<div class="container-crud-items-head-item" @click="open_Window('create_user')">create user</div>
			</div>
			<div class="container-crud-items-data">
				<Users v-if="this.users" />
				<Teams v-if="this.teams" />
			</div>
		</div>
	</div>
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


.container-crud {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
	min-height: 100vh;
	padding-top: 100px;
	position: relative;

	h2 {
		@include SuisseIntl;
		font-size: 70rem;
		font-weight: 500;
		color: $darkblue;
		margin-bottom: 70rem;
	}

	&-items {
		margin-top: 60px;
		width: 100%;
		display: flex;
		align-items: center;
		flex-direction: column;

		@include desktop {
			margin-top: 120px;
		}

		&-head {
			display: flex;
			align-items: center;
			border: 1px solid $darkblue;
			width: fit-content;

			&-item {
				@include SuisseIntl;
				padding: 10px 60px;
				cursor: pointer;
				font-size: 12rem;
				color: $darkblue;
				text-transform: uppercase;
				transition: color 0.3s linear, background 0.3s linear;

				&:hover,
				&.active {
					background-color: $darkblue;
					color: $white;
				}

				@include desktop {
					padding: 10px 90px;
				}

				&:nth-child(1) {
					border-right: 1px solid $darkblue;
				}
			}
		}

		&-data {
			margin-top: 60px;
			width: 100%;

			@include desktop {
				margin-top: 120px;
			}
		}
	}
}
</style>
