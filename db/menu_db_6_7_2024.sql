-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               9.0.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.7.0.6850
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for menu_db
DROP DATABASE IF EXISTS `menu_db`;
CREATE DATABASE IF NOT EXISTS `menu_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `menu_db`;

-- Dumping structure for table menu_db.banner
DROP TABLE IF EXISTS `banner`;
CREATE TABLE IF NOT EXISTS `banner` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `image` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.banner: ~2 rows (approximately)
DELETE FROM `banner`;
INSERT INTO `banner` (`id`, `image`, `created_at`, `updated_at`) VALUES
	(1, '/banners/banner2.png', '2024-06-14 09:45:03', '2024-06-14 09:45:03'),
	(2, '/banners/banner4.jpg', '2024-06-14 09:47:50', '2024-06-14 09:47:50');

-- Dumping structure for table menu_db.category
DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `serial` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.category: ~4 rows (approximately)
DELETE FROM `category`;
INSERT INTO `category` (`id`, `name`, `image`, `serial`, `created_at`, `updated_at`) VALUES
	(1, 'Đồ uống', '/categories/beer.png', 1, '2024-06-14 10:34:23', '2024-06-14 10:34:23'),
	(2, 'Cơm', '/categories/com.png', 2, '2024-06-14 10:34:23', '2024-06-14 10:34:23'),
	(3, 'Hải sản', '/categories/haisan.png', 3, '2024-06-14 10:49:03', '2024-06-14 10:49:03'),
	(4, 'Lẩu', '/categories/lau.png', 4, '2024-06-14 10:34:23', '2024-06-14 10:34:23');

-- Dumping structure for table menu_db.food
DROP TABLE IF EXISTS `food`;
CREATE TABLE IF NOT EXISTS `food` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `category_id` bigint unsigned NOT NULL,
  `order_count` bigint DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_general_ci,
  `discount` int DEFAULT NULL,
  `is_discount` tinyint(1) NOT NULL,
  `is_show` tinyint(1) NOT NULL,
  `price` float(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `photo_gallery` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_food_category` (`category_id`),
  CONSTRAINT `FK_food_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE,
  CONSTRAINT `food_chk_1` CHECK (json_valid(`photo_gallery`))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.food: ~3 rows (approximately)
DELETE FROM `food`;
INSERT INTO `food` (`id`, `name`, `category_id`, `order_count`, `description`, `discount`, `is_discount`, `is_show`, `price`, `created_at`, `updated_at`, `photo_gallery`) VALUES
	(1, 'Lẩu hội an', 4, 12, NULL, NULL, 0, 1, 111111.00, '2024-06-14 09:45:03', '2024-06-14 09:45:03', '["/foods/lau.jpeg", "/foods/lau.jpeg", "/foods/lau.jpeg", "/foods/lau.jpeg"]'),
	(2, 'Cơm gà xối mỡ', 2, 30, 'Responses are an essential aspect of web development, serving as the server\'s means of communicating with client requests. In frameworks like Vania, similar to other modern web frameworks, responses play a vital role in delivering content, status codes, and headers back to the client.\r\n\r\nIn Vania, crafting responses is straightforward and versatile, allowing developers to tailor the data and presentation to suit their application\'s requirements. Whether it involves returning JSON data, rendering HTML content, or serving files for download, Vania offers a comprehensive set of tools for handling various response scenarios seamlessly.\r\n\r\nA deep understanding of response construction and manipulation empowers developers to build dynamic and interactive web applications. By effectively managing responses, developers can ensure efficient communication between the server and client, thereby delivering a smooth and satisfactory user experience.', 10, 1, 1, 45000.00, '2024-06-15 05:51:53', '2024-06-15 05:51:53', '["/foods/com-ga-xoi-mo.jpg","/foods/com-ga-xoi-mo.jpg","/foods/com-ga-xoi-mo.jpg"]'),
	(3, 'Cocacola', 1, 30, NULL, NULL, 0, 1, 15000.00, '2024-06-15 05:53:39', '2024-06-15 05:53:39', '["/foods/coca.png","/foods/coca.png","/foods/coca.png"]');

-- Dumping structure for table menu_db.order
DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `status` enum('new','processing','completed','cancel') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT 'new',
  `total_price` float NOT NULL,
  `table_id` bigint NOT NULL,
  `payed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_order_table` (`table_id`),
  KEY `status` (`status`,`created_at`) USING BTREE,
  CONSTRAINT `FK_order_table` FOREIGN KEY (`table_id`) REFERENCES `table` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.order: ~34 rows (approximately)
DELETE FROM `order`;
INSERT INTO `order` (`id`, `status`, `total_price`, `table_id`, `payed_at`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(18, 'cancel', 1151610, 1, NULL, '2024-04-25 09:44:23', '2024-06-27 09:59:02', NULL),
	(20, 'cancel', 55500, 2, NULL, '2024-06-25 10:50:56', '2024-06-25 10:50:57', NULL),
	(21, 'cancel', 555000, 1, NULL, '2024-06-25 10:51:37', '2024-06-27 10:00:05', NULL),
	(22, 'new', 15000, 1, NULL, '2024-06-25 10:55:34', '2024-06-27 10:00:01', NULL),
	(23, 'new', 15000, 1, NULL, '2024-06-25 10:56:43', '2024-06-25 10:56:43', NULL),
	(25, 'cancel', 258000, 1, NULL, '2024-06-26 03:08:06', '2024-06-26 03:08:06', NULL),
	(26, 'processing', 40500, 1, NULL, '2025-06-26 03:09:16', '2024-06-27 08:53:16', NULL),
	(27, 'cancel', 40500, 1, NULL, '2024-06-26 03:10:17', '2024-06-26 03:10:17', NULL),
	(28, 'processing', 40500, 1, NULL, '2024-06-26 03:11:38', '2024-06-26 03:11:38', NULL),
	(29, 'new', 15000, 1, NULL, '2024-06-26 03:14:39', '2024-06-26 03:14:39', NULL),
	(30, 'new', 15000, 1, NULL, '2024-06-26 03:15:47', '2024-06-26 03:15:47', NULL),
	(31, 'cancel', 40500, 1, NULL, '2024-06-27 03:19:07', '2024-06-27 09:20:29', NULL),
	(32, 'new', 15000, 1, NULL, '2024-06-26 03:20:27', '2024-06-26 03:20:27', NULL),
	(33, 'new', 15000, 1, NULL, '2024-06-26 03:24:01', '2024-06-26 03:24:01', NULL),
	(34, 'new', 15000, 1, NULL, '2022-06-26 03:25:41', '2024-06-27 08:53:27', NULL),
	(35, 'new', 15000, 1, NULL, '2024-06-26 03:27:20', '2024-06-26 03:27:20', NULL),
	(36, 'new', 15000, 1, NULL, '2024-06-26 03:31:04', '2024-06-26 03:31:04', NULL),
	(37, 'new', 15000, 1, NULL, '2024-06-26 03:37:05', '2024-06-26 03:37:05', NULL),
	(38, 'new', 15000, 1, '2024-06-27 10:30:29', '2024-06-26 08:42:34', '2024-06-27 10:32:07', NULL),
	(39, 'completed', 40500, 1, '2024-06-27 10:07:13', '2024-06-27 08:43:33', '2024-06-27 10:07:16', NULL),
	(40, 'new', 15000, 1, NULL, '2024-06-26 08:45:19', '2024-06-26 08:45:20', NULL),
	(41, 'new', 15000, 1, NULL, '2024-06-26 08:46:34', '2024-06-26 08:46:34', NULL),
	(42, 'new', 15000, 1, NULL, '2024-06-26 08:47:27', '2024-06-26 08:47:27', NULL),
	(43, 'new', 15000, 2, NULL, '2024-06-26 08:47:46', '2024-06-26 08:47:46', NULL),
	(44, 'new', 15000, 1, NULL, '2024-06-26 08:48:46', '2024-06-26 08:48:46', NULL),
	(45, 'processing', 40500, 1, NULL, '2024-06-26 08:51:33', '2024-06-26 08:51:33', NULL),
	(46, 'cancel', 40500, 1, NULL, '2024-06-26 09:00:22', '2024-06-26 09:00:22', NULL),
	(47, 'cancel', 40500, 2, NULL, '2024-06-26 09:51:56', '2024-06-26 09:51:56', NULL),
	(48, 'processing', 15000, 2, NULL, '2024-06-26 09:52:12', '2024-06-26 09:52:12', NULL);

-- Dumping structure for table menu_db.order_detail
DROP TABLE IF EXISTS `order_detail`;
CREATE TABLE IF NOT EXISTS `order_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint NOT NULL,
  `food_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `price` float NOT NULL,
  `total_amount` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `note` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `food_id` (`food_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `FK_order_detail_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`food_id`) REFERENCES `food` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.order_detail: ~44 rows (approximately)
DELETE FROM `order_detail`;
INSERT INTO `order_detail` (`id`, `order_id`, `food_id`, `quantity`, `price`, `total_amount`, `created_at`, `updated_at`, `note`) VALUES
	(36, 18, 2, 1, 45000, 40500, '2024-06-25 09:44:23', '2024-06-25 09:44:23', NULL),
	(37, 18, 1, 10, 111111, 1111110, '2024-06-25 09:44:23', '2024-06-25 09:44:23', NULL),
	(40, 20, 3, 1, 15000, 15000, '2024-06-25 10:50:57', '2024-06-25 10:50:57', NULL),
	(41, 20, 2, 1, 45000, 40500, '2024-06-25 10:50:57', '2024-06-25 10:50:57', NULL),
	(42, 21, 3, 10, 15000, 150000, '2024-06-25 10:51:37', '2024-06-25 10:51:37', NULL),
	(43, 21, 2, 10, 45000, 405000, '2024-06-25 10:51:37', '2024-06-25 10:51:37', NULL),
	(44, 22, 3, 1, 15000, 15000, '2024-06-25 10:55:34', '2024-06-25 10:55:34', NULL),
	(45, 23, 3, 1, 15000, 15000, '2024-06-25 10:56:43', '2024-06-25 10:56:43', NULL),
	(47, 25, 2, 6, 45000, 243000, '2024-06-26 03:08:06', '2024-06-26 03:08:06', NULL),
	(48, 25, 3, 1, 15000, 15000, '2024-06-26 03:08:06', '2024-06-26 03:08:06', NULL),
	(49, 26, 2, 1, 45000, 40500, '2024-06-26 03:09:16', '2024-06-26 03:09:16', NULL),
	(50, 27, 2, 1, 45000, 40500, '2024-06-26 03:10:17', '2024-06-26 03:10:17', NULL),
	(51, 28, 2, 1, 45000, 40500, '2024-06-26 03:11:38', '2024-06-26 03:11:38', NULL),
	(52, 29, 3, 1, 15000, 15000, '2024-06-26 03:14:39', '2024-06-26 03:14:39', NULL),
	(53, 30, 3, 1, 15000, 15000, '2024-06-26 03:15:47', '2024-06-26 03:15:47', NULL),
	(54, 31, 2, 1, 45000, 40500, '2024-06-26 03:19:07', '2024-06-26 03:19:07', NULL),
	(55, 32, 3, 1, 15000, 15000, '2024-06-26 03:20:27', '2024-06-26 03:20:27', NULL),
	(56, 33, 3, 1, 15000, 15000, '2024-06-26 03:24:01', '2024-06-26 03:24:01', NULL),
	(57, 34, 3, 1, 15000, 15000, '2024-06-26 03:25:41', '2024-06-26 03:25:41', NULL),
	(58, 35, 3, 1, 15000, 15000, '2024-06-26 03:27:20', '2024-06-26 03:27:20', NULL),
	(59, 36, 3, 1, 15000, 15000, '2024-06-26 03:31:04', '2024-06-26 03:31:04', NULL),
	(60, 37, 3, 1, 15000, 15000, '2024-06-26 03:37:05', '2024-06-26 03:37:05', NULL),
	(61, 38, 3, 1, 15000, 15000, '2024-06-26 08:42:34', '2024-06-26 08:42:34', NULL),
	(62, 39, 2, 1, 45000, 40500, '2024-06-26 08:43:33', '2024-06-26 08:43:33', NULL),
	(63, 40, 3, 1, 15000, 15000, '2024-06-26 08:45:19', '2024-06-26 08:45:19', NULL),
	(64, 41, 3, 1, 15000, 15000, '2024-06-26 08:46:34', '2024-06-26 08:46:34', NULL),
	(65, 42, 3, 1, 15000, 15000, '2024-06-26 08:47:27', '2024-06-26 08:47:27', NULL),
	(66, 43, 3, 1, 15000, 15000, '2024-06-26 08:47:46', '2024-06-26 08:47:46', NULL),
	(67, 44, 3, 1, 15000, 15000, '2024-06-26 08:48:46', '2024-06-26 08:48:46', NULL),
	(68, 45, 2, 1, 45000, 40500, '2024-06-26 08:51:33', '2024-06-26 08:51:33', NULL),
	(69, 46, 2, 1, 45000, 40500, '2024-06-26 09:00:22', '2024-06-26 09:00:22', NULL),
	(70, 47, 2, 1, 45000, 40500, '2024-06-26 09:51:56', '2024-06-26 09:51:56', NULL),
	(71, 48, 3, 1, 15000, 15000, '2024-06-26 09:52:12', '2024-06-26 09:52:12', NULL);

-- Dumping structure for table menu_db.personal_access_tokens
DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` tinytext COLLATE utf8mb4_general_ci NOT NULL,
  `tokenable_id` bigint NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB AUTO_INCREMENT=158 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.personal_access_tokens: ~84 rows (approximately)
DELETE FROM `personal_access_tokens`;
INSERT INTO `personal_access_tokens` (`id`, `name`, `tokenable_id`, `token`, `last_used_at`, `created_at`, `deleted_at`) VALUES
	(74, 'default', 1, 'e666d75d6863a8cc912aef5bb494e4c9', '2024-06-21 03:23:49', '2024-06-21 03:23:49', NULL),
	(75, 'default', 1, '99314262b2b17122ea570d41a80ab17a', '2024-06-21 03:27:01', '2024-06-21 03:26:29', NULL),
	(76, 'default', 1, 'baee2c73f4119706211ed84fac6e48cc', '2024-06-21 03:31:44', '2024-06-21 03:31:43', '2024-06-21 03:42:08'),
	(77, 'default', 1, '50874ecb41e3d137b49b212c202a12b7', '2024-06-21 03:42:10', '2024-06-21 03:42:10', NULL),
	(78, 'default', 1, 'ff3949b46311c8028a09d05e60b27128', '2024-06-21 03:43:31', '2024-06-21 03:43:30', '2024-06-21 03:44:03'),
	(79, 'default', 1, '268501db60f8a2cb06bb57036237ae70', '2024-06-21 03:44:58', '2024-06-21 03:44:05', '2024-06-21 03:45:03'),
	(80, 'default', 1, 'bd5a730b8e4d8525f691ac1e3fe632b4', '2024-06-21 03:45:05', '2024-06-21 03:45:05', NULL),
	(81, 'default', 1, 'a81ea394c79647990ee49fffa57fe5ef', '2024-06-21 10:09:02', '2024-06-21 04:09:54', NULL),
	(82, 'default', 1, 'be46ae9779bdef3b5ab299063d07461a', '2024-06-21 10:18:49', '2024-06-21 10:13:14', '2024-06-21 10:21:24'),
	(83, 'default', 1, '91a28140bcff05779e504de4866128be', '2024-06-21 10:28:36', '2024-06-21 10:28:36', '2024-06-21 10:29:48'),
	(84, 'default', 1, 'a7c73c4baf7dbfe507fa212df29debe6', '2024-06-21 10:29:50', '2024-06-21 10:29:50', '2024-06-21 10:30:05'),
	(85, 'default', 1, '21f045a4feeff5d191389534194a1aef', '2024-06-22 07:25:50', '2024-06-21 10:30:36', NULL),
	(86, 'default', 1, 'ed5956010a1c0c20630a9bfa77db4e62', NULL, '2024-06-22 05:41:54', NULL),
	(87, 'default', 1, '488fcdb3bee20ccf7ecca3ac4099bc64', NULL, '2024-06-22 07:54:54', NULL),
	(88, 'default', 1, '950ced047c510c297ca3ef88933af94f', NULL, '2024-06-24 03:33:25', NULL),
	(89, 'default', 1, '6775559825e1bd0a252838f5fde1d521', NULL, '2024-06-24 08:54:48', NULL),
	(90, 'default', 1, 'a6ab631543a286a50e9386a343fec095', '2024-06-24 08:54:55', '2024-06-24 08:54:55', NULL),
	(91, 'default', 1, '054c21945daba97d9823b8bff6e11a0c', NULL, '2024-06-25 09:43:06', NULL),
	(92, 'default', 1, 'c14386a2d14ac9185b732124dc1ab2c5', '2024-06-26 08:47:14', '2024-06-25 09:43:20', '2024-06-26 09:01:32'),
	(93, 'default', 1, '078ab1dea9156b114751f667ae6e4e8e', NULL, '2024-06-26 09:02:05', NULL),
	(94, 'default', 1, '25c3acfd717a1e7515ed3c7a76b29d2e', '2024-06-28 02:58:49', '2024-06-28 02:58:38', NULL),
	(95, 'default', 1, 'c808a6b8cb1f337ac2600e1690528172', '2024-06-28 03:35:06', '2024-06-28 03:26:18', '2024-06-28 08:49:28'),
	(96, 'default', 1, '28797a72db11ae894959a511b1e62428', NULL, '2024-06-28 07:24:33', NULL),
	(97, 'default', 1, 'f42909e23f6eb9a951c87c6f2c682cad', NULL, '2024-06-28 07:27:22', NULL),
	(98, 'default', 1, '816337f08f350f8a8ce06655f1b7c372', NULL, '2024-06-28 07:29:05', NULL),
	(99, 'default', 1, '4e59e6830072d61023ec552ea96a6897', NULL, '2024-06-28 07:30:10', NULL),
	(100, 'default', 1, 'f31791518739634bcb101dbcb81118e3', NULL, '2024-06-28 08:23:47', NULL),
	(101, 'default', 1, '7f5aa240cae0c1ef8cdc1d85766a3ebe', NULL, '2024-06-28 08:46:05', NULL),
	(102, 'default', 1, '2606104bef86239f38601b508d4595b5', NULL, '2024-06-28 08:47:03', NULL),
	(103, 'default', 1, 'b481c013870e02e05d9279e828606128', NULL, '2024-06-28 08:49:32', NULL),
	(104, 'default', 1, 'ec12d2e1c94cfe8ad018ae0d5a45108c', NULL, '2024-06-28 08:58:35', NULL),
	(105, 'default', 1, '8b644e17b407de9c7cce3444511a2ed2', NULL, '2024-06-28 08:59:24', NULL),
	(106, 'default', 1, '0b74637b03ede5bca128016ef9568186', NULL, '2024-06-28 09:11:54', NULL),
	(107, 'default', 1, 'e62e3f1f5bd1b79e66446f6757dc9138', NULL, '2024-06-28 09:14:03', NULL),
	(108, 'default', 1, '504245465be330a2491da761aed8a6f3', NULL, '2024-06-28 09:34:46', NULL),
	(109, 'default', 1, '82437a0b0085e0b2e7012fb7e14824da', NULL, '2024-06-28 09:35:51', NULL),
	(110, 'default', 1, '4494d34d4d266cdab520cce94939e21a', NULL, '2024-06-29 07:10:08', NULL),
	(111, 'default', 1, '42ef1487c985427efda6605f25970bbc', NULL, '2024-07-01 06:36:26', NULL),
	(112, 'default', 1, '2f97d2937d3b09a6330aecab1b4bfcf7', '2024-07-01 06:44:06', '2024-07-01 06:36:34', NULL),
	(113, 'default', 1, '65aa860d1fc5613992c3506c767efaca', NULL, '2024-07-01 07:53:35', NULL),
	(114, 'default', 1, '169c4a3438d5100321ded42fc1a24749', NULL, '2024-07-01 09:24:07', NULL),
	(115, 'default', 1, '83852d96d2e4f3232b709adc4b919205', NULL, '2024-07-01 09:24:11', NULL),
	(116, 'default', 1, '7abc81e24cbc2b97fb5f04e268a3875f', NULL, '2024-07-01 09:24:31', NULL),
	(117, 'default', 1, 'ad5e94ec473203176c9788bec400b0dd', NULL, '2024-07-01 09:24:37', NULL),
	(118, 'default', 1, 'a1a0fe853b8da38699b6d5c67a692414', NULL, '2024-07-01 09:34:12', NULL),
	(119, 'default', 1, 'db0de00a6c1a52f4ce02add62348b222', NULL, '2024-07-01 09:34:47', NULL),
	(120, 'default', 1, '188ae3a25341630f51dff3e8612189a9', NULL, '2024-07-01 09:35:21', NULL),
	(121, 'default', 1, '3a59f89f79e903913108b0a1bf4d5151', NULL, '2024-07-01 09:36:40', NULL),
	(122, 'default', 1, 'f9fa1edd8b920a343c365b7d81dd57e1', NULL, '2024-07-01 09:38:15', NULL),
	(123, 'default', 1, '75c53228de462474eac2f69ea2b5d9d5', NULL, '2024-07-01 09:38:21', NULL),
	(124, 'default', 1, '99e84559ab8a6fcb7f33f7e658c1d3de', NULL, '2024-07-01 10:00:55', NULL),
	(125, 'default', 1, '2dc24ff69d2f46c3243b4ccd406de135', NULL, '2024-07-01 11:07:43', NULL),
	(126, 'default', 1, 'b1554a0de0c629dfc8f1da7d6404d218', NULL, '2024-07-01 11:07:54', NULL),
	(127, 'default', 1, '23d7100d02d7c676604a79e85ca0f1ea', NULL, '2024-07-01 11:09:38', NULL),
	(128, 'default', 1, 'bd9b0e47536418636bbc02e0236fb164', NULL, '2024-07-01 11:13:35', NULL),
	(129, 'default', 1, '5756047e4ad1c8cea5aa387c59b6841e', NULL, '2024-07-01 11:13:38', NULL),
	(130, 'default', 1, '29541a3348a73e1c9bff5ac1162d7930', NULL, '2024-07-01 11:13:49', NULL),
	(131, 'default', 1, '84038f341b951474431c1a1e4f099821', NULL, '2024-07-01 11:15:14', NULL),
	(132, 'default', 1, '73b3314d62a582fda03c1f466bff66ed', NULL, '2024-07-01 11:15:23', NULL),
	(133, 'default', 1, '579530fb86f7aca78a6147d829722263', NULL, '2024-07-01 11:15:25', NULL),
	(134, 'default', 1, '4738ce2434d00a7b074a6e32edd2a271', NULL, '2024-07-01 11:16:33', NULL),
	(135, 'default', 1, 'a39058a6eac6139de4fc388819c955a2', NULL, '2024-07-01 11:16:37', NULL),
	(136, 'default', 1, '35d9bfa85cec8e827e21c0fd52f6f7a7', NULL, '2024-07-01 11:18:05', NULL),
	(137, 'default', 1, 'b7d2d5651150f5b9a628dac72ff97236', NULL, '2024-07-01 11:18:44', NULL),
	(138, 'default', 1, '66a4d6a9c5c6be5392a89201084d8168', NULL, '2024-07-01 11:20:44', NULL),
	(139, 'default', 1, '9ae8da0630324313a27431ae3ffbc108', NULL, '2024-07-01 11:27:27', NULL),
	(140, 'default', 1, 'c2b3bc40e91e9e629484b9c7d00147ec', NULL, '2024-07-01 11:27:35', NULL),
	(141, 'default', 1, '99ad7ceaea95bef4d7b72974ed05508b', NULL, '2024-07-01 11:27:39', NULL),
	(142, 'default', 1, '8a238bf6957b042d2a9fafd36693d46c', NULL, '2024-07-01 11:27:55', NULL),
	(143, 'default', 1, '138f87f538dfdb5bf394b5cd487acce7', NULL, '2024-07-02 03:49:49', NULL),
	(144, 'default', 1, 'edd043f4d2c5250b6b10672905b97426', NULL, '2024-07-02 04:22:12', NULL),
	(145, 'default', 1, 'e68a52d178be9fb4ea1fa542dda23b17', NULL, '2024-07-02 11:21:29', NULL),
	(146, 'default', 1, '7d2f1d15d3701efbca5be3c23aed850a', NULL, '2024-07-02 11:24:38', NULL),
	(147, 'default', 1, '8284ea0a748d6ed595df0999512af738', NULL, '2024-07-02 11:25:15', NULL),
	(148, 'default', 1, 'f20f4e5ca25fd198c80e94a66b20e9a7', NULL, '2024-07-02 11:41:48', NULL),
	(149, 'default', 1, '897632461ff618d440f95d84ea3b3d4d', NULL, '2024-07-03 02:51:28', NULL),
	(150, 'default', 1, 'ead9dfbc99a17257ba2e04680effb32d', NULL, '2024-07-03 02:58:27', NULL),
	(151, 'default', 1, '1e4db54e9d87823060f2eab802077fc3', NULL, '2024-07-03 05:55:56', NULL),
	(152, 'default', 1, 'd073aeec892950f30c190a44434b5ca6', NULL, '2024-07-03 08:19:11', NULL),
	(153, 'default', 1, '754804e3a180f1085a5748d3e3abee61', NULL, '2024-07-03 08:19:35', NULL),
	(154, 'default', 1, '6bf4a94baaffad3117b75d50463df4df', NULL, '2024-07-03 09:06:19', NULL),
	(155, 'default', 1, '4fe5eb0872704789616fc6969f1251d5', NULL, '2024-07-03 09:06:25', NULL),
	(156, 'default', 1, 'd64f7fa3c94a32d2c03b019005a60732', NULL, '2024-07-03 09:06:29', NULL),
	(157, 'default', 1, '765402c4edc7a696d5dfc6bf898cee46', NULL, '2024-07-03 09:06:37', NULL);

-- Dumping structure for table menu_db.table
DROP TABLE IF EXISTS `table`;
CREATE TABLE IF NOT EXISTS `table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_general_ci NOT NULL,
  `seats` int NOT NULL,
  `is_use` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.table: ~4 rows (approximately)
DELETE FROM `table`;
INSERT INTO `table` (`id`, `name`, `seats`, `is_use`) VALUES
	(1, 'Bàn 1', 2, 1),
	(2, 'Bàn 2', 3, 1),
	(3, 'Bàn 10 trên sân thượng', 2, 0),
	(4, 'Bàn trong nhà vệ sinh', 2, 0);

-- Dumping structure for table menu_db.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `phone_number` int NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.user: ~1 rows (approximately)
DELETE FROM `user`;
INSERT INTO `user` (`id`, `full_name`, `phone_number`, `password`, `image`, `created_at`, `updated_at`) VALUES
	(1, 'Nguyen Tien Anh', 328023993, 'oqsmnvQ6j6+Wu7ja4LeuTearsSC0Y7u/BVV6YyFsMw1fGUIjqi8lz0KRJbFyCElCVaSId/+PO66EXz1K8CpbbU1y0w==', '/users/1/E:imagecom-ga-xoi-mo.jpg', '2024-06-14 07:21:57', '2024-06-22 05:26:33');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
