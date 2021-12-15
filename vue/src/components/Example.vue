<template>
  <div class="background">
    <div class="top">
      <div class="d-flex row row-cols-1 row-cols-md-3 g-3">
      <form class="d-flex flex-row justify-content-end">
        <input
          class="searchHeader flex-grow"
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
              variant="primary"
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
          variant="secondary"
          pill
          v-on:click.prevent="clearSearchInputs"
          >Show All</b-button
        >
        <b-button
          class="searchHeader"
          v-if="isLoggedIn == true"
          v-bind:variant="filter.isFavorited == true ? 'warning' : 'light'"
          pill
          v-on:click.prevent="toggleFavorite"
          >Favorites <font-awesome-icon icon="star"></font-awesome-icon>
        </b-button>
      </form>

      <div class="d-flex flex-row justify-content-end">
        <h3 id="tagHeader">Search By Tags:</h3>
      </div>
      <div id="pillcase">
        <div class="pillbox d-flex flex-row flex-wrap justify-content-end">
          <div
            class="tags"
            v-for="language in retrieveAllLanguages"
            :key="language.id"
          >
            <b-button
              class="tagButton"
              variant="primary"
              pill
              v-on:click="languageTagButton(language)"
              >{{ language }}</b-button
            >
          </div>
        </div>
        <div class="tags d-flex flex-row flex-wrap justify-content-end">
          <div class="tags" v-for="tag in retrieveAllTags" :key="tag.id">
            <b-button
              class="tagButton"
              variant="info"
              pill
              v-on:click="tagButton(tag)"
              >{{ tag }}</b-button
            >
          </div>
        </div>
      </div>

      <div class="d-flex flex-row justify-content-start">
        <b-button
          id="addExampleButton"
          class="tagButton btn btn-success"
          v-on:click="toggleAdd"
          v-if="addingNewExample == false && isLoggedIn == true"
          >Add an Example</b-button
        >
        <b-button
          class="tagButton btn btn-danger"
          v-on:click="toggleAdd"
          v-if="addingNewExample == true && isLoggedIn == true"
          >Cancel Add</b-button
        >
      </div>
      </div>
     

      <b-button
        class="tagButton btn btn-danger"
        v-if="this.addMessage != ''"
        v-on:click="clearMessages"
        >{{ this.addMessage }}</b-button
      >
      <b-button
        class="tagButton btn btn-success"
        v-if="this.addGoodMessage != ''"
        v-on:click="clearMessages"
        >{{ this.addGoodMessage }}</b-button
      >
      <b-button class="tagButton btn btn-danger" v-if="deleteMessage != ''">
        {{ this.deleteMessage }}</b-button
      >
      <b-button
        class="tagButton btn btn-dark"
        v-if="deleteMessage != ''"
        v-on:click="deleteExampleCancel"
      >
        Cancel</b-button
      >
      <b-button
        class="tagButton btn btn-danger"
        v-if="deleteMessage != ''"
        v-on:click="deleteExampleConfirm"
        >Confirm Delete</b-button
      >

      <!-- start all card display -->
      <div id="allCards" class="row row-cols-1 row-cols-md-3 g-3">
        <!-- Add a Card Field -->
        <div class="col" v-if="this.addingNewExample == true">
          <div class="card h-100">
            <div class="card-body d-flex flex-column">
              <form class="card-body d-flex flex-column" action="submit">
                <input
                  type="text"
                  class="card-title"
                  placeholder="Title"
                  v-model="newExample.title"
                />
                <textarea
                  class="card-text"
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
                <input
                  type="text"
                  placeholder="Attribution"
                  v-model="newExample.attribution"
                />
                <div>
                  <b-dropdown
                    id="dropdown-1"
                    variant="primary"
                    :text="
                      newExample.languageName == ''
                        ? 'Choose Language'
                        : newExample.languageName
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
                <p class="labelText">Add/Remove Tags</p>
                <div
                  class="pillbox d-flex flex-wrap flex-row justify-content-start"
                >
                  <div
                    class="tags"
                    v-for="tag in newExample.tags"
                    v-bind:key="tag.tagId"
                  >
                    <b-button
                      class="tagButton btn opacity-100"
                      pill
                      variant="info"
                      v-on:click="addTagButton(tag)"
                      >{{ tag }}</b-button
                    >
                  </div>
                </div>
                <!-- <p>Available Tags</p> -->
                <div
                  class="pillbox d-flex flex-wrap flex-row justify-content-start"
                >
                  <div
                    class="tags"
                    v-for="tag in this.retrieveTagsForNew"
                    :key="tag.id"
                  >
                    <b-button
                      class="tagButton opacity-50"
                      variant="info"
                      pill
                      v-on:click="addTagButton(tag)"
                      >{{ tag }}</b-button
                    >
                  </div>
                </div>

                <div class="d-flex flex-row justify-content-center">
                  <b-button
                    class="tagButton opacity-50 flex-fill"
                    v-on:click="togglePrivate"
                    v-if="newExample.privateExample == true"
                    >Make Public</b-button
                  >
                  <b-button
                    class="tagButton opacity-100 flex-fill"
                    v-on:click="togglePrivate"
                    v-if="newExample.privateExample == false"
                    >Make Private</b-button
                  >
                  <b-button
                    class="tagButton flex-fill btn btn-danger"
                    v-on:click.prevent="toggleAdd"
                    >Cancel</b-button
                  >
                  <b-button
                    class="tagButton flex-fill btn btn-dark"
                    v-on:click.prevent="submitNewExample"
                    >Submit</b-button
                  >
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
          <!-- Start Edit Example Card -->
          <div
            class="card h-100"
            v-bind:class="[stageEdit === example.exampleId ? '' : 'hidden']"
          >
            <div class="card-body d-flex flex-column">
              <form class="card-body d-flex flex-column" action="submit">
                <input
                  type="text"
                  class="card-title"
                  placeholder="Title"
                  v-model="editExample.title"
                />
                <textarea
                  class="card-text"
                  type="text"
                  placeholder="Description "
                  v-model="editExample.description"
                ></textarea>
                <textarea
                  type="text"
                  class="d-card-text overflow: auto"
                  placeholder="Add code here"
                  v-model="editExample.codeExample"
                ></textarea>
                <input
                  type="text"
                  placeholder="Attribution"
                  v-model="editExample.attribution"
                />

                <div>
                  <b-dropdown
                    id="dropdown-1"
                    variant="primary"
                    :text="
                      editExample.languageName == ''
                        ? 'Choose Language'
                        : editExample.languageName
                    "
                    class="m-md-2"
                  >
                    <b-dropdown-item
                      v-for="language in retrieveAllLanguages"
                      :key="language.id"
                      v-on:click="editLanguageButton(language)"
                      >{{ language }}</b-dropdown-item
                    >
                  </b-dropdown>
                </div>
                <!-- <p>Selected</p> -->
                <p class="labelText">Add/Remove Tags</p>
                <div
                  class="pillbox d-flex flex-wrap flex-row justify-content-start"
                >
                  <div
                    class="tags"
                    v-for="tag in editExample.tags"
                    v-bind:key="tag.tagId"
                  >
                    <b-button
                      class="tagButton btn opacity-100"
                      pill
                      variant="info"
                      v-on:click="editTagButton(tag)"
                      >{{ tag }}</b-button
                    >
                  </div>
                </div>
                <!-- <p>Available Tags</p> -->
                <div
                  class="pillbox d-flex flex-wrap flex-row justify-content-start"
                >
                  <div
                    class="tags"
                    v-for="tag in retrieveTagsForEdit"
                    :key="tag.id"
                  >
                    <b-button
                      class="tagButton opacity-50"
                      variant="info"
                      pill
                      v-on:click="editTagButton(tag)"
                      >{{ tag }}</b-button
                    >
                  </div>
                </div>

                <div class="d-flex flex-row justify-content-center">
                  <b-button
                    class="tagButton opacity-50 flex-fill"
                    v-on:click="togglePrivateEdit"
                    v-if="editExample.privateExample === true"
                    >Make Public</b-button
                  >
                  <b-button
                    class="tagButton opacity-100 flex-fill"
                    v-on:click="togglePrivateEdit"
                    v-if="editExample.privateExample === false"
                    >Make Private</b-button
                  >
                  <b-button
                    class="tagButton flex-fill btn btn-danger"
                    v-on:click.prevent="cancelEdit"
                    >Cancel</b-button
                  >
                  <b-button
                    class="tagButton flex-fill btn btn-dark"
                    v-on:click.prevent="confirmEdit"
                    >Submit</b-button
                  >
                </div>
              </form>
            </div>
          </div>
          <!-- End Edit Example Card -->

          <!-- Start Display Card -->
          <div
            class="card h-100"
            v-bind:class="{ hidden: stageEdit === example.exampleId }"
          >
            <div class="card-body d-flex flex-column">
              <h4 class="card-title">{{ example.title }}</h4>
              <p class="card-text">{{ example.description }}</p>

              <pre class="codeDisplay border border-primary overflow-auto">{{
                convertFromUTF16(example.codeExample)
              }}</pre>

              <p class="card-text">Source: {{ example.attribution }}</p>

              <div class="d-flex align-items-end mt-auto">
                <div class="d-flex flex-row mt-auto">
                  <b-button
                    class="tagButton"
                    variant="primary"
                    pill
                    v-on:click="languageTagButton(example.languageName)"
                    >{{ example.languageName }}</b-button
                  >
                  <div
                    class="tags"
                    v-for="tag in example.tags"
                    v-bind:key="tag.tagId"
                  >
                    <b-button
                      class="tagButton"
                      pill
                      variant="info"
                      v-on:click="tagButton(tag)"
                      >{{ tag }}</b-button
                    >
                  </div>
                </div>
              </div>
              <!-- end display of example language and search tags -->

              <div class="d-flex flex-row justify-content-end">
                <b-button
                  class="tagButton"
                  pill
                  variant="outline-dark"
                  v-on:click="copyToClipboard(example.codeExample)"
                >
                  <font-awesome-icon icon="copy"></font-awesome-icon>
                </b-button>
                <div v-if="isLoggedIn == true">
                  <b-button
                    class="tagButton"
                    pill
                    v-bind:variant="
                      example.favoriteExample == true
                        ? 'warning'
                        : 'outline-warning'
                    "
                    v-on:click="makeFavorite(example)"
                    ><font-awesome-icon icon="star"></font-awesome-icon>
                  </b-button>
                  <b-button
                    v-if="$store.state.user.id === example.userId"
                    class="tagButton"
                    pill
                    variant="outline-dark"
                    v-on:click="stageEditExample(example)"
                    >Edit</b-button
                  >

                  <b-button
                    v-if="$store.state.user.id === example.userId"
                    class="tagButton"
                    pill
                    variant="outline-danger"
                    v-on:click="deleteExampleCheck(example.exampleId)"
                    >Delete</b-button
                  >
                </div>
              </div>
              <!-- end of example control buttons -->
            </div>
            <!-- end card body -->
          </div>
          <!-- end example card iteration -->
        </div>
        <!-- End Example Card Display Loop -->
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
        isFavorited: false,
      },
      addMessage: "",
      addGoodMessage: "",
      stageDelete: 0,
      stageEdit: 0,
      deleteMessage: "",
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
        privateExample: "",
        attribution: "",
        defaultExample: "",
        userId: 0,
        favoriteExample: false,
      },
      editExample: {
        title: "",
        description: "",
        tags: [],
        exampleId: 0,
        languageName: "",
        languageId: 0,
        codeExample: "",
        privateExample: false,
        attribution: "",
        defaultExample: "",
        userId: 0,
        favoriteExample: "",
      },
    };
  }, // End of data
  created() {
    if (this.$store.state.user.currentUser != {}) {
      exampleService.retrieveExamples().then((response) => {
        this.examples = response.data;
      });
    }
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
        this.newExample.tags.splice(index, 1);
      } else {
        this.newExample.tags.push(tagOnButton);
      }
    },
    editTagButton(tagOnButton) {
      if (this.editExample.tags.includes(tagOnButton)) {
        const index = this.editExample.tags.indexOf(tagOnButton);
        this.editExample.tags.splice(index, 1);
      } else {
        this.editExample.tags.push(tagOnButton);
      }
    },
    addLanguageButton(languageOnButton) {
      this.newExample.languageName = languageOnButton;
    },
    editLanguageButton(languageOnButton) {
      this.editExample.languageName = languageOnButton;
    },
    clearSearchInputs() {
      (this.filter.title = ""),
        (this.filter.language = ""),
        (this.filter.tags = ""),
        (this.filter.searchedTags = []);
      this.filter.isFavorited = false;
    },
    clearMessages() {
      this.addMessage = "";
      this.addGoodMessage = "";
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
        this.newExample.privateExample = "";
        this.newExample.attribution = "";
        this.newExample.defaultExample = "";
        (this.newExample.favoriteExample = false),
          (this.newExample.userId = this.$store.state.user.id);
        this.addingNewExample = !this.addingNewExample;
      } else {
        this.addingNewExample = !this.addingNewExample;
      }
    },
    cancelEdit() {
      this.editExample.title = "";
      this.editExample.description = "";
      this.editExample.tags = [];
      this.editExample.exampleId = 0;
      this.editExample.languageName = "";
      this.editExample.languageId = 0;
      this.editExample.codeExample = "";
      this.editExample.privateExample = false;
      this.editExample.attribution = "";
      this.editExample.defaultExample = "";
      this.editExample.userId = this.$store.state.user.id;
      this.editExample.favoriteExample = false;
      this.stageEdit = 0;
    },
    retrieveAllTagsMethod() {
      return this.retrieveAllTags;
    },
    togglePrivate() {
      this.newExample.privateExample = !this.newExample.privateExample;
    },
    togglePrivateEdit() {
      this.editExample.privateExample = !this.editExample.privateExample;
    },
    toggleFavorite() {
      this.filter.isFavorited = !this.filter.isFavorited;
    },
    submitNewExample() {
      // Data Validation
      if (this.newExample.languageName == "") {
        this.addMessage = "Language must be selected";
        throw "Language must be selected";
      }
      if (this.newExample.codeExample == "") {
        this.addMessage = "Code example cannot be blank";
        throw "Code example cannot be blank";
      }
      if (this.newExample.title == "") {
        this.addMessage = "Title cannot be blank";
        throw "Title cannot be blank";
      }
      // Convert Code to UTF16
      let exampleToSubmit = Object.assign({}, this.newExample);
      let bufferArray = new ArrayBuffer(exampleToSubmit.codeExample.length * 2);
      let convertedCode = new Uint16Array(bufferArray);
      for (let i = 0; i < exampleToSubmit.codeExample.length; i++) {
        convertedCode[i] = exampleToSubmit.codeExample.charCodeAt(i);
      }
      exampleToSubmit.codeExample = convertedCode.join(",");
      // Send new Example to Database
      if (this.$store.state.user.currentUser != {}) {
        exampleService
          .addExample(exampleToSubmit)
          .then((response) => {
            this.addGoodMessage = "Code Example Added!";
            this.toggleAdd();
            if (response.status == 201) {
              exampleService.retrieveExamples().then((response) => {
                this.examples = response.data;
              });
            }
          })
          .catch((error) => {
            this.toggleAdd();
            this.addMessage = "Code Example could not be added!";
            console.log(error);
          });
      }
    },
    stageEditExample(exampleObject) {
      this.editExample.title = exampleObject.title;
      this.editExample.description = exampleObject.description;
      this.editExample.tags = exampleObject.tags;
      this.editExample.exampleId = exampleObject.exampleId;
      this.editExample.languageName = exampleObject.languageName;
      this.editExample.languageId = exampleObject.languageId;
      this.editExample.codeExample = this.convertFromUTF16(
        exampleObject.codeExample
      );
      this.editExample.privateExample = exampleObject.privateExample;
      this.editExample.attribution = exampleObject.attribution;
      this.editExample.defaultExample = exampleObject.defaultExample;
      this.editExample.userId = this.$store.state.user.id;
      this.editExample.favoriteExample = exampleObject.favoriteExample;
      this.stageEdit = exampleObject.exampleId;
    },
    makeFavorite(exampleToFavorite) {
      if (this.$store.state.user.currentUser != {}) {
        exampleService
          .toggleFavorite(exampleToFavorite.exampleId)
          .then((response) => {
            if (response.status == 200) {
              exampleService.retrieveExamples().then((response) => {
                this.examples = response.data;
              });
            }
          })
          .catch((error) => {
            this.addMessage = "Code Example could not be favorited.";
            console.log(error);
          });
      }
    },
    deleteExampleCheck(deleteId) {
      if (this.$store.state.user.currentUser != {}) this.stageDelete = deleteId;
      this.deleteMessage =
        "Are you sure you want to delete the example called " +
        this.examples.find(
          (thisExample) => thisExample.exampleId == this.stageDelete
        ).title +
        "?";
      scroll(0, 0);
    },
    deleteExampleConfirm() {
      if (this.$store.state.user.currentUser != {}) {
        exampleService
          .deleteExample(this.stageDelete)
          .then((response) => {
            this.stageDelete = 0;
            this.deleteMessage = "";
            if (response.status == 204) {
              this.addMessage = "Code Example was deleted.";
              exampleService.retrieveExamples().then((response) => {
                this.examples = response.data;
              });
            }
          })
          .catch((error) => {
            this.addMessage = "Code Example was not deleted.";
            console.log(error);
          });
      }
    },
    deleteExampleCancel() {
      this.stageDelete = 0;
      this.deleteMessage = "";
    },
    confirmEdit() {
      // Data Validation
      if (this.editExample.languageName == "") {
        this.addMessage = "Language must be selected";
        throw "Language must be selected";
      }
      if (this.editExample.codeExample == "") {
        this.addMessage = "Code example cannot be blank";
        throw "Code example cannot be blank";
      }
      if (this.editExample.title == "") {
        this.addMessage = "Title cannot be blank";
        throw "Title cannot be blank";
      }
      // Convert Code to UTF16
      let exampleToResubmit = Object.assign({}, this.editExample);
      let bufferArray = new ArrayBuffer(
        exampleToResubmit.codeExample.length * 2
      );
      let convertedCode = new Uint16Array(bufferArray);
      for (let i = 0; i < exampleToResubmit.codeExample.length; i++) {
        convertedCode[i] = exampleToResubmit.codeExample.charCodeAt(i);
      }
      exampleToResubmit.codeExample = convertedCode.join(",");
      // Send new Example to Database
      if (this.$store.state.user.currentUser != {}) {
        exampleService
          .editExample(exampleToResubmit.exampleId, exampleToResubmit)
          .then((response) => {
            this.cancelEdit();
            if (response.status == 200) {
              this.addGoodMessage = "Code Example was edited successfully.";
              exampleService.retrieveExamples().then((response) => {
                this.examples = response.data;
              });
            }
          })
          .catch((error) => {
            this.addMessage = "Code Example edit was not saved.";
            console.log(error);
          });
      }
    },
    copyToClipboard(exampleCode) {
      var copyText = this.convertFromUTF16(exampleCode);

      navigator.clipboard.writeText(copyText);

      this.addGoodMessage = "Copied to clipboard!";
    },
  }, // End of methods
  computed: {
    filterSnippets() {
      let filteredExamples = this.examples;

      if (this.filter.isFavorited === true) {
        filteredExamples = filteredExamples.filter(
          (example) => example.favoriteExample === true
        );
      }

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

      filteredExamples = filteredExamples.sort((a, b) =>
        a.title.toLowerCase() < b.title.toLowerCase()
          ? -1
          : a.title.toLowerCase() > b.title.toLowerCase()
          ? 1
          : 0
      );

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
      newTags = newTags.filter((tag) => !newExampleTags.includes(tag));
      return newTags;
    },
    retrieveTagsForEdit() {
      const editExampleTags = this.editExample.tags;
      let newTags = this.retrieveAllTagsMethod();
      newTags = newTags.filter((tag) => !editExampleTags.includes(tag));
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
    isLoggedIn() {
      if (this.$store.state.user.id > 0) {
        return true;
      }
      return false;
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

.labelText {
  color: black;
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

#tagHeader {
  color: whitesmoke;
}

.hidden {
  display: none;
}

.top {
  margin-top: 1.5em;
}

#allCards {
  margin-top: 0.7em;
  margin-bottom: 0.7em;
}

#addExampleButton {
  font-size: 1em;
}
</style>



