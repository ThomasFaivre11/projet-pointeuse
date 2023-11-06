import check_token from '../composables/useAuth'

export default defineNuxtRouteMiddleware(() => {
	setTimeout(() => {
		console.log('middleware');
		const token = check_token()
		if (token){
			window.location.href = `http://localhost:3000/dashboard`
		}else {
			window.location.href = `http://localhost:3000/`
		}
	}, 0.00001);
});
