/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50726
Source Host           : localhost:3306
Source Database       : shop

Target Server Type    : MYSQL
Target Server Version : 50726
File Encoding         : 65001

Date: 2020-09-05 17:02:09
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `admin`
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `user` varchar(255) NOT NULL COMMENT '登录账号',
  `password` varchar(255) NOT NULL COMMENT '登录密码',
  `nickName` varchar(255) DEFAULT NULL COMMENT '后台人员名称',
  `email` varchar(255) DEFAULT NULL COMMENT '邮箱，用于重设密码',
  `phone` varchar(255) DEFAULT NULL COMMENT '手机，用于重设密码',
  `adminImg` varchar(255) DEFAULT NULL COMMENT '后台人员头像',
  `id` int(11) NOT NULL COMMENT '后台管理id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('admin', 'admin', '欧某', '1143954601@qq.com', '13178898274', 'img/test.png', '1');

-- ----------------------------
-- Table structure for `products`
-- ----------------------------
DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `productName` varchar(255) DEFAULT NULL,
  `productImg` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of products
-- ----------------------------
INSERT INTO `products` VALUES ('3', '我是产品2', 'http://www.ouyikang.com/storage/upload/20200817/e06918efcd4f4cd1ebc4c8c9e128ecea.jpg', 'https://www.baidu.com', '1');
INSERT INTO `products` VALUES ('2', '我是产品1', 'http://www.ouyikang.com/storage/upload/20200817/c4f95571ddc35f35c65b81765d12e424.jpg', 'https://www.taobao.com', '1');
INSERT INTO `products` VALUES ('4', '我是产品3', 'http://www.ouyikang.com/storage/upload/20200817/586b3e26cb1bd6c102318263aec76f1c.png', 'https://www.baidu.com', '1');
INSERT INTO `products` VALUES ('5', '4', 'http://www.ouyikang.com/storage/upload/20200817/37eeaaa9c00d629df1fbe1192233ddbd.png', 'https://www.taobao.com', '1');
INSERT INTO `products` VALUES ('6', '5', 'http://www.ouyikang.com/storage/upload/20200817/37eeaaa9c00d629df1fbe1192233ddbd.png', 'http://www.carned.cn', '1');

-- ----------------------------
-- Table structure for `think_shop`
-- ----------------------------
DROP TABLE IF EXISTS `think_shop`;
CREATE TABLE `think_shop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `shop_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL DEFAULT '888888' COMMENT '商家登录密码',
  `phone` varchar(255) DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `update_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `shop_img` varchar(255) DEFAULT 'storage/upload/20200817/user.jpg',
  `state` int(11) NOT NULL DEFAULT '1',
  `product_num` int(11) NOT NULL DEFAULT '0' COMMENT '商家的全部商品数量（包含已上架和未上架）',
  `deal_num` int(11) NOT NULL DEFAULT '0' COMMENT '成交总订单数量(已付款之后的，且包含已退款)',
  `deal_price` float(11,2) NOT NULL DEFAULT '0.00' COMMENT '商家成交的总金额（包含退款金额）',
  `money` float(11,2) NOT NULL DEFAULT '0.00' COMMENT '商家当前可提现余额',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of think_shop
-- ----------------------------
INSERT INTO `think_shop` VALUES ('1', '中粤名车', '1143954601@qq.com', '888888', '18888888888', '2020-09-03 19:34:45', '2020-09-03 19:34:45', '广东省广州市黄河沙河东路3号中粤广场', '广州市', 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('2', '欧某小店1号', '114395460@qq.com', '888888', '13178898274', '2020-09-03 20:41:20', '2020-09-03 20:41:20', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('3', '欧某小店2号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:37', '2020-09-03 20:42:37', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('4', '欧某小店2号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:39', '2020-09-03 20:42:39', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('5', '欧某小店2号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:43', '2020-09-03 20:42:43', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('6', '欧某小店2号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:45', '2020-09-03 20:42:45', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('7', '欧某小店3号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:47', '2020-09-03 20:42:47', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('8', '欧某小店3号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:49', '2020-09-03 20:42:49', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('9', '欧某小店3号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:50', '2020-09-03 20:42:50', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('10', '欧某小店3号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:51', '2020-09-03 20:42:51', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('11', '欧某小店3号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:51', '2020-09-03 20:42:51', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('12', '欧某小店4号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:54', '2020-09-03 20:42:54', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('13', '欧某小店4号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:54', '2020-09-03 20:42:54', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('14', '欧某小店4号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:55', '2020-09-03 20:42:55', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('15', '欧某小店4号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:55', '2020-09-03 20:42:55', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('16', '欧某小店4号', '1143954601@qq.com', '888888', '13178898274', '2020-09-04 21:25:15', '2020-09-04 21:25:15', null, null, 'storage/upload/20200817/user.jpg', '-1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('17', '欧某小店4号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:56', '2020-09-03 20:42:56', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('18', '欧某小店4号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:57', '2020-09-03 20:42:57', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('19', '欧某小店4号', '1143954601@qq.com', '888888', '13178898274', '2020-09-04 21:25:18', '2020-09-04 21:25:18', null, null, 'storage/upload/20200817/user.jpg', '-1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('20', '欧某小店4号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:58', '2020-09-03 20:42:58', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('21', '欧某小店4号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:42:59', '2020-09-03 20:42:59', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('22', '欧某小店5号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:01', '2020-09-03 20:43:01', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('23', '欧某小店5号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:02', '2020-09-03 20:43:02', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('24', '欧某小店5号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:02', '2020-09-03 20:43:02', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('25', '欧某小店5号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:03', '2020-09-03 20:43:03', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('26', '欧某小店5号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:03', '2020-09-03 20:43:03', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('27', '欧某小店5号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:04', '2020-09-03 20:43:04', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('28', '欧某小店5号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:05', '2020-09-03 20:43:05', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('29', '欧某小店5号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:05', '2020-09-03 20:43:05', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('30', '欧某小店5号', '1143954601@qq.com', '888888', '13178898274', '2020-09-04 21:01:37', '2020-09-04 21:01:37', null, null, 'storage/upload/20200904/c409412990ebd02756a0bbad4f47110d.png', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('31', '欧某小店6号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:09', '2020-09-03 20:43:09', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('32', '欧某小店6号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:09', '2020-09-03 20:43:09', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('33', '欧某小店6号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:10', '2020-09-03 20:43:10', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('34', '欧某小店6号', '1143954601@qq.com', '888888', '13178898274', '2020-09-03 20:43:10', '2020-09-03 20:43:10', null, null, 'storage/upload/20200817/user.jpg', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('35', '欧某小店6号', '1143954601@qq.com', '888888', '13178898274', '2020-09-04 21:01:24', '2020-09-04 21:01:24', null, null, 'storage/upload/20200904/eaf1534a0d4413efb501b8beb104758e.png', '1', '0', '0', '0.00', '0.00');
INSERT INTO `think_shop` VALUES ('36', '欧某小店6号', '1143954601@qq.com', '888888', '13178898274', '2020-09-04 20:02:44', '2020-09-04 20:02:44', null, null, 'storage/upload/20200817/user.jpg', '-1', '0', '0', '0.00', '0.00');

-- ----------------------------
-- Table structure for `think_user`
-- ----------------------------
DROP TABLE IF EXISTS `think_user`;
CREATE TABLE `think_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id,唯一标识符',
  `email` varchar(255) DEFAULT NULL COMMENT '用户邮箱，用于登录',
  `password` varchar(255) DEFAULT '888888' COMMENT '用户密码',
  `phone` varchar(255) DEFAULT NULL COMMENT '用户手机，用于登录',
  `nick_name` varchar(255) DEFAULT NULL COMMENT '用户昵称',
  `user_img` varchar(255) DEFAULT 'storage/upload/20200817/user.jpg' COMMENT '用户头像地址',
  `state` int(11) DEFAULT '1' COMMENT '账号状态：-1禁用，1正常使用',
  `create_time` timestamp NULL DEFAULT NULL,
  `update_time` timestamp NULL DEFAULT NULL,
  `deal_price` float(11,2) NOT NULL DEFAULT '0.00' COMMENT '成交金额（包含已退款）',
  `deal_num` int(11) NOT NULL DEFAULT '0' COMMENT '成交数量(包含已退款)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of think_user
-- ----------------------------
INSERT INTO `think_user` VALUES ('34', '114395460@qq.com', '666666', '13178898274', '欧某1号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:36:41', '2020-09-02 20:36:41', '0.00', '0');
INSERT INTO `think_user` VALUES ('35', '114395460@qq.com', '666666', '13178898274', '欧某2号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:36:43', '2020-09-02 20:36:43', '0.00', '0');
INSERT INTO `think_user` VALUES ('36', '114395460@qq.com', '666666', '13178898274', '欧某3号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:36:46', '2020-09-02 20:36:46', '0.00', '0');
INSERT INTO `think_user` VALUES ('37', '114395460@qq.com', '666666', '13178898274', '欧某4号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:36:48', '2020-09-02 20:36:48', '0.00', '0');
INSERT INTO `think_user` VALUES ('38', '114395460@qq.com', '666666', '13178898274', '欧某5号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:36:50', '2020-09-02 20:36:50', '0.00', '0');
INSERT INTO `think_user` VALUES ('39', '114395460@qq.com', '666666', '13178898274', '欧某6号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:36:53', '2020-09-02 20:36:53', '0.00', '0');
INSERT INTO `think_user` VALUES ('40', '114395460@qq.com', '666666', '13178898274', '欧某7号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:36:55', '2020-09-02 20:36:55', '0.00', '0');
INSERT INTO `think_user` VALUES ('41', '114395460@qq.com', '666666', '13178898274', '欧某8号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:36:59', '2020-09-02 20:36:59', '0.00', '0');
INSERT INTO `think_user` VALUES ('42', '114395460@qq.com', '666666', '13178898274', '欧某9号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:37:03', '2020-09-02 20:37:03', '0.00', '0');
INSERT INTO `think_user` VALUES ('43', '114395460@qq.com', '666666', '13178898274', '欧某10号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:37:06', '2020-09-02 20:37:06', '0.00', '0');
INSERT INTO `think_user` VALUES ('44', '114395460@qq.com', '666666', '13178898274', '欧某11号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:37:08', '2020-09-02 20:37:08', '0.00', '0');
INSERT INTO `think_user` VALUES ('45', '114395460@qq.com', '666666', '13178898274', '欧某12号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:37:11', '2020-09-02 20:37:11', '0.00', '0');
INSERT INTO `think_user` VALUES ('46', '114395460@qq.com', '666666', '13178898274', '欧某13号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:37:14', '2020-09-02 20:37:14', '0.00', '0');
INSERT INTO `think_user` VALUES ('47', '114395460@qq.com', '666666', '13178898274', '欧某14号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:37:17', '2020-09-02 20:37:17', '0.00', '0');
INSERT INTO `think_user` VALUES ('48', '114395460@qq.com', '666666', '13178898274', '欧某15号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:37:20', '2020-09-02 20:37:20', '0.00', '0');
INSERT INTO `think_user` VALUES ('49', '114395460@qq.com', '666666', '13178898274', '欧某16号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:37:22', '2020-09-02 20:37:22', '0.00', '0');
INSERT INTO `think_user` VALUES ('50', '114395460@qq.com', '666666', '13178898274', '欧某17号', 'storage/upload/20200817/user.jpg', '1', '2020-09-02 20:37:25', '2020-09-02 20:37:25', '0.00', '0');
INSERT INTO `think_user` VALUES ('51', '1143954601@qq.com', '6666667', '13178898274', '欧某88号', 'storage/upload/20200904/47e6cf713f0f75898248d08b1ae6407c.jpg', '1', '2020-09-02 20:37:28', '2020-09-02 20:37:28', '0.00', '0');
INSERT INTO `think_user` VALUES ('52', '114395460@qq.com', '666667', '13178898274', '欧某19号', 'storage/upload/20200817/user.jpg', '-1', '2020-09-02 20:37:30', '2020-09-02 20:37:30', '0.00', '0');
