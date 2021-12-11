<template>
<!--
    <div id="nav">
      <router-link class="routeLink" v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link class="routeLink" v-bind:to="{ name: 'examples-display' }">See Examples Now</router-link>
      <router-link class="routeLink" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''"> | Logout</router-link>
    </div> -->

        <!-- BEGIN NAV BAR -->


        
      <div>
<div class="bg-primary">
    <div class="navbar navbar-dark bg-transparent">


     <b-navbar class="inner" toggleable="lg" type="dark" variant="info">
    <b-navbar-brand href="#">NavBar</b-navbar-brand>

    <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

    <b-collapse id="nav-collapse" is-nav>
      <b-navbar-nav >
      
<b-nav-item class="routeLink" v-bind:to="{ name: 'home' }">Home</b-nav-item>
<b-nav-item class="routeLink" v-bind:to="{ name: 'examples-display' }">See Examples Now</b-nav-item>
<b-nav-item class="routeLink" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</b-nav-item>

     
      </b-navbar-nav>

      <!-- Right aligned nav items -->
      <b-navbar-nav class="ml-auto">
       

               <b-nav-item-dropdown right>
          <!-- Using 'button-content' slot -->
          <template #button-content>
            <em>User</em>
          </template>
          <b-dropdown-item href="#">Profile</b-dropdown-item>
          <b-dropdown-item href="#">Sign Out</b-dropdown-item>
        </b-nav-item-dropdown>
      </b-navbar-nav>
    </b-collapse>
  </b-navbar>
 </div>
</div>


</div> <!-- END OF NAV BAR -->

</template>

<script>
export default {
    name: "the-header"
}
</script>

<style>
.inner {
    background-color: transparent;
}
</style>