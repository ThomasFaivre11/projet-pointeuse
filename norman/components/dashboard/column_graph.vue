<script setup lang="ts">
import id_manager_module from '../../composables/user_token';
import token_mod from '../../composables/useAuth';

const module_check_token = token_mod();
const module_token = id_manager_module();
async function executeWorkingTime() {
	const token = localStorage.getItem('user_token');
	console.log(token);
	const ok = module_check_token.check_token();
	console.log(ok);
	await module_token.search_id_manager(token);

	// const result = await getWorkingTime("0b13584d-850a-429f-960f-621a488b3793","bd53579a-2c28-4ded-80b6-1ae5c01daf2c");
	getWorkingTime('0b13584d-850a-429f-960f-621a488b3793', 'bd53579a-2c28-4ded-80b6-1ae5c01daf2c').then((result) => {
		console.log(result);
	});
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
	//generate array of random numbers of length 10
	const data = Array.from({ length: 10 }, () => Math.floor(Math.random() * 10));
	options.value = {
		...options.value,
		xaxis: {
			categories: Array.from({ length: 10 }, (_, i) => new Date().getFullYear() - i), // array of last 10 years
		},
	};
	series.value = [
		{
			name: 'Score',
			data: data,
		},
	];
};
onMounted(() => {
	updateChart();
});
</script>

<template>
	<div class="dashboard-container">
		<div class="button-container">
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
		left: 20px;
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
