/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : net29172485

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2016-09-13 23:26:51
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `my_concern`
-- ----------------------------
DROP TABLE IF EXISTS `my_concern`;
CREATE TABLE `my_concern` (
  `id` int(11) NOT NULL auto_increment COMMENT '我的关注',
  `userid` int(11) NOT NULL default '0' COMMENT '用户id',
  `good_id` int(11) default NULL COMMENT '商品Id',
  `good_name` varchar(255) character set gbk default NULL COMMENT '商品名称',
  `flog` int(11) default '0' COMMENT '标识',
  `time` int(13) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of my_concern
-- ----------------------------
