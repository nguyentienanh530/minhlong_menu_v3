-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 22, 2024 at 08:25 AM
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
-- Table structure for table `banners`
--

CREATE TABLE `banners` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `image` varchar(255) NOT NULL,
  `show` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `banners`
--

INSERT INTO `banners` (`id`, `user_id`, `image`, `show`, `created_at`, `updated_at`) VALUES
(10, 1, '/banners/1/1721315983555.webp', 1, '2024-07-17 02:54:05', '2024-07-19 02:36:09'),
(11, 1, '/banners/1/1721316009109.webp', 1, '2024-07-17 02:54:11', '2024-07-19 02:36:22'),
(12, 1, '/banners/1/1721316014278.webp', 1, '2024-07-17 03:01:29', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `serial` int(10) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `user_id`, `name`, `image`, `serial`, `created_at`, `updated_at`) VALUES
(6, 1, 'Nước uống - Nước uống', '/categories/1/coffe.png', 1, '2024-07-17 03:38:05', '2024-07-18 11:26:17'),
(7, 1, 'Shushi', '/categories/1/sushi.png', 2, '2024-07-17 03:38:49', NULL),
(8, 1, 'Ăn vặt', '/categories/1/taco.png', 3, '2024-07-17 03:39:13', NULL),
(9, 1, 'Cơm chiên', '/categories/1/rice.png', 4, '2024-07-17 03:39:38', NULL),
(11, 1, 'Gà', '/categories/1/chicken.png', 5, '2024-07-17 03:42:51', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `foods`
--

CREATE TABLE `foods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
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
-- Dumping data for table `foods`
--

INSERT INTO `foods` (`id`, `user_id`, `name`, `image1`, `image2`, `image3`, `image4`, `category_id`, `order_count`, `description`, `discount`, `is_discount`, `is_show`, `price`, `created_at`, `updated_at`) VALUES
(25, 1, 'an nhanh', '/foods/1/Breakfast-board28-500x500.jpg', '', '', '', 8, 14, 'Food is any substance consumed by an organism for nutritional support. Food is usually of plant, animal, or fungal origin and contains essential nutrients such as carbohydrates, fats, proteins, vitamins, or minerals. The substance is ingested by an organism and assimilated by the organism\'s cells to provide energy, maintain life, or stimulate growth. Different species of animals have different feeding behaviours that satisfy the needs of their metabolisms and have evolved to fill a specific ecological niche within specific geographical contexts.\n\nOmnivorous humans are highly adaptable and have adapted to obtain food in many different ecosystems. Humans generally use cooking to prepare food for consumption. The majority of the food energy required is supplied by the industrial food industry, which produces food through intensive agriculture and distributes it through complex food processing and food distribution systems. This system of conventional agriculture relies heavily on fossil fuels, which means that the food and agricultural systems are one of the major contributors to climate change, accounting for as much as 37% of total greenhouse gas emissions.[1]\n\nThe food system has significant impacts on a wide range of other social and political issues, including sustainability, biological diversity, economics, population growth, water supply, and food security. Food safety and security are monitored by international agencies like the International Association for Food Protection, the World Resources Institute, the World Food Programme, the Food and Agriculture Organization, and the International Food Information Council.', 1, 1, 1, 21000, '2024-07-17 05:37:55', '2024-07-20 11:06:35'),
(26, 1, 'com', '/foods/1/party-food-500x500.jpg', '', '', '', 9, 18, '', 5, 1, 1, 30000, '2024-07-17 05:38:48', '2024-07-20 11:06:35'),
(27, 1, 'asdasd', '/foods/1/dinner-ideas-2-500x500.jpg', '', '', '', 7, 13, 'Every time that I want to refactor a name of a class in my code I need to change the class name and also change the file name. I think this is a waste of time to change the name of the same thing twice, this is an another step to make refactor harder. For example, I have a class that have the name of NodeKey and I want to change the class name to FileKey I need to change the class name and the file name from node_key.dart to file_key.dart.\n\nI thing that this process need to be automated and it will same time for many users and make refactoring easier. On Change Symble that change class name the extension will check if the file name have the same name as the changed class name (taking into consideration the name conventions of UpperCamelCase for class names and lowercase_with_underscores for file names) and if they have the same name change also the file name to the new name (with the name conventions).\n\nAlternative solutions are: use existing extensions that does it, if you know any, or this is already possible in this extension and I don\'t know about it or make a new extension that does it.\n\nI will be happy to implement this if it is possible :) If possible you know any file/files you think that I need to change to make this feature?', 0, 0, 1, 25000, '2024-07-17 05:55:50', '2024-07-20 11:06:35');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `status` enum('new','processing','completed','cancel') DEFAULT 'new',
  `total_price` float DEFAULT NULL,
  `table_id` bigint(20) NOT NULL,
  `payed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `status`, `total_price`, `table_id`, `payed_at`, `created_at`, `updated_at`) VALUES
(52, 1, 'cancel', 28500, 5, NULL, '2024-07-20 02:47:04', '2024-07-20 08:51:17'),
(53, 1, 'cancel', 85500, 5, NULL, '2024-07-20 02:47:04', '2024-07-20 08:51:55'),
(54, 1, 'completed', 57000, 7, '2024-07-22 06:14:28', '2024-07-20 02:47:04', '2024-07-22 06:14:28'),
(55, 1, 'completed', 57000, 7, '2024-07-24 06:14:31', '2024-07-20 02:47:04', '2024-07-22 06:15:02'),
(56, 1, 'completed', 57000, 5, '2024-07-22 06:14:33', '2024-07-20 02:47:04', '2024-07-22 06:14:33'),
(57, 1, 'completed', 74290, 5, '2024-07-23 03:37:35', '2024-07-20 02:47:04', '2024-07-22 03:37:48'),
(59, 1, 'cancel', 74290, 6, NULL, '2024-07-20 02:47:04', '2024-07-20 08:02:30'),
(60, 1, 'cancel', 74290, 6, NULL, '2024-07-20 02:48:28', '2024-07-20 08:05:34'),
(62, 1, 'completed', 74290, 7, '2024-07-25 02:50:44', '2024-07-20 06:25:34', '2024-07-22 06:15:10'),
(63, 1, 'completed', 74290, 6, '2024-07-22 02:50:46', '2024-07-20 06:25:55', '2024-07-22 02:50:46'),
(64, 1, 'completed', 74290, 5, '2024-07-27 06:14:19', '2024-07-20 08:55:27', '2024-07-22 06:15:16'),
(65, 1, 'completed', 74290, 7, '2024-07-28 06:14:26', '2024-07-20 08:55:51', '2024-07-22 06:15:20'),
(66, 1, 'processing', 25000, 6, NULL, '2024-07-20 08:56:03', '2024-07-20 11:07:24'),
(67, 1, 'new', 53500, 5, NULL, '2024-07-20 11:03:35', '2024-07-20 11:03:35'),
(68, 1, 'new', 74290, 7, NULL, '2024-07-20 11:06:06', '2024-07-20 11:06:06'),
(69, 1, 'new', 28500, 5, NULL, '2024-07-20 11:06:19', '2024-07-20 11:06:19'),
(70, 1, 'new', 74290, 7, NULL, '2024-07-20 11:06:35', '2024-07-20 11:06:35');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` bigint(20) NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `food_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` float NOT NULL,
  `total_amount` float NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `note` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `food_id`, `quantity`, `price`, `total_amount`, `created_at`, `updated_at`, `note`) VALUES
(75, 52, 26, 1, 30000, 28500, '2024-07-18 11:13:47', NULL, ''),
(76, 53, 26, 3, 30000, 85500, '2024-07-18 11:16:30', NULL, ''),
(77, 54, 26, 2, 30000, 57000, '2024-07-18 11:18:06', NULL, ''),
(78, 55, 26, 2, 30000, 57000, '2024-07-18 11:18:48', NULL, ''),
(79, 56, 26, 2, 30000, 57000, '2024-07-18 11:33:59', NULL, ''),
(80, 57, 27, 1, 25000, 25000, '2024-07-19 09:39:33', NULL, ''),
(81, 57, 26, 1, 30000, 28500, '2024-07-19 09:39:33', NULL, ''),
(82, 57, 25, 1, 21000, 20790, '2024-07-19 09:39:33', NULL, ''),
(86, 59, 27, 1, 25000, 25000, '2024-07-20 02:44:13', NULL, ''),
(87, 59, 26, 1, 30000, 28500, '2024-07-20 02:44:13', NULL, ''),
(88, 59, 25, 1, 21000, 20790, '2024-07-20 02:44:13', NULL, ''),
(89, 60, 27, 1, 25000, 25000, '2024-07-20 02:48:28', NULL, ''),
(90, 60, 26, 1, 30000, 28500, '2024-07-20 02:48:28', NULL, ''),
(91, 60, 25, 1, 21000, 20790, '2024-07-20 02:48:28', NULL, ''),
(95, 62, 27, 1, 25000, 25000, '2024-07-20 06:25:34', NULL, ''),
(96, 62, 26, 1, 30000, 28500, '2024-07-20 06:25:34', NULL, ''),
(97, 62, 25, 1, 21000, 20790, '2024-07-20 06:25:34', NULL, ''),
(98, 63, 27, 1, 25000, 25000, '2024-07-20 06:25:55', NULL, ''),
(99, 63, 26, 1, 30000, 28500, '2024-07-20 06:25:55', NULL, ''),
(100, 63, 25, 1, 21000, 20790, '2024-07-20 06:25:55', NULL, ''),
(101, 64, 26, 1, 30000, 28500, '2024-07-20 08:55:27', NULL, ''),
(102, 64, 25, 1, 21000, 20790, '2024-07-20 08:55:27', NULL, ''),
(103, 64, 27, 1, 25000, 25000, '2024-07-20 08:55:27', NULL, ''),
(104, 65, 27, 1, 25000, 25000, '2024-07-20 08:55:51', NULL, ''),
(105, 65, 26, 1, 30000, 28500, '2024-07-20 08:55:51', NULL, ''),
(106, 65, 25, 1, 21000, 20790, '2024-07-20 08:55:51', NULL, ''),
(107, 66, 27, 1, 25000, 25000, '2024-07-20 08:56:03', NULL, ''),
(108, 67, 26, 1, 30000, 28500, '2024-07-20 11:03:35', NULL, ''),
(109, 67, 27, 1, 25000, 25000, '2024-07-20 11:03:35', NULL, ''),
(110, 68, 27, 1, 25000, 25000, '2024-07-20 11:06:06', NULL, ''),
(111, 68, 26, 1, 30000, 28500, '2024-07-20 11:06:06', NULL, ''),
(112, 68, 25, 1, 21000, 20790, '2024-07-20 11:06:06', NULL, ''),
(113, 69, 26, 1, 30000, 28500, '2024-07-20 11:06:19', NULL, ''),
(114, 70, 25, 1, 21000, 20790, '2024-07-20 11:06:35', NULL, ''),
(115, 70, 26, 1, 30000, 28500, '2024-07-20 11:06:35', NULL, ''),
(116, 70, 27, 1, 25000, 25000, '2024-07-20 11:06:35', NULL, '');

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
(161, 'default', 1, '306fb750759458309bb809f80695359d', '2024-07-16 03:50:20', '2024-07-16 02:51:56', NULL),
(162, 'default', 1, 'e0e2b53991a87e9527d857219d4cc3a8', '2024-07-16 03:57:05', '2024-07-16 03:57:05', '2024-07-16 04:03:11'),
(163, 'default', 1, '157b4a30e47363a6779bba6d560f898b', '2024-07-16 04:04:04', '2024-07-16 04:03:20', NULL),
(164, 'default', 1, '2114acdd6bd9c6808b3d9d878864ce1a', NULL, '2024-07-16 06:58:16', NULL),
(165, 'default', 1, '679cc83d746a62c52a32432d205c99ee', NULL, '2024-07-16 07:04:22', NULL),
(166, 'default', 1, '644483ed18f351c5e0e33e482586834d', NULL, '2024-07-16 07:05:51', NULL),
(167, 'default', 1, '317ba6f6c45c37023484f3b8e907adca', NULL, '2024-07-16 07:14:30', NULL),
(168, 'default', 1, 'a4ed794f9404e637b7cd8065b746adf6', '2024-07-16 08:19:29', '2024-07-16 08:19:28', NULL),
(169, 'default', 1, '0f374045cde108ca33050096cff0565d', '2024-07-16 08:26:05', '2024-07-16 08:26:04', NULL),
(170, 'default', 1, '34b52d2049c01f8034fa2f2738e62da7', '2024-07-16 08:27:56', '2024-07-16 08:27:56', NULL),
(171, 'default', 1, '0a1d43804e5f12ff3d85719dfa0d83ed', '2024-07-16 08:30:35', '2024-07-16 08:29:39', '2024-07-16 08:31:01'),
(172, 'default', 1, '22b37c9fb239d25d4de32beeb2f0944e', '2024-07-16 08:31:50', '2024-07-16 08:31:50', '2024-07-16 08:31:57'),
(173, 'default', 1, 'f5911ecd0477cc69a33a497649eb73e8', '2024-07-16 08:40:59', '2024-07-16 08:40:59', '2024-07-16 08:41:05'),
(174, 'default', 1, '3b63e29d4197e7b404d677955227d178', '2024-07-16 08:41:15', '2024-07-16 08:41:12', NULL),
(175, 'default', 1, 'eef863cdd6834ca3780df580991ff74f', '2024-07-16 08:43:04', '2024-07-16 08:43:04', NULL),
(176, 'default', 1, '08b1f0761fa4bea5e23c07de7bc754ab', '2024-07-16 08:47:20', '2024-07-16 08:46:54', NULL),
(178, 'default', 1, '1958d0b9f31d41524a88042fe40e79cc', '2024-07-16 08:49:02', '2024-07-16 08:49:02', NULL),
(180, 'default', 1, '19737ba5c18f3115338dff26bc1e67f8', '2024-07-16 08:50:43', '2024-07-16 08:50:43', NULL),
(182, 'default', 1, 'cfcaa58717afc3be32ad9dd3dce45e55', '2024-07-16 09:14:40', '2024-07-16 09:14:40', NULL),
(184, 'default', 1, '5ea3270b3cdb091b24614e27b61b6948', '2024-07-16 09:16:53', '2024-07-16 09:16:53', NULL),
(186, 'default', 1, '9bbbf19d9f19358e3c04c4a77e8bc5c9', '2024-07-16 09:18:46', '2024-07-16 09:18:01', NULL),
(188, 'default', 1, '6016bf0194347f18e1ab4a2c1000aa37', '2024-07-16 09:19:09', '2024-07-16 09:19:09', NULL),
(190, 'default', 1, '809cf918896b3641e29c7aad3b875551', '2024-07-16 09:32:47', '2024-07-16 09:32:47', NULL),
(192, 'default', 1, '23c16b19fbb7f92528aa61ab6c0d0bd1', NULL, '2024-07-16 09:35:27', NULL),
(193, 'default', 1, 'b841a6a6dcbe3f18a51d03f74e98c2ce', '2024-07-16 09:36:47', '2024-07-16 09:36:06', '2024-07-16 09:36:52'),
(195, 'default', 1, 'f85a0f9eefd6353a62ba8541c7c348f8', '2024-07-16 09:37:47', '2024-07-16 09:36:59', NULL),
(196, 'default', 1, '168aeeebbd2d8617d6235c3b0cd06311', '2024-07-16 09:42:28', '2024-07-16 09:41:39', NULL),
(198, 'default', 1, '263901718240d60ceef247c2037d24a0', '2024-07-16 10:35:07', '2024-07-16 10:35:07', NULL),
(200, 'default', 1, '7c714ba5922c90d1f7cfffa8b3741894', '2024-07-16 10:36:16', '2024-07-16 10:35:28', NULL),
(201, 'default', 1, 'b473f46bf945910cd39dee5449dfeca6', '2024-07-16 10:36:42', '2024-07-16 10:36:42', NULL),
(203, 'default', 1, '976964d9acf3c297a505faa0d4748279', '2024-07-16 10:39:44', '2024-07-16 10:38:51', NULL),
(204, 'default', 1, '7aece902ebd1a0eb315fed08d0c9e088', '2024-07-16 10:41:43', '2024-07-16 10:41:43', NULL),
(206, 'default', 1, 'ad4cf8893e897871ff9826f55747151c', '2024-07-16 10:43:10', '2024-07-16 10:42:24', NULL),
(207, 'default', 1, '0cb59d6297ecd678de4daa265138916d', '2024-07-16 10:44:28', '2024-07-16 10:44:28', NULL),
(209, 'default', 1, '81e832068bba72656f1a720caf1d1354', '2024-07-16 10:45:23', '2024-07-16 10:45:23', NULL),
(210, 'default', 1, 'd0abc2fc19b9479b8caebc6fe491f795', '2024-07-16 10:47:33', '2024-07-16 10:47:33', NULL),
(212, 'default', 1, 'ff64d1fdd11eab29b03754a5bddf0667', '2024-07-16 10:50:58', '2024-07-16 10:50:57', NULL),
(213, 'default', 1, 'e3b16e2c08f496d04e1738e58a6b785c', '2024-07-16 10:52:16', '2024-07-16 10:52:16', NULL),
(215, 'default', 1, 'a0c39299dd73cb411e8430dcd89f1f7b', '2024-07-16 10:55:59', '2024-07-16 10:55:59', NULL),
(216, 'default', 1, 'e745aea0914a8f2619feafff31378885', '2024-07-16 11:00:04', '2024-07-16 11:00:04', NULL),
(218, 'default', 1, '8f660b1f33c0b24cc2c88ab86c742659', '2024-07-16 11:01:48', '2024-07-16 11:01:11', NULL),
(220, 'default', 1, '05c602c81f9fb4d494c71dd4fe917896', '2024-07-16 11:04:12', '2024-07-16 11:04:12', NULL),
(222, 'default', 1, 'a34abd2fbfff62d11186dd740d709bf2', '2024-07-16 11:08:09', '2024-07-16 11:07:49', NULL),
(224, 'default', 1, 'f37787ad1ff9da7f7f120c4ae535e107', '2024-07-16 11:09:40', '2024-07-16 11:09:40', NULL),
(225, 'default', 1, '82fcc7b6debc73711441e07c1172fcb1', '2024-07-16 11:10:12', '2024-07-16 11:09:40', NULL),
(226, 'default', 1, '5fd9c2de439957fc4399752530560ebf', '2024-07-16 11:11:21', '2024-07-16 11:11:21', NULL),
(228, 'default', 1, 'd3d42d49ec8bcb3a455809418ffffbe4', '2024-07-16 11:17:56', '2024-07-16 11:17:41', NULL),
(230, 'default', 1, '4b5c79123b9a76bceae01bdfb2fbee7a', NULL, '2024-07-16 11:23:41', NULL),
(231, 'default', 1, '587177ed2fd22dca9388d6d622c03a3d', '2024-07-16 11:27:11', '2024-07-16 11:27:11', NULL),
(232, 'default', 1, '31c116ad3733e97798a02abc8821278d', '2024-07-17 02:37:02', '2024-07-17 02:36:33', NULL),
(233, 'default', 1, '1fc1f0be88f0d24593ee52efd600649c', '2024-07-17 02:40:18', '2024-07-17 02:39:20', NULL),
(234, 'default', 1, '2de24de77ea0b2d0983f79c6e00885c3', '2024-07-17 02:40:58', '2024-07-17 02:40:26', NULL),
(235, 'default', 1, 'ab81e0bc0cfcba13640a42ed44241102', '2024-07-17 02:44:44', '2024-07-17 02:44:33', NULL),
(236, 'default', 1, '6db4cf2769aa699650eab0609b74da06', '2024-07-17 02:50:59', '2024-07-17 02:50:44', NULL),
(237, 'default', 1, '28ff22dd17cd5d745d48a145ad6a5f07', '2024-07-17 02:54:11', '2024-07-17 02:53:46', NULL),
(238, 'default', 1, 'a8fa9a1e3089cb9e2eac884e31cea8d3', '2024-07-17 02:59:22', '2024-07-17 02:58:52', NULL),
(239, 'default', 1, '845dfe67a929b63de511a6e966b49c53', '2024-07-17 03:01:21', '2024-07-17 03:00:28', NULL),
(240, 'default', 1, '9c4013f0b79199c56d80235e90d24daf', '2024-07-17 03:01:29', '2024-07-17 03:01:29', NULL),
(241, 'default', 1, 'af1a5d0634e785475ba9b21391dfe167', '2024-07-17 03:12:17', '2024-07-17 03:12:04', NULL),
(242, 'default', 1, '666ff85984d2677966b5ab204215f0cb', '2024-07-17 03:13:58', '2024-07-17 03:13:34', NULL),
(243, 'default', 1, 'faeb3e98bcbad0d86122280610ae61c6', '2024-07-17 03:15:46', '2024-07-17 03:14:56', NULL),
(247, 'default', 1, '4506678757d7bd7f59d2495a77dc7bff', '2024-07-17 03:16:49', '2024-07-17 03:16:41', NULL),
(248, 'default', 1, '4af3326f4977053b87a66e69c4cc6d28', '2024-07-17 03:18:21', '2024-07-17 03:18:18', NULL),
(249, 'default', 1, '93299f1ec7ec8fefd969e9f38e49e7c2', '2024-07-17 03:21:10', '2024-07-17 03:21:05', NULL),
(250, 'default', 1, '9df4da569a34e9fbfb2bd7bd2774828f', '2024-07-17 03:23:12', '2024-07-17 03:23:08', NULL),
(251, 'default', 1, '01aa275f7e90b36e28e369055f8435b8', '2024-07-17 03:24:41', '2024-07-17 03:24:30', NULL),
(252, 'default', 1, '28819fe142c41fa00358ed8db2e71623', '2024-07-17 03:27:03', '2024-07-17 03:26:51', NULL),
(253, 'default', 1, '8c9c2e18900ac7898fbb69fbd8541e35', '2024-07-17 03:33:55', '2024-07-17 03:33:53', NULL),
(254, 'default', 1, '82d5228b218232c3d81cb50cb5cee9d6', '2024-07-17 03:37:10', '2024-07-17 03:36:54', NULL),
(255, 'default', 1, 'ee219725f2a21eadcad6749095e30713', '2024-07-17 03:38:49', '2024-07-17 03:38:05', NULL),
(256, 'default', 1, '55a6e5d8d5389174ada5296e9f3c3e57', '2024-07-17 03:40:06', '2024-07-17 03:39:13', NULL),
(257, 'default', 1, '780f1866398b8044bf7f24949b74cf38', '2024-07-17 03:42:51', '2024-07-17 03:42:13', NULL),
(258, 'default', 1, '96fee5ceb7071439b93464e3c3b4cb4b', '2024-07-17 03:48:02', '2024-07-17 03:47:59', NULL),
(259, 'default', 1, 'c63569f745863375c768b5c0c85b0d0b', '2024-07-17 04:06:17', '2024-07-17 03:57:12', NULL),
(260, 'default', 1, 'ae94f038450b341ad9b3864a122c9024', '2024-07-17 04:07:34', '2024-07-17 04:07:33', NULL),
(261, 'default', 1, '03e27dd68bfde28ccba6455ff8170399', '2024-07-17 05:50:19', '2024-07-17 04:07:45', NULL),
(262, 'default', 1, '5283aa7cb5ed865be3edb740beedc298', '2024-07-17 04:14:11', '2024-07-17 04:14:11', NULL),
(263, 'default', 1, 'e68218a2c044db10bc5228461390ce9f', '2024-07-17 05:55:35', '2024-07-17 04:14:11', '2024-07-17 05:55:57'),
(264, 'default', 1, 'b324f2037ce19e60c7c708fd0a085a4e', '2024-07-17 04:55:48', '2024-07-17 04:55:47', NULL),
(265, 'default', 1, '3ed79311ffa0e69dedeb92c70c974964', '2024-07-17 05:35:29', '2024-07-17 04:56:23', NULL),
(266, 'default', 1, 'df3aa7f292c3b7afdbba68077e450f18', '2024-07-17 05:36:09', '2024-07-17 05:36:06', NULL),
(267, 'default', 1, '5f8187b6cd5f172a3cb1898b2eb49c43', '2024-07-17 06:08:41', '2024-07-17 05:36:18', '2024-07-17 06:09:15'),
(268, 'default', 1, '11776064ebc72d2e8878f23632690690', '2024-07-17 06:13:29', '2024-07-17 05:51:28', NULL),
(269, 'default', 1, '52fdd72b5676724844efd1bd1a406899', '2024-07-17 06:03:18', '2024-07-17 05:55:59', NULL),
(270, 'default', 5, '13c0171660f09479b87211f0f3b748fe', '2024-07-17 06:12:21', '2024-07-17 06:12:15', '2024-07-17 06:12:26'),
(271, 'default', 1, '2e290059302a30fce5488f5557fd99a3', '2024-07-18 02:38:53', '2024-07-17 06:12:27', '2024-07-18 02:38:58'),
(272, 'default', 1, '535eeb9aad6c728cc402409b7e913efc', '2024-07-18 04:44:25', '2024-07-17 06:13:37', NULL),
(273, 'default', 1, '38a284934713826a25e4b8aac5581f8b', '2024-07-18 04:26:11', '2024-07-17 06:20:04', NULL),
(277, 'default', 1, '1ca56f2da94b6b9673a82301d2430f94', '2024-07-18 02:39:04', '2024-07-18 02:39:04', '2024-07-18 02:39:08'),
(278, 'default', 1, 'fc9eaba0b5c53a5c2ff7ad6f9beff67b', '2024-07-18 03:42:35', '2024-07-18 02:46:37', NULL),
(279, 'default', 1, '64e3a35b0bb13f269696d8c70dfb39e3', '2024-07-18 03:43:23', '2024-07-18 03:42:35', NULL),
(280, 'default', 1, 'a20a2b30d72a0cc1becabf6355cba042', '2024-07-18 03:44:12', '2024-07-18 03:43:23', '2024-07-18 03:44:16'),
(281, 'default', 1, 'd198732ad8b6ac2f58b1ca9f17678970', '2024-07-18 03:44:37', '2024-07-18 03:44:19', NULL),
(282, 'default', 1, '48bf5560d4cf3d358ff9008c58e89764', '2024-07-18 03:45:59', '2024-07-18 03:44:37', NULL),
(283, 'default', 1, 'eb24a73d7be1dab32a918a54a4d48625', '2024-07-18 04:34:15', '2024-07-18 03:45:59', '2024-07-18 04:34:18'),
(284, 'default', 1, 'fef42ee4dce10899de8b133ab4710ff6', NULL, '2024-07-18 04:27:40', NULL),
(285, 'default', 1, '688029dab85f3516a1e82b182435510a', '2024-07-18 04:29:47', '2024-07-18 04:29:47', NULL),
(286, 'default', 1, '80140c1c88a7a7c4fd330265fa1f07d5', '2024-07-18 04:32:03', '2024-07-18 04:30:01', NULL),
(287, 'default', 1, '7687cb14cd344df4dd3bbd6d72fd2fe1', '2024-07-18 04:32:17', '2024-07-18 04:32:16', NULL),
(288, 'default', 1, 'bece593a6197d234fa7c47dc47228381', NULL, '2024-07-18 04:32:29', NULL),
(289, 'default', 1, 'c9abed50c4c04648bbb297dc0e35bb1c', NULL, '2024-07-18 04:48:34', NULL),
(290, 'default', 1, 'e643f96e3771502c272575d90bed209c', NULL, '2024-07-18 04:48:56', NULL),
(291, 'default', 1, '36101d1ad52bc4f92379d587d528d921', '2024-07-18 04:49:09', '2024-07-18 04:49:09', NULL),
(292, 'default', 1, 'acdebf0c5ffff8e3dad8dccaf89415bd', '2024-07-18 11:42:57', '2024-07-18 04:50:40', NULL),
(293, 'default', 1, 'de73fcf2520f30eb7f9754af922b6f7c', '2024-07-20 08:06:51', '2024-07-18 11:19:46', '2024-07-20 08:07:34'),
(294, 'default', 1, '9f4fd48ca0d4c81847203b6f45e815ef', '2024-07-18 11:49:45', '2024-07-18 11:36:58', NULL),
(295, 'default', 5, '31f505415a323231be49474053321603', '2024-07-18 11:46:03', '2024-07-18 11:46:03', NULL),
(296, 'default', 1, 'e0c03bb5e5445f9a3cdae3ec5c86d8d8', '2024-07-22 03:58:23', '2024-07-18 11:46:39', NULL),
(297, 'default', 1, '1b353046ca312dc35d6ed7c490868be1', '2024-07-19 09:18:08', '2024-07-19 09:12:17', NULL),
(298, 'default', 1, '10b4757c2e11fb5b09bab94ea085f1b0', '2024-07-19 09:23:05', '2024-07-19 09:20:33', NULL),
(299, 'default', 1, '6ebcb319240b15fd7354193af0ea9c9a', '2024-07-20 08:58:01', '2024-07-20 08:16:56', '2024-07-20 08:58:21'),
(300, 'default', 1, '96c2625f84379311fd354ff2a5bca577', '2024-07-20 09:04:34', '2024-07-20 09:02:44', '2024-07-20 09:04:43'),
(301, 'default', 1, '5a23a6210d8b07ae91b24017bda654eb', '2024-07-20 09:36:16', '2024-07-20 09:20:03', '2024-07-20 09:36:28'),
(302, 'default', 1, '6f90aa2f06b7f97d2006c0cd404b5072', '2024-07-22 06:17:50', '2024-07-20 09:36:43', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tables`
--

CREATE TABLE `tables` (
  `id` bigint(20) NOT NULL,
  `name` text NOT NULL,
  `seats` int(11) NOT NULL,
  `is_use` tinyint(1) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tables`
--

INSERT INTO `tables` (`id`, `name`, `seats`, `is_use`, `user_id`, `created_at`, `updated_at`) VALUES
(5, 'ban 1', 2, 1, 1, '2024-07-17 04:23:25', '2024-07-18 11:13:47'),
(6, 'ban 2', 2, 1, 1, '2024-07-17 04:23:49', '2024-07-20 02:44:13'),
(7, 'ban 3', 3, 1, 1, '2024-07-17 04:23:56', '2024-07-18 11:18:06');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `phone_number` int(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `phone_number`, `password`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Nguyen Tien Anh', 328023993, 'Io6x4kQrdfsifmhAWqoHDNAmCB0z71LMdlps/wA00AQeeG4mFfs8Ye5ZiN7wQk/3Nu2EAEAUFGTn8LUWZm2Pyz5JRg==', '/users/1/1721380675493.webp', '2024-06-14 07:21:57', '2024-07-20 08:16:41'),
(4, 'Nguyen Tien Anh', 123456789, 'Io6x4kQrdfsifmhAWqoHDNAmCB0z71LMdlps/wA00AQeeG4mFfs8Ye5ZiN7wQk/3Nu2EAEAUFGTn8LUWZm2Pyz5JRg==', NULL, '2024-07-17 06:08:41', '2024-07-20 08:16:41'),
(5, 'Nguyen Tien Anh', 1234567891, 'Io6x4kQrdfsifmhAWqoHDNAmCB0z71LMdlps/wA00AQeeG4mFfs8Ye5ZiN7wQk/3Nu2EAEAUFGTn8LUWZm2Pyz5JRg==', NULL, '2024-07-17 06:11:50', '2024-07-20 08:16:41');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `foods`
--
ALTER TABLE `foods`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `FK_food_category` (`category_id`),
  ADD KEY `fk_users_foods` (`user_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_order_table` (`table_id`),
  ADD KEY `status` (`status`,`created_at`) USING BTREE,
  ADD KEY `fk_users_orders` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
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
-- Indexes for table `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_users_tables` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `banners`
--
ALTER TABLE `banners`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `foods`
--
ALTER TABLE `foods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=303;

--
-- AUTO_INCREMENT for table `tables`
--
ALTER TABLE `tables`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `banners`
--
ALTER TABLE `banners`
  ADD CONSTRAINT `fk_users_banners` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `fk_users_categories` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `foods`
--
ALTER TABLE `foods`
  ADD CONSTRAINT `fk_users_foods` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_users_orders` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `fk_orders_foods` FOREIGN KEY (`food_id`) REFERENCES `foods` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_orders_order_details` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `tables`
--
ALTER TABLE `tables`
  ADD CONSTRAINT `fk_users_tables` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
