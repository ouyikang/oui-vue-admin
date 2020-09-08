<template>
	<view :class="'oui-selecter'+(showOptions?' on':'')" @click="show()">
		<view class="oui-selecter-title">{{options_title}}</view><span :class="'icon_down'+(showOptions?' on':'')"></span>
		<view :class="'options'+(showOptions?' on':'')">
			<view class="point"></view>
			<view class="options-item" v-for="(item,index) in options" @click.stop="setOptions(index)">
				{{item.title}}
			</view>
		</view>
		<view v-if="showOptions" class="oui-selecter-mask" @click.stop="hide()"></view>
	</view>
</template>

<script>
	export default {
		props: ['options'],
		name:'ouiSelecter',
		data() {
			return {
				showOptions:false,
				options_title:''
			};
		},
		methods:{
			show(){
				this.showOptions=!this.showOptions;
			},
			hide(){
				this.showOptions=false;
			},
			setOptions(index){
				this.options_title=this.options[index].title
				this.showOptions=false;
				this.$emit('change', index)
			},
		},
		mounted () {
			this.options_title=this.options[0].title
		}
	}
</script>

<style>
.mask{width: 100vw;height: 0;position: fixed;z-index: 99;background: rgba(0,0,0,0.4);transition: all 0.3s;backdrop-filter: blur(10px) brightness(110%); display:flex;justify-content:center;align-items:center;}
.mask.show{width: 100vw;height: 100vh;top: 0;left: 0;border-radius: 0;}
</style>
