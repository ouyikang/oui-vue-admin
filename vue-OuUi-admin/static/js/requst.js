"use strict";

import Vue from 'vue';
import conf from './config.js'


// Full config:  https://github.com/axios/axios#request-config
// axios.defaults.baseURL = process.env.baseURL || process.env.apiUrl || '';
// axios.defaults.headers.common['Authorization'] = AUTH_TOKEN;
// axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';


let axios = {
	cgi: conf.host + '/admin/',
	defaultConfig: {
		loading: true,
		message: true,
		header: {
			'X-Requested-With': 'XMLHttpRequest'
		},
		success: (res) => {
			if (res.statusCode != 200) {
				if (typeof axios.fail === 'function') {
					axios.fail(res)
				}
				axios.responseError(res)
			} else {
				res.config = axios.config
				if (typeof axios.success === 'function') {
					axios.success(res)
				}
				axios.responseSuccess(res)
			}
		},
		complete: (res) => {
			res.config = axios.config
			if (typeof axios.complete === 'function') {
				axios.complete(res)
			}
			if (res.config.loading) {
				uni.hideLoading()
			}
		}
	},
	
	config: {},
	
	create(config) {
		let mergeConfig = this.defaultConfig;
		mergeConfig.header = {};
		mergeConfig = Object.assign(mergeConfig, config);
		this.config = mergeConfig;
		return this;
	},
	
	request (url, data, success, fail) {
		this.config.url = this.cgi + url
		this.config.data = data
		this.success = success
		this.fail = fail
		if (this.config.loading) {
			uni.showLoading({mask:true})
		}
		uni.request(this.config)
	},
	
	get (url, data) {
		let ins = this
		return new Promise(function(reslove, reject) {
			ins.config.method = 'GET'
			ins.request(url, data, reslove, reject)
		})
	},
	post (url, data, query) {
		let ins = this
		return new Promise(function(reslove, reject) {
			ins.config.method = 'POST'
			// let params = common.paramtostr(query)
			let params = query
			ins.request(url + (params ? '?'+ params : ''), data, reslove, reject)
		})
	},
	put (url, data) {
		let ins = this
		return new Promise(function(reslove, reject) {
			ins.config.method = 'PUT'
			ins.request(url, data, reslove, reject)
		})
	},
	delete (url, data) {
		let ins = this
		return new Promise(function(reslove, reject) {
			ins.config.method = 'DELETE'
			ins.request(url, data, reslove, reject)
		})
	},
	
	success: false,
	fail: false,
	
	responseSuccess(res) {
		let data = res.data;
		let config = res.config
		if (config.message === true) {
			if (data.code === 1 && data.msg !== '') {
				uni.showToast({
					icon: 'success',
					mask: true,
					title: data.msg
				})
			} else if (data.code === 0) {
				if (data.msg !== '') {
					uni.showToast({
						icon: 'none',
						mask: true,
						title: data.msg
					})
				} else {
					uni.showToast({
						icon: 'none',
						mask: true,
						title: '数据异常，请稍后再试'
					})
				}
			}
		}
		if (data.code === -11) {
			uni.showToast({
				icon: 'none',
				mask: true,
				title: '登录凭据已失效'
			})
		}
	},
	responseError(error) {
		let config = error.config;
		let data = error.data;
		let code = error.statusCode;
		if (data) {			
			if(code == '401') {
				uni.navigateTo({
					url: '/pages/session/login'
				})
			} else {
				uni.showToast({
					icon: 'none',
					mask: true,
					title: '网络异常，状态码:' + request.statusCode
				})
			}
		} else {
			uni.showToast({
				icon: 'none',
				mask: true,
				title: '网络异常，请稍后再试'
			})
		}
	}

}


/**
 * 常规请求
 */
let ajax = (custom) => {
	return axios.create(custom)
};

ajax.install = function(Vue) {
	Vue.prototype.$axios = ajax;
};

export default ajax

Vue.use(ajax)
