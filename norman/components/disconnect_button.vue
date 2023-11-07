<script setup lang="ts">

</script>

<template>
  <button class="container">
    <img src="../assets/svg/arrow_black.svg"  alt="arrow"/>
    <button class="button-text">Disconnect</button>
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
    background-color: $red;
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
    color: $red;
  }
  img {
    width: 30px;
    height: auto;
  }
}
</style>
