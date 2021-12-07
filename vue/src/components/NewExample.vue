   <form action="submit">
      <input type="text" v-model="newExample.title" />
      <textarea type="text" v-model="newExample.code_example"> </textarea>
      <button v-on:click.prevent="submitCode">press me!</button>
    </form>