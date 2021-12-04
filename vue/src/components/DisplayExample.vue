<template>
  <div>
      <div v-for="example in this.$store.state.examples" v-bind:key="example.example_id">
          <h1>Title: {{example.title}}</h1>
          <p>Example Code Display: {{example.code_example}}</p>
      </div>
  </div>
</template>

<script>

export default {
    name: "display-example"
}
</script>

<style>

</style>