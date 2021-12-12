<template>
<!--
    <div id="nav">
      <router-link class="routeLink" v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link class="routeLink" v-bind:to="{ name: 'examples-display' }">See Examples Now</router-link>
      <router-link class="routeLink" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''"> | Logout</router-link>
    </div> -->

        <!-- BEGIN NAV BAR -->


        
      <div >



     <b-navbar id="nope" class=" d-flex justify-content-end vw-80"  toggleable="lg" type="dark"  bg-transparent >
    

    
      <b-navbar-nav    >
<b-nav-item  class="routeLink text" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''">Login | </b-nav-item>
<b-nav-item link-classes="text" class="routeLink" v-bind:to="{ name: 'home' }" v-if="$store.state.token != ''" >Home</b-nav-item>
<b-nav-item link-classes="text" class="routeLink" v-bind:to="{ name: 'examples-display' }">Explore</b-nav-item>
<b-nav-item link-classes="text" class="routeLink" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</b-nav-item>


     
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
.nope {
  width: 80%
 
  
  
}

.nav-item.nav-item.nav-item a {
    color: white;
    font-size: 3rem;
    text-shadow:
        0.07em 0 black,
        0 0.07em black,
        -0.07em 0 black,
        0 -0.07em black;
        
}
.nav-item.nav-item.nav-item a:hover {
text-decoration: underline;
}
</style>