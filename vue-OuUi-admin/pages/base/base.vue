<template>
	<view class="base">
		<view class="mask" @click="hideMenus" v-if="if_phone&&show_menus"></view>
		<view :class="'menus'+(if_phone?' phone':'')" :style="menus_style">
			<view class="top">
				<image :src="logo" class="logo"></image>
				<view class="logo_title">Vue-OuUi-Admin</view>
			</view>

			<view :class="(item.on&&item.child.length>0?'menus_item_on':'menus_item')" v-for="(item,index) in menus" :key="index"
			 @click="setMenusId(0,item,index)" :style="'height:'+(item.on?'auto;':'50px;')+'background:'+(item.id===menus_id&&item.child.length<1?'#1890ff':'#001529;')">
				<image class="menus_icon" :src="'../../static/img/'+item.icon+'.png'"></image>
				<image v-if="item.child.length>0&&show_menus" :style="'transform: rotate('+(item.on?'0':'-180')+'deg);'" class="menus_show" src="../../static/img/icon_down_menus.png"></image>
				<span class="menus_title">{{item.title}}</span>
				<view :style="'height:'+(item.on?'50px;':'0px;')+'background-color:'+(Ichild.id===menus_child_id?'#1890ff':'#001529;')"
				 class="menus_item_child" v-for="(Ichild,index) in item.child" :key="index" @click.stop="setMenusId(1,item,index,Ichild)" >
					<span class="child_title">{{Ichild.title}}</span>
				</view>
			</view>
		</view>
		<view :class="'content'+(if_phone?' phone':'')" :style="content_style">
			<view class="head">
				<view class="show_menus_base" @click="hideMenus">
					<view :class="'show_menus'+(show_menus?' show':' hide')"></view>
					<view class="show_menus title">{{show_menus?'收起':'展开'}}</view>
				</view>
				<image class="nowPage_icon float-left" src="../../static/img/icon_right_black.png"></image>
				<span class="nowPage_title float-left">{{nowPage_title}}</span>
				
				<view class="user" @mouseover="showAdminMenus(true)" @mouseleave="showAdminMenus(false)">
					<view class="img_base"><image class="img" :src="admin.adminImg"></image></view>
					<span class="title">{{admin.nickName}}</span>
					<span class="icon"></span>
					<view class="admin_menus" :style="admin_menus_style" @mouseover="showAdminMenus(true)" @mouseleave="showAdminMenus(false)">
						<view class="item_center">
							<view class="item_line">
								<view class="icon_user"></view>
								<view class="title">个人中心</view>
							</view>
						</view>
						<view class="item_logout">
							<view class="item_line">
								<view class="icon_logout"></view>
								<view class="title">退出登录</view>
							</view>
						</view>
					</view>
				</view>
				<!-- 刷新按钮 -->
				<view class="reload" @click="reload()"></view>
			</view>
			<view class="iframeBase">
				<home v-if="menus_id==='home'" class="iframe"></home>
				<userAdmin v-if="menus_child_id==='user_admin'" class="iframe"></userAdmin>
				<shopAdmin v-if="menus_child_id==='shop_admin'" class="iframe"></shopAdmin>
				<view class="bottom">@备案号：粤备OuUiAdmin</view>
			</view>
			
			
			<!-- <router-view class="iframe"></router-view> -->
			<!-- <image src="../../static/img/check0.png" @click="hideMenus" mode=""></image> -->
		</view>
	</view>
</template>

<script>
	import Vue from 'vue'
	import home from '../home/home'
	import userAdmin from '../module/user/user_admin'
	import shopAdmin from '../module/user/shop_admin'
	export default {
		components: {home,userAdmin,shopAdmin},
		data() {
			return {
				logo: "../../static/img/ou_ui_logo.png", //左上角logo
				if_phone: false,
				show_menus: true,
				menus_style: "left:0px;",
				content_style: "width:calc(100vw - 270px)",
				admin_menus_style: "0px;",
				admin: { //管理员模拟数据
					adminImg: "../../static/img/user.jpg",
					nickName: "欧某"
				},
				menus: [ //左侧菜单栏模拟数据
					{
						id: 'home',
						title: '首页',
						icon: 'icon_home',
						on: true,
						child: []
					},
					{
						id: 'user',
						title: '用户管理',
						icon: 'icon_user_admin',
						on: true,
						child: [{
							id: 'user_admin',
							title: '普通用户'
						}, {
							id: 'shop_admin',
							title: '商家管理'
						}, {
							id: 'system_admin',
							title: '系统管理员'
						}]
					},
					{
						id: 'product',
						title: '产品管理',
						icon: 'icon_product',
						on: false,
						child: [{
							id: 'product_admin',
							title: '商品列表'
						}, {
							id: 'product_sort',
							title: '商品分类'
						}]
					},
					{
						id: 'order',
						title: '订单管理',
						icon: 'icon_order',
						on: false,
						child: [{
							id: 'order_admin',
							title: '订单列表'
						}, {
							id: 'order_logistics',
							title: '物流信息'
						}]
					},{
						id: 'setting',
						title: '系统配置',
						icon: 'icon_sys_setting',
						on: false,
						child: []
					}
				],
				menus_copy: [],
				menus_id: '',
				menus_child_id: '',
				nowPage_title:'首页'
			}
		},
		created() {
			this.init(); //初始化
			this.checkIfPhone() //监听窗口尺寸变化
		},
		methods: {
			reload(){
				let id=this.menus_child_id;
				console.log(id)
				this.menus_child_id=false;
				uni.showLoading({
					title:'加载中'
				})
				let that=this;
				
				that.$nextTick(function(){
					uni.hideLoading()
					that.menus_child_id=id;
				})
				
			},
			setMenusId(type, item, index, Ichild) { //index可能是item的，也可能是Ichild的
				if (type === 0) {
					let nowItem = item;
					nowItem.on = !nowItem.on
					
					this.$set(this.menus, index, nowItem)
					if (item.child.length < 1) {
						this.menus_id = item.id
						this.menus_child_id = false;
						this.nowPage_title=item.title
					}
					if (this.show_menus == false && this.if_phone == false) { //在电脑端且关闭菜单，点击了就打开菜单
						this.hideMenus()
					}
				} else {
					this.menus_id = item.id
					this.menus_child_id = Ichild.id
					this.nowPage_title=Ichild.title
				}
			},
			showAdminMenus(type) {
				if (type) {
					this.admin_menus_style = "height:90px;"
				} else {
					this.admin_menus_style = "height:0px;"
				}
			},
			hideMenus() {
				if (this.if_phone) {
					this.content_style = "width:100vw;"
					if (this.show_menus) {
						this.menus_style = "left:-270px;"
						this.show_menus = false;
					} else {
						this.menus_style = "left:0px;"
						this.show_menus = true;
					}
				} else {
					if (this.show_menus) {
						this.menus_style = "width:70px;"
						this.content_style = "width:calc(100vw - 70px)"
						this.show_menus = false;
						this.menus_copy = JSON.parse(JSON.stringify(this.menus));
						let nowMenus = JSON.parse(JSON.stringify(this.menus));
						for (let i in this.menus) {
							nowMenus[i].on = false
						}
						this.menus = nowMenus;

					} else {
						this.menus_style = "width:270px;"
						this.content_style = "width:calc(100vw - 270px)"
						this.show_menus = true;
						this.menus = this.menus_copy;
					}
				}

			},
			checkIfPhone() {
				let that = this;
				uni.onWindowResize(function(res) {
					let h = res.size.windowHeight
					let w = res.size.windowWidth
					if (w <= h && that.if_phone == false) {
						that.$nextTick(function(){
							that.if_phone = true;
							that.show_menus = true;
							that.menus_style = "width:270px;";
							that.content_style = "width:100vw;";
						})
					} else if (w > h) {
						that.if_phone = false;
						that.menus_style = "width:270px;";
						that.content_style = "width:calc(100vw - 270px)";
						that.show_menus = true;
					}
				})
			},
			init() {
				let h = document.body.clientHeight;
				let w = document.body.clientWidth;
				if (w <= h) {
					this.if_phone = true
					this.content_style = "width:100vw;";
					this.menus_child_id="user_admin"
				} else {
					this.if_phone = false
					this.menus_child_id="user_admin"
				}
				console.log(this.if_phone)
			}
		}
	}
</script>

<style>

</style>
