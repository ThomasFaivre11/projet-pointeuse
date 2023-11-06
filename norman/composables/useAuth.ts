const useAuth = () => {
	const myHeaders = new Headers();
	myHeaders.append('Content-Type', 'application/json');
	async function login(email: string, password: string){
		const data_type = {
			email: `${email}`,
			password: `${password}`
		}
		try {
			const url = `http://localhost:4000/api/login`;
			const response = await fetch(url, {
				method: "POST",
				headers: myHeaders,
				body: JSON.stringify(data_type),
			});
			if (response.ok){
				const login_response = await response.json()
				const token = login_response["user_token"]
				localStorage.setItem("user_token", token)
				window.location.href = "http://localhost:3000/dashboard"
			}else {
				console.log("problème de requete login")
			}
		}catch (e){
			console.log(e)
		}
	}

	function check_token() {
		const token = localStorage.getItem('user_token');
		return !!token;
	}

	return {
		login,
		check_token
	};
};

export default useAuth;
