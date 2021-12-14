<template>
<!--
    <div id="nav">
      <router-link class="routeLink" v-bind:to="{ name: 'home' }">Home</router-link>&nbsp;|&nbsp;
      <router-link class="routeLink" v-bind:to="{ name: 'examples-display' }">See Examples Now</router-link>
      <router-link class="routeLink" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''"> | Logout</router-link>
    </div> -->

        <!-- BEGIN NAV BAR -->


        
      <div >



     <b-navbar id="nope" class=" d-flex justify-content-between"  toggleable="lg" type="dark"  bg-transparent >
    <img id="logo" src="../assets/testlogo.png"/>
        <div>
    
      <b-navbar-nav    >
<b-nav-item  class="routeLink text" v-bind:to="{ name: 'login' }" v-if="$store.state.token == ''">Login | </b-nav-item>
<b-nav-item id="home" link-classes="text" class="routeLink" v-bind:to="{ name: 'home' }" v-if="$store.state.token != ''" >Home |</b-nav-item>
<b-nav-item link-classes="text" class="routeLink" v-bind:to="{ name: 'register' }" v-if="$store.state.token == ''">Register</b-nav-item>
<b-nav-item link-classes="text" class="routeLink" v-bind:to="{ name: 'logout' }" v-if="$store.state.token != ''">Logout</b-nav-item>

     
      </b-navbar-nav>
    </div>

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


.b-navbar.nav {
    margin-right: 2em;
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

.navbar{
  margin-right: 2em;
}

#logo {
  max-width: 25%;
  height: auto;
  margin-left: 2em;
}
</style>