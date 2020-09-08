<template>
	<view class="content" >
		<!-- 添加/查询 -->
		<view class="ouui_set_head">
			
			<view class="auto_width">
				<view class="btn btn_bule float-left" @click="showLayer()">
					<span  class="btn_icon add"></span>
					<span  class="btn_text">添加</span>
				</view>
				<ouiSelecter ref="ouiSelecter" class="float-left mt-5 ml-5"  :options="state"  @change="setState"></ouiSelecter>
			</view>
			
			<view class="auto_width">
				<view class="btn btn_bule float-right" @click="getDatas()">
					<span  class="btn_icon search"></span>
					<span class="btn_text">搜索</span>
				</view>
				<input v-model="search_val" class="select float-right" type="text" placeholder-class="select_placeholder" placeholder="店铺ID/手机号码/店铺邮箱" />
			</view>
		</view>


		<view class="tb_base">
			<table class="ouui_table" cellspacing="0">
				<tr class="table_head">
					<td>店铺ID</td>
					<td class="td160">创建时间</td>
					<td>店铺名称</td>
					<td>店铺头像</td>
					<td>手机号码</td>
					<td>店铺余额</td>
					<td>成交金额</td>
					<td>成交订单数量</td>
					<td>商品总数量</td>
					<td>使用状态</td>
					<td class="td150">操作/管理</td>
				</tr>
				<tr class="table_content" v-for="(item,index) in pages[pages_index]">
					<td>{{item.id}}</td>
					<td >{{item.create_time}}</td>
					<td class="cursor_pointer chosed" @click="goDetails(item.id)">{{item.shop_name}}</td>
					<td><image class="tb_img_round" :src="host+item.shop_img"></image></td>
					<td>{{item.phone}}</td>
					<td >{{item.money}}元</td>
					<td >{{item.deal_price}}元</td>
					<td >{{item.deal_num}}</td>
					<td >{{item.product_num}}</td>
					<td><view :class="'float-left state '+(item.state==1?'on':'off')"></view>{{item.state==1?'正常':'禁用'}}</td>
					<td>
						<a @click="showForm(1,item)" class="tb_btn_set chosed">编辑</a>
						<a v-if="item.state==1" @click="disableData(item.id,-1)" class="tb_btn_set chosed">禁用</a>
						<a v-else @click="disableData(item.id,1)" class="tb_btn_set chosed">启用</a>
						<!-- <a @click="delectData(item.id)" class="tb_btn_set chosed">删除</a> -->
						<a @click="goDetails(item.id)" class="tb_btn_set chosed">详情</a>
					</td>
				</tr>
			</table>
		</view>
		<!-- 分页器 -->
		<view class="pager">
			<view class="pager_content">
				<view class="Btn next" @click="nextPage()"></view>
				<view class="Btn last" @click="lastPage()"></view>
				<picker class="pager_picker float-right" :range="pages_index_item" @change="setPageIndex"><span class="picker_title">第{{pages_index+1}}页</span></picker>
				<span class="title">共{{page_length}}页</span>
			</view>
		</view>
		
		
		<ouiLayer ref="ouiLayer">
			
			<view class="mask_form" @click.stop="">
				<!-- 标题 -->
				<view class="mask_form_head"><view class="head_title">{{newType===0?'新建':'编辑 (id:'+newData.id+')'}}</view><view @click="$refs.ouiLayer.hide" class="icon_close"></view></view>
				<view class="mask_form_body">
					<!-- 表单行 -->
					<view class="line">
						<view class="line_title"><span class="float-right red">*</span><span class="float-right">店铺名称</span></view>
						<input class="form_input float-left" type="text" placeholder="请输入店铺名称" v-model="newData.shop_name"/>
					</view>
					<view class="line">
						<view class="line_title"><span class="float-right red">*</span><span class="float-right">登录密码</span></view>
						<input class="form_input float-left" type="text" placeholder="请输入密码" v-model="newData.password"/>
					</view>
					<view class="line">
						<view class="line_title"><span class="float-right red">*</span><span class="float-right">店铺邮箱</span></view>
						<input class="form_input float-left" type="text" placeholder="请输入店铺邮箱"v-model="newData.email"/>
					</view>
					<view class="line">
						<view class="line_title"><span class="float-right red">*</span><span class="float-right">手机号码</span></view>
						<input class="form_input float-left" type="text" placeholder="请输入手机号码" v-model="newData.phone"/>
					</view>
					<view class="line">
						<view class="line_title"><span class="float-right red">*</span><span class="float-right">头像</span></view>
						<input class="form_input small float-left" type="text" placeholder="请上传头像" v-model="newData.shop_img"/>
						<view class="oui_btn_bule float-left mt-9 chosed" @click="choseImg()">上传</view>
					</view>
				</view>
				<view class="mask_form_foot">
					<view class="cancel" @click="$refs.ouiLayer.hide">取消</view>
					<view class="enter" v-if="newType===0" @click="addData()">新建</view>
					<view class="enter" v-else            @click="update()">保存</view>
				</view>
			</view>
			
		</ouiLayer>
		<!-- 暂无更多的提示 -->
		<view v-if="no_more" class="noMore"><view class="icon"></view></view>
	</view>
</template>

<script>
	import ouiLayer from '../../../components/oui-layer.vue'
	import ouiSelecter from '../../../components/oui-selecter.vue'
	export default {
		components: {ouiLayer,ouiSelecter},
		data() {
			return {
				host: this.Imgurl,
				allDatas: [],//所有数据
				state:[{title:'启用',id:1},{title:'禁用',id:-1}],
				state_index:0,
				search_val:'',
				no_more:false,
				newData:{},//新增或修改的数据
				newType:0,//0新建,1删除
				pages:[],
				pages_index_item:[],
				pages_index:0,
				page_length:0,
			}
		},
		methods: {
			choseImg(){
				// 选择图片
				var that=this;
				uni.chooseImage({
					count:1,
					success(res){
						that.uploadImage(res.tempFiles[0],res.tempFilePaths[0])
					}
				})
			},
			uploadImage(file,filePath){
				// 上传图片]
				let that=this;
				let host=this.host
				uni.uploadFile({
					fileType:'image',
					file:file,
				    url: that.host+'/admin/uploadImage',
				    filePath: filePath,
				    name: 'image',
				    success: function (res) {
						var imgPath=JSON.parse(res.data).data
						imgPath=imgPath.replace(/\\/g,"/");//替换掉反斜杠
						imgPath='storage/'+imgPath;
						that.newData.shop_img=imgPath;
					},
					complete: function () {
						uni.hideLoading()
					}
				});
				// 选择图片
			},
			showLayer(){
				this.$refs.ouiLayer.show();
			},
			showForm(type,data){
				this.newType=type;
				if(type===0){//0新建,1更新
					this.newData={};
					this.$refs.ouiLayer.show();
				}else if(type===1){
					this.newData=data;
					this.$refs.ouiLayer.show();
				}
			},
			update(){
				// 更新数据
				let that = this;
				return this.$api.updateShop(this.newData).then(function(res) {
					if(res.data.code!=200){
						uni.showToast({
							icon:'none',
							title:res.data.msg
						})
					}else{
						uni.showToast({
							icon:'success',
							title:res.data.msg
						})
						setTimeout(function(){
							that.$refs.ouiLayer.hide();
							that.getDatas();
						},1500)
					}
					
				})
			},
			disableData(id,type){//type-1禁用,1启用
				// 禁用数据
				let that=this;
				let title;
				if(type===-1){
					title='是否禁用?'
				}else{
					title='是否启用?'
				}
				uni.showModal({
					content:title,
					success(res) {
						if(res.confirm){
							return that.$api.disableShop({id:id,state:type}).then(function(res){
								if(res.data.code===200){
									uni.showToast({
										icon:'success',
										title:res.data.msg
									});
									setTimeout(function(){
										that.getDatas();
									},1500)
								}else{
									uni.showToast({
										icon:'none',
										title:res.data.msg
									})
									
								}
							})
						}
					}
				})
			},
			delectData(id){
				// 删除单条数据
				let that=this;
				uni.showModal({
					content:'是否确认删除',
					success(res) {
						if(res.confirm){
							return that.$api.delectUser({id:id}).then(function(res){
								if(res.data.code===200){
									uni.showToast({
										icon:'success',
										title:res.data.msg
									});
									that.getDatas()
								}else{
									uni.showToast({
										icon:'none',
										title:res.data.msg
									})
									
								}
							})
						}
					}
				})
			},
			addData(){
				// 新建数据
				let that = this;
				console.log(this.newData);
				return this.$api.addShop(this.newData).then(function(res) {
					if(res.data.code!=200){
						uni.showToast({
							icon:'none',
							title:res.data.msg
						})
					}else{
						uni.showToast({
							icon:'success',
							title:res.data.msg
						})
						setTimeout(function(){
							that.$refs.ouiLayer.hide();
							that.getDatas();
						},1500)
					}
					
				})
			},
			nextPage(){
				// 下一页
				if(this.pages_index==this.page_length-1){
					uni.showToast({
						icon:'none',
						title:'没有更多了'
					})
					return
				}else{
					this.pages_index++
				}
			},
			lastPage(){
				// 上一页
				if(this.pages_index==0){
					uni.showToast({
						icon:'none',
						title:'当前已经是第一页'
					})
					return
				}else{
					this.pages_index--
				}
			},
			setState(index){
				// 设置禁用/启用
				this.state_index=index;
				this.getDatas();
			},
			setPageIndex(e){
				// 设置当前分页
				this.pages_index=e.detail.value;
			},
			setPagesData(data){
				// 设置分页数据
				let length=(data.length/10).toFixed(0);
				length=parseInt(length);
				let pages_index_item=[];
				var pages=[]
				for(let i =0;i<=length;i++){
					if(data[i*10]){
						this.page_length=i+1;
						let val="第"+(i+1).toString()+"页"
						pages_index_item.push(val)
						let onePage=[];
						for(let h=0;h<10;h++){
							let index=i*10+h;
							if(data[index]){
								onePage.push(data[index])
							}
						}
						pages[i]=onePage;
					}
				}
				this.pages=pages;
				this.pages_index_item=pages_index_item;
			},
			getDatas() {
				//查询所有数据
				let that = this;
				return this.$api.getShops({
					user: this.search_val,
					state: this.state[this.state_index].id
				}).then(function(res) {
					if(res.data.code===501){
						uni.showToast({
							icon:'none',
							title:'暂无数据'
						})
						that.no_more=true
					}else{
						that.no_more=false
					}
					that.allDatas = res.data.data;
					that.setPagesData(res.data.data)
				})
			}
		},
		mounted() {
			//初始化
			this.getDatas()
		}
	}
</script>

<style>

</style>
