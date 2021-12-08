<template>
  <div>
    <form>
      <input placeholder="search title" type="text" v-model="filter.title" />
      <input placeholder="search language" type="text" v-model="filter.language" />
      <input placeholder="search by tags" type="text" v-model="filter.tags" />
      <button type="button" class="btn btn-primary">Primary</button>

      
    </form>
    <div v-for="example in filterSnippets" v-bind:key="example.exampleId">
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
      filter: {
        title: '',
        language: '',
        tags: ''
      },
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
    filterSnippets() {

      let filteredExamples = this.examples;

      if (this.filter.title != '') {
        filteredExamples = filteredExamples.filter((example) => 
          example.title
          .toLowerCase()
          .includes(this.filter.title.toLowerCase())
        );
      }

      if (this.filter.language != '') {
        filteredExamples = filteredExamples.filter((example) => 
          example.languageName
          .toLowerCase()
          .includes(this.filter.language.toLowerCase())
        );
      }

      if (this.filter.tags != '') {
          filteredExamples = filteredExamples.filter(example => 
            // return this.tagFilter == '' ? true :  
          example.tags.find(tag => 
          tag == this.filter.tags
          )
      )
      }

      return filteredExamples;
      
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