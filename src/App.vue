<script setup>
import CvGenerator from './views/CvGenerator.vue'
</script>

<template>
  <CvGenerator />
</template>

<style scoped>
.cv-wrapper {
  height: 100vh;
}
.logo {
  height: 6em;
  padding: 1.5em;
  will-change: filter;
  transition: filter 300ms;
}
.logo:hover {
  filter: drop-shadow(0 0 2em #646cffaa);
}
.logo.vue:hover {
  filter: drop-shadow(0 0 2em #42b883aa);
}
</style>
