<template>
  <div id="login" class="text-center">
    <form class="form-signin" @submit.prevent="login">
      <h1 class="h3 mb-3 font-weight-normal">Please Sign In</h1>
      <div
        class="alert alert-danger"
        role="alert"
        v-if="invalidCredentials"
      >Invalid username and password!</div>
      <div
        class="alert alert-success"
        role="alert"
        v-if="this.$route.query.registration"
      >Thank you for registering, please sign in.</div>
      <label for="username" class="sr-only">Username</label>
      <input
        type="text"
        id="username"
        class="form-control"
        placeholder="Username"
        v-model="user.username"
        required
        autofocus
      />
      <label for="password" class="sr-only">Password</label>
      <input
        type="password"
        id="password"
        class="form-control"
        placeholder="Password"
        v-model="user.password"
        required
      />
      <router-link class="routeLink" :to="{ name: 'register' }">Need an account?</router-link>
      
      <button id="submit" class="btn btn-lg btn-primary btn-block" type="submit">
        Sign in
      </button>
    </form>
   <!-- <example /> -->
  </div>
</template>

<script>

import authService from "../services/AuthService";


export default {
  name: "login",

  data() {
    return {
      user: {
        username: "",
        password: ""
      },
      invalidCredentials: false
    };
  },
  methods: {
    login() {
      authService
        .login(this.user)
        .then(response => {
          if (response.status == 200) {
            this.$store.commit("SET_AUTH_TOKEN", response.data.token);
            this.$store.commit("SET_USER", response.data.user);
            this.$router.push("/examples-display");
          }
        })
        .catch(error => {
          const response = error.response;

          if (response.status === 401) {
            this.invalidCredentials = true;
          }
        });
    }
  }
};
</script>

<style scoped>

body {


  font-family: "Open Sans Condensed", sans-serif;
}
#login {
  
  padding: 1em;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
 
 
}

form {
  position: relative;
  width: 20em;
  margin: 0 auto;
  background: rgb(72, 117, 201, .3);
  padding: 20px 22px;
  border: 1px solid;
  border-radius: 2em;

  font-weight: bold;
  
}

form input, form button {
  
  border: 1px solid;

  

  font: bold .875em/1.25em "Open Sans Condensed", sans-serif;
  letter-spacing: .075em;
  color: rgb(0, 0, 0);
  text-shadow: 0 1px 0 rgba(0,0,0,.1);
  margin-bottom: .5em;

  
}

.form-signin {

  color: rgb(255, 255, 255);


}

.routeLink {
  display: inline-block;
  margin: .5em;
}

#submit {
  
  display: block;
  margin: auto;
}
</style>
