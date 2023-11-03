<script>
import Classique_button from '~/components/classique_button.vue';
import ScrollTrigger from 'gsap/ScrollTrigger';
import gsap from 'gsap';

export default {
	name: 'TextImage',
	components: { Classique_button },
	mounted() {
		this.$nextTick(() => {
			gsap.registerPlugin(ScrollTrigger);
			const tl = gsap.timeline({
				scrollTrigger: {
					trigger: this.$refs.containerImage,
					start: 'top center',
					end: 'bottom center',
				},
			});

			tl.fromTo(this.$refs.image, { scale: 1.2 }, { scale: 1, duration: 1.7, ease: 'power3.out' }, 0);
			tl.fromTo(this.$refs.title, { y: 100 }, { y: 0, duration: 1.2, ease: 'power3.out' }, 0);
			tl.fromTo(this.$refs.title, { alpha: 0 }, { alpha: 1, duration: 0.6 }, 0);
			tl.from(this.$refs.description, { opacity: 0, duration: 1 }, 0.5);
		});
	},
};
</script>

<template>
	<div class="container-image-text" ref="containerImage">
		<div class="container-image">
			<img src="assets/images/img_glass.jpg" alt="glass" ref="image" />
		</div>
		<div class="container-text" ref="containerText">
			<div class="text-titre">
				<h1 ref="title">We go beyond animation</h1>
			</div>
			<div class="text" ref="description">
				<p>
					Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean feugiat nec orci non dictum. Sed condimentum viverra augue at eleifend. Duis in ante a elit semper elementum. Integer hendrerit lacus in scelerisque maximus. <br /><br />Suspendisse porta nec magna non auctor.
					Quisque aliquet nunc nunc, sit amet porta diam sagittis ut
				</p>
			</div>
		</div>
	</div>
</template>

<style scoped lang="scss">
.container-image-text {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background: $darkblue;
	overflow: hidden;
}
img {
	transform-origin: 50% 80%;
	width: 100%;
	height: 100%;
}
.container-image {
	min-width: 45vh;
	height: 100%;

	@include desktop {
		max-width: 60vh;
	}
}
.container-text {
	padding-top: 15vh;
	margin-left: 10vh;
	max-width: 80vh;
	min-width: 40vh;
	height: 100vh;

	.text-titre {
		@include GT-America;
		font-size: 3vw;
		font-weight: 300;
		color: $white;
	}
	.text {
		@include SuisseIntl;
		margin-top: 10vh;
		margin-bottom: 5vh;
		font-size: 2vw;
		color: $white;
		opacity: 0.7;
	}
}
@include mobile-only {
	.container-image-text {
		flex-direction: column;
		height: auto;
	}
	.container-image {
		max-width: 60%;
	}
	.container-text {
		margin-left: 0;
		margin-top: 0;
	}
}
</style>
