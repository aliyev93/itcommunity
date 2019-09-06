/*
 Navicat Premium Data Transfer

 Source Server         : localhostMac
 Source Server Type    : MySQL
 Source Server Version : 50721
 Source Host           : 192.168.1.102:3306
 Source Schema         : itcommunity

 Target Server Type    : MySQL
 Target Server Version : 50721
 File Encoding         : 65001

 Date: 06/09/2019 18:14:12
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for auth_group
-- ----------------------------
DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE `auth_group`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group
-- ----------------------------
INSERT INTO `auth_group` VALUES (1, 'ADMIN');
INSERT INTO `auth_group` VALUES (2, 'CLIENT');

-- ----------------------------
-- Table structure for auth_group_role
-- ----------------------------
DROP TABLE IF EXISTS `auth_group_role`;
CREATE TABLE `auth_group_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `insert_date_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_date_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKa68196081fvovjhkek5m97n3y`(`role_id`) USING BTREE,
  INDEX `FK859n2jvi8ivhui0rl0esws6o`(`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_group_role
-- ----------------------------
INSERT INTO `auth_group_role` VALUES (2, 2, 6, '2019-09-05 17:59:36', NULL);
INSERT INTO `auth_group_role` VALUES (3, 2, 7, '2019-09-06 12:53:48', NULL);

-- ----------------------------
-- Table structure for auth_role
-- ----------------------------
DROP TABLE IF EXISTS `auth_role`;
CREATE TABLE `auth_role`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `insert_date_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of auth_role
-- ----------------------------
INSERT INTO `auth_role` VALUES (1, 'ADMIN', '2019-05-09 00:00:00', '2019-05-09 00:00:00');
INSERT INTO `auth_role` VALUES (2, 'CLIENT', '2019-05-09 00:00:00', '2019-05-09 00:00:00');

-- ----------------------------
-- Table structure for employee_profile
-- ----------------------------
DROP TABLE IF EXISTS `employee_profile`;
CREATE TABLE `employee_profile`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `approved` bit(1) NOT NULL,
  `approved_date_time` datetime(0) NOT NULL,
  `cv_path` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `github_path` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `is_looking_for_work` bit(1) NOT NULL,
  `is_working` bit(1) NOT NULL,
  `linkedin_path` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `insert_date_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_date_time` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK5s5kad0xi8m49gscqaxjq2hcw`(`user_id`) USING BTREE,
  CONSTRAINT `employee_profile_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for employee_profile_language
-- ----------------------------
DROP TABLE IF EXISTS `employee_profile_language`;
CREATE TABLE `employee_profile_language`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) NOT NULL,
  `employee_profile_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `insert_date_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_date_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKs4muhk6x4j4tkxqb1odmnfj7m`(`employee_profile_id`) USING BTREE,
  INDEX `FK9wagkcbieklokxxyeeo3e69tq`(`language_id`) USING BTREE,
  CONSTRAINT `employee_profile_language_ibfk_1` FOREIGN KEY (`employee_profile_id`) REFERENCES `employee_profile` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_profile_language_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for employee_profile_skill
-- ----------------------------
DROP TABLE IF EXISTS `employee_profile_skill`;
CREATE TABLE `employee_profile_skill`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` int(11) NULL DEFAULT NULL,
  `employee_profile_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `insert_date_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_date_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKi0g6h7113kqhy19m5xqu34jhf`(`employee_profile_id`) USING BTREE,
  INDEX `FK6vt32pmm7jwvo7yndis5k9395`(`skill_id`) USING BTREE,
  CONSTRAINT `employee_profile_skill_ibfk_1` FOREIGN KEY (`employee_profile_id`) REFERENCES `employee_profile` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_profile_skill_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `skill` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for employee_project
-- ----------------------------
DROP TABLE IF EXISTS `employee_project`;
CREATE TABLE `employee_project`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `approved` smallint(6) NOT NULL,
  `position` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `employee_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `join_date_time` datetime(0) NOT NULL,
  `insert_date_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_date_time` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKpdp6ekpc8854dn4mebe7d1sdj`(`employee_id`) USING BTREE,
  INDEX `FKhi5ffkj0w09uieki7lhiop2ub`(`project_id`) USING BTREE,
  CONSTRAINT `employee_project_ibfk_1` FOREIGN KEY (`employee_id`) REFERENCES `employee_profile` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `employee_project_ibfk_2` FOREIGN KEY (`project_id`) REFERENCES `itproject` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for gender
-- ----------------------------
DROP TABLE IF EXISTS `gender`;
CREATE TABLE `gender`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `insert_date_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_date_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of gender
-- ----------------------------
INSERT INTO `gender` VALUES (1, 'male', '2019-09-05 14:57:41', NULL);
INSERT INTO `gender` VALUES (2, 'female', '2019-09-05 14:57:51', NULL);

-- ----------------------------
-- Table structure for itproject
-- ----------------------------
DROP TABLE IF EXISTS `itproject`;
CREATE TABLE `itproject`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `about` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `github_path` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `in_development` tinyint(1) NOT NULL,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `need_employee` tinyint(1) NULL DEFAULT NULL,
  `publish_date` datetime(0) NULL DEFAULT NULL,
  `website_path` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `thumbnail` varchar(200) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `insert_date_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_date_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of itproject
-- ----------------------------
INSERT INTO `itproject` VALUES (1, 'Bu proyekt IT sahəsində olan, hal-hazırda çalışan və ya çalışmayan hər kəsi eyni platforma altında cəmləyir. IT sahəsində olan şəxs özü haqqında qısa məlumat təsvir edir, hansı bacarıqları hansı səviyyədə bilir onu qeyd edir, cv-sini, linkedin profilini, hal-hazırda çalışıb çalışmadığını qeyd edir.\nBu proyekt ona imkan yaradacaq ki, hansısa şirkət və ya entrepreneur IT sahəsindən hər hansısa məqsədlə(işə götürmə, seminar vermək üçün, freelance layihələr və s.) şəxs axtardıqda rahatlıqla bu portaldan istifadə edə biləcək.', 'https://github.com/bsp-tech/itcommunity', 1, 'test', NULL, NULL, 'https://github.com/bsp-tech/itcommunity', 'https://web-material3.yokogawa.com/f50b5c6f3b3ab4006f471295cdff5684f5afafe9.png', '2019-09-05 15:00:00', NULL);

-- ----------------------------
-- Table structure for language
-- ----------------------------
DROP TABLE IF EXISTS `language`;
CREATE TABLE `language`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `insert_date_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_date_time` datetime(0) NOT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for project_skill
-- ----------------------------
DROP TABLE IF EXISTS `project_skill`;
CREATE TABLE `project_skill`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `insert_date_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_date_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKebssgfcqvrsaxrs00sj0anbi9`(`project_id`) USING BTREE,
  INDEX `FKrhm021cfqcutusb89uxtgyred`(`skill_id`) USING BTREE,
  CONSTRAINT `project_skill_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `itproject` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `project_skill_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `skill` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of project_skill
-- ----------------------------
INSERT INTO `project_skill` VALUES (1, 1, 1, '2019-05-09 00:00:00', NULL);
INSERT INTO `project_skill` VALUES (2, 1, 2, '2019-05-09 00:00:00', NULL);

-- ----------------------------
-- Table structure for skill
-- ----------------------------
DROP TABLE IF EXISTS `skill`;
CREATE TABLE `skill`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `insert_date_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of skill
-- ----------------------------
INSERT INTO `skill` VALUES (1, 'Java', NULL, NULL);
INSERT INTO `skill` VALUES (2, 'Bootstrap', NULL, NULL);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `age` int(11) NOT NULL,
  `email` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `name` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `surname` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `gender_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  `insert_date_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update_date_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FKcbf93j56y7t2tyhunb4neewva`(`gender_id`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE,
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 26, 'sarkhanrasullu@gmail.com', 1, 'Sarkhan', '111111', 'Rasullu', 1, 1, '2019-09-05 15:00:00', '2019-09-06 16:33:41');
INSERT INTO `user` VALUES (6, 1111, 'aa@mail.ru', 0, 'aa', '1111', 'aa', 2, 1, '2019-09-05 17:59:36', '2019-09-06 16:33:34');
INSERT INTO `user` VALUES (7, 111, 'aasdcsdc@mail.ru', 0, 'aa', '1111', 'aa', 2, 1, '2019-09-06 12:53:48', '2019-09-06 16:33:37');
INSERT INTO `user` VALUES (9, 26, 'serxan@gmail.com', 0, 'Sarkhan', '111111', 'Rasullu', 1, 2, '2019-09-06 17:12:10', NULL);

SET FOREIGN_KEY_CHECKS = 1;