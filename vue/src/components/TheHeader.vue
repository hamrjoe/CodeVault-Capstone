<template>
<!--
    <div id="nav">
      <router-link class="routeLink" v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link class="routeLink" v-bind:to="{ name: 'examples-display' }">See Examples Now</router-link>
      <router-link class="routeLink" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''"> | Logout</router-link>
    </div> -->

        <!-- BEGIN NAV BAR -->


        
      <div>



     <b-navbar class="d-flex justify-content-center"  toggleable="lg" type="dark"  bg-transparent >
    

    
      <b-navbar-nav    >
      
<b-nav-item link-classes="text-white text" class="routeLink" v-bind:to="{ name: 'home' }" >Home</b-nav-item>
<b-nav-item link-classes="text-white text" class="routeLink" v-bind:to="{ name: 'examples-display' }">Explore</b-nav-item>
<b-nav-item link-classes="text-white text" class="routeLink" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</b-nav-item>
<b-nav-item link-classes="text-white text" class="routeLink" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''">Login</b-nav-item>

     
      </b-navbar-nav>

      <!-- Right aligned nav items -->
    
  
  </b-navbar>


</div> <!-- END OF NAV BAR -->

</template>

<script>
export default {
    name: "the-header"
}
</script>

<style>
.text {
  font-size: 1.7rem;
  color:rebeccapurple
  
}
</style>