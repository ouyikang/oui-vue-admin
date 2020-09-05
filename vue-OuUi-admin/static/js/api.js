
import Vue from 'vue';
import axios from './requst.js'
import conf from './config.js'
export const api = {}
// 通用接口
var host=conf.host;
api.login = function (data) {
	return axios().post('login',data)
}

// 用户管理
api.getUsers = function (data) {
	return axios().post('getUsers',data)
}
api.addUser = function (data) {
	return axios().post('addUser',data)
}
api.delectUser = function (data) {
	return axios().post('delectUser',data)
}
api.updateUser = function (data) {
	return axios().post('updateUser',data)
}
api.disableUser = function (data) {
	return axios().post('disableUser',data)
}
//商家管理
api.getShops = function (data) {
	return axios().post('getShops',data)
}
api.addShop = function (data) {
	return axios().post('addShop',data)
}
api.updateShop = function (data) {
	return axios().post('updateShop',data)
}
api.disableShop = function (data) {
	return axios().post('disableShop',data)
}
api.install = function (Vue) {
    // 1. 添加全局方法或属性
    Vue.$api = api
    // 4. 添加实例方法
    Vue.prototype.$api = api
}

export default api

Vue.use(api)
