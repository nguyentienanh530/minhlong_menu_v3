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
CREATE DATABASE IF NOT EXISTS `menu_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `menu_db`;

-- Dumping structure for table menu_db.banners
DROP TABLE IF EXISTS `banners`;
CREATE TABLE IF NOT EXISTS `banners` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `show` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `fk_users_banners` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.banners: ~5 rows (approximately)
DELETE FROM `banners`;
INSERT INTO `banners` (`id`, `user_id`, `image`, `show`, `created_at`, `updated_at`) VALUES
	(10, 1, '/banners/1/1721315983555.webp', 1, '2024-07-17 02:54:05', '2024-07-23 04:33:54'),
	(11, 1, '/banners/1/1721316009109.webp', 0, '2024-07-17 02:54:11', '2024-07-23 08:39:37'),
	(12, 1, '/banners/1/1721316014278.webp', 1, '2024-07-17 03:01:29', '2024-07-23 04:33:53'),
	(13, 1, '/banners/1/1721706994521.webp', 1, '2024-07-23 03:44:45', '2024-07-23 03:56:34'),
	(14, 1, '/banners/1/1721708023652.webp', 1, '2024-07-23 03:57:11', '2024-07-23 04:30:50');

-- Dumping structure for table menu_db.categories
DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `serial` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `fk_users_categories` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.categories: ~10 rows (approximately)
DELETE FROM `categories`;
INSERT INTO `categories` (`id`, `user_id`, `name`, `image`, `serial`, `created_at`, `updated_at`) VALUES
	(6, 1, 'Nước uống', '/categories/1/coffe.png', 85, '2024-07-17 03:38:05', '2024-07-23 03:27:29'),
	(7, 1, 'Sushi', '/categories/1/1721638113710.webp', 9, '2024-07-17 03:38:49', '2024-07-22 09:10:51'),
	(8, 1, 'Ăn vặt', '/categories/1/taco.png', 11, '2024-07-17 03:39:13', '2024-07-22 10:38:36'),
	(9, 1, 'Cơm', '/categories/1/rice.png', 44, '2024-07-17 03:39:38', '2024-07-22 10:58:43'),
	(12, 1, 'Trái cây', '/categories/1/1721632831042.webp', 34, '2024-07-22 07:20:30', '2024-07-22 10:38:51'),
	(13, 1, 'Mì', '/categories/1/1721632903941.webp', 64, '2024-07-22 07:21:43', '2024-07-23 03:27:23'),
	(14, 1, 'Salad', '/categories/1/1721632952405.webp', 8, '2024-07-22 07:22:31', NULL),
	(15, 1, 'Nướng', '/categories/1/1721641756875.webp', 9, '2024-07-22 07:32:09', '2024-07-22 09:49:16'),
	(16, 1, 'Lẩu', '/categories/1/1721633835563.webp', 8, '2024-07-22 07:37:14', '2024-07-22 09:41:00'),
	(18, 1, 'Sashimi', '/categories/1/1721638127809.webp', 33, '2024-07-22 08:48:47', '2024-07-22 10:39:04');

-- Dumping structure for table menu_db.foods
DROP TABLE IF EXISTS `foods`;
CREATE TABLE IF NOT EXISTS `foods` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `image1` text COLLATE utf8mb4_general_ci,
  `image2` text COLLATE utf8mb4_general_ci,
  `image3` text COLLATE utf8mb4_general_ci,
  `image4` text COLLATE utf8mb4_general_ci,
  `category_id` bigint unsigned NOT NULL,
  `order_count` bigint DEFAULT NULL,
  `description` longtext COLLATE utf8mb4_general_ci,
  `discount` int DEFAULT NULL,
  `is_discount` tinyint(1) NOT NULL DEFAULT '0',
  `is_show` tinyint(1) NOT NULL DEFAULT '1',
  `price` float NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_food_category` (`category_id`),
  KEY `fk_users_foods` (`user_id`),
  CONSTRAINT `fk_users_foods` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=183 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.foods: ~134 rows (approximately)
DELETE FROM `foods`;
INSERT INTO `foods` (`id`, `user_id`, `name`, `image1`, `image2`, `image3`, `image4`, `category_id`, `order_count`, `description`, `discount`, `is_discount`, `is_show`, `price`, `created_at`, `updated_at`) VALUES
	(25, 1, 'an nhanh', '/foods/1/Breakfast-board28-500x500.jpg', '', '', '', 8, 14, 'Food is any substance consumed by an organism for nutritional support. Food is usually of plant, animal, or fungal origin and contains essential nutrients such as carbohydrates, fats, proteins, vitamins, or minerals. The substance is ingested by an organism and assimilated by the organism\'s cells to provide energy, maintain life, or stimulate growth. Different species of animals have different feeding behaviours that satisfy the needs of their metabolisms and have evolved to fill a specific ecological niche within specific geographical contexts.\n\nOmnivorous humans are highly adaptable and have adapted to obtain food in many different ecosystems. Humans generally use cooking to prepare food for consumption. The majority of the food energy required is supplied by the industrial food industry, which produces food through intensive agriculture and distributes it through complex food processing and food distribution systems. This system of conventional agriculture relies heavily on fossil fuels, which means that the food and agricultural systems are one of the major contributors to climate change, accounting for as much as 37% of total greenhouse gas emissions.[1]\n\nThe food system has significant impacts on a wide range of other social and political issues, including sustainability, biological diversity, economics, population growth, water supply, and food security. Food safety and security are monitored by international agencies like the International Association for Food Protection, the World Resources Institute, the World Food Programme, the Food and Agriculture Organization, and the International Food Information Council.', 1, 1, 1, 21000, '2024-07-17 05:37:55', '2024-07-20 11:06:35'),
	(26, 1, 'com', '/foods/1/party-food-500x500.jpg', '', '', '', 9, 18, '', 5, 1, 1, 30000, '2024-07-17 05:38:48', '2024-07-20 11:06:35'),
	(27, 1, 'asdasd', '/foods/1/dinner-ideas-2-500x500.jpg', '', '', '', 7, 13, 'Every time that I want to refactor a name of a class in my code I need to change the class name and also change the file name. I think this is a waste of time to change the name of the same thing twice, this is an another step to make refactor harder. For example, I have a class that have the name of NodeKey and I want to change the class name to FileKey I need to change the class name and the file name from node_key.dart to file_key.dart.\n\nI thing that this process need to be automated and it will same time for many users and make refactoring easier. On Change Symble that change class name the extension will check if the file name have the same name as the changed class name (taking into consideration the name conventions of UpperCamelCase for class names and lowercase_with_underscores for file names) and if they have the same name change also the file name to the new name (with the name conventions).\n\nAlternative solutions are: use existing extensions that does it, if you know any, or this is already possible in this extension and I don\'t know about it or make a new extension that does it.\n\nI will be happy to implement this if it is possible :) If possible you know any file/files you think that I need to change to make this feature?', 0, 0, 1, 25000, '2024-07-17 05:55:50', '2024-07-20 11:06:35'),
	(28, 1, 'Nước giải khát Coca Cola', '/foods/1/1721635906704.webp', '/foods/1/1721635906712.webp', '/foods/1/1721635702296.webp', '/foods/1/1721635702321.webp', 6, 2, '- Là loại nước ngọt được nhiều người yêu thích với hương vị thơm ngon, sảng khoái. Nước ngọt Cocacola vị nguyên bản với lượng gas lớn sẽ giúp bạn xua tan mọi cảm giác mệt mỏi, căng thẳng, đem lại cảm giác thoải mái sau khi hoạt động ngoài trời.', 0, 0, 1, 20000, '2024-07-22 08:08:22', '2024-07-22 09:15:06'),
	(29, 1, 'Nước uống giải khát Pepsi', '/foods/1/1721636150342.webp', '/foods/1/1721636150350.webp', '/foods/1/1721636150356.webp', '/foods/1/1721636150362.webp', 6, 0, '- Sản phẩm nước ngọt chính hãng từ thương hiệu Pepsi nổi tiếng toàn cầuvới hương vị thơm ngon, sảng khoái. Sản phẩm với lượng gas lớn sẽ giúp bạn bổ sung năng lượng làm việc mỗi ngày', 10, 1, 1, 20000, '2024-07-22 08:15:50', NULL),
	(30, 1, 'Sinh tố bơ', '/foods/1/1721636339935.webp', '/foods/1/1721636339944.webp', '/foods/1/1721636339950.webp', '/foods/1/1721636339956.webp', 6, 0, 'Bạn lo ngại mình chế biến không được giống với hương vị của quán và sẽ làm mất đi vị ngon vốn có của món sinh tố này. Đừng lo, bạn chỉ cần làm theo công thức dưới đây vừa đơn giản lại chẳng kém cạnh gì so với ngoài quán.', 0, 0, 1, 30000, '2024-07-22 08:18:59', NULL),
	(31, 1, 'Sinh tố dâu việt quất', '/foods/1/1721636596347.webp', '/foods/1/1721636596357.webp', '/foods/1/1721636596363.webp', '/foods/1/1721636596372.webp', 6, 0, 'Cho tất các các nguyên liệu vào máy xay trong vòng 1 phút đến khi đạt được độ nhuyễn mịn mong muốn, có thể thêm mật ong hoặc nước để điều chỉnh độ ngọt cũng như mức độ đặc của sinh tố theo nhu cầu của bạn.\r\n\r\nRót sinh tố ra ly, trang trí theo ý thích và thưởng thức.', 0, 0, 1, 30000, '2024-07-22 08:23:16', NULL),
	(32, 1, 'Sinh tố dưa lưới', '/foods/1/1721636689555.webp', '', '', '', 6, 0, 'Cho dưa lưới cùng đá bào, nước cốt chanh, sữa đặc và một chút nước vào máy xay sinh tố, xay hỗn hợp 2 phút cho mềm mịn.\r\n\r\nĐổ sinh tố ra ly và thưởng thức.', 0, 0, 1, 30000, '2024-07-22 08:24:49', NULL),
	(33, 1, 'Sinh tố cam soài', '/foods/1/1721636747750.webp', '', '', '', 6, 0, 'Xoài cắt nhỏ. Cam gọt vỏ và bổ thành nhiều miếng nhỏ.\r\n\r\nCho các nguyên liệu vào máy xay sinh tố xay trong 2 phút cho đến khi hỗn hợp nhuyễn mịn.\r\n\r\nĐổ sinh tố vào cốc, có thể cho lên trên vài lát cam hoặc xoài cắt hạt lựu và thưởng thức.\r\n\r\nHi vọng qua bài viết này, Barista School đã giúp bạn “bỏ túi” thêm những công thức sinh tố trái cây thơm ngon và dễ làm tại nhà nhé!', 0, 0, 1, 30000, '2024-07-22 08:25:47', NULL),
	(34, 1, 'Sữa hạnh nhân', '/foods/1/1721640511216.webp', '', '', '', 6, 0, 'Ngâm hạnh nhân với nước ấm khoảng 4 tiếng, sau đó tách vỏ lụa bên ngoài. Không nên ngâm quá lâu sẽ khiến sữa dễ bị chua và không còn vị béo.\r\n\r\nho hạnh nhân vào máy xay, đổ thêm khoảng 500ml nước, xay kỹ, nhiều lần để hỗn hợp thật nhuyễn.\r\n\r\nLọc hỗn hợp, thêm một ít nước và dùng muỗng khuấy đều và lọc kỹ để lọc bỏ phần bã.\r\n\r\nCho sữa đã lọc vào nồi, thêm 150g đường, khuấy đều để đường tan.\r\n\r\nĐun sữa trên bếp với lửa vừa, khuấy đều tay để sữa không bị vón.\r\n\r\nKhi sữa đã sôi, bạn để thêm 1 chút rồi tắt bếp. Sau đó, để nguội và rây lại 1 lần nữa để loại bỏ hết cặn.', 0, 0, 1, 30000, '2024-07-22 08:26:46', '2024-07-22 09:28:30'),
	(35, 1, 'Trà cam quế mật ong', '/foods/1/1721636880020.webp', '', '', '', 6, 0, 'Rửa sạch quế và dùng một chiếc nồi nhỏ, cho quế vào đun cùng khoảng 200ml. Đun đều lửa đến khi nước chuyển sang màu đỏ thì tắt bếp, vớt quế và lọc bỏ bụi, cặn.\r\n\r\nCam rửa sạch, vắt lấy nước cam nguyên chất, bỏ hạt. Hãy để lại 1 vài lát cam mỏng để trang trí cốc trà.\r\n\r\nCho nước quế, nước cam, mật ong và đá lạnh (tùy thích) vào cốc/ ly đảo đều.\r\n\r\nĐặt thêm lát cam, ống quế lên phía trên để trang trí. Sau đó bạn có thể thưởng thức nóng hoặc lạnh tùy thích.', 0, 0, 1, 30000, '2024-07-22 08:27:59', NULL),
	(36, 1, 'Trà dâu tây', '/foods/1/1721636919493.webp', '', '', '', 6, 0, 'Thả 2 túi trà lọc vào 500ml nước sôi và ngâm trong khoảng 10 – 20 phút để trà được đậm vị.\r\n\r\nRửa sạch dâu tây, cắt đôi quả để vào ly thủy tinh. Sử dụng chày muddle dầm nát.\r\n\r\nTiếp theo cho dâu tây tươi vừa dầm nát, pure dâu, 100 – 200ml nước trà và đá viên vào bình lắc. Lắc đều khoảng 15 – 20 giây để các nguyên liệu hòa đều với nhau.\r\n\r\nĐổ hỗn hợp nước trà vào ly thủy tinh và trang trí cốc trà cùng vài lát dâu tây tươi.', 0, 0, 1, 30000, '2024-07-22 08:28:39', NULL),
	(37, 1, 'Trà nhài thanh long đỏ', '/foods/1/1721636949003.webp', '', '', '', 6, 0, 'Cho trà vào bình lắc, thêm đá, mật ong, nước đường, nước cốt chanh, siro vào lắc đều tay khoảng 10 giây.\r\n\r\nĐổ trà ra cốc, cho thêm thanh long đỏ vào để thưởng thức.', 0, 0, 1, 30000, '2024-07-22 08:29:08', NULL),
	(38, 1, 'Sushi cá hồi', '/foods/1/1721637235726.webp', '', '', '', 7, 0, 'Sushi cá hồi là một món sushi được làm từ miếng cá hồi tươi được cắt thành những lát mỏng và được đặt lên một viên cơm trộn với giấm gạo, muối, đường và một ít rong biển.', 0, 0, 1, 59000, '2024-07-22 08:33:55', NULL),
	(39, 1, 'Sushi tôm ngọt Nhật', '/foods/1/1721637304221.webp', '', '', '', 7, 0, 'Tôm ngọt Nhật là một loại tôm được nuôi trong ao nuôi tại Nhật Bản. Tôm ngọt Nhật có thịt ngon, ngọt và dai, được ưa chuộng và sử dụng trong nhiều món ăn Nhật Bản.', 0, 0, 1, 169000, '2024-07-22 08:35:03', '2024-07-22 08:35:09'),
	(40, 1, 'Sushi Kobe nướng tái', '/foods/1/1721637404018.webp', '', '', '', 7, 0, '', 20, 1, 1, 149000, '2024-07-22 08:36:43', NULL),
	(41, 1, 'Sushi Kobe Phomai', '/foods/1/1721637461942.webp', '', '', '', 7, 0, 'Thịt bò Kobe là loại thịt bò được sản xuất từ các con bò đặc biệt nuôi tại vùng Hyogo của Nhật Bản', 0, 0, 1, 149000, '2024-07-22 08:37:41', NULL),
	(42, 1, 'Sushi lươn Nhật', '/foods/1/1721637501309.webp', '', '', '', 7, 0, 'Sushi lươn có mùi vị đậm đà, béo ngậy và hơi ngọt do nước sốt teriyaki, hương vị của rong biển và cơm nếm giấm. Đây là một món ăn giàu chất dinh dưỡng, cung cấp nhiều protein từ lươn và carbohydrate từ cơm. Lươn cũng là nguồn cung cấp axit béo omega-3, giúp giảm nguy cơ mắc bệnh tim mạch và đột quỵ.', 0, 0, 1, 89000, '2024-07-22 08:38:20', NULL),
	(43, 1, 'Sushi tôm bơ', '/foods/1/1721637542287.webp', '', '', '', 7, 0, 'Thịt tôm là nguồn dinh dưỡng tốt, chứa nhiều protein, vitamin và khoáng chất như selen, đồng, kẽm, magiê và iodine. Nó cũng là một nguồn tuyệt vời của các axit béo omega-3, một loại chất béo có lợi cho sức khỏe tim mạch.', 0, 0, 1, 69000, '2024-07-22 08:39:01', NULL),
	(44, 1, 'Cuộn trứng cá hồi đặc biệt', '/foods/1/1721637629627.webp', '', '', '', 7, 0, 'Cuộn trứng cá hồi là một món ăn sushi phổ biến trong ẩm thực Nhật Bản. Món ăn này được làm bằng cách cuộn cơm sushi với lá nori (tảo biển khô) và trứng cá hồi bên trong.', 0, 0, 1, 219000, '2024-07-22 08:40:29', NULL),
	(45, 1, 'Cuộn cá hồi nướng tái', '/foods/1/1721637691480.webp', '', '', '', 7, 0, 'Cá hồi nướng tái là một món ăn phổ biến trong ẩm thực Nhật Bản và nhiều quốc gia khác trên thế giới. Món ăn này được làm bằng cách nướng cá hồi với nhiệt độ cao trong một thời gian ngắn để bên trong cá vẫn còn tái (hơi chín nhưng không chín hoàn toàn).', 0, 0, 1, 139000, '2024-07-22 08:41:31', '2024-07-22 08:54:36'),
	(46, 1, 'Cuộn tôm cá ngừ', '/foods/1/1721637769167.webp', '', '', '', 7, 0, 'Cuộn tôm cá ngừ là một món ăn sushi phổ biến trong ẩm thực Nhật Bản. Món ăn này được làm bằng cách cuộn cơm sushi với lá nori (tảo biển khô), tôm, cá ngừ và rau sống bên trong.', 0, 0, 1, 149000, '2024-07-22 08:42:48', '2024-07-22 08:54:31'),
	(47, 1, 'Cơm cuộn tôm', '/foods/1/1721637842705.webp', '', '', '', 7, 0, 'Trong sushi tôm, tôm thường được chế biến trước khi được đặt lên trên cơm. Tôm sống được chế biến bằng cách ngâm trong nước muối để giết chết vi khuẩn và loại bỏ mùi hôi của tôm. Sau đó, tôm được lột vỏ và cắt thành miếng nhỏ để đặt lên trên cơm sushi.', 0, 1, 1, 99000, '2024-07-22 08:44:02', '2024-07-22 09:46:18'),
	(48, 1, 'Bụng cá hồi', '/foods/1/1721638238738.webp', '', '', '', 18, 0, 'Sashimi cá hồi có vị tươi ngon, béo ngậy, thường được xem là một món ăn sang trọng và đẳng cấp trong ẩm thực Nhật Bản.', 0, 0, 1, 169000, '2024-07-22 08:50:38', NULL),
	(49, 1, 'Combo cá hồi', '/foods/1/1721638295459.webp', '', '', '', 18, 0, 'Sashimi cá hồi là một món ăn Nhật Bản truyền thống được làm từ cá hồi tươi sống được cắt thành miếng mỏng và được ăn kèm với các gia vị như wasabi và đậu phộng. Cá hồi thường được chọn từ các loài có chất lượng tốt và được chế biến ngay sau khi bắt để đảm bảo tươi ngon nhất.', 0, 0, 1, 779000, '2024-07-22 08:51:35', '2024-07-22 08:54:16'),
	(50, 1, 'Cá hồi đặc biệt', '/foods/1/1721638341583.webp', '', '', '', 18, 0, 'Sashimi cá hồi có vị tươi ngon, béo ngậy, thường được xem là một món ăn sang trọng và đẳng cấp trong ẩm thực Nhật Bản.', 0, 0, 1, 439000, '2024-07-22 08:52:21', '2024-07-22 08:54:12'),
	(51, 1, 'Trứng cá hồi', '/foods/1/1721638388668.webp', '', '', '', 18, 0, 'Trứng Cá Hồi được xem là một loại thực phẩm dinh dưỡng cao vì chứa nhiều chất béo không bão hòa omega-3, protein, vitamin và khoáng chất.', 0, 0, 1, 199000, '2024-07-22 08:53:08', '2024-07-22 08:54:07'),
	(52, 1, 'Cá hồi ', '/foods/1/1721638443501.webp', '', '', '', 18, 0, '', 0, 0, 1, 159000, '2024-07-22 08:54:03', NULL),
	(53, 1, 'Sườn bò không xương', '/foods/1/1721638635764.webp', '', '', '', 15, 0, 'Món ăn thịt bò BBQ có hương vị đậm đà, thơm ngon và đa dạng, là món ăn yêu thích của nhiều người và đáng để thử.', 0, 0, 1, 259000, '2024-07-22 08:57:15', NULL),
	(54, 1, 'Thăn ngoại Kobe cắt thanh', '/foods/1/1721638688097.webp', '', '', '', 15, 0, 'Thịt bò Kobe, hay còn gọi là Wagyu, là loại thịt bò được chăn nuôi ở Nhật Bản. Thịt bò Kobe được biết đến với chất lượng cao, mềm và thơm ngon, với một lượng mỡ intramuscular (mỡ nằm trong cơ) cao, tạo ra một hương vị đặc biệt và mềm mượt.', 0, 0, 1, 1599000, '2024-07-22 08:58:07', NULL),
	(55, 1, 'Bạch tuộc nướng sa tế', '/foods/1/1721639029133.webp', '', '', '', 15, 0, 'Bạch tuộc vốn dĩ đã có vị ngọt tự nhiên do vậy khi nướng bạn không cần phải chuẩn bị quá nhiều gia vị. Bạn chỉ cần làm sạch bạch tuộc rồi ướp cùng một chút hành tím, tỏi băm nhuyễn, sa tế cà gia vị. Để ướp khoảng 30-40 phút cho bạch tuộc thấm đều gia vị là có thể mang đi nướng. Những miếng bạch tuộc vàng ươm, dai dai cùng vị cay của sa tế rất hấp dẫn.', 0, 0, 1, 49000, '2024-07-22 09:03:48', NULL),
	(56, 1, 'Gà nướng mật ong', '/foods/1/1721639069130.webp', '', '', '', 15, 0, 'Sò lông không chỉ chứa nhiều chất dinh dưỡng tốt cho cơ thể mà chúng còn được chế biến thành nhiều món ăn thơm ngon, lạ miệng và hấp dẫn. Từng chú sò lông béo ú được nướng trên bếp than hồng cùng với sa tế thơm lừng thật cuốn hút. Thịt sò khi nướng chín sẽ có vị ngọt thanh, giòn dai và không hề bị tanh mà ngược lại còn thơm mùi sa tế cùng nước sốt cay có hương vị đậm đà.', 0, 0, 1, 200000, '2024-07-22 09:04:28', NULL),
	(57, 1, 'Tôm nướng muối ớt', '/foods/1/1721639125144.webp', '', '', '', 15, 0, 'Vị ngọt thanh của thịt tôm quyện cùng vị cay nồng của muối ớt chắc chắn sẽ khiến bạn cảm thấy vô cùng thú vị. Món ăn này không cần phải chuẩn bị nguyên liệu cầu kì, chỉ cần tôm tươi sống, muối, tỏi, ớt bột và ớt băm nhuyễn là đủ. Để món tôm nướng muối ớt ngon và thêm phần hấp dẫn thì bạn nên chọn những con tôm sú tươi ngon, to và chắc thịt nhé!', 0, 0, 1, 120000, '2024-07-22 09:05:24', NULL),
	(58, 1, 'Hàu nướng mỡ hành', '/foods/1/1721639164444.webp', '', '', '', 15, 0, 'Nhắc đến các món nướng ngon đến từ hải sản thì không thể nào quên một món đặc biệt là hàu nướng mỡ hành. Món ăn này không chỉ thơm ngon mà còn bổ dưỡng rất tốt cho sức khỏe. Thịt hàu ngọt kết hợp cùng vị béo và mùi thơm của mỡ hành tạo nên món ăn ngon khó cưỡng.', 0, 0, 1, 90000, '2024-07-22 09:06:03', NULL),
	(59, 1, 'Cá hồi nướng tỏi', '/foods/1/1721639209563.webp', '', '', '', 15, 0, 'Cá hồi là một thực phẩm được nhiều chị em nội trợ yêu thích bởi chúng có giá trị dinh dưỡng cao, hương vị thơm ngon và thịt cá ngọt. Cá hồi nướng tỏi có hương vị thơm lừng của những tép tỏi nướng được kết hợp cùng miếng cá hồi ngọt ngon, chắc thịt. Món ăn này rất ngon miệng, kích thích được các giác quan của người ăn', 0, 0, 1, 30000, '2024-07-22 09:06:49', NULL),
	(60, 1, 'Thịt lợn nướng riềng sả', '/foods/1/1721639260244.webp', '', '', '', 15, 0, 'Bạn có thể làm mới món thịt lợn nướng bằng cách nướng với riềng sả rất ngon, chắc chắn sẽ được lòng của cả nhà. Món ăn này chế biến không quá cầu kì, nguyên liệu chủ đạo là thịt lợn, riềng và sả tạo nên món ăn cực hấp dẫn, không thể lẫn vào đâu được. Để món ăn được ngon hơn, bạn nên chọn phần thịt ba chỉ hoặc thịt chân giò để khi nướng thịt không bị khô.', 0, 0, 1, 120000, '2024-07-22 09:07:39', NULL),
	(61, 1, 'Thịt heo nướng sốt chanh', '/foods/1/1721639386554.webp', '', '', '', 15, 0, 'Phần nước sốt chanh được làm từ dầu hào, nước cốt canh, bột tiêu đen, sốt cà chua, gừng rồi ướp với thịt heo khoảng 2 tiếng cho thấm gia vị.\r\n\r\nKhi nướng thịt, bạn có thể phết thêm nước sốt lên trên bề mặt cho thịt đậm đà hơn.', 0, 0, 1, 79000, '2024-07-22 09:09:46', NULL),
	(62, 1, 'Bò lá lốt', '/foods/1/1721639421043.webp', '', '', '', 15, 0, 'Băm nhuyễn thịt bò trộn cùng với thịt heo xay, mỡ heo xay. Sau đó trộn thịt với 30g lá lốt thái nhỏ, hành tím, sả băm, tỏi băm, lạc đã dập sơ, hạt tiêu xay, đường, hạt nêm, dầu hào, 8 muỗng canh dầu ăn.\r\n\r\nDùng lá lốt cuộn nhân thịt thành từng miếng vừa ăn.\r\n\r\nQuét chút dầu ăn lên vỉ và bắt đầu nướng.', 0, 0, 1, 49000, '2024-07-22 09:10:20', NULL),
	(63, 1, 'Dưa lưới ', '/foods/1/1721639630179.webp', '', '', '', 12, 0, 'Ăn dưa đê', 0, 0, 1, 40000, '2024-07-22 09:13:49', NULL),
	(64, 1, 'Combo trái cây 2', '/foods/1/1721639677786.webp', '', '', '', 12, 0, 'Cách cắt trái cây đẹp mắt hoàn toàn nằm trong khả năng của bạn', 0, 0, 1, 30000, '2024-07-22 09:14:37', NULL),
	(65, 1, 'Combo Cam Táo Dâu', '/foods/1/1721639759182.webp', '', '', '', 12, 0, 'hoa quả đẹp mắt, miễn chê.', 0, 0, 1, 30000, '2024-07-22 09:15:58', NULL),
	(66, 1, 'Combo cam Dưa hấu', '/foods/1/1721639814448.webp', '', '', '', 12, 0, 'Để làm trái cây dĩa đẹp thì phải thật tỉ mỉ bạn nhé!', 0, 0, 1, 30000, '2024-07-22 09:16:53', NULL),
	(67, 1, 'Lẩu Tứ Xuyên', '/foods/1/1721640134211.webp', '', '', '', 16, 0, 'Lẩu Tứ Xuyên là một trong những món lẩu ngon trên thế giới, không chỉ nổi tiếng của Trung Quốc mà còn tại nhiều nước khác. Món ăn này xuất phát từ điều kiện địa lý đặc biệt của miền đất Tứ Xuyên. Vì tỉnh này có độ ẩm cao, mùa đông lạnh nên người dân đã sáng tạo nên món lẩu nóng hổi, cay xè. ', 0, 0, 1, 340000, '2024-07-22 09:22:13', NULL),
	(68, 1, 'Lẩu Thái', '/foods/1/1721640167553.webp', '', '', '', 16, 0, 'Một trong những món lẩu nổi tiếng rất được yêu thích là món lẩu Thái – lẩu truyền thống của người dân Thái Lan với đầy đủ hương vị chua, cay, ngọt, mặn. Đây cũng là món lẩu có vị cay nồng nhưng vừa phải. Sự kết hợp của ớt đỏ, gừng tươi và nước cốt chanh, lá chanh với tỉ lệ hợp lý giúp món lẩu dễ ăn hơn. ', 0, 0, 1, 490000, '2024-07-22 09:22:46', NULL),
	(69, 1, 'Lẩu Shabu', '/foods/1/1721640379717.webp', '', '', '', 16, 0, 'Thêm một món lẩu ngon trên thế giới mà bạn không thể bỏ qua, đó là lẩu shabu của Nhật Bản. Món lẩu này mê hoặc những tín đồ ẩm thực bởi hương vị ngọt đậm đà và dinh dưỡng cao. Theo đó, lẩu shabu có nguồn gốc từ Shuan Yangrou của Trung Hoa. Theo thời gian, món ăn được cải biên để trở thành món lẩu hấp dẫn của Nhật Bản. ', 0, 0, 1, 30000, '2024-07-22 09:26:19', NULL),
	(70, 1, 'Lẩu kim chi', '/foods/1/1721640675767.webp', '', '', '', 16, 0, 'Lẩu kim chi cũng là món lẩu nổi tiếng của Hàn Quốc, được yêu thích nhờ hương vị đậm đà, thơm ngon. Món lẩu này là món ăn truyền thống của người Hàn, có vị chua cay đậm đà nhờ cách thức nêm nếm đặc biệt. Mùa đông mà được xì xụp bên nồi nước lẩu kim chi thì còn gì ngon và hấp dẫn bằng? ', 0, 0, 1, 43000, '2024-07-22 09:31:15', NULL),
	(71, 1, 'Lẩu cá', '/foods/1/1721640813777.webp', '', '', '', 16, 0, 'Món ăn này rất dễ làm và không tốn nhiều thời gian. Đầu tiên, bạn sơ chế sạch cá bằng cách bỏ mang, xẻ dọc phía dưới miệng cá rồi moi hết phần ruột bên trong. Sau đó rửa lại cá bằng nước sạch, ngâm qua bằng dấm hoặc rượu để khử mùi tanh và tăng hương vị cho cá.\r\n\r\nThái cá thành từng miếng nhỏ rồi xếp vào đĩa, tẩm ướp gia vị. Lẩu cá thường ăn kèm với rau chuối, rau muống, bún, ngò gai, rau ngổ,… và nước mắm.', 0, 0, 1, 45300, '2024-07-22 09:33:33', NULL),
	(72, 1, 'Lẩu chua cay', '/foods/1/1721640846691.webp', '', '', '', 16, 0, 'Vị chua chua cay cay từ lẩu chua cay chắc chắn sẽ là một sự lựa chọn tuyệt vời, thách thức khả năng chịu đựng của cái nóng mùa hè gay gắt. Lẩu chua cay có nguồn gốc từ Thái Lan với cách nấu rất đơn giản.\r\n\r\nCác nguyên liệu cần chuẩn bị cho món ăn gồm thịt cá, hải sản, rau củ. Thời gian thực hiện món lẩu rất nhanh chóng, giúp bạn sẽ có được một món ăn trọn vị.', 0, 0, 1, 340000, '2024-07-22 09:34:06', NULL),
	(73, 1, 'Lẩu gà', '/foods/1/1721640880006.webp', '', '', '', 16, 0, 'Cách thực hiện món lẩu gà thập cẩm rất đơn giản và dễ dàng, nồi lẩu gà thành phẩm sẽ có vị thơm của chanh, sả, rượu trắng,… và một số gia vị khác khiến nồi lẩu gà dậy mùi thơm hơn. Ngoài ra, gà đã có sẵn vị ngọt tự nhiên nên sẽ càng ngon hơn khi ăn kèm với rau, cá, nấm hay hải sản.\r\n\r\nBạn có thể tham khảo một số món lẩu gà như lẩu gà lá é, lẩu gà lá giang,… để phù hợp với khẩu vị của gia đình.', 0, 0, 1, 340000, '2024-07-22 09:34:39', NULL),
	(74, 1, 'Lẩu bò', '/foods/1/1721640905635.webp', '', '', '', 16, 0, 'Lẩu bò được xem là món ăn nhất định phải thưởng thức vào những ngày hè oi ả. Vị ngọt của xương bò cộng với vị thơm đặc trưng của đậu phụ mềm thì không còn gì để nói. Một trong những yếu tố giúp món ăn này trở nên hấp dẫn là nước chấm chao đậm vị.', 0, 0, 1, 340000, '2024-07-22 09:35:04', NULL),
	(75, 1, 'Lẩu bạch tuộc', '/foods/1/1721640927225.webp', '', '', '', 16, 0, 'Lẩu thường là món ăn được lựa chọn vào những buổi họp, gặp gỡ đông người. Nếu lẩu gà, lẩu nấm hay lẩu bò đã là những món ăn quá quen thuộc, sao bạn không thử đổi vị với lẩu bạch tuộc. ', 0, 0, 1, 340000, '2024-07-22 09:35:26', NULL),
	(76, 1, 'Lẩu chay', '/foods/1/1721640949274.webp', '', '', '', 16, 0, 'Nếu đã quá ngán với thịt cá, lẩu chay sẽ là món ăn hấp dẫn giải nhiệt cho mùa hè. Nguyên liệu chính để nấu lẩu chay bao gồm tàu hủ, nấm, rau củ quả hay mọc chay.\r\n\r\nNếu thích hương vị chua cay, bạn có thể lựa chọn lẩu chay Thái Lan. Ngược lại, các món lẩu rau nấm chứa nhiều chất xơ sẽ là sự lựa chọn phù hợp nếu bạn không thích ăn cay.', 0, 0, 1, 123300, '2024-07-22 09:35:48', NULL),
	(77, 1, 'Lẩu kiểu nhật', '/foods/1/1721640977182.webp', '', '', '', 16, 0, 'Ở Nhật, lẩu thường được ăn vào mùa đông để làm ấm cơ thể. Tuy nhiên, khi về Việt Nam, người Việt có thể ăn lẩu kiểu Nhật quanh năm vì món ăn này có thể đổ mồ hôi nhiều, giúp tăng sức bền. ', 0, 0, 1, 324000, '2024-07-22 09:36:16', NULL),
	(78, 1, 'Lẩu tôm', '/foods/1/1721640999463.webp', '', '', '', 16, 0, 'Vào mùa hè, nhiều người thường không thích ăn lẩu vì ngại nóng nhưng lẩu tôm lại rất mát với vị chua thanh ngọt, vị mát của bí đao hay mùi thơm của mướp.\r\n\r\nNước dùng lẩu rất ngọt, vị ngọt của nước cốt tôm xay nguyên chất, tạo nên sự kết hợp tuyệt vời với các nguyên liệu đi kèm gồm gầu bò, sườn sụn, chả tôm,…', 0, 0, 1, 540000, '2024-07-22 09:36:38', NULL),
	(79, 1, 'Lẩu đậu hủ', '/foods/1/1721641028493.webp', '', '', '', 16, 0, 'Trong các món đậu hủ chay, lẩu đậu hủ được xem là món ăn thích hợp vào mùa hè. Nguyên liệu cần chuẩn bị là đậu hủ, nấm và nước dùng được nấu từ các loại rau củ quả hầm nhừ.\r\n\r\nLẩu đậu hủ có ưu điểm là hương vị bổ dưỡng, thanh đạm, không chán ngấy, thích hợp với những buổi sum họp gia đình.\r\n\r\n', 0, 0, 1, 234000, '2024-07-22 09:37:07', NULL),
	(80, 1, 'Lẩu chân giò', '/foods/1/1721641057475.webp', '/foods/1/1721641057484.webp', '', '', 16, 0, 'Lẩu chân giò rất kén người ăn nhưng những ai đã ăn được, hợp khẩu vị là sẽ nghiện ngay từ lần ăn đầu tiên. Khi nấu, lượng mỡ trong chân giò heo được tiêu bớt nên không có vị quá béo ngậy mà chỉ có độ ngọt với hương thơm ngào ngạt. ', 0, 0, 1, 430000, '2024-07-22 09:37:36', NULL),
	(81, 1, 'Lẩu sườn non', '/foods/1/1721641080241.webp', '', '', '', 16, 0, 'Một nồi lẩu thơm lừng, nóng hồi, đầy ắp thịt và rau xanh luôn bắt mắt và ngon miệng. Do đó, trong các món lẩu ngon mùa hè không thể không nhắc đến lẩu sườn non.\r\n\r\nMón ăn thành phẩm có màu sắc đỏ pha vàng đẹp mắt, nước lẩu trong vắt, đậm đà. Khi ăn có thể kết hợp thêm rau xanh, thịt bò, nấm là bạn đã có được một món ăn giải nhiệt tuyệt vời cho ngày hè.', 0, 0, 1, 430000, '2024-07-22 09:37:59', NULL),
	(82, 1, 'Lẩu khô Hồn Nam', '/foods/1/1721641200509.webp', '', '', '', 16, 0, 'Nguyên liệu làm lẩu khô có thể là vịt, cá, thỏ... Những món này sau khi sơ chế được ướp thêm các loại phụ liệu như gừng lát, rau mùi... rồi dùng rượu trắng xào sơ qua, sau đó bỏ vào chút dầu ớt, đun khoảng 15 phút là trở thành nồi lẩu khô có mùi vị đặc biệt. Đây là món ăn độc đáo của vùng Hồ Nam.', 0, 0, 1, 430000, '2024-07-22 09:39:59', NULL),
	(83, 1, 'Lẩu hải sản Quảng Đông', '/foods/1/1721641242347.webp', '', '', '', 16, 0, 'Món lẩu hải sản của người Quảng Đông rất chăm chút phần nguyên liệu, nồi lẩu bắt buộc phải có nhiều loại hải sản đa dạng như thịt bò, mực, bạch tuộc, xách bò, hải sâm... Khi ăn, các loại hải sản sẽ được nhúng chín trong phần nước dùng thanh ngọt, sau đó để riêng vào chén của mỗi người rồi mới tiếp tục bỏ các phần nguyên liệu thịt gà, thịt bò vào nồi lẩu. Sau khi dùng xong phần thịt mới thêm vào các loại rau cải, nấm để ăn sau cùng.', 0, 0, 1, 324000, '2024-07-22 09:40:34', '2024-07-22 09:40:41'),
	(84, 1, 'Lẩu Trùng Khánh', '/foods/1/1721641681718.webp', '', '', '', 16, 0, 'Lẩu Trùng Khánh, còn gọi là “lẩu cay”, một trong những món ăn truyền thống của người Hán ở vùng Xuyên Du. Lẩu Trùng Khánh có màu đỏ, vị cay là vị chủ đạo, ngoài ra còn có vị mặn, chua phía dưới đáy là phần mỡ bò để tạo thêm phần ngậy và thơm cho nồi nước dùng.', 0, 0, 1, 4300000, '2024-07-22 09:48:00', '2024-07-22 09:51:46'),
	(85, 1, 'Bánh tráng cuộn sốt trứng', '/foods/1/1721641899059.webp', '', '', '', 8, 0, 'Nếu bạn là một tín đồ của món ăn vặt thì hãy thử thưởng ngay món bánh tráng cuộn sốt trứng sẽ khiến nhiều người mê đắm bởi phần bánh tráng dẻo thơm và bắt mắt với màu vàng óng ánh. Còn phần sốt được làm từ trứng gà thơm béo kết hợp cùng những nguyên liệu ăn kèm rất đậm đà và vừa vị.', 0, 0, 1, 200000, '2024-07-22 09:51:38', NULL),
	(86, 1, 'Rong biển cháy tỏi', '/foods/1/1721641967846.webp', '', '', '', 8, 0, 'Với vị rong biển đậm đà, giòn rụm quyện cùng phần tỏi thơm lừng kết hợp cùng vị cay cay từ ớt rất kích thích,... Tất cả đã tạo nên một món ăn vặt rất hấp dẫn và thơm ngon. Món rong biển cháy tỏi được nhiều người dùng khi xem phim, nhâm nhi với bia hay dùng với cơm trắng đều rất ngon.', 0, 0, 1, 34300, '2024-07-22 09:52:47', NULL),
	(87, 1, 'Bánh tráng trộn', '/foods/1/1721642002688.webp', '', '', '', 8, 0, 'Đây được xem là một món ăn vặt quen thuộc thu hút giới trẻ nhờ vào sự kết hợp gia vị và nguyên liệu một cách độc đáo.\r\nMón bánh tráng trộn được phối trộn từ vị cay của bò khô cùng vị béo bùi của lạc, của trứng cút và vị thơm của hành phi. Tất cả đã đồng nhất tạo nên một hương vị có một không hai.', 0, 0, 1, 32000, '2024-07-22 09:53:21', NULL),
	(88, 1, 'Xoài Lắc', '/foods/1/1721642153198.webp', '', '', '', 8, 0, 'Xoài lắc là một trong những món ăn vặt được yêu thích bậc nhất Sài Gòn. Món ăn này đã “đốn tim” nhiều tín đồ ẩm thực với vị chua chua ngọt ngọt đầy kích thích từ xoài. Đồng thời, vị thơm lừng và cay nhẹ của muối tôm càng giúp món xoài lắc thêm phần cuốn hút và thơm ngon.', 0, 0, 1, 32000, '2024-07-22 09:55:52', NULL),
	(89, 1, 'Chè bưởi', '/foods/1/1721642178178.webp', '', '', '', 8, 0, 'Nếu bạn là một tín đồ của những món ngọt thì hãy thưởng thức qua món chè bưởi thơm ngon, hấp dẫn. Món ăn này phải được chế biến rất công phu và tỉ mĩ mới cho ra được hương vị thơm nồng, giòn dai của bưởi nhưng lại không bị đắng hòa quyện cùng vị bùi của đậu xanh và điểm thêm vị béo ngậy của nước cốt dừa sẽ khiến bạn mê đắm.', 0, 0, 1, 320000, '2024-07-22 09:56:17', NULL),
	(90, 1, 'Bánh tráng cuộn sốt me', '/foods/1/1721642209678.webp', '', '', '', 8, 0, 'Món bánh tráng cuốn sốt me đã làm mê đắm bao tín đồ ăn vặt bởi phần bánh tráng dẻo thơm quyện cùng vị chua của xoài, vị béo thơm của đậu phộng, trứng cút hòa quyện cùng cái thơm của rau răm rất kích thích. Đồng thời, phần sốt chua, mặn, ngọt rất vừa phải càng làm món ăn thêm cuốn hút.', 0, 0, 1, 320000, '2024-07-22 09:56:48', NULL),
	(91, 1, 'Bánh tôm', '/foods/1/1721642240904.webp', '', '', '', 8, 0, 'Nếu bạn đang tìm một món bánh thơm ngon, hấp dẫn thì hãy thưởng thức ngay món bánh tôm. Nhiều người yêu thích món bánh tôm bởi vỏ bánh vàng giòn, đẹp mắt quyện cùng phần nhân béo bùi. Một linh hồn của món ăn này đó chính là nước chấm, bạn chỉ cần nhúng miếng bánh tôm vào nước chấm bạn sẽ cảm nhận được hương vị đậm đà rất kích thích.', 0, 0, 1, 430000, '2024-07-22 09:57:20', NULL),
	(92, 1, 'Nuộm khô bò', '/foods/1/1721642280714.webp', '', '', '', 8, 0, 'Với vị ngọt nhẹ và giòn giòn củađu đủ kết hợp cùng vị dai dai của khô bò, thơm nồng mùi ớt cực hấp dẫn. Món nộm khô bò thường được các bạn trẻ thưởng thức vào những buổi chiều mát ở những quán lề đường, vừa ăn vừa trò chuyện với bạn bè quả thật là thú vị và tuyệt vời.', 0, 0, 1, 320000, '2024-07-22 09:57:59', NULL),
	(93, 1, 'Chè khoai dẻo', '/foods/1/1721642315308.webp', '', '', '', 8, 0, 'Chè khoai dẻo được nấu từ khoai lang kết hợp cùng đường và lá dứa nên tạo nên một món ăn ngon với vị ngọt bùi, dai dai của viên khoai lang hòa cùng phần nước cốt dừa béo ngậy và đặc biệt hương thơm thoang thoảng từ lá dứa đã khiến nhiều người sành ăn phải gật gù khen ngon.', 0, 0, 1, 320000, '2024-07-22 09:58:34', NULL),
	(94, 1, 'Cút lộn xào me', '/foods/1/1721642338918.webp', '', '', '', 8, 0, 'Món cút lộn xào me đã chinh phục được nhiều thực khách từ lần đầu tiên thưởng thức. Vị chua ngọt của sốt được kết hợp rất vừa vị, quyện cùng phần trứng cút bổ dưỡng cộng thêm vị ấm, thơm của rau răm và vị béo giòn của đậu phộng,... Tất cả được được phối trộn rất đúng điệu và hợp vị.', 0, 0, 1, 320000, '2024-07-22 09:58:58', NULL),
	(95, 1, 'Cá viên chiên nước mắm', '/foods/1/1721642368711.webp', '', '', '', 8, 0, 'Món cá viên chiên nước mắm là một trong những món ăn được nhiều bạn trẻ ưa chuộng nhất. Món ăn này được biến tấu một cách đầy sáng tạo với phần cá viên được chiên vàng đầy hấp dẫn quyện cùng phần sốt nước mắm mặn mặn, ngọt ngọt rất đậm đà và thơm ngon.', 0, 0, 1, 32000, '2024-07-22 09:59:27', NULL),
	(96, 1, 'Khoai tây lốc xoáy', '/foods/1/1721642410028.webp', '', '', '', 8, 0, 'Khoai tây lốc xoáy được biết đến là một món ăn vặt đến từ Hàn Quốc và không biết tự lúc nào món ăn này đã chinh phục và được giới trẻ rất yêu thích. Điều thú vị của món ăn này đó là phần khoai tây được tạo hình như lốc xoáy được chiên vàng giòn quyện cùng vị phô mai béo ngậy đã tạo nên sự kết hợp rất đặc biệt.', 0, 0, 1, 32000, '2024-07-22 10:00:09', '2024-07-22 10:00:24'),
	(97, 1, 'Sụn gà rang muối', '/foods/1/1721642469269.webp', '', '', '', 8, 0, 'Sụn gà rang muối là một cái tên quen thuộc trong danh sách những món ăn vặt được yêu thích nhất bởi phần sụn gà được chiên vàng giòn đấy hấp dẫn kết hợp cùng lớp muối được phủ đều bên ngoài rất vừa vị và thơm ngon. Món ăn này bạn có thể dùng với bia hoặc cơm đều ngon hết mức.', 0, 0, 1, 140000, '2024-07-22 10:01:08', NULL),
	(98, 1, 'Bánh cay', '/foods/1/1721642493861.webp', '', '', '', 8, 0, 'Đây được xem là một loại bánh chứa đầy ký ức tuổi thơ về những người bà, người mẹ đã tỉ mĩ tạo nên một món ăn thơm ngon, tròn vị. Bánh cay được nhiều người yêu thích bởi phần khoai mì được xử lý và chiên vàng quyện cùng vị cay từ ớt đã tạo nên một món ăn rất kích thích.', 0, 0, 1, 43000, '2024-07-22 10:01:33', NULL),
	(99, 1, 'Da heo chiên nước mắm', '/foods/1/1721642530306.webp', '', '', '', 8, 0, 'Phần da heo được chiên giòn rụm, có màu vàng đẹp mắt kết hợp cùng phần nước sốt đậm đà có đủ vị mặn, ngọt, cay rất hấp dẫn. Chính từ sự độc đáo từ sắc, hương và vị mà món da heo chiên nước mắm đã được các bạn trẻ yêu thích và chọn làm món ăn thường trực trong các buổi nói chuyện hay xem phim.', 0, 0, 1, 43000, '2024-07-22 10:02:09', NULL),
	(100, 1, 'Mực rim me', '/foods/1/1721642565070.webp', '', '', '', 8, 0, 'Mực rim me là một món ăn được kết hợp nguyên liệu rất tài hoa và đầy nghệ thuật. Chỉ với mực khô và me đã tạo nên một món ăn vặt đậm đà, thơm ngon với vị thơm đặc trưng từ mực khô kết hợp cùng vị chua ngọt đầy hấp dẫn. Đây cũng được xem là một món ăn ngon khi dùng với bia và cơm trắng', 0, 0, 1, 40300, '2024-07-22 10:02:44', NULL),
	(101, 1, 'Dừa sấy', '/foods/1/1721642599705.webp', '', '', '', 8, 0, 'Mực rim me là một món ăn được kết hợp nguyên liệu rất tài hoa và đầy nghệ thuật. Chỉ với mực khô và me đã tạo nên một món ăn vặt đậm đà, thơm ngon với vị thơm đặc trưng từ mực khô kết hợp cùng vị chua ngọt đầy hấp dẫn. Đây cũng được xem là một món ăn ngon khi dùng với bia và cơm trắng', 0, 0, 1, 23000, '2024-07-22 10:03:18', NULL),
	(102, 1, 'Bánh tráng tỏi', '/foods/1/1721642627954.webp', '', '', '', 8, 0, 'Bánh tráng tỏi được xem là một "vị cứu tinh" của những tín đồ nghiện bánh tráng. Món ăn này đã làm mê đắm giới trẻ bởi phần bánh tráng dẻo thơm kết hợp cùng phần muối, tỏi rất đậm đà và tròn vị. Món ăn này dường như luôn có mặt ở khắp mọi nơi vì giá cả bình dân nhưng hương vị thì ngon vô đối.', 0, 0, 1, 43999, '2024-07-22 10:03:47', NULL),
	(103, 1, 'Bánh mì ngao đường', '/foods/1/1721642721279.webp', '', '', '', 8, 0, 'vặn nhỏ lửa và cho bánh mì vào, đảo đều tay để đường phủ đều. Sau đó, bạn chờ bánh nguội và thường thức.\r\n\r\nBánh mì ngào đường là một trong những món ăn vặt dễ làm tại nhà, thường để chế biến món ăn này bạn chỉ mất khoảng 20 phút.', 0, 0, 1, 14000, '2024-07-22 10:05:20', NULL),
	(104, 1, 'Snack chuối', '/foods/1/1721642755472.webp', '', '', '', 8, 0, '', 0, 0, 1, 43000, '2024-07-22 10:05:54', NULL),
	(105, 1, 'Snack khoai tây', '/foods/1/1721642786879.webp', '', '', '', 8, 0, 'Những món ăn vặt dễ làm tại nhà không thể thiếu snack khoai tây. Bạn có thể chế biến trong 1 lần và bảo quản trong hộp kín để thưởng thức dần.', 0, 0, 1, 43900, '2024-07-22 10:06:26', NULL),
	(106, 1, 'Bánh Oreo cuộn kem sữa', '/foods/1/1721642832021.webp', '', '', '', 8, 0, 'Bánh Oreo cuộn kem sữa với vị đắng nhẹ kết hợp nhân kem béo mịn sẽ khiến bạn thích mê, hãy bỏ túi ngay những món ăn vặt dễ làm tại nhà để thực hiện khi buồn miệng nhé.', 0, 0, 1, 43000, '2024-07-22 10:07:11', NULL),
	(107, 1, 'Khoai tây chiên nước mắm', '/foods/1/1721642871507.webp', '', '', '', 8, 0, 'Nếu bạn thích khoai tây thì có thể đổi món bằng khoai tây chiên nước mắm cùng rất ngon miệng, hấp dẫn.', 0, 0, 1, 43000, '2024-07-22 10:07:50', NULL),
	(108, 1, 'Báp xào phô mai', '/foods/1/1721642897343.webp', '', '', '', 8, 0, 'Bắp xào phô mai thơm ngon, béo ngậy mà bất kỳ ai cũng không thể cưỡng lại được. Cuối tuần của bạn sẽ tuyệt vời hơn khi cùng bạn bè thực hiện và nhâm nhi những món ăn vặt dễ làm tại nhà này đấy nhé!', 0, 0, 1, 32000, '2024-07-22 10:08:16', NULL),
	(109, 1, 'Gan gà chiên xù', '/foods/1/1721642937130.webp', '', '', '', 8, 0, 'Những món ăn vặt dễ làm tại nhà không thể không nhắc đến gan gà chiên xù. Miếng gan vàng ươm, giòn rụm kết hợp vị béo của gan sẽ rất kích thích vị giác của bạn đấy.', 0, 0, 1, 230000, '2024-07-22 10:08:56', NULL),
	(110, 1, 'Khoai mì hấp nước cốt dừa', '/foods/1/1721642969590.webp', '', '', '', 8, 0, 'Khi ăn, bạn chỉ lần lấy khoai mì ra bắt, rưới nước cốt dừa và rắc muối đậu lên. Hương vị thơm ngon, ngọt bùi của món ăn này chắc sẽ khiến bạn ăn đến no nê mới dừng lại được.', 0, 0, 1, 32000, '2024-07-22 10:09:28', NULL),
	(111, 1, 'Khoai tây nghiền', '/foods/1/1721643012726.webp', '', '', '', 8, 0, 'Khoai tây nghiền là một trong những món ăn vặt dễ làm tại nhà, có thể ăn kèm với gà rán, gà nướng hoặc soup…', 0, 0, 1, 32000, '2024-07-22 10:10:11', NULL),
	(112, 1, 'Bánh quy bơ', '/foods/1/1721643036576.webp', '', '', '', 8, 0, 'Một trong những món ăn vặt dễ làm tại nhà là món bánh quy bơ. Miếng bánh giòn tan hòa quyện hương bơ thơm phức mà bất cứ ai cũng khó có thể từ chối.', 0, 0, 1, 43000, '2024-07-22 10:10:35', NULL),
	(113, 1, 'Đậu hũ hạnh nhân', '/foods/1/1721643070397.webp', '', '', '', 8, 0, 'Đậu hũ thơm ngon, ngọt thanh, phảng phất hương quế chắc chắn bạn ăn một lần sẽ nhớ mãi. Đây là một trong những món ăn vặt dễ làm tại nhà mà vụng về đến mấy bạn cũng có thể làm được.', 0, 0, 1, 23000, '2024-07-22 10:11:09', NULL),
	(114, 1, 'Chè hạt sen', '/foods/1/1721644202985.webp', '', '', '', 8, 0, 'Chè hạt sen là món chè thường được vua chúa thời xưa thưởng thức trong các buổi yến tiệc cung đình. Theo Đông y, hạt sen là vị thuốc quý giúp dưỡng tâm an thần, ích thận, bổ tỳ và hỗ trợ điều trị bệnh mất ngủ, tiêu chảy, sốt cao…\r\n\r\n', 0, 0, 1, 43000, '2024-07-22 10:30:01', NULL),
	(115, 1, 'Chè khúc bạch', '/foods/1/1721644251716.webp', '', '', '', 8, 0, 'Chè khúc bạch từng có một thời tạo nên “sức hút mãnh liệt” theo trào lưu giới trẻ. Món chè cuốn hút thị giác với những viên khúc bạch mềm dẻo và hạt sen tròn tròn, thêm chút hạnh nhân rang đẹp mắt.', 0, 0, 1, 43000, '2024-07-22 10:30:50', NULL),
	(116, 1, 'Sương sáo', '/foods/1/1721644281273.webp', '', '', '', 8, 0, 'Nhắc đến sương sáo thì ai cũng nhớ ngay đến một món giải nhiệt có màu đen tuyền ấn tượng với hương thơm dịu nhẹ. Bạn chỉ cần cắt nhỏ sương sáo rồi rưới thêm chút đường và nước cốt dừa là đã có ngay món giải nhiệt thơm ngon rồi.', 0, 0, 1, 32000, '2024-07-22 10:31:20', NULL),
	(117, 1, 'Rau câu sơn thủy', '/foods/1/1721644333411.webp', '', '', '', 8, 0, 'Rau câu sơn thủy nghe tên đã thấy hữu tình còn vẻ ngoài thì vô cùng bắt mắt. 3 tầng màu sắc đẹp nghệ thuật với sự phối hợp giữa 3 nguyên liệu: lá dứa, cafe, sữa đặc. Hương vị thì ngọt dịu và rau câu ăn giòn giòn sần sật khá lạ miệng.', 0, 0, 1, 43000, '2024-07-22 10:32:12', NULL),
	(118, 1, 'Rau câu trái cây', '/foods/1/1721644370874.webp', '', '', '', 8, 0, 'Một trong các món tráng miệng đãi tiệc không thể thiếu trong mọi sự kiện là rau câu trái cây. Nguyên liệu là đa dạng các loại trái cây tươi ngon tự chọn như táo, cam, nho, bơ… với màu sắc phong phú vô cùng.\r\n\r\nĐặc biệt, mỗi loại rau câu sẽ mô phỏng hình dáng và hương vị đặc trưng của từng loại trái cây tương ứng. Chẳng hạn rau câu dưa hấu sẽ có hình dáng trái dưa hấu vỏ xanh ruột đỏ. Bên trong có vị ngọt mát quyện với lớp thạch sữa dừa beo béo…\r\n\r\n', 0, 0, 1, 43000, '2024-07-22 10:32:49', NULL),
	(119, 1, 'Bánh da lợn', '/foods/1/1721644395604.webp', '', '', '', 8, 0, 'Bánh da lợn là món tráng miệng trong bữa tiệc khá quen thuộc với người Việt từ trước đến nay. Bên trong là nhân đậu xanh bùi bùi còn bên ngoài là lớp bánh dai dẻo thơm mùi lá dứa, ngon khó cưỡng.', 0, 0, 1, 43000, '2024-07-22 10:33:14', NULL),
	(120, 1, 'Bánh flan', '/foods/1/1721644420071.webp', '', '', '', 8, 0, 'Bánh flan cuốn hút vị giác bởi hương trứng beo béo quyện cùng vị sốt caramel ngọt đậm đà. Bề mặt bánh flan láng mịn và mềm mại vô cùng nên trẻ em đến người già đều thưởng thức được.', 0, 0, 1, 43000, '2024-07-22 10:33:39', NULL),
	(121, 1, 'Bánh mousse', '/foods/1/1721644447269.webp', '', '', '', 8, 0, 'Mousse là một trong các loại bánh trứ danh của Pháp, hội tụ đủ hương vị từ beo béo đến chua chua, ngọt ngọt. Được yêu thích nhất là 3 vị nổi tiếng gồm chanh dây, matcha, chocolate, xoài,…', 0, 0, 1, 34000, '2024-07-22 10:34:06', NULL),
	(122, 1, 'Sữa chua trái cây', '/foods/1/1721644468989.webp', '', '', '', 8, 0, 'Trái cây chứa nhiều vitamin giúp tăng cường sức khỏe và hệ miễn dịch cơ thể. Với món sữa chua trái cây thơm ngon mát lạnh này, bạn có thể mix tùy ý các loại trái cây theo yêu cầu và sở thích của thực khách.', 0, 0, 1, 43000, '2024-07-22 10:34:27', NULL),
	(123, 1, 'Kem chanh dây', '/foods/1/1721644512970.webp', '', '', '', 8, 0, 'Kem chanh dây có màu vàng tươi bắt mắt và vị chua ngọt kích thích vị giác vô cùng. Kết thúc bữa tiệc bằng món kem này khiến thực khách cảm thấy không bị ngán mà còn giúp thanh lọc cơ thể hiệu quả.', 0, 0, 1, 39000, '2024-07-22 10:35:11', NULL),
	(124, 1, 'Kem dừa', '/foods/1/1721644539504.webp', '', '', '', 8, 0, 'Kem dừa là món ngon quen thuộc của bao đứa trẻ nên khi nhìn thấy kem dừa trên bàn tiệc sẽ gợi nhắc tuổi thơ tươi đẹp của nhiều thực khách. Làm sao quên được vị sữa dừa ngọt béo rắc vài hạt đậu phộng bùi thơm, ngon khó cưỡng!', 0, 0, 1, 43000, '2024-07-22 10:35:38', NULL),
	(125, 1, 'Bánh chuối nướng', '/foods/1/1721644617460.webp', '', '', '', 8, 0, 'Bánh chuối nướng là món bánh tráng miệng thơm ngon, nguyên liệu dễ. Món bánh tơi xốp có vị ngọt vừa phải của chuối, mùi thơm nồng nàn, rất kích thích vị giác. Bạn có thể thêm một ít socola chip để bánh ngon hơn, các em nhỏ cũng thích thú thưởng thức hơn.', 0, 0, 1, 32900, '2024-07-22 10:36:56', NULL),
	(126, 1, 'Sương sáo nước cốt dừa', '/foods/1/1721644656248.webp', '', '', '', 8, 0, 'Sương sáo nước cốt dừa là món tráng miệng thích hợp cho những buổi chiều nóng nực. Sương sáo dai dai, mềm mềm ăn kèm với nước cốt dừa béo béo, thêm vài viên đá mát lạnh sẽ giúp bạn phấn chấn tinh thần hơn hẳn sau bữa ăn.', 0, 0, 1, 34200, '2024-07-22 10:37:35', NULL),
	(127, 1, 'Cơm chiên Thập Cẩm', '/foods/1/1721645268174.webp', '', '', '', 9, 0, 'Hạt cơm chín săn, rau củ quả ngọt giòn, chả lụa dai dai, đậu hũ béo bùi và tàu hũ ky giòn giòn. Vị hài hoà vừa ăn cho một món chay hoàn hảo. Món cơm chiên chay vừa bổ dưỡng, vừa thơm ngon này nhất định sẽ là lựa chọn thú vị cho thực đơn hàng ngày của cả gia đình đây!', 0, 0, 1, 50000, '2024-07-22 10:47:47', NULL),
	(128, 1, 'Cơm chiên nấm mặn', '/foods/1/1721645301840.webp', '', '', '', 9, 0, 'Món chay ngon tuyệt cho những “tín đồ cơm chiên” đây! Cơm được ướp đều thấm vị, riêng nấm hương được ướp bột chiên giòn đậm đà, đặc biệt là sau cùng cơm còn được trộn thêm với bột rong biển khiến món ăn càng dậy mùi thơm ngon thật hấp dẫn. Đúng là một món chay vừa hấp dẫn vừa bổ dưỡng cho cả gia đình phải không nào!', 0, 0, 1, 430000, '2024-07-22 10:48:20', NULL),
	(129, 1, 'Cơm chiên thịt bò phô mai', '/foods/1/1721645336726.webp', '', '', '', 9, 0, 'Công thức làm cơm chiên ngon đáng thử cho những ai yêu thích món cơm chiên là đây nhé! Màu sắc món ăn điểm xanh đỏ rất bắt mắt và giàu dinh dưỡng, cộng thêm vị thơm ngon, đậm đà béo nhẹ từ phô mai và dưỡng chất từ thịt bò sẽ đem lại món cơm chiên độc đáo, lạ miệng và “càng ăn càng thèm”. Món ăn phù hợp cho cả người lớn và trẻ nhỏ, có thể làm bữa phụ hoặc một trong những lựa chọn cho thực đơn đãi khách.', 0, 0, 1, 430000, '2024-07-22 10:48:55', NULL),
	(130, 1, 'Cơm chiên cá mặn', '/foods/1/1721645367252.webp', '', '', '', 9, 0, 'Nếu đã là một “fan” của món cơm chiên cá mặn ở nhà hàng, thì công thức này đích thực dành cho cả nhà mình nè! Chỉ cần ngâm qua đêm cá khô, và vài phút chế biến là bạn đã có ngay những dĩa cơm chiên cá mặn giòn ngon, vàng ươm, không thua kém gì ở tiệm rồi!', 0, 0, 1, 430000, '2024-07-22 10:49:26', NULL),
	(131, 1, 'Cơm chiên Dương Châu', '/foods/1/1721645402956.webp', '', '', '', 9, 0, 'Cách làm cơm chiên dương châu “đỉnh của đỉnh”, chuẩn vị Trung Hoa mà hợp khẩu vị với người Việt đây chị em ơi! Chị em mình cần gì mua ngoài tiệm nữa, làm thử ngay tại nhà cho đã cơn thèm trong những ngày cuối tuần này nhé!', 0, 0, 1, 340000, '2024-07-22 10:50:01', NULL),
	(132, 1, 'Cơm chiên dừa', '/foods/1/1721645426881.webp', '', '', '', 9, 0, 'Bạn đã bao giờ thử món cơm chiên dừa thơm béo, bùi bùi xựt xựt rất hấp dẫn chưa? Hãy tự tay chế biến món ăn ngon này với công thức siêu đơn giản, nhanh chóng từ Món Ngon Mỗi Ngày! Món cơm chiên Malaysia chuẩn vị, thấm nước cốt dừa, thơm hương cà ri hòa cùng rau củ và các miếng dừa giòn tan này sẽ khiến cả nhà bạn trầm trồ và tấm tắc khen ngon suốt bữa ăn cho xem!', 0, 0, 1, 340000, '2024-07-22 10:50:25', NULL),
	(133, 1, 'Cơm chiên Mayonnaise', '/foods/1/1721645474415.webp', '', '', '', 9, 0, 'Bạn đã bao giờ thử món cơm chiên dừa thơm béo, bùi bùi xựt xựt rất hấp dẫn chưa? Hãy tự tay chế biến món ăn ngon này với công thức siêu đơn giản, nhanh chóng từ Món Ngon Mỗi Ngày! Món cơm chiên Malaysia chuẩn vị, thấm nước cốt dừa, thơm hương cà ri hòa cùng rau củ và các miếng dừa giòn tan này sẽ khiến cả nhà bạn trầm trồ và tấm tắc khen ngon suốt bữa ăn cho xem!', 0, 0, 1, 43000, '2024-07-22 10:51:13', NULL),
	(134, 1, 'Cơm chiên trứng cá', '/foods/1/1721645495893.webp', '', '', '', 9, 0, 'Thơm vị đặc trưng của cơm chiên tỏi, đẹp mắt với điểm xuyết màu vàng của trứng và rau dưa ăn kèm, vị beo béo giòn giòn mà không ngán chút nào. Đổi khẩu vị món cơm chiên thông thường thay bằng Cơm chiên trứng cá là sáng kiến không tệ chút nào!', 0, 0, 1, 433220, '2024-07-22 10:51:34', '2024-07-22 10:51:54'),
	(135, 1, 'Cơm chiên trái thơm', '/foods/1/1721645548406.webp', '', '', '', 9, 0, 'Mang phong cách trình bày hết sức ấn tượng, nhìn thì có vẻ phức tạp nhưng cách làm món cơm chiên trái thơm này không hề khó chút nào đâu nè! Sự kết hợp giữa hương vị tôm và trái cây tạo vị chua nhẹ, vừa dễ ăn vừa dễ làm, phù hợp chế biến cho thực đơn vào các dịp tiệc trang trọng.', 0, 0, 1, 330000, '2024-07-22 10:52:27', NULL),
	(136, 1, 'Cơm chiên trái cây', '/foods/1/1721645580143.webp', '', '', '', 9, 0, 'Kết hợp trái cây với cơm tưởng không ngon mà ngon không tưởng luôn đó cả nhà ơi! Không chỉ có thể tận dụng được hết nguyên liệu sẵn có trong tủ lạnh, mà cả nhà còn có ngay một món ăn bổ dưỡng, mới lạ, hấp dẫn về màu sắc, hương vị nữa đó!', 0, 0, 1, 43334, '2024-07-22 10:52:59', NULL),
	(137, 1, 'Cơm chiên cá mặn chay', '/foods/1/1721645630381.webp', '', '', '', 9, 0, 'Dĩa cơm chiên nhiều màu sắc và dinh dưỡng với ớt chuông xanh đỏ, bắp hạt vàng ươm nhìn thật bắt mắt; cho vào miệng một miếng thì cảm nhận được hương vị boarô phi thơm lừng, bắp hạt ngọt giòn, cơm thì dẻo bùi, đặc biệt là vị cá mặn chay thơm thơm ghiền ghiền đó!', 0, 0, 1, 320000, '2024-07-22 10:53:49', NULL),
	(138, 1, 'Cơm chiên chay', '/foods/1/1721645655291.webp', '', '', '', 9, 1, 'Nếu chị em muốn tìm công thức làm món cơm chiên chay truyện thống thì phải chọn ngay món này nhé! Với sự kết hợp với rất nhiều loại rau củ giúp cả nhà dễ dàng thay đổi khẩu vị, bên cạnh đó còn tận dụng được hết các nguyên liệu dư nữa nè!', 0, 0, 1, 430000, '2024-07-22 10:54:14', '2024-07-23 07:28:30'),
	(139, 1, 'Cơm gạo lức chiên nghêu', '/foods/1/1721645698401.webp', '', '', '', 9, 0, 'Gạo lức tốt cho sức khỏe vì có nhiều chất dinh dưỡng. Tuy nhiên, không phải ai cũng biết cách chế biến để cơm gạo lức dễ ăn hơn. Thay vì chiên cơm trắng như ngày thường, chị em còn có thể biến tấu bằng cách làm món Cơm Gạo Lức thơm ngon và rất dễ ăn này nữa nè!', 0, 0, 1, 43000, '2024-07-22 10:54:57', NULL),
	(140, 1, 'Cơm sen cốm', '/foods/1/1721645727396.webp', '', '', '', 9, 1, 'Cơm sen cốm là món cơm chiên chay mới lạ, nhiều dinh dưỡng mà nhất định chị em phải thử. Với có sự kết hợp thanh đạm của sen và cốm, chắc chắn sẽ trở thành 1 món ngon thích hợp cho cả nhà thuộc “fan” món cơm chiên.', 0, 0, 1, 430000, '2024-07-22 10:55:26', '2024-07-23 07:28:30'),
	(141, 1, 'Cơm hoàng bào', '/foods/1/1721645757336.webp', '', '', '', 9, 0, 'Cơm Hoàng bào là món ăn truyền thống với hình thức bắt mắt và hương vị thơm ngon bắt nguồn từ trong cung đình khi xưa. Nhìn bên ngoài tuy cầu kì nhưng cách làm món ăn lại đơn giản; dùng món này để thay đổi khẩu vị trong các bữa ăn hằng ngày của gia đình hay trong các đám tiệc đều rất hợp lý nhé!', 0, 0, 1, 43000, '2024-07-22 10:55:56', NULL),
	(142, 1, 'Cơm trân châu', '/foods/1/1721645784582.webp', '', '', '', 9, 0, 'Dựa trên công thức món sushi Nhật nhưng có cải tiến đôi chút cho phù hợp với khẩu vị của người Việt hơn. Đây là món ăn ngon, dễ chế biến và đảm bảo dinh dưỡng cho các em nhỏ trong dịp cuối tuần nè!', 0, 0, 1, 430000, '2024-07-22 10:56:23', NULL),
	(143, 1, 'Cơm chanh Ấn Độ', '/foods/1/1721645811748.webp', '', '', '', 9, 0, 'Các món ăn Ấn Độ luôn có nhiều gia vị siêu hấp dẫn, nhưng không phải dễ để tìm một công thức “chuẩn vị” đâu nha. Để Món Ngon Mỗi Ngày hướng dẫn bạn cách làm món Cơm chiên kiểu Ấn Độ vừa dễ, mà vừa ngon đúng vị nhé!', 0, 0, 1, 43000, '2024-07-22 10:56:50', NULL),
	(144, 1, 'Cơm rau củ nấm hương', '/foods/1/1721645845433.webp', '', '', '', 9, 1, 'Chị em đang muốn làm món cơm chiên ít dầu mỡ và giàu dinh dưỡng từ rau củ thì phải thử ngày cơm rau củ nấm hương nhá! Đĩa cơm chiên thơm lừng, hạt cơm săn chắc, đượm mùi nấm hương, hòa đều rau củ xanh xanh, đỏ đỏ, vừa giòn ngon vừa bắt mắt. Ngon quá cả nhà ơi!', 0, 0, 1, 342000, '2024-07-22 10:57:24', '2024-07-23 07:28:30'),
	(145, 1, 'Cơm gà', '/foods/1/1721645883218.webp', '', '', '', 9, 0, 'Ai từng đến Hội An hẳn sẽ thích món cơm gà nổi tiếng. Sao bạn không thử biến căn bếp nhà mình thành một góc nhỏ của Hội An bằng cách chiêu đãi cả nhà mỗi người một dĩa Cơm Gà tự làm siêu “xịn xò” này nhỉ? Với lớp cơm thơm ngon, lớp thịt gà xé giòn ngọt, hòa quyện cùng rau răm, hành phi. Chắc chắn “bà chủ” sẽ có nhiều “khách ruột” đó!', 0, 0, 1, 39020, '2024-07-22 10:58:02', NULL),
	(146, 1, 'Mì Udon', '/foods/1/1721646349526.webp', '', '', '', 13, 0, 'Mì Udon, Nhật Bản: Mỗi vùng của Nhật Bản lại có một cách chế biến mì Udon riêng. Sợi mì khá dày, được làm từ bột mì. Loại nước dùng điển hình nhất là kakejiru, với vị nhạt, làm từ nước dashi, xì dầu và rượu nấu ăn mirin. ', 0, 0, 1, 43000, '2024-07-22 11:05:48', NULL),
	(147, 1, 'Mì kéo tay ', '/foods/1/1721646371284.webp', '', '', '', 13, 0, 'Mì kéo tay, Trung Quốc: Để làm được một bát mì kéo tay ngon, đầu bếp phải chú ý tới sự cân bằng của bột, nước và các nguyên tố bên ngoài như độ ẩm không khí, nếu không sẽ làm mất độ đàn hồi nổi tiếng của sợi mì. Mì thường được chan nước dùng bò, thêm thịt và rau. ', 0, 0, 1, 43333, '2024-07-22 11:06:10', NULL),
	(148, 1, 'Mì thái', '/foods/1/1721646393400.webp', '', '', '', 13, 0, 'Mì thái, Trung Quốc: Đặc sản của tỉnh Sơn Tây được làm từ một khối bột đã nhào (bột mì hoặc bột gạo). Đầu bếp sẽ dùng một loại dao đặc biệt để thái bột thẳng vào nước sôi. Người làm cần thật nhanh tay để mì chín đều. Mì được ăn cùng một nước dùng bò cay, hoặc xào với các nguyên liệu khác.', 0, 0, 1, 34000, '2024-07-22 11:06:32', NULL),
	(149, 1, 'Mì khoai lang', '/foods/1/1721646414657.webp', '', '', '', 13, 0, 'Mì khoai lang, Hàn Quốc: Loại mì này được làm từ tinh bột khoai lang, thường dùng làm món mì xào Japchae của Hàn Quốc. Mì được xào cùng dầu vừng, thêm rau củ, thịt bò, nêm xì dầu và đường tùy khẩu vị.', 0, 0, 1, 34000, '2024-07-22 11:06:53', NULL),
	(150, 1, 'Mì Soba', '/foods/1/1721646442653.webp', '', '', '', 13, 0, 'Mì soba, Nhật Bản: Món ăn này nổi bật giữa các loại mì của Nhật Bản vì được làm từ bột kiều mạch cán mỏng, sau đó xắt thành sợi mảnh. Mì soba thường được ăn lạnh, cùng với một loại nước chấm làm từ dashi và đậu nành, có thể thêm đậu phụ, trứng hay tempura.', 0, 0, 1, 34000, '2024-07-22 11:07:21', NULL),
	(151, 1, 'Mì rau cải bó xôi', '/foods/1/1721646501185.webp', '', '', '', 13, 0, 'Món mì này không chỉ bổ dưỡng mà còn hấp dẫn bởi màu sắc đẹp mắt của sợi mì. Để có những sợi mì xanh, người bán nhào bột mì với nước ép rau cải trước khi kéo. Món mì rau cải này được coi là món ăn giàu dưỡng chất và có lợi cho những người bị cholesterol cao hay bị huyết áp cao. Một trong những quán ăn bán món ăn ngon tuyệt này là tiệm mì Kun Kun Bo Cai Mian, mì ở đây rất tươi ngon và bọn có thể thêm các loại rau với giá chỉ một vài tệ.', 0, 0, 1, 43000, '2024-07-22 11:08:19', NULL),
	(152, 1, 'Mì ba hương vị', '/foods/1/1721646710198.webp', '/foods/1/1721646710214.webp', '', '', 13, 0, 'Đây là một món mì vô cùng độc đáo và bạn chỉ có thể tìm thấy nó ở một nhà hàng duy nhất ở  Tây An tên là Tam Nguyên Lão Hoàng Gia . Cùng một to mỳ nhưng bạn có thể thưởng thức nó theo 3 cách khác nhau. Cách thứ nhất là bạn trộn mì sốt thịt. và cả nước súp canh. Mỗi cách ăn đều ngon và có những điểm thú vị riêng.', 0, 0, 1, 430000, '2024-07-22 11:11:48', NULL),
	(153, 1, 'Mì kéo Lan Châu', '/foods/1/1721646939346.webp', '', '', '', 13, 0, 'Mặc dù kiểu ăn này có bán ở nhiều tỉnh thành trên cả Trung Quốc nhưng món mì kéo Lan Châu được bán ở Tây An luôn có một sức hấp dẫn kì lạ. Loại mì này được kéo bằng tay, dày và dai. Món ăn khi ăn sẽ được chan nước dùng, thêm ớt và mè. Không chỉ ngon mà được chứng kiến cảnh kéo mì trong lúc chờ ăn cũng rát thú vị. Một gơiqj ý để thưởng thức món ăn này là quán Hai De Niu Rou Mian', 20, 1, 1, 43000, '2024-07-22 11:15:38', NULL),
	(154, 1, 'Mì thịt dê', '/foods/1/1721647118972.webp', '', '', '', 13, 0, 'Nhiều người cho rằng món mì thịt dê có hương vị mạnh, chủ yếu là do phần thị dê khá gây nên khó có thể thích món ăn này. Tuy nhiên nếu đã có lần thử món mì này ở Tay An, bạn có thể sẽ phải thay đổi suy nghĩ của mình. Mỗi bát mì là sự kết hợp tuyệt vờ của những sợi mì giòn dai cùng phẩn nước sụp thịt béo, ngọt và thơm cùng những loại gia vị khó quên', 0, 0, 1, 34000, '2024-07-22 11:18:37', NULL),
	(155, 1, 'Mì Tonkotsu Ramen', '/foods/1/1721647487573.webp', '', '', '', 13, 0, ' Nước dùng chủ yếu được làm từ xương và mỡ heo hầm trong nhiều tiếng đồng hồ, nên nước thường và có màu trắng nhạt. Loại nước dùng này mang vị ngọt dịu từ xương heo và béo ngậy từ mỡ. Sợi mì ăn với laoị ramen này thường là loại nhỏ để dễ dàng cảm nhận được hết vị ngon của mì và nước dùng. Món ăn kèm thường là thịt heo, gừng muối chua, trứng luộc lòng đào, hành lá rong biển và một só loại rau củ khác.', 0, 0, 1, 34000, '2024-07-22 11:24:46', NULL),
	(156, 1, 'Mì miso ramen', '/foods/1/1721647678764.webp', '', '', '', 13, 0, 'Miso là một loại sốt đậu nhành lên men. Miso Ramen thường được hầm sốt miso với thịt gà và cá để tạo ra vị ngọt nhẹ và hương thơm hấp dẫn. SỌi mì ăn chung với nước dfùng với nước dùng này lại loại xoán và dày, được ăn kèm với trứng luộc lòng đào, thịt xá xíu và chả cá', 0, 0, 1, 43000, '2024-07-22 11:27:57', NULL),
	(157, 1, 'Mì Shoyu Ramen', '/foods/1/1721648057664.webp', '', '', '', 13, 0, 'Thành phần chính của loại nước dùng này là xì dầu, nấu chung với thị và rau củ để tạo được vị ngọt từ thịt và hương thơm của đậu nhành. Tuy nhiên, loại nước dùng này khá đậm, có thể sẽ khó ắn đối với những ai quen ăn nhạt. Sợi mì ăn với loại này thường là sợi nhỏ để nước dùng dễ thấm vào mì. Loại mì này thường ăn kèm măng khô, chả cá, rong biển, thịt xá xíu và trứng luộc lòng đào.', 0, 0, 1, 43000, '2024-07-22 11:34:16', NULL),
	(158, 1, 'Mì Soba Trà Xanh', '/foods/1/1721703509550.webp', '', '', '', 13, 0, 'Mì Soba Trà Xanh (Cha Soba) được làm từ hạt kiều mạch pha thêm bột matcha độc đáo, chính vì thế tạo nên màu sắc xanh lá tươi mát cũng như tăng thêm hương vị hấp dẫn cho mì. Dưới đôi bàn tay của những người nghệ nhân nơi bếp lửa, mì Soba kết hợp trà xanh hơn cả một món mì Nhật Bản thơm ngon mà còn mang theo đó là những công dụng tuyệt vời giúp chống lão hóa và bồi bổ sức khỏe. Bên cạnh đó, mì Soba còn được xem là biểu tượng cho sự may mắn. Người Nhật sẽ thường ăn mì này vào cuối năm với ý nghĩa tiễn năm cũ, đón một năm mới đầy may mắn và sức khỏe. ', 0, 0, 1, 32000, '2024-07-23 02:58:29', NULL),
	(159, 1, 'Ramen Chanh', '/foods/1/1721705119132.webp', '', '', '', 13, 0, 'Ussina\r\nTản mạn\r\nẨm thực Nhật Bản\r\nmì nhật bản\r\nmì soba\r\nnhà hàng Nhật\r\nKhám Phá Các Loại Mì Nhật Bản Độc Đáo Mà Bạn Không Nên Bỏ Lỡ\r\n\r\nTop Món Ăn Tăng Đề Kháng Được Người Nhật Ưa Chuộng\r\nNgười Nhật Bản Ăn Rau Củ Gì Để Bồi Bổ Sức Khỏe Vào Mùa Xuân?\r\nNhật Bản – Xứ sở hoa anh đào luôn được giới đầu bếp đánh giá cao nền ẩm thực phong phú, trong đó nổi tiếng với sự đa dạng các loại mì được làm bởi đôi bàn tay của những người nghệ nhân lành nghề. Bất kỳ ai đến đây du lịch đều không thể bỏ qua các món mì Nhật Bản. Cùng Ussina khám phá các loại mì Nhật Bản độc đáo mà bạn không nên bỏ lỡ nhé!\r\n\r\n1. Soba Trà Xanh – Món mì Nhật Bản mát lành\r\nMì Soba Trà Xanh (Cha Soba) được làm từ hạt kiều mạch pha thêm bột matcha độc đáo, chính vì thế tạo nên màu sắc xanh lá tươi mát cũng như tăng thêm hương vị hấp dẫn cho mì. Dưới đôi bàn tay của những người nghệ nhân nơi bếp lửa, mì Soba kết hợp trà xanh hơn cả một món mì Nhật Bản thơm ngon mà còn mang theo đó là những công dụng tuyệt vời giúp chống lão hóa và bồi bổ sức khỏe. Bên cạnh đó, mì Soba còn được xem là biểu tượng cho sự may mắn. Người Nhật sẽ thường ăn mì này vào cuối năm với ý nghĩa tiễn năm cũ, đón một năm mới đầy may mắn và sức khỏe. \r\n\r\nBạn có thể thưởng thức được món mì Soba Trà Xanh mát lành này khi đến Ussina Sky 77. Cha Soba nằm trong menu Afternoon Tea Set – sự kết hợp đặc biệt với phong cách thưởng thức trà chiều mang đến nhiều tầng hương vị khác biệt. Sợi mì tươi ăn kèm nước dùng Dashi thanh mát tạo nên một phần hương vị độc đáo không thể thiếu cho set trà chiều.\r\n\r\nSoba Trà Xanh - Món mì Nhật Bản mát lành\r\nSoba Trà Xanh – Món mì Nhật Bản mát lành\r\n2. Ramen Chanh – Loại mì độc đáo của người Nhật\r\nNhắc đến ẩm thực Nhật Bản, chắc chắn không thể thiếu mì Ramen trong danh sách với sự đa dạng về hương vị.\r\n\r\nMì Ramen Nhật Bản được biết đến từ năm 1910 tại nhà hàng Rairaten, bắt nguồn với mục đích bán cho tầng lớp lao động. Nhưng nhờ hương vị độc đáo mà Ramen ngày càng phổ biến và được biến tấu thành nhiều phiên bản khác nhau, tùy vào mỗi vùng và khẩu vị địa phương.', 0, 0, 1, 40000, '2024-07-23 03:25:19', NULL),
	(160, 1, 'Ramen Cas Ayu', '/foods/1/1721705150365.webp', '', '', '', 13, 0, 'Ayu còn được gọi là cá Hương Nhật Bản, sống ở môi trường nước ngọt, rất được ưa chuộng trong ẩm thực Nhật. \r\n\r\nAyu khô nướng thường được sử dụng để làm nguyên liệu cho món Dashi chất lượng trong ẩm thực Nhật Bản. Nhưng với mì Ramen Cá Ayu, món ăn là sự kết hợp của mì Ramen với nước dùng cá kho nhẹ nhàng, thanh mát, ăn kèm topping là cá Ayu được nướng khô tạo nên hương vị đậm đà, làm phong phú hơn cho món mì Ramen – món ăn nổi tiếng Nhật Bản.', 0, 0, 1, 40000, '2024-07-23 03:25:50', NULL),
	(161, 1, 'Nagashi Somen', '/foods/1/1721705178982.webp', '', '', '', 13, 0, 'Nagashi Somen hay còn được gọi với cái tên gần gũi hơn là mì ống trúc, được đánh giá là món mì độc đáo và công phu của người Nhật. Món mì này được phục vụ trên một hệ thống ống trúc dài, theo dòng chảy của nước lạnh, món mì sẽ trôi trên ống trúc và các thực khách sẽ ngồi tại bàn và đón mì trôi đến, sau đó sẽ nhanh tay gắp cho mình những phần mì Somen mát lạnh. \r\n\r\nKhông ngoa khi nói Nagashi Somen là món ăn được yêu thích nhất, là món ăn tinh thần giải nhiệt mùa hè cực kì tốt, bởi đây là món mì phục vụ bằng nước lạnh, thưởng thức cùng chén sốt Tsuyu có vị nhạt, thanh đạm ngay tại chỗ.', 0, 0, 1, 40000, '2024-07-23 03:26:19', NULL),
	(162, 1, 'Shirataki', '/foods/1/1721705215541.webp', '', '', '', 13, 0, 'Không chỉ là ẩm thực đa dạng phong phú, người Nhật còn tinh tế khi chế biến các món ăn với thành phần tốt cho sức khỏe. Trong đó có thể kế đến Mì Shirataki với hàm lượng calo thấp, được nhiều người lựa chọn cho thực đơn giảm cân.', 0, 0, 1, 40000, '2024-07-23 03:26:55', NULL),
	(163, 1, 'Salad Mực', '/foods/1/1721705324902.webp', '', '', '', 14, 0, 'Salad mực với cách chế biến đơn giản nhưng lại mang đến hương vị tuyệt vời và thanh mát vô cùng, màu sắc bắt mắt, thêm mùi thơm thoang thoảng từ mè rang, rau củ giòn ngọt quyện cùng độ giòn tan từ mực chiên thật là hấp dẫn. Salad khi ăn, bạn rưới 1 ít nước sốt lên sẽ tạo vị chua hài hòa, giúp tăng thêm hương vị cho món salad của chúng ta.', 0, 0, 1, 40000, '2024-07-23 03:28:45', NULL),
	(164, 1, 'Salad sò điệp', '/foods/1/1721705364397.webp', '', '', '', 14, 0, 'Thêm vào thực đơn món salad sò điệp cực hấp dẫn, thơm ngon và đầy đủ dinh dưỡng để bữa ăn không còn nhàm chán. Một món ăn độc lạ với sự kết hợp độc đáo từ các loại hải sản và rau củ tươi mát vô cùng.\r\n\r\nKhi ăn vào sẽ cảm nhận được mùi vị tươi ngon của sò điệp, từ từ vị cay nhè nhẹ của ớt và vị chua thanh thanh của cà chua sẽ tan trên đầu lưỡi. Món salad này không chỉ làm thỏa mãn vị giác mà còn rất đẹp mắt với màu đỏ xanh xen lẫn vào nhau.', 0, 0, 1, 40000, '2024-07-23 03:29:24', NULL),
	(165, 1, 'Salad cá hồi', '/foods/1/1721705388336.webp', '', '', '', 14, 0, 'Cá hồi là nguyên liệu vô cùng thơm ngon và cung cấp nhiều dưỡng chất cho cơ thể.\r\n\r\nSalad cá hồi được nhiều người yêu thích bởi thịt cá mềm thơm và thấm đậm gia vị. Xà lách thanh mát và các loại rau củ khác vừa tạo màu sắc vừa tạo độ giòn ngọt cho món ăn. Sự kết hợp tuyệt vời của sữa chua và sốt mayonnaise giúp cho vị giác của bạn phải trầm trồ.', 0, 0, 1, 40000, '2024-07-23 03:29:48', NULL),
	(166, 1, 'Salad thịt bò', '/foods/1/1721705411850.webp', '', '', '', 14, 0, 'Salad thịt bò có rau củ tươi giòn, ngọt thanh, thịt bò chín vừa mềm và ngọt vị hòa quyện cùng nước sốt chua ngọt thơm ngon, bổ dưỡng. Một món salad vừa có chất xơ, vitamin và cả chất đạm thì thật hoàn hảo cho một bữa ăn nhẹ.', 0, 0, 1, 40000, '2024-07-23 03:30:12', NULL),
	(167, 1, 'Salad ức gà', '/foods/1/1721705509232.webp', '', '', '', 14, 0, 'Ức gà được biết đến như một loại thực phẩm giàu protein tốt cho cơ thể, salad ức gà sẽ là lựa chọn hoàn hảo khi bạn đang muốn tăng cơ, giảm mỡ. Món salad được kết hợp từ nhiều loại rau củ bổ dưỡng, ăn cùng ức gà chiên sốt Nhật mềm đậm vị.\r\n\r\nỨc gà vàng ươm với lớp ngoài thấm vị beo béo từ sốt mè rang, bên trong vẫn giữ được vị ngọt của thịt gà, xà lách và cà chua khiến cho màu sắc món ăn trở nên hấp dẫn hơn rất nhiều, cùng với vị mát lành từ rau củ và một chút cay cay của hành tây. Đây sẽ là món salad không những thơm ngon mà còn đẹp da, giữ dáng.', 0, 0, 1, 40000, '2024-07-23 03:31:49', NULL),
	(168, 1, 'Cobb Salad', '/foods/1/1721705544847.webp', '', '', '', 14, 0, 'Cobb salad là món ăn nổi tiếng và khá phổ biến hiện nay. Cobb salad là món ăn giàu dinh dưỡng lại thơm ngon và dễ ăn.\r\n\r\nĐây là sự hòa quyện của vị béo từ trứng gà và bơ cùng với vị chua từ giấm táo và cà, ngon khó cưỡng khi có cả thịt ba rọi và thịt gà được chiên vàng ươm, ăn vào sẽ cảm nhận được vị cay nồng từ hành tím và mù tạc, đảm bảo vị giác sẽ được kích thích vô cùng.\r\n\r\nMón salad này rất thích hợp với những bạn đang muốn giảm cân, giữ vóc dáng cân đối. Bạn có thể thêm món salad này vào bữa ăn gia đình để thực đơn trở nên phong phú hơn.', 0, 0, 1, 40000, '2024-07-23 03:32:25', NULL),
	(169, 1, 'Salad rau bina', '/foods/1/1721705647942.webp', '', '', '', 14, 0, 'Rau bina hay còn được gọi là cải bó xôi là một loại rau nổi tiếng với nhiều lợi ích tốt cho cơ thể. Món salad rau bina với cách làm đơn giản nhưng lại vô cùng dinh dưỡng.\r\n\r\nVới sự hoà quyện từ các nguyên liệu như rau bina, dâu tây, hạnh nhân và phô mai làm cho món ăn vừa có vị thanh mát từ rau, pha một chút chua chua ngọt ngọt của dâu tây, lẫn vào đó là vị béo từ phô mai và các hạt mè rang, chắc chắn sẽ làm thỏa mãn vị giác của người ăn.', 0, 0, 1, 40000, '2024-07-23 03:34:08', NULL),
	(170, 1, 'Salad cầu vồng', '/foods/1/1721705714904.webp', '', '', '', 14, 0, 'Yêu thích rau củ và những món ăn có vẻ ngoài bắt mắt thì hãy thử món salad cầu vồng. Sự hòa trộn của ức gà mềm ngon cùng với vị thanh ngọt từ nhiều loại rau củ như cà rốt, ngô, dưa leo... hòa quyện.\r\n\r\nVới hương vị nước sốt đậm đà mang đến cho bạn một món salad vừa bắt mắt, vừa thơm ngon, ăn đến đâu cũng thấy mùi vị khác lạ khó có thể ngán được.', 0, 0, 1, 40000, '2024-07-23 03:35:15', NULL),
	(171, 1, 'Salad rong nho', '/foods/1/1721705737033.webp', '', '', '', 14, 0, 'Món salad rong nho ngon mê ly nhìn thôi đã thấy muốn ăn thử một miếng, rong nho tươi mát, ăn đến đâu giòn tan đến đó, kết hợp với nhiều màu sắc của rau củ thấm vị béo của mè rang, vị chua ngọt của sốt giấm ngon khó cưỡng, ớt chuông không quá cay mà còn làm tăng thêm hương vị cho món ăn càng hấp dẫn, càng ăn càng mê.', 0, 0, 1, 40000, '2024-07-23 03:35:37', NULL),
	(172, 1, 'Salad ớt chuông', '/foods/1/1721705777785.webp', '', '', '', 14, 0, 'Ớt chuông được biết đến như một loại rau củ tốt cho da và sức khỏe, đặc khi chế biến thành món salad chẳng những giữ được mùi vị đặc trưng, khi quyện cùng các loại sốt và rau củ khác càng tăng thêm hương vị.\r\n\r\nỚt chuông và hành tây thơm nồng, chỉ cay nhè nhẹ kết hợp với vị ngọt tươi ngon của thịt tôm và ức gà thấm các gia vị và nước sốt salad chắc chắn sẽ làm bùng nổ vị giác của cả gia đình.', 0, 0, 1, 40000, '2024-07-23 03:36:18', NULL),
	(173, 1, 'Salad trái cây', '/foods/1/1721705802759.webp', '', '', '', 14, 1, 'Salad trái cây không chỉ dễ ăn mà còn bổ sung lượng vitamin đáng kể cũng như các khoáng chất cần thiết khác cho cơ thể. Chỉ với vài bước đơn giản là bạn đã thực hiện xong salad trái cây ngon tuyệt.\r\n\r\nTrái cây có vị chua chua ngọt ngọt sẽ kích thích vị giác tột độ, rắc một ít phô mai Feta cho món ăn trở nên thơm béo hơn hay có thể kết hợp cùng sữa chua, sau đó cho vào ngăn mát tủ lạnh 30 phút, bạn sẽ có một tô salad trái cây ngon tuyệt vời.\r\n\r\n', 0, 0, 1, 40000, '2024-07-23 03:36:43', '2024-07-23 07:28:30'),
	(174, 1, 'Salad hoa quả họ Berry', '/foods/1/1721705852855.webp', '', '', '', 14, 1, 'Salad hoa quả vừa ngon vừa giúp giảm cân và thanh lọc cơ thể. Salad hoa quả họ Berry chứa rất nhiều các vitamin thiết yếu như vitamin A, C, E,.. giúp đẹp da, giữ dáng đồng thời cung cấp chất xơ cho cơ thể cùng với vị chua chua ngọt ngọt ngon tuyệt từ những quả mọng mang lại.\r\n\r\nSalad trái cây có thể kết hợp với sữa chua hoặc nước cốt chanh và mật ong, món salad này chính là tổng hòa giữa vị chua chua của dâu tây và việt quất, mùi thơm của mận, vị ngọt của nho đen và độ mọng nước từ dưa hấu. Ăn đến đâu thích đến đấy, chỉ cần nhìn màu sắc đã không thể chối từ.', 0, 0, 1, 40000, '2024-07-23 03:37:33', '2024-07-23 07:28:30'),
	(175, 1, 'Salad dưa lưới', '/foods/1/1721705899930.webp', '', '', '', 14, 1, 'Dưa lưới là loại trái cây thanh mát, chứa nhiều vitamin và dưỡng chất tốt cho sức khỏe thì salad dưa lưới chính là lựa chọn tuyệt vời.\r\n\r\nVới mùi thơm nức mũi, chỉ cần cắn vào là sự mọng nước từ dưa lưới sẽ tan ra trên đầu lưỡi, cùng các loại trái cây giòn ngọt và vị cay nhẹ của lá bạc hà không chỉ đem lại dinh dưỡng mà còn cho bữa ăn thêm phong phú hơn.', 0, 0, 1, 40000, '2024-07-23 03:38:20', '2024-07-23 07:28:30'),
	(176, 1, 'Salad đào', '/foods/1/1721705929144.webp', '', '', '', 14, 1, 'Salad đào với cách làm đơn giản nhưng thành phẩm cực kì đáng mong đợi. Vị chua ngọt và mùi thơm đặc trưng của đào nướng kết hợp với độ mềm, ngọt của thịt ức gà, vị đậm đà của nước sốt và tươi mát của rau - một sự kết hợp không thể hoàn hảo hơn.\r\n\r\nMón salad đào nướng rất thích hợp để dùng cho người đang ăn kiêng, đang giảm cân đấy!', 0, 0, 1, 40000, '2024-07-23 03:38:49', '2024-07-23 07:28:30'),
	(177, 1, 'Salad quýt', '/foods/1/1721706002130.webp', '', '', '', 14, 1, 'Quýt không chỉ được ăn theo cách thông thường mà có thể chế biến thành salad rất thơm ngon, lạ miệng đấy! Với cách làm đơn giản và nhanh gọn, món ăn có màu sắc bắt mắt của những múi quýt kết hợp cùng xanh mát của bơ và rau củ.\r\n\r\nQuýt chua chua ngọt ngọt kết hợp với vị bùi béo của bơ vô cùng lạ miệng, các loại rau thấm nhẹ gia vị từ mật ong, giấm và dầu oliu tạo thành món ăn vô cùng đặc sắc với nhiều chất xơ và vitamin tốt cho cơ thể.', 0, 0, 1, 40000, '2024-07-23 03:40:02', '2024-07-23 07:28:30'),
	(178, 1, 'Salad bơ', '/foods/1/1721706023513.webp', '', '', '', 14, 1, 'Bơ được biết đến như loại trái cây tốt cho sức khỏe và cả sắc đẹp. Không có lý do gì lại không kết hợp bơ với các loại rau củ khác để tạo nên món salad vừa lạ miệng, thơm ngon lại cung cấp cho các thể những dưỡng chất thiếu yếu giúp dưỡng da, giữ dáng hiệu quả.\r\n\r\nSalad bơ là sự kết hợp giữa nước sốt dứa tươi mát cùng với vị béo bùi của bơ, dứa nướng thơm lừng vẫn còn giữ được nước, thịt bò đậm vị sẽ tạo nên sức hấp dẫn khó cưỡng cho món salad thơm ngon này.', 0, 0, 1, 40000, '2024-07-23 03:40:23', '2024-07-23 07:28:30'),
	(179, 1, 'Salad kiwi', '/foods/1/1721706052019.webp', '', '', '', 14, 1, 'Kiwi vốn dĩ đã chứa nhiều công dụng tốt cho sức khỏe, khi kết hợp với các loại rau củ để tạo thành món salad kiwi lại càng thêm bổ dưỡng. Chỉ cần vài thao tác đơn giản, bạn đã chế biến xong món salad kiwi ngon lành giúp giảm cân với màu sắc hấp dẫn nhìn là mê ngay.\r\n\r\nKiwi chua chua ngọt ngọt kết hợp với sốt mayonaise sẽ làm tăng thêm phần béo đậm đà khiến món salad trở nên độc đáo hơn, nếu không thích vị béo hãy thử kết hợp với sốt cam chanh mật ong, vừa thơm mùi cam, ngọt thanh từ mật ong quyện với các loại trái cây, đảm bảo vô cùng đặc sắc.', 0, 0, 1, 40000, '2024-07-23 03:40:52', '2024-07-23 07:28:30'),
	(180, 1, 'Salad dưa hấu', '/foods/1/1721706087116.webp', '', '', '', 14, 1, 'Dưa hấu chứa nhiều vitamin có lợi cho sức khỏe và giúp giải nhiệt trong những ngày hè rất tốt, thử ngay món salad dưa hấu với vị ngọt thanh, mọng nước của dưa hấu kết hợp với sự thanh mát nhiều loại rau củ, xen lẫn với một tí mùi cay nồng từ tiêu và hành tây, đây hứa hẹn sẽ là một món cực thích hợp cho những ngày nóng bức đấy!', 0, 0, 1, 40000, '2024-07-23 03:41:27', '2024-07-23 07:28:30'),
	(181, 1, 'Greek salad', '/foods/1/1721706130525.webp', '', '', '', 14, 1, 'Greek salad chính là lựa chọn tuyệt vời đối với các bạn đang muốn "tăng cơ, giảm mỡ" bởi hàm lượng đạm trong Greek salad khá thấp nên đây là món ăn rất thích hợp để hỗ trợ cải thiện vóc dáng.\r\n\r\nXà lách thấm vị thơm từ dầu oliu và vị chua của giấm, dưa leo và hành tây giòn có chút hăng nhẹ, chút cay nồng từ ớt chuông được trung hòa bởi vị thơm béo từ phô mai Feta. Tất cả tạo nên một món salad vừa đẹp mắt vừa dinh dưỡng.', 0, 0, 1, 40000, '2024-07-23 03:42:10', '2024-07-23 07:28:30'),
	(182, 1, 'Salad  cam đậu đỏ', '/foods/1/1721706201580.webp', '', '', '', 14, 1, 'Thêm một cách chế biến món salad nữa mà bạn không thể bỏ qua đó là salad cam đậu đỏ. Món ăn này độc đáo bởi sự kết hợp của các nguyên liệu như lòng đỏ trứng, húng lũi, giá sống, thịt nguội,... đặc biệt là đậu đỏ, đậu bi Hà Lan, đậu cove và cam vàng. Tất cả nguyên liệu hòa quyện cùng nước sốt mayonnaise beo béo ngon miệng.', 0, 0, 1, 40000, '2024-07-23 03:43:21', '2024-07-23 07:28:30');

-- Dumping structure for table menu_db.orders
DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint unsigned NOT NULL,
  `status` enum('new','processing','completed','cancel') COLLATE utf8mb4_general_ci DEFAULT 'new',
  `total_price` float DEFAULT NULL,
  `table_id` bigint NOT NULL,
  `payed_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `FK_order_table` (`table_id`),
  KEY `status` (`status`,`created_at`) USING BTREE,
  KEY `fk_users_orders` (`user_id`),
  CONSTRAINT `fk_users_orders` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=72 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.orders: ~17 rows (approximately)
DELETE FROM `orders`;
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
	(66, 1, 'completed', 25000, 6, '2024-07-22 09:44:46', '2024-07-20 08:56:03', '2024-07-22 09:44:46'),
	(67, 1, 'completed', 53500, 5, '2024-07-22 09:44:48', '2024-07-20 11:03:35', '2024-07-22 09:44:48'),
	(68, 1, 'new', 74290, 7, NULL, '2024-07-20 11:06:06', '2024-07-20 11:06:06'),
	(69, 1, 'new', 28500, 5, NULL, '2024-07-20 11:06:19', '2024-07-20 11:06:19'),
	(70, 1, 'new', 74290, 7, NULL, '2024-07-20 11:06:35', '2024-07-20 11:06:35'),
	(71, 1, 'completed', 1602000, 6, '2024-07-23 07:28:51', '2024-07-23 07:28:30', '2024-07-23 07:28:51');

-- Dumping structure for table menu_db.order_details
DROP TABLE IF EXISTS `order_details`;
CREATE TABLE IF NOT EXISTS `order_details` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `order_id` bigint unsigned NOT NULL,
  `food_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `price` float NOT NULL,
  `total_amount` float NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `note` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`id`),
  KEY `food_id` (`food_id`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `fk_orders_foods` FOREIGN KEY (`food_id`) REFERENCES `foods` (`id`),
  CONSTRAINT `fk_orders_order_details` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.order_details: ~36 rows (approximately)
DELETE FROM `order_details`;
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
	(116, 70, 27, 1, 25000, 25000, '2024-07-20 11:06:35', NULL, ''),
	(117, 71, 182, 1, 40000, 40000, '2024-07-23 07:28:30', NULL, ''),
	(118, 71, 181, 1, 40000, 40000, '2024-07-23 07:28:30', NULL, ''),
	(119, 71, 180, 1, 40000, 40000, '2024-07-23 07:28:30', NULL, ''),
	(120, 71, 179, 1, 40000, 40000, '2024-07-23 07:28:30', NULL, ''),
	(121, 71, 178, 1, 40000, 40000, '2024-07-23 07:28:30', NULL, ''),
	(122, 71, 177, 1, 40000, 40000, '2024-07-23 07:28:30', NULL, ''),
	(123, 71, 176, 1, 40000, 40000, '2024-07-23 07:28:30', NULL, ''),
	(124, 71, 175, 1, 40000, 40000, '2024-07-23 07:28:30', NULL, ''),
	(125, 71, 174, 1, 40000, 40000, '2024-07-23 07:28:30', NULL, ''),
	(126, 71, 173, 1, 40000, 40000, '2024-07-23 07:28:30', NULL, ''),
	(127, 71, 144, 1, 342000, 342000, '2024-07-23 07:28:30', NULL, ''),
	(128, 71, 140, 1, 430000, 430000, '2024-07-23 07:28:30', NULL, ''),
	(129, 71, 138, 1, 430000, 430000, '2024-07-23 07:28:30', NULL, '');

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
) ENGINE=InnoDB AUTO_INCREMENT=322 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.personal_access_tokens: ~123 rows (approximately)
DELETE FROM `personal_access_tokens`;
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
	(294, 'default', 1, '9f4fd48ca0d4c81847203b6f45e815ef', '2024-07-22 08:11:09', '2024-07-18 11:36:58', NULL),
	(295, 'default', 5, '31f505415a323231be49474053321603', '2024-07-18 11:46:03', '2024-07-18 11:46:03', NULL),
	(296, 'default', 1, 'e0c03bb5e5445f9a3cdae3ec5c86d8d8', '2024-07-23 10:31:15', '2024-07-18 11:46:39', NULL),
	(297, 'default', 1, '1b353046ca312dc35d6ed7c490868be1', '2024-07-19 09:18:08', '2024-07-19 09:12:17', NULL),
	(298, 'default', 1, '10b4757c2e11fb5b09bab94ea085f1b0', '2024-07-19 09:23:05', '2024-07-19 09:20:33', NULL),
	(299, 'default', 1, '6ebcb319240b15fd7354193af0ea9c9a', '2024-07-20 08:58:01', '2024-07-20 08:16:56', '2024-07-20 08:58:21'),
	(300, 'default', 1, '96c2625f84379311fd354ff2a5bca577', '2024-07-20 09:04:34', '2024-07-20 09:02:44', '2024-07-20 09:04:43'),
	(301, 'default', 1, '5a23a6210d8b07ae91b24017bda654eb', '2024-07-20 09:36:16', '2024-07-20 09:20:03', '2024-07-20 09:36:28'),
	(302, 'default', 1, '6f90aa2f06b7f97d2006c0cd404b5072', '2024-07-22 09:43:49', '2024-07-20 09:36:43', '2024-07-22 09:43:53'),
	(303, 'default', 1, '4796953abb48014dfa70ef47621281b4', '2024-07-22 08:09:02', '2024-07-22 07:18:17', '2024-07-22 08:09:06'),
	(304, 'default', 1, 'f75b1dbd5104148e53bdc2b7c079bc4e', '2024-07-23 05:35:33', '2024-07-22 08:09:12', '2024-07-23 05:35:40'),
	(305, 'default', 1, 'a56a4bbb6c7706224cb57e460572de7d', '2024-07-22 08:12:15', '2024-07-22 08:12:14', NULL),
	(306, 'default', 1, 'c40f2e2c6a155e0cc06e298188472a2c', '2024-07-22 08:19:08', '2024-07-22 08:19:08', NULL),
	(307, 'default', 1, '05ea732e443fd04e5de5c940693826cd', '2024-07-22 08:20:25', '2024-07-22 08:20:25', NULL),
	(308, 'default', 1, '2f8cd1dbbca88f7a7dd7d19e959823eb', '2024-07-22 08:40:37', '2024-07-22 08:40:37', NULL),
	(309, 'default', 1, 'cfb6b02248955f96686c53e75ec1a78d', '2024-07-22 10:12:48', '2024-07-22 09:22:53', NULL),
	(310, 'default', 1, 'f3c36223e5f5ba24db629af511b7c02f', '2024-07-23 02:57:15', '2024-07-22 09:44:11', NULL),
	(311, 'default', 1, '8eac7374cf3b913d211c6474f9b67c4b', '2024-07-23 03:22:08', '2024-07-22 10:12:58', NULL),
	(312, 'default', 1, 'c8025417bc7859be90f74fcdeff5417e', '2024-07-23 03:44:59', '2024-07-23 03:44:59', NULL),
	(314, 'default', 1, '945a7e35680da047c1395dcf5083f9bd', '2024-07-23 03:45:13', '2024-07-23 03:45:12', '2024-07-23 03:45:20'),
	(315, 'default', 1, 'c80bfb626da794c9b00e84acffac2d20', '2024-07-23 08:39:37', '2024-07-23 03:45:28', NULL),
	(316, 'default', 1, 'a039d46d3e8eca97d399d651e0ef66d4', '2024-07-23 03:57:18', '2024-07-23 03:57:18', NULL),
	(317, 'default', 1, 'f955637da4e3bf6cf134091191594bdc', '2024-07-23 04:02:48', '2024-07-23 04:02:48', NULL),
	(318, 'default', 1, 'fa28326e1011767b25ccb88399b0f3f7', '2024-07-23 04:14:17', '2024-07-23 04:14:17', NULL),
	(319, 'default', 1, '5e4658c055766446b200278085f09f8a', '2024-07-23 05:07:14', '2024-07-23 04:30:35', NULL),
	(320, 'default', 1, '3bfae1871e10085c5e679871f0498b71', '2024-07-23 11:32:56', '2024-07-23 05:36:02', NULL),
	(321, 'default', 1, '701c1f91deb4e66aaa66550eb7ea5f18', '2024-07-23 11:28:59', '2024-07-23 07:27:17', NULL);

-- Dumping structure for table menu_db.tables
DROP TABLE IF EXISTS `tables`;
CREATE TABLE IF NOT EXISTS `tables` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` text COLLATE utf8mb4_general_ci NOT NULL,
  `seats` int NOT NULL,
  `is_use` tinyint(1) NOT NULL,
  `user_id` bigint unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_users_tables` (`user_id`),
  CONSTRAINT `fk_users_tables` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.tables: ~3 rows (approximately)
DELETE FROM `tables`;
INSERT INTO `tables` (`id`, `name`, `seats`, `is_use`, `user_id`, `created_at`, `updated_at`) VALUES
	(5, 'ban 1', 2, 1, 1, '2024-07-17 04:23:25', '2024-07-18 11:13:47'),
	(6, 'ban 2', 2, 1, 1, '2024-07-17 04:23:49', '2024-07-20 02:44:13'),
	(7, 'ban 3', 3, 1, 1, '2024-07-17 04:23:56', '2024-07-18 11:18:06');

-- Dumping structure for table menu_db.users
DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `phone_number` int NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table menu_db.users: ~3 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `full_name`, `phone_number`, `password`, `image`, `created_at`, `updated_at`) VALUES
	(1, 'Nguyen Tien Anh', 328023993, 'Io6x4kQrdfsifmhAWqoHDNAmCB0z71LMdlps/wA00AQeeG4mFfs8Ye5ZiN7wQk/3Nu2EAEAUFGTn8LUWZm2Pyz5JRg==', '/users/1/1721380675493.webp', '2024-06-14 07:21:57', '2024-07-20 08:16:41'),
	(4, 'Nguyen Tien Anh', 123456789, 'Io6x4kQrdfsifmhAWqoHDNAmCB0z71LMdlps/wA00AQeeG4mFfs8Ye5ZiN7wQk/3Nu2EAEAUFGTn8LUWZm2Pyz5JRg==', NULL, '2024-07-17 06:08:41', '2024-07-20 08:16:41'),
	(5, 'Nguyen Tien Anh', 1234567891, 'Io6x4kQrdfsifmhAWqoHDNAmCB0z71LMdlps/wA00AQeeG4mFfs8Ye5ZiN7wQk/3Nu2EAEAUFGTn8LUWZm2Pyz5JRg==', NULL, '2024-07-17 06:11:50', '2024-07-20 08:16:41');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
