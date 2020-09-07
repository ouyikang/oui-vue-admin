<template>
	<view :class="'oui-selecter'+(showOptions?' on':'')" @click="show()" @blur="hide()">
		<view class="oui-selecter-title">{{options_title}}</view><span :class="'icon_down'+(showOptions?' on':'')"></span>
		<view :class="'options'+(showOptions?' on':'')">
			<view class="point"></view>
			<view class="options-item" v-for="(item,index) in options" @click.stop="setOptions(index)">
				{{item}}
			</view>	
		</view>
	</view>
</template>

<script>
	export default {
		props: ['options'],
		name:'ouiSelecter',
		data() {
			return {
				showOptions:false,
				options_index:0,
				options_title:''
			};
		},
		methods:{
			show(){
				this.showOptions=!this.showOptions;
				
			},
			init(options){
				this.options=options;
			},
			hide(){
				console.log("失去焦点")
				this.showOptions=false;
				
			},
			setOptions(index){
				this.options_index=index;
				this.options_title=this.options[this.options_index]
				this.showOptions=false;
			},
		},
		mounted () {
			this.options_title=this.options[this.options_index]
			console.log('111')
		}
	}
</script>

<style>
.mask{width: 100vw;height: 0;position: fixed;z-index: 99;background: rgba(0,0,0,0.4);transition: all 0.3s;backdrop-filter: blur(10px) brightness(110%); display:flex;justify-content:center;align-items:center;}
.mask.show{width: 100vw;height: 100vh;top: 0;left: 0;border-radius: 0;}
</style>
