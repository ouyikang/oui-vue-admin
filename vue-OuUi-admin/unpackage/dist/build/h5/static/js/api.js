
import Vue from 'vue';
import axios from './requst.js'
export const api = {}
 
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



api.install = function (Vue) {
    // 1. 添加全局方法或属性
    Vue.$api = api
    // 4. 添加实例方法
    Vue.prototype.$api = api
}

export default api

Vue.use(api)
