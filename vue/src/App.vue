<template>
  <div id="app" class="background">
    <div id="nav">
      <router-link class="routeLink" v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link class="routeLink" v-bind:to="{ name: 'examples-display' }">See Examples Now</router-link>
      <router-link class="routeLink" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''"> | Logout</router-link>
    </div>
    <router-view />
  </div>
</template>

<style >
html {
  background-color: #1F4287;
}
.background {
  background-color: #1F4287;
}

.routeLink {
  color: cyan;
}

#nav {
  text-align: center;
  margin: 20px;
}

</style>