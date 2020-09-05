import Vue from 'vue'
import App from './App'
import api from 'static/js/api.js'
import conf from 'static/js/config.js'
Vue.config.productionTip = false
App.mpType = 'app'
// import router from './router'
// import { RouterMount } from 'uni-simple-router'

// RouterMount(app,'#app'); 
 
const app = new Vue({
	...App
	
})
app.$mount()

Vue.use(api);
Vue.prototype.Imgurl = conf.Imgurl//挂载到Vue实例上面