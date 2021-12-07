<template>
  <div>
    <form>
      <input type="text" v-model="tagFilter" />
    </form>
    <div v-for="example in filterSnippetsByTags" v-bind:key="example.exampleId">
      <p class="formatCode">{{ example.title }}</p>
      <pre class="formatCode">{{ convertFromUTF16(example.codeExample) }}</pre>
      <p>{{example.languageName}}</p>
      <p v-for="tag in example.tags" v-bind:key="tag"></p>
      
    </div>


     
   
  </div>
</template>

<script>
import exampleService from "../services/ExampleService.js";
export default {
  name: "example",
  data() {
    return {
      tagFilter: '',
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
    convertFromUTF16(exampleToConvert) {
      const stringToArray = exampleToConvert.split(',');
      return String.fromCharCode.apply(null, stringToArray);
    }


  },
  computed: {
    filterSnippetsByTags() {

      return this.examples.filter(example => {
        return this.tagFilter == '' ? true : example.tags.find(tag => {
          return tag === this.tagFilter
        })
      })
    }
  }
};
</script>

<style>
pre {
  text-align: left;
  border: 1px solid black;
}
</style>