import authModule from '../composables/useAuth'

export default defineNuxtRouteMiddleware(() => {
	setTimeout(() => {
		console.log('middleware');
		const user = authModule()
		const token = user.check_token()
		if (token){
			window.location.href = `http://localhost:3000/dashboard`
		}else {
			window.location.href = `http://localhost:3000/`
		}
	}, 0.00001);
});
