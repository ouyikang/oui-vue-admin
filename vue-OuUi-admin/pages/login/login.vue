<template>
	<view class="login">
		<div class="head_text">beautiful boys and girls欢迎加入OuUi,作者微信：OuOuOuMyGod</div>
		
		<div class="login_from">
			<div class="tittle">Hello!</div>
			<div class="tittle_tips">欢迎来到 Ou-Ui-Login</div>
			<div class="line_w_100" style="margin-top: 30px;">
				<div class="login_input" style="padding: 0;">
					<image src="../../static/img/icon_user.png" class="icon_user"></image>
					<input type="text" v-model="phone" placeholder="邮箱/手机号" class="user" />
				</div>
			</div>
			<div class="line_w_100" style="margin-top: 0px;">
				<div class="login_input" >
					<image src="../../static/img/icon_password.png" class="icon_password"></image>
					<input v-if="type=='text'" type="text" placeholder="请输入密码" class="password" v-model="password" />
					<input v-else type="password" placeholder="请输入密码" class="password" v-model="password" />
					<image :src='see' class="see_password" @mouseenter="see_password_mouse(true)" @mouseleave="see_password_mouse(false)" @click="see_password()"></image>
				</div>
			</div>
			<div class="line_w_100" style="margin-top: 20px;">
				<button class="button_l_login" @click="login()">登录</button>
			</div>
		</div>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				title: 'Hello',
				phone:"admin",
				password:"admin",
				see: '../../static/img/see.png',
				type:'password'
			}
		},
		onLoad() {
			
		},
		methods: {
			see_password_mouse(mouse) {
				if (mouse == true) {
					this.see = '../../static/img/see2.png'
				} else {
					if (this.type == 'text') {
						this.see = '../../static/img/see2.png'
						return
					}
					this.see = '../../static/img/see.png'
				}
			
			},
			see_password() {
				if (this.type == 'password') {
					this.see = '../../static/img/see2.png'
					this.type = 'text'
				} else {
					this.see = '../../static/img/see.png'
					this.type = 'password'
				}
			},
			login(){
				setTimeout(function(){
					uni.redirectTo({
						url:'../base/base'
					})
				},1000)
				
				return this.$api.login({user:this.phone,password:this.password}).then(function(res){
					if(res.data.code!=200){
						uni.showToast({
							icon:'none',
							title:res.data.msg
						})
					}else{
						//登录成功，跳转
						uni.showToast({
							title:res.data.msg
						})
						setTimeout(function(){
							uni.redirectTo({
								url:'../base/base'
							})
						},1000)
					}
				})
				
			}
		}
	}
</script>

<style>
	

</style>
