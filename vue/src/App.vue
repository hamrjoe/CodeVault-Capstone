<template>
  <div id="app" class="background">
    <div id="nav">
      <router-link v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</router-link>
      <router-link v-bind:tp="{ name: 'examples' }">Examples</router-link>
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
</style>