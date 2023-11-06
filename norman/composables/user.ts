import { log } from 'unenv/runtime/node/util';

const user = () => {
	const myHeaders = new Headers();
	myHeaders.append('Content-Type', 'application/json');
	let base_url = 'http://localhost:4000/api/users';

	async function createUser(type: string, username: string, password: string, email: string) {
		let creation = false;
		let token = null;
		try {
			const userData = {
				type: `${type}`,
				username: `${username}`,
				password: `${password}`,
				email: `${email}`,
			};
			// console.log(JSON.stringify({ user: userData }));
			const resp = await fetch(base_url, {
				method: 'POST',
				headers: myHeaders,
				body: JSON.stringify({ user: userData }),
			});
			if (resp.ok) {
				const creationResponse = await resp.json();
				console.log('User créé avec succès');
				if (creationResponse["token"]){
					token = creationResponse["token"]
				}else {
					console.log("pas de token")
				}
				creation = true;
			} else {
				throw new Error(`Erreur HTTP! Statut: ${resp.status} \n\n`);
			}
		} catch (e) {
			creation = false
			console.log(e);
			console.log(' Erreur lors de la création d\'un user');
		}

		// @ts-ignore
		return {creation, token};
	}

	async function getUser(id: string, email: string, username: string) {
		try {
			//check data
			if (id != '' && (email == '' || username == '')) {
				base_url += `/${id}`;
			} else if (id == '' && email != '' && username != '') {
				base_url += `?email=${email}&username=${username}`;
			} else {
				console.log('Erreur dans les paramètres');
			}
			const resp = await fetch(base_url, {
				method: 'GET',
			});
			if (resp.ok) {
				console.log('User retourné');
			} else {
				throw new Error(`Erreur HTTP! Statut: ${resp.status}`);
			}
			return await resp.json();
		} catch (e) {
			console.log('Erreur lors de la récupération de l\'user\n' + e);
		}
	}

	async function updateUser(id: string, type: string, username: string, password: string, email: string) {
		try {
			const url = base_url + `/${id}`;
			const userData = {
				type: `${type}`,
				username: `${username}`,
				password: `${password}`,
				email: `${email}`,
			};
			const resp = await fetch(url, {
				method: 'PUT',
				headers: {
					'Content-Type': 'application/json',
				},
				body: JSON.stringify({ user: userData }),
			});
			if (resp.ok) {
				console.log('user updated');
			} else {
				throw new Error(`Erreur HTTP! Statut: ${resp.status}`);
			}
		} catch (e) {
			console.log('Erreur lors de la modification de l\'user\n' + e);
		}
	}

	async function deleteUser(id: string) {
		try {
			const url = base_url + `/${id}`;
			const resp = fetch(url, {
				method: 'DELETE',
			});
			console.log('user deleted');
		} catch (e) {
			console.log('Erreur lors de la suppression de l\'user\n' + e);
		}
	}

	return {
		createUser,
		getUser,
		updateUser,
		deleteUser,
	};
};

export default user;