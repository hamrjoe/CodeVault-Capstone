<template>

  <div id="app" class="background">
<the-header />

    <router-view />
  </div>
</template>

<script>
  import TheHeader from './components/TheHeader.vue'
  export default {
    name: 'App',
    components: {
      TheHeader
    }
  }
</script>

<style >


body {
  background:   url("https://i.ibb.co/v4zDfyy/india-homepage.jpg");
  

}








</style>

html {
  background-color: #1F4287;
}

.background {
  background-color: #1F4287;
}