<script>
import gsap from 'gsap';
import ScrollTrigger from 'gsap/ScrollTrigger';

export default {
	name: 'Home',
	mounted() {
		this.$nextTick(() => {
			gsap.registerPlugin(ScrollTrigger);
			gsap.config({ force3D: true });
			gsap.defaults({ ease: 'none', duration: 0.5 });
		});
	},
};
</script>

<template>
	<div>
		<slot />
	</div>
</template>

<style lang="scss">
html {
	font-size: 1px;

	@include tablet {
		font-size: calc(max(100vw / 1024, 1px));
	}

	@include desktop {
		font-size: calc(max(100vw / 1440, 1px));
	}

	@include large {
		font-size: calc(min(1px, 100vh / 800));
	}
}

form {
	display: flex;
	flex-direction: column;
	gap: 30rem;
	.form-data {
		display: flex;
		gap: 30rem;

		.input-data {
			height: 20rem;
			width: 100%;
			position: relative;
		}

		input {
			height: 100%;
			width: 100%;
			border: none !important;
			border-bottom: 2px solid $darkblue;
		}

		input[type='text'],
		input[type='email'] {
			background: transparent;
			border: none !important;
		}

		input:focus ~ label,
		input:valid ~ label {
			transform: translateY(-17rem);
			color: $darkblue;
		}

		label {
			position: absolute;
			bottom: 6rem;
			left: 0;
			color: $darkblue;
			pointer-events: none;
			transition: all 0.3s ease;
		}

		.underline {
			position: absolute;
			bottom: 0;
			height: 1px;
			width: 100%;
			background: $darkblue;
		}

		.underline:before {
			position: absolute;
			content: '';
			height: 100%;
			width: 100%;
			background: $darkblue;
			transition: transform 0.3s linear;
			transform: scaleX(0);
		}

		input:focus ~ .underline:before,
		input:valid ~ .underline::before {
			transform: scaleX(1);
		}

		.text {
			font-size: 12rem;
			@include SuisseIntl;
		}
	}
}
</style>
