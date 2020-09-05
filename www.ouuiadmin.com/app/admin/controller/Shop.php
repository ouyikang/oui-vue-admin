<?php
namespace app\admin\controller;
use app\BaseController;
use think\facade\DB;//导入DB类
use think\facade\Request;//导入请求类
use think\facade\Filesystem;//导入文件类
use app\model\Shop as ShopModel;

class Shop extends BaseController
{
	public function getShops(){//所有商家
		
		$shop=input('post.shop');
		$state=input('post.state');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		if($shop){
			$res=ShopModel::where('email','like','%'.$shop.'%')->where('state',$state)->order('id', 'desc')->select();
		}else{
			$res=ShopModel::where('state',$state)->order('id', 'desc')->select();
		}
		if(count($res)<1){//判断结果集长度是否大于0
			$rtData['code']=501;
			$rtData['data']=[];
			$rtData['msg']='暂无用户数据';
		}else{
			$rtData['code']=200;
			$rtData['msg']='查询商家成功';
			$rtData['data']=$res;
		}
		return json($rtData);
	}
	
	public function addShop(){//添加商家
		$shop_name=input('post.shop_name');
		$password=input('post.password');
		$email=input('post.email');
		$phone=input('post.phone');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		if(!$shop_name){
			$rtData=[
				'code'=>'502',
				'data'=>'',
				'msg'=>'店铺名称不能为空'
			];
		}else if(!$password){
			$rtData=[
				'code'=>'502',
				'data'=>'',
				'msg'=>'密码不能为空'
			];
		}else if(!$email){
			$rtData=[
				'code'=>'502',
				'data'=>'',
				'msg'=>'邮箱不能为空'
			];
		}else if(!$phone){
			$rtData=[
				'code'=>'502',
				'data'=>'',
				'msg'=>'手机号码不能为空'
			];
		}else{
			$shop=new ShopModel();
			$res=$shop->save([
				'shop_name' => $shop_name,
				'password'=>$password,
				'email'=>$email,
				'phone'=>$phone
			]);
			
			if($res>=1){//判断结果集长度是否大于0
				$rtData['code']=200;
				$rtData['msg']='新建商家成功';
				$rtData['data']=$res;
			}else{
				$rtData['code']=501;
				$rtData['msg']='新建失败';
			}
		}
		return json($rtData);
	}
	
	
	public function updateShop(){//保存/修改商家
		$id=input('post.id');
		$shop_name=input('post.shop_name');
		$password=input('post.password');
		$email=input('post.email');
		$phone=input('post.phone');
		$shop_img=input('post.shop_img');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=ShopModel::where('id', $id)
		    ->data(['shop_name' => $shop_name,'password'=>$password,'email'=>$email,'phone'=>$phone,'shop_img'=>$shop_img])
		    ->update();
		if($res>=0){//判断结果集长度是否大于0
			$rtData['code']=200;
			$rtData['msg']='保存成功';
			$rtData['data']=$res;
		}else{
			$rtData['code']=501;
			$rtData['msg']='保存失败';
			$rtData['data']=$res;
		}
		return json($rtData);
	}
	
	public function disableShop(){//禁用店铺
		$id=input('post.id');
		$state=input('post.state');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=ShopModel::where('id', $id)
		    ->data(['state' => $state])
		    ->update();
		if($state==-1){
			$msg='禁用成功';
		}else{
			$msg='启用成功';
		}
		
		if($res>=0){//判断结果集长度是否大于0
			$rtData['code']=200;
			$rtData['msg']=$msg;
			$rtData['data']=$res;
		}else{
			$rtData['code']=501;
			$rtData['msg']='禁用失败';
			$rtData['data']=$res;
		}
		return json($rtData);
	}
	
	
}
