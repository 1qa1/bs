/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80029
 Source Host           : localhost:3306
 Source Schema         : agrisystem

 Target Server Type    : MySQL
 Target Server Version : 80029
 File Encoding         : 65001

 Date: 06/01/2023 13:22:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for agri_check
-- ----------------------------
DROP TABLE IF EXISTS `agri_check`;
CREATE TABLE `agri_check`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '检测表的id',
  `cid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上链的检测信息的key',
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应的商品的key',
  `create_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agri_check
-- ----------------------------
INSERT INTO `agri_check` VALUES (5, 'e6adab3a-2e8b-4a9e-8198-78e8608f2047', '大西瓜', NULL, NULL, NULL, NULL);
INSERT INTO `agri_check` VALUES (6, '37097561-da2a-41ab-958b-2dff31c6cf96', '大西瓜', NULL, NULL, NULL, NULL);
INSERT INTO `agri_check` VALUES (7, '3b49e238-26b3-4814-8945-03c5ef6db496', '大西瓜', NULL, NULL, NULL, NULL);
INSERT INTO `agri_check` VALUES (8, 'e7f8a3a5-f3b7-4c3c-88fa-023d3343711a', '大西瓜', NULL, NULL, NULL, NULL);
INSERT INTO `agri_check` VALUES (9, '816cefb3-b406-4dc2-b1cd-25b6c0923763', '大西瓜', NULL, NULL, NULL, NULL);
INSERT INTO `agri_check` VALUES (10, '7bb9108d-4e18-4c68-af0f-f92674a661fb', '大西瓜', NULL, NULL, NULL, NULL);
INSERT INTO `agri_check` VALUES (11, '2eec96a2-4519-4996-bf2e-37dfb5491899', '大西瓜', NULL, NULL, NULL, NULL);
INSERT INTO `agri_check` VALUES (12, 'ff718d0a-5e9c-4ef8-ac19-315f2ae46d21', '大西瓜', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for agri_fertilizer
-- ----------------------------
DROP TABLE IF EXISTS `agri_fertilizer`;
CREATE TABLE `agri_fertilizer`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '肥料表ID',
  `fid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应链上肥料表的key',
  `gid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '赌赢链上种植信息的key',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agri_fertilizer
-- ----------------------------

-- ----------------------------
-- Table structure for agri_grow
-- ----------------------------
DROP TABLE IF EXISTS `agri_grow`;
CREATE TABLE `agri_grow`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '种植表的ID',
  `gid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应的种植信息的key',
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应的商品的key',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agri_grow
-- ----------------------------
INSERT INTO `agri_grow` VALUES (7, '87d4b729-510a-45ae-81ac-521ca801db82', NULL);
INSERT INTO `agri_grow` VALUES (8, '6ff0f4da-a5c3-496e-9e56-fe82eebf6389', NULL);
INSERT INTO `agri_grow` VALUES (9, '1014d3c5-f320-45d0-8848-7919e9582ec4', NULL);
INSERT INTO `agri_grow` VALUES (10, '709c7b57-4fb9-4de0-93de-61662f826cc4', NULL);

-- ----------------------------
-- Table structure for agri_medicine
-- ----------------------------
DROP TABLE IF EXISTS `agri_medicine`;
CREATE TABLE `agri_medicine`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用药表ID',
  `mid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应链上的用药信息key',
  `gid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应的链上的种植信息的key',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agri_medicine
-- ----------------------------
INSERT INTO `agri_medicine` VALUES (6, '45cb4a66-6910-4fd7-90e3-bceca9832dbf', NULL);
INSERT INTO `agri_medicine` VALUES (7, '6745ec93-1c10-49ef-80f9-fd49f340506b', NULL);
INSERT INTO `agri_medicine` VALUES (9, 'fd1a8fd8-4bb1-414e-8114-2d15a86203e2', NULL);

-- ----------------------------
-- Table structure for agri_official
-- ----------------------------
DROP TABLE IF EXISTS `agri_official`;
CREATE TABLE `agri_official`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '官方抽查的id',
  `oid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '上链的官方抽查的key',
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应的商品的上链id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 22 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agri_official
-- ----------------------------

-- ----------------------------
-- Table structure for agri_product
-- ----------------------------
DROP TABLE IF EXISTS `agri_product`;
CREATE TABLE `agri_product`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '商品的ID',
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '商品的key',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应商品的运输id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 42 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agri_product
-- ----------------------------

-- ----------------------------
-- Table structure for agri_routine
-- ----------------------------
DROP TABLE IF EXISTS `agri_routine`;
CREATE TABLE `agri_routine`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '日常检测ID',
  `rid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日常检测上链的ID',
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应的商品上链的ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agri_routine
-- ----------------------------

-- ----------------------------
-- Table structure for agri_sell
-- ----------------------------
DROP TABLE IF EXISTS `agri_sell`;
CREATE TABLE `agri_sell`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '销售表的ID',
  `sid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '销售信息上链Key',
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对应的商品的Key',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agri_sell
-- ----------------------------

-- ----------------------------
-- Table structure for agri_transport
-- ----------------------------
DROP TABLE IF EXISTS `agri_transport`;
CREATE TABLE `agri_transport`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '运输表的ID',
  `tid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '运输信息的上链key',
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '所运输的商品的上链key',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agri_transport
-- ----------------------------
INSERT INTO `agri_transport` VALUES (2, '99096269-fdb5-4ad6-84cc-2d3f924d46dd', '大西瓜');
INSERT INTO `agri_transport` VALUES (5, 'a6eec44c-d0b4-4006-bcc2-dced7053ab1a', '大西瓜');

-- ----------------------------
-- Table structure for agri_tx
-- ----------------------------
DROP TABLE IF EXISTS `agri_tx`;
CREATE TABLE `agri_tx`  (
  `pid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品的Key',
  `txid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易hash',
  `timestamp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '交易时间戳',
  PRIMARY KEY (`pid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of agri_tx
-- ----------------------------
INSERT INTO `agri_tx` VALUES ('067ab403-f095-4740-b332-03fdee84cb5b', '784c7a911654a0607a59fab67462c8022a80524425bf7e29775d0ca5ded5c558', '2023-01-01 04:39:11.494 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('0c0a6d4e-3f8c-494d-baf7-ab8b3fb5d14d', 'e0f145db45b96a9dad1829933c88283afd1e72352a420158d92ee7745f5f28ed', '2023-01-01 08:27:21.133 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('0db96b04-a765-444a-8e3f-f26fe41115d5', '8cba5f86fe758bd01a88a0ccb6112da54122fbbb10cb684d3476f6541f1e9c9e', '2022-12-31 09:05:18.636 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('24e97bcb-ad6b-42d3-9259-8573b602838b', '6ba49ba6b4d84876cfc400f1ccfb705d63ea27e45ad8181fc0d00ee5ad24fc4b', '2023-01-01 04:35:42.955 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('2b4e6e75-9c1e-42cf-93ae-39331521a589', '3ded6405eab2ba03c07387de1ff35398f60fea978c2851f4b11e76830d24ba2e', '2022-12-31 08:20:47.843 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('3146b878-0063-4a3f-a945-24b5ee58644d', '3708637441b7353d048e4fe739a486be8c31d098f266e10bbdb3821f90bbee1a', '2023-01-01 08:22:23.909 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('33d4718e-becc-41f0-997a-9585a24cf114', '6e5e369b818eb06fc5c60cecd670c174e2afc63e2b39edd5fc553c33ce61e764', '2023-01-01 08:13:31.329 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('3543a526-d7ce-482a-a0da-eaab47316177', '420fa64e07b74a0a6551c733776429d64bc6b48b758eacba8ed118037faaca07', '2023-01-01 04:36:55.741 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('4b7e2f0c-5d34-4d1b-bb0a-1690a73afa45', 'e903b160b7ed41e0d9c0305d335578108edfada9bc7ceec591212079151deec8', '2023-01-01 04:39:36.644 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('5a1a4c1b-11f7-4451-9275-8e6957cb071c', 'a8db84c823d130b6b1aac777fb0408fb3fa4b6e1777fb89e80074350977c1a42', '2022-12-31 08:27:41.969 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('5ccab7b7-d5b4-4ed8-bb79-dcb9ddfe169e', '0cdce6d8da1f474591e54b2e8dcc47929902d91e8eb1d5271e9b8a3a7de052e3', '2023-01-01 08:20:42.514 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('5e311fd9-25ca-4246-8e95-5edd564ea537', '85fefe83cd3e18cfb0b0a47e5fe2e8ba5bcdf2da6e5ea0aeaf5a37caf33b4ae2', '2022-12-31 11:18:16.471 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('742941bc-55f4-465a-b519-7fce542ee262', '53ea8f39188d578c380b2499d99c3a389c8de3d6f0d57ed27ff8ca306fbc2121', '2022-12-31 08:20:29.681 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('75f01586-37c6-442b-9ba9-3b113e5b9236', '85a7844e049956cac44da39a5aa1458c7fd7ed0c1e4116a9d9fa98d7ff8474f6', '2023-01-01 08:19:39.344 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('78ecb015-5c25-4990-b233-8ebedb9ca5d2', 'bd840612720db3e8b6da55d4afd7e128d18de279f3d94528993d5b9333b02a7f', '2023-01-01 08:18:12.94 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('7c3efddc-2dbe-4203-b1d8-0c78f7a3c68b', '0d100e77a4324c7e54c26a27aeae0dadb7808ca9c2a7e8587dfeb6bcc1c47ebe', '2023-01-01 04:35:01.726 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('81d1fa19-f022-436a-b1c6-7991bf8d27ea', '10aa1241658430dd0c032f7eb38699719f729768b5bcd2e4380b392bd722ea47', '2023-01-01 08:26:55.393 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('893f0e01-a148-498a-a2e2-127b5c3c4049', 'cac3f866d0f285e9d1870b8697af3e6b65abb180c2995722801abe88ff31400d', '2022-12-31 10:29:14.014 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('8bbb62fe-de28-440f-ae5d-7868602f09aa', 'ab40c9807b585da05e75901a797c5b3a2cb6e4f3f395535404a978a2299831f2', '2022-12-31 08:37:22.947 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('96c3b54a-dd6a-4321-9969-9c1bc1296e71', 'e294f30fdb2e094703fcc593e1725dcdd8b7a3840673e5c1ff82cc75247bd7d6', '2023-01-01 08:23:59.73 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('9a7eeb5b-eacb-45e1-b9f2-310c4bc07c83', '009b12972c1a3e91276973c5a37915fbe271fab68eb3d544b74235b0139159a8', '2022-12-31 08:34:09.738 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('9e176d25-24f5-4502-a64d-cc93771d2db5', 'd21540c6d0d4fb6923679737e3e04fb18ae13919ef92ef945260cf38f540e357', '2022-12-31 11:17:47.27 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('a1c26193-563e-4e0b-9e6a-fbeadfd62a9f', 'a1345d90f72b6802d092afc1edc32e8569739d40ad3c95a9e11f0120a166d6db', '2023-01-01 04:37:41.708 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('a253949e-149a-4724-9816-4fbe9e5b23da', 'e7dcfe7482e879da7575f6523206d9d93dc3cb1903d18404883be2b3980acb8d', '2023-01-01 04:35:19.641 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('a2922834-1bbe-4266-b308-ba7be0f6009d', 'd6ddca02116dcfa447b2044efc7bab3479e2e115e01a4d8ccfbc6db72f9e0aec', '2022-12-31 10:02:26.982 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('a3543d07-cb94-441e-af5c-63d4978ae0f6', '0b1482bc7a3cff26fbdcb5329f4e0cce749a8883c2e941b711a67289081b9ecc', '2022-12-31 10:01:19.135 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('b4f10878-8eef-4253-b4c4-eeaa48c21e27', '2aaa5a674ad4d930b83241788bebed86f4da4fbb111dd21c04d1a97729b5092d', '2023-01-01 08:21:44.589 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('b8d1dec5-034e-48e8-9124-a52d1a6b9d86', '1cc450402a85b026d01583dfbb12eddffc0f99247daa0686386aca45f3079998', '2023-01-01 08:24:55.801 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('ba7cc7c1-0211-4ac4-8952-e47a8457cde7', 'b0c14d75947c86b412d11cbe4a8fd2ef5e1d11b021b52da184d4c97b0aaca2f3', '2023-01-01 08:25:45.1 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('bd363267-8ad0-4daf-945b-8a35332a556e', '11866a3b8e8a05c6a41593774b9eb15c429b316fec16116544f888d0b9b6203f', '2023-01-01 08:20:10.75 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('c334c3f9-d4df-48c3-9e8f-a68326aa4296', 'b5cc750dd4355dad06cdfbc3db8aa675233703bfea122bfa1239ad6be97e7e4e', '2022-12-31 08:28:33.533 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('d006e34f-b1d4-422a-9587-0636bbbaadf0', '845040f5ff67f06f74908dcfef7924edf48d2234f453fe8c529030a3411123fd', '2022-12-31 08:33:07.233 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('d10cdf1d-2d33-4697-8f76-41dcda71c39e', 'b69a9081d5c81589865be0a6674599cad0dfdd9bb44888c9ad223b4a4efe406a', '2023-01-01 04:38:17.5 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('e37ba67d-f939-4e01-883a-8642f525d034', '2136e504ceced45d9301083fe732e7a403f6a1ba29a74d055f02ebd12dfca814', '2022-12-31 09:05:46.142 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('e3abe2f5-1ff7-4cf0-88f9-b4adbcee0b6e', '17b66a87515aa57f81783b782006951e742cd509c363d86fa1b00b90e479d871', '2022-12-31 08:35:02.511 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('e57d97e6-c917-4652-b653-f2da61865628', 'b31917a804be4faa14f59bbfe555d46d67f99ceec1080c5e1aa5c24d3067e498', '2023-01-01 08:16:07.712 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('e6207e45-a52f-4ad3-ae9a-ff0eda1fe050', 'a80d805804ca9bf062fbf3fca125f35e64937ec3c152152774e1b25e647b4968', '2023-01-01 04:36:17.27 +0000 UTC');
INSERT INTO `agri_tx` VALUES ('f95a44a0-1952-4b55-b31f-a7b51540f455', 'd4b04b70e41c2c40a7fc6ccb302d5f3ef7a180da18bf0277287fdae64b57ae0f', '2022-12-31 10:19:22.404 +0000 UTC');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'agri_check', '商品检查', NULL, NULL, 'AgriCheck', 'crud', 'com.ruoyi.system', 'system', 'check', '商品检查ID', 'ruoyi', '0', 'D:\\\\z_salary\\\\笨仔\\\\', '{}', 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:28', NULL);
INSERT INTO `gen_table` VALUES (2, 'agri_fertilizer', '肥料', NULL, NULL, 'AgriFertilizer', 'crud', 'com.ruoyi.system', 'system', 'fertilizer', '肥料ID', 'ruoyi', '0', '/', '{}', 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:44:41', NULL);
INSERT INTO `gen_table` VALUES (3, 'agri_grow', '种植表', NULL, NULL, 'AgriGrow', 'crud', 'com.ruoyi.system', 'system', 'grow', '种植ID管理', 'ruoyi', '0', '/', '{}', 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:16', NULL);
INSERT INTO `gen_table` VALUES (4, 'agri_medicine', '药品', NULL, NULL, 'AgriMedicine', 'crud', 'com.ruoyi.system', 'system', 'medicine', '药品ID', 'ruoyi', '0', '/', '{}', 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:54', NULL);
INSERT INTO `gen_table` VALUES (5, 'agri_product', '产品', NULL, NULL, 'AgriProduct', 'crud', 'com.ruoyi.system', 'system', 'product', '产品ID', 'ruoyi', '0', '/', '{}', 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:46:14', NULL);
INSERT INTO `gen_table` VALUES (6, 'agri_sell', '售卖', NULL, NULL, 'AgriSell', 'crud', 'com.ruoyi.system', 'system', 'sell', '售卖信息ID', 'ruoyi', '0', '/', '{}', 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:46:32', NULL);
INSERT INTO `gen_table` VALUES (7, 'agri_transport', '运输', NULL, NULL, 'AgriTransport', 'crud', 'com.ruoyi.system', 'system', 'transport', '运输信息ID', 'ruoyi', '0', '/', '{}', 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:48:09', NULL);
INSERT INTO `gen_table` VALUES (8, 'agri_official', '官方抽查表', NULL, NULL, 'AgriOfficial', 'crud', 'com.ruoyi.system', 'system', 'official', '官方抽查', 'ruoyi', '0', '/', '{}', 'admin', '2022-12-20 12:20:53', '', '2022-12-20 12:21:25', NULL);
INSERT INTO `gen_table` VALUES (9, 'agri_routine', '日常抽查', NULL, NULL, 'AgriRoutine', 'crud', 'com.ruoyi.system', 'system', 'routine', '日常抽查', 'ruoyi', '0', '/', '{}', 'admin', '2022-12-20 12:20:53', '', '2022-12-20 12:21:52', NULL);
INSERT INTO `gen_table` VALUES (10, 'agri_tx', '交易hash表', NULL, NULL, 'AgriTx', 'crud', 'com.ruoyi.system', 'system', 'tx', '交易信息', 'ruoyi', '0', '/', '{}', 'admin', '2022-12-31 15:13:15', '', '2022-12-31 15:14:19', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, '1', 'id', '检测表的id', 'int', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:28');
INSERT INTO `gen_table_column` VALUES (2, '1', 'cid', '上链的检测信息的key', 'varchar(255)', 'String', 'cid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:28');
INSERT INTO `gen_table_column` VALUES (3, '1', 'pid', '对应的商品的key', 'varchar(255)', 'String', 'pid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:28');
INSERT INTO `gen_table_column` VALUES (4, '2', 'id', '肥料表ID', 'int', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:44:41');
INSERT INTO `gen_table_column` VALUES (5, '2', 'fid', '对应链上肥料表的key', 'varchar(255)', 'String', 'fid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:44:41');
INSERT INTO `gen_table_column` VALUES (6, '2', 'gid', '赌赢链上种植信息的key', 'varchar(255)', 'String', 'gid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:44:41');
INSERT INTO `gen_table_column` VALUES (7, '3', 'id', '种植表的ID', 'int', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:16');
INSERT INTO `gen_table_column` VALUES (8, '3', 'gid', '对应的种植信息的key', 'varchar(255)', 'String', 'gid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:16');
INSERT INTO `gen_table_column` VALUES (9, '3', 'pid', '对应的商品的key', 'varchar(255)', 'String', 'pid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:16');
INSERT INTO `gen_table_column` VALUES (10, '4', 'id', '用药表ID', 'int', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:54');
INSERT INTO `gen_table_column` VALUES (11, '4', 'mid', '对应链上的用药信息key', 'varchar(255)', 'String', 'mid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:54');
INSERT INTO `gen_table_column` VALUES (12, '4', 'gid', '对应的链上的种植信息的key', 'varchar(255)', 'String', 'gid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:45:54');
INSERT INTO `gen_table_column` VALUES (13, '5', 'id', '商品的ID', 'int', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:46:14');
INSERT INTO `gen_table_column` VALUES (14, '5', 'pid', '商品的key', 'varchar(255)', 'String', 'pid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:46:14');
INSERT INTO `gen_table_column` VALUES (15, '5', 'tid', '对应商品的运输id', 'varchar(255)', 'String', 'tid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:46:14');
INSERT INTO `gen_table_column` VALUES (16, '6', 'id', '销售表的ID', 'int', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:46:32');
INSERT INTO `gen_table_column` VALUES (17, '6', 'sid', '销售信息上链Key', 'varchar(255)', 'String', 'sid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:46:32');
INSERT INTO `gen_table_column` VALUES (18, '6', 'pid', '对应的商品的Key', 'varchar(255)', 'String', 'pid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:46:32');
INSERT INTO `gen_table_column` VALUES (19, '7', 'id', '运输表的ID', 'int', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:48:09');
INSERT INTO `gen_table_column` VALUES (20, '7', 'tid', '运输信息的上链key', 'varchar(255)', 'String', 'tid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:48:09');
INSERT INTO `gen_table_column` VALUES (21, '7', 'pid', '所运输的商品的上链key', 'varchar(255)', 'String', 'pid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-12-20 11:41:40', '', '2022-12-20 11:48:09');
INSERT INTO `gen_table_column` VALUES (22, '8', 'id', '官方抽查的id', 'int', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-12-20 12:20:53', '', '2022-12-20 12:21:25');
INSERT INTO `gen_table_column` VALUES (23, '8', 'oid', '上链的官方抽查的key', 'varchar(255)', 'String', 'oid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-12-20 12:20:53', '', '2022-12-20 12:21:25');
INSERT INTO `gen_table_column` VALUES (24, '8', 'pid', '对应的商品的上链id', 'varchar(255)', 'String', 'pid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-12-20 12:20:53', '', '2022-12-20 12:21:25');
INSERT INTO `gen_table_column` VALUES (25, '9', 'id', '日常检测ID', 'int', 'Long', 'id', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-12-20 12:20:53', '', '2022-12-20 12:21:52');
INSERT INTO `gen_table_column` VALUES (26, '9', 'rid', '日常检测上链的ID', 'varchar(255)', 'String', 'rid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-12-20 12:20:53', '', '2022-12-20 12:21:52');
INSERT INTO `gen_table_column` VALUES (27, '9', 'pid', '对应的商品上链的ID', 'varchar(255)', 'String', 'pid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-12-20 12:20:53', '', '2022-12-20 12:21:52');
INSERT INTO `gen_table_column` VALUES (28, '10', 'pid', '商品的Key', 'varchar(255)', 'String', 'pid', '1', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-12-31 15:13:15', '', '2022-12-31 15:14:19');
INSERT INTO `gen_table_column` VALUES (29, '10', 'txid', '交易hash', 'varchar(255)', 'String', 'txid', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-12-31 15:13:15', '', '2022-12-31 15:14:19');
INSERT INTO `gen_table_column` VALUES (30, '10', 'timestamp', '交易时间戳', 'varchar(255)', 'String', 'timestamp', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-12-31 15:13:15', '', '2022-12-31 15:14:19');

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-12-18 16:42:22', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-12-18 16:42:22', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-12-18 16:42:22', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'admin', '2022-12-18 16:42:22', '', NULL, '是否开启验证码功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2022-12-18 16:42:22', '', NULL, '是否开启注册用户功能（true开启，false关闭）');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 204 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '企业名称', 0, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-18 16:42:01', 'admin', '2023-01-01 13:14:08');
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '种养殖端公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-18 16:42:01', 'admin', '2023-01-01 13:15:50');
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '运输端公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-18 16:42:01', 'admin', '2023-01-01 13:15:42');
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '养鸡场有限公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-18 16:42:01', 'admin', '2023-01-01 13:16:38');
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '萝卜大户种植公司', 2, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-18 16:42:01', 'admin', '2023-01-01 13:16:51');
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '白菜种植基地', 3, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-18 16:42:01', 'admin', '2023-01-01 13:17:13');
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-18 16:42:01', '', NULL);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-18 16:42:01', '', NULL);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '好利来物流有限公司', 1, '若依', '15888888888', 'ry@qq.com', '0', '0', 'admin', '2022-12-18 16:42:01', 'admin', '2023-01-01 13:16:22');
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, '若依', '15888888888', 'ry@qq.com', '0', '2', 'admin', '2022-12-18 16:42:01', '', NULL);
INSERT INTO `sys_dept` VALUES (200, 100, '0,100', '监管机构', 3, '若依', '13311111111', '123@qq.com', '0', '0', 'admin', '2023-01-01 13:18:25', '', NULL);
INSERT INTO `sys_dept` VALUES (201, 200, '0,100,200', '公安送检机构', 1, '若依', '13311111111', '123@qq.com', '0', '0', 'admin', '2023-01-01 13:18:51', '', NULL);
INSERT INTO `sys_dept` VALUES (202, 100, '0,100', '农业大市场', 4, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-02 13:09:57', '', NULL);
INSERT INTO `sys_dept` VALUES (203, 202, '0,100,202', '金百汇生鲜超市', 1, NULL, NULL, NULL, '0', '0', 'admin', '2023-01-02 13:10:23', '', NULL);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '默认分组');
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '系统分组');
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-12-18 16:42:21', '', NULL, '停用状态');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-12-18 16:42:19', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-12-18 16:42:19', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-12-18 16:42:19', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2022-12-18 16:42:19', '', NULL, '任务状态列表');
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2022-12-18 16:42:19', '', NULL, '任务分组列表');
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2022-12-18 16:42:19', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2022-12-18 16:42:19', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2022-12-18 16:42:19', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2022-12-18 16:42:19', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2022-12-18 16:42:19', '', NULL, '登录状态列表');

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2022-12-18 16:42:26', '', NULL, '');
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2022-12-18 16:42:26', '', NULL, '');
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2022-12-18 16:42:26', '', NULL, '');

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 171 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-20 11:41:13');
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-20 12:20:43');
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-28 17:02:56');
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-28 18:11:57');
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-29 10:40:00');
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-29 12:14:41');
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-12-29 14:27:39');
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-29 14:27:48');
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-29 16:53:33');
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-29 18:54:03');
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-30 10:46:36');
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-30 18:49:50');
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-12-30 21:49:38');
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-30 21:49:43');
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-31 10:21:19');
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-31 11:05:14');
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-12-31 13:11:27');
INSERT INTO `sys_logininfor` VALUES (117, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-12-31 13:11:33');
INSERT INTO `sys_logininfor` VALUES (118, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-31 13:11:37');
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '验证码错误', '2022-12-31 14:44:51');
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-31 14:44:57');
INSERT INTO `sys_logininfor` VALUES (121, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-31 16:20:04');
INSERT INTO `sys_logininfor` VALUES (122, 'admin', '192.168.31.5', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2022-12-31 17:58:37');
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-31 18:00:27');
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '192.168.31.5', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2022-12-31 18:52:05');
INSERT INTO `sys_logininfor` VALUES (125, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-31 20:48:42');
INSERT INTO `sys_logininfor` VALUES (126, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2022-12-31 20:48:51');
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-31 20:48:56');
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '192.168.31.5', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2022-12-31 21:10:28');
INSERT INTO `sys_logininfor` VALUES (129, 'admin', '192.168.31.5', '内网IP', 'Chrome Mobile', 'Android 1.x', '1', '验证码错误', '2022-12-31 21:30:24');
INSERT INTO `sys_logininfor` VALUES (130, 'admin', '192.168.31.5', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2022-12-31 21:30:32');
INSERT INTO `sys_logininfor` VALUES (131, 'admin', '192.168.31.5', '内网IP', 'Chrome Mobile', 'Android 1.x', '1', '验证码错误', '2022-12-31 21:43:33');
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '192.168.31.5', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2022-12-31 21:43:38');
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '192.168.31.11', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2022-12-31 21:55:48');
INSERT INTO `sys_logininfor` VALUES (134, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-01-01 12:34:02');
INSERT INTO `sys_logininfor` VALUES (135, 'admin', '192.168.31.5', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2023-01-01 12:55:27');
INSERT INTO `sys_logininfor` VALUES (136, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2023-01-01 13:23:22');
INSERT INTO `sys_logininfor` VALUES (137, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-01-01 13:27:01');
INSERT INTO `sys_logininfor` VALUES (138, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2023-01-01 15:01:03');
INSERT INTO `sys_logininfor` VALUES (139, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-01-01 15:07:20');
INSERT INTO `sys_logininfor` VALUES (140, 'admin', '192.168.31.5', '内网IP', 'Chrome Mobile', 'Android 1.x', '1', '验证码错误', '2023-01-01 16:30:11');
INSERT INTO `sys_logininfor` VALUES (141, 'admin', '192.168.31.5', '内网IP', 'Chrome Mobile', 'Android 1.x', '0', '登录成功', '2023-01-01 16:30:15');
INSERT INTO `sys_logininfor` VALUES (142, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '注册成功', '2023-01-02 12:44:48');
INSERT INTO `sys_logininfor` VALUES (143, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '密码输入错误1次', '2023-01-02 12:45:02');
INSERT INTO `sys_logininfor` VALUES (144, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2023-01-02 12:45:02');
INSERT INTO `sys_logininfor` VALUES (145, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '密码输入错误2次', '2023-01-02 12:45:08');
INSERT INTO `sys_logininfor` VALUES (146, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2023-01-02 12:45:08');
INSERT INTO `sys_logininfor` VALUES (147, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-01-02 12:45:19');
INSERT INTO `sys_logininfor` VALUES (148, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2023-01-02 12:46:49');
INSERT INTO `sys_logininfor` VALUES (149, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-01-02 12:46:57');
INSERT INTO `sys_logininfor` VALUES (150, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2023-01-02 12:52:49');
INSERT INTO `sys_logininfor` VALUES (151, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '密码输入错误1次', '2023-01-02 12:52:58');
INSERT INTO `sys_logininfor` VALUES (152, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2023-01-02 12:52:58');
INSERT INTO `sys_logininfor` VALUES (153, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-01-02 12:53:06');
INSERT INTO `sys_logininfor` VALUES (154, 'user', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2023-01-02 12:53:56');
INSERT INTO `sys_logininfor` VALUES (155, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-01-02 12:55:50');
INSERT INTO `sys_logininfor` VALUES (156, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2023-01-02 13:04:36');
INSERT INTO `sys_logininfor` VALUES (157, 'plant', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '注册成功', '2023-01-02 13:05:08');
INSERT INTO `sys_logininfor` VALUES (158, 'sell', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '注册成功', '2023-01-02 13:06:10');
INSERT INTO `sys_logininfor` VALUES (159, 'transport', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '注册成功', '2023-01-02 13:06:31');
INSERT INTO `sys_logininfor` VALUES (160, 'check', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '注册成功', '2023-01-02 13:06:53');
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-01-02 13:07:49');
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2023-01-02 13:11:35');
INSERT INTO `sys_logininfor` VALUES (163, 'plant', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2023-01-02 13:11:47');
INSERT INTO `sys_logininfor` VALUES (164, 'plant', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '密码输入错误1次', '2023-01-02 13:11:47');
INSERT INTO `sys_logininfor` VALUES (165, 'plant', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '密码输入错误2次', '2023-01-02 13:11:54');
INSERT INTO `sys_logininfor` VALUES (166, 'plant', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '1', '用户不存在/密码错误', '2023-01-02 13:11:54');
INSERT INTO `sys_logininfor` VALUES (167, 'plant', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-01-02 13:12:04');
INSERT INTO `sys_logininfor` VALUES (168, 'plant', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2023-01-02 13:13:37');
INSERT INTO `sys_logininfor` VALUES (169, 'check', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '登录成功', '2023-01-02 13:13:51');
INSERT INTO `sys_logininfor` VALUES (170, 'check', '127.0.0.1', '内网IP', 'Chrome 10', 'Windows 10', '0', '退出成功', '2023-01-02 13:14:13');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2064 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-12-18 16:42:08', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 6, 'monitor', NULL, '', 1, 0, 'M', '1', '0', '', 'monitor', 'admin', '2022-12-18 16:42:08', 'admin', '2022-12-28 18:23:50', '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 8, 'tool', NULL, '', 1, 0, 'M', '1', '0', '', 'tool', 'admin', '2022-12-18 16:42:08', 'admin', '2023-01-02 12:51:35', '系统工具目录');
INSERT INTO `sys_menu` VALUES (4, '若依官网', 0, 7, 'http://ruoyi.vip', NULL, '', 0, 0, 'M', '1', '0', '', 'guide', 'admin', '2022-12-18 16:42:08', 'admin', '2023-01-02 12:51:29', '若依官网地址');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-12-18 16:42:08', '', NULL, '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '1', '0', 'system:role:list', 'peoples', 'admin', '2022-12-18 16:42:08', 'admin', '2023-01-02 13:04:01', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-12-18 16:42:08', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-12-18 16:42:08', 'admin', '2023-01-01 13:13:07', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '1', '0', 'system:post:list', 'post', 'admin', '2022-12-18 16:42:08', 'admin', '2022-12-28 17:04:30', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '1', '0', 'system:dict:list', 'dict', 'admin', '2022-12-18 16:42:08', 'admin', '2022-12-28 17:04:38', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '1', '0', 'system:config:list', 'edit', 'admin', '2022-12-18 16:42:08', 'admin', '2022-12-28 17:06:02', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '1', '0', 'system:notice:list', 'message', 'admin', '2022-12-18 16:42:08', 'admin', '2022-12-28 17:05:19', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '1', '0', '', 'log', 'admin', '2022-12-18 16:42:08', 'admin', '2022-12-28 17:05:25', '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-12-18 16:42:08', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2022-12-18 16:42:08', '', NULL, '定时任务菜单');
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2022-12-18 16:42:08', '', NULL, '数据监控菜单');
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2022-12-18 16:42:08', '', NULL, '服务监控菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-12-18 16:42:08', '', NULL, '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2022-12-18 16:42:08', '', NULL, '缓存列表菜单');
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-12-18 16:42:08', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-12-18 16:42:08', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2022-12-18 16:42:08', '', NULL, '系统接口菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2022-12-18 16:42:08', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2022-12-18 16:42:08', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-12-18 16:42:08', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2000, '日常巡查', 2061, 1, 'routine', 'check/routine/index', NULL, 1, 0, 'C', '0', '0', 'system:routine:list', 'color', 'admin', '2022-12-28 17:10:19', 'admin', '2023-01-02 12:59:18', '日常抽查菜单');
INSERT INTO `sys_menu` VALUES (2001, '日常抽查查询', 2000, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:routine:query', '#', 'admin', '2022-12-28 17:10:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2002, '日常抽查新增', 2000, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:routine:add', '#', 'admin', '2022-12-28 17:10:19', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2003, '日常抽查修改', 2000, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:routine:edit', '#', 'admin', '2022-12-28 17:10:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2004, '日常抽查删除', 2000, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:routine:remove', '#', 'admin', '2022-12-28 17:10:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2005, '日常抽查导出', 2000, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:routine:export', '#', 'admin', '2022-12-28 17:10:20', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2006, '产品信息', 2060, 1, 'product', 'plant/product/index', NULL, 1, 0, 'C', '0', '0', 'system:product:list', 'bug', 'admin', '2022-12-28 17:15:36', 'admin', '2022-12-28 18:31:26', '产品信息菜单');
INSERT INTO `sys_menu` VALUES (2007, '产品信息查询', 2006, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:product:query', '#', 'admin', '2022-12-28 17:15:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2008, '产品信息新增', 2006, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:product:add', '#', 'admin', '2022-12-28 17:15:36', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2009, '产品信息修改', 2006, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:product:edit', '#', 'admin', '2022-12-28 17:15:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2010, '产品信息删除', 2006, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:product:remove', '#', 'admin', '2022-12-28 17:15:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2011, '产品信息导出', 2006, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:product:export', '#', 'admin', '2022-12-28 17:15:37', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2012, '种植过程', 2060, 2, 'grow', 'plant/grow/index', NULL, 1, 0, 'C', '0', '0', 'system:grow:list', 'build', 'admin', '2022-12-28 17:22:39', 'admin', '2022-12-29 16:59:19', '种植过程菜单');
INSERT INTO `sys_menu` VALUES (2013, '种植过程查询', 2012, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:grow:query', '#', 'admin', '2022-12-28 17:22:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2014, '种植过程新增', 2012, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:grow:add', '#', 'admin', '2022-12-28 17:22:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '种植过程修改', 2012, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:grow:edit', '#', 'admin', '2022-12-28 17:22:39', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '种植过程删除', 2012, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:grow:remove', '#', 'admin', '2022-12-28 17:22:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '种植过程导出', 2012, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:grow:export', '#', 'admin', '2022-12-28 17:22:40', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '用药情况', 2060, 3, 'medicine', 'plant/medicine/index', NULL, 1, 0, 'C', '0', '0', 'system:medicine:list', 'druid', 'admin', '2022-12-28 17:24:16', 'admin', '2022-12-29 16:59:30', '用药情况查询菜单');
INSERT INTO `sys_menu` VALUES (2019, '用药情况查询', 2018, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:medicine:query', '#', 'admin', '2022-12-28 17:24:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2020, '用药情况新增', 2018, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:medicine:add', '#', 'admin', '2022-12-28 17:24:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '用药情况修改', 2018, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:medicine:edit', '#', 'admin', '2022-12-28 17:24:17', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '用药情况删除', 2018, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:medicine:remove', '#', 'admin', '2022-12-28 17:24:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '用药情况导出', 2018, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:medicine:export', '#', 'admin', '2022-12-28 17:24:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '检测情况', 2060, 5, 'check', 'plant/check/index', NULL, 1, 0, 'C', '0', '0', 'system:check:list', 'dict', 'admin', '2022-12-28 17:25:14', 'admin', '2022-12-29 16:59:50', '检测情况查询菜单');
INSERT INTO `sys_menu` VALUES (2025, '检测情况查询', 2024, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:check:query', '#', 'admin', '2022-12-28 17:25:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2026, '检测情况新增', 2024, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:check:add', '#', 'admin', '2022-12-28 17:25:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2027, '检测情况修改', 2024, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:check:edit', '#', 'admin', '2022-12-28 17:25:14', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2028, '检测情况删除', 2024, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:check:remove', '#', 'admin', '2022-12-28 17:25:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2029, '检测情况导出', 2024, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:check:export', '#', 'admin', '2022-12-28 17:25:15', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2030, '肥料情况', 2060, 4, 'fertilizer', 'plant/fertilizer/index', NULL, 1, 0, 'C', '0', '0', 'system:fertilizer:list', 'drag', 'admin', '2022-12-28 17:26:31', 'admin', '2022-12-29 16:59:40', '肥料情况查询菜单');
INSERT INTO `sys_menu` VALUES (2031, '肥料情况查询', 2030, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fertilizer:query', '#', 'admin', '2022-12-28 17:26:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2032, '肥料情况新增', 2030, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fertilizer:add', '#', 'admin', '2022-12-28 17:26:31', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2033, '肥料情况修改', 2030, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fertilizer:edit', '#', 'admin', '2022-12-28 17:26:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2034, '肥料情况删除', 2030, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fertilizer:remove', '#', 'admin', '2022-12-28 17:26:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2035, '肥料情况导出', 2030, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:fertilizer:export', '#', 'admin', '2022-12-28 17:26:32', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2036, '运输信息', 2062, 1, 'transport', 'transport/transport/index', NULL, 1, 0, 'C', '0', '0', 'system:transport:list', 'dashboard', 'admin', '2022-12-28 17:27:59', 'admin', '2022-12-30 21:05:41', '运输信息查询菜单');
INSERT INTO `sys_menu` VALUES (2037, '运输信息查询', 2036, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:transport:query', '#', 'admin', '2022-12-28 17:27:59', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2038, '运输信息新增', 2036, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:transport:add', '#', 'admin', '2022-12-28 17:28:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2039, '运输信息修改', 2036, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:transport:edit', '#', 'admin', '2022-12-28 17:28:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2040, '运输信息删除', 2036, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:transport:remove', '#', 'admin', '2022-12-28 17:28:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2041, '运输信息导出', 2036, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:transport:export', '#', 'admin', '2022-12-28 17:28:00', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2042, '官方抽检', 2061, 1, 'official', 'check/official/index', NULL, 1, 0, 'C', '0', '0', 'system:official:list', 'email', 'admin', '2022-12-28 17:28:55', 'admin', '2023-01-02 12:59:34', '官方巡查记录查询菜单');
INSERT INTO `sys_menu` VALUES (2043, '官方巡查记录查询', 2042, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:official:query', '#', 'admin', '2022-12-28 17:28:55', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2044, '官方巡查记录新增', 2042, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:official:add', '#', 'admin', '2022-12-28 17:28:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2045, '官方巡查记录修改', 2042, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:official:edit', '#', 'admin', '2022-12-28 17:28:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2046, '官方巡查记录删除', 2042, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:official:remove', '#', 'admin', '2022-12-28 17:28:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2047, '官方巡查记录导出', 2042, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:official:export', '#', 'admin', '2022-12-28 17:28:56', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2048, '售卖记录', 2063, 1, 'sell', 'sell/sell/index', NULL, 1, 0, 'C', '0', '0', 'system:sell:list', 'chart', 'admin', '2022-12-28 18:10:45', 'admin', '2022-12-30 21:05:53', '售卖记录查询菜单');
INSERT INTO `sys_menu` VALUES (2049, '售卖记录查询', 2048, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:sell:query', '#', 'admin', '2022-12-28 18:10:45', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2050, '售卖记录新增', 2048, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:sell:add', '#', 'admin', '2022-12-28 18:10:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2051, '售卖记录修改', 2048, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:sell:edit', '#', 'admin', '2022-12-28 18:10:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2052, '售卖记录删除', 2048, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:sell:remove', '#', 'admin', '2022-12-28 18:10:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2053, '售卖记录导出', 2048, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:sell:export', '#', 'admin', '2022-12-28 18:10:46', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2060, '种植端', 0, 2, 'plant', NULL, NULL, 1, 0, 'M', '0', '0', '', 'code', 'admin', '2022-12-28 18:13:36', 'admin', '2022-12-28 18:25:00', '');
INSERT INTO `sys_menu` VALUES (2061, '监管端', 0, 5, 'check', NULL, NULL, 1, 0, 'M', '0', '0', '', 'education', 'admin', '2022-12-28 18:14:46', 'admin', '2023-01-02 12:58:59', '');
INSERT INTO `sys_menu` VALUES (2062, '运输端', 0, 3, 'transport', NULL, NULL, 1, 0, 'M', '0', '0', '', 'edit', 'admin', '2022-12-28 18:17:17', 'admin', '2022-12-28 18:25:13', '');
INSERT INTO `sys_menu` VALUES (2063, '销售端', 0, 4, 'sell', NULL, NULL, 1, 0, 'M', '0', '0', '', 'date', 'admin', '2022-12-28 18:21:46', 'admin', '2023-01-02 12:56:11', '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2022-12-18 16:42:29', '', NULL, '管理员');
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-12-18 16:42:29', '', NULL, '管理员');

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  PRIMARY KEY (`oper_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 242 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '\"agri_transport,agri_fertilizer,agri_medicine,agri_grow,agri_check,agri_sell,agri_product\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 11:41:41');
INSERT INTO `sys_oper_log` VALUES (101, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"check\",\"className\":\"AgriCheck\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"检测表的id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Cid\",\"columnComment\":\"上链的检测信息的key\",\"columnId\":2,\"columnName\":\"cid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"cid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Pid\",\"columnComment\":\"对应的商品的key\",\"columnId\":3,\"columnName\":\"pid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"pid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"商品检查ID\",\"genPath\":\"D:\\\\\\\\z_salary\\\\\\\\笨仔\\\\\\\\\",\"genType\":\"1\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"商品检查\",\"tableId\":1,\"tableName\":\"agri_check\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 11:44:08');
INSERT INTO `sys_oper_log` VALUES (102, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"fertilizer\",\"className\":\"AgriFertilizer\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"肥料表ID\",\"columnId\":4,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Fid\",\"columnComment\":\"对应链上肥料表的key\",\"columnId\":5,\"columnName\":\"fid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"fid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Gid\",\"columnComment\":\"赌赢链上种植信息的key\",\"columnId\":6,\"columnName\":\"gid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":2,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"肥料ID\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"肥料\",\"tableId\":2,\"tableName\":\"agri_fertilizer\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 11:44:41');
INSERT INTO `sys_oper_log` VALUES (103, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"grow\",\"className\":\"AgriGrow\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"种植表的ID\",\"columnId\":7,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Gid\",\"columnComment\":\"对应的种植信息的key\",\"columnId\":8,\"columnName\":\"gid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Pid\",\"columnComment\":\"对应的商品的key\",\"columnId\":9,\"columnName\":\"pid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"pid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":3,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"种植ID管理\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"种植表\",\"tableId\":3,\"tableName\":\"agri_grow\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 11:45:16');
INSERT INTO `sys_oper_log` VALUES (104, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"check\",\"className\":\"AgriCheck\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"检测表的id\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-12-20 11:44:08\",\"usableColumn\":false},{\"capJavaField\":\"Cid\",\"columnComment\":\"上链的检测信息的key\",\"columnId\":2,\"columnName\":\"cid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"cid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-12-20 11:44:08\",\"usableColumn\":false},{\"capJavaField\":\"Pid\",\"columnComment\":\"对应的商品的key\",\"columnId\":3,\"columnName\":\"pid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"pid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"updateTime\":\"2022-12-20 11:44:08\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"商品检查ID\",\"genPath\":\"D:\\\\\\\\z_salary\\\\\\\\笨仔\\\\\\\\\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"商品检查\",\"tableId\":1,\"tableName\":\"agri_check\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 11:45:28');
INSERT INTO `sys_oper_log` VALUES (105, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"medicine\",\"className\":\"AgriMedicine\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"用药表ID\",\"columnId\":10,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Mid\",\"columnComment\":\"对应链上的用药信息key\",\"columnId\":11,\"columnName\":\"mid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"mid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Gid\",\"columnComment\":\"对应的链上的种植信息的key\",\"columnId\":12,\"columnName\":\"gid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"gid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":4,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"药品ID\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"药品\",\"tableId\":4,\"tableName\":\"agri_medicine\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 11:45:55');
INSERT INTO `sys_oper_log` VALUES (106, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"product\",\"className\":\"AgriProduct\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"商品的ID\",\"columnId\":13,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Pid\",\"columnComment\":\"商品的key\",\"columnId\":14,\"columnName\":\"pid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"pid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Tid\",\"columnComment\":\"对应商品的运输id\",\"columnId\":15,\"columnName\":\"tid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"tid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":5,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"产品ID\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"产品\",\"tableId\":5,\"tableName\":\"agri_product\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 11:46:14');
INSERT INTO `sys_oper_log` VALUES (107, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"sell\",\"className\":\"AgriSell\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"销售表的ID\",\"columnId\":16,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Sid\",\"columnComment\":\"销售信息上链Key\",\"columnId\":17,\"columnName\":\"sid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"sid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Pid\",\"columnComment\":\"对应的商品的Key\",\"columnId\":18,\"columnName\":\"pid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"pid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":6,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"售卖信息ID\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"售卖\",\"tableId\":6,\"tableName\":\"agri_sell\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 11:46:32');
INSERT INTO `sys_oper_log` VALUES (108, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"transport\",\"className\":\"AgriTransport\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"运输表的ID\",\"columnId\":19,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Tid\",\"columnComment\":\"运输信息的上链key\",\"columnId\":20,\"columnName\":\"tid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"tid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Pid\",\"columnComment\":\"所运输的商品的上链key\",\"columnId\":21,\"columnName\":\"pid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 11:41:40\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"pid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":7,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"运输信息ID\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"运输\",\"tableId\":7,\"tableName\":\"agri_transport\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 11:48:10');
INSERT INTO `sys_oper_log` VALUES (109, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-12-20 11:48:21');
INSERT INTO `sys_oper_log` VALUES (110, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '\"agri_official,agri_routine\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 12:20:53');
INSERT INTO `sys_oper_log` VALUES (111, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"official\",\"className\":\"AgriOfficial\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"官方抽查的id\",\"columnId\":22,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 12:20:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Oid\",\"columnComment\":\"上链的官方抽查的key\",\"columnId\":23,\"columnName\":\"oid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 12:20:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"oid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Pid\",\"columnComment\":\"对应的商品的上链id\",\"columnId\":24,\"columnName\":\"pid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 12:20:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"pid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":8,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"官方抽查\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"官方抽查表\",\"tableId\":8,\"tableName\":\"agri_official\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 12:21:25');
INSERT INTO `sys_oper_log` VALUES (112, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"routine\",\"className\":\"AgriRoutine\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"日常检测ID\",\"columnId\":25,\"columnName\":\"id\",\"columnType\":\"int\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 12:20:53\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Rid\",\"columnComment\":\"日常检测上链的ID\",\"columnId\":26,\"columnName\":\"rid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 12:20:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"rid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Pid\",\"columnComment\":\"对应的商品上链的ID\",\"columnId\":27,\"columnName\":\"pid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-20 12:20:53\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"pid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":9,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"日常抽查\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"日常抽查\",\"tableId\":9,\"tableName\":\"agri_routine\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-20 12:21:52');
INSERT INTO `sys_oper_log` VALUES (113, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-12-20 12:22:00');
INSERT INTO `sys_oper_log` VALUES (114, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dept/index\",\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":103,\"menuName\":\"部门管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":1,\"path\":\"dept\",\"perms\":\"system:dept:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 17:04:23');
INSERT INTO `sys_oper_log` VALUES (115, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/post/index\",\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"post\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":104,\"menuName\":\"岗位管理\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":1,\"path\":\"post\",\"perms\":\"system:post:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 17:04:30');
INSERT INTO `sys_oper_log` VALUES (116, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dict/index\",\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":105,\"menuName\":\"字典管理\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":1,\"path\":\"dict\",\"perms\":\"system:dict:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 17:04:38');
INSERT INTO `sys_oper_log` VALUES (117, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/notice/index\",\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"message\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":107,\"menuName\":\"通知公告\",\"menuType\":\"C\",\"orderNum\":8,\"params\":{},\"parentId\":1,\"path\":\"notice\",\"perms\":\"system:notice:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 17:05:19');
INSERT INTO `sys_oper_log` VALUES (118, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"log\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":108,\"menuName\":\"日志管理\",\"menuType\":\"M\",\"orderNum\":9,\"params\":{},\"parentId\":1,\"path\":\"log\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 17:05:25');
INSERT INTO `sys_oper_log` VALUES (119, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/role/index\",\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":101,\"menuName\":\"角色管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"role\",\"perms\":\"system:role:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 17:05:56');
INSERT INTO `sys_oper_log` VALUES (120, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/config/index\",\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":106,\"menuName\":\"参数设置\",\"menuType\":\"C\",\"orderNum\":7,\"params\":{},\"parentId\":1,\"path\":\"config\",\"perms\":\"system:config:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 17:06:03');
INSERT INTO `sys_oper_log` VALUES (121, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 17:06:17');
INSERT INTO `sys_oper_log` VALUES (122, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/routine/index\",\"createTime\":\"2022-12-28 17:10:19\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"日常抽查\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"routine\",\"perms\":\"system:routine:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 17:11:56');
INSERT INTO `sys_oper_log` VALUES (123, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/product/index\",\"createTime\":\"2022-12-28 17:15:36\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"产品信息\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"product\",\"perms\":\"system:product:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 17:29:49');
INSERT INTO `sys_oper_log` VALUES (124, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"种植端\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"system\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:13:36');
INSERT INTO `sys_oper_log` VALUES (125, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:13:36\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2060,\"menuName\":\"种植端\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:13:56');
INSERT INTO `sys_oper_log` VALUES (126, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"巡查管理\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"system\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:14:47');
INSERT INTO `sys_oper_log` VALUES (127, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:14:46\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2061,\"menuName\":\"巡查管理\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:14:56');
INSERT INTO `sys_oper_log` VALUES (128, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/routine/index\",\"createTime\":\"2022-12-28 17:10:19\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"日常抽查\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2060,\"path\":\"routine\",\"perms\":\"system:routine:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:15:25');
INSERT INTO `sys_oper_log` VALUES (129, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/grow/index\",\"createTime\":\"2022-12-28 17:22:39\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"种植过程\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2060,\"path\":\"grow\",\"perms\":\"system:grow:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:15:55');
INSERT INTO `sys_oper_log` VALUES (130, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/medicine/index\",\"createTime\":\"2022-12-28 17:24:16\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"用药情况\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2060,\"path\":\"medicine\",\"perms\":\"system:medicine:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:16:08');
INSERT INTO `sys_oper_log` VALUES (131, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/check/index\",\"createTime\":\"2022-12-28 17:25:14\",\"icon\":\"download\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2024,\"menuName\":\"检测情况\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2060,\"path\":\"check\",\"perms\":\"system:check:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:16:19');
INSERT INTO `sys_oper_log` VALUES (132, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/fertilizer/index\",\"createTime\":\"2022-12-28 17:26:31\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"肥料情况\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2060,\"path\":\"fertilizer\",\"perms\":\"system:fertilizer:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:16:33');
INSERT INTO `sys_oper_log` VALUES (133, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"运输端\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:17:17');
INSERT INTO `sys_oper_log` VALUES (134, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:14:46\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2061,\"menuName\":\"巡查端\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:17:33');
INSERT INTO `sys_oper_log` VALUES (135, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/transport/index\",\"createTime\":\"2022-12-28 17:27:59\",\"icon\":\"dashboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"运输信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2062,\"path\":\"transport\",\"perms\":\"system:transport:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:17:51');
INSERT INTO `sys_oper_log` VALUES (136, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/official/index\",\"createTime\":\"2022-12-28 17:28:55\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2042,\"menuName\":\"官方巡查记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2061,\"path\":\"official\",\"perms\":\"system:official:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:18:06');
INSERT INTO `sys_oper_log` VALUES (137, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/transport/index\",\"createTime\":\"2022-12-28 18:11:47\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2054,\"menuName\":\"运输记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"transport\",\"perms\":\"system:transport:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:18:29');
INSERT INTO `sys_oper_log` VALUES (138, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2054', '127.0.0.1', '内网IP', '{menuId=2054}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2022-12-28 18:18:50');
INSERT INTO `sys_oper_log` VALUES (139, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/transport/index\",\"createTime\":\"2022-12-28 18:11:47\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2054,\"menuName\":\"运输记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"transport\",\"perms\":\"system:transport:list\",\"status\":\"1\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:19:02');
INSERT INTO `sys_oper_log` VALUES (140, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2054', '127.0.0.1', '内网IP', '{menuId=2054}', '{\"msg\":\"存在子菜单,不允许删除\",\"code\":601}', 0, NULL, '2022-12-28 18:19:07');
INSERT INTO `sys_oper_log` VALUES (141, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/transport/index\",\"createTime\":\"2022-12-28 18:11:47\",\"icon\":\"#\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2054,\"menuName\":\"运输记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":1,\"path\":\"transport\",\"perms\":\"system:transport:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:19:17');
INSERT INTO `sys_oper_log` VALUES (142, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2059', '127.0.0.1', '内网IP', '{menuId=2059}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:19:32');
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2058', '127.0.0.1', '内网IP', '{menuId=2058}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:19:36');
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2057', '127.0.0.1', '内网IP', '{menuId=2057}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:19:40');
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2056', '127.0.0.1', '内网IP', '{menuId=2056}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:19:44');
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2055', '127.0.0.1', '内网IP', '{menuId=2055}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:19:47');
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', NULL, '/system/menu/2054', '127.0.0.1', '内网IP', '{menuId=2054}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:19:51');
INSERT INTO `sys_oper_log` VALUES (148, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/routine/index\",\"createTime\":\"2022-12-28 17:10:19\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"日常抽查\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2061,\"path\":\"routine\",\"perms\":\"system:routine:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:20:53');
INSERT INTO `sys_oper_log` VALUES (149, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"date\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"售卖端\",\"menuType\":\"M\",\"orderNum\":1,\"params\":{},\"parentId\":0,\"path\":\"system\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:21:46');
INSERT INTO `sys_oper_log` VALUES (150, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/sell/index\",\"createTime\":\"2022-12-28 18:10:45\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2048,\"menuName\":\"售卖记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2063,\"path\":\"sell\",\"perms\":\"system:sell:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:22:35');
INSERT INTO `sys_oper_log` VALUES (151, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:13:36\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2060,\"menuName\":\"种植端\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:22:54');
INSERT INTO `sys_oper_log` VALUES (152, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:17:17\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"运输端\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:23:20');
INSERT INTO `sys_oper_log` VALUES (153, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:21:46\",\"icon\":\"date\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"售卖端\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:23:29');
INSERT INTO `sys_oper_log` VALUES (154, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:14:46\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2061,\"menuName\":\"巡查端\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"system\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:23:36');
INSERT INTO `sys_oper_log` VALUES (155, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"monitor\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2,\"menuName\":\"系统监控\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"monitor\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:23:50');
INSERT INTO `sys_oper_log` VALUES (156, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:23:58');
INSERT INTO `sys_oper_log` VALUES (157, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:24:08');
INSERT INTO `sys_oper_log` VALUES (158, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:13:36\",\"icon\":\"code\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2060,\"menuName\":\"种植端\",\"menuType\":\"M\",\"orderNum\":2,\"params\":{},\"parentId\":0,\"path\":\"plant\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:25:00');
INSERT INTO `sys_oper_log` VALUES (159, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:17:17\",\"icon\":\"edit\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2062,\"menuName\":\"运输端\",\"menuType\":\"M\",\"orderNum\":3,\"params\":{},\"parentId\":0,\"path\":\"transport\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:25:14');
INSERT INTO `sys_oper_log` VALUES (160, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:21:46\",\"icon\":\"date\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"售卖端\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"sell\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:25:25');
INSERT INTO `sys_oper_log` VALUES (161, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:14:46\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2061,\"menuName\":\"巡查端\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"check\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:25:37');
INSERT INTO `sys_oper_log` VALUES (162, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/product/index\",\"createTime\":\"2022-12-28 17:15:36\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"产品信息\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2060,\"path\":\"product\",\"perms\":\"system:product:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:26:10');
INSERT INTO `sys_oper_log` VALUES (163, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/official/index\",\"createTime\":\"2022-12-28 17:28:55\",\"icon\":\"email\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2042,\"menuName\":\"官方巡查\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2061,\"path\":\"official\",\"perms\":\"system:official:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:27:07');
INSERT INTO `sys_oper_log` VALUES (164, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/grow/index\",\"createTime\":\"2022-12-28 17:22:39\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"种植过程\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2060,\"path\":\"grow\",\"perms\":\"system:grow:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:27:23');
INSERT INTO `sys_oper_log` VALUES (165, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/check/index\",\"createTime\":\"2022-12-28 17:25:14\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2024,\"menuName\":\"检测情况\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2060,\"path\":\"check\",\"perms\":\"system:check:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:27:37');
INSERT INTO `sys_oper_log` VALUES (166, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/product/index\",\"createTime\":\"2022-12-28 17:15:36\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"产品信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2060,\"path\":\"product\",\"perms\":\"system:product:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:29:42');
INSERT INTO `sys_oper_log` VALUES (167, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/grow/index\",\"createTime\":\"2022-12-28 17:22:39\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"种植过程\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2060,\"path\":\"grow\",\"perms\":\"system:grow:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:29:51');
INSERT INTO `sys_oper_log` VALUES (168, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/medicine/index\",\"createTime\":\"2022-12-28 17:24:16\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"用药情况\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2060,\"path\":\"medicine\",\"perms\":\"system:medicine:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:29:58');
INSERT INTO `sys_oper_log` VALUES (169, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/fertilizer/index\",\"createTime\":\"2022-12-28 17:26:31\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"肥料情况\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2060,\"path\":\"fertilizer\",\"perms\":\"system:fertilizer:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:30:09');
INSERT INTO `sys_oper_log` VALUES (170, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/check/index\",\"createTime\":\"2022-12-28 17:25:14\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2024,\"menuName\":\"检测情况\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2060,\"path\":\"check\",\"perms\":\"system:check:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:30:17');
INSERT INTO `sys_oper_log` VALUES (171, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"plant/product/index\",\"createTime\":\"2022-12-28 17:15:36\",\"icon\":\"bug\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2006,\"menuName\":\"产品信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2060,\"path\":\"product\",\"perms\":\"system:product:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-28 18:31:26');
INSERT INTO `sys_oper_log` VALUES (172, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"plant/grow/index\",\"createTime\":\"2022-12-28 17:22:39\",\"icon\":\"build\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2012,\"menuName\":\"种植过程\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2060,\"path\":\"grow\",\"perms\":\"system:grow:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-29 16:59:20');
INSERT INTO `sys_oper_log` VALUES (173, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"plant/medicine/index\",\"createTime\":\"2022-12-28 17:24:16\",\"icon\":\"druid\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2018,\"menuName\":\"用药情况\",\"menuType\":\"C\",\"orderNum\":3,\"params\":{},\"parentId\":2060,\"path\":\"medicine\",\"perms\":\"system:medicine:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-29 16:59:30');
INSERT INTO `sys_oper_log` VALUES (174, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"plant/fertilizer/index\",\"createTime\":\"2022-12-28 17:26:31\",\"icon\":\"drag\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2030,\"menuName\":\"肥料情况\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":2060,\"path\":\"fertilizer\",\"perms\":\"system:fertilizer:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-29 16:59:40');
INSERT INTO `sys_oper_log` VALUES (175, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"plant/check/index\",\"createTime\":\"2022-12-28 17:25:14\",\"icon\":\"dict\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2024,\"menuName\":\"检测情况\",\"menuType\":\"C\",\"orderNum\":5,\"params\":{},\"parentId\":2060,\"path\":\"check\",\"perms\":\"system:check:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-29 16:59:51');
INSERT INTO `sys_oper_log` VALUES (176, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"transport/transport/index\",\"createTime\":\"2022-12-28 17:27:59\",\"icon\":\"dashboard\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2036,\"menuName\":\"运输信息\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2062,\"path\":\"transport\",\"perms\":\"system:transport:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-30 21:05:42');
INSERT INTO `sys_oper_log` VALUES (177, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"sell/sell/index\",\"createTime\":\"2022-12-28 18:10:45\",\"icon\":\"chart\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2048,\"menuName\":\"售卖记录\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2063,\"path\":\"sell\",\"perms\":\"system:sell:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-30 21:05:53');
INSERT INTO `sys_oper_log` VALUES (178, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"check/routine/index\",\"createTime\":\"2022-12-28 17:10:19\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"日常抽查\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2061,\"path\":\"routine\",\"perms\":\"system:routine:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-30 21:06:10');
INSERT INTO `sys_oper_log` VALUES (179, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"check/official/index\",\"createTime\":\"2022-12-28 17:28:55\",\"icon\":\"email\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2042,\"menuName\":\"官方巡查\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2061,\"path\":\"official\",\"perms\":\"system:official:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-30 21:06:20');
INSERT INTO `sys_oper_log` VALUES (180, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/importTable', '127.0.0.1', '内网IP', '\"agri_tx\"', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-31 15:13:15');
INSERT INTO `sys_oper_log` VALUES (181, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', NULL, '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"tx\",\"className\":\"AgriTx\",\"columns\":[{\"capJavaField\":\"Pid\",\"columnComment\":\"商品的Key\",\"columnId\":28,\"columnName\":\"pid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-31 15:13:15\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isPk\":\"1\",\"javaField\":\"pid\",\"javaType\":\"String\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Txid\",\"columnComment\":\"交易hash\",\"columnId\":29,\"columnName\":\"txid\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-31 15:13:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"txid\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Timestamp\",\"columnComment\":\"交易时间戳\",\"columnId\":30,\"columnName\":\"timestamp\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2022-12-31 15:13:15\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"javaField\":\"timestamp\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":10,\"updateBy\":\"\",\"usableColumn\":false}],\"crud\":true,\"functionAuthor\":\"ruoyi\",\"functionName\":\"交易信息\",\"genPath\":\"/\",\"genType\":\"0\",\"moduleName\":\"system\",\"options\":\"{}\",\"packageName\":\"com.ruoyi.system\",\"params\":{},\"sub\":false,\"tableComment\":\"交易hash表\",\"tableId\":10,\"tableName\":\"agri_tx\",\"tplCategory\":\"crud\",\"tree\":false}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2022-12-31 15:14:19');
INSERT INTO `sys_oper_log` VALUES (182, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', NULL, '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{}', NULL, 0, NULL, '2022-12-31 15:14:25');
INSERT INTO `sys_oper_log` VALUES (183, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/role/index\",\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":101,\"menuName\":\"角色管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"role\",\"perms\":\"system:role:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:12:10');
INSERT INTO `sys_oper_log` VALUES (184, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/dept/index\",\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"tree\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":103,\"menuName\":\"部门管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":1,\"path\":\"dept\",\"perms\":\"system:dept:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:13:07');
INSERT INTO `sys_oper_log` VALUES (185, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":100,\"deptName\":\"企业名称\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:14:09');
INSERT INTO `sys_oper_log` VALUES (186, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/107', '127.0.0.1', '内网IP', '{deptId=107}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:14:24');
INSERT INTO `sys_oper_log` VALUES (187, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/106', '127.0.0.1', '内网IP', '{deptId=106}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:14:27');
INSERT INTO `sys_oper_log` VALUES (188, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/105', '127.0.0.1', '内网IP', '{deptId=105}', '{\"msg\":\"部门存在用户,不允许删除\",\"code\":601}', 0, NULL, '2023-01-01 13:14:52');
INSERT INTO `sys_oper_log` VALUES (189, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"养殖端公司\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"企业名称\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:15:18');
INSERT INTO `sys_oper_log` VALUES (190, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":102,\"deptName\":\"运输端公司\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":100,\"parentName\":\"企业名称\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:15:42');
INSERT INTO `sys_oper_log` VALUES (191, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"种养殖端公司\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"parentName\":\"企业名称\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:15:50');
INSERT INTO `sys_oper_log` VALUES (192, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, 'admin', NULL, '/system/dept/109', '127.0.0.1', '内网IP', '{deptId=109}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:16:00');
INSERT INTO `sys_oper_log` VALUES (193, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":108,\"deptName\":\"好利来物流有限公司\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":102,\"parentName\":\"运输端公司\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:16:22');
INSERT INTO `sys_oper_log` VALUES (194, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"parentName\":\"种养殖端公司\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:16:38');
INSERT INTO `sys_oper_log` VALUES (195, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":104,\"deptName\":\"萝卜大户种植公司\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":2,\"params\":{},\"parentId\":101,\"parentName\":\"种养殖端公司\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:16:52');
INSERT INTO `sys_oper_log` VALUES (196, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"白菜种植基地\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"parentName\":\"种养殖端公司\",\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:17:14');
INSERT INTO `sys_oper_log` VALUES (197, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"监管机构\",\"email\":\"123@qq.com\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":100,\"phone\":\"13311111111\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:18:25');
INSERT INTO `sys_oper_log` VALUES (198, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,200\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"公安送检机构\",\"email\":\"123@qq.com\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":200,\"phone\":\"13311111111\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 13:18:52');
INSERT INTO `sys_oper_log` VALUES (199, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"张三\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'uploadsurl\' in \'class com.ruoyi.common.core.domain.entity.SysUser\'', '2023-01-01 13:56:33');
INSERT INTO `sys_oper_log` VALUES (200, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"张三\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'uploadsurl\' in \'class com.ruoyi.common.core.domain.entity.SysUser\'', '2023-01-01 13:58:17');
INSERT INTO `sys_oper_log` VALUES (201, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"张三\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'uploadsurl\' in \'class com.ruoyi.common.core.domain.entity.SysUser\'', '2023-01-01 14:05:12');
INSERT INTO `sys_oper_log` VALUES (202, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"张三\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', NULL, 1, 'nested exception is org.apache.ibatis.reflection.ReflectionException: There is no getter for property named \'uploadsurl\' in \'class com.ruoyi.common.core.domain.entity.SysUser\'', '2023-01-01 14:09:06');
INSERT INTO `sys_oper_log` VALUES (203, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"张三\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \',\n			law,\n			\n 			update_time = sysdate() \n 		where user_id = 1\' at line 14\r\n### The error may exist in file [D:\\z_salary\\笨仔\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,               status = ?,     login_ip = ?,     login_date = ?,          remark = ?,    address,    law,         update_time = sysdate()     where user_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \',\n			law,\n			\n 			update_time = sysdate() \n 		where user_id = 1\' at line 14\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \',\n			law,\n			\n 			update_time = sysdate() \n 		where user_id = 1\' at line 14', '2023-01-01 14:11:07');
INSERT INTO `sys_oper_log` VALUES (204, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"张三\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \',\n			law,\n			\n 			update_time = sysdate() \n 		where user_id = 1\' at line 14\r\n### The error may exist in file [D:\\z_salary\\笨仔\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,               status = ?,     login_ip = ?,     login_date = ?,          remark = ?,    address,    law,         update_time = sysdate()     where user_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \',\n			law,\n			\n 			update_time = sysdate() \n 		where user_id = 1\' at line 14\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \',\n			law,\n			\n 			update_time = sysdate() \n 		where user_id = 1\' at line 14', '2023-01-01 14:15:58');
INSERT INTO `sys_oper_log` VALUES (205, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"张三\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', NULL, 1, '\r\n### Error updating database.  Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'address = \'台湾省\',\n			 law = \'张三\' \n 		where user_id = 1\' at line 15\r\n### The error may exist in file [D:\\z_salary\\笨仔\\RuoYi-Vue-master\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserMapper.updateUser-Inline\r\n### The error occurred while setting parameters\r\n### SQL: update sys_user     SET user_name = ?,     nick_name = ?,     email = ?,     phonenumber = ?,     sex = ?,               status = ?,     login_ip = ?,     login_date = ?,          remark = ?,     update_time = sysdate()     address = ?,     law = ?     where user_id = ?\r\n### Cause: java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'address = \'台湾省\',\n			 law = \'张三\' \n 		where user_id = 1\' at line 15\n; bad SQL grammar []; nested exception is java.sql.SQLSyntaxErrorException: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near \'address = \'台湾省\',\n			 law = \'张三\' \n 		where user_id = 1\' at line 15', '2023-01-01 14:18:55');
INSERT INTO `sys_oper_log` VALUES (206, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"张三\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 14:20:39');
INSERT INTO `sys_oper_log` VALUES (207, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"李四\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 14:22:43');
INSERT INTO `sys_oper_log` VALUES (208, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"李四\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 14:41:46');
INSERT INTO `sys_oper_log` VALUES (209, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"李四\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"uploadsurl\":\"http://localhost/dev-api//profile/upload/2023/01/01/123_20230101144432A002.png\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 14:44:34');
INSERT INTO `sys_oper_log` VALUES (210, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"李四\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"uploadsurl\":\"http://localhost/dev-api//profile/upload/2023/01/01/check_20230101153426A001.jpg\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 15:34:28');
INSERT INTO `sys_oper_log` VALUES (211, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"李四\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"uploadsurl\":\"http://localhost/dev-api//profile/upload/2023/01/01/background_20230101153452A002.jpg\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 15:34:56');
INSERT INTO `sys_oper_log` VALUES (212, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"李四\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"uploadsurl\":\"http://localhost/dev-api//profile/upload/2023/01/01/background_20230101154224A003.jpg\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 15:42:27');
INSERT INTO `sys_oper_log` VALUES (213, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'admin', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"台湾省\",\"admin\":true,\"createBy\":\"admin\",\"createTime\":\"2022-12-18 16:42:03\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"123@qq.com\",\"law\":\"李四\",\"loginDate\":\"2023-01-01 12:55:28\",\"loginIp\":\"192.168.31.5\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15888888888\",\"remark\":\"管理员\",\"roles\":[{\"admin\":true,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":1,\"roleKey\":\"admin\",\"roleName\":\"超级管理员\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"uploadsurl\":\"http://localhost/dev-api//profile/upload/2023/01/01/check_20230101154745A004.jpg\",\"userId\":1,\"userName\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-01 15:47:48');
INSERT INTO `sys_oper_log` VALUES (214, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'user', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"中国广州养鸡基地\",\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2023-01-02 12:44:47\",\"delFlag\":\"0\",\"email\":\"123@qq.com\",\"law\":\"王二\",\"loginIp\":\"\",\"nickName\":\"user\",\"params\":{},\"phonenumber\":\"13011111111\",\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"user\"}', '{\"msg\":\"修改用户\'user\'失败，邮箱账号已存在\",\"code\":500}', 0, NULL, '2023-01-02 12:46:12');
INSERT INTO `sys_oper_log` VALUES (215, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'user', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"中国广州养鸡基地\",\"admin\":false,\"createBy\":\"\",\"createTime\":\"2023-01-02 12:44:47\",\"delFlag\":\"0\",\"email\":\"111@qq.com\",\"law\":\"王二\",\"loginIp\":\"\",\"nickName\":\"user\",\"params\":{},\"phonenumber\":\"13011111111\",\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"user\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:46:28');
INSERT INTO `sys_oper_log` VALUES (216, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2060,2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016,2017,2018,2019,2020,2021,2022,2023,2030,2031,2032,2033,2034,2035,2024,2025,2026,2027,2028,2029],\"params\":{},\"roleId\":100,\"roleKey\":\"plant\",\"roleName\":\"养殖户角色\",\"roleSort\":\"1\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:49:35');
INSERT INTO `sys_oper_log` VALUES (217, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2062,2036,2037,2038,2039,2040,2041],\"params\":{},\"roleId\":101,\"roleKey\":\"transport\",\"roleName\":\"运输角色\",\"roleSort\":\"0\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:50:23');
INSERT INTO `sys_oper_log` VALUES (218, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2063,2048,2049,2050,2051,2052,2053],\"params\":{},\"roleId\":102,\"roleKey\":\"sell\",\"roleName\":\"销售角色\",\"roleSort\":\"0\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:50:42');
INSERT INTO `sys_oper_log` VALUES (219, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2061,2000,2001,2002,2003,2004,2005,2042,2043,2044,2045,2046,2047],\"params\":{},\"roleId\":103,\"roleKey\":\"check\",\"roleName\":\"巡查角色\",\"roleSort\":\"4\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:51:04');
INSERT INTO `sys_oper_log` VALUES (220, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"guide\",\"isCache\":\"0\",\"isFrame\":\"0\",\"menuId\":4,\"menuName\":\"若依官网\",\"menuType\":\"M\",\"orderNum\":7,\"params\":{},\"parentId\":0,\"path\":\"http://ruoyi.vip\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:51:29');
INSERT INTO `sys_oper_log` VALUES (221, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"tool\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":3,\"menuName\":\"系统工具\",\"menuType\":\"M\",\"orderNum\":8,\"params\":{},\"parentId\":0,\"path\":\"tool\",\"perms\":\"\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:51:35');
INSERT INTO `sys_oper_log` VALUES (222, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"address\":\"中国广州养鸡基地\",\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2023-01-02 12:44:47\",\"delFlag\":\"0\",\"deptId\":105,\"email\":\"111@qq.com\",\"law\":\"王二\",\"loginDate\":\"2023-01-02 12:45:19\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"user\",\"params\":{},\"phonenumber\":\"13011111111\",\"postIds\":[],\"roleIds\":[100],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":100,\"userName\":\"user\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:52:45');
INSERT INTO `sys_oper_log` VALUES (223, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'user', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"中国广州养鸡基地\",\"admin\":false,\"createBy\":\"\",\"createTime\":\"2023-01-02 12:44:47\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"白菜种植基地\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"111@qq.com\",\"law\":\"王二\",\"loginDate\":\"2023-01-02 12:45:19\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"user\",\"params\":{},\"phonenumber\":\"13011111111\",\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"plant\",\"roleName\":\"养殖户角色\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"uploadsurl\":\"http://localhost/dev-api//profile/upload/2023/01/02/123_20230102125330A001.png\",\"userId\":100,\"userName\":\"user\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:53:33');
INSERT INTO `sys_oper_log` VALUES (224, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:21:46\",\"icon\":\"date\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2063,\"menuName\":\"销售端\",\"menuType\":\"M\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"sell\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:56:11');
INSERT INTO `sys_oper_log` VALUES (225, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2022-12-28 18:14:46\",\"icon\":\"education\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2061,\"menuName\":\"监管端\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"check\",\"perms\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:58:59');
INSERT INTO `sys_oper_log` VALUES (226, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"check/routine/index\",\"createTime\":\"2022-12-28 17:10:19\",\"icon\":\"color\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"日常巡查\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2061,\"path\":\"routine\",\"perms\":\"system:routine:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:59:18');
INSERT INTO `sys_oper_log` VALUES (227, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"check/official/index\",\"createTime\":\"2022-12-28 17:28:55\",\"icon\":\"email\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2042,\"menuName\":\"官方抽检\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2061,\"path\":\"official\",\"perms\":\"system:official:list\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 12:59:34');
INSERT INTO `sys_oper_log` VALUES (228, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-01-02 12:50:22\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2062,2036,2037,2038,2039,2040,2041],\"params\":{},\"roleId\":101,\"roleKey\":\"transport\",\"roleName\":\"运输角色\",\"roleSort\":\"3\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:02:47');
INSERT INTO `sys_oper_log` VALUES (229, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.changeStatus()', 'PUT', 1, 'admin', NULL, '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"status\":\"1\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:02:53');
INSERT INTO `sys_oper_log` VALUES (230, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-01-02 12:50:42\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2063,2048,2049,2050,2051,2052,2053],\"params\":{},\"roleId\":102,\"roleKey\":\"sell\",\"roleName\":\"销售角色\",\"roleSort\":\"4\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:03:08');
INSERT INTO `sys_oper_log` VALUES (231, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-01-02 12:51:04\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[2061,2000,2001,2002,2003,2004,2005,2042,2043,2044,2045,2046,2047],\"params\":{},\"roleId\":103,\"roleKey\":\"check\",\"roleName\":\"巡查角色\",\"roleSort\":\"5\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:03:18');
INSERT INTO `sys_oper_log` VALUES (232, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2023-01-02 12:51:04\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2061,2000,2001,2002,2003,2004,2005,2042,2043,2044,2045,2046,2047],\"params\":{},\"roleId\":103,\"roleKey\":\"check\",\"roleName\":\"巡查角色\",\"roleSort\":\"5\",\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:03:24');
INSERT INTO `sys_oper_log` VALUES (233, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"system/role/index\",\"createTime\":\"2022-12-18 16:42:08\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":101,\"menuName\":\"角色管理\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":1,\"path\":\"role\",\"perms\":\"system:role:list\",\"query\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"1\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:04:01');
INSERT INTO `sys_oper_log` VALUES (234, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2023-01-02 13:05:08\",\"delFlag\":\"0\",\"deptId\":103,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"plant\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[100],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":101,\"userName\":\"plant\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:08:27');
INSERT INTO `sys_oper_log` VALUES (235, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2023-01-02 13:06:31\",\"delFlag\":\"0\",\"deptId\":108,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"transport\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[101],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":103,\"userName\":\"transport\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:09:01');
INSERT INTO `sys_oper_log` VALUES (236, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2023-01-02 13:06:52\",\"delFlag\":\"0\",\"deptId\":201,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"check\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[103],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":104,\"userName\":\"check\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:09:19');
INSERT INTO `sys_oper_log` VALUES (237, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"农业大市场\",\"orderNum\":4,\"params\":{},\"parentId\":100,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:09:57');
INSERT INTO `sys_oper_log` VALUES (238, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,202\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"金百汇生鲜超市\",\"orderNum\":1,\"params\":{},\"parentId\":202,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:10:23');
INSERT INTO `sys_oper_log` VALUES (239, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2023-01-02 13:06:10\",\"delFlag\":\"0\",\"deptId\":203,\"email\":\"\",\"loginIp\":\"\",\"nickName\":\"sell\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"roleIds\":[102],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":102,\"userName\":\"sell\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:10:53');
INSERT INTO `sys_oper_log` VALUES (240, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'plant', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"北京市\",\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2023-01-02 13:05:08\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":103,\"email\":\"12345@qq.com\",\"law\":\"张三\",\"loginIp\":\"\",\"nickName\":\"plant\",\"params\":{},\"phonenumber\":\"13011111111\",\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"plant\",\"roleName\":\"养殖户角色\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"uploadsurl\":\"http://localhost/dev-api//profile/upload/2023/01/02/check_20230102131254A002.jpg\",\"userId\":101,\"userName\":\"plant\"}', '{\"msg\":\"修改用户\'plant\'失败，手机号码已存在\",\"code\":500}', 0, NULL, '2023-01-02 13:12:56');
INSERT INTO `sys_oper_log` VALUES (241, '个人信息', 2, 'com.ruoyi.web.controller.system.SysProfileController.updateProfile()', 'PUT', 1, 'plant', NULL, '/system/user/profile', '127.0.0.1', '内网IP', '{\"address\":\"北京市\",\"admin\":false,\"createBy\":\"\",\"createTime\":\"2023-01-02 13:05:08\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"养鸡场有限公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"email\":\"12345@qq.com\",\"law\":\"张三\",\"loginIp\":\"\",\"nickName\":\"plant\",\"params\":{},\"phonenumber\":\"14022222222\",\"roles\":[{\"admin\":false,\"dataScope\":\"1\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"plant\",\"roleName\":\"养殖户角色\",\"roleSort\":\"1\",\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"uploadsurl\":\"http://localhost/dev-api//profile/upload/2023/01/02/check_20230102131316A003.jpg\",\"userId\":101,\"userName\":\"plant\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2023-01-02 13:13:19');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2022-12-18 16:42:05', '', NULL, '');
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2022-12-18 16:42:05', '', NULL, '');
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-12-18 16:42:05', '', NULL, '');
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2022-12-18 16:42:05', '', NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2022-12-18 16:42:07', '', NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '2', 0, 0, '1', '0', 'admin', '2022-12-18 16:42:07', 'admin', '2023-01-02 13:02:53', '普通角色');
INSERT INTO `sys_role` VALUES (100, '养殖户角色', 'plant', 1, '1', 1, 1, '0', '0', 'admin', '2023-01-02 12:49:34', '', NULL, NULL);
INSERT INTO `sys_role` VALUES (101, '运输角色', 'transport', 3, '1', 1, 1, '0', '0', 'admin', '2023-01-02 12:50:22', 'admin', '2023-01-02 13:02:47', NULL);
INSERT INTO `sys_role` VALUES (102, '销售角色', 'sell', 4, '1', 1, 1, '0', '0', 'admin', '2023-01-02 12:50:42', 'admin', '2023-01-02 13:03:07', NULL);
INSERT INTO `sys_role` VALUES (103, '巡查角色', 'check', 5, '1', 1, 1, '0', '0', 'admin', '2023-01-02 12:51:04', 'admin', '2023-01-02 13:03:24', NULL);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 2);
INSERT INTO `sys_role_menu` VALUES (2, 3);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 109);
INSERT INTO `sys_role_menu` VALUES (2, 110);
INSERT INTO `sys_role_menu` VALUES (2, 111);
INSERT INTO `sys_role_menu` VALUES (2, 112);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 114);
INSERT INTO `sys_role_menu` VALUES (2, 115);
INSERT INTO `sys_role_menu` VALUES (2, 116);
INSERT INTO `sys_role_menu` VALUES (2, 117);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1046);
INSERT INTO `sys_role_menu` VALUES (2, 1047);
INSERT INTO `sys_role_menu` VALUES (2, 1048);
INSERT INTO `sys_role_menu` VALUES (2, 1049);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1051);
INSERT INTO `sys_role_menu` VALUES (2, 1052);
INSERT INTO `sys_role_menu` VALUES (2, 1053);
INSERT INTO `sys_role_menu` VALUES (2, 1054);
INSERT INTO `sys_role_menu` VALUES (2, 1055);
INSERT INTO `sys_role_menu` VALUES (2, 1056);
INSERT INTO `sys_role_menu` VALUES (2, 1057);
INSERT INTO `sys_role_menu` VALUES (2, 1058);
INSERT INTO `sys_role_menu` VALUES (2, 1059);
INSERT INTO `sys_role_menu` VALUES (2, 1060);
INSERT INTO `sys_role_menu` VALUES (100, 1);
INSERT INTO `sys_role_menu` VALUES (100, 100);
INSERT INTO `sys_role_menu` VALUES (100, 101);
INSERT INTO `sys_role_menu` VALUES (100, 102);
INSERT INTO `sys_role_menu` VALUES (100, 103);
INSERT INTO `sys_role_menu` VALUES (100, 104);
INSERT INTO `sys_role_menu` VALUES (100, 105);
INSERT INTO `sys_role_menu` VALUES (100, 106);
INSERT INTO `sys_role_menu` VALUES (100, 107);
INSERT INTO `sys_role_menu` VALUES (100, 108);
INSERT INTO `sys_role_menu` VALUES (100, 500);
INSERT INTO `sys_role_menu` VALUES (100, 501);
INSERT INTO `sys_role_menu` VALUES (100, 1000);
INSERT INTO `sys_role_menu` VALUES (100, 1001);
INSERT INTO `sys_role_menu` VALUES (100, 1002);
INSERT INTO `sys_role_menu` VALUES (100, 1003);
INSERT INTO `sys_role_menu` VALUES (100, 1004);
INSERT INTO `sys_role_menu` VALUES (100, 1005);
INSERT INTO `sys_role_menu` VALUES (100, 1006);
INSERT INTO `sys_role_menu` VALUES (100, 1007);
INSERT INTO `sys_role_menu` VALUES (100, 1008);
INSERT INTO `sys_role_menu` VALUES (100, 1009);
INSERT INTO `sys_role_menu` VALUES (100, 1010);
INSERT INTO `sys_role_menu` VALUES (100, 1011);
INSERT INTO `sys_role_menu` VALUES (100, 1012);
INSERT INTO `sys_role_menu` VALUES (100, 1013);
INSERT INTO `sys_role_menu` VALUES (100, 1014);
INSERT INTO `sys_role_menu` VALUES (100, 1015);
INSERT INTO `sys_role_menu` VALUES (100, 1016);
INSERT INTO `sys_role_menu` VALUES (100, 1017);
INSERT INTO `sys_role_menu` VALUES (100, 1018);
INSERT INTO `sys_role_menu` VALUES (100, 1019);
INSERT INTO `sys_role_menu` VALUES (100, 1020);
INSERT INTO `sys_role_menu` VALUES (100, 1021);
INSERT INTO `sys_role_menu` VALUES (100, 1022);
INSERT INTO `sys_role_menu` VALUES (100, 1023);
INSERT INTO `sys_role_menu` VALUES (100, 1024);
INSERT INTO `sys_role_menu` VALUES (100, 1025);
INSERT INTO `sys_role_menu` VALUES (100, 1026);
INSERT INTO `sys_role_menu` VALUES (100, 1027);
INSERT INTO `sys_role_menu` VALUES (100, 1028);
INSERT INTO `sys_role_menu` VALUES (100, 1029);
INSERT INTO `sys_role_menu` VALUES (100, 1030);
INSERT INTO `sys_role_menu` VALUES (100, 1031);
INSERT INTO `sys_role_menu` VALUES (100, 1032);
INSERT INTO `sys_role_menu` VALUES (100, 1033);
INSERT INTO `sys_role_menu` VALUES (100, 1034);
INSERT INTO `sys_role_menu` VALUES (100, 1035);
INSERT INTO `sys_role_menu` VALUES (100, 1036);
INSERT INTO `sys_role_menu` VALUES (100, 1037);
INSERT INTO `sys_role_menu` VALUES (100, 1038);
INSERT INTO `sys_role_menu` VALUES (100, 1039);
INSERT INTO `sys_role_menu` VALUES (100, 1040);
INSERT INTO `sys_role_menu` VALUES (100, 1041);
INSERT INTO `sys_role_menu` VALUES (100, 1042);
INSERT INTO `sys_role_menu` VALUES (100, 1043);
INSERT INTO `sys_role_menu` VALUES (100, 1044);
INSERT INTO `sys_role_menu` VALUES (100, 1045);
INSERT INTO `sys_role_menu` VALUES (100, 2006);
INSERT INTO `sys_role_menu` VALUES (100, 2007);
INSERT INTO `sys_role_menu` VALUES (100, 2008);
INSERT INTO `sys_role_menu` VALUES (100, 2009);
INSERT INTO `sys_role_menu` VALUES (100, 2010);
INSERT INTO `sys_role_menu` VALUES (100, 2011);
INSERT INTO `sys_role_menu` VALUES (100, 2012);
INSERT INTO `sys_role_menu` VALUES (100, 2013);
INSERT INTO `sys_role_menu` VALUES (100, 2014);
INSERT INTO `sys_role_menu` VALUES (100, 2015);
INSERT INTO `sys_role_menu` VALUES (100, 2016);
INSERT INTO `sys_role_menu` VALUES (100, 2017);
INSERT INTO `sys_role_menu` VALUES (100, 2018);
INSERT INTO `sys_role_menu` VALUES (100, 2019);
INSERT INTO `sys_role_menu` VALUES (100, 2020);
INSERT INTO `sys_role_menu` VALUES (100, 2021);
INSERT INTO `sys_role_menu` VALUES (100, 2022);
INSERT INTO `sys_role_menu` VALUES (100, 2023);
INSERT INTO `sys_role_menu` VALUES (100, 2024);
INSERT INTO `sys_role_menu` VALUES (100, 2025);
INSERT INTO `sys_role_menu` VALUES (100, 2026);
INSERT INTO `sys_role_menu` VALUES (100, 2027);
INSERT INTO `sys_role_menu` VALUES (100, 2028);
INSERT INTO `sys_role_menu` VALUES (100, 2029);
INSERT INTO `sys_role_menu` VALUES (100, 2030);
INSERT INTO `sys_role_menu` VALUES (100, 2031);
INSERT INTO `sys_role_menu` VALUES (100, 2032);
INSERT INTO `sys_role_menu` VALUES (100, 2033);
INSERT INTO `sys_role_menu` VALUES (100, 2034);
INSERT INTO `sys_role_menu` VALUES (100, 2035);
INSERT INTO `sys_role_menu` VALUES (100, 2060);
INSERT INTO `sys_role_menu` VALUES (101, 1);
INSERT INTO `sys_role_menu` VALUES (101, 100);
INSERT INTO `sys_role_menu` VALUES (101, 101);
INSERT INTO `sys_role_menu` VALUES (101, 102);
INSERT INTO `sys_role_menu` VALUES (101, 103);
INSERT INTO `sys_role_menu` VALUES (101, 104);
INSERT INTO `sys_role_menu` VALUES (101, 105);
INSERT INTO `sys_role_menu` VALUES (101, 106);
INSERT INTO `sys_role_menu` VALUES (101, 107);
INSERT INTO `sys_role_menu` VALUES (101, 108);
INSERT INTO `sys_role_menu` VALUES (101, 500);
INSERT INTO `sys_role_menu` VALUES (101, 501);
INSERT INTO `sys_role_menu` VALUES (101, 1000);
INSERT INTO `sys_role_menu` VALUES (101, 1001);
INSERT INTO `sys_role_menu` VALUES (101, 1002);
INSERT INTO `sys_role_menu` VALUES (101, 1003);
INSERT INTO `sys_role_menu` VALUES (101, 1004);
INSERT INTO `sys_role_menu` VALUES (101, 1005);
INSERT INTO `sys_role_menu` VALUES (101, 1006);
INSERT INTO `sys_role_menu` VALUES (101, 1007);
INSERT INTO `sys_role_menu` VALUES (101, 1008);
INSERT INTO `sys_role_menu` VALUES (101, 1009);
INSERT INTO `sys_role_menu` VALUES (101, 1010);
INSERT INTO `sys_role_menu` VALUES (101, 1011);
INSERT INTO `sys_role_menu` VALUES (101, 1012);
INSERT INTO `sys_role_menu` VALUES (101, 1013);
INSERT INTO `sys_role_menu` VALUES (101, 1014);
INSERT INTO `sys_role_menu` VALUES (101, 1015);
INSERT INTO `sys_role_menu` VALUES (101, 1016);
INSERT INTO `sys_role_menu` VALUES (101, 1017);
INSERT INTO `sys_role_menu` VALUES (101, 1018);
INSERT INTO `sys_role_menu` VALUES (101, 1019);
INSERT INTO `sys_role_menu` VALUES (101, 1020);
INSERT INTO `sys_role_menu` VALUES (101, 1021);
INSERT INTO `sys_role_menu` VALUES (101, 1022);
INSERT INTO `sys_role_menu` VALUES (101, 1023);
INSERT INTO `sys_role_menu` VALUES (101, 1024);
INSERT INTO `sys_role_menu` VALUES (101, 1025);
INSERT INTO `sys_role_menu` VALUES (101, 1026);
INSERT INTO `sys_role_menu` VALUES (101, 1027);
INSERT INTO `sys_role_menu` VALUES (101, 1028);
INSERT INTO `sys_role_menu` VALUES (101, 1029);
INSERT INTO `sys_role_menu` VALUES (101, 1030);
INSERT INTO `sys_role_menu` VALUES (101, 1031);
INSERT INTO `sys_role_menu` VALUES (101, 1032);
INSERT INTO `sys_role_menu` VALUES (101, 1033);
INSERT INTO `sys_role_menu` VALUES (101, 1034);
INSERT INTO `sys_role_menu` VALUES (101, 1035);
INSERT INTO `sys_role_menu` VALUES (101, 1036);
INSERT INTO `sys_role_menu` VALUES (101, 1037);
INSERT INTO `sys_role_menu` VALUES (101, 1038);
INSERT INTO `sys_role_menu` VALUES (101, 1039);
INSERT INTO `sys_role_menu` VALUES (101, 1040);
INSERT INTO `sys_role_menu` VALUES (101, 1041);
INSERT INTO `sys_role_menu` VALUES (101, 1042);
INSERT INTO `sys_role_menu` VALUES (101, 1043);
INSERT INTO `sys_role_menu` VALUES (101, 1044);
INSERT INTO `sys_role_menu` VALUES (101, 1045);
INSERT INTO `sys_role_menu` VALUES (101, 2036);
INSERT INTO `sys_role_menu` VALUES (101, 2037);
INSERT INTO `sys_role_menu` VALUES (101, 2038);
INSERT INTO `sys_role_menu` VALUES (101, 2039);
INSERT INTO `sys_role_menu` VALUES (101, 2040);
INSERT INTO `sys_role_menu` VALUES (101, 2041);
INSERT INTO `sys_role_menu` VALUES (101, 2062);
INSERT INTO `sys_role_menu` VALUES (102, 1);
INSERT INTO `sys_role_menu` VALUES (102, 100);
INSERT INTO `sys_role_menu` VALUES (102, 101);
INSERT INTO `sys_role_menu` VALUES (102, 102);
INSERT INTO `sys_role_menu` VALUES (102, 103);
INSERT INTO `sys_role_menu` VALUES (102, 104);
INSERT INTO `sys_role_menu` VALUES (102, 105);
INSERT INTO `sys_role_menu` VALUES (102, 106);
INSERT INTO `sys_role_menu` VALUES (102, 107);
INSERT INTO `sys_role_menu` VALUES (102, 108);
INSERT INTO `sys_role_menu` VALUES (102, 500);
INSERT INTO `sys_role_menu` VALUES (102, 501);
INSERT INTO `sys_role_menu` VALUES (102, 1000);
INSERT INTO `sys_role_menu` VALUES (102, 1001);
INSERT INTO `sys_role_menu` VALUES (102, 1002);
INSERT INTO `sys_role_menu` VALUES (102, 1003);
INSERT INTO `sys_role_menu` VALUES (102, 1004);
INSERT INTO `sys_role_menu` VALUES (102, 1005);
INSERT INTO `sys_role_menu` VALUES (102, 1006);
INSERT INTO `sys_role_menu` VALUES (102, 1007);
INSERT INTO `sys_role_menu` VALUES (102, 1008);
INSERT INTO `sys_role_menu` VALUES (102, 1009);
INSERT INTO `sys_role_menu` VALUES (102, 1010);
INSERT INTO `sys_role_menu` VALUES (102, 1011);
INSERT INTO `sys_role_menu` VALUES (102, 1012);
INSERT INTO `sys_role_menu` VALUES (102, 1013);
INSERT INTO `sys_role_menu` VALUES (102, 1014);
INSERT INTO `sys_role_menu` VALUES (102, 1015);
INSERT INTO `sys_role_menu` VALUES (102, 1016);
INSERT INTO `sys_role_menu` VALUES (102, 1017);
INSERT INTO `sys_role_menu` VALUES (102, 1018);
INSERT INTO `sys_role_menu` VALUES (102, 1019);
INSERT INTO `sys_role_menu` VALUES (102, 1020);
INSERT INTO `sys_role_menu` VALUES (102, 1021);
INSERT INTO `sys_role_menu` VALUES (102, 1022);
INSERT INTO `sys_role_menu` VALUES (102, 1023);
INSERT INTO `sys_role_menu` VALUES (102, 1024);
INSERT INTO `sys_role_menu` VALUES (102, 1025);
INSERT INTO `sys_role_menu` VALUES (102, 1026);
INSERT INTO `sys_role_menu` VALUES (102, 1027);
INSERT INTO `sys_role_menu` VALUES (102, 1028);
INSERT INTO `sys_role_menu` VALUES (102, 1029);
INSERT INTO `sys_role_menu` VALUES (102, 1030);
INSERT INTO `sys_role_menu` VALUES (102, 1031);
INSERT INTO `sys_role_menu` VALUES (102, 1032);
INSERT INTO `sys_role_menu` VALUES (102, 1033);
INSERT INTO `sys_role_menu` VALUES (102, 1034);
INSERT INTO `sys_role_menu` VALUES (102, 1035);
INSERT INTO `sys_role_menu` VALUES (102, 1036);
INSERT INTO `sys_role_menu` VALUES (102, 1037);
INSERT INTO `sys_role_menu` VALUES (102, 1038);
INSERT INTO `sys_role_menu` VALUES (102, 1039);
INSERT INTO `sys_role_menu` VALUES (102, 1040);
INSERT INTO `sys_role_menu` VALUES (102, 1041);
INSERT INTO `sys_role_menu` VALUES (102, 1042);
INSERT INTO `sys_role_menu` VALUES (102, 1043);
INSERT INTO `sys_role_menu` VALUES (102, 1044);
INSERT INTO `sys_role_menu` VALUES (102, 1045);
INSERT INTO `sys_role_menu` VALUES (102, 2048);
INSERT INTO `sys_role_menu` VALUES (102, 2049);
INSERT INTO `sys_role_menu` VALUES (102, 2050);
INSERT INTO `sys_role_menu` VALUES (102, 2051);
INSERT INTO `sys_role_menu` VALUES (102, 2052);
INSERT INTO `sys_role_menu` VALUES (102, 2053);
INSERT INTO `sys_role_menu` VALUES (102, 2063);
INSERT INTO `sys_role_menu` VALUES (103, 1);
INSERT INTO `sys_role_menu` VALUES (103, 100);
INSERT INTO `sys_role_menu` VALUES (103, 101);
INSERT INTO `sys_role_menu` VALUES (103, 102);
INSERT INTO `sys_role_menu` VALUES (103, 103);
INSERT INTO `sys_role_menu` VALUES (103, 104);
INSERT INTO `sys_role_menu` VALUES (103, 105);
INSERT INTO `sys_role_menu` VALUES (103, 106);
INSERT INTO `sys_role_menu` VALUES (103, 107);
INSERT INTO `sys_role_menu` VALUES (103, 108);
INSERT INTO `sys_role_menu` VALUES (103, 500);
INSERT INTO `sys_role_menu` VALUES (103, 501);
INSERT INTO `sys_role_menu` VALUES (103, 1000);
INSERT INTO `sys_role_menu` VALUES (103, 1001);
INSERT INTO `sys_role_menu` VALUES (103, 1002);
INSERT INTO `sys_role_menu` VALUES (103, 1003);
INSERT INTO `sys_role_menu` VALUES (103, 1004);
INSERT INTO `sys_role_menu` VALUES (103, 1005);
INSERT INTO `sys_role_menu` VALUES (103, 1006);
INSERT INTO `sys_role_menu` VALUES (103, 1007);
INSERT INTO `sys_role_menu` VALUES (103, 1008);
INSERT INTO `sys_role_menu` VALUES (103, 1009);
INSERT INTO `sys_role_menu` VALUES (103, 1010);
INSERT INTO `sys_role_menu` VALUES (103, 1011);
INSERT INTO `sys_role_menu` VALUES (103, 1012);
INSERT INTO `sys_role_menu` VALUES (103, 1013);
INSERT INTO `sys_role_menu` VALUES (103, 1014);
INSERT INTO `sys_role_menu` VALUES (103, 1015);
INSERT INTO `sys_role_menu` VALUES (103, 1016);
INSERT INTO `sys_role_menu` VALUES (103, 1017);
INSERT INTO `sys_role_menu` VALUES (103, 1018);
INSERT INTO `sys_role_menu` VALUES (103, 1019);
INSERT INTO `sys_role_menu` VALUES (103, 1020);
INSERT INTO `sys_role_menu` VALUES (103, 1021);
INSERT INTO `sys_role_menu` VALUES (103, 1022);
INSERT INTO `sys_role_menu` VALUES (103, 1023);
INSERT INTO `sys_role_menu` VALUES (103, 1024);
INSERT INTO `sys_role_menu` VALUES (103, 1025);
INSERT INTO `sys_role_menu` VALUES (103, 1026);
INSERT INTO `sys_role_menu` VALUES (103, 1027);
INSERT INTO `sys_role_menu` VALUES (103, 1028);
INSERT INTO `sys_role_menu` VALUES (103, 1029);
INSERT INTO `sys_role_menu` VALUES (103, 1030);
INSERT INTO `sys_role_menu` VALUES (103, 1031);
INSERT INTO `sys_role_menu` VALUES (103, 1032);
INSERT INTO `sys_role_menu` VALUES (103, 1033);
INSERT INTO `sys_role_menu` VALUES (103, 1034);
INSERT INTO `sys_role_menu` VALUES (103, 1035);
INSERT INTO `sys_role_menu` VALUES (103, 1036);
INSERT INTO `sys_role_menu` VALUES (103, 1037);
INSERT INTO `sys_role_menu` VALUES (103, 1038);
INSERT INTO `sys_role_menu` VALUES (103, 1039);
INSERT INTO `sys_role_menu` VALUES (103, 1040);
INSERT INTO `sys_role_menu` VALUES (103, 1041);
INSERT INTO `sys_role_menu` VALUES (103, 1042);
INSERT INTO `sys_role_menu` VALUES (103, 1043);
INSERT INTO `sys_role_menu` VALUES (103, 1044);
INSERT INTO `sys_role_menu` VALUES (103, 1045);
INSERT INTO `sys_role_menu` VALUES (103, 2000);
INSERT INTO `sys_role_menu` VALUES (103, 2001);
INSERT INTO `sys_role_menu` VALUES (103, 2002);
INSERT INTO `sys_role_menu` VALUES (103, 2003);
INSERT INTO `sys_role_menu` VALUES (103, 2004);
INSERT INTO `sys_role_menu` VALUES (103, 2005);
INSERT INTO `sys_role_menu` VALUES (103, 2042);
INSERT INTO `sys_role_menu` VALUES (103, 2043);
INSERT INTO `sys_role_menu` VALUES (103, 2044);
INSERT INTO `sys_role_menu` VALUES (103, 2045);
INSERT INTO `sys_role_menu` VALUES (103, 2046);
INSERT INTO `sys_role_menu` VALUES (103, 2047);
INSERT INTO `sys_role_menu` VALUES (103, 2061);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业地址',
  `law` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业法人',
  `uploadsurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资格证书上传',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 105 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', '123@qq.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2023-01-02 13:07:50', 'admin', '2022-12-18 16:42:03', '', '2023-01-02 13:07:49', '管理员', '台湾省', '李四', 'http://localhost/dev-api//profile/upload/2023/01/01/check_20230101154745A004.jpg');
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-12-18 16:42:03', 'admin', '2022-12-18 16:42:03', '', NULL, '测试员', NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (100, 105, 'user', 'user', '00', '111@qq.com', '13011111111', '0', '', '$2a$10$bFh4ZFNSt36miQWtMg1zg.RSWOfjlZXEac59gMScbO1Zbigpedyza', '0', '0', '127.0.0.1', '2023-01-02 12:45:19', '', '2023-01-02 12:44:47', 'admin', '2023-01-02 12:53:32', NULL, '中国广州养鸡基地', '王二', 'http://localhost/dev-api//profile/upload/2023/01/02/123_20230102125330A001.png');
INSERT INTO `sys_user` VALUES (101, 103, 'plant', 'plant', '00', '12345@qq.com', '14022222222', '0', '', '$2a$10$K8D/0thvZ7Nc8RKzE6Jk/ueaFjxUKOLhIU7qBf2/97ThfmjevfZFG', '0', '0', '127.0.0.1', '2023-01-02 13:12:04', '', '2023-01-02 13:05:08', 'admin', '2023-01-02 13:13:19', NULL, '北京市', '张三', 'http://localhost/dev-api//profile/upload/2023/01/02/check_20230102131316A003.jpg');
INSERT INTO `sys_user` VALUES (102, 203, 'sell', 'sell', '00', '', '', '0', '', '$2a$10$ohqpS2HOo2ReXqRT.eJnQuuUeFX73ilevfRtFvy3JuRWE2Rq36ZU6', '0', '0', '', NULL, '', '2023-01-02 13:06:10', 'admin', '2023-01-02 13:10:53', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (103, 108, 'transport', 'transport', '00', '', '', '0', '', '$2a$10$vsUFX2vQyoi9Y2SrlvjkauYlJf5Vm1HewmmkilJ.h9.X5Zf6pcV6K', '0', '0', '', NULL, '', '2023-01-02 13:06:31', 'admin', '2023-01-02 13:09:01', NULL, NULL, NULL, NULL);
INSERT INTO `sys_user` VALUES (104, 201, 'check', 'check', '00', '', '', '0', '', '$2a$10$9jXMUqCxpmzANoVaFBVry.0GEsDzNRcvq9tXpg/ROg/cCUfVUmiAK', '0', '0', '127.0.0.1', '2023-01-02 13:13:51', '', '2023-01-02 13:06:52', 'admin', '2023-01-02 13:13:51', NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (100, 100);
INSERT INTO `sys_user_role` VALUES (101, 100);
INSERT INTO `sys_user_role` VALUES (102, 102);
INSERT INTO `sys_user_role` VALUES (103, 101);
INSERT INTO `sys_user_role` VALUES (104, 103);

SET FOREIGN_KEY_CHECKS = 1;
