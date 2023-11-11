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
			if (!response.ok) {
				throw new Error(`Erreur HTTP! Statut: ${response.status}`);
			} else {
				console.log('clock envoyé');
			}
			return await response.json();
		} catch (e) {
			console.log(e);
			console.log('problème get du clock');
		}
	}

	async function updateClock(id: string, time: string, status: boolean) {
		try {
			const dynamic_url = url+`/${id}`;
			const clockData = {
				time: `${time}`,
				status: `${status}`
			}
			const response = await fetch(dynamic_url, {
				method: 'PUT',
				headers: {
					'Content-Type': 'application/json',
				},
				body: JSON.stringify({clock: clockData}),

			});
			if (!response.ok) {
				throw new Error(`Erreur HTTP! Statut: ${response.status}`);
			} else {
				console.log('clock mis à jour');
			}
		} catch (e){
			console.log(e);
			console.log("Problème lors de la mise à jour d'un clock !");
		}
	}

	return {
		createClock,
		deleteClock,
		getClockByUser,
		updateClock
	};
};

export default clock;
