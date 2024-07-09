-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 09, 2024 at 01:34 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `menu_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `banner`
--

CREATE TABLE `banner` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `banner`
--

INSERT INTO `banner` (`id`, `image`, `created_at`, `updated_at`) VALUES
(1, '/banners/banner2.png', '2024-06-14 09:45:03', '2024-06-14 09:45:03'),
(2, '/banners/banner4.jpg', '2024-06-14 09:47:50', '2024-06-14 09:47:50');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `serial` int(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `image`, `serial`, `created_at`, `updated_at`) VALUES
(1, 'Đồ uống', '/categories/beer.png', 1, '2024-06-14 10:34:23', '2024-06-14 10:34:23'),
(2, 'Cơm', '/categories/com.png', 2, '2024-06-14 10:34:23', '2024-06-14 10:34:23'),
(3, 'Hải sản', '/categories/haisan.png', 3, '2024-06-14 10:49:03', '2024-06-14 10:49:03'),
(4, 'Lẩu', '/categories/lau.png', 4, '2024-06-14 10:34:23', '2024-06-14 10:34:23');

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image1` text DEFAULT NULL,
  `image2` text DEFAULT NULL,
  `image3` text DEFAULT NULL,
  `image4` text DEFAULT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `order_count` bigint(20) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `discount` int(10) DEFAULT NULL,
  `is_discount` tinyint(1) NOT NULL DEFAULT 0,
  `is_show` tinyint(1) NOT NULL DEFAULT 1,
  `price` float NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`id`, `name`, `image1`, `image2`, `image3`, `image4`, `category_id`, `order_count`, `description`, `discount`, `is_discount`, `is_show`, `price`, `created_at`, `updated_at`) VALUES
(1, 'Lẩu hội an', NULL, NULL, NULL, NULL, 4, 12, NULL, NULL, 0, 1, 111111, '2024-06-14 09:45:03', '2024-06-14 09:45:03'),
(2, 'Cơm gà xối mỡ', NULL, NULL, NULL, NULL, 2, 30, 'Responses are an essential aspect of web development, serving as the server\'s means of communicating with client requests. In frameworks like Vania, similar to other modern web frameworks, responses play a vital role in delivering content, status codes, and headers back to the client.\r\n\r\nIn Vania, crafting responses is straightforward and versatile, allowing developers to tailor the data and presentation to suit their application\'s requirements. Whether it involves returning JSON data, rendering HTML content, or serving files for download, Vania offers a comprehensive set of tools for handling various response scenarios seamlessly.\r\n\r\nA deep understanding of response construction and manipulation empowers developers to build dynamic and interactive web applications. By effectively managing responses, developers can ensure efficient communication between the server and client, thereby delivering a smooth and satisfactory user experience.', 10, 1, 1, 45000, '2024-06-15 05:51:53', '2024-06-15 05:51:53'),
(3, 'Cocacola', NULL, NULL, NULL, NULL, 1, 30, NULL, NULL, 0, 1, 15000, '2024-06-15 05:53:39', '2024-06-15 05:53:39'),
(6, 'cai gi nua', NULL, NULL, NULL, NULL, 1, 0, '', 0, 0, 0, 123, '2024-07-09 05:09:53', NULL),
(8, 'lau ga la e', NULL, NULL, NULL, NULL, 4, 0, '', 0, 0, 0, 300000, '2024-07-09 05:58:32', NULL),
(9, 'pepsi', NULL, NULL, NULL, NULL, 1, 0, '', 0, 0, 0, 15000, '2024-07-09 06:01:14', NULL),
(10, 'Nước cam', NULL, NULL, NULL, NULL, 1, 0, '', 0, 0, 0, 25000, '2024-07-09 06:02:16', NULL),
(11, 'Cơm chiên Dương Châu', NULL, NULL, NULL, NULL, 1, 0, '', 15, 0, 0, 60000, '2024-07-09 06:27:09', NULL),
(12, 'Cá lóc chiên giòn', NULL, NULL, NULL, NULL, 3, 0, '', 20, 0, 0, 300000, '2024-07-09 06:33:12', NULL),
(13, 'asdas', NULL, NULL, NULL, NULL, 1, 0, '', 0, 0, 0, 123, '2024-07-09 07:15:59', NULL),
(14, 'goi ca duoi', '', '', '', '', 2, 0, '', 0, 0, 1, 300000, '2024-07-09 07:18:43', '2024-07-09 10:43:52'),
(15, 'Goi ca loc', '', '', '', '', 3, 0, '', 0, 0, 1, 400000, '2024-07-09 07:21:30', '2024-07-09 10:43:24'),
(16, 'Lau thap cam', '/foods/pexels-ella-olsson-572949-1640772.jpg', '', '', '', 4, 0, '', 0, 0, 1, 150000, '2024-07-09 07:23:06', '2024-07-09 09:43:18'),
(17, 'Goi cua', '/foods/pexels-ella-olsson-572949-1640772.jpg', '', '', '', 1, 0, '', 20, 1, 1, 600000, '2024-07-09 07:54:09', '2024-07-09 09:42:56'),
(18, 'combo oc', '/foods/istockphoto-1316145932-612x612.jpg', '', '', '', 1, 0, '', 20, 1, 1, 600000, '2024-07-09 08:46:20', '2024-07-09 09:42:53'),
(19, 'Oc buu vang', '/foods/istockphoto-1316145932-612x612.jpg', '', '', '', 3, 0, '', 20, 1, 1, 30000, '2024-07-09 09:06:47', '2024-07-09 09:42:50'),
(20, 'goi mang cut', '/foods/pexels-ella-olsson-572949-1640772.jpg', '', '', '', 4, 0, '', 10, 1, 1, 200000, '2024-07-09 09:08:43', '2024-07-09 09:42:46'),
(21, 'Lau oc ', '/foods/pexels-ella-olsson-572949-1640772.jpg', '/foods/istockphoto-1316145932-612x612.jpg', '/foods/pexels-ella-olsson-572949-1640772.jpg', '/foods/360_F_252388016_KjPnB9vglSCuUJAumCDNbmMzGdzPAucK.jpg', 4, 0, '', 5, 1, 1, 20000000, '2024-07-09 09:17:24', '2024-07-09 09:42:24'),
(22, 'Ga luoc', '/foods/istockphoto-1316145932-612x612.jpg', '', '', '', 2, 0, '', 2, 1, 1, 500000, '2024-07-09 09:23:04', NULL),
(23, 'Mam ngu qua', '/foods/360_F_252388016_KjPnB9vglSCuUJAumCDNbmMzGdzPAucK.jpg', '', '', '', 4, 0, '', 3, 1, 1, 900000, '2024-07-09 09:49:04', '2024-07-09 10:44:15');

-- --------------------------------------------------------

--
-- Table structure for table `order`
--

CREATE TABLE `order` (
  `id` bigint(20) NOT NULL,
  `status` enum('new','processing','completed') DEFAULT 'new',
  `total_price` float NOT NULL,
  `table_id` bigint(20) NOT NULL,
  `payed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order`
--

INSERT INTO `order` (`id`, `status`, `total_price`, `table_id`, `payed_at`, `created_at`, `updated_at`) VALUES
(15, 'completed', 166611, 1, NULL, '2024-02-24 08:55:58', '2024-06-27 10:00:24'),
(16, 'new', 540333, 2, NULL, '2024-02-11 09:07:19', '2024-06-27 09:58:50'),
(17, 'new', 611055, 1, NULL, '2024-03-31 09:18:45', '2024-06-27 09:58:55'),
(18, 'new', 1151610, 1, NULL, '2024-04-25 09:44:23', '2024-06-27 09:59:02'),
(19, 'new', 55500, 1, NULL, '2024-05-25 10:40:41', '2024-06-27 09:59:10'),
(20, 'new', 55500, 2, NULL, '2024-06-25 10:50:56', '2024-06-25 10:50:57'),
(21, 'new', 555000, 1, NULL, '2024-06-25 10:51:37', '2024-06-27 10:00:05'),
(22, 'new', 15000, 1, NULL, '2024-06-25 10:55:34', '2024-06-27 10:00:01'),
(23, 'new', 15000, 1, NULL, '2024-06-25 10:56:43', '2024-06-25 10:56:43'),
(24, 'new', 40500, 1, NULL, '2024-06-25 10:58:01', '2024-06-25 10:58:01'),
(25, 'new', 258000, 1, NULL, '2024-06-26 03:08:06', '2024-06-26 03:08:06'),
(26, 'new', 40500, 1, NULL, '2025-06-26 03:09:16', '2024-06-27 08:53:16'),
(27, 'new', 40500, 1, NULL, '2024-06-26 03:10:17', '2024-06-26 03:10:17'),
(28, 'new', 40500, 1, NULL, '2024-06-26 03:11:38', '2024-06-26 03:11:38'),
(29, 'new', 15000, 1, NULL, '2024-06-26 03:14:39', '2024-06-26 03:14:39'),
(30, 'new', 15000, 1, NULL, '2024-06-26 03:15:47', '2024-06-26 03:15:47'),
(31, 'new', 40500, 1, NULL, '2024-06-27 03:19:07', '2024-06-27 09:20:29'),
(32, 'new', 15000, 1, NULL, '2024-06-26 03:20:27', '2024-06-26 03:20:27'),
(33, 'new', 15000, 1, NULL, '2024-06-26 03:24:01', '2024-06-26 03:24:01'),
(34, 'new', 15000, 1, NULL, '2022-06-26 03:25:41', '2024-06-27 08:53:27'),
(35, 'new', 15000, 1, NULL, '2024-06-26 03:27:20', '2024-06-26 03:27:20'),
(36, 'new', 15000, 1, NULL, '2024-06-26 03:31:04', '2024-06-26 03:31:04'),
(37, 'new', 15000, 1, NULL, '2024-06-26 03:37:05', '2024-06-26 03:37:05'),
(38, 'new', 15000, 1, '2024-06-27 10:30:29', '2024-06-26 08:42:34', '2024-06-27 10:32:07'),
(39, 'completed', 40500, 1, '2024-06-27 10:07:13', '2024-06-27 08:43:33', '2024-06-27 10:07:16'),
(40, 'new', 15000, 1, NULL, '2024-06-26 08:45:19', '2024-06-26 08:45:20'),
(41, 'new', 15000, 1, NULL, '2024-06-26 08:46:34', '2024-06-26 08:46:34'),
(42, 'new', 15000, 1, NULL, '2024-06-26 08:47:27', '2024-06-26 08:47:27'),
(43, 'new', 15000, 2, NULL, '2024-06-26 08:47:46', '2024-06-26 08:47:46'),
(44, 'new', 15000, 1, NULL, '2024-06-26 08:48:46', '2024-06-26 08:48:46'),
(45, 'new', 40500, 1, NULL, '2024-06-26 08:51:33', '2024-06-26 08:51:33'),
(46, 'new', 40500, 1, NULL, '2024-06-26 09:00:22', '2024-06-26 09:00:22'),
(47, 'new', 40500, 2, NULL, '2024-06-26 09:51:56', '2024-06-26 09:51:56'),
(48, 'new', 15000, 2, NULL, '2024-06-26 09:52:12', '2024-06-26 09:52:12');

-- --------------------------------------------------------

--
-- Table structure for table `order_detail`
--

CREATE TABLE `order_detail` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `food_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` float NOT NULL,
  `total_amount` float NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_detail`
--

INSERT INTO `order_detail` (`id`, `order_id`, `food_id`, `quantity`, `price`, `total_amount`, `created_at`, `updated_at`, `note`) VALUES
(27, 15, 2, 1, 45000, 40500, '2024-06-24 08:55:58', '2024-06-24 08:55:58', ''),
(28, 15, 1, 1, 111111, 111111, '2024-06-24 08:55:58', '2024-06-24 08:55:58', ''),
(30, 16, 2, 4, 45000, 162000, '2024-06-24 09:07:19', '2024-06-24 09:07:19', ''),
(31, 16, 1, 3, 111111, 333333, '2024-06-24 09:07:19', '2024-06-24 09:07:19', ''),
(32, 16, 3, 3, 15000, 45000, '2024-06-24 09:07:19', '2024-06-24 09:07:19', ''),
(33, 17, 2, 1, 45000, 40500, '2024-06-24 09:18:45', '2024-06-24 09:18:45', ''),
(34, 17, 1, 5, 111111, 555555, '2024-06-24 09:18:45', '2024-06-24 09:18:45', ''),
(35, 17, 3, 1, 15000, 15000, '2024-06-24 09:18:45', '2024-06-24 09:18:45', ''),
(36, 18, 2, 1, 45000, 40500, '2024-06-25 09:44:23', '2024-06-25 09:44:23', NULL),
(37, 18, 1, 10, 111111, 1111110, '2024-06-25 09:44:23', '2024-06-25 09:44:23', NULL),
(38, 19, 3, 1, 15000, 15000, '2024-06-25 10:40:41', '2024-06-25 10:40:41', NULL),
(39, 19, 2, 1, 45000, 40500, '2024-06-25 10:40:41', '2024-06-25 10:40:41', NULL),
(40, 20, 3, 1, 15000, 15000, '2024-06-25 10:50:57', '2024-06-25 10:50:57', NULL),
(41, 20, 2, 1, 45000, 40500, '2024-06-25 10:50:57', '2024-06-25 10:50:57', NULL),
(42, 21, 3, 10, 15000, 150000, '2024-06-25 10:51:37', '2024-06-25 10:51:37', NULL),
(43, 21, 2, 10, 45000, 405000, '2024-06-25 10:51:37', '2024-06-25 10:51:37', NULL),
(44, 22, 3, 1, 15000, 15000, '2024-06-25 10:55:34', '2024-06-25 10:55:34', NULL),
(45, 23, 3, 1, 15000, 15000, '2024-06-25 10:56:43', '2024-06-25 10:56:43', NULL),
(46, 24, 2, 1, 45000, 40500, '2024-06-25 10:58:01', '2024-06-25 10:58:01', NULL),
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

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` tinytext NOT NULL,
  `tokenable_id` bigint(20) NOT NULL,
  `token` varchar(255) NOT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `personal_access_tokens`
--

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
(157, 'default', 1, '765402c4edc7a696d5dfc6bf898cee46', NULL, '2024-07-03 09:06:37', NULL),
(158, 'default', 1, 'c023557bf39039a74b9cee1652f1e199', NULL, '2024-07-08 11:07:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `table`
--

CREATE TABLE `table` (
  `id` bigint(20) NOT NULL,
  `name` text NOT NULL,
  `seats` int(11) NOT NULL,
  `is_use` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `table`
--

INSERT INTO `table` (`id`, `name`, `seats`, `is_use`) VALUES
(1, 'Bàn 1', 2, 1),
(2, 'Bàn 2', 3, 1),
(3, 'Bàn 10 trên sân thượng', 2, 0),
(4, 'Bàn trong nhà vệ sinh', 2, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `phone_number` int(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `full_name`, `phone_number`, `password`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Nguyen Tien Anh', 328023993, 'oqsmnvQ6j6+Wu7ja4LeuTearsSC0Y7u/BVV6YyFsMw1fGUIjqi8lz0KRJbFyCElCVaSId/+PO66EXz1K8CpbbU1y0w==', '/users/1/E:imagecom-ga-xoi-mo.jpg', '2024-06-14 07:21:57', '2024-06-22 05:26:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banner`
--
ALTER TABLE `banner`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `FK_food_category` (`category_id`);

--
-- Indexes for table `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_order_table` (`table_id`),
  ADD KEY `status` (`status`,`created_at`) USING BTREE;

--
-- Indexes for table `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `food_id` (`food_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `token` (`token`);

--
-- Indexes for table `table`
--
ALTER TABLE `table`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banner`
--
ALTER TABLE `banner`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `order`
--
ALTER TABLE `order`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=159;

--
-- AUTO_INCREMENT for table `table`
--
ALTER TABLE `table`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
