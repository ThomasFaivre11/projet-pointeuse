import { log } from 'unenv/runtime/node/util';
import useAuth from './useAuth'

const user = () => {
	const useAuthModule = useAuth();
	const myHeaders = new Headers();
	myHeaders.append('Content-Type', 'application/json');
	let base_url = 'http://localhost:4000/api/users';

	async function createUser(type: string, username: string, password: string, email: string) {
		try {
			const userData = {
				type: `${type}`,
				username: `${username}`,
				password: `${password}`,
				email: `${email}`,
			};
			const resp = await fetch(base_url, {
				method: 'POST',
				headers: myHeaders,
				body: JSON.stringify({ user: userData }),
			});
			if (resp.ok) {
				const creationResponse = await resp.json();
				console.log('User créé avec succès');
				let log = false
				try {
					await useAuthModule.login(email, password)
					log = true;
				}catch (err){
					console.log(err)
					console.log("problème de loggin")
				}
				if (log){
					console.log(`l'utilisateur ${username} est connecté`)
				}else {
					console.log("problème de connexion")
				}
			}
		} catch (e) {
			console.log(e);
			console.log(' Erreur lors de la création d\'un user');
		}
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