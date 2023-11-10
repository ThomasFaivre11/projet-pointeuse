<script setup lang="ts">
import id_manager_module from '../../composables/user_token';
import token_mod from '../../composables/useAuth';
import get_role from '../../composables/useAuth';

const role = get_role();
import workingtimes from "~/composables/workingtimes";
import workteams from "~/composables/workteams";

const dates = [];
const dataWorkingtimes = reactive([]);
const module_check_token = token_mod();
const module_token = id_manager_module();

async function executeWorkingTime() {
  const token = localStorage.getItem('user_token');
  console.log(token);
  const ok = module_check_token.check_token();
  console.log(ok);
  await module_token.search_id_manager(token);

  // const result = await getWorkingTime("0b13584d-850a-429f-960f-621a488b3793","bd53579a-2c28-4ded-80b6-1ae5c01daf2c");
  /*getWorkingTime('0b13584d-850a-429f-960f-621a488b3793', 'bd53579a-2c28-4ded-80b6-1ae5c01daf2c').then((result) => {
    console.log(result);
  });*/
}


function calculerTempsEcoule(dateDebutStr: string | number | Date, dateFinStr: string | number | Date) {
  const dateDebut = new Date(dateDebutStr);
  const dateFin = new Date(dateFinStr);

  const differenceEnMillisecondes = Math.abs((dateFin as any) - (dateDebut as any));

  const jours = Math.floor(differenceEnMillisecondes / (1000 * 60 * 60 * 24));
  const heures = Math.floor((differenceEnMillisecondes % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  const minutes = Math.floor((differenceEnMillisecondes % (1000 * 60 * 60)) / (1000 * 60));
  const secondes = Math.floor((differenceEnMillisecondes % (1000 * 60)) / 1000);

  return {
    jours,
    heures,
    minutes,
    secondes
  };
}

const formatTime = (hours: number, minutes: number) => {
  const formattedHours = String(hours).padStart(2, '0');
  const formattedMinutes = String(minutes).padStart(2, '0');
  return `${formattedHours}:${formattedMinutes}`;
};

/*
* Afficher le taux de working time (~7h /jours) ⇒ diagramme de colonnes
* => Récupérer les temps de travail de l'équipe
* ===> Récupérer les workingtimes des 7 derniers jours de l'équipe, les trier par jour et calculer les temps de travail moyen.
* ===> Définir une moyenne de travail
* ===> Afficher les colonnes avec une certaine couleur en fonction du taux
* ===> Axe des abscisse : Les jours au format DD/MM
* ===> Axe des ordonnées : sur 10 ou 12h heures
*/
const dataChart = async () => {
  // Variables
  const id_workers = [];
  const team_workingtimes = [];
  const workingtimes_by_dates = [];
  // Récupération de l'équipe du manager :
  const work_team = await workteams().getWorkTeamsByManager(JSON.parse(localStorage.getItem("user_token")).user_id)
  //console.log("les membres de l'équipe : ");
  // Récupération de l'id de chaque membre
  for (const worker of work_team) {
    id_workers.push(worker.worker_id);
  }
  //console.log(id_workers);
  // Récupération des worktimes de chaque id
  const dateRef = new Date();
  const start = new Date();
  start.setDate(start.getDate() -7);
  const end = new Date();
  for (const worker of id_workers) {
    const wt = await workingtimes().getWorkingTime(worker, "", start.toISOString().slice(0, 19), end.toISOString().slice(0, 19));
    // ajouter chaque wt dans le tableau
    if (wt.data.length>0){
      for (const wtElement of wt.data) {
        team_workingtimes.push(wtElement);
      }
    }
  }
  //console.log(team_workingtimes);
  for (let i = 7; i>0 ; i--) {
    const begin = new Date(dateRef);
    begin.setDate(dateRef.getDate() - i);
    //console.log(begin);
    dates.push(begin);
  }
  //console.log(dates);

  var i = 0;
  // Tableau de taille 7 (un pour chaque jour) contenant les wt correspondant
  for (const date of dates) { // Les dates
    const tmp_tab = [];
    for (const wt_element of team_workingtimes) { // Les workingtimes
      const tmp_wt = new Date(wt_element.start);
      //console.log(tmp_wt.getDate());
      //console.log(date.getDay());
      //console.log(wt_element.start.getDate());

      if (tmp_wt.getDate() == date.getDate()){
        tmp_tab.push(wt_element);
      } else {
      }
    }
    workingtimes_by_dates.push(tmp_tab);
    i++;
  }
  //console.log(workingtimes_by_dates);
  // Pour chaque jour calculer les workingtime effectif et faire une moyenne
  for (const day of workingtimes_by_dates) {
    let inc = 0;
    let sommeTemps = { heures: 0, minutes: 0, secondes: 0 };
    for (const wts of day) {
      inc++;
      const temps = calculerTempsEcoule(wts.start, wts.end);
      sommeTemps.heures += temps.heures;
      sommeTemps.minutes += temps.minutes;
      sommeTemps.secondes += temps.secondes;
    }

    if (inc > 0) {
      const moyenneHeures = Math.floor(sommeTemps.heures / inc);
      const moyenneMinutes = Math.floor(sommeTemps.minutes / inc);
      const formattedTime = formatTime(moyenneHeures, moyenneMinutes);
      dataWorkingtimes.push({
        heures: moyenneHeures,
        minutes: moyenneMinutes,
        secondes: Math.floor(sommeTemps.secondes / inc),
        formattedTime,
      });
    } else {
      dataWorkingtimes.push({
        heures: 0,
        minutes: 0,
        secondes: 0,
        formattedTime: '00:00',
      });
    }
  }
  console.log(dataWorkingtimes);

  // Chaque moyenne de travail par jour est contenue dans dataWorktimes
  // Chaque jours dans le même ordre est contenue dans dates
}

const options = ref({
	chart: {
		type: 'bar',
	},
	plotOptions: {
		bar: {
			borderRadius: 10,
			borderRadiusApplication: 'around',
		},
	},
});
const series = ref([
	{
		name: 'Score',
		data: [],
	},
]);
const updateChart = () => {
  options.value = {
    ...options.value,
    xaxis: {
      categories: dates.map(date => date.toLocaleDateString()),
    },
  };

  const seriesData = dataWorkingtimes.map(temps => ({
    x: temps.formattedTime,
    y: decimalToTime(temps.heures + temps.minutes / 60), // Utilisation d'une approche différente pour éviter les décimales
  }));

  series.value = [
    {
      name: 'Moyenne',
      data: seriesData,
    },
  ];
};

function decimalToTime(decimal) {
  const hours = Math.floor(decimal);
  const minutes = Math.round((decimal - hours) * 60);

  // Formatage pour ajouter un zéro en tête si nécessaire
  const formattedHours = String(hours).padStart(2, '0');
  const formattedMinutes = String(minutes).padStart(2, '0');
  console.log(`${formattedHours}:${formattedMinutes}`);
  return `${formattedHours}.${formattedMinutes}`;
}

onMounted(async () => {
  await dataChart();
	updateChart();
});
</script>

<template>
	<div class="dashboard-container">
		<div v-if="this.role === `employee`" class="button-container">
			<button class="clock-button launch">Démarrer</button>
			<button class="clock-button stop">Stop</button>
		</div>
		<h2>Profil</h2>
		<apexchart :key="series" height="400" width="600px" :options="options" :series="series"></apexchart>
		<button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded" @click="updateChart">Change</button>
	</div>
	<button class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded" @click="executeWorkingTime">get manager id</button>
</template>

<style scoped lang="scss">
.dashboard-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
	min-height: 100vh;
	position: relative;
	padding-top: 100px;

	h2 {
		@include SuisseIntl;
		font-size: 70rem;
		font-weight: 500;
		color: $darkblue;
		margin-bottom: 70rem;
	}

	.button-container {
		position: fixed;
		right: 20px;
		top: 20px;
		.clock-button {
			display: flex;
			align-items: center;
			justify-content: center;
			width: 100px;
			height: 50px;
			color: $white;
			background: $darkblue;
			border: solid 1px $darkblue;
			@include SuisseIntl;
			font-size: 12rem;
			transition: color 0.3s linear, background 0.3s linear;

			&.stop {
				background: $white;
				border: solid 1px $darkblue;
				color: $darkblue;

				&:hover {
					color: $white;
					background: $darkblue;
				}
			}

			&:nth-child(1) {
				margin-bottom: 20px;
			}

			&:hover {
				color: $darkblue;
				background: $white;
			}
		}
	}
}
</style>
