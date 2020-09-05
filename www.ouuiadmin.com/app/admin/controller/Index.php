<?php
namespace app\admin\controller;
use app\BaseController;
use think\facade\DB;//导入DB类
use think\facade\Request;//导入请求类
use think\facade\Filesystem;//导入文件类
class Index extends BaseController
{
    public function index()
    {
        return '1欧某admin';
    }

    public function hello($name = 'ThinkPHP6')
    {
        return 'admin方法1111,' . $name;
    }
	
	public function add(){//增加
		$data = ['email' => '2','password' => '1233'];
		$res=Db::name('user')->save($data);
		print_r($res);
	}
	
	
	public function delect(){//删除
		//根据主键删除:
		// Db::table('think_user')->delete(1);
		// Db::table('think_user')->delete([1,2,3]);
		//根据条件删除:
		// Db::table('think_user')->where('id',1)->delete();
		// Db::table('think_user')->where('id','<',10)->delete();
		$res=Db::table('user')->delete(3);
		print_r($res);
	}
	
	public function select(){//查询
		$res=Db::table('user')->where('state', 1)->select();
		halt($res[0]['nickName']);
	}
	
	public function change(){//修改
		Db::name('user')
		    ->where('id', 1)
		    ->data(['name' => 'thinkphp'])
		    ->update();
		$res=Db::name('user')->save($data);
		print_r($res);
	}
	
	
	public function login(){//登录
		header('Content-Type:application/json; charset=utf-8');
		$user=input('post.user');
		$password=input('post.password');
		$rtData=[
			'code'=>'404',
			'data'=>$user,
			'msg'=>'网络错误'
		];
		$res=Db::table('admin')->where('user',$user)->select();
		if(count($res)<1){//判断结果集长度是否大于0
			$rtData['code']=501;
			$rtData['msg']='该账号尚未注册';
		}else{	
			if($res[0]['password']==$password){
				$rtData['code']=200;
				$rtData['msg']='登录成功';
			}else{
				$rtData['code']=502;
				$rtData['msg']='密码错误';
			}
		}
		return json($rtData);
	}
	
	public function getProductLists(){//查询产品列表
	
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=Db::table('products')->where('status','1')->select();
		if(count($res)<1){//判断结果集长度是否大于0
			$rtData['code']=501;
			$rtData['msg']='暂无产品数据';
		}else{
			$rtData['code']=200;
			$rtData['msg']='查询产品成功';
			$rtData['data']=$res;
		}
		return json($rtData);
	}
	
	public function getProductDetails(){//查询产品详情
		$id=input('post.id');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=Db::table('products')->where('id',$id)->select();
		if(count($res)<1){//判断结果集长度是否大于0
			$rtData['code']=501;
			$rtData['msg']='暂无产品数据';
		}else{
			$rtData['code']=200;
			$rtData['msg']='查询产品成功';
			$rtData['data']=$res;
		}
		return json($rtData);
	}
	
	
	public function delectProduct(){//删除产品
		$id=input('post.id');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=Db::table('products')->where('id',$id)->delete();
		if($res>=1){//判断结果集长度是否大于0
			$rtData['code']=200;
			$rtData['msg']='删除产品成功';
			$rtData['data']=$res;
		}else{
			$rtData['code']=501;
			$rtData['msg']='删除失败';
		}
		return json($rtData);
	}
	
	
	public function saveProduct(){//保存/修改产品
		$id=input('post.id');
		$productName=input('post.productName');
		$productImg=input('post.productImg');
		$link=input('post.link');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=Db::name('products')
		    ->where('id', $id)
		    ->data(['productName' => $productName,'productImg'=>$productImg,'link'=>$link])
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
	
	public function creatProduct(){//新建产品
		$productName=input('post.productName');
		$productImg=input('post.productImg');
		$link=input('post.link');
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$data = ['productName' => $productName,'productImg'=>$productImg,'link'=>$link,'status'=>'1'];
		$res=Db::name('products')->save($data);
		
		if($res>=1){//判断结果集长度是否大于0
			$rtData['code']=200;
			$rtData['msg']='新建产品成功';
			$rtData['data']=$res;
		}else{
			$rtData['code']=501;
			$rtData['msg']='新建失败';
		}
		return json($rtData);
	}
	
	public function uploadImage () {
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		
		$file = request()->file('image');
		    // 上传到本地服务器
		 if (is_null($file)) {
		        // 请检查请求类型和表单编码
		        // 不是post请求或没有指定enctype="multipart/form-data"会进入这里
			throw new \think\Exception('没有文件上传');
		}	
			
		$savename = \think\facade\Filesystem::disk('public')->putFile('upload',$file);
		$rtData['data']=$savename;
		$rtData['code']=200;
		$rtData['msg']='上传成功';
		return json($rtData);
	}
	
	
	public function getShopInfo(){//查询商家信息
		
		header('Content-Type:application/json; charset=utf-8');
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=Db::table('shop_info')->where('id',1)->select();
		if(count($res)<1){//判断结果集长度是否大于0
			$rtData['code']=501;
			$rtData['msg']='暂无数据';
		}else{
			$rtData['code']=200;
			$rtData['msg']='查询成功';
			$rtData['data']=$res;
		}
		return json($rtData);
	}
	
	public function saveShop(){//保存商家信息
		header('Content-Type:application/json; charset=utf-8');
		
		$shopName=input('post.shopName');
		$city=input('post.city');
		$address=input('post.address');
		$headUrl=input('post.headUrl');
		
		$rtData=[
			'code'=>'404',
			'data'=>'',
			'msg'=>'网络错误'
		];
		$res=Db::name('shop_info')
		    ->where('id', 1)
		    ->data(['shopName' => $shopName,'city'=>$city,'address'=>$address,'headUrl'=>$headUrl])
		    ->update();
			
		if($res>=0){//判断结果集长度是否大于0
			$rtData['code']=200;
			$rtData['msg']='保存成功';
			$rtData['data']=$res;
		}else{
			$rtData['code']=501;
			$rtData['msg']='保存失败';
		}
		return json($rtData);
	}
	
}
