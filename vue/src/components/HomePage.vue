<template>
 <div  class=" mainDiv d-flex justify-content-center ">

  
<div class="row" >
  <div id="invisibleColumn" class="col-auto"> Tooooooooooooooooooooooooooooo</div>
  <div class="col align-self-center text-center">

 
 
  <div class="boxed ">

  <p class="p-1">Keeping track of your code is <u>hard</u>.</p>
  <p class="p-2">We make it easy.</p>

    
    <b-btn id="btn" variant="dark" class="routeLink" v-bind:to="{ name: 'register' }" href="#" role="button">Get Started</b-btn>
  
 
       </div>

 </div>
 </div>

       
</div>


</template>

<script>

export default {
  
    name: "home-page"
}
</script>

<style scope>
body {
  background-image: url("https://i.ibb.co/v4zDfyy/india-homepage.jpg")
}



#invisibleColumn {
  color: transparent;
}

.boxed {
  
  width: 60rem;
  height: 20rem;
  background: rgba(53, 58, 107, 0.8);
  border-radius: 1rem;
  padding-top: 2em;
  

}
.p-1   {
  color: white;
  font-style: 'Roboto', sans-serif;
  font-weight: 500;
  font-size: 300%;
  
  text-align: center;
  
  

  
  
}
.p-2 {
    color: white;
  font-style: 'Roboto', sans-serif;
  font-weight: 500;
  font-size: 300%;
  text-align: center;
 
}
#btn {



font-size: 1.7rem;

font-weight:bold;
}

.mainDiv {
  height: 80vh
}

</style>