<?php
namespace app\admin\controller;
use app\BaseController;
use think\facade\DB;//导入DB类
use think\facade\Request;//导入请求类
use think\facade\Filesystem;//导入文件类
use app\model\User as UserModel;

class User extends BaseController
{
	public function getUsers(){//所有用户
		
		$user=input('post.user');
		$state=input('post.state');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		if($user){
			$res=UserModel::where('email','like','%'.$user.'%')->where('state',$state)->order('id', 'desc')->select();
		}else{
			$res=UserModel::where('state',$state)->order('id', 'desc')->select();
		}
		if(count($res)<1){//判断结果集长度是否大于0
			$rtData['code']=501;
			$rtData['data']=[];
			$rtData['msg']='暂无用户数据';
		}else{
			$rtData['code']=200;
			$rtData['msg']='查询用户成功';
			$rtData['data']=$res;
		}
		return json($rtData);
	}
	
	public function addUser(){//添加用户
		$nick_name=input('post.nick_name');
		$password=input('post.password');
		$email=input('post.email');
		$phone=input('post.phone');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		if(!$nick_name){
			$rtData=[
				'code'=>'502',
				'data'=>'',
				'msg'=>'用户名不能为空'
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
				'msg'=>'手机号不能为空'
			];
		}else{
			$user=new UserModel();
			$res=$user->save([
				'nick_name' => $nick_name,
				'password'=>$password,
				'email'=>$email,
				'phone'=>$phone
			]);
			
			if($res>=1){//判断结果集长度是否大于0
				$rtData['code']=200;
				$rtData['msg']='新建用户成功';
				$rtData['data']=$res;
			}else{
				$rtData['code']=501;
				$rtData['msg']='新建失败';
			}
		}
		return json($rtData);
	}
	
	public function delectUser(){//删除用户
		$id=input('post.id');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=UserModel::find($id)->delete();
		if($res>=1){//判断结果集长度是否大于0
			$rtData['code']=200;
			$rtData['msg']='删除成功';
			$rtData['data']=$res;
		}else{
			$rtData['code']=501;
			$rtData['msg']='删除失败';
		}
		return json($rtData);
	}
	
	public function updateUser(){//保存/修改用户
		$id=input('post.id');
		$nick_name=input('post.nick_name');
		$password=input('post.password');
		$email=input('post.email');
		$phone=input('post.phone');
		$user_img=input('post.user_img');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=UserModel::where('id', $id)
		    ->data(['nick_name' => $nick_name,'password'=>$password,'email'=>$email,'phone'=>$phone,'user_img'=>$user_img])
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
	
	public function disableUser(){//禁用用户
		$id=input('post.id');
		$state=input('post.state');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=UserModel::where('id', $id)
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
