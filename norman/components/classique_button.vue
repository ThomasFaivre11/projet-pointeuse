<script setup lang="ts">
const buttonText = defineProps<{ text: string }>();
</script>

<template>
	<button class="container">
		<img src="../assets/svg/arrow_black.svg" />
		<button class="button-text">{{ text }}</button>
	</button>
</template>

<style lang="scss" scoped>
.container {
	position: relative;
	width: fit-content;
	height: 40px;
	display: flex;
	align-items: center;
	flex-direction: row;
	gap: 10rem;
	cursor: pointer;

	&:before,
	&:after {
		content: '';
		position: absolute;
		width: 100%;
		height: 1px;
		background-color: $darkblue;
		bottom: -2px;
		left: 0;
	}

	&::after {
		transform: scale(0);
		transform-origin: left;
	}

	&::before {
		transform: scale(1);
		transform-origin: right;
	}

	&:hover {
		&:before {
			transform: scale(0);
			transition: transform 0.6s $out-quart;
		}
		&:after {
			transition: transform 0.6s $out-quart 0.35s;
			transform: scale(1);
		}
	}

	.button-text {
		@include GT-America;
		font-weight: 500;
		font-size: 20rem;
		color: $darkblue;
	}
	img {
		width: 30px;
		height: auto;
	}
}
</style>
