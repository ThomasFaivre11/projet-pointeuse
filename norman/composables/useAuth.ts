const useAuth = () => {
	// modele url http://localhost:4000/api/users?email=thomas@thomas&username=thomas
	async function login(username: string, email: string, password: string) {
		try {
			const url = `http://localhost/api/login`;
			const response = await fetch(url);
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
		check_token,
	};
};

export default useAuth;
