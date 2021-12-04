<template>
  <div>
    <div v-for="example in examples" v-bind:key="example.exampleId">
      <p class="formatCode">{{ example.title }}</p>
      <pre class="formatCode">{{ addNewLine(example.codeExample) }}</pre>
    </div>
    <form action="submit">
      <input type="text" v-model="newExample.title" />
      <textarea type="text" v-model="newExample.code_example"> </textarea>
      <button v-on:click.prevent="submitCode">press me!</button>
    </form>
    <div
      v-for="example in this.$store.state.examples"
      v-bind:key="example.example_id"
    >
      <h1>Title: {{ example.title }}</h1>
      <pre>{{ example.code_example }}</pre>
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
      newExample: {
        title: "",
        example_id: "",
        language_id: "",
        user_id: "",
        isPrivate: "",
        isDefault: "",
        attribution: "",
        code_example: "",
      },
    };
  },
  created() {
    exampleService.retrieveExamples().then((response) => {
      this.examples = response.data;
    });
  },
  methods: {
    addNewLine(example) {
      return example.replaceAll("\\n", "\n");
    },
    escapeNewLine(example) {
      return example.replaceAll("\\n", "\n");
    },
    submitCode() {
      this.$store.commit("ADD_CODE", this.newExample);
    },
  },
};
</script>

<style>

</style>