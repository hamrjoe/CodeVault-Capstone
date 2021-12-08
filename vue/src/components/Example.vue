<template>
  <div class="background">
    <div>
    <form>
      <input placeholder="search title" type="text" v-model="filter.title" />
      <input placeholder="search language" type="text" v-model="filter.language" />
      <input placeholder="search by tags" type="text" v-model="filter.tags" />
    

      
    </form>
    <!-- <div v-for="example in filterSnippets" v-bind:key="example.exampleId">
      <p class="formatCode">{{ example.title }}</p>
      <pre class="formatCode">{{ convertFromUTF16(example.codeExample) }}</pre>
      <p>{{example.languageName}}</p>
      <p v-for="tag in example.tags" v-bind:key="tag"></p>
      
    </div> -->
 
     <div class="card" v-for="example in filterSnippets" v-bind:key="example.exampleId">

  <div class="card-block">
    <h4 class="card-title">{{example.title}}</h4>
  
  </div>
  <div class="card-block">
    <pre>{{ convertFromUTF16(example.codeExample) }}</pre>
    </div>

  <div class="pillbox" >
   <b-button pill>{{example.languageName}}</b-button>
  <div class="tags" v-for="tag in example.tags" v-bind:key="tag.tagId">
  <b-button pill variant="primary" >{{tag}}</b-button>
  </div>
 
  </div>
</div>
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
  },
      makeTagList() {
      let test = this.examples
      
      return test
    }
};
</script>

<style >


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