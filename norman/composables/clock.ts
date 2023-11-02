const clock = () => {
	let url = 'http://localhost:4000/api/clocks';

	async function createClock(user_id: string, time: string, status: boolean) {
		try {
			const dynamic_url = url+`/${user_id}`;
			const clockData = {
				time: `${time}`,
				status: `${status}`
			}
			const response = await fetch(dynamic_url, {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
				},
				body: JSON.stringify({clocks: clockData}),
			});
			if (!response.ok) {
				throw new Error(`Erreur HTTP! Statut: ${response.status}`);
			} else {
				console.log('clock créer :)');
			}
		} catch (error) {
			console.log(error);
			console.log("problème de création d'un clock !");
		}
	}

	async function deleteClock(clock_id: string) {
		try {
			const dynamic_url = url+`/${clock_id}`;
			const response = await fetch(dynamic_url, {
				method: 'DELETE',
			});
			response.ok? console.log('clock est delete') : console.log('clock non delete ! Une erreur est survenue');
		} catch (e) {
			console.log(e);
			console.log('problème delete du clock');
		}
	}

	async function getClockByUser(user_id: string) {
		try {
			const dynamic_url = url+`/${user_id}`;
			const response = await fetch(dynamic_url, {
				method: 'GET',
			});
			let res = await response.json();
			response.ok? console.log('clock est get\n'+res.data) : console.log('problème get du clock : '+response);
			return
		} catch (e) {
			console.log(e);
			console.log('problème get du clock');
		}
	}

	return {
		createClock,
		deleteClock,
		getClockByUser,
	};
};

export default clock;
