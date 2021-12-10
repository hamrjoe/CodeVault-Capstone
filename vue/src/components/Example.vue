<template>
  <div class="background">
    <div>
      <form>
        <input
          class="searchHeader"
          placeholder="search title"
          type="text"
          v-model="filter.title"
        />
        <div>
          <!-- <input class="searchHeader" placeholder="search language" type="text" v-model="filter.language" /> -->

          <div>
            <b-dropdown
              id="dropdown-1"
              :text="
                filter.language == '' ? 'Choose Language' : filter.language
              "
              class="m-md-2"
            >
              <b-dropdown-item
                v-for="language in retrieveAllLanguages"
                :key="language.id"
                v-on:click="languageTagButton(language)"
                >{{ language }}</b-dropdown-item
              >
            </b-dropdown>
          </div>
        </div>

        <!--Show all button -->
        <b-button
          class="searchHeader"
          pill
          v-on:click.prevent="clearSearchInputs"
          >Show All</b-button
        >
        <b-button id="addExampleButton"  v-on:click="toggleAdd" v-if="addingNewExample == false"
          >Add an Example</b-button
        >
        <b-button id="cancelAddExample" v-on:click="toggleAdd" v-if="addingNewExample == true"
          >Cancel Add</b-button
        >
      </form>

      <div id="pillcase">
        <div class="pillbox">
          <div
            class="tags"
            v-for="language in retrieveAllLanguages"
            :key="language.id"
          >
            <b-button
              class="tagButton"
              pill
              v-on:click="languageTagButton(language)"
              >{{ language }}</b-button
            >
          </div>
        </div>
        <div class="tags">
          <div class="tags" v-for="tag in retrieveAllTags" :key="tag.id">
            <b-button
              class="tagButton"
              variant="primary"
              pill
              v-on:click="tagButton(tag)"
              >{{ tag }}</b-button
            >
          </div>
        </div>
      </div>

      <!-- <div v-for="example in filterSnippets" v-bind:key="example.exampleId">
      <p class="formatCode">{{ example.title }}</p>
      <pre class="formatCode">{{ convertFromUTF16(example.codeExample) }}</pre>
      <p>{{example.languageName}}</p>
      <p v-for="tag in example.tags" v-bind:key="tag"></p>
      
    </div> -->

<p v-if=" this.addMessage != '' "></p>


 

  <!-- start all card display -->
       <div class="row row-cols-1 row-cols-md-4 g-4">
         <!-- Add a Card Field -->
         <div class="col" v-if="this.addingNewExample == true">
      <div class="card h-100 " >
        <div class="card-body d-flex flex-column">
          <form class="card-body d-flex flex-column" action="submit">
            <input type="text" class="card-title " placeholder="Title" v-model="newExample.title" />
            <textarea class="card-text"
              type="text"
              placeholder="Description"
              v-model="newExample.description"
            ></textarea>
            <textarea
              type="text"
              class="d-card-text overflow: auto"
              placeholder="Add code here"
              v-model="newExample.codeExample"
            ></textarea>
            <input type="text" placeholder="Attribution" v-model="newExample.attribution" />
          <div>
            <b-dropdown
              id="dropdown-1"
              :text="
                newExample.languageName == '' ? 'Choose Language' : newExample.languageName
              "
              class="m-md-2"
            >
              <b-dropdown-item
                v-for="language in retrieveAllLanguages"
                :key="language.id"
                v-on:click="addLanguageButton(language)"
                >{{ language }}</b-dropdown-item
              >
            </b-dropdown>
          </div>
 <!-- <p>Selected</p> -->
        <div class="pillbox ">
         
          <div class="tags" v-for="tag in newExample.tags" v-bind:key="tag.tagId">
            <b-button
              class="tagButton btn opacity-100"
              pill
              variant="primary"
              v-on:click="addTagButton(tag)"
              >{{ tag }}</b-button
            >
          </div>
        </div>
         <!-- <p>Available Tags</p> -->
           <div class="pillbox">
          <div class="tags" v-for="tag in this.retrieveTagsForNew" :key="tag.id">
            <b-button
              class="tagButton opacity-50"
              variant="primary"
              pill
              v-on:click="addTagButton(tag)"
              >{{ tag }}</b-button
            >
          </div>
        </div>

            
            <div class="d-flex flex-row  justify-content-center">
            <!-- <input type="checkbox" v-model="newExample.isPrivate" /> -->
            <b-button class="tagButton opacity-100 flex-fill" v-on:click="togglePrivate" v-if="newExample.isPrivate == true">Make Public</b-button>
            <b-button class="tagButton opacity-50 flex-fill " v-on:click="togglePrivate" v-if="newExample.isPrivate == false">Make Private</b-button>
            <b-button class="tagButton flex-fill btn btn-dark" v-on:click.prevent="toggleAdd">Cancel</b-button>
            <b-button class="tagButton flex-fill btn btn-danger" v-on:click.prevent="submitNewExample">Submit</b-button>
           
            </div>
          </form>
        </div>
        </div>
      </div>
 <!-- End Add Example Card -->


<!-- Display all searched cards -->

      <div
        class="col" 
        v-for="example in filterSnippets"
        v-bind:key="example.exampleId" 
      >  
      <div class="card h-100">
        <div class="card-body d-flex flex-column">
          <h4 class="card-title">{{ example.title }}</h4>
            <p class="card-text">description placeholder</p>
       
          <pre class="codeDisplay border border-primary overflow-auto">{{ convertFromUTF16(example.codeExample) }}</pre>

          <p class="card-text">{{example.attribution}}</p>
          
      
        <div class="d-flex align-items-end mt-auto" >
          <b-button
            class="tagButton "
            pill
            v-on:click="languageTagButton(example.languageName)"
            >{{ example.languageName }}</b-button
          >
          <div class="tags" v-for="tag in example.tags" v-bind:key="tag.tagId">
            <b-button
              class="tagButton"
              pill
              variant="primary"
              v-on:click="tagButton(tag)"
              >{{ tag }}</b-button
            >
          </div>
        </div>
        </div>
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
        title: "",
        language: "",
        tags: "",
        searchedTags: [],
      },
      addMessage: "",
      addingNewExample: false,
      tagFilter: "",
      examples: [],
      newExample: {
        title: "",
        description: "",
        tags: [],
        exampleId: 0,
        languageName: "",
        languageId: 0,
        codeExample: "",
        isPrivate: "",
        attribution: "",
        isDefault: "",
        userId: 0,
      },
    };
  }, // End of data
  created() {
    exampleService.retrieveExamples().then((response) => {
      this.examples = response.data;
    });
  }, //End of created
  methods: {
    convertFromUTF16(exampleToConvert) {
      const stringToArray = exampleToConvert.split(",");
      return String.fromCharCode.apply(null, stringToArray);
    },
    languageTagButton(languageOnButton) {
      this.filter.language = languageOnButton;
    },
    tagButton(tagOnButton) {
      this.filter.tags = tagOnButton;
    },
    addTagButton(tagOnButton) {
      if (this.newExample.tags.includes(tagOnButton)) {
        const index = this.newExample.tags.indexOf(tagOnButton);
        this.newExample.tags.splice(index,1);
      }
      else {
        this.newExample.tags.push(tagOnButton);
      }
    },
    addLanguageButton(languageOnButton) {
      this.newExample.languageName = languageOnButton;
    },
    clearSearchInputs() {
      (this.filter.title = ""),
        (this.filter.language = ""),
        (this.filter.tags = ""),
        (this.filter.searchedTags = []);
    },
    toggleAdd() {
      if (this.addingNewExample) {
        this.newExample.title = "";
        this.newExample.description = "";
        this.newExample.tags = [];
        this.newExample.languageName = "";
        this.newExample.languageId = 0;
        this.newExample.exampleId = 0;
        this.newExample.codeExample = "";
        this.newExample.isPrivate = "";
        this.newExample.attribution = "";
        this.newExample.isDefault = "";
        this.newExample.userId = 0;
        this.addingNewExample = !this.addingNewExample;
      }
      else {
        this.addingNewExample = !this.addingNewExample;
      }
    },
    retrieveAllTagsMethod() {
      return this.retrieveAllTags;
    },
    togglePrivate() {
      this.newExample.isPrivate = !this.newExample.isPrivate;
    },
    submitNewExample() {
      // Data Validation

      // Convert Code to UTF16
      let exampleToSubmit = Object.assign({}, this.newExample);
      let bufferArray = new ArrayBuffer(exampleToSubmit.codeExample.length*2);
      let convertedCode = new Uint16Array(bufferArray);
      for (let i=0; i < exampleToSubmit.codeExample.length; i++) {
        convertedCode[i] = exampleToSubmit.codeExample.charCodeAt(i);
      }
      exampleToSubmit.codeExample = convertedCode.join(',');
      // Send new Example to Database
      exampleService.addExample(exampleToSubmit).then( (response) => {
        this.toggleAdd();
        if (response.status == 201) {
          exampleService.retrieveExamples().then((response) => {
            this.examples = response.data;
          });
        }
      }).catch( error => {
        console.log(error);
      });
    }
  }, // End of methods
  computed: {
    filterSnippets() {
      let filteredExamples = this.examples;

      if (this.filter.title != "") {
        filteredExamples = filteredExamples.filter((example) =>
          example.title.toLowerCase().includes(this.filter.title.toLowerCase())
        );
      }

      if (this.filter.language != "") {
        filteredExamples = filteredExamples.filter(
          (example) =>
            example.languageName.toLowerCase() ===
            this.filter.language.toLowerCase()
        );
      }

      if (this.filter.tags != "") {
        filteredExamples = filteredExamples.filter((example) =>
          // return this.tagFilter == '' ? true :
          example.tags.find((tag) => tag == this.filter.tags)
        );
      }

      return filteredExamples;
    },
    retrieveAllTags() {
      let allTags = [];
      this.examples.forEach((example) => {
        example.tags.forEach((tag) => {
          if (allTags.includes(tag) === false) {
            allTags.push(tag);
          }
        });
      });

      return allTags;
    },
    retrieveTagsForNew() {
      const newExampleTags = this.newExample.tags;
      let newTags = this.retrieveAllTagsMethod();
      newTags = newTags.filter( (tag) => 
        !newExampleTags.includes(tag)
      );
      return newTags;
    },
    retrieveAllLanguages() {
      let allLanguages = [];
      this.examples.forEach((example) => {
        if (allLanguages.includes(example.languageName) === false)
          allLanguages.push(example.languageName);
      });

      return allLanguages;
    },
  }, // End of computed
  makeTagList() {
    let test = this.examples;

    return test;
  },
};
</script>

<style scoped >
.background {
  margin-left: 2%;
  margin-right: 2%;
}
pre {
  max-height: 10rem;
}

.searchHeader {
  margin: 4px;
}

.tagButton {
  margin: 2px;
}

.codeDisplay {
  text-align: left;
  padding: 2px;
  border: 10px solid black;
  overflow: auto;
}
/* .pillbox {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
}

#pillcase {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
} */
form {
  color: cyan;

}

.pillbox {
    display: flex;
    flex-direction: row;
}

#addExampleButton {
  background: #a81c56
}

#cancelAddExample {
  background: #0bcc7c
}
</style>



