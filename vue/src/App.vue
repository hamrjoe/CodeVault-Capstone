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

<style scope>




.routeLink {
  color: cyan;
}

#nav {
  text-align: center;
  margin: 20px;
}

</style>

html {
  background-color: #1F4287;
}

.background {
  background-color: #1F4287;
}