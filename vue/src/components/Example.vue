<template>
  <div>
    <div v-for="example in examples" v-bind:key="example.exampleId">
      <p class="formatCode">{{ example.title }}</p>
      <pre class="formatCode">{{ addNewLine(example.codeExample) }}</pre>
      <code class="formatCode">Example with code tag: {{ example.codeExample }}</code>
      <textarea class="formatCode" v-bind:value="example.codeExample"> </textarea>
      <textarea class="formatCode" v-bind:value="addNewLine(example.codeExample)" ></textarea>
    </div>
  </div>
</template>

<script>
import exampleService from "../services/ExampleService.js";
export default {
  name: "example",
  data() {
    return {
      examples: [],
    };
  },
  created() {
    exampleService.retrieveExamples().then((response) => {
      this.examples = response.data;
    });
  },
  methods: {
      addNewLine(example) {
          return example.replaceAll('\\n', '\n')
          
      }
  },
};
</script>

<style>
.formatCode {
  white-space: pre-wrap;
}
</style>