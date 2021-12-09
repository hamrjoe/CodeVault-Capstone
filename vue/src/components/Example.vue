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
        <b-button v-on:click="toggleAdd" v-if="addingNewExample == false"
          >Add an Example</b-button
        >
        <b-button v-on:click="toggleAdd" v-if="addingNewExample == true"
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


<!-- Add a Card Field -->
      <div class="card" v-if="this.addingNewExample == true">
        <div class="card-block">
          <form action="submit">
            <input type="text" placeholder="Title" v-model="newExample.title" />
            <textarea
              type="text"
              placeholder="Description"
              v-model="newExample.description"
            ></textarea>
            <textarea
              type="text"
              placeholder="Add code here"
              v-model="newExample.code_example"
            ></textarea>
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

        <div class="pillbox">
          <div class="tags" v-for="tag in newExample.tags" v-bind:key="tag.tagId">
            <b-button
              class="tagButton"
              pill
              variant="primary"
              v-on:click="addTagButton(tag)"
              >{{ tag }}</b-button
            >
          </div>
          <div class="tags" v-for="tag in this.retrieveTagsForNew" :key="tag.id">
            <b-button
              class="tagButton"
              variant="primary"
              pill
              v-on:click="addTagButton(tag)"
              >{{ tag }}</b-button
            >
          </div>
        </div>



            <button v-on:click.prevent="">Submit</button>
            <button v-on:click.prevent="toggleAdd">Cancel</button>
          </form>
        </div>
      </div>
  <!-- End Add Example Card -->

<!-- Display all searched cards -->
      <div
        class="card"
        v-for="example in filterSnippets"
        v-bind:key="example.exampleId"
      >
        <div class="card-block">
          <h4 class="card-title">{{ example.title }}</h4>
        </div>
        <div class="card-block">
          <pre>{{ convertFromUTF16(example.codeExample) }}</pre>
        </div>

        <div class="pillbox">
          <b-button
            class="tagButton"
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
      addingNewExample: false,
      tagFilter: "",
      examples: [],
      newExample: {
        title: "",
        description: "",
        exampleId: 0,
        languageName: "",
        userId: 0,
        isPrivate: "",
        isDefault: "",
        attribution: "",
        codeExample: "",
        tags: [],
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
        this.newExample.exampleId = 0;
        this.newExample.languageName = "";
        this.newExample.userId = 0;
        this.newExample.isPrivate = "";
        this.newExample.isDefault = "";
        this.newExample.attribution = "";
        this.newExample.codeExample = "";
        this.newExample.tags = [];
        this.addingNewExample = !this.addingNewExample;
      }
      else {
        this.addingNewExample = !this.addingNewExample;
      }
    },
    retrieveAllTagsMethod() {
      return this.retrieveAllTags;
    }
  },
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
  }, // end of computed
  makeTagList() {
    let test = this.examples;

    return test;
  },
};
</script>

<style >
.searchHeader {
  margin: 4px;
}

.tagButton {
  margin: 2px;
}

pre {
  text-align: left;
  padding: 2px;
  border: 1px solid black;
}
.pillbox {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
}
.card {
  margin: 1rem;
  margin-left: 40%;
  margin-right: 40%;
}
#pillcase {
  display: flex;
  flex-direction: row;
  justify-content: flex-start;
}
