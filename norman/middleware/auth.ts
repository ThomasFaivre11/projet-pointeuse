import useAuth from '../composables/useAuth';

export default defineNuxtRouteMiddleware((to, from) => {
	const token = useAuth().check_token();

	if (!token) {
		return navigateTo('/');
	}
});
