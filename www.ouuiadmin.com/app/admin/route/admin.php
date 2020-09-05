<?php
// +----------------------------------------------------------------------
// | ThinkPHP [ WE CAN DO IT JUST THINK ]
// +----------------------------------------------------------------------
// | Copyright (c) 2006~2018 http://thinkphp.cn All rights reserved.
// +----------------------------------------------------------------------
// | Licensed ( http://www.apache.org/licenses/LICENSE-2.0 )
// +----------------------------------------------------------------------
// | Author: liu21st <liu21st@gmail.com>
// +----------------------------------------------------------------------
use think\facade\Route;

Route::group(function(){
        Route::rule('login', 'index/login');
		Route::rule('getProductLists', 'index/getProductLists');
		Route::rule('getProductDetails', 'index/getProductDetails');
		Route::rule('delectProduct', 'index/delectProduct');
		Route::rule('creatProduct', 'index/creatProduct');
		Route::rule('saveProduct', 'index/saveProduct');
		Route::rule('uploadImage', 'index/uploadImage');
		Route::rule('getShopInfo', 'index/getShopInfo');
		Route::rule('saveShop', 'index/saveShop');
		// 用户
		Route::rule('getUsers', 'user/getUsers');
		Route::rule('addUser', 'user/addUser');
		Route::rule('delectUser', 'user/delectUser');
		Route::rule('updateUser', 'user/updateUser');
		Route::rule('disableUser', 'user/disableUser');
		//商家
		Route::rule('getShops', 'shop/getShops');
		Route::rule('addShop', 'shop/addShop');
		Route::rule('updateShop', 'shop/updateShop');
		Route::rule('disableShop', 'shop/disableShop');
		// Route::rule('hello', 'index/hello');
});
