<?php
namespace app\index\controller;

use app\BaseController;

class Index extends BaseController
{
    public function index()
    {
        return '1欧某index';
    }

    public function hello($name = 'ThinkPHP6')
    {
        return 'index方法111' . $name;
    }
}
