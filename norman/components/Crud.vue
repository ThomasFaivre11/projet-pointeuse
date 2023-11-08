<script>
import Teams from '@/components/crud/Teams.vue';
import Users from '@/components/crud/Users.vue';

export default {
	data() {
		return {
			users: true,
			teams: false,
		};
	},
	methods: {
		changeUsers() {
			this.users = true;
			this.teams = false;
		},
		changeTeams() {
			this.users = false;
			this.teams = true;
		},
	},
	components: {
		Teams,
		Users,
	},
};
</script>

<template>
	<div class="container-crud">
		<h2>CRUD</h2>
		<div class="container-crud-items">
			<div class="container-crud-items-head">
				<div :class="{ active: this.users }" class="container-crud-items-head-item" @click="changeUsers">users</div>
				<div :class="{ active: this.teams }" class="container-crud-items-head-item" @click="changeTeams">teams</div>
			</div>
			<div class="container-crud-items-data">
				<Users v-if="this.users" />
				<Teams v-if="this.teams" />
			</div>
		</div>
	</div>
</template>

<style scoped lang="scss">
.container-crud {
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 100%;
	min-height: 100vh;
	padding-top: 100px;

	h2 {
		@include SuisseIntl;
		font-size: 70rem;
		font-weight: 500;
		color: $darkblue;
		margin-bottom: 70rem;
	}

	&-items {
		margin-top: 60px;

		@include desktop {
			margin-top: 120px;
		}

		&-head {
			display: flex;
			align-items: center;
			border: 1px solid $darkblue;

			&-item {
				@include SuisseIntl;
				padding: 10px 60px;
				cursor: pointer;
				font-size: 12rem;
				color: $darkblue;
				text-transform: uppercase;
				transition: color 0.3s linear, background 0.3s linear;

				&:hover,
				&.active {
					background-color: $darkblue;
					color: $white;
				}

				@include desktop {
					padding: 10px 90px;
				}

				&:nth-child(1) {
					border-right: 1px solid $darkblue;
				}
			}
		}

		&-data {
			margin-top: 60px;

			@include desktop {
				margin-top: 120px;
			}
		}
	}
}
</style>
