// https://v3.nuxtjs.org/api/configuration/nuxt.config
export default defineNuxtConfig({
	ssr: false,
	plugins: [
		{ src: '~/plugins/vue-apexcharts.js', mode: 'client' }
	],
	module: ['@nuxt/ui'],
	css: [`@/assets/scss/fonts.scss`, `@/assets/scss/reset.scss`],
	router: {
		middleware: ['delay'],
	},
	vite: {
		css: {
			preprocessorOptions: {
				scss: {
					additionalData: '@use "@/assets/scss/mixins.scss" as *; @use "@/assets/scss/variables.scss" as *;',
				},
			},
		},
	},
});
