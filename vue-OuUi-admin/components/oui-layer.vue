<template>
	<view :class="'mask'+(showLayer?' show':'')"  :visible.sync="showLayer" width="60%" :before-close="hide" @click="hide()">
		<slot @click.stop="stop()" v-if="showLayer"></slot>	
	</view>
</template>

<script>
	export default {
		name:'layer',
		data() {
			return {
				showLayer:false,
			};
		},
		methods:{
			show(){
				this.showLayer=true;
			},
			hide(){
				this.showLayer=false;
			},
			stop(){
				console.log("点击")
			}
			
		}
	}
</script>

<style>
.mask{width: 100vw;height: 0;position: fixed;z-index: 99;background: rgba(0,0,0,0.4);transition: all 0.3s;backdrop-filter: blur(10px) brightness(110%); display:flex;justify-content:center;align-items:center;}
.mask.show{width: 100vw;height: 100vh;top: 0;left: 0;border-radius: 0;}
</style>
