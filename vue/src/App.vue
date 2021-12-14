<template>

  <div id="app" class="background">
<the-header />

    <router-view />
    <div class="footer">&copy; JG INDIA  </div>
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


body  {
  background:   url("https://i.ibb.co/v4zDfyy/india-homepage.jpg");
  box-shadow: inset 0 0 0 1000px rgba(0,0,0,.3);
  backdrop-filter: blur(4px);
  height: 100vh;
  background-repeat: inherit;
  
  
  }


.footer {
  text-align: center;
  color: whitesmoke;
}






</style>

html {
  background-color: #1F4287;
}

.background {
  background-color: #1F4287;
}