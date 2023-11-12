<script>
import Teams from '@/components/crud/Teams.vue';
import Users from '@/components/crud/Users.vue';
import gsap from "gsap";
import ButtonBlue from "~/components/Button-blue.vue";
import utilisateur from '../composables/user';
import equipe from '../composables/workteams';
import workteams from "../composables/workteams";

const workteam = equipe();
const user_module = utilisateur();


const all_utilisateur = reactive(await user_module.get_all_users())


let profilData = reactive({
  action: '',
  username: '',
  email: '',
  password: '',
  type: '',
  name: '',
  manager: '',
  participant: '',
});

export default {
  mounted() {
    window.addEventListener('keydown', this.handleEscape);
  },
  data() {
		return {
			users: true,
			teams: false,
      profilData: profilData,
		};
	},
	methods: {
    async openModifyDialog(profileData){
      if (profilData.action === 'create_user'){
        if (profileData.type !== 'employe' && profileData.type !== 'manager'){
          alert("veuillez vérifier la saisie du role: \n employe OU manager");
        }else {
          await user_module.createUser(profileData.type, profileData.username, profileData.password, profileData.email, '');
        }
      }else {
        const participant = this.traitement_des_participant(profileData.participant)
        const final_object_workteams = await this.traitement_create_team(profileData.manager, participant)
        for (let j = 0; j < final_object_workteams.liste_user.length; j++){
          await workteams().createWorkTeams(profileData.name, final_object_workteams.id_manager, final_object_workteams.liste_user[j]);
        }
      }
      this.close();
    },
    // email_manager, email_participant
    async traitement_create_team(email_manager, email_participant) {
      const obj_total = {
        "id_manager": "",
        "liste_user": [],
      }
      for (const item of all_utilisateur[0]) {
        if (item.email === email_manager) {
          const id_manager_pre = item.id;
          const user_manager = await user_module.getUser(id_manager_pre, "", "");
          console.log(user_manager)
          obj_total.id_manager = user_manager.data.id;
        } else {
          let liste_user = [];
          for (let k = 0; k < email_participant.length; k++){
            if (item.email === email_participant[k]){
             const id_utilisateur = item.id;
             liste_user.push(id_utilisateur)
              obj_total.liste_user = liste_user;
            }
          }
        }
      }
      return obj_total;
    },
    traitement_des_participant(chaine){
      let liste_nom = [];
      if (chaine.includes(",")){
        liste_nom = chaine.split(',').map(nom => nom.trim());
      }else {
        liste_nom.push(chaine)
        return liste_nom
      }
    },
    handleEscape(event) {
      if (event && event.key === 'Escape') {
        this.close();
      }
    },
    open_Window(action){
      profilData.action = action;
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
  <div v-if="profilData.action === 'create_user'">
    <div class="form-user" ref="formContainer">
      <div class="wrapper-close" @click="close" ref="wrapperClose"></div>
      <form  @submit.prevent="addUser" ref="formUser">
        <h2 v-if="profilData.action === 'create_user'">Créer un utilisateur</h2>
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
  </div>

  <div v-if="profilData.action === 'create_team'">
    <div class="form-user" ref="formContainer">
      <div class="wrapper-close" @click="close" ref="wrapperClose"></div>
      <form  @submit.prevent="addUser" ref="formUser">
        <h2 v-if="profilData.action === 'create_team'">Créer une team</h2>
        <div class="form-data">
          <div class="input-data">
            <input class="text" type="text" required v-model="profilData.name" />
            <div class="underline"></div>
            <label class="text">Nom de la team</label>
          </div>
        </div>
        <div class="form-data">
          <div class="input-data">
            <input class="text" type="text" required v-model="profilData.manager" />
            <div class="underline"></div>
            <label class="text">Email du manager</label>
          </div>
        </div>
        <div class="form-data">
          <div class="input-data">
            <input class="text" type="text" required v-model="profilData.participant" />
            <div class="underline"></div>
            <label class="text">Email de l'employe</label>
          </div>
        </div>
        <ButtonBlue text="Créer" @click="this.openModifyDialog(profilData)" />
      </form>
    </div>
  </div>

	<div class="container-crud">
		<h2>CRUD</h2>
		<div class="container-crud-items">
			<div class="container-crud-items-head">
				<div :class="{ active: this.users }" class="container-crud-items-head-item" @click="changeUsers">users</div>
				<div :class="{ active: this.teams }" class="container-crud-items-head-item" @click="changeTeams">teams</div>
				<div class="container-crud-items-head-item" @click="open_Window('create_user')">create user</div>
				<div class="container-crud-items-head-item" @click="open_Window('create_team')">create team</div>
			</div>
			<div class="container-crud-items-data">
				<Users v-if="this.users" />
				<Teams v-if="this.teams" />
			</div>
		</div>
	</div>
</template>

<style scoped lang="scss">
.select {
  width: 100%;
  font-size: 12rem;
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
