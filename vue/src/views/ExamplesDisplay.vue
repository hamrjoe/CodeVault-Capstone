<template>
  <example />
</template>

<script>
import Example from '../components/Example.vue'
export default {
  components: { Example },

}
</script>

<style>
pre {
  text-align: left;
  border: 1px solid black;
}
.pillbox {
    display: flex;
    flex-direction: row;
}
.card {
  margin: 1rem;
  margin-left: 40%;
  margin-right: 40%;
}


</style>