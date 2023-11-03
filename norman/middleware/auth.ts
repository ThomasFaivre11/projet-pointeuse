export default defineNuxtRouteMiddleware(() => {
	setTimeout(() => {
		console.log('middleware');
	}, 0.00001);
});
