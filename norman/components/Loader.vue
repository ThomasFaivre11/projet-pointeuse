<script>
import gsap from 'gsap';

export default {
	name: 'Loader',
	mounted() {
		this.$nextTick(() => {
			const tl = gsap.timeline();
			tl.fromTo('.word', { yPercent: 100 }, { duration: 1.2, yPercent: 0, stagger: 0.05, ease: 'power3.inOut' });
			tl.to('.word', { yPercent: -100, duration: 1.2, ease: 'power3.inOut', stagger: 0.05 }, '+=0.3');
			tl.to(this.$refs.loader, { yPercent: -100, duration: 0.8, ease: 'power4.out' });
		});
	},
};
</script>

<template>
	<div class="module loader" ref="loader">
		<div class="inner-line">
			<span class="word">S</span>
			<span class="word">O</span>
			<span class="word">P</span>
			<span class="word">H</span>
			<span class="word">I</span>
			<span class="word">E</span>
		</div>
	</div>
</template>

<style lang="scss" scoped>
.module.loader {
	position: fixed;
	display: flex;
	align-items: center;
	justify-content: center;
	top: 0;
	left: 0;
	width: 100%;
	height: 100vh;
	z-index: 1000;
	background-color: $darkblue;
	overflow: hidden;
	pointer-events: none;

	.inner-line {
		overflow: hidden;
		position: relative;
		.word {
			@include GT-America;
			display: inline-block;
			color: $white;
			font-weight: 500;
			font-size: 70rem;
			@include tablet {
				font-size: 7vh;
			}

			@include desktop {
				font-size: 10vh;
			}
		}
	}
}
</style>
