<script>
import gsap from 'gsap';
import Profil from '@/components/Profil.vue';
import Dashboard from '@/components/Dashboard.vue';
import Team from '@/components/Team.vue';

export default {
	data() {
		return {
			Profil: {
				nav: false,
				page: false,
			},
			Dashboard: {
				nav: true,
				page: true,
			},
			Team: {
				nav: false,
				page: false,
			},
		};
	},
	components: {
		Profil,
		Dashboard,
		Team,
	},
	methods: {
		interloader(profilActive, dasboardActive, teamActive) {
			const tl = gsap.timeline();

			tl.add(() => {
				this.Profil.nav = profilActive;
				this.Dashboard.nav = dasboardActive;
				this.Team.nav = teamActive;
			});
			tl.set(this.$refs.sideBar, { pointerEvents: 'none' });
			tl.set([this.$refs.firstBackground, this.$refs.secondBackground, this.$refs.thirdBackground], { yPercent: 100 });
			tl.set(this.$refs.interloader, { display: 'flex' });
			tl.to([this.$refs.firstBackground, this.$refs.secondBackground, this.$refs.thirdBackground], { yPercent: 0, duration: 1.2, ease: 'power3.inOut', stagger: 0.15 });
			tl.fromTo(this.$refs.logoContainer, { yPercent: -100 }, { yPercent: 0, duration: 1.2, ease: 'power3.inOut' }, 0.3);
			tl.add(() => {
				this.Profil.page = profilActive;
				this.Dashboard.page = dasboardActive;
				this.Team.page = teamActive;
			});
			tl.to([this.$refs.thirdBackground, this.$refs.secondBackground, this.$refs.firstBackground], { yPercent: -100, duration: 1.2, ease: 'power3.inOut', stagger: 0.15 });
			tl.to(this.$refs.logoContainer, { yPercent: 100, duration: 1.2, ease: 'power3.inOut' }, '<');
			tl.set(this.$refs.interloader, { display: 'none' });
			tl.set(this.$refs.sideBar, { pointerEvents: 'all' });
		},
	},
};
</script>

<template>
	<div class="side-bar" ref="sideBar">
		<div class="title">Sophie</div>
		<ul>
			<li :class="{ active: this.Dashboard.nav }" @click="interloader(false, true, false)">
				<span class="line"></span>
				<div class="overflow"></div>
				<span>Dashboard</span>
			</li>
			<li :class="{ active: this.Team.nav }" @click="interloader(false, false, true)">
				<span class="line"></span>
				<div class="overflow"></div>
				<span>Mon Equipe</span>
			</li>
			<li :class="{ active: this.Profil.nav }" @click="interloader(true, false, false)">
				<span class="line"></span>
				<div class="overflow"></div>
				<span>Mon Profil</span>
			</li>
		</ul>
	</div>
	<div class="dashboard-container">
		<Dashboard v-if="this.Dashboard.page" />
		<Team v-if="this.Team.page" />
		<Profil v-if="this.Profil.page" />
		<div class="partial interloader" ref="interloader">
			<div class="background first" ref="firstBackground"></div>
			<div class="background second" ref="secondBackground"></div>
			<div class="background third" ref="thirdBackground">
				<div class="logo-container" ref="logoContainer">
					<div class="logo">SOPHIE</div>
				</div>
			</div>
		</div>
	</div>
</template>

<style lang="scss" scoped>
.side-bar {
	position: fixed;
	top: 0;
	left: 0;
	gap: 50px;
	width: 300rem;
	height: 100vh;
	background: $white;
	box-shadow: 0 0 10rem rgba(0, 0, 0, 0.1);
	.title {
		@include SuisseIntl;
		text-transform: uppercase;
		font-size: 30rem;
		font-weight: 500;
		color: $darkblue;
		margin-top: 50px;
		margin-left: 100rem;
	}

	ul {
		display: flex;
		flex-direction: column;
		gap: 15px;
		list-style-type: none;
		margin: 0;
		padding: 0;
		margin-left: 100rem;
		margin-top: 100px;

		li {
			display: flex;
			align-items: center;
			position: relative;
			gap: 10px;
			margin-right: 10px;
			cursor: pointer;

			&:hover,
			&.active {
				span {
					&.line {
						transform: scaleX(1);
					}
				}
				.overflow {
					width: 30px;
				}
			}
			span {
				@include GT-America;
				display: inline-block;
				font-size: 20px;
				color: $darkblue;

				&.line {
					position: absolute;
					left: 0;
					width: 25px;
					height: 1px;
					background: $darkblue;
					transform: scaleX(0);
					transition: transform 0.4s $in-out-cubic;
					transform-origin: left;
				}
			}
			.overflow {
				width: 0;
				transition: width 0.4s $in-out-cubic;
			}
		}
	}
}
.dashboard-container {
	margin-left: 300rem;
	width: calc(100% - 300rem);
	min-height: 100vh;
	position: relative;
	.partial.interloader {
		z-index: 999;
		width: calc(100% - 300rem);
		// height: calc(100 * var(--vh));
		height: 100vh;
		position: fixed;
		top: 0;
		right: 0;
		overflow: hidden;
		display: none;

		.logo-container {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			display: flex;
			align-items: center;
			justify-content: center;

			.logo {
				color: $white;
				width: fit-content;
				font-size: 100rem;
				@include GT-America;
				color: $white;
				font-weight: 500;
			}
		}

		.first {
			background: $blue;
		}

		.second {
			background: $lightblue;
		}

		.third {
			display: flex;
			align-items: center;
			justify-content: center;
			overflow: hidden;
			z-index: 1;
			position: relative;
			background: $darkblue;
		}

		.background,
		.wrapper {
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
		}
	}
}
</style>
