export default defineNuxtRouteMiddleware(() => {
	setTimeout(() => {
		console.log('middleware');
		const token = localStorage.getItem("user_token");
		if (!token){
			console.log(token)
			window.location.href = "http://localhost:3000/"
		}
	}, 0.00001);
});
