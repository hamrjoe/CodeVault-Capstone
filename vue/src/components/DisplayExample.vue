<template>
  <div>
      <div v-for="example in this.$store.state.examples" v-bind:key="example.example_id">
            <h1>Title: {{example.title}}</h1>
            <pre>Example with pre tag: {{example.code_example}}</pre>             
      </div>
  </div>
</template>

<script>

export default {
    name: "display-example"
}
</script>

<style>
pre {
    white-space: pre-wrap;
}

</style>