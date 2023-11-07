const useAuth = () => {
	const myHeaders = new Headers();
	myHeaders.append('Content-Type', 'application/json');
	async function login(email: string, password: string) {
		const data_type = {
			email: `${email}`,
			password: `${password}`,
		};
		try {
			const url = `http://localhost:4000/api/login`;
			const response = await fetch(url, {
				method: 'POST',
				headers: myHeaders,
				body: JSON.stringify(data_type),
			});
			if (response.ok){
				const login_response = await response.json()
				const user_id = login_response.user.id;
				const type = login_response.user.type;
				const token = login_response.token;
				const obj_data = {
					"token": token,
					"user_id": user_id,
					"type": type,
				}
				localStorage.setItem("user_token", JSON.stringify(obj_data))
				setTimeout(window.location.href = "http://localhost:3000/dashboard",2);
			}else {
				console.log("problème de requete login")
			}
		} catch (e) {
			console.log(e);
		}
	}

	async function disconnect(token: string) {
		try {
			const data_type = {
				token: `${token}`,
			};
			localStorage.setItem('user_token', null);
			const url = 'http://localhost:4000/api/disconnect';
			const resp = await fetch(url, {
				method: 'POST',
				headers: myHeaders,
				body: JSON.stringify(data_type),
			});
			if (resp.ok) {
				localStorage.removeItem('user_token');
				// localStorage.removeItem('user_id');
				// localStorage.removeItem('user_role');
				navigateTo('/');
			}
		} catch (e) {
			console.log(e);
		}
	}

	function check_token() {
		const token = localStorage.getItem('user_token');
		return !!token;
	}

	return {
		login,
		disconnect,
		check_token,
	};
};

export default useAuth;
