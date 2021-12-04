<template>
  <div>
      <div v-for="example in this.$store.state.examples" v-bind:key="example.example_id">
          <h1>Title: {{example.title}}</h1>
         
          
          <code><pre>Example with pre tag: {{example.code_example}}</pre></code>
            <code>Example with code tag: {{example.code_example}}</code>
                 <textarea v-bind:value="example.code_example"> </textarea> 
            <p>Example with regular p tag: {{example.code_example}}</p>
             
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