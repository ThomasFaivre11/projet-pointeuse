<script setup lang="ts">
const buttonText = defineProps<{ text: string }>();
</script>

<template>
	<button class="blue-button">
		<span>{{ text }}</span>
	</button>
</template>

<style scoped lang="scss">
.blue-button {
	position: relative;
	font-weight: 500;
	font-size: 12rem;
	color: $darkblue;
	padding: 20px 20px;
	border: 1px solid $darkblue;
	@include GT-America;
	overflow: hidden;
	transition: color 0.4s linear;

	span {
		position: relative;
		display: inline-block;
		z-index: 1;
	}

	&:before {
		content: '';
		position: absolute;
		width: 100%;
		height: 100%;
		background-color: $darkblue;
		top: 0;
		left: 0;
		transform: translate3d(0, 100%, 0);
		transition: transform 0.4s $in-out-quart;
	}

	&:hover {
		color: $white;
		&:before {
			transform: translate3d(0, 0, 0);
		}
	}
}
</style>
