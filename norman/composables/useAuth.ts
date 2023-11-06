const useAuth = () => {
	// modele url http://localhost:4000/api/users?email=thomas@thomas&username=thomas
	async function login(username: string, email: string, password: string){
		try {
			const url = `http://localhost/api/login`;
			const response = await fetch(url)
		}catch (e){
			console.log(e)
		}
	}
	
	return {};
};

export default useAuth;
