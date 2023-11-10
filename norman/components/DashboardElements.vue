<script>
import gsap from 'gsap';
import Profil from '@/components/Profil.vue';
import Dashboard from '@/components/dashboard/column_graph.vue';
import Team from '@/components/Team.vue';
import Crud from '@/components/Crud.vue';
import useAuth from '@/composables/useAuth';

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
			Crud: {
				nav: false,
				page: false,
			},
			role: useAuth().get_role(),
		};
	},
	mounted: function () {
		if (document.documentElement.clientWidth < 768) {
			gsap.set(this.$refs.sideBar, { xPercent: -110 });
		}
	},
	components: {
		Profil,
		Dashboard,
		Team,
		Crud,
	},
	methods: {
		interloader(profilActive, dasboardActive, teamActive, crudActive) {
			const tl = gsap.timeline();

			tl.add(() => {
				this.Profil.nav = profilActive;
				this.Dashboard.nav = dasboardActive;
				this.Team.nav = teamActive;
				this.Crud.nav = crudActive;
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
				this.Crud.page = crudActive;
			});
			tl.to([this.$refs.thirdBackground, this.$refs.secondBackground, this.$refs.firstBackground], { yPercent: -100, duration: 1.2, ease: 'power3.inOut', stagger: 0.15 });
			tl.to(this.$refs.logoContainer, { yPercent: 100, duration: 1.2, ease: 'power3.inOut' }, '<');
			tl.set(this.$refs.interloader, { display: 'none' });
			tl.set(this.$refs.sideBar, { pointerEvents: 'all' });
		},
		openSideBar() {
			const tl = gsap.timeline();

			tl.to(this.$refs.sideBar, { xPercent: 0, duration: 1, ease: 'power3.inOut' });
		},
		closeSideBar() {
			const tl = gsap.timeline();

			tl.to(this.$refs.sideBar, { xPercent: -110, duration: 1, ease: 'power3.inOut' });
		},
		disconnect() {
			useAuth().disconnect();
		},
	},
};
</script>

<template>
	<div class="icon-menu" @click="openSideBar">
		<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-home">
			<path d="m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" />
			<polyline points="9 22 9 12 15 12 15 22" />
		</svg>
	</div>
	<div class="side-bar" ref="sideBar">
		<div class="relative-container">
			<div class="close-container" @click="closeSideBar">
				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="lucide lucide-x">
					<path d="M18 6 6 18" />
					<path d="m6 6 12 12" />
				</svg>
			</div>
			<div class="title">Sophie</div>
			<ul>
				<li :class="{ active: this.Dashboard.nav }" @click="interloader(false, true, false, false)">
					<span class="line"></span>
					<div class="overflow"></div>
					<span>Dashboard</span>
				</li>
				<li :class="{ active: this.Team.nav }" @click="interloader(false, false, true, false)">
					<span class="line"></span>
					<div class="overflow"></div>
					<span>Mon Equipe</span>
				</li>
				<li :class="{ active: this.Profil.nav }" @click="interloader(true, false, false, false)">
					<span class="line"></span>
					<div class="overflow"></div>
					<span>Mon Profil</span>
				</li>
				<li v-if="this.role !== `employee`" :class="{ active: this.Crud.nav }" @click="interloader(false, false, false, true)">
					<span class="line"></span>
					<div class="overflow"></div>
					<span>CRUD</span>
				</li>
				<li @click="useAuth().disconnect()">
					<span class="line"></span>
					<div class="overflow"></div>
					<span>Déconnexion</span>
				</li>
			</ul>
		</div>
	</div>
	<div class="dashboard-container">
		<Dashboard v-if="this.Dashboard.page" />
		<Team v-if="this.Team.page" />
		<Profil v-if="this.Profil.page" />
		<Crud v-if="this.Crud.page" />
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
.icon-menu {
	position: fixed;
	bottom: 30px;
	left: 30px;
	width: 24px;
	z-index: 1;

	svg {
		stroke: $darkblue;
	}

	@include tablet {
		display: none;
	}
}

.side-bar {
	position: fixed;
	top: 0;
	left: 0;
	gap: 50px;
	width: 300rem;
	height: 100vh;
	background: $white;
	box-shadow: 0 0 10rem rgba(0, 0, 0, 0.1);
	z-index: 2;

	.relative-container {
		position: relative;

		.close-container {
			position: absolute;
			top: -30px;
			right: 30px;
			width: 24px;

			svg {
				stroke: $darkblue;
			}

			@include tablet {
				display: none;
			}
		}
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
}
.dashboard-container {
	background: $white;
	width: 100%;
	min-height: 100vh;
	position: relative;

	@include tablet {
		margin-left: 300rem;
		width: calc(100% - 300rem);
	}
	.partial.interloader {
		z-index: 999;
		width: 100%;
		height: 100vh;
		position: fixed;
		top: 0;
		right: 0;
		overflow: hidden;
		display: none;

		@include tablet {
			width: calc(100% - 300rem);
		}

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
