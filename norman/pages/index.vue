<!-- home page -->
<script>
import gsap from 'gsap';
import Loader from '@/components/Loader.vue';
import Auth from '@/components/Auth.vue';

export default {
	mounted() {
		this.$nextTick(() => {
			const tl = gsap.timeline();

			tl.fromTo(this.$refs.title, { yPercent: 100 }, { duration: 1.2, yPercent: 0, ease: 'power3.out' }, '+=3.4');
			tl.fromTo(this.$refs.title, { alpha: 0 }, { duration: 0.6, alpha: 1, ease: 'linear' }, '<');
			tl.fromTo([this.$refs.caption], { alpha: 0 }, { duration: 1, alpha: 0.3, ease: 'linear' }, '<+0.6');
			tl.fromTo([this.$refs.circleOne, this.$refs.circleTwo, this.$refs.circleThree], { scale: 0 }, { duration: 1, scale: 1, ease: 'power3.out', stagger: 0.1 }, '<+0.1');
		});
	},
	methods: {
		goToTextimage() {
			const clientHeight = document.documentElement.clientHeight;

			window.scrollTo({
				top: clientHeight,
				behavior: 'smooth',
			});
		},
	},
	components: {
		Loader,
	},
};
</script>

<template>
	<section class="home">
		<Loader />
		<div class="hero">
			<div class="inner-line">
				<h1 ref="title">sophie</h1>
			</div>
			<div ref="caption" class="caption">Meilleure pointeuse 2022</div>
			<div class="circle one" ref="circleOne"></div>
			<div class="circle two" ref="circleTwo"></div>
			<div class="circle three" ref="circleThree" @click="goToTextimage()">
				<svg xmlns="http://www.w3.org/2000/svg" width="30" height="9" viewBox="0 0 30 9" fill="none">
					<path fill-rule="evenodd" clip-rule="evenodd" d="M27.793 5.035H1v-1h26.793l-2.328-2.329.707-.707 3.182 3.182a.499.499 0 0 1 0 .707L26.172 8.07l-.707-.707 2.328-2.328Z" fill="#fff" stroke="#fff" stroke-width=".5" />
				</svg>
			</div>
		</div>
		<Textimage />
		<Auth />
	</section>
</template>

<style lang="scss" scoped>
.hero {
	position: relative;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 100vh;
	width: 100%;
	gap: 50px;
	overflow: hidden;
	.inner-line {
		position: relative;
		overflow: hidden;
		h1 {
			@include SuisseIntl;
			font-size: 70rem;
			color: $darkblue;
			text-transform: uppercase;

			@include tablet {
				font-size: 12vh;
			}

			@include desktop {
				font-size: 20vh;
			}
		}
	}
	.caption {
		@include Staff;
		font-size: 20rem;
		color: $darkblue;
		text-transform: uppercase;
		opacity: 0.3;

		@include tablet {
			font-size: 2vh;
		}

		@include desktop {
			font-size: 3vh;
		}
	}

	.circle {
		position: absolute;
		border-radius: 50%;
		background: $darkblue;
		width: 100rem;
		height: 100rem;

		@include tablet {
			width: 20vh;
			height: 20vh;
		}

		@include desktop {
			width: 40vh;
			height: 40vh;
		}

		&.one {
			top: 0;
			left: 0;
			transform: translate3d(-50%, -50%, 0);
		}

		&.two {
			top: 50%;
			right: 0;
			transform: translate3d(70%, -50%, 0);
		}

		&.three {
			bottom: 0;
			left: 50%;
			transform: translate3d(-50%, 65%, 0);
			border: 1px solid $darkblue;
			cursor: pointer;
			transition: background-color 0.3s linear;

			&:hover {
				background-color: $white;
				svg {
					path {
						fill: $darkblue;
					}
				}
			}
			svg {
				display: none;
				position: absolute;
				left: 50%;
				transform: rotate3d(0, 0, 1, 90deg) translate3d(68%, 45%, 0px);
				width: 50px;
				height: 50px;

				@include desktop {
					display: block;
				}
				path {
					fill: $white;
					transition: fill 0.3s linear;
				}
			}
		}
	}
}
</style>
