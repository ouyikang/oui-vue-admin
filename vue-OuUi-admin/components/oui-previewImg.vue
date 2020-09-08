<template>
	<view  :class="'oui-previewImg'+(imgs.length>0?' show':'')" @click="hide()">
		<view class="" v-for="(item,index) in imgs" >
			<image v-if="index===imgIndex" :src="item" class="oui_img" mode="widthFix" ></image>
		</view>
		
		<view v-if="imgs.length>0&&!ifPhone" class="oui-previewImg-control"></view>
	</view>	
</template>

<script>
	export default {
		data() {
			return {
				imgs:[],
				ifPhone:false,
				imgIndex:0
			};
		},
		methods:{
			show(imgsItem){
				this.imgs=imgsItem;
				let platform=uni.getSystemInfoSync().platform
				if(platform=='ios'||platform=='android'){
					this.ifPhone=true
				}else{
					this.ifPhone=false
				}
			},
			hide(){
				this.imgs=[]
			}
		}
	}
</script>

<style>
.oui-previewImg{width: 100vw;top: 0;left: 0;height: 0;position: fixed;z-index: 99;background: rgba(0,0,0,0.4);transition: height 0.3s;backdrop-filter: blur(10px) brightness(110%); display:flex;justify-content:center;align-items:center;overflow: hidden;}
.oui-previewImg.show{height: 100vh;}
.oui-imgBase{width: auto;height: auto;display:flex;justify-content:center;align-items:center;overflow-y: scroll;}
.oui_img{max-width: 100vw;max-height: calc(100vh - 200px);}
.oui-previewImg-control{width: 100vw;height: 80px;display:flex;justify-content:center;align-items:center;position: absolute;bottom: 0;border-top: #fff 1px solid;z-index: 99;}
</style>
