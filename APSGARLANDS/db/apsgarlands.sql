-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 17, 2023 at 11:57 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apsgarlands`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllCustomerActivePoints` ()   BEGIN
          SELECT customer_id,earned_total FROM(SELECT * FROM (SELECT *,IF(customer_change!=0,@e:=0,IF(current_status=0,@e:=@e+1,@e:=@e+0)) as chk,IF(customer_change!=0,@d:=1,IF(current_status=0 OR @e!=0,@d:=0,@d:=@d+1)) as checking FROM (SELECT customer_id,IF(reward_points_earned!='',DATE_FORMAT(expiry_date,'%Y-%m-%d'),DATE_FORMAT(created_at,'%Y-%m-%d')) as entry_date,IFNULL(reward_points_earned,0) as reward,IFNULL(reward_points_claimed,0) as claimed,IF(@a=customer_id OR @a=0,@b:=@b+IFNULL(reward_points_earned,0)-IFNULL(reward_points_claimed,0),@b:=IFNULL(reward_points_earned,0)) as earned_total,IF(customer_id!=@a,@a:=customer_id,0) as customer_change,IF(DATE_FORMAT(expiry_date,'%Y-%m-%d')>='2023-10-09' OR IFNULL(reward_points_earned,0)=0,1,0) as current_status FROM customer_reward_points,(SELECT @a:=0) s,(SELECT @b:=0) t ORDER BY customer_id ASC,entry_date DESC) s, (SELECT @d:=0) t, (SELECT @e:=0) u) s ORDER by customer_id ASC, checking DESC) t GROUP by customer_id;
        END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetCustomerEarnedTotal` (IN `CustomerID` BIGINT(11))   BEGIN
		SELECT customer_id, earned_total FROM (
			SELECT * FROM (
				SELECT *, IF(customer_change != 0, @e := 0, IF(current_status = 0, @e := @e + 1, @e := @e + 0)) as chk,
				IF(customer_change != 0, @d := 1, IF(current_status = 0 OR @e != 0, @d := 0, @d := @d + 1)) as checking
				FROM (
					SELECT customer_id,
						IF(reward_points_earned != '', DATE_FORMAT(expiry_date, '%Y-%m-%d'), DATE_FORMAT(created_at, '%Y-%m-%d')) as entry_date,
						IFNULL(reward_points_earned, 0) as reward,
						IFNULL(reward_points_claimed, 0) as claimed,
						IF(@a = customer_id OR @a = 0, @b := @b + IFNULL(reward_points_earned, 0) - IFNULL(reward_points_claimed, 0), @b := IFNULL(reward_points_earned, 0)) as earned_total,
						IF(customer_id != @a, @a := customer_id, 0) as customer_change,
						IF(DATE_FORMAT(expiry_date, '%Y-%m-%d') >= DATE(NOW()) OR IFNULL(reward_points_earned, 0) = 0, 1, 0) as current_status
					FROM customer_reward_points , (SELECT @a := 0) s, (SELECT @b := 0)  t
					where customer_id = CustomerID ORDER BY customer_id ASC, entry_date DESC
				) s,
				(SELECT @d := 0) t,
				(SELECT @e := 0) u
			)  s

			ORDER by customer_id ASC, checking DESC
		) t
		GROUP by customer_id;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rewardPointsCalc` (IN `CustomerID` BIGINT(11))   BEGIN
    SELECT 
        customer_id,
        SUM(reward_points_earned) AS reward_points_earned_total,
        SUM(reward_points_claimed) AS reward_points_claimed_total,
        SUM(CASE WHEN expiry_date < '2023-09-11' THEN reward_points_earned ELSE 0 END) AS expired_earned_rewardpoints,
        SUM(CASE WHEN reward_points_claimed IS NOT NULL AND created_at < '2023-09-11' THEN reward_points_claimed ELSE 0 END) AS expired_claimed_rewardpoints,
        SUM(CASE WHEN reward_points_earned IS NOT NULL AND expiry_date > '2023-09-11' THEN reward_points_earned ELSE 0 END) - 
        SUM(CASE WHEN expiry_date < '2023-09-11' THEN reward_points_earned ELSE 0 END) AS in_live_earned_rewardpoints,
        (CASE WHEN SUM(reward_points_earned) IS NOT NULL AND SUM(reward_points_claimed) IS NOT NULL AND SUM(CASE WHEN expiry_date < '2023-09-11' THEN reward_points_earned ELSE 0 END) > 0 
            THEN SUM(reward_points_earned) - SUM(CASE WHEN expiry_date < '2023-09-11' THEN reward_points_earned ELSE 0 END) - SUM(reward_points_claimed) 
            ELSE 0 END) AS expired_points
    FROM 
        customer_reward_points
    WHERE 
        customer_id = CustomerID
        AND deleted_at IS NULL
    GROUP BY 
        customer_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `abandonedcartlistreport`
--

CREATE TABLE `abandonedcartlistreport` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(191) NOT NULL,
  `customer_id` varchar(191) NOT NULL,
  `quantity` double(8,2) NOT NULL,
  `rate` double(8,2) NOT NULL,
  `product_id` varchar(191) NOT NULL,
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) NOT NULL,
  `reason` longtext DEFAULT '',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `abandonedcartlistreport`
--

INSERT INTO `abandonedcartlistreport` (`id`, `slug`, `customer_id`, `quantity`, `rate`, `product_id`, `first_name`, `last_name`, `reason`, `created_at`, `updated_at`) VALUES
(1, 'jasmine', '4', 1.00, 999.00, '6', 'APS', 'Admin', NULL, '2023-10-28 08:18:52', NULL),
(2, 'manoranjitham', '4', 1.00, 150.00, '9', 'APS', 'Admin', 'Single product clearing', '2023-10-28 08:19:21', NULL),
(3, 'lotus-yeVHn5rz', '4', 1.00, 250.00, '14', 'APS', 'Admin', 'Bulk Product Clearing', '2023-10-28 08:19:41', NULL),
(4, 'loose-flower-red', '4', 1.00, 19.00, '10', 'APS', 'Admin', 'Bulk Product Clearing', '2023-10-28 08:19:41', NULL),
(5, 'vettiver-malai-for-god', '1', 1.00, 24.00, '15', 'GIRISH', 'SHANKAR', NULL, '2023-11-03 09:37:46', NULL),
(6, 'red-rose-bouquet', '1', 1.00, 145.00, '8', 'GIRISH', 'SHANKAR', NULL, '2023-11-03 09:37:47', NULL),
(7, 'combo-losse-flower', '1', 1.00, 14.00, '16', 'GIRISH', 'SHANKAR', NULL, '2023-11-03 09:39:33', NULL),
(8, 'arali-saram-flowers', '6', 3.00, 9.00, '24', 'Sangeetha', 'M', NULL, '2023-11-17 08:06:36', NULL),
(9, 'malli-saram', '6', 4.00, 8.28, '26', 'Sangeetha', 'M', NULL, '2023-11-17 08:08:21', NULL),
(10, 'violet-bouquet', '23', 1.00, 99.00, '27', 'udhaya', 's', NULL, '2023-11-17 09:50:25', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `activations`
--

CREATE TABLE `activations` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activations`
--

INSERT INTO `activations` (`id`, `user_id`, `code`, `completed`, `completed_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'TveyR9rvS1pumbnTwCerCFJ8H6ssW2i2', 1, '2023-08-09 11:54:33', '2023-08-09 06:24:33', '2023-08-09 06:24:33'),
(2, 2, 'SYWP2ZOSFnJnD7D92YONTzywZ9qAGtKR', 1, '2023-08-16 16:35:35', '2023-08-16 11:05:35', '2023-08-16 11:05:35'),
(3, 3, '4tkqJZJwLYkfvQ2VxqyP9QX7nKp45klg', 1, '2023-08-22 16:25:43', '2023-08-22 10:55:43', '2023-08-22 10:55:43'),
(4, 4, 'TveyR9rvS1pumbnTwCerCFJ8H6ssW2i2', 1, '2023-08-09 11:54:33', '2023-08-09 06:24:33', '2023-08-09 06:24:33'),
(5, 5, 'KQZCydY9de62PpKXmw3v8woZo7ZUWqNf', 1, '2023-08-24 15:35:50', '2023-08-24 10:05:50', '2023-08-24 10:05:50'),
(6, 6, 'hFz3Kvx4X8zEdBHMkIMtGlLu4kFFfccF', 1, '2023-08-24 19:16:46', '2023-08-24 13:46:45', '2023-08-24 13:46:46'),
(7, 7, 'qR2Qzlu1SxURIiWWawreZAB5RhMThpBa', 1, '2023-09-25 13:18:06', '2023-09-25 07:48:06', '2023-09-25 07:48:06'),
(8, 8, 'dHQxLHYaLiqplinfjCojXouBFzokWR3i', 1, '2023-10-28 16:41:01', '2023-10-28 11:11:01', '2023-10-28 11:11:01'),
(22, 22, 'yOASOGK4PEzpecDIByOJeuy289TXsMKh', 1, '2023-10-30 20:08:17', '2023-10-30 14:38:17', '2023-10-30 14:38:17'),
(23, 23, 'Spnm6WCzOLsXKYNdw5JkefP63QSBp4im', 1, '2023-11-17 17:24:21', '2023-11-17 11:54:21', '2023-11-17 11:54:21');

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) NOT NULL,
  `address_1` varchar(191) NOT NULL,
  `address_2` varchar(191) DEFAULT NULL,
  `city` varchar(191) NOT NULL,
  `state` varchar(191) NOT NULL,
  `zip` varchar(191) NOT NULL,
  `country` varchar(191) NOT NULL,
  `user_type` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `customer_id`, `first_name`, `last_name`, `address_1`, `address_2`, `city`, `state`, `zip`, `country`, `user_type`, `created_at`, `updated_at`) VALUES
(1, 1, 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 0, '2023-08-10 12:13:43', '2023-08-10 12:13:43'),
(2, 3, 'Mahendran', 'Sadhasivam', '338/1A LVR colony', NULL, 'Erode', 'TN', '638004', 'IN', 0, '2023-08-22 11:00:26', '2023-08-22 11:00:26'),
(3, 3, 'Navin', 'Elangovan', '121-Kovil Street', NULL, 'Erode', 'TN', '638004', 'IN', 0, '2023-08-22 11:01:14', '2023-08-22 11:01:14'),
(4, 5, 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 0, '2023-08-24 13:22:14', '2023-08-24 14:17:52'),
(5, 4, 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 0, '2023-08-24 13:27:42', '2023-08-24 13:27:42'),
(6, 1, 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 0, '2023-08-24 13:38:49', '2023-08-24 13:38:49'),
(7, 6, 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'SGR', '6380000', 'MY', 0, '2023-08-24 13:49:41', '2023-08-24 13:49:41'),
(8, 1, 'santhila', 'S', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', 0, '2023-09-28 11:40:46', '2023-09-28 11:40:46'),
(9, 7, 'Indumathi', 'E', 'kulalumpur', NULL, 'kulalumpur', 'TRG', '59000', 'MY', 0, '2023-10-26 06:30:50', '2023-10-26 06:30:50'),
(10, 8, 'Prabakaran1', 'V', 'Address 1', 'Address 2', 'Kualalumpur', 'KUL', '59000', 'MY', 0, '2023-10-28 11:11:01', '2023-10-28 11:11:01'),
(11, 6, 'Sangeetha', 'M', 'erode', NULL, 'erode', 'CCU', '59000', 'AO', 1, '2023-11-17 10:55:22', '2023-11-17 10:55:22'),
(12, 23, 'udhya', 's', 'Malaysia', 'Malaysia', 'Malaysia', 'SGR', '59000', 'MY', 0, '2023-11-17 11:59:46', '2023-11-17 11:59:46');

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` int(10) UNSIGNED NOT NULL,
  `attribute_set_id` int(10) UNSIGNED NOT NULL,
  `is_filterable` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`id`, `attribute_set_id`, `is_filterable`, `created_at`, `updated_at`, `slug`) VALUES
(1, 5, 1, '2023-08-09 12:49:38', '2023-08-09 12:49:38', 'green'),
(2, 5, 1, '2023-08-09 12:50:01', '2023-08-09 12:50:01', 'red'),
(3, 3, 1, '2023-08-09 12:51:16', '2023-08-09 12:51:16', 'price'),
(4, 2, 1, '2023-08-10 08:08:16', '2023-08-10 08:08:16', 'products'),
(5, 6, 1, '2023-08-14 10:08:54', '2023-08-28 09:22:11', 'weight');

-- --------------------------------------------------------

--
-- Table structure for table `attribute_categories`
--

CREATE TABLE `attribute_categories` (
  `attribute_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_categories`
--

INSERT INTO `attribute_categories` (`attribute_id`, `category_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(2, 3),
(2, 4),
(2, 5),
(3, 1),
(3, 2),
(3, 3),
(3, 4),
(3, 5),
(4, 1),
(4, 2),
(4, 4),
(5, 5),
(5, 12),
(5, 25);

-- --------------------------------------------------------

--
-- Table structure for table `attribute_sets`
--

CREATE TABLE `attribute_sets` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_sets`
--

INSERT INTO `attribute_sets` (`id`, `created_at`, `updated_at`) VALUES
(1, '2023-08-09 12:46:12', '2023-08-09 12:46:12'),
(2, '2023-08-09 12:46:24', '2023-08-09 12:46:24'),
(3, '2023-08-09 12:46:34', '2023-08-09 12:46:34'),
(4, '2023-08-09 12:46:41', '2023-08-09 12:46:41'),
(5, '2023-08-09 12:48:35', '2023-08-09 12:48:35'),
(6, '2023-08-14 10:07:36', '2023-08-14 10:07:36');

-- --------------------------------------------------------

--
-- Table structure for table `attribute_set_translations`
--

CREATE TABLE `attribute_set_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `attribute_set_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_set_translations`
--

INSERT INTO `attribute_set_translations` (`id`, `attribute_set_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'Name'),
(2, 2, 'en', 'Description'),
(3, 3, 'en', 'Price'),
(4, 4, 'en', 'Options'),
(5, 5, 'en', 'Color'),
(6, 6, 'en', 'Specification');

-- --------------------------------------------------------

--
-- Table structure for table `attribute_translations`
--

CREATE TABLE `attribute_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `attribute_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_translations`
--

INSERT INTO `attribute_translations` (`id`, `attribute_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'Green'),
(2, 2, 'en', 'red'),
(3, 3, 'en', 'price'),
(4, 4, 'en', 'Products'),
(5, 5, 'en', 'Weight');

-- --------------------------------------------------------

--
-- Table structure for table `attribute_values`
--

CREATE TABLE `attribute_values` (
  `id` int(10) UNSIGNED NOT NULL,
  `attribute_id` int(10) UNSIGNED NOT NULL,
  `position` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_values`
--

INSERT INTO `attribute_values` (`id`, `attribute_id`, `position`, `created_at`, `updated_at`) VALUES
(1, 1, 0, '2023-08-09 12:50:25', '2023-08-09 12:50:25'),
(2, 2, 0, '2023-08-09 12:50:36', '2023-08-09 12:50:36'),
(3, 3, 0, '2023-08-09 12:51:38', '2023-08-09 12:51:38'),
(4, 4, 0, '2023-08-10 08:08:33', '2023-08-10 08:08:33'),
(5, 4, 1, '2023-08-10 08:08:33', '2023-08-10 08:08:33'),
(6, 5, 0, '2023-08-14 10:08:54', '2023-08-14 10:08:54');

-- --------------------------------------------------------

--
-- Table structure for table `attribute_value_translations`
--

CREATE TABLE `attribute_value_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `attribute_value_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `value` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_value_translations`
--

INSERT INTO `attribute_value_translations` (`id`, `attribute_value_id`, `locale`, `value`) VALUES
(1, 1, 'en', 'green'),
(2, 2, 'en', 'red'),
(3, 3, 'en', 'price'),
(4, 4, 'en', '10'),
(5, 5, 'en', '20'),
(6, 6, 'en', '1Kg');

-- --------------------------------------------------------

--
-- Table structure for table `blogcategorys`
--

CREATE TABLE `blogcategorys` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(50) NOT NULL,
  `category_code` varchar(5) NOT NULL,
  `description` varchar(50) DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blogcategorys`
--

INSERT INTO `blogcategorys` (`id`, `category_name`, `category_code`, `description`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Nature', '001', 'About Nature', 1, '2023-10-21 11:01:38', '2023-10-21 11:01:38', NULL),
(2, 'Ophelia Greenholt PhD', '763', 'Earum ut.', 1, '2023-10-30 14:14:33', '2023-10-30 14:14:33', NULL),
(3, 'Cecil Kirlin V', '324', 'Quia.', 1, '2023-10-30 14:14:33', '2023-10-30 14:14:33', NULL),
(4, 'Leanne Gerlach', '984', 'Aut et.', 1, '2023-10-30 14:14:33', '2023-10-30 14:14:33', NULL),
(5, 'Flavio Nikolaus', '355', 'Minima.', 1, '2023-10-30 14:14:33', '2023-10-30 14:14:33', NULL),
(6, 'Elmer Bashirian', '144', 'Laborum.', 1, '2023-10-30 14:14:33', '2023-10-30 14:14:33', NULL),
(7, 'Mittie Breitenberg', '486', 'Atque.', 1, '2023-10-30 14:14:33', '2023-10-30 14:14:33', NULL),
(8, 'Prof. Tiana Pfeffer', '799', 'Modi.', 1, '2023-10-30 14:14:33', '2023-10-30 14:14:33', NULL),
(9, 'Salvador Keeling', '146', 'Sed.', 1, '2023-10-30 14:14:33', '2023-10-30 14:14:33', NULL),
(10, 'Prof. Dina Pfannerstill MD', '229', 'A dolorem.', 1, '2023-10-30 14:14:33', '2023-10-30 14:14:33', NULL),
(11, 'Delia Greenfelder', '659', 'Mollitia.', 1, '2023-10-30 14:14:33', '2023-10-30 14:14:33', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `blogcomment`
--

CREATE TABLE `blogcomment` (
  `id` int(10) UNSIGNED NOT NULL,
  `comments` longtext NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blogcomment`
--

INSERT INTO `blogcomment` (`id`, `comments`, `post_id`, `author_id`, `created_at`, `updated_at`, `deleted_at`, `is_active`) VALUES
(1, 'test', 2, 1, '2023-10-30 14:11:17', '2023-10-30 14:11:17', NULL, 1),
(2, 'hi test from prabhu', 1, 1, '2023-10-31 07:43:18', '2023-10-31 07:43:18', NULL, 1),
(3, 'hi prabhu testing', 1, 1, '2023-10-31 07:46:55', '2023-10-31 07:46:55', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `blogfeedback`
--

CREATE TABLE `blogfeedback` (
  `id` int(10) UNSIGNED NOT NULL,
  `likes` tinyint(1) NOT NULL,
  `dislikes` tinyint(1) NOT NULL,
  `post_id` int(10) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blogposts`
--

CREATE TABLE `blogposts` (
  `id` int(10) UNSIGNED NOT NULL,
  `post_title` varchar(50) NOT NULL,
  `post_body` longtext NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL,
  `author_id` int(10) UNSIGNED NOT NULL,
  `post_status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `approved_by` int(10) UNSIGNED DEFAULT NULL,
  `approved_date` date DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blogposts`
--

INSERT INTO `blogposts` (`id`, `post_title`, `post_body`, `category_id`, `tag_id`, `author_id`, `post_status`, `approved_by`, `approved_date`, `is_active`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'test', '<p>tset</p>', 1, 1, 1, 'approved', 1, '2023-10-30', 1, '2023-10-30 13:09:55', '2023-10-30 13:09:55', NULL),
(2, 'Flowers', 'For other uses, see Flower (disambiguation).\r\n\"Floral\" redirects here. For other uses, see Floral (disambiguation).\r\n\r\nA flower, sometimes known as a bloom or blossom, is the reproductive structure found in flowering plants (plants of the division Angiospermae). Flowers produce gametophytes, which in flowering plants consist of a few haploid cells which produce gametes. The \"male\" gametophyte, which produces non-motile sperm, is enclosed within pollen grains; the \"female\" gametophyte is contained within the ovule. When pollen from the anther of a flower is deposited on the stigma, this is called pollination. Some flowers may self-pollinate, producing seed using pollen from the same flower or a different flower of the same plant, but others have mechanisms to prevent self-pollination and rely on cross-pollination, when pollen is transferred from the anther of one flower to the stigma of another flower on a different individual of the same species.\r\n\r\nSelf-pollination happens in flowers where the stamen and carpel mature at the same time, and are positioned so that the pollen can land on the flower\'s stigma. This pollination does not require an investment from the plant to provide nectar and pollen as food for pollinators.[1]\r\n\r\nSome flowers produce diaspores without fertilization (parthenocarpy). Flowers contain sporangia and are the site where gametophytes develop.\r\n\r\nMost flowering plants depend on animals, such as bees, moths, and butterflies, to transfer their pollen between different flowers, and have evolved to attract these pollinators by various strategies, including brightly colored, conspicuous petals, attractive scents, and the production of nectar, a food source for pollinators.[2] In this way, many flowering plants have co-evolved with pollinators to be mutually dependent on services they provide to one another—in the plant\'s case, a means of reproduction; in the pollinator\'s case, a source of food.[3] After fertilization, the ovary of the flower develops into fruit containing seeds.\r\n\r\nFlowers have long been appreciated by humans for their beauty and pleasant scents, and also hold cultural significance as religious, ritual, or symbolic objects, or sources of medicine and food.', 1, 1, 1, 'pending', NULL, NULL, 1, '2023-10-30 14:10:19', '2023-10-30 14:10:19', NULL),
(3, 'Lawson Flatley', '632', 1, 1, 1, 'pending', 1, '2015-05-04', 1, '2023-10-30 14:12:45', '2023-10-30 14:12:45', NULL),
(4, 'Tierra Welch', '615', 1, 1, 1, 'pending', 6, '1987-03-07', 1, '2023-10-30 14:12:45', '2023-10-30 14:12:45', NULL),
(5, 'Norwood Bins', '269', 1, 1, 1, 'pending', 9, '1989-07-04', 1, '2023-10-30 14:12:45', '2023-10-30 14:12:45', NULL),
(6, 'Narciso Conn', '256', 1, 1, 1, 'pending', 4, '1982-03-16', 1, '2023-10-30 14:12:45', '2023-10-30 14:12:45', NULL),
(7, 'Bret Kuhn', '912', 1, 1, 1, 'pending', 6, '2012-11-01', 1, '2023-10-30 14:12:45', '2023-10-30 14:12:45', NULL),
(8, 'Dr. Esteban Prosacco', '491', 1, 1, 1, 'pending', 4, '2016-12-07', 1, '2023-10-30 14:12:45', '2023-10-30 14:12:45', NULL),
(9, 'Dr. Trycia O\'Conner DDS', '790', 1, 1, 1, 'pending', 8, '1991-10-04', 1, '2023-10-30 14:12:45', '2023-10-30 14:12:45', NULL),
(10, 'Lisa Halvorson', '39', 1, 1, 1, 'pending', 9, '2004-06-08', 1, '2023-10-30 14:12:45', '2023-10-30 14:12:45', NULL),
(11, 'Gilberto Pouros IV', '443', 1, 1, 1, 'pending', 9, '2012-04-27', 1, '2023-10-30 14:12:45', '2023-10-30 14:12:45', NULL),
(12, 'Lambert Grant Sr.', '238', 1, 1, 1, 'pending', 7, '2002-04-04', 1, '2023-10-30 14:12:45', '2023-10-30 14:12:45', NULL),
(13, 'Jayme Price Sr.', 'Voluptas reprehenderit atque perspiciatis perspiciatis officia molestias et. Laudantium dolor ut soluta exercitationem illum deserunt. Facere voluptas exercitationem nisi vitae officia aperiam quisquam. Neque autem reiciendis ea aut.', 1, 1, 1, 'pending', 5, '1992-08-31', 1, '2023-10-30 14:15:37', '2023-10-30 14:15:37', NULL),
(14, 'Miss Jessica Quigley', 'Quo laboriosam et deleniti esse fugiat dolorem. Nostrum dolorem eveniet quae deleniti et minus. Unde quam deleniti nihil earum recusandae expedita quod.', 1, 1, 1, 'pending', 1, '1993-02-02', 1, '2023-10-30 14:15:37', '2023-10-30 14:15:37', NULL),
(15, 'Prof. Abraham Swift DVM', 'Cupiditate odit repellat dolor deleniti qui rerum. Voluptatem ipsam modi culpa maxime sunt voluptatem rerum. Eum facere maiores voluptatibus optio. Provident nobis aliquam earum nihil ad quis eos.', 1, 1, 1, 'pending', 5, '2000-08-26', 1, '2023-10-30 14:15:37', '2023-10-30 14:15:37', NULL),
(16, 'D\'angelo Tillman', 'Et delectus aut ea qui consequatur vitae. Ipsum in magni perspiciatis placeat deleniti.', 1, 1, 1, 'pending', 9, '1975-12-12', 1, '2023-10-30 14:15:37', '2023-10-30 14:15:37', NULL),
(17, 'Abel King Jr.', 'Minima odit ad cupiditate et. Et reiciendis eligendi delectus totam. Inventore minus voluptatibus nihil amet. Reprehenderit voluptate ipsum aliquid sapiente rerum qui. Sit sint perferendis accusantium et quo officiis.', 1, 1, 1, 'pending', 2, '2020-04-05', 1, '2023-10-30 14:15:37', '2023-10-30 14:15:37', NULL),
(18, 'Miss Clara Pagac', 'Laudantium excepturi numquam unde et. Voluptas nesciunt necessitatibus dolor fugiat voluptatem. Ipsa et omnis rerum. Doloremque sed veniam et eum laborum quisquam vel nostrum.', 1, 1, 1, 'pending', 10, '1979-12-03', 1, '2023-10-30 14:15:37', '2023-10-30 14:15:37', NULL),
(19, 'Terrence Grady', 'Fugiat qui eos provident molestiae et consequatur recusandae. Nulla saepe ipsum quia commodi hic laboriosam. Animi maxime maxime quos soluta.', 1, 1, 1, 'pending', 2, '1992-11-16', 1, '2023-10-30 14:15:37', '2023-10-30 14:15:37', NULL),
(20, 'Jaylon Greenholt', 'Unde quia fugit hic eos explicabo. Voluptatem tenetur error ut provident animi reprehenderit et. Quas consequatur eaque qui modi voluptatem non.', 1, 1, 1, 'pending', 7, '1993-01-03', 1, '2023-10-30 14:15:37', '2023-10-30 14:15:37', NULL),
(21, 'Prof. Lewis Rowe', 'Et nesciunt harum corporis. Repudiandae doloremque fugit quia. A fuga perferendis voluptas eos aut.', 1, 1, 1, 'pending', 1, '2017-04-20', 1, '2023-10-30 14:15:37', '2023-10-30 14:15:37', NULL),
(22, 'Clarabelle Gorczany', 'Distinctio animi similique odio et excepturi. Ratione veniam nam et aut consequuntur ipsam aut.', 1, 1, 1, 'pending', 10, '2000-07-29', 1, '2023-10-30 14:15:37', '2023-10-30 14:15:37', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `blogtags`
--

CREATE TABLE `blogtags` (
  `id` int(10) UNSIGNED NOT NULL,
  `tag_name` varchar(50) NOT NULL,
  `tag_code` varchar(5) NOT NULL,
  `is_active` tinyint(4) DEFAULT 1,
  `description` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `blogtags`
--

INSERT INTO `blogtags` (`id`, `tag_name`, `tag_code`, `is_active`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'flowers', '001', 1, 'for testing purpose', '2023-10-30 13:09:02', '2023-10-30 13:09:02', NULL),
(2, 'Flossie Schoen', '631', 1, 'Iste et.', '2023-10-30 14:10:13', '2023-10-30 14:10:13', NULL),
(3, 'Julien Larson', '328', 1, 'Quasi sed.', '2023-10-30 14:15:03', '2023-10-30 14:15:03', NULL),
(4, 'Shanon Berge', '302', 1, 'Ut.', '2023-10-30 14:15:03', '2023-10-30 14:15:03', NULL),
(5, 'Tessie Goldner', '702', 1, 'Nostrum.', '2023-10-30 14:15:03', '2023-10-30 14:15:03', NULL),
(6, 'Destiny Bode', '19', 1, 'Voluptas.', '2023-10-30 14:15:03', '2023-10-30 14:15:03', NULL),
(7, 'Augustine Kuhlman', '918', 1, 'Ut et.', '2023-10-30 14:15:03', '2023-10-30 14:15:03', NULL),
(8, 'Brittany Hand', '466', 1, 'Et enim.', '2023-10-30 14:15:03', '2023-10-30 14:15:03', NULL),
(9, 'Rosemary Yost DDS', '923', 1, 'Illo.', '2023-10-30 14:15:03', '2023-10-30 14:15:03', NULL),
(10, 'Derrick Haag DDS', '505', 1, 'Dolores.', '2023-10-30 14:15:03', '2023-10-30 14:15:03', NULL),
(11, 'Simone Abernathy', '451', 1, 'In.', '2023-10-30 14:15:03', '2023-10-30 14:15:03', NULL),
(12, 'Mr. Dion Adams', '540', 1, 'Veritatis.', '2023-10-30 14:15:03', '2023-10-30 14:15:03', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(191) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `slug`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'aps', 1, '2023-08-09 12:44:27', '2023-08-09 12:44:27'),
(2, 'apsg', 1, '2023-08-10 08:10:46', '2023-08-10 08:10:46');

-- --------------------------------------------------------

--
-- Table structure for table `brand_translations`
--

CREATE TABLE `brand_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `brand_id` int(11) NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brand_translations`
--

INSERT INTO `brand_translations` (`id`, `brand_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'APS'),
(2, 2, 'en', 'APS Garlands');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `slug` varchar(191) NOT NULL,
  `position` int(10) UNSIGNED DEFAULT NULL,
  `is_searchable` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `slug`, `position`, `is_searchable`, `is_active`, `created_at`, `updated_at`) VALUES
(1, NULL, 'devotional-garlands', NULL, 0, 1, '2023-08-09 12:34:25', '2023-08-14 09:45:08'),
(2, NULL, 'wedding-garlands', NULL, 0, 1, '2023-08-09 12:34:44', '2023-08-14 09:44:47'),
(3, NULL, 'funeral-garlands', NULL, 0, 1, '2023-08-09 12:35:01', '2023-08-14 09:24:25'),
(4, NULL, 'festival-garlands', NULL, 0, 1, '2023-08-09 12:35:23', '2023-08-14 09:45:29'),
(5, NULL, 'greetings', NULL, 0, 1, '2023-08-09 12:42:40', '2023-08-14 09:45:38'),
(12, 4, 'loose-flowers-pwvcy8wu', NULL, 0, 1, '2023-08-11 07:08:17', '2023-08-14 09:45:59'),
(15, NULL, 'combo', NULL, 0, 1, '2023-08-12 03:57:20', '2023-08-14 09:46:04'),
(18, NULL, 'same-day-delivery', NULL, 0, 1, '2023-08-14 06:51:14', '2023-08-14 06:51:14'),
(19, NULL, 'combo-IB1js2MR', NULL, 0, 1, '2023-08-14 06:51:52', '2023-08-14 06:51:52'),
(20, NULL, 'pre-order', NULL, 1, 1, '2023-08-14 06:54:57', '2023-08-16 06:06:19'),
(21, 1, 'jasmine-saram', NULL, 0, 1, '2023-08-14 06:57:28', '2023-08-14 06:57:28'),
(22, 3, 'main-garland', NULL, 0, 1, '2023-08-14 07:46:50', '2023-08-14 07:46:50'),
(23, 3, 'bouquet', NULL, 0, 1, '2023-08-14 07:47:17', '2023-08-14 07:47:17'),
(24, 3, 'hand-bouquet', NULL, 0, 1, '2023-08-14 07:47:48', '2023-08-14 07:47:48'),
(25, 3, 'hand-bouquet-1yQ0zKX4', NULL, 0, 1, '2023-08-14 07:48:03', '2023-08-14 07:48:03');

-- --------------------------------------------------------

--
-- Table structure for table `category_translations`
--

CREATE TABLE `category_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `category_translations`
--

INSERT INTO `category_translations` (`id`, `category_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'Saram Flowers'),
(2, 2, 'en', 'Engagement Garland'),
(3, 3, 'en', 'Wedding Garland'),
(4, 4, 'en', 'Prayer Garland'),
(5, 5, 'en', 'Flowers'),
(12, 12, 'en', 'Loose flowers'),
(15, 15, 'en', 'Temple Garland'),
(18, 18, 'en', 'Same Day Delivery'),
(19, 19, 'en', 'Combo'),
(20, 20, 'en', 'Pre-Order'),
(21, 21, 'en', 'Jasmine Saram'),
(22, 22, 'en', 'Main Garland'),
(23, 23, 'en', 'Bouquet'),
(24, 24, 'en', 'Hand Bouquet'),
(25, 25, 'en', 'Loose Flowers');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `countryId` int(100) NOT NULL,
  `countryUUID` char(36) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `countryCode` varchar(255) NOT NULL,
  `countryName` varchar(255) NOT NULL,
  `isEnable` tinyint(1) DEFAULT NULL,
  `dialCode` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`countryId`, `countryUUID`, `countryCode`, `countryName`, `isEnable`, `dialCode`, `createdAt`, `updatedAt`) VALUES
(1, '27c66275-e9da-45c8-9c72-142ab11b168e', 'IND', 'India', 1, '+91', '2023-11-06 12:19:38', '2023-11-06 12:19:38');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) NOT NULL,
  `value` decimal(18,4) UNSIGNED DEFAULT NULL,
  `is_percent` tinyint(1) NOT NULL,
  `free_shipping` tinyint(1) NOT NULL,
  `minimum_spend` decimal(18,4) UNSIGNED DEFAULT NULL,
  `maximum_spend` decimal(18,4) UNSIGNED DEFAULT NULL,
  `usage_limit_per_coupon` int(10) UNSIGNED DEFAULT NULL,
  `usage_limit_per_customer` int(10) UNSIGNED DEFAULT NULL,
  `used` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `code`, `value`, `is_percent`, `free_shipping`, `minimum_spend`, `maximum_spend`, `usage_limit_per_coupon`, `usage_limit_per_customer`, `used`, `is_active`, `start_date`, `end_date`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'fyi56', '10.0000', 0, 0, '200.0000', '2000.0000', 10, 10, 3, 1, '2023-08-10', '2023-08-31', NULL, '2023-08-10 12:10:22', '2023-08-25 09:28:55'),
(2, 'fyi5623', '9.0000', 0, 0, NULL, NULL, NULL, NULL, 3, 1, '2023-08-04', '2023-08-26', NULL, '2023-08-11 10:43:13', '2023-08-24 13:14:00'),
(3, 'ShipFree0114', '25.0000', 0, 1, '100.0000', NULL, 10, 1, 1, 1, NULL, NULL, NULL, '2023-08-24 13:14:17', '2023-08-24 13:27:43'),
(4, 'FSOFF00147', '35.0000', 1, 1, NULL, NULL, NULL, NULL, 2, 1, '2023-08-22', '2023-08-25', NULL, '2023-08-24 13:18:17', '2023-08-25 14:22:07'),
(5, 'n157y123', '100.0000', 1, 0, NULL, NULL, 5, 5, 3, 1, '2023-08-25', '2023-09-01', NULL, '2023-08-25 09:32:04', '2023-08-25 09:50:36'),
(6, 'OONAMFEST0187', '50.0000', 0, 0, NULL, NULL, NULL, NULL, 2, 1, '2023-10-15', '2023-11-16', NULL, '2023-08-28 09:27:40', '2023-11-03 09:32:39'),
(7, 'PFEST1023', '25.0000', 1, 0, '50.0000', '250.0000', 50, 10, 0, 1, NULL, NULL, NULL, '2023-10-12 07:27:21', '2023-10-12 07:27:54'),
(8, 'NovOFF23', '60.0000', 0, 0, NULL, NULL, NULL, NULL, 0, 1, '2023-11-01', '2023-11-30', NULL, '2023-11-02 09:07:20', '2023-11-03 09:43:29'),
(9, 'NOVOFF23', '11.0000', 1, 0, NULL, NULL, 100, 5, 2, 1, '2023-11-01', '2023-11-30', NULL, '2023-11-02 09:07:56', '2023-11-17 10:56:56');

-- --------------------------------------------------------

--
-- Table structure for table `coupon_categories`
--

CREATE TABLE `coupon_categories` (
  `coupon_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `exclude` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupon_categories`
--

INSERT INTO `coupon_categories` (`coupon_id`, `category_id`, `exclude`) VALUES
(9, 19, 1);

-- --------------------------------------------------------

--
-- Table structure for table `coupon_products`
--

CREATE TABLE `coupon_products` (
  `coupon_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `exclude` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_translations`
--

CREATE TABLE `coupon_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `coupon_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupon_translations`
--

INSERT INTO `coupon_translations` (`id`, `coupon_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'aadi Offer'),
(2, 2, 'en', 'diwali sale'),
(3, 3, 'en', 'Free Shipping'),
(4, 4, 'en', 'FestiveOff'),
(5, 5, 'en', 'New Year'),
(6, 6, 'en', 'Oonam Fest'),
(7, 7, 'en', 'Pooja Festival'),
(8, 9, 'en', 'November offer'),
(9, 8, 'en', 'NovOFF23');

-- --------------------------------------------------------

--
-- Table structure for table `cross_sell_products`
--

CREATE TABLE `cross_sell_products` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `cross_sell_product_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cross_sell_products`
--

INSERT INTO `cross_sell_products` (`product_id`, `cross_sell_product_id`) VALUES
(2, 4),
(3, 1),
(5, 1),
(5, 2),
(5, 3),
(7, 2),
(7, 3),
(7, 4),
(7, 5),
(7, 6),
(8, 2),
(8, 5),
(8, 6),
(8, 7),
(9, 2),
(9, 3),
(10, 1),
(10, 3),
(10, 5),
(11, 1),
(11, 2),
(11, 3),
(11, 7),
(11, 9),
(11, 10),
(12, 6),
(13, 9),
(15, 10),
(15, 11),
(15, 12),
(15, 13),
(16, 9),
(16, 10),
(16, 11),
(16, 12),
(16, 13),
(16, 14),
(17, 9),
(17, 10),
(17, 11),
(17, 12),
(17, 13),
(18, 10),
(18, 11),
(18, 14),
(18, 16),
(24, 12),
(24, 13),
(24, 14),
(24, 15),
(24, 16),
(26, 16),
(26, 17);

-- --------------------------------------------------------

--
-- Table structure for table `currency_rates`
--

CREATE TABLE `currency_rates` (
  `id` int(10) UNSIGNED NOT NULL,
  `currency` varchar(191) NOT NULL,
  `rate` decimal(8,4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currency_rates`
--

INSERT INTO `currency_rates` (`id`, `currency`, `rate`, `created_at`, `updated_at`) VALUES
(1, 'USD', '1.0000', '2023-08-09 06:24:38', '2023-08-09 06:24:38'),
(2, 'MYR', '1.0000', '2023-08-11 05:41:39', '2023-08-26 07:29:52');

-- --------------------------------------------------------

--
-- Table structure for table `customer_reward_points`
--

CREATE TABLE `customer_reward_points` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `customer_id` int(11) NOT NULL,
  `reward_type` enum('birthday','signup','firstorder','firstpayment','firstreview','manualoffer','order') DEFAULT NULL,
  `order_id` int(10) UNSIGNED DEFAULT NULL,
  `review_id` int(10) UNSIGNED DEFAULT NULL,
  `reward_points_earned` int(11) DEFAULT NULL,
  `reward_points_claimed` int(11) DEFAULT NULL,
  `expiry_date` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customer_reward_points`
--

INSERT INTO `customer_reward_points` (`id`, `customer_id`, `reward_type`, `order_id`, `review_id`, `reward_points_earned`, `reward_points_claimed`, `expiry_date`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 5, 'manualoffer', NULL, NULL, 100, NULL, '2023-10-01 17:57:10', NULL, '2023-09-21 17:57:10', '2023-10-05 18:33:49'),
(2, 4, 'manualoffer', NULL, NULL, 150, NULL, '2023-10-17 17:57:52', NULL, '2023-10-05 17:57:52', '2023-11-02 17:05:49'),
(12, 4, '', NULL, NULL, NULL, 50, NULL, NULL, '2023-09-26 18:41:29', '2023-11-02 17:05:49'),
(15, 5, '', NULL, NULL, NULL, 50, NULL, NULL, '2023-10-02 18:41:29', NULL),
(18, 5, 'manualoffer', NULL, NULL, 200, NULL, '2023-11-01 18:41:29', NULL, '2023-09-02 18:41:30', '2023-10-31 09:27:23'),
(20, 5, NULL, NULL, NULL, NULL, 100, NULL, NULL, '2023-10-18 18:41:29', '2023-10-31 09:28:13'),
(21, 7, 'manualoffer', NULL, NULL, 100, NULL, '2023-10-18 19:31:17', NULL, '2023-10-06 19:31:17', '2023-10-06 19:31:17'),
(22, 5, 'manualoffer', NULL, NULL, 140, NULL, '2023-10-29 13:42:57', NULL, '2023-10-07 13:42:57', '2023-10-31 09:28:58'),
(23, 2, 'manualoffer', NULL, NULL, 200, NULL, '2023-10-25 14:25:11', NULL, '2023-10-13 14:25:11', '2023-10-13 14:25:38'),
(40, 8, NULL, NULL, NULL, NULL, 200, NULL, NULL, '2023-10-28 16:41:01', '2023-10-28 16:41:01'),
(41, 8, NULL, NULL, NULL, NULL, 0, NULL, NULL, '2023-10-28 16:43:38', '2023-10-28 16:43:38'),
(43, 22, 'signup', NULL, NULL, 50, NULL, '2023-11-11 20:08:17', NULL, '2023-10-30 17:38:17', NULL),
(44, 4, NULL, NULL, NULL, NULL, 70, NULL, NULL, '2023-10-30 21:05:01', '2023-10-31 16:15:38'),
(45, 4, NULL, NULL, NULL, NULL, 100, NULL, NULL, '2023-10-30 21:08:33', '2023-10-30 21:08:33'),
(46, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-31 14:38:12', '2023-10-31 14:38:12'),
(47, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-31 14:39:25', '2023-10-31 14:39:25'),
(48, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-31 15:28:27', '2023-10-31 15:28:27'),
(49, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-31 15:30:37', '2023-10-31 15:30:37'),
(50, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-31 15:31:26', '2023-10-31 15:31:26'),
(51, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-31 15:42:15', '2023-10-31 15:42:15'),
(52, 4, 'firstorder', NULL, NULL, 100, NULL, '2023-11-12 15:42:17', NULL, '2023-10-31 13:12:17', NULL),
(53, 4, 'firstorder', NULL, NULL, 100, NULL, '2023-11-12 15:42:27', NULL, '2023-10-31 13:12:27', NULL),
(54, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2023-10-31 17:07:10', '2023-10-31 17:07:10'),
(55, 4, NULL, NULL, NULL, NULL, 25, NULL, NULL, '2023-10-31 18:49:24', '2023-10-31 18:49:24'),
(60, 4, NULL, NULL, NULL, NULL, 5, NULL, NULL, '2023-11-11 13:31:28', '2023-11-11 13:31:28'),
(61, 23, 'signup', NULL, NULL, 50, NULL, '2023-11-29 17:24:21', NULL, '2023-11-17 14:54:21', NULL),
(62, 23, NULL, NULL, NULL, NULL, 20, NULL, NULL, '2023-11-17 17:50:57', '2023-11-17 17:50:57');

-- --------------------------------------------------------

--
-- Table structure for table `default_addresses`
--

CREATE TABLE `default_addresses` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `address_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `default_addresses`
--

INSERT INTO `default_addresses` (`id`, `customer_id`, `address_id`) VALUES
(1, 1, 6),
(2, 5, 4),
(3, 4, 5),
(4, 6, 7),
(5, 7, 9),
(6, 8, 10),
(7, 23, 12);

-- --------------------------------------------------------

--
-- Table structure for table `emails`
--

CREATE TABLE `emails` (
  `id` int(10) UNSIGNED NOT NULL,
  `subscribers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`subscribers`)),
  `subject` varchar(191) NOT NULL,
  `template` varchar(191) NOT NULL,
  `date` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `emails`
--

INSERT INTO `emails` (`id`, `subscribers`, `subject`, `template`, `date`, `is_active`, `created_at`, `updated_at`) VALUES
(1, '[\"prabakaranpbk@gmail.com\",\"prabakaran@santhila.co\"]', 'Greetings', 'Welcome Mail', NULL, 0, '2023-11-01 14:05:21', '2023-11-01 14:05:21'),
(2, '[\"prabakaranpbk@gmail.com\",\"prabakaran@santhila.co\"]', 'TEst', 'Welcome Mail', NULL, 0, '2023-11-01 14:18:45', '2023-11-01 14:18:45'),
(3, '[\"prabakaranpbk@gmail.com\",\"prabakaran@santhila.co\"]', 'TEst', 'Welcome Mail', NULL, 0, '2023-11-01 14:19:26', '2023-11-01 14:19:26'),
(4, '[\"prabakaranpbk@gmail.com\",\"prabakaran@santhila.co\"]', 'TEst', 'Welcome Mail', NULL, 0, '2023-11-01 14:19:40', '2023-11-01 14:19:40'),
(5, '[\"prabakaranpbk@gmail.com\",\"prabakaran@santhila.co\"]', 'TEst', 'Welcome Mail', NULL, 0, '2023-11-01 14:19:52', '2023-11-01 14:19:52'),
(6, '[\"prabakaranpbk@gmail.com\",\"prabakaran@santhila.co\"]', 'TEst', 'Welcome Mail', NULL, 0, '2023-11-01 14:20:05', '2023-11-01 14:20:05'),
(7, '[\"prabakaranpbk@gmail.com\",\"prabakaran@santhila.co\"]', 'TEst', 'Welcome Mail', NULL, 0, '2023-11-01 14:21:02', '2023-11-01 14:21:02'),
(8, '[\"prabakaran@santhila.co\"]', 'Test', 'Welcome Mail', NULL, 0, '2023-11-01 14:22:40', '2023-11-01 14:22:40'),
(9, '[\"prabakaranpbk@gmail.com\",\"prabakaran@santhila.co\"]', 'test', 'Welcome Mail', NULL, 0, '2023-11-02 09:09:36', '2023-11-02 09:09:36'),
(10, '[\"prabakaranpbk@gmail.com\",\"prabakaran@santhila.co\"]', 'test', 'Welcome Mail', NULL, 0, '2023-11-02 09:09:44', '2023-11-02 09:09:44');

-- --------------------------------------------------------

--
-- Table structure for table `entity_files`
--

CREATE TABLE `entity_files` (
  `id` int(10) UNSIGNED NOT NULL,
  `file_id` int(10) UNSIGNED NOT NULL,
  `entity_type` varchar(191) NOT NULL,
  `entity_id` bigint(20) UNSIGNED NOT NULL,
  `zone` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `entity_files`
--

INSERT INTO `entity_files` (`id`, `file_id`, `entity_type`, `entity_id`, `zone`, `created_at`, `updated_at`) VALUES
(6, 4, 'Modules\\Brand\\Entities\\Brand', 1, 'logo', '2023-08-09 12:45:05', '2023-08-09 12:45:05'),
(24, 27, 'Modules\\Menu\\Entities\\MenuItem', 2, 'background_image', '2023-08-10 09:45:50', '2023-08-10 09:45:50'),
(25, 27, 'Modules\\Menu\\Entities\\MenuItem', 3, 'background_image', '2023-08-10 09:50:43', '2023-08-10 09:50:43'),
(57, 82, 'Modules\\Category\\Entities\\Category', 16, 'logo', '2023-08-14 06:21:16', '2023-08-14 06:21:16'),
(58, 82, 'Modules\\Category\\Entities\\Category', 16, 'banner', '2023-08-14 06:21:16', '2023-08-14 06:21:16'),
(59, 82, 'Modules\\Category\\Entities\\Category', 17, 'logo', '2023-08-14 06:50:49', '2023-08-14 06:50:49'),
(60, 82, 'Modules\\Category\\Entities\\Category', 17, 'banner', '2023-08-14 06:50:49', '2023-08-14 06:50:49'),
(73, 80, 'Modules\\Menu\\Entities\\MenuItem', 16, 'background_image', '2023-08-14 07:00:16', '2023-08-14 07:00:16'),
(74, 82, 'Modules\\Category\\Entities\\Category', 19, 'logo', '2023-08-14 07:04:17', '2023-08-14 07:04:17'),
(76, 86, 'Modules\\Category\\Entities\\Category', 18, 'logo', '2023-08-14 07:05:12', '2023-08-14 07:05:12'),
(77, 89, 'Modules\\Category\\Entities\\Category', 21, 'logo', '2023-08-14 07:06:25', '2023-08-14 07:06:25'),
(78, 15, 'Modules\\Category\\Entities\\Category', 3, 'logo', '2023-08-14 09:24:25', '2023-08-14 09:24:25'),
(82, 8, 'Modules\\Category\\Entities\\Category', 1, 'logo', '2023-08-14 09:45:09', '2023-08-14 09:45:09'),
(85, 8, 'Modules\\Category\\Entities\\Category', 15, 'logo', '2023-08-14 09:46:04', '2023-08-14 09:46:04'),
(206, 159, 'Modules\\Product\\Entities\\Product', 15, 'base_image', '2023-08-14 11:05:19', '2023-08-14 11:05:19'),
(207, 163, 'Modules\\Product\\Entities\\Product', 15, 'additional_images', '2023-08-14 11:05:19', '2023-08-14 11:05:19'),
(208, 162, 'Modules\\Product\\Entities\\Product', 15, 'additional_images', '2023-08-14 11:05:19', '2023-08-14 11:05:19'),
(209, 161, 'Modules\\Product\\Entities\\Product', 15, 'additional_images', '2023-08-14 11:05:19', '2023-08-14 11:05:19'),
(210, 160, 'Modules\\Product\\Entities\\Product', 15, 'additional_images', '2023-08-14 11:05:19', '2023-08-14 11:05:19'),
(211, 159, 'Modules\\Product\\Entities\\Product', 15, 'additional_images', '2023-08-14 11:05:19', '2023-08-14 11:05:19'),
(227, 168, 'Modules\\Product\\Entities\\Product', 16, 'base_image', '2023-08-14 11:27:22', '2023-08-14 11:27:22'),
(228, 176, 'Modules\\Product\\Entities\\Product', 16, 'additional_images', '2023-08-14 11:27:22', '2023-08-14 11:27:22'),
(229, 175, 'Modules\\Product\\Entities\\Product', 16, 'additional_images', '2023-08-14 11:27:22', '2023-08-14 11:27:22'),
(230, 174, 'Modules\\Product\\Entities\\Product', 16, 'additional_images', '2023-08-14 11:27:22', '2023-08-14 11:27:22'),
(251, 188, 'Modules\\Product\\Entities\\Product', 17, 'base_image', '2023-08-14 12:06:21', '2023-08-14 12:06:21'),
(252, 189, 'Modules\\Product\\Entities\\Product', 17, 'additional_images', '2023-08-14 12:06:21', '2023-08-14 12:06:21'),
(253, 188, 'Modules\\Product\\Entities\\Product', 17, 'additional_images', '2023-08-14 12:06:21', '2023-08-14 12:06:21'),
(254, 187, 'Modules\\Product\\Entities\\Product', 17, 'additional_images', '2023-08-14 12:06:21', '2023-08-14 12:06:21'),
(255, 186, 'Modules\\Product\\Entities\\Product', 17, 'additional_images', '2023-08-14 12:06:21', '2023-08-14 12:06:21'),
(256, 185, 'Modules\\Product\\Entities\\Product', 17, 'additional_images', '2023-08-14 12:06:21', '2023-08-14 12:06:21'),
(276, 198, 'Modules\\Product\\Entities\\Product', 13, 'base_image', '2023-08-14 12:19:42', '2023-08-14 12:19:42'),
(277, 198, 'Modules\\Product\\Entities\\Product', 13, 'additional_images', '2023-08-14 12:19:42', '2023-08-14 12:19:42'),
(278, 156, 'Modules\\Product\\Entities\\Product', 13, 'additional_images', '2023-08-14 12:19:42', '2023-08-14 12:19:42'),
(281, 192, 'Modules\\Product\\Entities\\Product', 9, 'base_image', '2023-08-14 12:20:29', '2023-08-14 12:20:29'),
(282, 193, 'Modules\\Product\\Entities\\Product', 9, 'additional_images', '2023-08-14 12:20:29', '2023-08-14 12:20:29'),
(283, 190, 'Modules\\Product\\Entities\\Product', 9, 'additional_images', '2023-08-14 12:20:29', '2023-08-14 12:20:29'),
(284, 192, 'Modules\\Product\\Entities\\Product', 9, 'additional_images', '2023-08-14 12:20:29', '2023-08-14 12:20:29'),
(285, 191, 'Modules\\Product\\Entities\\Product', 9, 'additional_images', '2023-08-14 12:20:29', '2023-08-14 12:20:29'),
(286, 114, 'Modules\\Product\\Entities\\Product', 6, 'base_image', '2023-08-14 12:22:16', '2023-08-14 12:22:16'),
(287, 183, 'Modules\\Product\\Entities\\Product', 6, 'additional_images', '2023-08-14 12:22:16', '2023-08-14 12:22:16'),
(288, 114, 'Modules\\Product\\Entities\\Product', 6, 'additional_images', '2023-08-14 12:22:16', '2023-08-14 12:22:16'),
(289, 199, 'Modules\\Product\\Entities\\Product', 6, 'additional_images', '2023-08-14 12:22:16', '2023-08-14 12:22:16'),
(314, 141, 'Modules\\Product\\Entities\\Product', 10, 'base_image', '2023-08-14 12:29:16', '2023-08-14 12:29:16'),
(315, 144, 'Modules\\Product\\Entities\\Product', 10, 'additional_images', '2023-08-14 12:29:16', '2023-08-14 12:29:16'),
(316, 143, 'Modules\\Product\\Entities\\Product', 10, 'additional_images', '2023-08-14 12:29:16', '2023-08-14 12:29:16'),
(317, 142, 'Modules\\Product\\Entities\\Product', 10, 'additional_images', '2023-08-14 12:29:16', '2023-08-14 12:29:16'),
(318, 141, 'Modules\\Product\\Entities\\Product', 10, 'additional_images', '2023-08-14 12:29:16', '2023-08-14 12:29:16'),
(319, 140, 'Modules\\Product\\Entities\\Product', 10, 'additional_images', '2023-08-14 12:29:16', '2023-08-14 12:29:16'),
(320, 139, 'Modules\\Product\\Entities\\Product', 10, 'additional_images', '2023-08-14 12:29:16', '2023-08-14 12:29:16'),
(321, 138, 'Modules\\Product\\Entities\\Product', 10, 'additional_images', '2023-08-14 12:29:16', '2023-08-14 12:29:16'),
(322, 206, 'Modules\\Category\\Entities\\Category', 5, 'logo', '2023-08-14 12:32:39', '2023-08-14 12:32:39'),
(326, 207, 'Modules\\Category\\Entities\\Category', 2, 'logo', '2023-08-14 12:41:28', '2023-08-14 12:41:28'),
(327, 208, 'Modules\\Category\\Entities\\Category', 4, 'logo', '2023-08-14 12:42:31', '2023-08-14 12:42:31'),
(328, 87, 'Modules\\Category\\Entities\\Category', 20, 'logo', '2023-08-16 06:06:19', '2023-08-16 06:06:19'),
(372, 113, 'Modules\\Product\\Entities\\Product', 5, 'base_image', '2023-08-25 06:43:56', '2023-08-25 06:43:56'),
(373, 113, 'Modules\\Product\\Entities\\Product', 5, 'additional_images', '2023-08-25 06:43:56', '2023-08-25 06:43:56'),
(402, 125, 'Modules\\Product\\Entities\\Product', 7, 'base_image', '2023-08-25 06:54:56', '2023-08-25 06:54:56'),
(403, 127, 'Modules\\Product\\Entities\\Product', 7, 'additional_images', '2023-08-25 06:54:56', '2023-08-25 06:54:56'),
(404, 126, 'Modules\\Product\\Entities\\Product', 7, 'additional_images', '2023-08-25 06:54:56', '2023-08-25 06:54:56'),
(405, 125, 'Modules\\Product\\Entities\\Product', 7, 'additional_images', '2023-08-25 06:54:56', '2023-08-25 06:54:56'),
(406, 124, 'Modules\\Product\\Entities\\Product', 7, 'additional_images', '2023-08-25 06:54:56', '2023-08-25 06:54:56'),
(407, 122, 'Modules\\Product\\Entities\\Product', 7, 'additional_images', '2023-08-25 06:54:56', '2023-08-25 06:54:56'),
(408, 116, 'Modules\\Product\\Entities\\Product', 3, 'base_image', '2023-08-25 06:55:49', '2023-08-25 06:55:49'),
(409, 116, 'Modules\\Product\\Entities\\Product', 3, 'additional_images', '2023-08-25 06:55:49', '2023-08-25 06:55:49'),
(410, 33, 'Modules\\Product\\Entities\\Product', 3, 'additional_images', '2023-08-25 06:55:49', '2023-08-25 06:55:49'),
(422, 132, 'Modules\\Product\\Entities\\Product', 8, 'base_image', '2023-08-25 06:58:49', '2023-08-25 06:58:49'),
(423, 134, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-25 06:58:49', '2023-08-25 06:58:49'),
(424, 133, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-25 06:58:49', '2023-08-25 06:58:49'),
(425, 132, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-25 06:58:49', '2023-08-25 06:58:49'),
(426, 131, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-25 06:58:49', '2023-08-25 06:58:49'),
(427, 130, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-25 06:58:49', '2023-08-25 06:58:49'),
(428, 129, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-25 06:58:49', '2023-08-25 06:58:49'),
(429, 196, 'Modules\\Product\\Entities\\Product', 4, 'base_image', '2023-08-25 06:59:02', '2023-08-25 06:59:02'),
(430, 197, 'Modules\\Product\\Entities\\Product', 4, 'additional_images', '2023-08-25 06:59:02', '2023-08-25 06:59:02'),
(431, 180, 'Modules\\Product\\Entities\\Product', 4, 'additional_images', '2023-08-25 06:59:02', '2023-08-25 06:59:02'),
(507, 145, 'Modules\\Product\\Entities\\Product', 11, 'base_image', '2023-08-25 11:51:19', '2023-08-25 11:51:19'),
(508, 145, 'Modules\\Product\\Entities\\Product', 11, 'additional_images', '2023-08-25 11:51:19', '2023-08-25 11:51:19'),
(509, 146, 'Modules\\Product\\Entities\\Product', 11, 'additional_images', '2023-08-25 11:51:19', '2023-08-25 11:51:19'),
(510, 147, 'Modules\\Product\\Entities\\Product', 11, 'additional_images', '2023-08-25 11:51:19', '2023-08-25 11:51:19'),
(511, 149, 'Modules\\Product\\Entities\\Product', 11, 'additional_images', '2023-08-25 11:51:19', '2023-08-25 11:51:19'),
(512, 155, 'Modules\\Product\\Entities\\Product', 12, 'base_image', '2023-08-25 11:57:26', '2023-08-25 11:57:26'),
(513, 154, 'Modules\\Product\\Entities\\Product', 12, 'additional_images', '2023-08-25 11:57:26', '2023-08-25 11:57:26'),
(518, 26, 'Modules\\Product\\Entities\\Product', 1, 'base_image', '2023-08-25 13:19:07', '2023-08-25 13:19:07'),
(519, 26, 'Modules\\Product\\Entities\\Product', 1, 'additional_images', '2023-08-25 13:19:07', '2023-08-25 13:19:07'),
(534, 215, 'Modules\\Product\\Entities\\Product', 18, 'downloads', '2023-08-25 13:28:20', '2023-08-25 13:28:20'),
(539, 202, 'Modules\\Product\\Entities\\Product', 18, 'base_image', '2023-08-26 10:03:55', '2023-08-26 10:03:55'),
(540, 204, 'Modules\\Product\\Entities\\Product', 18, 'additional_images', '2023-08-26 10:03:55', '2023-08-26 10:03:55'),
(541, 202, 'Modules\\Product\\Entities\\Product', 18, 'additional_images', '2023-08-26 10:03:55', '2023-08-26 10:03:55'),
(542, 201, 'Modules\\Product\\Entities\\Product', 18, 'additional_images', '2023-08-26 10:03:55', '2023-08-26 10:03:55'),
(543, 198, 'Modules\\Menu\\Entities\\MenuItem', 43, 'background_image', '2023-08-28 09:22:21', '2023-08-28 09:22:21'),
(544, 12, 'Modules\\Brand\\Entities\\Brand', 2, 'logo', '2023-08-28 09:23:31', '2023-08-28 09:23:31'),
(545, 3, 'Modules\\Brand\\Entities\\Brand', 2, 'banner', '2023-08-28 09:23:31', '2023-08-28 09:23:31'),
(564, 218, 'Modules\\Product\\Entities\\Product', 24, 'base_image', '2023-09-01 15:30:44', '2023-09-01 15:30:44'),
(565, 220, 'Modules\\Product\\Entities\\Product', 24, 'additional_images', '2023-09-01 15:30:44', '2023-09-01 15:30:44'),
(566, 219, 'Modules\\Product\\Entities\\Product', 24, 'additional_images', '2023-09-01 15:30:44', '2023-09-01 15:30:44'),
(567, 218, 'Modules\\Product\\Entities\\Product', 24, 'additional_images', '2023-09-01 15:30:44', '2023-09-01 15:30:44'),
(568, 217, 'Modules\\Product\\Entities\\Product', 24, 'additional_images', '2023-09-01 15:30:44', '2023-09-01 15:30:44'),
(569, 216, 'Modules\\Product\\Entities\\Product', 24, 'additional_images', '2023-09-01 15:30:44', '2023-09-01 15:30:44'),
(570, 221, 'Modules\\Product\\Entities\\Product', 25, 'base_image', '2023-10-06 14:04:57', '2023-10-06 14:04:57'),
(583, 167, 'Modules\\Product\\Entities\\Product', 14, 'base_image', '2023-11-03 10:12:19', '2023-11-03 10:12:19'),
(584, 167, 'Modules\\Product\\Entities\\Product', 14, 'additional_images', '2023-11-03 10:12:19', '2023-11-03 10:12:19'),
(585, 165, 'Modules\\Product\\Entities\\Product', 14, 'additional_images', '2023-11-03 10:12:19', '2023-11-03 10:12:19'),
(586, 166, 'Modules\\Product\\Entities\\Product', 14, 'additional_images', '2023-11-03 10:12:19', '2023-11-03 10:12:19'),
(587, 164, 'Modules\\Product\\Entities\\Product', 14, 'additional_images', '2023-11-03 10:12:19', '2023-11-03 10:12:19'),
(588, 34, 'Modules\\Product\\Entities\\Product', 2, 'base_image', '2023-11-03 10:14:11', '2023-11-03 10:14:11'),
(589, 34, 'Modules\\Product\\Entities\\Product', 2, 'additional_images', '2023-11-03 10:14:11', '2023-11-03 10:14:11'),
(590, 185, 'Modules\\Product\\Entities\\Product', 26, 'base_image', '2023-11-17 10:37:40', '2023-11-17 10:37:40'),
(591, 189, 'Modules\\Product\\Entities\\Product', 26, 'additional_images', '2023-11-17 10:37:40', '2023-11-17 10:37:40'),
(592, 188, 'Modules\\Product\\Entities\\Product', 26, 'additional_images', '2023-11-17 10:37:40', '2023-11-17 10:37:40'),
(593, 226, 'Modules\\Product\\Entities\\Product', 27, 'base_image', '2023-11-17 10:52:57', '2023-11-17 10:52:57'),
(594, 226, 'Modules\\Product\\Entities\\Product', 27, 'additional_images', '2023-11-17 10:52:57', '2023-11-17 10:52:57');

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `filename` varchar(191) NOT NULL,
  `disk` varchar(191) NOT NULL,
  `path` varchar(191) NOT NULL,
  `extension` varchar(191) NOT NULL,
  `mime` varchar(191) NOT NULL,
  `size` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`id`, `user_id`, `filename`, `disk`, `path`, `extension`, `mime`, `size`, `created_at`, `updated_at`) VALUES
(1, 1, '634f4e5785dd2f33274fdfe3-wisteria-garland-flower-vines-wisteria.jpg', 'public_storage', 'media/h57Co5xBqh80PgfFNc2mODhsBazHIPEIb4HMwQYH.jpg', 'jpg', 'image/jpeg', '211920', '2023-08-09 12:36:18', '2023-08-09 12:36:18'),
(2, 1, 'bridal-bouquet-2-1-300x300.jpg', 'public_storage', 'media/chfoQU5cJP4x0avmLFreBXajAUAVXaLfsYtQIGI9.jpg', 'jpg', 'image/jpeg', '27724', '2023-08-09 12:36:37', '2023-08-09 12:36:37'),
(3, 1, 'basket1.jpg', 'public_storage', 'media/L1RN8Ce2rc3MHIzJWK72GqQEVebLuT7GRqJNnbnf.jpg', 'jpg', 'image/jpeg', '174954', '2023-08-09 12:36:43', '2023-08-09 12:36:43'),
(4, 1, 'logo-1.jpg', 'public_storage', 'media/cqsxiKjFKjhAfquR0im9UXxbF07J69cRv2KeGXq4.jpg', 'jpg', 'image/jpeg', '54442', '2023-08-09 12:37:12', '2023-08-09 12:37:12'),
(5, 1, 'maingar3-300x300.jpg', 'public_storage', 'media/FhePh7ylLJ03D8ul2EWuOkhE46vFgOoanzARNwj7.jpg', 'jpg', 'image/jpeg', '13961', '2023-08-09 12:37:12', '2023-08-09 12:37:12'),
(6, 1, 'maingar-150x150.jpg', 'public_storage', 'media/LXEdHsbDpGD77qidnVQogH71K4sBrqmiqwsPqTba.jpg', 'jpg', 'image/jpeg', '5719', '2023-08-09 12:37:12', '2023-08-09 12:37:12'),
(7, 1, 'mango-leaf-copy-2-150x150.jpg', 'public_storage', 'media/gnlqA6krxHPZYS5Iov0MGuIfeMawRQ7lz91vAAGM.jpg', 'jpg', 'image/jpeg', '6467', '2023-08-09 12:37:12', '2023-08-09 12:37:12'),
(8, 1, '250x158-pooja-300x300.jpg', 'public_storage', 'media/oWJMFEy4PCyT2lYWxwnksgGFtDwNSR95BW95d4d0.jpg', 'jpg', 'image/jpeg', '32240', '2023-08-09 12:37:28', '2023-08-09 12:37:28'),
(9, 1, 'handbouquet-300x300.jpg', 'public_storage', 'media/bur6uDFIigxTqWyY4ISumFmqtV5VWYrBuRVDadgw.jpg', 'jpg', 'image/jpeg', '17966', '2023-08-09 12:37:45', '2023-08-09 12:37:45'),
(10, 1, 'dsc-2068.jpg', 'public_storage', 'media/d75sf76L68DFQTlKCo883g4QEFXF1atHUgVVQdxi.jpg', 'jpg', 'image/jpeg', '587165', '2023-08-09 12:38:59', '2023-08-09 12:38:59'),
(11, 1, 'jasmine.jpg', 'public_storage', 'media/Nn52PxwN985bKYN6YjFDHCfMgCKMxKVTybp9kG3k.jpg', 'jpg', 'image/jpeg', '9100', '2023-08-09 12:40:37', '2023-08-09 12:40:37'),
(12, 1, 'bridal-bouquet-2-1-150x150.jpg', 'public_storage', 'media/q1uduqSshch4io8NZHExhWOak2gwL5ZLpDKPGTDM.jpg', 'jpg', 'image/jpeg', '9843', '2023-08-09 12:41:09', '2023-08-09 12:41:09'),
(13, 1, 'c-346-01.jpg', 'public_storage', 'media/4Bfyw0IIf9yobzQ961PLCxUHHWvmV2x7jvBEfol8.jpg', 'jpg', 'image/jpeg', '185770', '2023-08-09 12:41:09', '2023-08-09 12:41:09'),
(14, 1, 'c-346-01-300x300.jpg', 'public_storage', 'media/eMzgJiJopXH3mEE5eBxjPxkOJi9WWlQ5K3DyDwhp.jpg', 'jpg', 'image/jpeg', '10960', '2023-08-09 12:41:10', '2023-08-09 12:41:10'),
(15, 1, 'engaementgarland-300x300.jpg', 'public_storage', 'media/Su6bppk6s8lcrLLy3L0km7C0q1nEOrwUnSHiYhpW.jpg', 'jpg', 'image/jpeg', '23875', '2023-08-09 12:41:10', '2023-08-09 12:41:10'),
(16, 1, 'lilly-garland-300x300.jpg', 'public_storage', 'media/YGe1muWuOU7gzFGJkL3wIgdmfGe6tq4I0hBLjkZq.jpg', 'jpg', 'image/jpeg', '37672', '2023-08-09 12:41:11', '2023-08-09 12:41:11'),
(17, 1, 'rp-102-1-300x300.jpg', 'public_storage', 'media/6JGApWuaW7i8nnWl4JW61dvFN6yhO1BPZgfYQGqE.jpg', 'jpg', 'image/jpeg', '10616', '2023-08-09 12:41:11', '2023-08-09 12:41:11'),
(18, 1, 'temple.jpg', 'public_storage', 'media/cDmQDvDukzmyF3jkISK28HUNfQC3YsjBUt8Sai7q.jpg', 'jpg', 'image/jpeg', '53323', '2023-08-09 12:41:12', '2023-08-09 12:41:12'),
(19, 1, 'thulasi-garlend-300x300.jpg', 'public_storage', 'media/VMKInX6EJQNi8ODOo5iSpHYU4A3b1ptCoFxjvpiy.jpg', 'jpg', 'image/jpeg', '27151', '2023-08-09 12:41:12', '2023-08-09 12:41:12'),
(20, 1, 'Nn52PxwN985bKYN6YjFDHCfMgCKMxKVTybp9kG3k.jpg', 'public_storage', 'media/kaCs7mekjehnKxouBsyIj05P08rEkWgHEKCysEH6.jpg', 'jpg', 'image/jpeg', '9100', '2023-08-09 12:41:12', '2023-08-09 12:41:12'),
(21, 1, 'vadamalli-garland.jpg', 'public_storage', 'media/K1WkUPPGTsUWEOcvbZnMdOcUL8ts3G1VmcnKHSKn.jpg', 'jpg', 'image/jpeg', '1000558', '2023-08-09 12:41:12', '2023-08-09 12:41:12'),
(22, 1, 'kaCs7mekjehnKxouBsyIj05P08rEkWgHEKCysEH6.jpg', 'public_storage', 'media/8GwnzNsGSdudD2vEsk4Kns61HkwIgOT9mhQBSBI3.jpg', 'jpg', 'image/jpeg', '9100', '2023-08-09 12:41:19', '2023-08-09 12:41:19'),
(23, 1, '8GwnzNsGSdudD2vEsk4Kns61HkwIgOT9mhQBSBI3.jpg', 'public_storage', 'media/dVJx6jWeKQUtrdMTuN59sus5WNJceDGgcxIgVuyU.jpg', 'jpg', 'image/jpeg', '9100', '2023-08-09 12:41:39', '2023-08-09 12:41:39'),
(24, 1, 'dVJx6jWeKQUtrdMTuN59sus5WNJceDGgcxIgVuyU.jpg', 'public_storage', 'media/UQyJkr2E8dExXQSA1d76lItVq0virxtJiN7ymULW.jpg', 'jpg', 'image/jpeg', '9100', '2023-08-09 12:41:45', '2023-08-09 12:41:45'),
(25, 1, 'UQyJkr2E8dExXQSA1d76lItVq0virxtJiN7ymULW.jpg', 'public_storage', 'media/tUccninNUm4JpC8R2OtuWxO1pndg5cR4IvDioUX9.jpg', 'jpg', 'image/jpeg', '9100', '2023-08-09 12:42:04', '2023-08-09 12:42:04'),
(26, 1, 'tUccninNUm4JpC8R2OtuWxO1pndg5cR4IvDioUX9.jpg', 'public_storage', 'media/dU3ROcK1SbiRneVeed3wRGqaX6a6Pr6Kdi7ksvzf.jpg', 'jpg', 'image/jpeg', '9100', '2023-08-09 12:45:13', '2023-08-09 12:45:13'),
(27, 1, 'dU3ROcK1SbiRneVeed3wRGqaX6a6Pr6Kdi7ksvzf.jpg', 'public_storage', 'media/ENrZ4eervCCuEpa14vuqe27c4YGU9GKNJ2jglpz2.jpg', 'jpg', 'image/jpeg', '9100', '2023-08-09 12:45:35', '2023-08-09 12:45:35'),
(28, 1, 'DSC_2079.jpg', 'public_storage', 'media/DStBCL0tpmZHU82nBRUXOG2RE1uIpKO0vvfW6n4Z.jpg', 'jpg', 'image/jpeg', '383493', '2023-08-09 12:56:53', '2023-08-09 12:56:53'),
(29, 1, 'DSC_2078.jpg', 'public_storage', 'media/NL0ET0aQzsqYzrGHjR0ox1dT1b6DQ1VB9UBR0jDg.jpg', 'jpg', 'image/jpeg', '337498', '2023-08-09 12:56:53', '2023-08-09 12:56:53'),
(30, 1, 'images.jfif', 'public_storage', 'media/aGxkFN8utAyEve4H4LK4cWc3L0LvBSLZtWYpCeVa.jpg', 'jpg', 'image/jpeg', '12100', '2023-08-10 10:14:37', '2023-08-10 10:14:37'),
(31, 1, 'banner1.jpg', 'public_storage', 'media/7mwD6fJRs9OK126f1RpwjWeU64k667AJJoQyVCP6.jpg', 'jpg', 'image/jpeg', '54950', '2023-08-10 10:57:34', '2023-08-10 10:57:34'),
(32, 1, 'banner1.jpg', 'public_storage', 'media/DwIj5Pr3ak4ir5KyYIBlXIgJG1vhiD87F1kJU7p8.jpg', 'jpg', 'image/jpeg', '54950', '2023-08-10 10:57:51', '2023-08-10 10:57:51'),
(33, 1, 'jasmine-1.jpg', 'public_storage', 'media/gipJppdIIJJRyysp063nWvzC2fLftu1Hbnxp7tyu.jpg', 'jpg', 'image/jpeg', '10057', '2023-08-10 10:59:27', '2023-08-10 10:59:27'),
(34, 1, '178fd01741f2d60d00bb8f9c50e4cc6e.jpg', 'public_storage', 'media/SQAHsKySbG4uP5ptgXFH7VkYrgCU2aapy1ANh8R5.jpg', 'jpg', 'image/jpeg', '28210', '2023-08-10 12:37:59', '2023-08-10 12:37:59'),
(35, 1, 'bloomthis-bloombag-marissa-white-lily-bloombag-1080x1080-01_400x.webp', 'public_storage', 'media/yrHpWEIOUIxjmlR2ZZZAGHLgI89jR2g9VpRhdNTS.webp', 'webp', 'image/webp', '26514', '2023-08-11 07:51:27', '2023-08-11 07:51:27'),
(36, 1, 'bloomthis-collection-slot-card-01-free-same-day-delivery.webp', 'public_storage', 'media/WOr9NhR1sXdd1rnEMg7NrplSACmlSJTIM17tSbzY.webp', 'webp', 'image/webp', '24138', '2023-08-11 07:51:54', '2023-08-11 07:51:54'),
(37, 1, 'images.png', 'public_storage', 'media/7DtnhnPgIlIZHxxd3l2HXsU0xWdWiOw2tp20YDw7.png', 'png', 'image/png', '9458', '2023-08-11 07:52:14', '2023-08-11 07:52:14'),
(38, 1, 'iStock-525792007-scaled.jpg', 'public_storage', 'media/IuzqmDGnQfK41PRf83JRgloMLSmLvziXxr71yaJU.jpg', 'jpg', 'image/jpeg', '280473', '2023-08-11 07:53:48', '2023-08-11 07:53:48'),
(59, 1, '20881731.jpg', 'public_storage', 'media/gTp2IVlmEDXQCMqLpOODq1M1toGEnfcUGMeqgS4D.jpg', 'jpg', 'image/jpeg', '148734', '2023-08-12 08:09:45', '2023-08-12 08:09:45'),
(60, 1, '1440724370_13.png', 'public_storage', 'media/jz3iXkkKFtwCx3W8DX8lYWDR1LNOeCxUG5tuuKZD.png', 'png', 'image/png', '616466', '2023-08-12 08:09:46', '2023-08-12 08:09:46'),
(61, 1, '781271364902d6a6135c094571ecdae8606949ef.webp', 'public_storage', 'media/nQ5mtiv8sX8fDlObz2lEf05HJZdp0HF2lZQ1z3Yd.webp', 'webp', 'image/webp', '59732', '2023-08-12 08:09:46', '2023-08-12 08:09:46'),
(63, 1, '48939848523_35e1762542_b.jpg', 'public_storage', 'media/1LZagMpI90pLMfeQM5oryHan7Q6BarSgu7s00UHB.jpg', 'jpg', 'image/jpeg', '387242', '2023-08-12 08:11:45', '2023-08-12 08:11:45'),
(64, 1, 'images (3).jpg', 'public_storage', 'media/pLyiRWrUQ0StiZj8NLa075Q3JHWBc0gUVNdfWtB8.jpg', 'jpg', 'image/jpeg', '10134', '2023-08-12 08:12:53', '2023-08-12 08:12:53'),
(65, 1, 'image001-1024x683.jpg', 'public_storage', 'media/Bq8VVi9hgY5aOrhPcLzIzIjsW3cLn3rIHHXSGmRp.jpg', 'jpg', 'image/jpeg', '81225', '2023-08-12 08:30:14', '2023-08-12 08:30:14'),
(66, 1, 'istockphoto-1458402436-170667a.jpg', 'public_storage', 'media/PiGLD2T9iiNtH47L1mTlBIUSjBCVhpYxr36UkccR.jpg', 'jpg', 'image/jpeg', '208825', '2023-08-14 04:40:27', '2023-08-14 04:40:27'),
(67, 1, '1000_F_188459907_kLnbxIvxtzgPs5j7cCZpLXPjjppD7C0i.jpg', 'public_storage', 'media/YxJ5Ngst5sjaXZNv0v3N5ONx8CStkb7gzJrMURo4.jpg', 'jpg', 'image/jpeg', '318845', '2023-08-14 04:46:00', '2023-08-14 04:46:00'),
(68, 1, 'best-places-to-see-flowers-in-melbourne-1024x683.jpg', 'public_storage', 'media/mTWpDdoPsXJIxWi2Ov3kFBxgRGZZaNQdI2BwftPi.jpg', 'jpg', 'image/jpeg', '44326', '2023-08-14 04:46:17', '2023-08-14 04:46:17'),
(69, 1, '642_How_to_Make_Grocery_Store_Flowers_Look_Like_They_Came_From_a_Florist_Body-1024x683.jpg', 'public_storage', 'media/5c027ZqBBAFExWCs5U5mkGVX1Dd7XkyynEXieLIJ.jpg', 'jpg', 'image/jpeg', '177625', '2023-08-14 04:52:25', '2023-08-14 04:52:25'),
(70, 1, '245-2457433_flower-field-png-marigold-flor.png', 'public_storage', 'media/AdPFMiEL25YIg0jHD43G0unL52TmXq1K3u3CEfvu.png', 'png', 'image/png', '1262861', '2023-08-14 04:52:25', '2023-08-14 04:52:25'),
(71, 1, 'pink-white-flowers-close-up.jpg', 'public_storage', 'media/5bAoFtiI7IikNxdHhuLv4E9UDbtRPmPVotsSe6oV.jpg', 'jpg', 'image/jpeg', '11938403', '2023-08-14 04:55:55', '2023-08-14 04:55:55'),
(72, 1, 'roses-with-background-defocused.jpg', 'public_storage', 'media/laCwQsFtavFfmEh2m9vLo6smvcmjnDmxvjZNYEFj.jpg', 'jpg', 'image/jpeg', '5057719', '2023-08-14 05:01:26', '2023-08-14 05:01:26'),
(74, 1, 'jasmine-flower-background_34266-952.jpg', 'public_storage', 'media/EAwOLJLswcNUboTjq1BDN2Ekfjq5Q2oLQlebK4Pj.jpg', 'jpg', 'image/jpeg', '63937', '2023-08-14 05:02:05', '2023-08-14 05:02:05'),
(75, 1, '1000_F_559551236_mbLFa3enV2ALrVqHy3T6gsYinYLcmwWm.jpg', 'public_storage', 'media/MBEPrUBonS9yfjUQW7AfieeAVyYV4HhVu4ZBdZ1L.jpg', 'jpg', 'image/jpeg', '364868', '2023-08-14 05:11:52', '2023-08-14 05:11:52'),
(76, 1, 'tulips-floral-background_108930-2690.jpg', 'public_storage', 'media/eFOD12TkPFTKLiahJXT0OEtB45hzNVeYrH4BUeWZ.jpg', 'jpg', 'image/jpeg', '72419', '2023-08-14 05:16:12', '2023-08-14 05:16:12'),
(77, 1, 'aps-logo123.png', 'public_storage', 'media/zNnZ9JSsPhlLxZz3rwCoAcpImBpvDGwsoJ1K6vWn.png', 'png', 'image/png', '148625', '2023-08-14 05:24:34', '2023-08-14 05:24:34'),
(78, 1, '240_F_286829530_C5L4tw5pTsUtXJH5aeOuGl3CIAXrUdQX.jpg', 'public_storage', 'media/9ASX2ZtIicw5aAEb65v4GX6IwjfKVENPSiip6uty.jpg', 'jpg', 'image/jpeg', '41557', '2023-08-14 05:56:13', '2023-08-14 05:56:13'),
(79, 1, 'chamomile-1024x683.jpg', 'public_storage', 'media/49NkKpyYY7N1dzJ96qbdxp5t6S8t1U9I39DxyXqR.jpg', 'jpg', 'image/jpeg', '91102', '2023-08-14 05:56:14', '2023-08-14 05:56:14'),
(80, 1, 'Wedding-Sample-3-flower-cown.jpg', 'public_storage', 'media/iaaxDfrg5WyFR8i6yE4p575n7AgXhOrAVJxK71QJ.jpg', 'jpg', 'image/jpeg', '76584', '2023-08-14 05:56:14', '2023-08-14 05:56:14'),
(82, 1, 'intersection-1-300x300.png', 'public_storage', 'media/O6heEKF9Lz6iPcNd9J0xFcvHw9OKrPURsUDbBYAc.png', 'png', 'image/png', '10711', '2023-08-14 06:20:50', '2023-08-14 06:20:50'),
(84, 1, 'mixed-anemone-flowers.zip', 'public_storage', 'media/lxZtX4QmtSev48DB06RAQ4gmTiDqsFASxYqfuCeK.zip', 'zip', 'application/zip', '34176377', '2023-08-14 06:48:36', '2023-08-14 06:48:36'),
(85, 1, 'beautiful-tulips-bucket-isolated-white_392895-77533.jpg', 'public_storage', 'media/4gLgQ35tejreOkP6FzlUbLPSwuXAj16TTnhPkd3z.jpg', 'jpg', 'image/jpeg', '83180', '2023-08-14 06:49:29', '2023-08-14 06:49:29'),
(86, 1, 'download.jfif', 'public_storage', 'media/Gq69aNHjjKKzsOJra7CfFCDuZaWjdGVlJx5jv0Pr.jpg', 'jpg', 'image/jpeg', '10490', '2023-08-14 06:50:19', '2023-08-14 06:50:19'),
(87, 1, 'images (1).png', 'public_storage', 'media/6W1RLExqFPwixi6pZc1E9dvuwQNmLdUGrNCqIkmx.png', 'png', 'image/png', '11894', '2023-08-14 06:54:47', '2023-08-14 06:54:47'),
(88, 1, 'download-28-300x300.jpg', 'public_storage', 'media/5rHfpCXFJmzl6raq3erdZnzWNaNyIZOsmDPt5ZgC.jpg', 'jpg', 'image/jpeg', '27861', '2023-08-14 06:56:26', '2023-08-14 06:56:26'),
(89, 1, 'jasmine-3-150x150.jpg', 'public_storage', 'media/Cus2N4sK9xFCLuE5FHjF3qA8p2Sy9VL9Aqg81ZHK.jpg', 'jpg', 'image/jpeg', '10363', '2023-08-14 06:57:06', '2023-08-14 06:57:06'),
(90, 1, 'jasmine-4.jpg', 'public_storage', 'media/VAWc30IjOhMcUhxJF8bQOo051sWGVVCHV2ZsZwsH.jpg', 'jpg', 'image/jpeg', '2203698', '2023-08-14 06:57:07', '2023-08-14 06:57:07'),
(92, 1, 'beautiful-pink-lotus_44272-51.jpg', 'public_storage', 'media/YyEcBs8IdLGeBd7RC32v9lVlEo3IwuEWHNzvoyAS.jpg', 'jpg', 'image/jpeg', '74561', '2023-08-14 07:05:16', '2023-08-14 07:05:16'),
(93, 1, 'closeup-shot-beautiful-pink-tulips-white-surface_181624-33642.jpg', 'public_storage', 'media/5ERkRuY1NW4uGojNlyt9VBQzfxwofgzu2m0Bp8zS.jpg', 'jpg', 'image/jpeg', '78478', '2023-08-14 07:26:10', '2023-08-14 07:26:10'),
(94, 1, 'images (11).jpg', 'public_storage', 'media/YL9qmnsGXqOrmEFt8I5vq1arWfSvGx3Tmt28Nzx0.jpg', 'jpg', 'image/jpeg', '8996', '2023-08-14 07:43:55', '2023-08-14 07:43:55'),
(95, 1, 'wedding-invitation-with-lovely-colorful-flowers_1035-19833.jpg', 'public_storage', 'media/div9iiduLBNmc1gNNewTPxKtrpF1ZuqxeMhsbJKS.jpg', 'jpg', 'image/jpeg', '40684', '2023-08-14 07:51:41', '2023-08-14 07:51:41'),
(96, 1, 'watercolor-spring-floral-element_1340-8127.jpg', 'public_storage', 'media/dvIruuejlE6fmw3F8vw8kUWSKSHmIHX9fDnChxoI.jpg', 'jpg', 'image/jpeg', '79045', '2023-08-14 07:51:42', '2023-08-14 07:51:42'),
(97, 1, 'bunch-red-pink-roses_77116-32 (1).jpg', 'public_storage', 'media/BSxaXfooF2GTRVLXdds9XBtG1ofXnBAMs5iCoQVN.jpg', 'jpg', 'image/jpeg', '45171', '2023-08-14 07:57:35', '2023-08-14 07:57:35'),
(98, 1, 'creative-layout-made-with-tulip-flowers-bright-white-red-surface_154293-6558.jpg', 'public_storage', 'media/sIftmINFZASRgmJGwgdvLVjSaGa4WZ4uDumWXzYU.jpg', 'jpg', 'image/jpeg', '77435', '2023-08-14 08:06:01', '2023-08-14 08:06:01'),
(99, 1, 'd8233b11818cf0d483d53fe591921f62.jpg', 'public_storage', 'media/l4zWRihKknQtEzeHB8dztie7fDT4OUUSVydyKqSs.jpg', 'jpg', 'image/jpeg', '135857', '2023-08-14 08:14:57', '2023-08-14 08:14:57'),
(100, 1, 'Lilly Wedding garland 1 pair - Rs.4000-910x1155.jpg', 'public_storage', 'media/66pRQfcg7ptQYxjXv693V9VK4DrLXPud71m5zRyS.jpg', 'jpg', 'image/jpeg', '164652', '2023-08-14 08:23:57', '2023-08-14 08:23:57'),
(101, 1, '7838367ad0a6e941e9d81e55a5a0f538.jpg', 'public_storage', 'media/GeTQIhT0Tu2uDk5eCqpchenjvIXjJW2Fuj2D8N3V.jpg', 'jpg', 'image/jpeg', '138282', '2023-08-14 08:25:35', '2023-08-14 08:25:35'),
(102, 1, '65a47cbc6115e8447cd878fd3390c6aa.jpg', 'public_storage', 'media/qqDh7AaRk2v0VQw18WvS7T1Nk7fjLgSpSvVlXUKF.jpg', 'jpg', 'image/jpeg', '46261', '2023-08-14 08:34:42', '2023-08-14 08:34:42'),
(103, 1, 'd90c92322d70b4ac86a13367611b3132.jpg', 'public_storage', 'media/fj0REJfRbbVzOgfIjVFMTYjnkCMWsXjFY9liFu9b.jpg', 'jpg', 'image/jpeg', '73602', '2023-08-14 08:35:02', '2023-08-14 08:35:02'),
(104, 1, 'mothers-day-background-with-flowers-box_23-2147776552.jpg', 'public_storage', 'media/JS36Gp7QQ6Zwxj5EKfzjlSZWJ22l8tK4NlcQsplR.jpg', 'jpg', 'image/jpeg', '64870', '2023-08-14 09:16:40', '2023-08-14 09:16:40'),
(105, 1, 'arrangement-with-beautiful-roses-vase.jpg', 'public_storage', 'media/URzcAkYD9VDhaR94rqGKvLJUISVUJmXGrxWhWm0b.jpg', 'jpg', 'image/jpeg', '932742', '2023-08-14 09:25:12', '2023-08-14 09:25:12'),
(106, 1, 'spring-flowers-with-bunch-rocks-arrangement.jpg', 'public_storage', 'media/zjTBDysAwiRr2uce0DMufJOfYg5dgCJzUNhcX8Fg.jpg', 'jpg', 'image/jpeg', '1131732', '2023-08-14 09:26:10', '2023-08-14 09:26:10'),
(107, 1, 'spring-flowers-with-bunch-rocks-assortment.jpg', 'public_storage', 'media/bX3FUnmiPuTwD3FpBGs7ffv9WkO3AMNB8FprtgeN.jpg', 'jpg', 'image/jpeg', '1088172', '2023-08-14 09:27:06', '2023-08-14 09:27:06'),
(108, 1, 'bouquet-roses-vase-empty-card.jpg', 'public_storage', 'media/DhnSnfCsbLE8lIPy7rxRQuV5RHjDOxtpwinQb5cc.jpg', 'jpg', 'image/jpeg', '628110', '2023-08-14 09:28:08', '2023-08-14 09:28:08'),
(109, 1, 'bouquet-roses-vase-blank-card.jpg', 'public_storage', 'media/ELDocRdZC47N8EH3WKkVPLjpewao3aOFWNX7doil.jpg', 'jpg', 'image/jpeg', '1076238', '2023-08-14 09:28:08', '2023-08-14 09:28:08'),
(110, 1, 'beautiful-flower-bouquet-with-pomegranate-grapes-yellow-box-with-bowtie.jpg', 'public_storage', 'media/0waO1nJgUIG8G1bR6g0zeSN2sAbzSdFXa4zz5MFA.jpg', 'jpg', 'image/jpeg', '2152911', '2023-08-14 09:34:52', '2023-08-14 09:34:52'),
(111, 1, 'bouquet-roses-close-up-with-copy-space.jpg', 'public_storage', 'media/NiyAvCRmbbLAPafFBaUbXs4vjAi7HBbXmIL9P7Gg.jpg', 'jpg', 'image/jpeg', '1152370', '2023-08-14 09:36:09', '2023-08-14 09:36:09'),
(113, 1, '0e738a_1720c55984414c48bc3782c7497e6e2c_mv2-removebg-preview.png', 'public_storage', 'media/xfdxRuTdpeghecS9JryBmCEyUwTdSjPurLoZ4Tqq.png', 'png', 'image/png', '271646', '2023-08-14 09:51:39', '2023-08-14 09:51:39'),
(114, 1, 'DSC_1912-removebg-preview.png', 'public_storage', 'media/CzHkQQWyplQIn0rvxa8KLIn9CvT4icAIMJ6n0Zdg.png', 'png', 'image/png', '282272', '2023-08-14 10:02:36', '2023-08-14 10:02:36'),
(115, 1, 'DSC_1912-removebg-preview (2).png', 'public_storage', 'media/1Afucj20eUDDEGaVfyCHqjTCbK5rKx0nsZRXupFW.png', 'png', 'image/png', '324056', '2023-08-14 10:04:14', '2023-08-14 10:04:14'),
(116, 1, 'SKU13-removebg-preview (1).png', 'public_storage', 'media/mtOMnVCaShxt15Si57UegEjBrB42qiBjXyetQmrm.png', 'png', 'image/png', '173224', '2023-08-14 10:15:04', '2023-08-14 10:15:04'),
(122, 1, 'download (4).jfif', 'public_storage', 'media/JObprWyflAO7ckA9jkppabbbLjyJ1Tuo5UCHOn4k.jpg', 'jpg', 'image/jpeg', '7359', '2023-08-14 10:21:23', '2023-08-14 10:21:23'),
(123, 1, 'rose-flower-white-isolated.jpg', 'public_storage', 'media/jvqRX9CN0FViLmINXgQhig4VRifE5tgrATxyvKFO.jpg', 'jpg', 'image/jpeg', '1742744', '2023-08-14 10:21:25', '2023-08-14 10:21:25'),
(124, 1, 'download (2).jfif', 'public_storage', 'media/vz5yreXg1D2BGMTmRWtc5TZskO0rWfg3WPSclbqO.jpg', 'jpg', 'image/jpeg', '6620', '2023-08-14 10:21:40', '2023-08-14 10:21:40'),
(125, 1, 'bouquet.jpg', 'public_storage', 'media/dqFDkV1Cka06T33CEnB13HvFFxjE9AjQgdkEr3fT.jpg', 'jpg', 'image/jpeg', '8638', '2023-08-14 10:21:41', '2023-08-14 10:21:41'),
(126, 1, 'download (3).jfif', 'public_storage', 'media/RB1bxNfFwtG5uYkFEjk1vEyabrZ1Iq2p6lk6cT0L.jpg', 'jpg', 'image/jpeg', '4825', '2023-08-14 10:21:41', '2023-08-14 10:21:41'),
(127, 1, 'images (2).jfif', 'public_storage', 'media/QbmFsv47X1GM2fPjUOxKJOuYJTPm62t2DJlgOYmG.jpg', 'jpg', 'image/jpeg', '10168', '2023-08-14 10:21:42', '2023-08-14 10:21:42'),
(128, 1, 'red-rose-valentines-day-sweetest-day-isolated-white-background_42957-7248.jpg', 'public_storage', 'media/rk3rb8ZhJZ1UyCt9eBYEvokPkcpOFPaefu8EKqDi.jpg', 'jpg', 'image/jpeg', '27152', '2023-08-14 10:24:17', '2023-08-14 10:24:17'),
(129, 1, 'download (5).jfif', 'public_storage', 'media/ekuGu2Gvk1tUUKr9faXFp7Iitfgvna4kQTRYFPnT.jpg', 'jpg', 'image/jpeg', '9101', '2023-08-14 10:26:16', '2023-08-14 10:26:16'),
(130, 1, 'images (3).jfif', 'public_storage', 'media/RZCAj7rtlyiAJPMsLQvfPpj5BzbOZ86mE9sz0mrM.jpg', 'jpg', 'image/jpeg', '10496', '2023-08-14 10:26:16', '2023-08-14 10:26:16'),
(131, 1, 'images (4).jfif', 'public_storage', 'media/a63lG0BcMEkMqfu0W836tn86fmh3LcnVO7G1uia5.jpg', 'jpg', 'image/jpeg', '9290', '2023-08-14 10:26:17', '2023-08-14 10:26:17'),
(132, 1, 'rose-1.jpg', 'public_storage', 'media/GJZOYEOBCOMLiPlIx6FOccC7DVdcUkSc17gCLiPM.jpg', 'jpg', 'image/jpeg', '108505', '2023-08-14 10:26:17', '2023-08-14 10:26:17'),
(133, 1, 'Rose-2.jpg', 'public_storage', 'media/mySKaEBGtQiC91Koenw4fY0qfPW9etXbCbd19uRY.jpg', 'jpg', 'image/jpeg', '18286', '2023-08-14 10:26:18', '2023-08-14 10:26:18'),
(134, 1, 'Rose-3.jpg', 'public_storage', 'media/KY8ZgO0T2maSeBFAMjdbS3MoUiKUY36Ebjp5NFXK.jpg', 'jpg', 'image/jpeg', '15588', '2023-08-14 10:26:18', '2023-08-14 10:26:18'),
(135, 1, 'Artabotrys hexapetalusSudagar krishnan .jpg', 'public_storage', 'media/1QM0dyZWYzNNQUAbirbmDyy6k8QS0I6eTEEvQSD1.jpg', 'jpg', 'image/jpeg', '29189', '2023-08-14 10:32:31', '2023-08-14 10:32:31'),
(136, 1, 'Manoranjitham-flower-Plantation-care-and-growth.webp', 'public_storage', 'media/OM5Xii8zqTbso4v9mNAWmsZM6Xk5NOXszEhXkvSO.webp', 'webp', 'image/webp', '33566', '2023-08-14 10:32:32', '2023-08-14 10:32:32'),
(137, 1, 'Untitled-design-5.webp', 'public_storage', 'media/03Ump0BR7bbgMNw1prKK8OZOmfngxMGdfW6Q3tJi.webp', 'webp', 'image/webp', '21192', '2023-08-14 10:32:32', '2023-08-14 10:32:32'),
(138, 1, 'images (9).jfif', 'public_storage', 'media/oBd6kJdjBcV6HlFJzUCpJ7n5y9BzD7hPLSHKQ2Ca.jpg', 'jpg', 'image/jpeg', '9946', '2023-08-14 10:36:04', '2023-08-14 10:36:04'),
(139, 1, 'download (6).jfif', 'public_storage', 'media/dDKpp6mFtXnWK9mNXHRby4JdLSYi1w3tJq6ETriI.jpg', 'jpg', 'image/jpeg', '6530', '2023-08-14 10:36:55', '2023-08-14 10:36:55'),
(140, 1, 'images (7).jfif', 'public_storage', 'media/YjERhKWTvcLu58zD1poIFgx6ffK3aBoyweHPW1Iq.jpg', 'jpg', 'image/jpeg', '7079', '2023-08-14 10:36:55', '2023-08-14 10:36:55'),
(141, 1, 'images (9).jfif', 'public_storage', 'media/b7yy5O2uBW4qyg0qA3myxP7D1loTmcs5uyVjwKwu.jpg', 'jpg', 'image/jpeg', '9946', '2023-08-14 10:36:56', '2023-08-14 10:36:56'),
(142, 1, 'images (10).jfif', 'public_storage', 'media/O81UByoJLRhvZuliEU5gl0EAYk3m7mNPBduSG65y.jpg', 'jpg', 'image/jpeg', '17093', '2023-08-14 10:36:57', '2023-08-14 10:36:57'),
(143, 1, 'images (11).jfif', 'public_storage', 'media/pF6Uij1pfzcMz2YhjaDSImxF03dKvohJbz2QSTxC.jpg', 'jpg', 'image/jpeg', '13061', '2023-08-14 10:36:57', '2023-08-14 10:36:57'),
(144, 1, 'red-500x500.webp', 'public_storage', 'media/q2QBR6Nj4uDbSvG4hJ6MHDZwT0wyNoTWgwXBHv4H.webp', 'webp', 'image/webp', '40534', '2023-08-14 10:36:58', '2023-08-14 10:36:58'),
(145, 1, 'images (15).jfif', 'public_storage', 'media/Wvld0ifKter2CRFBOHTDlA9nlp6TY3mO9WaKMFuT.jpg', 'jpg', 'image/jpeg', '8727', '2023-08-14 10:41:24', '2023-08-14 10:41:24'),
(146, 1, 'images (4).jfif', 'public_storage', 'media/wz6mQw3tI8mEy6Hp5v2rlDFns9PbbkmGCZ93nCG4.jpg', 'jpg', 'image/jpeg', '9290', '2023-08-14 10:41:53', '2023-08-14 10:41:53'),
(147, 1, 'images (13).jfif', 'public_storage', 'media/ZSC8UF9qGfFHJQFolrvf86opgX81hW4S3zMh484G.jpg', 'jpg', 'image/jpeg', '7610', '2023-08-14 10:41:53', '2023-08-14 10:41:53'),
(148, 1, 'images (15).jfif', 'public_storage', 'media/Z49JZ9SVDbp0FLjxW7XY958q4A2Mde092HaSv3le.jpg', 'jpg', 'image/jpeg', '8727', '2023-08-14 10:41:54', '2023-08-14 10:41:54'),
(149, 1, 'images (16).jfif', 'public_storage', 'media/GaccA57SguS7xNyYy7dx2DUpZCX26bYWQPhpFKU9.jpg', 'jpg', 'image/jpeg', '7602', '2023-08-14 10:41:54', '2023-08-14 10:41:54'),
(154, 1, 'download (5).jpg', 'public_storage', 'media/jHfF6wLnuqpF4leueQ7sod8WJqnEqgoW5Npcec13.jpg', 'jpg', 'image/jpeg', '8709', '2023-08-14 10:49:14', '2023-08-14 10:49:14'),
(155, 1, '74D44A5826C813AAA6AA717861D4BA1D-2.webp', 'public_storage', 'media/EVN3ojnNJKkCYkRZtTS58gXDQRuy4T0zWYcMUlES.webp', 'webp', 'image/webp', '22662', '2023-08-14 10:49:15', '2023-08-14 10:49:15'),
(156, 1, 'vadamalli-flowering-plant.jpg', 'public_storage', 'media/L08KQDnvMAGcZ593oA63mSZnaQ2IYpEqnOvQlOxk.jpg', 'jpg', 'image/jpeg', '46890', '2023-08-14 10:50:41', '2023-08-14 10:50:41'),
(157, 1, 'images (9).jpg', 'public_storage', 'media/qs3Nv5CrV7BWfSOSaHtMJgTwHPpctc14MNkbJfRg.jpg', 'jpg', 'image/jpeg', '7781', '2023-08-14 10:53:16', '2023-08-14 10:53:16'),
(158, 1, 'images (10).jpg', 'public_storage', 'media/SPahMYDTthq3iiWjL0nka3O5rHxzRvzYKb5u1KZG.jpg', 'jpg', 'image/jpeg', '8827', '2023-08-14 10:53:16', '2023-08-14 10:53:16'),
(159, 1, 'images (18).jfif', 'public_storage', 'media/DYAI6Ga9kepjHqT88gpGht6wPjespWrq9Uj0FSoU.jpg', 'jpg', 'image/jpeg', '6222', '2023-08-14 11:02:12', '2023-08-14 11:02:12'),
(160, 1, 'download (9).jfif', 'public_storage', 'media/iIBziKylRsLfPV1988xWR53pxA9R8755j32yeJHA.jpg', 'jpg', 'image/jpeg', '6269', '2023-08-14 11:03:34', '2023-08-14 11:03:34'),
(161, 1, 'download (10).jfif', 'public_storage', 'media/jYCkXxVuVBSIT17z3UaujzZyLAFVHh288RPwRYsH.jpg', 'jpg', 'image/jpeg', '7000', '2023-08-14 11:03:35', '2023-08-14 11:03:35'),
(162, 1, 'images (18).jfif', 'public_storage', 'media/qXrJto02YZM9ahdgGRXq8h1dVyWJbb75YrltCQAT.jpg', 'jpg', 'image/jpeg', '6222', '2023-08-14 11:03:36', '2023-08-14 11:03:36'),
(163, 1, 'images (19).jfif', 'public_storage', 'media/IcUkjIqcEKBWBnnW5jqNiZhDAvYDt3nkcrFU1uNF.jpg', 'jpg', 'image/jpeg', '12571', '2023-08-14 11:03:36', '2023-08-14 11:03:36'),
(164, 1, 'blue-lotus-fresh-flowers-500x500.webp', 'public_storage', 'media/bTVCoHT1gkoskvl3Q6eglbvnZKedyZDUmshzA8wR.webp', 'webp', 'image/webp', '12794', '2023-08-14 11:12:34', '2023-08-14 11:12:34'),
(165, 1, '8.png', 'public_storage', 'media/moGPR7TQv7srjfHr181fJx7Z5t0APsMyiAODJmHg.png', 'png', 'image/png', '465190', '2023-08-14 11:15:50', '2023-08-14 11:15:50'),
(166, 1, '1681798613-1-lotus-buds.jpg', 'public_storage', 'media/FC2p4NQ7vqdPcI1h8wTwh2fZJjDs8t67fJghLGTp.jpg', 'jpg', 'image/jpeg', '24028', '2023-08-14 11:16:00', '2023-08-14 11:16:00'),
(167, 1, 'images (14).jpg', 'public_storage', 'media/Of1OZmYpHOy1pZGMVDd7HAYT18wPqdB6VRM9AOuS.jpg', 'jpg', 'image/jpeg', '3675', '2023-08-14 11:19:51', '2023-08-14 11:19:51'),
(168, 1, '40196773_1-hoovu-fresh-assorted-puja-flowers-greens-mix.webp', 'public_storage', 'media/KsDFvkc1TW3Ppj4UkRrBPVgQ8b9bR6tMMvkYKM4c.webp', 'webp', 'image/webp', '12374', '2023-08-14 11:25:36', '2023-08-14 11:25:36'),
(169, 1, 'download (7).jfif', 'public_storage', 'media/d71I4Y3QNZBG22uonZp6uq9IIFrKPi5OCbk5eLN3.jpg', 'jpg', 'image/jpeg', '9067', '2023-08-14 11:26:11', '2023-08-14 11:26:11'),
(170, 1, 'download (8).jfif', 'public_storage', 'media/4nC7lSIoyzOwwUToGOIapJVdCBXNqQwlBJsBIbLO.jpg', 'jpg', 'image/jpeg', '8479', '2023-08-14 11:26:11', '2023-08-14 11:26:11'),
(171, 1, 'download (11).jfif', 'public_storage', 'media/3Gkwp5jMLWgFp6hznXI2w5aLdTocHUV1A7YVlvxP.jpg', 'jpg', 'image/jpeg', '8479', '2023-08-14 11:26:12', '2023-08-14 11:26:12'),
(172, 1, 'images (5).jfif', 'public_storage', 'media/Taii0f8Od2ePsGgZmMQeqydtozalHgxejLgUza1b.jpg', 'jpg', 'image/jpeg', '5484', '2023-08-14 11:26:12', '2023-08-14 11:26:12'),
(173, 1, 'images (6).jfif', 'public_storage', 'media/syAOUIwv4ga4lmd5egEtNQSZoliUPmLCQkXzCLRO.jpg', 'jpg', 'image/jpeg', '12568', '2023-08-14 11:26:13', '2023-08-14 11:26:13'),
(174, 1, 'images (7).jfif', 'public_storage', 'media/JbSzhV06FjFnjUZ8vnRZaypAKRgnsYlXA8yVjEDi.jpg', 'jpg', 'image/jpeg', '7079', '2023-08-14 11:26:14', '2023-08-14 11:26:14'),
(175, 1, 'images (8).jfif', 'public_storage', 'media/h0P1tMXXBG144N8Ll0Rx7srZsUZzIuxgc4kIuPFE.jpg', 'jpg', 'image/jpeg', '3493', '2023-08-14 11:26:14', '2023-08-14 11:26:14'),
(176, 1, 'images (20).jfif', 'public_storage', 'media/i4AXYE8PzaARCg8571avmGhaxOJXnVuuqsmfceb2.jpg', 'jpg', 'image/jpeg', '13713', '2023-08-14 11:26:15', '2023-08-14 11:26:15'),
(177, 1, 'red_rose.jpg', 'public_storage', 'media/HZ9OKa96scrY6xT3vZxPkxmMOHCQP0f3IjrVCQgJ.jpg', 'jpg', 'image/jpeg', '13198', '2023-08-14 11:28:55', '2023-08-14 11:28:55'),
(178, 1, '30007033_2-fresho-rose-red-flower.webp', 'public_storage', 'media/kxCTeEMgcAn2msA1ZJz841uFr0oyWIONzWxKeWPw.webp', 'webp', 'image/webp', '47940', '2023-08-14 11:28:55', '2023-08-14 11:28:55'),
(180, 1, 'Yellowrosepetals-1080x567.jpg', 'public_storage', 'media/uChZbcSWcqhJOUZ1YcBAPhnti7K7WzElzD9bmtA8.jpg', 'jpg', 'image/jpeg', '95386', '2023-08-14 11:31:47', '2023-08-14 11:31:47'),
(182, 1, 'yellow-red-tip-rose-meaning-1674955468.jpg', 'public_storage', 'media/f8dO13WLYc1QgTFO2mnGTOglAcfeV3N1L8JcvpnR.jpg', 'jpg', 'image/jpeg', '236189', '2023-08-14 11:31:48', '2023-08-14 11:31:48'),
(183, 1, '1-1657345-full-images-fresh-jasmine-flowers-988437-500x500.webp', 'public_storage', 'media/cyIyBHg7uCkeWyZmDzWxVH3ClAJ69eSkZEciXpIo.webp', 'webp', 'image/webp', '36440', '2023-08-14 11:36:15', '2023-08-14 11:36:15'),
(184, 1, '_y_e_yellow_chamanthi_aanacart_1.jpg', 'public_storage', 'media/bLGqQ3SckhtKH0f5hoVze6Dbov5oZIspmM3TjN06.jpg', 'jpg', 'image/jpeg', '16468', '2023-08-14 11:39:41', '2023-08-14 11:39:41'),
(185, 1, 'download (13).jfif', 'public_storage', 'media/U3aQkfguFEY7shD2i63Lrf4rJRtIvYOxRTbHOBh9.jpg', 'jpg', 'image/jpeg', '11011', '2023-08-14 12:05:39', '2023-08-14 12:05:39'),
(186, 1, 'images (21).jfif', 'public_storage', 'media/trnA5Z3FfxaFhhOrBuTr1QCtgBiHXvwqHEKenhAM.jpg', 'jpg', 'image/jpeg', '9128', '2023-08-14 12:05:39', '2023-08-14 12:05:39'),
(187, 1, 'images (22).jfif', 'public_storage', 'media/6KQHneXkctgInN7eyVbbkwHRXJxZ230RHQtanV3X.jpg', 'jpg', 'image/jpeg', '10634', '2023-08-14 12:05:40', '2023-08-14 12:05:40'),
(188, 1, 'jasmine-3.jpg', 'public_storage', 'media/LbYC648i7pliasNOiZJDuMX3GCszS1vxYZeNAp27.jpg', 'jpg', 'image/jpeg', '10202', '2023-08-14 12:05:40', '2023-08-14 12:05:40'),
(189, 1, 'saram-1.jpg', 'public_storage', 'media/ZfBUPCr3hozzFsIBlXH23ep5pt9Btf2nHnkSeLGY.jpg', 'jpg', 'image/jpeg', '7755', '2023-08-14 12:05:41', '2023-08-14 12:05:41'),
(190, 1, 'istockphoto-532702777-612x612.jpg', 'public_storage', 'media/bWRzhwkIFQE4exmUDu0T6rJfChOvBIP7VZHkTwAe.jpg', 'jpg', 'image/jpeg', '22138', '2023-08-14 12:07:43', '2023-08-14 12:07:43'),
(191, 1, 'set-ylang-flower-realistic-elements-labels-cosmetic-skin-care-product-design-vector-isolated-illustration-184466625.webp', 'public_storage', 'media/YyTsvTImQ1TmEvWIKj6j52xAU3gVD12rN9PeqT0p.webp', 'webp', 'image/webp', '18962', '2023-08-14 12:07:43', '2023-08-14 12:07:43'),
(192, 1, 'ylang-ylang-flower-water-droplets-adhering-thailand-31756959.webp', 'public_storage', 'media/VFiGwQu6YRFIhNoVVXN8U9m7tcbvjjuS3p7dG9PZ.webp', 'webp', 'image/webp', '16684', '2023-08-14 12:07:44', '2023-08-14 12:07:44'),
(193, 1, 'hee5d1.jpg', 'public_storage', 'media/IzK9w923FbwvW5RQScl4HCzZRb60QtLZvJwCxg7t.jpg', 'jpg', 'image/jpeg', '25919', '2023-08-14 12:08:59', '2023-08-14 12:08:59'),
(196, 1, '12-yellow-roses_1.webp', 'public_storage', 'media/7nw90XWnX8y1gJdKL5WDF6zPN7yPV1mHF1J2kTnD.webp', 'webp', 'image/webp', '35198', '2023-08-14 12:15:34', '2023-08-14 12:15:34'),
(197, 1, '61Y-UdeH9WL._AC_UF894,1000_QL80_.jpg', 'public_storage', 'media/ppYXP7OLvpH9GAJpTaq0fSLlG8KAZr3J1wNYdVPb.jpg', 'jpg', 'image/jpeg', '77275', '2023-08-14 12:15:35', '2023-08-14 12:15:35'),
(198, 1, '1_5ea843ce-5326-4b61-9067-53da4da47c80_800x.webp', 'public_storage', 'media/vjTvOMDLO8dMLbWqxvZCINeDFBHsuHZmzN80wqXL.webp', 'webp', 'image/webp', '103580', '2023-08-14 12:19:18', '2023-08-14 12:19:18'),
(199, 1, '20001349_9-fresho-jasmine-flower.webp', 'public_storage', 'media/JNJMLlXpkUCMH1es32e5BSPzGVwyu6FUun8bA1uu.webp', 'webp', 'image/webp', '7752', '2023-08-14 12:21:57', '2023-08-14 12:21:57'),
(201, 1, 'download (13).jfif', 'public_storage', 'media/sO9Fl2CRHajVvH72wEcB5gnMrp4zanV08dHZKbj4.jpg', 'jpg', 'image/jpeg', '11011', '2023-08-14 12:24:34', '2023-08-14 12:24:34'),
(202, 1, 'download (14).jfif', 'public_storage', 'media/IRD74jdpJfkOicHaC0rhTejOVQUznlqo0JqLaQD5.jpg', 'jpg', 'image/jpeg', '6617', '2023-08-14 12:24:35', '2023-08-14 12:24:35'),
(203, 1, 'flowers-500x500.webp', 'public_storage', 'media/8lrWmHvFWpu6sndHKqN98fdvFQQKV8ElNZhRywWu.webp', 'webp', 'image/webp', '34880', '2023-08-14 12:24:36', '2023-08-14 12:24:36'),
(204, 1, 'images (23).jfif', 'public_storage', 'media/9CJpRv4PDPy2coeP2tHsXwVZgUhwAgqkuwnRqqMV.jpg', 'jpg', 'image/jpeg', '10994', '2023-08-14 12:24:36', '2023-08-14 12:24:36'),
(205, 1, 'jasmine-4.jpg', 'public_storage', 'media/O5jkepboke7rxCpphKMiPlTbMmPIdcHVxUWCzTQl.jpg', 'jpg', 'image/jpeg', '2203698', '2023-08-14 12:24:37', '2023-08-14 12:24:37'),
(206, 1, 'watercolor-spring-floral-element_1340-8127.jpg', 'public_storage', 'media/oP2fCovmQHEJyw3ZJukT2IpeOQJwUJ25gkwcucCH.jpg', 'jpg', 'image/jpeg', '79045', '2023-08-14 12:32:27', '2023-08-14 12:32:27'),
(207, 1, 's-l1200.webp', 'public_storage', 'media/oW576qN3ZSJSmxomSDH4AsJ7J3GABq4GhLQg0TUi.webp', 'webp', 'image/webp', '47640', '2023-08-14 12:37:27', '2023-08-14 12:37:27'),
(208, 1, 'vase-flowers-is-vase-with-flowers-it_1340-28192.jpg', 'public_storage', 'media/9q08QuQ9EkVAruw6y0kKGTupv1Nx0hYd3kD7oN9f.jpg', 'jpg', 'image/jpeg', '82908', '2023-08-14 12:42:25', '2023-08-14 12:42:25'),
(209, 1, '8.png', 'public_storage', 'media/KUwpGOqsibagZFtLeC3ZEvPGFrGsQt8PXl0NyZlQ.png', 'png', 'image/png', '465190', '2023-08-17 05:18:38', '2023-08-17 05:18:38'),
(210, 1, 'About-us_2.jpg', 'public_storage', 'media/9Ig4YvLyLFkJPXTrbM2LF8qU56r731UUBhGzbuL0.jpg', 'jpg', 'image/jpeg', '158063', '2023-08-17 05:22:21', '2023-08-17 05:22:21'),
(211, 1, 'About-us_2.jpg', 'public_storage', 'media/GGW8S0G1zME9cJ1BJreTtadaEVIum8pMyjPdLtc7.jpg', 'jpg', 'image/jpeg', '158063', '2023-08-17 05:35:59', '2023-08-17 05:35:59'),
(212, 1, 'About-us-1-1024x576.jpg', 'public_storage', 'media/RVaFqlz4tw8V99qOwlKExMzjMZlw5CEg9CUxJqTj.jpg', 'jpg', 'image/jpeg', '221765', '2023-08-17 05:37:24', '2023-08-17 05:37:24'),
(213, 1, '20160305_094336-1-1024x576.jpg', 'public_storage', 'media/JvA6ZeZPCYd73cgVVDve9WD0UiBIk2cm3GX77wDZ.jpg', 'jpg', 'image/jpeg', '237147', '2023-08-17 05:38:48', '2023-08-17 05:38:48'),
(214, 1, 'About-us-2-1024x576.jpg', 'public_storage', 'media/blijTqVbkCuA4B6NyVOs6Io7fJ597WQWbjHRTOKr.jpg', 'jpg', 'image/jpeg', '179339', '2023-08-17 05:45:04', '2023-08-17 05:45:04'),
(215, 1, 'sample.pdf', 'public_storage', 'media/ZbvBu8GViY59cMLZHfFGpUsDPGiug4sVIKxdf7St.pdf', 'pdf', 'application/pdf', '3028', '2023-08-24 15:19:50', '2023-08-24 15:19:50'),
(216, 1, 'Flower garland with pink oleander.jpg', 'public_storage', 'media/48RfQCJgoE9eKrPPvfKMDhf10hPqkb1n3Aa6oBhy.jpg', 'jpg', 'image/jpeg', '13434', '2023-08-28 09:31:34', '2023-08-28 09:31:34'),
(217, 1, 'arali.jpg', 'public_storage', 'media/dR5jWgW2H3A3UTrBEzSndDzfQy38z1nG2TYacsee.jpg', 'jpg', 'image/jpeg', '14813', '2023-08-28 09:32:04', '2023-08-28 09:32:04'),
(218, 1, 'Flower garland with pink oleander.jpg', 'public_storage', 'media/wG4Tz4yMF6nowQRM7YmRC7NG7jAiOq5cMuOVFTLj.jpg', 'jpg', 'image/jpeg', '13434', '2023-08-28 09:32:05', '2023-08-28 09:32:05'),
(219, 1, 'Flower garland with pink oleander-1.jpg', 'public_storage', 'media/sxENymSNMxnjUX5nFipqnFB1qOAxog5Mb8rPXozc.jpg', 'jpg', 'image/jpeg', '11505', '2023-08-28 09:32:06', '2023-08-28 09:32:06'),
(220, 1, 'images (24).jpg', 'public_storage', 'media/AfZcsfc5RZJC5xVI041xj0GiVatVVqm6G1nmTR5s.jpg', 'jpg', 'image/jpeg', '10591', '2023-08-28 09:32:07', '2023-08-28 09:32:07'),
(221, 1, 'aps flora logo.jpg', 'public_storage', 'media/cZt36CcWiiQ1NWAKLHcLm4JwgjhAkjRZrkfBO2L0.jpg', 'jpg', 'image/jpeg', '85144', '2023-10-06 07:57:18', '2023-10-06 07:57:18'),
(222, 6, 'bouquet-flowers_1339-5490.jpg', 'public_storage', 'media/2XEDwhCIFh5DhYTZvFT9NVbZX4TRRPcJpO8eBNYq.jpg', 'jpg', 'image/jpeg', '96823', '2023-10-17 14:07:41', '2023-10-17 14:07:41'),
(223, 6, 'beautiful-bouquet-flowers.jpg', 'public_storage', 'media/0PEdgq0q0BMrxXrf7kljOIZEJxZxYSZpb9ZnM8Kp.jpg', 'jpg', 'image/jpeg', '6454035', '2023-10-17 14:07:43', '2023-10-17 14:07:43'),
(224, 6, 'bouquet-stands-table.jpg', 'public_storage', 'media/P5ncFshOaXXkuVVsZGgRFTJVBw41cqVOJJ6Bvcvw.jpg', 'jpg', 'image/jpeg', '4321415', '2023-10-17 14:07:45', '2023-10-17 14:07:45'),
(225, 1, 'APS-Logo.png', 'public_storage', 'media/gtetad03z6bbNcFtgvibdjWnHiMImU3O1YOwroYi.png', 'png', 'image/png', '164725', '2023-10-17 14:15:01', '2023-10-17 14:15:01'),
(226, 6, 'violet_bouquet.jpg', 'public_storage', 'media/CgcvQJ6ajO3RtR3wUOSWFt9yF3c8jX8SMkWtORyu.jpg', 'jpg', 'image/jpeg', '9472', '2023-11-17 10:52:38', '2023-11-17 10:52:38');

-- --------------------------------------------------------

--
-- Table structure for table `fixedrates`
--

CREATE TABLE `fixedrates` (
  `id` int(10) UNSIGNED NOT NULL,
  `pincode` int(11) NOT NULL,
  `flat_price` int(11) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fixedrates`
--

INSERT INTO `fixedrates` (`id`, `pincode`, `flat_price`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 59000, 26, 0, '2023-09-25 07:16:42', '2023-09-25 07:16:42'),
(2, 59003, 22, 1, '2023-09-25 07:16:42', '2023-09-25 07:16:42'),
(3, 59005, 29, 1, '2023-09-25 07:16:42', '2023-09-25 07:16:42'),
(4, 59009, 23, 1, '2023-09-25 07:16:42', '2023-09-25 07:16:42'),
(5, 59006, 21, 1, '2023-09-25 07:16:42', '2023-09-25 07:16:42');

-- --------------------------------------------------------

--
-- Table structure for table `flash_sales`
--

CREATE TABLE `flash_sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flash_sales`
--

INSERT INTO `flash_sales` (`id`, `created_at`, `updated_at`) VALUES
(3, '2023-08-10 09:22:57', '2023-08-10 09:22:57'),
(4, '2023-10-17 08:11:27', '2023-10-17 08:11:27');

-- --------------------------------------------------------

--
-- Table structure for table `flash_sale_products`
--

CREATE TABLE `flash_sale_products` (
  `id` int(10) UNSIGNED NOT NULL,
  `flash_sale_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `end_date` date NOT NULL,
  `price` decimal(18,4) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `position` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flash_sale_products`
--

INSERT INTO `flash_sale_products` (`id`, `flash_sale_id`, `product_id`, `end_date`, `price`, `qty`, `position`) VALUES
(1, 3, 1, '2023-08-28', '20.0000', 5, 1),
(2, 3, 2, '2023-08-28', '25.0000', 5, 0),
(3, 3, 14, '2023-08-29', '18.0000', 12, 2),
(4, 4, 1, '2023-10-31', '56.0000', 2000, 0),
(5, 4, 3, '2023-10-31', '98.0000', 2500, 1);

-- --------------------------------------------------------

--
-- Table structure for table `flash_sale_product_orders`
--

CREATE TABLE `flash_sale_product_orders` (
  `flash_sale_product_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flash_sale_product_orders`
--

INSERT INTO `flash_sale_product_orders` (`flash_sale_product_id`, `order_id`, `qty`) VALUES
(1, 3, 1),
(1, 4, 1),
(2, 2, 1),
(2, 5, 1),
(2, 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `flash_sale_translations`
--

CREATE TABLE `flash_sale_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `flash_sale_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `campaign_name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `flash_sale_translations`
--

INSERT INTO `flash_sale_translations` (`id`, `flash_sale_id`, `locale`, `campaign_name`) VALUES
(3, 3, 'en', 'aadi sale'),
(4, 4, 'en', 'APS Launching Offer');

-- --------------------------------------------------------

--
-- Table structure for table `galleries`
--

CREATE TABLE `galleries` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `videoID` varchar(191) NOT NULL,
  `videoFullURL` longtext NOT NULL,
  `videoTitle` varchar(191) NOT NULL,
  `channelTitle` varchar(191) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `galleries`
--

INSERT INTO `galleries` (`id`, `user_id`, `videoID`, `videoFullURL`, `videoTitle`, `channelTitle`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, 'Rr3eUfVD-e4', 'https://www.youtube.com/watch?v=Rr3eUfVD-e4', 'Medley พุ่มพวงในดวงใจ By Jennifer Kim', 'Bouquet P', 1, '2023-09-27 09:41:46', NULL),
(2, 1, 'T-Z-VYrJYE8', 'https://www.youtube.com/watch?v=T-Z-VYrJYE8', 'HBD PKai', 'Bouquet P', 1, '2023-09-27 09:41:46', NULL),
(3, 1, 'OMYgrKqn4zw', 'https://www.youtube.com/watch?v=OMYgrKqn4zw', 'Memory Of You By Mr.saxman', 'Bouquet P', 1, '2023-09-27 09:41:46', NULL),
(4, 1, '_27-fp-LH_c', 'https://www.youtube.com/watch?v=_27-fp-LH_c', 'I Will Survive By Jennifer Kim @Jsl Studio', 'Bouquet P', 1, '2023-09-27 09:41:46', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lmscompany`
--

CREATE TABLE `lmscompany` (
  `cpId` int(100) NOT NULL,
  `cpUUID` char(36) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `cpCompanyName` varchar(255) NOT NULL,
  `cpAdminName` varchar(255) NOT NULL,
  `cpAdminMail` varchar(255) NOT NULL,
  `cpIndustry` varchar(255) NOT NULL,
  `cpCountry` varchar(255) NOT NULL,
  `cpCreatedUserId` int(11) NOT NULL,
  `cpEditedUserId` int(11) DEFAULT NULL,
  `cpCreatedDate` datetime NOT NULL,
  `cpEditedDate` datetime NOT NULL,
  `cpStatus` tinyint(1) DEFAULT NULL,
  `cpDeleteStatus` tinyint(1) DEFAULT NULL,
  `cpIpAddress` varchar(255) NOT NULL,
  `cpDeviceType` varchar(255) NOT NULL,
  `cpUserAgent` varchar(255) NOT NULL,
  `cpTimeStamp` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lmscompany`
--

INSERT INTO `lmscompany` (`cpId`, `cpUUID`, `cpCompanyName`, `cpAdminName`, `cpAdminMail`, `cpIndustry`, `cpCountry`, `cpCreatedUserId`, `cpEditedUserId`, `cpCreatedDate`, `cpEditedDate`, `cpStatus`, `cpDeleteStatus`, `cpIpAddress`, `cpDeviceType`, `cpUserAgent`, `cpTimeStamp`, `createdAt`, `updatedAt`) VALUES
(1, '27c66275-e9da-45c8-9c72-142ab11b168e', 'advance learning', 'amirkhan', 'amir@al.in', 'textails', '1', 1, 0, '2023-11-08 05:52:09', '2023-11-08 05:52:09', 0, 0, '', '', '', '2023-11-08 04:54:58', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `lmscreators`
--

CREATE TABLE `lmscreators` (
  `ctId` int(100) NOT NULL,
  `ctUUID` char(36) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ctName` varchar(255) NOT NULL,
  `ctMail` varchar(255) NOT NULL,
  `ctDesignation` varchar(255) NOT NULL,
  `ctAge` int(100) NOT NULL,
  `ctGender` enum('Male','Female','Others') NOT NULL DEFAULT 'Male',
  `ctStatus` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `ctCreatedDate` datetime NOT NULL,
  `ctEditedDate` datetime DEFAULT NULL,
  `ctCreateAdminDate` datetime DEFAULT NULL,
  `ctEditAdminDate` datetime DEFAULT NULL,
  `ctDeleteStatus` enum('NO','YES') NOT NULL DEFAULT 'NO',
  `ctIpAdderss` varchar(100) DEFAULT NULL,
  `ctDeviceType` varchar(100) DEFAULT NULL,
  `ctUserAgent` varchar(100) NOT NULL,
  `ctTimeStamp` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  `companyId` int(100) DEFAULT NULL,
  `countryId` int(100) DEFAULT NULL,
  `ctCreatedUserId` char(36) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ctEditedUserId` char(36) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ctCreateAdminUserId` char(36) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  `ctEditAdminUserId` char(36) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lmscreators`
--

INSERT INTO `lmscreators` (`ctId`, `ctUUID`, `ctName`, `ctMail`, `ctDesignation`, `ctAge`, `ctGender`, `ctStatus`, `ctCreatedDate`, `ctEditedDate`, `ctCreateAdminDate`, `ctEditAdminDate`, `ctDeleteStatus`, `ctIpAdderss`, `ctDeviceType`, `ctUserAgent`, `ctTimeStamp`, `createdAt`, `updatedAt`, `companyId`, `countryId`, `ctCreatedUserId`, `ctEditedUserId`, `ctCreateAdminUserId`, `ctEditAdminUserId`) VALUES
(1, 'd386ee03-ac11-42f8-999c-ba4484bfb28f', 'GIRIRAGHAVA', 'giriraghava1970@santhila.co', 'Tech Manager', 52, 'Male', 'Active', '2023-11-10 13:22:46', NULL, NULL, NULL, '', NULL, NULL, 'PostmanRuntime/7.35.0', '2023-11-10 13:22:46', '2023-11-10 13:22:46', '2023-11-10 13:22:46', 1, 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lmsplan`
--

CREATE TABLE `lmsplan` (
  `plId` int(11) NOT NULL,
  `plPlan` varchar(100) NOT NULL,
  `plPlanType` enum('Days','Month','Year') NOT NULL,
  `plValidityDays` bigint(20) NOT NULL,
  `plPrice` int(100) NOT NULL,
  `plCreatedUserId` bigint(20) NOT NULL,
  `plEidtedUserId` bigint(20) DEFAULT NULL,
  `plCreatedDate` datetime NOT NULL,
  `plEidtedDate` datetime DEFAULT NULL,
  `plStatus` enum('Active','Inactive') NOT NULL DEFAULT 'Active',
  `plDeleteStatus` enum('NO','YES') NOT NULL DEFAULT 'NO',
  `plIpAdderss` varchar(100) NOT NULL,
  `plDeviceType` varchar(100) NOT NULL,
  `plUserAgent` varchar(100) NOT NULL,
  `plTimeStamp` datetime DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-08-10 05:18:22', '2023-08-10 05:18:22'),
(2, 1, '2023-08-11 05:32:38', '2023-08-11 05:32:38'),
(3, 1, '2023-08-11 05:35:02', '2023-08-11 05:35:02'),
(4, 1, '2023-08-11 05:44:06', '2023-08-11 05:44:06'),
(5, 1, '2023-08-11 05:46:52', '2023-08-11 05:46:52'),
(6, 1, '2023-08-11 07:15:27', '2023-08-11 07:15:27'),
(7, 1, '2023-08-17 04:45:18', '2023-08-17 04:45:18'),
(8, 1, '2023-10-17 14:22:17', '2023-10-17 14:22:17'),
(9, 1, '2023-10-17 14:26:14', '2023-10-17 14:26:14');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `category_id` int(10) UNSIGNED DEFAULT NULL,
  `page_id` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(191) NOT NULL,
  `url` varchar(191) DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `target` varchar(191) NOT NULL,
  `position` int(10) UNSIGNED DEFAULT NULL,
  `is_root` tinyint(1) NOT NULL DEFAULT 0,
  `is_fluid` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `parent_id`, `category_id`, `page_id`, `type`, `url`, `icon`, `target`, `position`, `is_root`, `is_fluid`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, NULL, NULL, 'URL', NULL, NULL, '_self', 0, 1, 0, 1, '2023-08-10 05:18:22', '2023-08-10 05:18:22'),
(4, 2, NULL, NULL, NULL, 'URL', NULL, NULL, '_self', 0, 1, 0, 1, '2023-08-11 05:32:38', '2023-08-11 05:32:38'),
(5, 2, 4, NULL, 2, 'page', NULL, NULL, '_self', NULL, 0, 1, 1, '2023-08-11 05:33:06', '2023-08-11 05:33:06'),
(6, 3, NULL, NULL, NULL, 'URL', NULL, NULL, '_self', 0, 1, 0, 1, '2023-08-11 05:35:02', '2023-08-11 05:35:02'),
(7, 3, 6, NULL, 3, 'page', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-08-11 05:35:25', '2023-08-11 05:35:25'),
(8, 4, NULL, NULL, NULL, 'URL', NULL, NULL, '_self', 0, 1, 0, 1, '2023-08-11 05:44:06', '2023-08-11 05:44:06'),
(9, 4, 8, NULL, 4, 'page', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-08-11 05:44:25', '2023-08-11 05:44:25'),
(10, 5, NULL, NULL, NULL, 'URL', NULL, NULL, '_self', 0, 1, 0, 1, '2023-08-11 05:46:52', '2023-08-11 05:46:52'),
(11, 5, 10, NULL, 5, 'page', NULL, NULL, '_self', 1, 0, 0, 1, '2023-08-11 05:47:11', '2023-08-11 06:04:30'),
(14, 5, 10, NULL, NULL, 'url', 'products', NULL, '_self', 0, 0, 0, 1, '2023-08-11 06:04:23', '2023-09-06 08:08:03'),
(16, 1, 1, 3, NULL, 'category', NULL, NULL, '_self', 0, 0, 0, 1, '2023-08-11 06:28:28', '2023-08-14 07:00:16'),
(17, 1, 1, 1, NULL, 'category', NULL, NULL, '_self', 1, 0, 0, 1, '2023-08-11 06:28:49', '2023-08-14 07:00:55'),
(18, 1, 1, 20, NULL, 'category', NULL, NULL, '_self', 2, 0, 0, 1, '2023-08-11 06:29:19', '2023-08-14 07:01:10'),
(19, 1, 1, 19, NULL, 'category', NULL, NULL, '_self', 3, 0, 0, 1, '2023-08-11 06:29:39', '2023-08-14 07:01:26'),
(20, 1, 1, 18, NULL, 'category', NULL, NULL, '_self', 4, 0, 0, 1, '2023-08-11 06:30:03', '2023-08-14 07:02:04'),
(21, 1, 17, 4, NULL, 'category', NULL, NULL, '_self', 0, 0, 0, 1, '2023-08-11 06:53:50', '2023-08-11 06:56:04'),
(22, 1, 17, 4, NULL, 'category', NULL, NULL, '_self', 1, 0, 0, 1, '2023-08-11 06:54:21', '2023-08-11 06:56:04'),
(23, 1, 16, 3, NULL, 'category', NULL, NULL, '_self', 2, 0, 0, 1, '2023-08-11 06:54:43', '2023-08-14 07:49:48'),
(24, 1, 16, 3, NULL, 'category', NULL, NULL, '_self', 1, 0, 1, 1, '2023-08-11 06:55:59', '2023-08-14 07:52:24'),
(25, 1, 18, 3, NULL, 'category', NULL, NULL, '_self', 0, 0, 0, 1, '2023-08-11 06:56:27', '2023-08-11 06:56:30'),
(26, 1, 19, 2, NULL, 'category', NULL, NULL, '_self', 0, 0, 0, 1, '2023-08-11 06:56:59', '2023-08-11 06:58:01'),
(27, 1, 20, 2, NULL, 'category', NULL, NULL, '_self', 0, 0, 0, 1, '2023-08-11 06:57:29', '2023-08-11 06:58:01'),
(28, 6, NULL, NULL, NULL, 'URL', NULL, NULL, '_self', 0, 1, 0, 1, '2023-08-11 07:15:27', '2023-08-11 07:15:27'),
(29, 1, 1, 15, NULL, 'category', NULL, NULL, '_self', 5, 0, 0, 1, '2023-08-14 07:02:31', '2023-08-14 07:49:17'),
(30, 1, 1, 5, NULL, 'category', NULL, NULL, '_self', 6, 0, 0, 1, '2023-08-14 07:02:47', '2023-08-14 07:49:17'),
(31, 1, 1, 4, NULL, 'category', NULL, NULL, '_self', 7, 0, 0, 1, '2023-08-14 07:03:03', '2023-08-14 07:49:17'),
(32, 1, 1, 2, NULL, 'category', NULL, NULL, '_self', 8, 0, 0, 1, '2023-08-14 07:03:28', '2023-08-14 07:49:17'),
(33, 1, 16, 3, NULL, 'category', NULL, NULL, '_self', 0, 0, 0, 1, '2023-08-14 07:49:44', '2023-08-14 07:49:48'),
(34, 1, 16, 3, NULL, 'category', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-08-14 07:50:46', '2023-08-14 07:50:46'),
(35, 1, 24, 3, NULL, 'category', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-08-14 07:52:10', '2023-08-14 07:52:10'),
(36, 1, 24, 3, NULL, 'category', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-08-14 07:54:37', '2023-08-14 07:54:37'),
(37, 2, 4, NULL, NULL, 'url', 'http://192.168.1.67:8000/blog', NULL, '_self', NULL, 0, 0, 1, '2023-08-14 12:40:22', '2023-08-14 12:40:39'),
(38, 2, 4, NULL, NULL, 'url', 'create_testimonials', NULL, '_self', NULL, 0, 0, 1, '2023-08-14 12:41:06', '2023-09-06 07:05:43'),
(39, 7, NULL, NULL, NULL, 'URL', NULL, NULL, '_self', 0, 1, 0, 1, '2023-08-17 04:45:18', '2023-08-17 04:45:18'),
(40, 7, 39, 1, NULL, 'category', NULL, NULL, '_self', 0, 0, 0, 1, '2023-08-17 04:45:36', '2023-08-28 09:21:19'),
(41, 2, 4, NULL, 7, 'page', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-08-17 05:07:47', '2023-08-17 05:07:47'),
(42, 5, 10, NULL, NULL, 'url', '#', NULL, '_self', 6, 0, 0, 1, '2023-08-17 05:10:32', '2023-10-17 14:04:13'),
(44, 5, 10, NULL, NULL, 'url', 'create_testimonials', NULL, '_self', 5, 0, 0, 1, '2023-09-06 07:04:24', '2023-10-17 14:03:08'),
(45, 5, 10, NULL, NULL, 'url', '/CustomizeProduct', NULL, '_blank', 7, 0, 0, 1, '2023-09-19 10:25:15', '2023-10-17 14:34:28'),
(46, 8, NULL, NULL, NULL, 'URL', NULL, NULL, '_self', 0, 1, 0, 1, '2023-10-17 14:22:17', '2023-10-17 14:22:17'),
(47, 8, 46, NULL, NULL, 'url', '#', NULL, '_self', 0, 0, 0, 1, '2023-10-17 14:22:50', '2023-10-17 14:24:21'),
(48, 8, 46, NULL, NULL, 'url', '#', NULL, '_self', 1, 0, 0, 1, '2023-10-17 14:23:09', '2023-10-17 14:24:21'),
(49, 8, 46, NULL, NULL, 'url', '#', NULL, '_self', 2, 0, 0, 1, '2023-10-17 14:23:24', '2023-10-17 14:24:21'),
(50, 8, 46, NULL, NULL, 'url', '#', NULL, '_self', 3, 0, 0, 1, '2023-10-17 14:23:51', '2023-10-17 14:24:21'),
(51, 8, 46, NULL, 2, 'page', '#', NULL, '_self', NULL, 0, 0, 1, '2023-10-17 14:24:17', '2023-10-17 14:24:25'),
(52, 8, 46, NULL, 8, 'page', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-10-17 14:24:48', '2023-10-17 14:24:48'),
(53, 9, NULL, NULL, NULL, 'URL', NULL, NULL, '_self', 0, 1, 0, 1, '2023-10-17 14:26:14', '2023-10-17 14:26:14'),
(54, 9, 53, NULL, 2, 'page', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-10-17 14:26:36', '2023-10-17 14:26:36'),
(55, 9, 53, NULL, 3, 'page', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-10-17 14:26:52', '2023-10-17 14:26:52'),
(56, 9, 53, NULL, 4, 'page', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-10-17 14:27:05', '2023-10-17 14:27:05'),
(57, 9, 53, NULL, 7, 'page', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-10-17 14:27:31', '2023-10-17 14:27:31'),
(58, 9, 53, NULL, NULL, 'url', '#', NULL, '_self', NULL, 0, 0, 1, '2023-10-17 14:27:54', '2023-10-17 14:27:54'),
(59, 9, 53, NULL, NULL, 'url', 'create_testimonials', NULL, '_self', NULL, 0, 0, 1, '2023-10-17 14:28:11', '2023-10-17 14:28:11'),
(60, 5, 10, NULL, NULL, 'url', 'account/blogs', NULL, '_blank', NULL, 0, 0, 1, '2023-10-30 13:48:16', '2023-10-30 14:34:14');

-- --------------------------------------------------------

--
-- Table structure for table `menu_item_translations`
--

CREATE TABLE `menu_item_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_item_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_item_translations`
--

INSERT INTO `menu_item_translations` (`id`, `menu_item_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'root'),
(4, 4, 'en', 'root'),
(5, 5, 'en', 'About Us'),
(6, 6, 'en', 'root'),
(7, 7, 'en', 'Privacy Policy'),
(8, 8, 'en', 'root'),
(9, 9, 'en', 'FAQ'),
(10, 10, 'en', 'root'),
(11, 11, 'en', 'Brands'),
(14, 14, 'en', 'Shop'),
(16, 16, 'en', 'Wedding Garlands'),
(17, 17, 'en', 'Saram Flowers'),
(18, 18, 'en', 'Pre-Order'),
(19, 19, 'en', 'Combo'),
(20, 20, 'en', 'Same Day Delivery'),
(21, 21, 'en', 'loose flowers'),
(22, 22, 'en', 'Saram Flowers'),
(23, 23, 'en', 'Hand Bouquet'),
(24, 24, 'en', 'Bouquet'),
(25, 25, 'en', 'Ring Type flower'),
(26, 26, 'en', 'Bouquet'),
(27, 27, 'en', 'Bouquet'),
(28, 28, 'en', 'root'),
(29, 29, 'en', 'Temple Garland'),
(30, 30, 'en', 'Flowers'),
(31, 31, 'en', 'Prayer Garland'),
(32, 32, 'en', 'Engagement Garland'),
(33, 33, 'en', 'Main Garlands'),
(34, 34, 'en', 'Loose Flowers'),
(35, 35, 'en', 'Bouquet With Vase'),
(36, 36, 'en', 'Bouquet without Vase'),
(37, 37, 'en', 'Blog'),
(38, 38, 'en', 'Testimonial'),
(39, 39, 'en', 'root'),
(40, 40, 'en', 'Saram flowers'),
(41, 41, 'en', 'Mission & Vission'),
(42, 42, 'en', 'Newsletter'),
(44, 44, 'en', 'Testimonial'),
(45, 45, 'en', 'Customize Products'),
(46, 46, 'en', 'root'),
(47, 47, 'en', 'Our Stores'),
(48, 48, 'en', 'How to Order'),
(49, 49, 'en', 'Delivery Info'),
(50, 50, 'en', 'Contact Us'),
(51, 51, 'en', 'About Us'),
(52, 52, 'en', 'Terms & Conditions'),
(53, 53, 'en', 'root'),
(54, 54, 'en', 'About Us'),
(55, 55, 'en', 'Privacy Policy'),
(56, 56, 'en', 'FAQ'),
(57, 57, 'en', 'Mission & Vission'),
(58, 58, 'en', 'Blog'),
(59, 59, 'en', 'Testimonial'),
(60, 60, 'en', 'Blog');

-- --------------------------------------------------------

--
-- Table structure for table `menu_translations`
--

CREATE TABLE `menu_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_translations`
--

INSERT INTO `menu_translations` (`id`, `menu_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'Products'),
(2, 2, 'en', 'About Us'),
(3, 3, 'en', 'Privacy Policy'),
(4, 4, 'en', 'FAQ'),
(5, 5, 'en', 'Shop'),
(6, 6, 'en', 'Flash sale'),
(7, 7, 'en', 'Garlands1'),
(8, 8, 'en', 'Help'),
(9, 9, 'en', 'Info');

-- --------------------------------------------------------

--
-- Table structure for table `meta_data`
--

CREATE TABLE `meta_data` (
  `id` int(10) UNSIGNED NOT NULL,
  `entity_type` varchar(191) NOT NULL,
  `entity_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meta_data`
--

INSERT INTO `meta_data` (`id`, `entity_type`, `entity_id`, `created_at`, `updated_at`) VALUES
(1, 'Modules\\Product\\Entities\\Product', 1, '2023-08-09 12:42:13', '2023-08-09 12:42:13'),
(2, 'Modules\\Brand\\Entities\\Brand', 1, '2023-08-09 12:44:27', '2023-08-09 12:44:27'),
(3, 'Modules\\Product\\Entities\\Product', 2, '2023-08-09 12:57:27', '2023-08-09 12:57:27'),
(4, 'Modules\\Brand\\Entities\\Brand', 2, '2023-08-10 08:10:46', '2023-08-10 08:10:46'),
(5, 'Modules\\Page\\Entities\\Page', 1, '2023-08-10 09:25:15', '2023-08-10 09:25:15'),
(6, 'Modules\\Page\\Entities\\Page', 2, '2023-08-11 05:02:02', '2023-08-11 05:02:02'),
(7, 'Modules\\Page\\Entities\\Page', 3, '2023-08-11 05:02:48', '2023-08-11 05:02:48'),
(8, 'Modules\\Page\\Entities\\Page', 4, '2023-08-11 05:43:43', '2023-08-11 05:43:43'),
(9, 'Modules\\Page\\Entities\\Page', 5, '2023-08-11 05:46:15', '2023-08-11 05:46:15'),
(10, 'Modules\\Product\\Entities\\Product', 3, '2023-08-11 09:50:51', '2023-08-11 09:50:51'),
(11, 'Modules\\Product\\Entities\\Product', 4, '2023-08-12 04:23:27', '2023-08-12 04:23:27'),
(12, 'Modules\\Product\\Entities\\Product', 5, '2023-08-14 09:58:24', '2023-08-14 09:58:24'),
(13, 'Modules\\Product\\Entities\\Product', 6, '2023-08-14 10:02:58', '2023-08-14 10:02:58'),
(14, 'Modules\\Product\\Entities\\Product', 7, '2023-08-14 10:23:32', '2023-08-14 10:23:32'),
(15, 'Modules\\Product\\Entities\\Product', 8, '2023-08-14 10:27:47', '2023-08-14 10:27:47'),
(16, 'Modules\\Product\\Entities\\Product', 9, '2023-08-14 10:33:12', '2023-08-14 10:33:12'),
(17, 'Modules\\Product\\Entities\\Product', 10, '2023-08-14 10:38:12', '2023-08-14 10:38:12'),
(18, 'Modules\\Product\\Entities\\Product', 11, '2023-08-14 10:42:56', '2023-08-14 10:42:56'),
(19, 'Modules\\Product\\Entities\\Product', 12, '2023-08-14 10:45:33', '2023-08-14 10:45:33'),
(20, 'Modules\\Product\\Entities\\Product', 13, '2023-08-14 10:51:37', '2023-08-14 10:51:37'),
(21, 'Modules\\Product\\Entities\\Product', 14, '2023-08-14 10:53:42', '2023-08-14 10:53:42'),
(22, 'Modules\\Product\\Entities\\Product', 15, '2023-08-14 11:05:19', '2023-08-14 11:05:19'),
(23, 'Modules\\Product\\Entities\\Product', 16, '2023-08-14 11:27:22', '2023-08-14 11:27:22'),
(24, 'Modules\\Product\\Entities\\Product', 17, '2023-08-14 12:06:21', '2023-08-14 12:06:21'),
(25, 'Modules\\Product\\Entities\\Product', 18, '2023-08-14 12:25:18', '2023-08-14 12:25:18'),
(26, 'Modules\\Page\\Entities\\Page', 6, '2023-08-17 05:00:44', '2023-08-17 05:00:44'),
(27, 'Modules\\Page\\Entities\\Page', 7, '2023-08-17 05:07:19', '2023-08-17 05:07:19'),
(28, 'Modules\\Product\\Entities\\Product', 19, '2023-08-25 09:12:24', '2023-08-25 09:12:24'),
(29, 'Modules\\Product\\Entities\\Product', 20, '2023-08-25 10:03:38', '2023-08-25 10:03:38'),
(30, 'Modules\\Product\\Entities\\Product', 21, '2023-08-25 10:20:53', '2023-08-25 10:20:53'),
(31, 'Modules\\Product\\Entities\\Product', 22, '2023-08-25 11:59:33', '2023-08-25 11:59:33'),
(32, 'Modules\\Page\\Entities\\Page', 8, '2023-08-25 12:23:22', '2023-08-25 12:23:22'),
(33, 'Modules\\Product\\Entities\\Product', 23, '2023-08-26 08:00:56', '2023-08-26 08:00:56'),
(34, 'Modules\\Page\\Entities\\Page', 9, '2023-08-28 09:25:49', '2023-08-28 09:25:49'),
(35, 'Modules\\Product\\Entities\\Product', 24, '2023-08-28 09:34:20', '2023-08-28 09:34:20'),
(36, 'Modules\\Product\\Entities\\Product', 25, '2023-10-06 14:04:57', '2023-10-06 14:04:57'),
(37, 'Modules\\Blogcategory\\Entities\\Blogcategory', 1, '2023-10-21 11:01:38', '2023-10-21 11:01:38'),
(38, 'Modules\\Product\\Entities\\Product', 26, '2023-10-26 07:10:58', '2023-10-26 07:10:58'),
(39, 'Modules\\Blogtag\\Entities\\Blogtag', 1, '2023-10-30 13:09:02', '2023-10-30 13:09:02'),
(40, 'Modules\\Blogpost\\Entities\\Blogpost', 1, '2023-10-30 13:09:55', '2023-10-30 13:09:55'),
(41, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 1, '2023-10-30 14:09:14', '2023-10-30 14:09:14'),
(42, 'Modules\\Blogpost\\Entities\\Blogpost', 2, '2023-10-30 14:10:19', '2023-10-30 14:10:19'),
(43, 'Modules\\Blogpost\\Entities\\Blogpostcomments', 1, '2023-10-30 14:11:17', '2023-10-30 14:11:17'),
(44, 'Modules\\Blogpost\\Entities\\Blogpost', 3, '2023-10-30 14:12:45', '2023-10-30 14:12:45'),
(45, 'Modules\\Blogpost\\Entities\\Blogpost', 4, '2023-10-30 14:12:45', '2023-10-30 14:12:45'),
(46, 'Modules\\Blogpost\\Entities\\Blogpost', 5, '2023-10-30 14:12:45', '2023-10-30 14:12:45'),
(47, 'Modules\\Blogpost\\Entities\\Blogpost', 6, '2023-10-30 14:12:45', '2023-10-30 14:12:45'),
(48, 'Modules\\Blogpost\\Entities\\Blogpost', 7, '2023-10-30 14:12:45', '2023-10-30 14:12:45'),
(49, 'Modules\\Blogpost\\Entities\\Blogpost', 8, '2023-10-30 14:12:45', '2023-10-30 14:12:45'),
(50, 'Modules\\Blogpost\\Entities\\Blogpost', 9, '2023-10-30 14:12:45', '2023-10-30 14:12:45'),
(51, 'Modules\\Blogpost\\Entities\\Blogpost', 10, '2023-10-30 14:12:45', '2023-10-30 14:12:45'),
(52, 'Modules\\Blogpost\\Entities\\Blogpost', 11, '2023-10-30 14:12:45', '2023-10-30 14:12:45'),
(53, 'Modules\\Blogpost\\Entities\\Blogpost', 12, '2023-10-30 14:12:45', '2023-10-30 14:12:45'),
(54, 'Modules\\Blogcategory\\Entities\\Blogcategory', 2, '2023-10-30 14:14:33', '2023-10-30 14:14:33'),
(55, 'Modules\\Blogcategory\\Entities\\Blogcategory', 3, '2023-10-30 14:14:33', '2023-10-30 14:14:33'),
(56, 'Modules\\Blogcategory\\Entities\\Blogcategory', 4, '2023-10-30 14:14:33', '2023-10-30 14:14:33'),
(57, 'Modules\\Blogcategory\\Entities\\Blogcategory', 5, '2023-10-30 14:14:33', '2023-10-30 14:14:33'),
(58, 'Modules\\Blogcategory\\Entities\\Blogcategory', 6, '2023-10-30 14:14:33', '2023-10-30 14:14:33'),
(59, 'Modules\\Blogcategory\\Entities\\Blogcategory', 7, '2023-10-30 14:14:33', '2023-10-30 14:14:33'),
(60, 'Modules\\Blogcategory\\Entities\\Blogcategory', 8, '2023-10-30 14:14:33', '2023-10-30 14:14:33'),
(61, 'Modules\\Blogcategory\\Entities\\Blogcategory', 9, '2023-10-30 14:14:33', '2023-10-30 14:14:33'),
(62, 'Modules\\Blogcategory\\Entities\\Blogcategory', 10, '2023-10-30 14:14:33', '2023-10-30 14:14:33'),
(63, 'Modules\\Blogcategory\\Entities\\Blogcategory', 11, '2023-10-30 14:14:33', '2023-10-30 14:14:33'),
(64, 'Modules\\Blogtag\\Entities\\Blogtag', 3, '2023-10-30 14:15:03', '2023-10-30 14:15:03'),
(65, 'Modules\\Blogtag\\Entities\\Blogtag', 4, '2023-10-30 14:15:03', '2023-10-30 14:15:03'),
(66, 'Modules\\Blogtag\\Entities\\Blogtag', 5, '2023-10-30 14:15:03', '2023-10-30 14:15:03'),
(67, 'Modules\\Blogtag\\Entities\\Blogtag', 6, '2023-10-30 14:15:03', '2023-10-30 14:15:03'),
(68, 'Modules\\Blogtag\\Entities\\Blogtag', 7, '2023-10-30 14:15:03', '2023-10-30 14:15:03'),
(69, 'Modules\\Blogtag\\Entities\\Blogtag', 8, '2023-10-30 14:15:03', '2023-10-30 14:15:03'),
(70, 'Modules\\Blogtag\\Entities\\Blogtag', 9, '2023-10-30 14:15:03', '2023-10-30 14:15:03'),
(71, 'Modules\\Blogtag\\Entities\\Blogtag', 10, '2023-10-30 14:15:03', '2023-10-30 14:15:03'),
(72, 'Modules\\Blogtag\\Entities\\Blogtag', 11, '2023-10-30 14:15:03', '2023-10-30 14:15:03'),
(73, 'Modules\\Blogtag\\Entities\\Blogtag', 12, '2023-10-30 14:15:03', '2023-10-30 14:15:03'),
(74, 'Modules\\Blogpost\\Entities\\Blogpost', 13, '2023-10-30 14:15:37', '2023-10-30 14:15:37'),
(75, 'Modules\\Blogpost\\Entities\\Blogpost', 14, '2023-10-30 14:15:37', '2023-10-30 14:15:37'),
(76, 'Modules\\Blogpost\\Entities\\Blogpost', 15, '2023-10-30 14:15:37', '2023-10-30 14:15:37'),
(77, 'Modules\\Blogpost\\Entities\\Blogpost', 16, '2023-10-30 14:15:37', '2023-10-30 14:15:37'),
(78, 'Modules\\Blogpost\\Entities\\Blogpost', 17, '2023-10-30 14:15:37', '2023-10-30 14:15:37'),
(79, 'Modules\\Blogpost\\Entities\\Blogpost', 18, '2023-10-30 14:15:37', '2023-10-30 14:15:37'),
(80, 'Modules\\Blogpost\\Entities\\Blogpost', 19, '2023-10-30 14:15:37', '2023-10-30 14:15:37'),
(81, 'Modules\\Blogpost\\Entities\\Blogpost', 20, '2023-10-30 14:15:37', '2023-10-30 14:15:37'),
(82, 'Modules\\Blogpost\\Entities\\Blogpost', 21, '2023-10-30 14:15:37', '2023-10-30 14:15:37'),
(83, 'Modules\\Blogpost\\Entities\\Blogpost', 22, '2023-10-30 14:15:37', '2023-10-30 14:15:37'),
(84, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 2, '2023-10-30 14:17:04', '2023-10-30 14:17:04'),
(85, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 3, '2023-10-30 14:17:11', '2023-10-30 14:17:11'),
(86, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 4, '2023-10-30 14:17:14', '2023-10-30 14:17:14'),
(87, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 5, '2023-10-30 14:17:20', '2023-10-30 14:17:20'),
(88, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 6, '2023-10-30 14:17:23', '2023-10-30 14:17:23'),
(89, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 7, '2023-10-30 14:17:27', '2023-10-30 14:17:27'),
(90, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 8, '2023-10-30 14:17:29', '2023-10-30 14:17:29'),
(91, 'Modules\\Blogpost\\Entities\\Blogpost', 23, '2023-10-30 14:28:55', '2023-10-30 14:28:55'),
(92, 'Modules\\Blogpost\\Entities\\Blogpostcomments', 2, '2023-10-31 07:43:18', '2023-10-31 07:43:18'),
(93, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 9, '2023-10-31 07:43:48', '2023-10-31 07:43:48'),
(94, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 10, '2023-10-31 07:43:51', '2023-10-31 07:43:51'),
(95, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 11, '2023-10-31 07:43:53', '2023-10-31 07:43:53'),
(96, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 12, '2023-10-31 07:43:55', '2023-10-31 07:43:55'),
(97, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 13, '2023-10-31 07:43:58', '2023-10-31 07:43:58'),
(98, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 14, '2023-10-31 07:44:00', '2023-10-31 07:44:00'),
(99, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 15, '2023-10-31 07:44:03', '2023-10-31 07:44:03'),
(100, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 16, '2023-10-31 07:46:20', '2023-10-31 07:46:20'),
(101, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 17, '2023-10-31 07:46:24', '2023-10-31 07:46:24'),
(102, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 18, '2023-10-31 07:46:28', '2023-10-31 07:46:28'),
(103, 'Modules\\Blogpost\\Entities\\Blogpostcomments', 3, '2023-10-31 07:46:55', '2023-10-31 07:46:55'),
(104, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 19, '2023-10-31 07:47:02', '2023-10-31 07:47:02'),
(105, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 20, '2023-10-31 07:47:51', '2023-10-31 07:47:51'),
(106, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 21, '2023-10-31 13:22:42', '2023-10-31 13:22:42'),
(107, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 22, '2023-10-31 13:22:44', '2023-10-31 13:22:44'),
(108, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 23, '2023-10-31 13:22:46', '2023-10-31 13:22:46'),
(109, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 24, '2023-10-31 13:37:20', '2023-10-31 13:37:20'),
(110, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 25, '2023-10-31 13:37:25', '2023-10-31 13:37:25'),
(111, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 26, '2023-10-31 13:37:31', '2023-10-31 13:37:31'),
(112, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 27, '2023-10-31 13:43:47', '2023-10-31 13:43:47'),
(113, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 28, '2023-10-31 13:43:50', '2023-10-31 13:43:50'),
(114, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 29, '2023-10-31 13:43:52', '2023-10-31 13:43:52'),
(115, 'Modules\\Blogpost\\Entities\\Blogpostlikesdislikes', 30, '2023-10-31 13:43:56', '2023-10-31 13:43:56'),
(116, 'Modules\\Subscriber\\Entities\\Subscriber', 1, '2023-11-01 14:03:15', '2023-11-01 14:03:15'),
(117, 'Modules\\Template\\Entities\\Template', 1, '2023-11-01 14:04:04', '2023-11-01 14:04:04'),
(118, 'Modules\\Subscriber\\Entities\\Subscriber', 2, '2023-11-01 14:04:53', '2023-11-01 14:04:53'),
(119, 'Modules\\Email\\Entities\\Email', 1, '2023-11-01 14:05:21', '2023-11-01 14:05:21'),
(120, 'Modules\\Email\\Entities\\Email', 2, '2023-11-01 14:18:45', '2023-11-01 14:18:45'),
(121, 'Modules\\Email\\Entities\\Email', 3, '2023-11-01 14:19:27', '2023-11-01 14:19:27'),
(122, 'Modules\\Email\\Entities\\Email', 4, '2023-11-01 14:19:40', '2023-11-01 14:19:40'),
(123, 'Modules\\Email\\Entities\\Email', 5, '2023-11-01 14:19:52', '2023-11-01 14:19:52'),
(124, 'Modules\\Email\\Entities\\Email', 6, '2023-11-01 14:20:05', '2023-11-01 14:20:05'),
(125, 'Modules\\Email\\Entities\\Email', 7, '2023-11-01 14:21:02', '2023-11-01 14:21:02'),
(126, 'Modules\\Email\\Entities\\Email', 8, '2023-11-01 14:22:40', '2023-11-01 14:22:40'),
(127, 'Modules\\Email\\Entities\\Email', 10, '2023-11-02 09:09:44', '2023-11-02 09:09:44'),
(128, 'Modules\\Subscriber\\Entities\\Subscriber', 3, '2023-11-03 08:16:36', '2023-11-03 08:16:36'),
(129, 'Modules\\Product\\Entities\\Product', 27, '2023-11-17 10:52:57', '2023-11-17 10:52:57');

-- --------------------------------------------------------

--
-- Table structure for table `meta_data_translations`
--

CREATE TABLE `meta_data_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `meta_data_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `meta_title` varchar(191) DEFAULT NULL,
  `meta_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `meta_data_translations`
--

INSERT INTO `meta_data_translations` (`id`, `meta_data_id`, `locale`, `meta_title`, `meta_description`) VALUES
(1, 1, 'en', 'Wedding garland', 'Wedding garland'),
(2, 2, 'en', NULL, NULL),
(3, 3, 'en', NULL, NULL),
(4, 4, 'en', 'Yellowish Flower', 'Celebrate your day with our wonderful products!'),
(5, 5, 'en', NULL, NULL),
(6, 6, 'en', 'About Us', 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.'),
(7, 7, 'en', 'privacy-policy', 'Your privacy is as important to us as it is to you. We know you hate SPAM and so do we. That is why we will never sell or share your information with anyone without your express permission. We respect your rights and will do everything in our power to protect your personal information. In the interest of full disclosure, we provide this notice explaining our online information collection practices. This privacy notice discloses the privacy practices for EnvaySoft (herein known as we, us and our company) and applies solely to information collected by this web site.'),
(8, 8, 'en', NULL, NULL),
(9, 9, 'en', NULL, NULL),
(10, 10, 'en', NULL, NULL),
(11, 11, 'en', NULL, NULL),
(12, 12, 'en', NULL, NULL),
(13, 13, 'en', NULL, NULL),
(14, 14, 'en', NULL, NULL),
(15, 15, 'en', NULL, NULL),
(16, 16, 'en', NULL, NULL),
(17, 17, 'en', NULL, NULL),
(18, 18, 'en', NULL, NULL),
(19, 19, 'en', NULL, NULL),
(20, 20, 'en', NULL, NULL),
(21, 21, 'en', NULL, NULL),
(22, 22, 'en', NULL, NULL),
(23, 23, 'en', NULL, NULL),
(24, 24, 'en', NULL, NULL),
(25, 25, 'en', NULL, NULL),
(26, 26, 'en', NULL, NULL),
(27, 27, 'en', NULL, NULL),
(28, 28, 'en', NULL, NULL),
(29, 29, 'en', NULL, NULL),
(30, 30, 'en', NULL, NULL),
(31, 31, 'en', NULL, NULL),
(32, 32, 'en', NULL, NULL),
(33, 33, 'en', NULL, NULL),
(34, 34, 'en', NULL, NULL),
(35, 35, 'en', NULL, NULL),
(36, 36, 'en', NULL, NULL),
(37, 38, 'en', NULL, NULL),
(38, 117, 'en', NULL, NULL),
(39, 129, 'en', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_07_02_230147_migration_cartalyst_sentinel', 1),
(2, '2014_10_14_200250_create_settings_table', 1),
(3, '2014_10_26_162751_create_files_table', 1),
(4, '2014_10_30_191858_create_pages_table', 1),
(5, '2014_11_31_125848_create_page_translations_table', 1),
(6, '2015_02_27_105241_create_entity_files_table', 1),
(7, '2015_11_20_184604486385_create_translations_table', 1),
(8, '2015_11_20_184604743083_create_translation_translations_table', 1),
(9, '2017_05_29_155126144426_create_products_table', 1),
(10, '2017_05_30_155126416338_create_product_translations_table', 1),
(11, '2017_08_02_153217_create_options_table', 1),
(12, '2017_08_02_153348_create_option_translations_table', 1),
(13, '2017_08_02_153406_create_option_values_table', 1),
(14, '2017_08_02_153736_create_option_value_translations_table', 1),
(15, '2017_08_03_156576_create_product_options_table', 1),
(16, '2017_08_17_170128_create_related_products_table', 1),
(17, '2017_08_17_175236_create_up_sell_products_table', 1),
(18, '2017_08_17_175828_create_cross_sell_products_table', 1),
(19, '2017_11_09_141332910964_create_categories_table', 1),
(20, '2017_11_09_141332931539_create_category_translations_table', 1),
(21, '2017_11_26_083614526622_create_meta_data_table', 1),
(22, '2017_11_26_083614526828_create_meta_data_translations_table', 1),
(23, '2018_01_24_125642_create_product_categories_table', 1),
(24, '2018_02_04_150917488267_create_coupons_table', 1),
(25, '2018_02_04_150917488698_create_coupon_translations_table', 1),
(26, '2018_03_11_181317_create_coupon_products_table', 1),
(27, '2018_03_15_091937_create_coupon_categories_table', 1),
(28, '2018_04_18_154028776225_create_reviews_table', 1),
(29, '2018_05_17_115822452977_create_currency_rates_table', 1),
(30, '2018_07_03_124153537506_create_sliders_table', 1),
(31, '2018_07_03_124153537695_create_slider_translations_table', 1),
(32, '2018_07_03_133107770172_create_slider_slides_table', 1),
(33, '2018_07_03_133107770486_create_slider_slide_translations_table', 1),
(34, '2018_07_28_190524758357_create_attribute_sets_table', 1),
(35, '2018_07_28_190524758497_create_attribute_set_translations_table', 1),
(36, '2018_07_28_190524758646_create_attributes_table', 1),
(37, '2018_07_28_190524758877_create_attribute_translations_table', 1),
(38, '2018_07_28_190524759461_create_product_attributes_table', 1),
(39, '2018_08_01_001919718631_create_tax_classes_table', 1),
(40, '2018_08_01_001919718935_create_tax_class_translations_table', 1),
(41, '2018_08_01_001919723551_create_tax_rates_table', 1),
(42, '2018_08_01_001919723781_create_tax_rate_translations_table', 1),
(43, '2018_08_03_195922206748_create_attribute_values_table', 1),
(44, '2018_08_03_195922207019_create_attribute_value_translations_table', 1),
(45, '2018_08_04_190524764275_create_product_attribute_values_table', 1),
(46, '2018_08_07_135631306565_create_orders_table', 1),
(47, '2018_08_07_135631309451_create_order_products_table', 1),
(48, '2018_08_07_135631309512_create_order_product_options_table', 1),
(49, '2018_08_07_135631309624_create_order_product_option_values_table', 1),
(50, '2018_09_11_213926106353_create_transactions_table', 1),
(51, '2018_09_19_081602135631_create_order_taxes_table', 1),
(52, '2018_09_19_103745_create_setting_translations_table', 1),
(53, '2018_10_01_224852175056_create_wish_lists_table', 1),
(54, '2018_10_04_185608_create_search_terms_table', 1),
(55, '2018_11_03_160015_create_menus_table', 1),
(56, '2018_11_03_160138_create_menu_translations_table', 1),
(57, '2018_11_03_160753_create_menu_items_table', 1),
(58, '2018_11_03_160804_create_menu_item_translation_table', 1),
(59, '2019_02_05_162605_add_position_to_slider_slides_table', 1),
(60, '2019_02_09_164343_remove_file_id_from_slider_slides_table', 1),
(61, '2019_02_09_164434_add_file_id_to_slider_slide_translations_table', 1),
(62, '2019_02_14_103408_create_attribute_categories_table', 1),
(63, '2019_08_09_164759_add_slug_column_to_attributes_table', 1),
(64, '2019_11_01_201511_add_special_price_type_column_to_products_table', 1),
(65, '2019_11_23_193101_add_value_column_to_order_product_options_table', 1),
(66, '2020_01_04_211424_add_icon_column_to_menu_items_table', 1),
(67, '2020_01_05_160502_add_direction_column_to_slider_slide_translations_table', 1),
(68, '2020_01_05_234014_add_speed_column_to_sliders_table', 1),
(69, '2020_01_05_235014_add_fade_column_to_sliders_table', 1),
(70, '2020_01_15_000346259038_create_flash_sales_table', 1),
(71, '2020_01_15_000346259349_create_flash_sale_translations_table', 1),
(72, '2020_01_23_011234_create_flash_sale_products_table', 1),
(73, '2020_01_30_015722_create_flash_sale_product_orders_table', 1),
(74, '2020_02_22_215943_delete_meta_keywords_column_from_meta_data_translations_table', 1),
(75, '2020_03_05_214602901973_create_brands_table', 1),
(76, '2020_03_05_214602902369_create_brand_translations_table', 1),
(77, '2020_03_06_234605_add_brand_id_column_to_products_table', 1),
(78, '2020_04_06_211526_add_note_column_to_orders_table', 1),
(79, '2020_04_28_034118164376_create_tags_table', 1),
(80, '2020_04_28_034118164618_create_tag_translations_table', 1),
(81, '2020_04_28_225657_create_product_tags_table', 1),
(82, '2020_05_10_041616_create_updater_scripts_table', 1),
(83, '2020_10_07_175000_create_addresses_table', 1),
(84, '2020_10_07_175004_create_default_addresses_table', 1),
(85, '2020_11_21_163822_add_downloads_columns_to_products_table', 1),
(86, '2021_01_08_203241_change_shipping_method_column_in_orders_table', 1),
(87, '2021_01_09_172744_add_phone_column_to_users_table', 1),
(88, '2021_01_11_170516_create_order_downloads_table', 1),
(89, '2023_05_04_194556_rename_column_virtual_to_is_virtual', 2),
(90, '2023_08_16_173847_addfiled_products_table', 3),
(91, '2023_08_25_131155_add_column_to_order_products_table', 4),
(92, '2023_08_10_150917488267_create_reward_points_table', 5),
(93, '2023_08_22_151429_create-customer_reward_points-table', 5),
(97, '2018_02_04_150917488267_create_testimonials_table', 7),
(98, '2023_09_07_122259_create_customer_reward_points_table', 8),
(99, '2023_09_01_161415_new_two_columns', 9),
(102, '2023_08_31_153518_create_fixedrates_table', 12),
(103, '2023_09_12_183236_update_image_url_table_name', 13),
(104, '2023_09_16_151727_recurring_orders_table', 14),
(105, '2023_09_19_155956_create_recurring_orders_table', 15),
(106, '2023_09_19_194606_create_recurring_sub_orders_table', 16),
(107, '2023_09_21_121305_add_customer_reward_point_id-field', 17),
(112, '2023_08_24_124310_createabandonedlisttable', 19),
(113, '2023_09_14_164525_create_galleries_table', 20),
(114, '2023_09_26_141438_add_delivery_date_orders_table', 21),
(115, '2023_09_16_141332910964_create_blogtags_migrate_table', 22),
(116, '2023_09_16_141332910964_create_blogcategorys_migrate_table', 23),
(117, '2023_10_25_203958_add-field-orders-table', 24),
(118, '2023_08_31_121553_create_pickupstore_table', 25),
(119, '2023_10_11_125618_create_blogfeedback_table', 26),
(120, '2023_10_14_125618_create_blogcommenttable', 27),
(121, '2023_10_30_205153_create_custom_stored_procedure_get_customers_active_reward_points', 28),
(122, '2023_10_31_130749_create_custom_stored_procedure_get_allcustomers_active_reward_points', 29),
(127, '2023_10_31_164142_add_customer_reward_order-id_review-id_fields', 30),
(128, '2023_08_29_204009_create-reward_points_gifted-table', 31),
(130, '2023_10_05_182626_create_emails_table', 33),
(131, '2023_09_27_171909_create_subscribers_table', 34),
(132, '2023_09_30_154851_create_templates_table', 35),
(133, '2023_09_30_154953_create_template_translations_table', 36),
(134, '2023_09_12_125559_add_user_type', 37),
(135, '2023_09_29_165155_add_user_type', 38),
(136, '2023_10_04_120942_add_user_type_to_address', 39),
(137, '2023_10_27_144639_create_recurrings_table', 40),
(138, '2023_10_27_144918_create_recurring_sub_orders_table', 41),
(139, '2023_10_31_120500_add_column_order_status_to_recurring_sub_orders', 42),
(140, '2023_10_30_195722_add_column_isRecurring_to_orders_table', 43);

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `id` int(10) UNSIGNED NOT NULL,
  `type` varchar(191) NOT NULL,
  `is_required` tinyint(1) NOT NULL,
  `is_global` tinyint(1) NOT NULL DEFAULT 1,
  `position` int(10) UNSIGNED DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`id`, `type`, `is_required`, `is_global`, `position`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'checkbox_custom', 1, 1, NULL, NULL, '2023-08-09 12:53:11', '2023-08-09 12:53:11'),
(2, 'multiple_select', 1, 0, 0, NULL, '2023-08-09 12:56:06', '2023-08-09 12:56:06'),
(3, 'field', 0, 0, 0, NULL, '2023-08-09 12:58:10', '2023-08-09 12:58:10'),
(4, 'checkbox', 1, 0, 0, NULL, '2023-08-11 09:52:02', '2023-08-11 10:26:26'),
(5, 'checkbox', 0, 0, 0, NULL, '2023-08-11 11:18:20', '2023-08-11 11:18:20'),
(6, 'checkbox', 1, 0, 0, NULL, '2023-08-14 10:19:42', '2023-08-25 06:59:02'),
(7, 'checkbox', 0, 0, 0, NULL, '2023-08-14 10:23:31', '2023-08-14 10:23:31'),
(8, 'dropdown', 0, 0, 0, NULL, '2023-08-14 10:27:46', '2023-08-25 06:58:21'),
(9, 'checkbox', 0, 0, 0, NULL, '2023-10-26 07:10:58', '2023-10-26 07:10:58');

-- --------------------------------------------------------

--
-- Table structure for table `option_translations`
--

CREATE TABLE `option_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `option_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `option_translations`
--

INSERT INTO `option_translations` (`id`, `option_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'discount'),
(2, 2, 'en', 'Recrring'),
(3, 3, 'en', 'Garland'),
(4, 4, 'en', 'Pre-order'),
(5, 5, 'en', 'Garland'),
(6, 6, 'en', 'Today Only'),
(7, 7, 'en', 'Same day delivery'),
(8, 8, 'en', 'Special Offer'),
(9, 9, 'en', 'With ice box packing');

-- --------------------------------------------------------

--
-- Table structure for table `option_values`
--

CREATE TABLE `option_values` (
  `id` int(10) UNSIGNED NOT NULL,
  `option_id` int(10) UNSIGNED NOT NULL,
  `price` decimal(18,4) UNSIGNED DEFAULT NULL,
  `price_type` varchar(10) NOT NULL,
  `position` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `option_values`
--

INSERT INTO `option_values` (`id`, `option_id`, `price`, `price_type`, `position`, `created_at`, `updated_at`) VALUES
(1, 1, '10.0000', 'percent', 0, '2023-08-09 12:53:11', '2023-08-09 12:53:11'),
(2, 2, NULL, 'percent', 0, '2023-08-09 12:56:06', '2023-08-09 12:56:06'),
(4, 4, '50.0000', 'fixed', 0, '2023-08-11 09:52:02', '2023-08-11 09:52:02'),
(5, 5, '20.0000', 'fixed', 0, '2023-08-11 11:18:21', '2023-08-11 11:18:21'),
(6, 3, '200.0000', 'fixed', 0, '2023-08-14 09:59:33', '2023-08-14 09:59:33'),
(7, 6, '190.0000', 'fixed', 0, '2023-08-14 10:19:42', '2023-08-14 10:19:42'),
(8, 6, '280.0000', 'fixed', 1, '2023-08-14 10:19:42', '2023-08-14 10:19:42'),
(9, 7, '10.0000', 'fixed', 0, '2023-08-14 10:23:31', '2023-08-14 10:23:31'),
(10, 8, '250.0000', 'fixed', 0, '2023-08-14 10:27:46', '2023-08-25 06:53:15'),
(11, 8, '400.0000', 'fixed', 1, '2023-08-25 06:53:15', '2023-08-25 06:53:15'),
(12, 9, '2.0000', 'percent', 0, '2023-10-26 07:10:58', '2023-10-26 07:31:05');

-- --------------------------------------------------------

--
-- Table structure for table `option_value_translations`
--

CREATE TABLE `option_value_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `option_value_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `label` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `option_value_translations`
--

INSERT INTO `option_value_translations` (`id`, `option_value_id`, `locale`, `label`) VALUES
(1, 1, 'en', 'Discount'),
(2, 2, 'en', 'Yes'),
(3, 4, 'en', 'Pre-order'),
(4, 5, 'en', 'Pre-order'),
(5, 7, 'en', '2Kg'),
(6, 8, 'en', '3Kg'),
(7, 9, 'en', 'Same day delivery'),
(8, 10, 'en', 'Buy one, get one free'),
(9, 11, 'en', 'Buy One , get Two free'),
(10, 12, 'en', 'With ice box packing');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_email` varchar(191) NOT NULL,
  `customer_phone` varchar(191) DEFAULT NULL,
  `customer_first_name` varchar(191) NOT NULL,
  `customer_last_name` varchar(191) NOT NULL,
  `billing_first_name` varchar(191) NOT NULL,
  `billing_last_name` varchar(191) NOT NULL,
  `billing_address_1` varchar(191) NOT NULL,
  `billing_address_2` varchar(191) DEFAULT NULL,
  `billing_city` varchar(191) NOT NULL,
  `billing_state` varchar(191) NOT NULL,
  `billing_zip` varchar(191) NOT NULL,
  `billing_country` varchar(191) NOT NULL,
  `shipping_first_name` varchar(191) NOT NULL,
  `shipping_last_name` varchar(191) DEFAULT NULL,
  `shipping_address_1` varchar(191) NOT NULL,
  `shipping_address_2` varchar(191) DEFAULT NULL,
  `shipping_city` varchar(191) NOT NULL,
  `shipping_state` varchar(191) NOT NULL,
  `shipping_zip` varchar(191) NOT NULL,
  `shipping_country` varchar(191) NOT NULL,
  `sub_total` decimal(18,4) UNSIGNED NOT NULL,
  `shipping_method` varchar(191) DEFAULT NULL,
  `shipping_cost` decimal(18,4) UNSIGNED NOT NULL,
  `coupon_id` int(11) DEFAULT NULL,
  `discount` decimal(18,4) UNSIGNED NOT NULL,
  `total` decimal(18,4) UNSIGNED NOT NULL,
  `payment_method` varchar(191) NOT NULL,
  `currency` varchar(191) NOT NULL,
  `currency_rate` decimal(18,4) NOT NULL,
  `locale` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL,
  `user_type` varchar(191) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `isRecurring` tinyint(1) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `delivery_date` date DEFAULT NULL,
  `pickupstore_address_id` int(11) DEFAULT NULL,
  `rewardpoints_id` bigint(20) UNSIGNED DEFAULT NULL,
  `redemption_amount` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `customer_email`, `customer_phone`, `customer_first_name`, `customer_last_name`, `billing_first_name`, `billing_last_name`, `billing_address_1`, `billing_address_2`, `billing_city`, `billing_state`, `billing_zip`, `billing_country`, `shipping_first_name`, `shipping_last_name`, `shipping_address_1`, `shipping_address_2`, `shipping_city`, `shipping_state`, `shipping_zip`, `shipping_country`, `sub_total`, `shipping_method`, `shipping_cost`, `coupon_id`, `discount`, `total`, `payment_method`, `currency`, `currency_rate`, `locale`, `status`, `user_type`, `note`, `isRecurring`, `deleted_at`, `created_at`, `updated_at`, `delivery_date`, `pickupstore_address_id`, `rewardpoints_id`, `redemption_amount`) VALUES
(1, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '300.0000', NULL, '0.0000', 1, '0.0000', '300.0000', 'cod', 'USD', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-07-31 12:13:44', '2023-08-10 12:13:44', NULL, NULL, NULL, NULL),
(2, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '5.0000', 'local_pickup', '2.0000', NULL, '0.0000', '7.0000', 'cod', 'MYR', '1.0000', 'en', 'completed', NULL, NULL, 0, NULL, '2023-08-11 09:11:54', '2023-08-11 09:12:49', NULL, NULL, NULL, NULL),
(3, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '56.0000', NULL, '0.0000', NULL, '0.0000', '56.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-11 09:14:18', '2023-08-11 09:14:19', NULL, NULL, NULL, NULL),
(4, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '56.0000', NULL, '0.0000', NULL, '0.0000', '56.0000', 'cod', 'MYR', '1.0000', 'en', 'completed', NULL, NULL, 0, NULL, '2023-08-11 09:14:38', '2023-08-11 09:23:35', NULL, NULL, NULL, NULL),
(5, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '5.0000', 'local_pickup', '2.0000', NULL, '0.0000', '7.0000', 'cod', 'MYR', '1.0000', 'en', 'completed', NULL, NULL, 0, NULL, '2023-08-11 09:15:48', '2023-08-11 09:23:18', NULL, NULL, NULL, NULL),
(6, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '140.0000', 'free_shipping', '0.0000', NULL, '0.0000', '140.0000', 'cod', 'MYR', '1.0000', 'en', 'completed', NULL, NULL, 0, NULL, '2023-08-11 10:27:44', '2023-08-11 11:25:14', NULL, NULL, NULL, NULL),
(7, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '5.0000', 'local_pickup', '2.0000', NULL, '0.0000', '7.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-12 04:40:06', '2023-08-16 11:11:35', NULL, NULL, NULL, NULL),
(8, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '18.0000', NULL, '0.0000', NULL, '0.0000', '18.0000', 'cod', 'MYR', '1.0000', 'en', 'completed', NULL, NULL, 0, NULL, '2023-08-23 05:44:15', '2023-08-24 06:03:37', NULL, NULL, NULL, NULL),
(9, 3, 'mahi@santhila.co', '9994520822', 'Navin', 'Elangovan', 'Navin', 'Elangovan', '121-Kovil Street', NULL, 'Erode', 'TN', '638004', 'IN', 'Navin', 'Elangovan', '121-Kovil Street', NULL, 'Erode', 'TN', '638004', 'IN', '269.0000', 'free_shipping', '0.0000', 1, '10.0000', '259.0000', 'cod', 'MYR', '1.0000', 'en', 'completed', NULL, 'Gift', 0, NULL, '2023-08-22 11:08:50', '2023-08-22 11:11:12', NULL, NULL, NULL, NULL),
(10, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '158.0000', 'free_shipping', '0.0000', NULL, '0.0000', '158.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-22 05:56:04', '2023-08-24 05:56:06', NULL, NULL, NULL, NULL),
(11, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '144090000.0000', 'local_pickup', '2.0000', NULL, '0.0000', '144090002.0000', 'cod', 'MYR', '1.0000', 'en', 'canceled', NULL, NULL, 0, NULL, '2023-08-24 05:57:23', '2023-08-24 05:58:03', NULL, NULL, NULL, NULL),
(12, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '2.0000', 'local_pickup', '2.0000', NULL, '0.0000', '4.0000', 'cod', 'MYR', '1.0000', 'en', 'refunded', NULL, NULL, 0, NULL, '2023-08-24 05:59:09', '2023-08-24 06:01:39', NULL, NULL, NULL, NULL),
(13, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '2147.0000', 'free_shipping', '0.0000', NULL, '0.0000', '2147.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-24 06:37:58', '2023-08-24 06:38:00', NULL, NULL, NULL, NULL),
(14, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '29970.0000', 'free_shipping', '0.0000', NULL, '0.0000', '29970.0000', 'cod', 'MYR', '1.0000', 'en', 'canceled', NULL, NULL, 0, NULL, '2023-08-24 06:38:40', '2023-08-24 07:11:19', NULL, NULL, NULL, NULL),
(15, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '90.0000', 'local_pickup', '2.0000', 2, '9.0000', '83.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-24 13:12:01', '2023-08-24 13:12:02', NULL, NULL, NULL, NULL),
(16, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '4.0000', 'local_pickup', '2.0000', NULL, '0.0000', '6.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-24 13:12:23', '2023-08-24 13:12:23', NULL, NULL, NULL, NULL),
(17, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '14.0000', 'local_pickup', '2.0000', 2, '9.0000', '7.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-23 13:12:54', '2023-08-24 13:12:55', NULL, NULL, NULL, NULL),
(18, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '24.0000', 'local_pickup', '2.0000', NULL, '0.0000', '26.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-24 13:13:34', '2023-08-24 13:13:35', NULL, NULL, NULL, NULL),
(19, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '18.0000', NULL, '0.0000', 2, '9.0000', '9.0000', 'cod', 'MYR', '1.0000', 'en', 'refunded', NULL, NULL, 0, NULL, '2023-07-05 13:14:00', '2023-08-24 13:16:48', NULL, NULL, NULL, NULL),
(20, 5, 'prabakaran13@santhila.co', '9578009264', 'Prabakaran', 'V', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakara', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '29.0000', 'local_pickup', '2.0000', NULL, '0.0000', '31.0000', 'cod', 'MYR', '1.0000', 'en', 'processing', NULL, 'Trial Enrty', 0, NULL, '2023-07-13 13:22:14', '2023-08-24 13:26:37', NULL, NULL, NULL, NULL),
(22, 5, 'prabakaran13@santhila.co', '9578009264', 'Prabakara', 'V', 'Prabakara', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakara', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '431.0000', 'free_shipping', '0.0000', 4, '150.8500', '280.1500', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-24 13:34:28', '2023-08-24 13:34:29', NULL, NULL, NULL, NULL),
(23, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '9.0000', 'local_pickup', '2.0000', NULL, '0.0000', '11.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-24 13:38:49', '2023-08-24 13:38:50', NULL, NULL, NULL, NULL),
(24, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '14.0000', 'local_pickup', '2.0000', NULL, '0.0000', '16.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-24 13:40:22', '2023-08-24 13:40:23', NULL, NULL, NULL, NULL),
(25, 6, 'msangeethaece2001@gmail.com', '9788894897', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'SGR', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'SGR', '6380000', 'MY', '9.0000', 'local_pickup', '2.0000', NULL, '0.0000', '11.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, 'First Time visit your website - Order Note', 0, NULL, '2023-08-24 13:49:41', '2023-08-24 13:49:42', NULL, NULL, NULL, NULL),
(26, 6, 'msangeethaece2001@gmail.com', '9788894897', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'SGR', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'SGR', '6380000', 'MY', '187.0000', 'free_shipping', '0.0000', NULL, '0.0000', '187.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-24 13:56:59', '2023-08-24 13:56:59', NULL, NULL, NULL, NULL),
(27, 6, 'msangeethaece2001@gmail.com', '9788894897', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'SGR', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'SGR', '6380000', 'MY', '999.0000', 'free_shipping', '0.0000', NULL, '0.0000', '999.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-24 14:02:23', '2023-08-24 14:02:23', NULL, NULL, NULL, NULL),
(28, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '46.0000', 'local_pickup', '2.0000', NULL, '0.0000', '48.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-24 15:27:11', '2023-08-24 15:27:12', NULL, NULL, NULL, NULL),
(29, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '9.0000', 'local_pickup', '2.0000', NULL, '0.0000', '11.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 08:05:17', '2023-08-25 08:05:18', NULL, NULL, NULL, NULL),
(30, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '999.0000', 'free_shipping', '0.0000', NULL, '0.0000', '999.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 08:20:02', '2023-08-25 08:20:02', NULL, NULL, NULL, NULL),
(31, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '2.0000', 'local_pickup', '2.0000', NULL, '0.0000', '4.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 09:04:59', '2023-08-25 09:05:00', NULL, NULL, NULL, NULL),
(32, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '250.0000', 'local_pickup', '2.0000', 1, '10.0000', '242.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 09:28:55', '2023-08-25 09:28:56', NULL, NULL, NULL, NULL),
(33, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '199.0000', 'free_shipping', '0.0000', 5, '0.0000', '199.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 09:34:48', '2023-08-25 09:34:49', NULL, NULL, NULL, NULL),
(34, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '999.0000', 'free_shipping', '0.0000', 5, '100.0000', '899.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 09:41:36', '2023-08-25 09:41:36', NULL, NULL, NULL, NULL),
(35, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '200.0000', 'free_shipping', '0.0000', 5, '200.0000', '0.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 09:50:36', '2023-08-25 09:50:36', NULL, NULL, NULL, NULL),
(36, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '20.0000', 'flat_rate', '200.0000', NULL, '0.0000', '220.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 12:16:36', '2023-08-25 12:16:37', NULL, NULL, NULL, NULL),
(37, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '19.0000', 'local_pickup', '2.0000', NULL, '0.0000', '21.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 12:52:03', '2023-08-25 12:52:04', NULL, NULL, NULL, NULL),
(38, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '9.0000', 'free_shipping', '0.0000', NULL, '0.0000', '9.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 13:26:24', '2023-08-25 13:26:26', NULL, NULL, NULL, NULL),
(39, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '160.0000', 'local_pickup', '2.0000', 4, '2.0000', '160.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 14:22:07', '2023-08-25 14:22:09', NULL, NULL, NULL, NULL),
(40, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '709.0000', 'free_shipping', '0.0000', NULL, '0.0000', '709.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-25 14:50:54', '2023-08-25 14:50:57', NULL, NULL, NULL, NULL),
(41, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '66.0000', 'local_pickup', '2.0000', NULL, '0.0000', '68.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-26 09:21:16', '2023-08-26 09:21:18', NULL, NULL, NULL, NULL),
(42, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '20.0000', 'local_pickup', '2.0000', NULL, '0.0000', '22.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-28 08:01:00', '2023-08-28 08:01:02', NULL, NULL, NULL, NULL),
(43, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '9.0000', 'local_pickup', '2.0000', NULL, '0.0000', '11.0000', 'cod', 'MYR', '1.0000', 'en', 'processing', NULL, NULL, 0, NULL, '2023-08-28 09:41:33', '2023-08-28 09:44:48', NULL, NULL, NULL, NULL),
(44, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '30.0000', 'local_pickup', '2.0000', NULL, '0.0000', '32.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-08-28 10:47:40', '2023-08-28 10:47:42', NULL, NULL, NULL, NULL),
(45, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '199.0000', 'free_shipping', '0.0000', NULL, '0.0000', '199.0000', 'cod', 'MYR', '1.0000', 'en', 'processing', NULL, NULL, 0, NULL, '2023-08-28 12:41:24', '2023-08-31 14:26:30', NULL, NULL, NULL, NULL),
(46, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '90.0000', 'local_pickup', '2.0000', NULL, '0.0000', '92.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-09-06 08:09:18', '2023-09-06 08:09:21', NULL, NULL, NULL, NULL),
(47, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '20.0000', 'local_pickup', '2.0000', NULL, '0.0000', '22.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-09-09 09:14:47', '2023-09-09 09:14:49', NULL, NULL, NULL, NULL),
(48, 3, 'mahi@santhila.co', '9994520822', 'Navin', 'Elangovan', 'Navin', 'Elangovan', '121-Kovil Street', NULL, 'Erode', 'TN', '638004', 'IN', 'Navin', 'Elangovan', '121-Kovil Street', NULL, 'Erode', 'TN', '638004', 'IN', '560.0000', 'free_shipping', '0.0000', 1, '100.0000', '460.0000', 'cod', 'MYR', '1.0000', 'en', 'completed', NULL, 'Gift', 0, NULL, '2023-08-22 11:08:50', '2023-08-22 11:11:12', NULL, NULL, NULL, NULL),
(49, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '467.0000', 'free_shipping', '0.0000', NULL, '0.0000', '467.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-09-25 07:33:44', '2023-09-25 07:40:29', NULL, NULL, NULL, NULL),
(50, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '33.0000', 'free_shipping', '0.0000', NULL, '0.0000', '33.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-09-25 09:18:54', '2023-09-25 09:18:54', NULL, NULL, NULL, NULL),
(51, 1, 'giri@santhila.co', '91404040404', 'santhila', 'S', 'santhila', 'S', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', 'santhila', 'S', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', '158.0000', 'flat_rate', '22.0000', NULL, '0.0000', '180.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-09-28 11:40:46', '2023-09-28 11:40:46', NULL, NULL, NULL, NULL),
(52, 1, 'giri@santhila.co', '91404040404', 'santhila', 'S', 'santhila', 'S', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', 'santhila', 'S', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', '158.0000', 'flat_rate', '22.0000', NULL, '0.0000', '180.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-09-28 11:42:43', '2023-09-28 11:42:44', NULL, NULL, NULL, NULL),
(54, 5, 'prabakaran13@santhila.co', '9578009264', 'Prabakaran', 'V', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '1023.0000', 'free_shipping', '0.0000', NULL, '0.0000', '1023.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-06 07:36:09', '2023-10-06 07:36:11', NULL, NULL, NULL, NULL),
(55, 5, 'prabakaran13@santhila.co', '9578009264', 'Prabakaran', 'V', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '29.0000', 'local_pickup', '2.0000', NULL, '0.0000', '31.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, 'Order Note Test Entry. Birthday wishes', 0, NULL, '2023-10-06 07:44:11', '2023-10-06 07:44:11', '2023-10-11', NULL, NULL, NULL),
(56, 5, 'prabakaran13@santhila.co', '9578009264', 'Prabakaran', 'V', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '29.0000', 'local_pickup', '2.0000', NULL, '0.0000', '31.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-06 07:48:18', '2023-10-06 07:48:20', '2023-10-12', NULL, NULL, NULL),
(57, 5, 'prabakaran13@santhila.co', '9578009264', 'Prabakaran', 'V', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '11.0000', 'local_pickup', '2.0000', NULL, '0.0000', '13.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-06 08:04:46', '2023-10-06 08:04:49', NULL, NULL, NULL, NULL),
(58, 5, 'prabakaran13@santhila.co', '9578009264', 'Prabakaran', 'V', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '328.0000', 'free_shipping', '0.0000', NULL, '0.0000', '328.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-06 08:24:55', '2023-10-06 08:24:57', '2023-10-11', NULL, NULL, NULL),
(59, 5, 'prabakaran13@santhila.co', '9578009264', 'Prabakaran', 'V', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '300.0000', 'free_shipping', '0.0000', NULL, '0.0000', '300.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-06 08:48:38', '2023-10-06 08:48:40', '2023-10-06', NULL, NULL, NULL),
(62, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '9.0000', 'local_pickup', '2.0000', NULL, '0.0000', '11.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-10-25 10:52:46', '2023-10-25 10:52:46', '2023-10-26', NULL, NULL, NULL),
(63, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '9.0000', 'local_pickup', '2.0000', NULL, '0.0000', '11.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-10-25 10:53:04', '2023-10-25 10:53:04', '2023-10-26', NULL, NULL, NULL),
(64, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '9.0000', 'local_pickup', '2.0000', NULL, '0.0000', '11.0000', 'cod', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-10-25 10:53:16', '2023-10-25 10:53:16', '2023-10-26', NULL, NULL, NULL),
(65, 1, 'giri@santhila.co', '91404040404', 'santhila', 'S', 'santhila', 'S', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', 'santhila', 'S', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', '199.0000', 'local_pickup', '2.0000', NULL, '0.0000', '201.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-10-25 11:01:38', '2023-10-25 11:01:38', '2023-10-26', NULL, NULL, NULL),
(66, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '199.0000', 'local_pickup', '2.0000', NULL, '0.0000', '201.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-10-25 12:53:45', '2023-10-25 12:53:45', '2023-10-26', NULL, NULL, NULL),
(67, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '199.0000', 'local_pickup', '2.0000', NULL, '0.0000', '201.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-25 12:54:18', '2023-10-25 12:54:21', '2023-10-26', NULL, NULL, NULL),
(68, 1, 'giri@santhila.co', '91404040404', 'santhila', 'S', 'santhila', 'S', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', 'santhila', 'S', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', '11.0000', 'flat_rate', '22.0000', NULL, '0.0000', '33.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-25 15:12:04', '2023-10-25 15:12:07', NULL, 8, NULL, NULL),
(70, 7, 'indhumathi@santhila.co', '9995511447', 'Indumathi', 'E', 'Indumathi', 'E', 'kulalumpur', NULL, 'kulalumpur', 'TRG', '59000', 'MY', 'APS Main', NULL, 'Kuala Lumpur', 'Kuala Lumpur', 'Kuala Lumpur', 'KUL', '59000', 'MY', '9.0000', 'local_pickup', '2.0000', NULL, '0.0000', '11.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-26 06:55:30', '2023-10-26 06:55:32', NULL, 1, NULL, NULL),
(71, 7, 'indhumathi@santhila.co', '9995511447', 'Indumathi', 'E', 'Indumathi', 'E', 'kulalumpur', NULL, 'kulalumpur', 'TRG', '59000', 'MY', 'APS Selangor', NULL, 'Selangorr', 'Selangor', 'Selangor', 'SGR', '59001', 'MY', '158.0000', 'local_pickup', '2.0000', NULL, '0.0000', '160.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-26 07:02:19', '2023-10-26 07:02:20', NULL, 2, NULL, NULL),
(72, 7, 'indhumathi@santhila.co', '9995511447', 'Indumathi', 'E', 'Indumathi', 'E', 'kulalumpur', NULL, 'kulalumpur', 'TRG', '59000', 'MY', 'APS Main', NULL, 'Kuala Lumpur', 'Kuala Lumpur', 'Kuala Lumpur', 'KUL', '59000', 'MY', '2.0000', 'local_pickup', '2.0000', NULL, '0.0000', '4.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-26 07:03:49', '2023-10-26 07:03:51', NULL, 1, NULL, NULL),
(73, 7, 'indhumathi@santhila.co', '9995511447', 'Indumathi', 'E', 'Indumathi', 'E', 'kulalumpur', NULL, 'kulalumpur', 'TRG', '59000', 'MY', 'APS Selangor', NULL, 'Selangorr', 'Selangor', 'Selangor', 'SGR', '59001', 'MY', '9.0000', 'local_pickup', '2.0000', NULL, '0.0000', '11.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-10-26 07:04:47', '2023-10-26 07:04:49', NULL, 2, NULL, NULL),
(74, 7, 'indhumathi@santhila.co', '9995511447', 'Indumathi', 'E', 'Indumathi', 'E', 'kulalumpur', NULL, 'kulalumpur', 'TRG', '59000', 'MY', 'APS Main', NULL, 'Kuala Lumpur', 'Kuala Lumpur', 'Kuala Lumpur', 'KUL', '59000', 'MY', '8.2800', 'local_pickup', '2.0000', NULL, '0.0000', '10.2800', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-10-26 08:36:52', '2023-10-26 08:36:52', NULL, 1, NULL, NULL),
(85, 8, 'prabakaran@santhila.co1', '9578009226', 'Prabakaran1', 'V', 'Prabakaran1', 'V', 'Address 1', 'Address 2', 'Kualalumpur', 'KUL', '59000', 'MY', 'Prabakaran1', 'V', 'Address 1', 'Address 2', 'Kualalumpur', 'KUL', '59000', 'MY', '163.0000', 'free_shipping', '0.0000', 6, '50.0000', '93.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, 'Test Order Note', 0, NULL, '2023-10-28 11:11:01', '2023-10-28 11:11:01', NULL, NULL, 40, '20.00'),
(86, 8, 'prabakaran@santhila.co1', '9578009226', 'Prabakaran1', 'V', 'Prabakaran1', 'V', 'Address 1', 'Address 2', 'Kualalumpur', 'KUL', '59000', 'MY', 'Prabakaran1', 'V', 'Address 1', 'Address 2', 'Kualalumpur', 'KUL', '59000', 'MY', '163.0000', 'free_shipping', '0.0000', 6, '50.0000', '93.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, 'Special Note for delivery', 0, NULL, '2023-10-28 11:13:38', '2023-10-28 11:13:42', NULL, NULL, 41, '15.00'),
(96, 4, 'prabakaran@santhila.co', '9578009264', 'Prabakaran', 'V', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '269.0000', 'free_shipping', '0.0000', NULL, '0.0000', '269.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-10-31 13:19:24', '2023-10-31 13:19:24', NULL, NULL, 55, '25.00'),
(97, 1, 'giri@santhila.co', '91404040404', 'GIRISH', 'SHANKAR', 'GIRISH', 'SHANKAR', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', 'GIRISH', 'SHANKAR', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', '300.0000', 'flat_rate', '22.0000', NULL, '0.0000', '322.0000', 'cod', 'MYR', '1.0000', 'en', 'pending_payment', 'Login', NULL, 0, NULL, '2023-11-01 15:41:22', '2023-11-01 15:41:22', NULL, NULL, NULL, NULL),
(98, 3, 'mahi@santhila.co', '9994520822', 'Mahendran', 'Sadhasivam', 'Mahendran', 'Sadhasivam', '338/1A LVR colony', NULL, 'Erode', '', '638004', 'MY', 'Mahendran', 'Sadhasivam', 'Mahendran Sadhasivam', '338/1A LVR colony', 'Erode', '', '638004', 'MY', '800.0000', 'local_pickup', '2.0000', NULL, '0.0000', '802.0000', 'cod', 'MYR', '1.0000', 'en', 'pending_payment', 'Login', NULL, 0, NULL, '2023-11-01 15:45:45', '2023-11-01 15:45:45', '2023-11-11', NULL, NULL, NULL),
(99, 3, 'mahi@santhila.co', '9994520822', 'Mahendran', 'Sadhasivam', 'Mahendran', 'Sadhasivam', '121-Kovil Street', NULL, 'Erode', '', '638004', 'MY', 'Mahendran', 'Sadhasivam', '121-Kovil Street', NULL, 'Erode', '', '638004', 'MY', '250.0000', 'free_shipping', '0.0000', NULL, '0.0000', '250.0000', 'cod', 'MYR', '1.0000', 'en', 'pending_payment', 'Login', NULL, 0, NULL, '2023-11-01 15:51:56', '2023-11-01 15:51:56', NULL, NULL, NULL, NULL),
(100, 1, 'giri@santhila.co', '91404040404', 'GIRISH', 'SHANKAR', 'GIRISH', 'SHANKAR', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'GIRISH', 'SHANKAR', 'kulalumpur', NULL, 'kulalumpur', 'KUL', '59003', 'MY', '150.0000', 'flat_rate', '22.0000', NULL, '0.0000', '172.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', 'Login', NULL, 0, NULL, '2023-11-02 06:25:52', '2023-11-02 06:25:52', '2023-11-03', NULL, NULL, NULL),
(101, 1, 'indhumathi123@santhila.co', '91404040404', 'GIRISH', 'SHANKAR', 'GIRISH', 'SHANKAR', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'GIRISH', 'SHANKAR', 'APS JHR', 'Johor Bahru', 'Johor Bahru', 'TRG', 'Johor Bahru', 'MY', '150.0000', 'local_pickup', '2.0000', NULL, '0.0000', '152.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', 'Login', NULL, 0, NULL, '2023-11-02 06:34:24', '2023-11-02 06:34:24', '2023-11-03', NULL, NULL, NULL),
(102, 3, 'mahi@santhila.co', '9994520822', 'Mahendran', 'Sadhasivam', 'Mahendran', 'Sadhasivam', '121-Kovil Street', NULL, 'Erode', '', '638004', 'MY', 'Mahendran', 'Sadhasivam', '338/1A LVR colony', NULL, 'Erode', '', '638004', 'MY', '150.0000', 'free_shipping', '0.0000', NULL, '0.0000', '150.0000', 'cod', 'MYR', '1.0000', 'en', 'completed', 'Login', NULL, 0, NULL, '2023-11-02 14:21:45', '2023-11-02 14:21:45', NULL, NULL, NULL, NULL),
(103, 5, 'prabakaran13@santhila.co', '9578009264', 'Prabakaran', 'V', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '280.0000', 'local_pickup', '2.0000', NULL, '0.0000', '282.0000', 'razerpay', 'MYR', '1.0000', 'en', 'completed', NULL, NULL, 1, NULL, '2023-11-10 12:10:40', '2023-11-10 12:10:40', NULL, NULL, NULL, NULL),
(105, 4, 'prabakaran@santhila.co', '9578009264', 'Prabakaran', 'V', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', 'Prabakaran', 'V', '#45667, Jalan Gopeng, Off Jalan Pasar,', NULL, 'Klang', 'SGR', '41400', 'MY', '161.0000', 'local_pickup', '2.0000', NULL, '0.0000', '163.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-11-11 08:01:28', '2023-11-11 08:01:28', NULL, NULL, 60, '5.00'),
(106, 1, 'giri@santhila.co', '91404040404', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'TRG', '6380000', 'MY', '63.0000', 'local_pickup', '2.0000', NULL, '0.0000', '65.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 1, NULL, '2023-11-17 10:29:17', '2023-11-17 10:29:17', NULL, NULL, NULL, NULL),
(107, 6, 'sangeetha@gmail.com', '9788894897', 'Sangeetha', 'M', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'SGR', '6380000', 'MY', 'Sangeetha', 'M', 'SOLAR', 'ERODE', 'ERODE', 'SGR', '6380000', 'MY', '16.7256', 'local_pickup', '2.0000', NULL, '0.0000', '18.7256', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-11-17 10:39:06', '2023-11-17 10:39:06', NULL, NULL, NULL, NULL),
(108, 6, 'sangeetha@gmail.com', '9788894897', 'Sangeetha', 'M', 'Sangeetha', 'M', 'erode', NULL, 'erode', '', '59000', 'MY', 'Sangeetha', 'M', 'APS Main', 'Kuala Lumpur', 'Kuala Lumpur', '', 'Kuala Lumpur', 'MY', '140.0000', 'local_pickup', '2.0000', 9, '15.4000', '126.6000', 'cod', 'MYR', '1.0000', 'en', 'completed', 'Login', NULL, 0, NULL, '2023-11-17 10:56:54', '2023-11-17 10:56:54', NULL, NULL, NULL, NULL),
(109, 6, 'sangeetha@gmail.com', '9788894897', 'Sangeetha', 'M', 'Sangeetha', 'M', 'erode', NULL, 'erode', '', '59000', 'MY', 'Sangeetha', 'M', 'APS Main', 'Kuala Lumpur', 'Kuala Lumpur', '', 'Kuala Lumpur', 'MY', '140.0000', 'local_pickup', '2.0000', 9, '15.4000', '126.6000', 'cod', 'MYR', '1.0000', 'en', 'completed', 'Login', NULL, 0, NULL, '2023-11-17 10:56:56', '2023-11-17 10:56:56', NULL, NULL, NULL, NULL),
(110, 23, 'udhaya@gmail.com', '546465', 'udhya', 's', 'udhya', 's', 'Malaysia', 'Malaysia', 'Malaysia', 'SGR', '59000', 'MY', 'udhya', 's', 'Malaysia', 'Malaysia', 'Malaysia', 'SGR', '59000', 'MY', '99.0000', 'local_pickup', '2.0000', NULL, '0.0000', '101.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-11-17 11:59:46', '2023-11-17 11:59:46', NULL, NULL, NULL, NULL),
(111, 23, 'udhaya@gmail.com', '546465', 'udhya', 's', 'udhya', 's', 'Malaysia', 'Malaysia', 'Malaysia', 'SGR', '59000', 'MY', 'udhya', 's', 'Malaysia', 'Malaysia', 'Malaysia', 'SGR', '59000', 'MY', '99.0000', 'local_pickup', '2.0000', NULL, '0.0000', '101.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-11-17 12:07:17', '2023-11-17 12:07:17', NULL, NULL, NULL, NULL),
(112, 23, 'udhaya@gmail.com', '546465', 'udhya', 's', 'udhya', 's', 'Malaysia', 'Malaysia', 'Malaysia', 'SGR', '59000', 'MY', 'udhya', 's', 'Malaysia', 'Malaysia', 'Malaysia', 'SGR', '59000', 'MY', '99.0000', 'local_pickup', '2.0000', NULL, '0.0000', '101.0000', 'cod', 'MYR', '1.0000', 'en', 'pending', NULL, NULL, 0, NULL, '2023-11-17 12:15:07', '2023-11-17 12:15:09', NULL, NULL, NULL, NULL),
(113, 23, 'udhaya@gmail.com', '546465', 'udhya', 's', 'udhya', 's', 'Malaysia', 'Malaysia', 'Malaysia', 'SGR', '59000', 'MY', 'udhya', 's', 'Malaysia', 'Malaysia', 'Malaysia', 'SGR', '59000', 'MY', '396.0000', 'free_shipping', '0.0000', NULL, '0.0000', '396.0000', 'razerpay', 'MYR', '1.0000', 'en', 'pending_payment', NULL, NULL, 0, NULL, '2023-11-17 12:20:57', '2023-11-17 12:20:57', NULL, NULL, 62, '20.00');

-- --------------------------------------------------------

--
-- Table structure for table `order_downloads`
--

CREATE TABLE `order_downloads` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `file_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_downloads`
--

INSERT INTO `order_downloads` (`id`, `order_id`, `file_id`) VALUES
(1, 28, 215),
(2, 28, 207),
(3, 29, 215),
(4, 29, 207),
(5, 38, 215),
(6, 40, 215);

-- --------------------------------------------------------

--
-- Table structure for table `order_products`
--

CREATE TABLE `order_products` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `unit_price` decimal(18,4) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `line_total` decimal(18,4) UNSIGNED NOT NULL,
  `delivery_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_products`
--

INSERT INTO `order_products` (`id`, `order_id`, `product_id`, `unit_price`, `qty`, `line_total`, `delivery_date`) VALUES
(1, 1, 1, '150.0000', 2, '300.0000', NULL),
(2, 2, 2, '5.0000', 1, '5.0000', NULL),
(3, 3, 1, '56.0000', 1, '56.0000', NULL),
(4, 4, 1, '56.0000', 1, '56.0000', NULL),
(5, 5, 2, '5.0000', 1, '5.0000', NULL),
(6, 6, 3, '70.0000', 2, '140.0000', NULL),
(7, 7, 2, '5.0000', 1, '5.0000', NULL),
(8, 8, 11, '18.0000', 1, '18.0000', NULL),
(9, 9, 2, '199.0000', 1, '199.0000', NULL),
(10, 9, 3, '70.0000', 1, '70.0000', NULL),
(11, 10, 7, '158.0000', 1, '158.0000', NULL),
(12, 11, 18, '9.0000', 16010000, '144090000.0000', NULL),
(13, 12, 17, '2.0000', 1, '2.0000', NULL),
(14, 13, 17, '2.0000', 1, '2.0000', NULL),
(15, 13, 13, '147.0000', 1, '147.0000', NULL),
(16, 13, 6, '999.0000', 2, '1998.0000', NULL),
(17, 14, 6, '999.0000', 30, '29970.0000', NULL),
(18, 15, 18, '9.0000', 10, '90.0000', NULL),
(19, 16, 17, '2.0000', 2, '4.0000', NULL),
(20, 17, 16, '14.0000', 1, '14.0000', NULL),
(21, 18, 15, '24.0000', 1, '24.0000', NULL),
(22, 19, 11, '18.0000', 1, '18.0000', NULL),
(23, 20, 18, '9.0000', 1, '9.0000', NULL),
(24, 20, 5, '20.0000', 1, '20.0000', NULL),
(28, 22, 10, '19.0000', 5, '95.0000', NULL),
(29, 22, 7, '158.0000', 2, '316.0000', NULL),
(30, 22, 5, '20.0000', 1, '20.0000', NULL),
(31, 23, 18, '9.0000', 1, '9.0000', NULL),
(32, 24, 16, '14.0000', 1, '14.0000', NULL),
(33, 25, 18, '9.0000', 1, '9.0000', NULL),
(34, 26, 11, '18.0000', 1, '18.0000', NULL),
(35, 26, 10, '19.0000', 1, '19.0000', NULL),
(36, 26, 9, '150.0000', 1, '150.0000', NULL),
(37, 27, 6, '999.0000', 1, '999.0000', NULL),
(38, 28, 16, '14.0000', 2, '28.0000', NULL),
(39, 28, 18, '9.0000', 2, '18.0000', NULL),
(40, 29, 18, '9.0000', 1, '9.0000', NULL),
(41, 30, 6, '999.0000', 1, '999.0000', NULL),
(42, 31, 17, '2.0000', 1, '2.0000', NULL),
(43, 32, 14, '250.0000', 1, '250.0000', NULL),
(44, 33, 2, '199.0000', 1, '199.0000', NULL),
(45, 34, 6, '999.0000', 1, '999.0000', NULL),
(46, 35, 1, '200.0000', 1, '200.0000', NULL),
(47, 36, 5, '20.0000', 1, '20.0000', NULL),
(48, 37, 10, '19.0000', 1, '19.0000', '2023-08-27'),
(49, 38, 18, '9.0000', 1, '9.0000', NULL),
(50, 39, 3, '20.0000', 8, '160.0000', NULL),
(51, 40, 14, '250.0000', 1, '250.0000', NULL),
(52, 40, 9, '150.0000', 3, '450.0000', NULL),
(53, 40, 18, '9.0000', 1, '9.0000', NULL),
(54, 41, 17, '2.0000', 1, '2.0000', NULL),
(55, 41, 16, '14.0000', 1, '14.0000', NULL),
(56, 41, 12, '50.0000', 1, '50.0000', NULL),
(57, 42, 5, '20.0000', 1, '20.0000', '2023-09-10'),
(58, 43, 24, '9.0000', 1, '9.0000', NULL),
(59, 44, 10, '19.0000', 1, '19.0000', NULL),
(60, 44, 17, '2.0000', 1, '2.0000', NULL),
(61, 44, 24, '9.0000', 1, '9.0000', NULL),
(62, 45, 2, '199.0000', 1, '199.0000', NULL),
(63, 46, 24, '9.0000', 10, '90.0000', NULL),
(64, 47, 3, '20.0000', 1, '20.0000', NULL),
(65, 49, 7, '158.0000', 1, '158.0000', NULL),
(66, 49, 10, '19.0000', 1, '19.0000', NULL),
(67, 49, 8, '145.0000', 2, '290.0000', NULL),
(68, 50, 24, '9.0000', 1, '9.0000', NULL),
(69, 50, 15, '24.0000', 1, '24.0000', NULL),
(70, 51, 7, '158.0000', 1, '158.0000', NULL),
(71, 52, 7, '158.0000', 1, '158.0000', NULL),
(73, 54, 15, '24.0000', 1, '24.0000', NULL),
(74, 54, 6, '999.0000', 1, '999.0000', NULL),
(75, 55, 24, '9.0000', 1, '9.0000', NULL),
(76, 55, 5, '20.0000', 1, '20.0000', NULL),
(77, 56, 24, '9.0000', 1, '9.0000', NULL),
(78, 56, 5, '20.0000', 1, '20.0000', NULL),
(79, 57, 24, '9.0000', 1, '9.0000', NULL),
(80, 57, 17, '2.0000', 1, '2.0000', NULL),
(81, 58, 9, '150.0000', 1, '150.0000', NULL),
(82, 58, 5, '20.0000', 1, '20.0000', NULL),
(83, 58, 7, '158.0000', 1, '158.0000', NULL),
(84, 59, 9, '150.0000', 2, '300.0000', NULL),
(89, 62, 24, '9.0000', 1, '9.0000', NULL),
(90, 63, 24, '9.0000', 1, '9.0000', NULL),
(91, 64, 24, '9.0000', 1, '9.0000', NULL),
(92, 65, 2, '199.0000', 1, '199.0000', NULL),
(93, 66, 2, '199.0000', 1, '199.0000', NULL),
(94, 67, 2, '199.0000', 1, '199.0000', NULL),
(95, 68, 24, '9.0000', 1, '9.0000', NULL),
(96, 68, 17, '2.0000', 1, '2.0000', NULL),
(100, 70, 24, '9.0000', 1, '9.0000', NULL),
(101, 71, 7, '158.0000', 1, '158.0000', NULL),
(102, 72, 17, '2.0000', 1, '2.0000', NULL),
(103, 73, 24, '9.0000', 1, '9.0000', NULL),
(104, 74, 26, '8.2800', 1, '8.2800', NULL),
(132, 85, 17, '2.0000', 1, '2.0000', NULL),
(133, 85, 13, '147.0000', 1, '147.0000', NULL),
(134, 85, 16, '14.0000', 1, '14.0000', NULL),
(135, 86, 17, '2.0000', 1, '2.0000', NULL),
(136, 86, 13, '147.0000', 1, '147.0000', NULL),
(137, 86, 16, '14.0000', 1, '14.0000', NULL),
(158, 96, 14, '250.0000', 1, '250.0000', NULL),
(159, 96, 10, '19.0000', 1, '19.0000', NULL),
(160, 97, 4, '100.0000', 3, '300.0000', NULL),
(161, 98, 2, '200.0000', 3, '600.0000', '2023-11-11'),
(162, 98, 10, '20.0000', 10, '200.0000', '2023-11-11'),
(163, 99, 5, '25.0000', 10, '250.0000', NULL),
(164, 100, 3, '50.0000', 3, '150.0000', '2023-11-03'),
(165, 101, 13, '150.0000', 1, '150.0000', '2023-11-03'),
(166, 102, 3, '50.0000', 3, '150.0000', NULL),
(167, 103, 12, '50.0000', 1, '50.0000', NULL),
(168, 103, 5, '20.0000', 1, '20.0000', NULL),
(171, 105, 16, '14.0000', 1, '14.0000', NULL),
(172, 105, 13, '147.0000', 1, '147.0000', NULL),
(173, 106, 24, '9.0000', 1, '9.0000', NULL),
(174, 107, 26, '8.4456', 1, '8.4456', NULL),
(175, 107, 26, '8.2800', 1, '8.2800', NULL),
(176, 108, 16, '14.0000', 10, '140.0000', NULL),
(177, 109, 16, '14.0000', 10, '140.0000', NULL),
(178, 110, 27, '99.0000', 1, '99.0000', NULL),
(179, 111, 27, '99.0000', 1, '99.0000', NULL),
(180, 112, 27, '99.0000', 1, '99.0000', NULL),
(181, 113, 27, '99.0000', 4, '396.0000', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_product_options`
--

CREATE TABLE `order_product_options` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_product_id` int(10) UNSIGNED NOT NULL,
  `option_id` int(10) UNSIGNED NOT NULL,
  `value` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_product_options`
--

INSERT INTO `order_product_options` (`id`, `order_product_id`, `option_id`, `value`) VALUES
(1, 6, 4, NULL),
(2, 10, 4, NULL),
(5, 174, 9, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_product_option_values`
--

CREATE TABLE `order_product_option_values` (
  `order_product_option_id` int(10) UNSIGNED NOT NULL,
  `option_value_id` int(10) UNSIGNED NOT NULL,
  `price` decimal(18,4) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_product_option_values`
--

INSERT INTO `order_product_option_values` (`order_product_option_id`, `option_value_id`, `price`) VALUES
(1, 4, '50.0000'),
(2, 4, '50.0000'),
(5, 12, '0.1656');

-- --------------------------------------------------------

--
-- Table structure for table `order_taxes`
--

CREATE TABLE `order_taxes` (
  `order_id` int(10) UNSIGNED NOT NULL,
  `tax_rate_id` int(10) UNSIGNED NOT NULL,
  `amount` decimal(15,4) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(191) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `slug`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'garlands', 0, '2023-08-10 09:25:14', '2023-08-11 05:30:52'),
(2, 'about-us', 1, '2023-08-11 05:02:01', '2023-08-11 05:02:01'),
(3, 'privacy-policy', 1, '2023-08-11 05:02:48', '2023-08-11 05:04:20'),
(4, 'help-faq', 1, '2023-08-11 05:43:43', '2023-08-11 05:43:43'),
(5, 'brands', 1, '2023-08-11 05:46:15', '2023-08-11 05:46:15'),
(7, 'mission', 1, '2023-08-17 05:07:19', '2023-08-17 05:07:19'),
(8, 'terms-conditions', 1, '2023-08-25 12:23:22', '2023-08-25 12:23:22');

-- --------------------------------------------------------

--
-- Table structure for table `page_translations`
--

CREATE TABLE `page_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `page_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `body` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `page_translations`
--

INSERT INTO `page_translations` (`id`, `page_id`, `locale`, `name`, `body`) VALUES
(1, 1, 'en', 'Garlands', '<p>test</p>'),
(2, 2, 'en', 'About Us', '<div id=\"pg-181-0\" class=\"panel-grid panel-no-style\">\r\n<div id=\"pgc-181-0-0\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-0-0-0\" class=\"so-panel widget widget_black-studio-tinymce widget_black_studio_tinymce panel-first-child panel-last-child\" data-index=\"0\">\r\n<div id=\"pgc-181-0-0\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-0-0-0\" class=\"so-panel widget widget_black-studio-tinymce widget_black_studio_tinymce panel-first-child panel-last-child\" data-index=\"0\">\r\n<div id=\"pg-181-0\" class=\"panel-grid panel-no-style\">\r\n<div id=\"pgc-181-0-0\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-0-0-0\" class=\"so-panel widget widget_black-studio-tinymce widget_black_studio_tinymce panel-first-child panel-last-child\" data-index=\"0\">\r\n<div id=\"pg-181-0\" class=\"panel-grid panel-no-style\">\r\n<div id=\"pgc-181-0-0\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-0-0-0\" class=\"so-panel widget widget_black-studio-tinymce widget_black_studio_tinymce panel-first-child panel-last-child\" data-index=\"0\">\r\n<h3 class=\"widget-title\"><span class=\"light\">Who</span>&nbsp;We Are</h3>\r\n<div class=\"textwidget\">\r\n<p><strong>Nature Max Flourish Sdn Bhd</strong>&nbsp;(formally known as Nature Flow Enterprise) was established in the year 2016 to fill and support the ever growing needs of fresh flowers mainly for prayers, weddings, decorations, festivals and events.</p>\r\n<p>&nbsp;</p>\r\n</div>\r\n</div>\r\n</div>\r\n<div id=\"pgc-181-0-1\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-0-1-0\" class=\"so-panel widget widget_black-studio-tinymce widget_black_studio_tinymce panel-first-child panel-last-child\" data-index=\"1\">\r\n<div class=\"textwidget\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <img src=\"/storage/media/GGW8S0G1zME9cJ1BJreTtadaEVIum8pMyjPdLtc7.jpg\" alt=\"\" width=\"901\" height=\"484\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n<div id=\"pg-181-1\" class=\"panel-grid panel-no-style\">\r\n<div id=\"pgc-181-1-0\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-1-0-0\" class=\"so-panel widget widget_text panel-first-child panel-last-child\" data-index=\"2\">\r\n<div class=\"textwidget\">\r\n<div class=\"dropcap-wrap\">\r\n<div class=\"dropcap-pull\"><span class=\"dropcap style1\">1985</span></div>\r\n<strong>Started the Company</strong></div>\r\nThe business concept was inspired by Late Mr. Sellahdoray s/o Ramasamy and Madam Rasammal in 1985 whereby they started by selling jasmine flower and roses from their own small farm in Batu Arang to support the family.</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div id=\"pg-181-1\" class=\"panel-grid panel-no-style\">\r\n<div id=\"pgc-181-1-0\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-1-0-0\" class=\"so-panel widget widget_text panel-first-child panel-last-child\" data-index=\"2\">\r\n<div class=\"textwidget\">&nbsp;</div>\r\n<div class=\"textwidget\">&nbsp;</div>\r\n</div>\r\n</div>\r\n<div id=\"pgc-181-1-1\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-1-1-0\" class=\"so-panel widget widget_text panel-first-child panel-last-child\" data-index=\"3\">\r\n<div class=\"textwidget\">\r\n<div class=\"dropcap-wrap\">\r\n<div class=\"dropcap-pull\"><span class=\"dropcap style1\">1998</span></div>\r\n<strong class=\"dropcap-title\">Second Location</strong></div>\r\nIn 1998 they expand the farm to 10 acres to cover the demand of the flowers. As every business has downfall, in 2006 worker shortage and weather become an issue,his eldest son Mr. Palaniappan started to explore other alternative to sustain the business. As their grow, Mr. Ganesh the second son join together to build the empire.<br />\r\n<p>&nbsp;</p>\r\n</div>\r\n</div>\r\n</div>\r\n<div id=\"pgc-181-1-2\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-1-2-0\" class=\"so-panel widget widget_text panel-first-child panel-last-child\" data-index=\"4\">\r\n<div class=\"textwidget\">\r\n<div class=\"dropcap-wrap\">\r\n<div class=\"dropcap-pull\"><span class=\"dropcap style1\">2008</span></div>\r\n<strong class=\"dropcap-title\">Biggest Indian Flower Importer</strong></div>\r\nBy 2008 they started to import other flowers as well like Thailand roses, orchid and introduce the variety of flower into the market. In end of 2008 they decided to open an outlet in Brickfields for storage as well as a shop for retail market.\r\n<p>&nbsp;</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div id=\"pg-181-2\" class=\"panel-grid panel-no-style\">\r\n<div id=\"pgc-181-2-0\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-2-0-0\" class=\"so-panel widget widget_black-studio-tinymce widget_black_studio_tinymce panel-first-child\" data-index=\"5\">\r\n<h3 class=\"widget-title\"><span class=\"light\">Nation</span>&nbsp;Wide Distributor</h3>\r\n</div>\r\n<div id=\"panel-181-2-0-1\" class=\"so-panel widget widget_text panel-last-child\" data-index=\"6\">\r\n<div class=\"textwidget\">\r\n<p>After 10 years, now&nbsp;<strong>Nature Max Flourish Sdn Bhd</strong>&nbsp;is one of the largest wholesale flower distributors in Malaysia, supplying retail florists with high quality cut flowers, greens, fillers, and protea. We take pride of bringing in quality flower products by sources from both local and foreign farms mainly from Indonesia and India. The products are sourced from a carefully chosen partner farms to guarantee the best quality at the best and competitive price.</p>\r\n<p>By taking advantage of technology, innovative operations approach, strong partnerships built over a long time&nbsp;in this industry, and good old fashioned hard work,&nbsp;<strong>Nature Max Flourish Sdn</strong>&nbsp;<strong>Bhd</strong>&nbsp;is striving to be a cut above many of its competitors.&nbsp;<strong>Nature Max Flourish Sdn Bhd</strong>&nbsp;belief that we will do whatever is necessary and what our competitors are not willing to do to establish a long lasting relationship with the customer.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div id=\"pg-181-3\" class=\"panel-grid panel-has-style\">\r\n<div class=\"panel-row-style panel-row-style-for-181-3\">\r\n<div id=\"pgc-181-3-0\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-3-0-0\" class=\"so-panel widget widget_media_image panel-first-child panel-last-child\" data-index=\"7\"><img class=\"image wp-image-7457  attachment-large size-large about_img\" src=\"/storage/media/RVaFqlz4tw8V99qOwlKExMzjMZlw5CEg9CUxJqTj.jpg\" sizes=\"(max-width: 1024px) 100vw, 1024px\" srcset=\"https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-1-1024x576.jpg 1024w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-1-300x169.jpg 300w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-1-768x432.jpg 768w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-1-850x479.jpg 850w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-1-360x203.jpg 360w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-1.jpg 1365w\" alt=\"\" width=\"400\" height=\"224\" loading=\"lazy\" /><img class=\"image wp-image-7483  attachment-large size-large about_img\" style=\"border-width: 1px;\" src=\"/storage/media/JvA6ZeZPCYd73cgVVDve9WD0UiBIk2cm3GX77wDZ.jpg\" sizes=\"(max-width: 1024px) 100vw, 1024px\" srcset=\"https://www.naturemaxflorist.com.my/wp-content/uploads/2019/03/20160305_094336-1-1024x576.jpg 1024w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/03/20160305_094336-1-300x169.jpg 300w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/03/20160305_094336-1-768x432.jpg 768w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/03/20160305_094336-1-850x479.jpg 850w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/03/20160305_094336-1-360x203.jpg 360w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/03/20160305_094336-1.jpg 1920w\" alt=\"\" width=\"400\" height=\"226\" loading=\"lazy\" /><img class=\"image wp-image-7459  attachment-large size-large about_img\" src=\"/storage/media/blijTqVbkCuA4B6NyVOs6Io7fJ597WQWbjHRTOKr.jpg\" sizes=\"(max-width: 1024px) 100vw, 1024px\" srcset=\"https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-2-1024x576.jpg 1024w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-2-300x169.jpg 300w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-2-768x432.jpg 768w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-2-850x479.jpg 850w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-2-360x203.jpg 360w, https://www.naturemaxflorist.com.my/wp-content/uploads/2019/02/About-us-2.jpg 1366w\" alt=\"\" width=\"400\" height=\"225\" loading=\"lazy\" /></div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n<div>&nbsp;</div>'),
(3, 3, 'en', 'Privacy Policy', '<p>Your privacy is as important to us as it is to you. We know you hate SPAM and so do we. That is why we will never sell or share your information with anyone without your express permission. We respect your rights and will do everything in our power to protect your personal information. In the interest of full disclosure, we provide this notice explaining our online information collection practices. This privacy notice discloses the privacy practices for&nbsp;<a href=\"https://envaysoft.com/\">EnvaySoft</a>&nbsp;(herein known as we, us and our company) and applies solely to information collected by this web site.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Information Collection, Use, and Sharing</h4>\r\n<p>We are the sole owners of the information collected on this site. We only have access to information that you voluntarily give us via email or other direct contact from you. We will not sell or rent this information to anyone. We will use your information to respond to you, regarding the reason you contacted us. We will not share your information with any third party outside of our organization, other than as necessary to fulfill your request, e.g. to ship an order.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Disclosure</h4>\r\n<p>This site uses Google web analytics service. Google may record mouse clicks, mouse movements, scrolling activity as well as text you type in this website. This site does not use Google to collect any personally identifiable information entered in this website. Google does track your browsing habits across web sites which do not use Google services.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Security</h4>\r\n<p>We take precautions to protect your information. When you submit sensitive information via the website, your information is protected both online and offline.</p>\r\n<p>Wherever we collect sensitive information (such as credit card data), that information is encrypted and transmitted to us in a secure way. You can verify this by looking for a closed lock icon at the bottom of your web browser, or looking for &ldquo;https&rdquo; at the beginning of the address of the web page.</p>\r\n<p>While we use encryption to protect sensitive information transmitted online, we also protect your information offline. Only employees who need the information to perform a specific job (for example, billing or customer service) are granted access to personally identifiable information. The computers/servers in which we store personally identifiable information are kept in a secure environment.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Email Policy</h4>\r\n<p>The following are situations in which you may provide Your Information to us:</p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>\r\n<p>When you fill out forms or fields through our Services.</p>\r\n</li>\r\n<li>\r\n<p>When you register for an account with our Service.</p>\r\n</li>\r\n<li>\r\n<p>When you create a subscription for our newsletter or Services.</p>\r\n</li>\r\n<li>\r\n<p>When you provide responses to a survey.</p>\r\n</li>\r\n<li>\r\n<p>When you answer questions on a quiz.</p>\r\n</li>\r\n<li>\r\n<p>When you join or enroll in an event through our Services.</p>\r\n</li>\r\n<li>\r\n<p>When you order services or products from, or through our Service.</p>\r\n</li>\r\n<li>\r\n<p>When you provide information to us through a third-party application, service or Website.</p>\r\n</li>\r\n</ul>'),
(4, 4, 'en', 'Help & FAQ', '<h1>Help &amp; FAQ</h1>\r\n<p>&nbsp;</p>\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>What does LOREM mean?</h4>\r\n<p>&lsquo;Lorem ipsum dolor sit amet, consectetur adipisici elit&hellip;&rsquo; (complete text) is dummy text that is not meant to mean anything. It is used as a placeholder in magazine layouts, for example, in order to give an impression of the finished document. The text is intentionally unintelligible so that the viewer is not distracted by the content. The language is not real Latin and even the first word &lsquo;Lorem&rsquo; does not exist. It is said that the lorem ipsum text has been common among typesetters since the 16th century.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Why do we use it?</h4>\r\n<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Where does it come from?</h4>\r\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Where can I get some?</h4>\r\n<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Why do we use Lorem Ipsum?</h4>\r\n<p>Many times, readers will get distracted by readable text when looking at the layout of a page. Instead of using filler text that says &ldquo;Insert content here,&rdquo; Lorem Ipsum uses a normal distribution of letters, making it resemble standard English. This makes it easier for designers to focus on visual elements, as opposed to what the text on a page actually says. Lorem Ipsum is absolutely necessary in most design cases, too. Web design projects like landing pages, website redesigns and so on only look as intended when they\'re fully-fleshed out with content.</p>'),
(5, 5, 'en', 'Brands', '<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/apple/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/jZG1juhijMhWSrn8B4jgsX5x4Vb8dOTdZTtGNACo.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/samsung/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/nshpkDL124reDq8apPXBcpVrnV8ABDzC88R5gg3K.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/huawei/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/SbgS1CCecSpvvnBeBmG6xP49q2NymXQzJpiHbMAi.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/oneplus/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/JwT1Wydv8ADuSHBh7ZtCaWLkuO2Jy9WYZRovQW1W.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/hp/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/j2WP3lfi8JTanXQsxrNDclJAb2RHKxBOtlQwlK2g.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/dell/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/8bmlnpJluQBwAAJolyS708652aY6Kj8dEmYQ7woo.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/acer/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/rCfwklCfNTBKz4JGeloPqqI7BTS8PdYibzEkB8mS.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/asus/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/JnH5uK3QY3mOamQ8NsHCbtqj0xULHsjOTHtHTbeO.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/microsoft/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/HSvr36xBFke3Jh6mbDaeAG8jJZ4RH78ousrLr1i2.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/xiaomi/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/vW30vojYODrqYBs9x3ToIpBHm1zyrKU7ZhmD9SQG.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/google/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/RlQnH51zyXArkeBhIT0BCaJiyqAIcdCHCNjnsiZW.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/msi/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/8DfT3LNUhYbei3YrhJ1FscMVKiPPQi43LdCY29Am.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/lg/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/P9UF8sprnzBNqEnbAd2j82UA4b0fzk85uIZp4H4s.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/beats/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/3IcUp71JfyiH3wkWU0omhlcs0xqgdWzmY3Z4imMO.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/adidas/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/H0BnQ6XoB6vBb1YAkRg22mncLS76Yv0zGz4T4M04.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/nike/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/DbwfoaPYxERzjV8qsFUSpS9UMjskuZ5yauWC3Wtn.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/levis/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/Quysi8IloZADWNe2ZxeK98PN4FgHpoQWBXSnhlQV.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/nokia/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/cpX550XTke137wP71XC4bd6vGf68l6emVynXq3HJ.png\" alt=\"brand image\" /></a></div>'),
(7, 7, 'en', 'Mission', '<div id=\"pg-181-4\" class=\"panel-grid panel-no-style\">\r\n<div id=\"pgc-181-4-0\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-4-0-0\" class=\"so-panel widget widget_text panel-first-child panel-last-child\" data-index=\"10\">\r\n<h3 class=\"widget-title\"><span class=\"light\">Mission</span></h3>\r\n</div>\r\n</div>\r\n</div>\r\n<div id=\"pg-181-5\" class=\"panel-grid panel-no-style\">\r\n<div id=\"pgc-181-5-0\" class=\"panel-grid-cell\">\r\n<div id=\"panel-181-5-0-0\" class=\"so-panel widget widget_text panel-first-child panel-last-child\" data-index=\"11\">\r\n<div class=\"textwidget\">\r\n<p>To provide our valued customer with a great selection of high quality fresh flower at the best price possible, and the highest level of services for all of their needs.</p>\r\n<p>Now&nbsp;<strong>Naturemax Flourish Sdn Bhd</strong>&nbsp;operates from his main office in Brickfields and has a branch in Klang. They supply to most of the cities over East Malaysia where customer based.</p>\r\n</div>\r\n</div>\r\n</div>\r\n</div>'),
(8, 8, 'en', 'Terms & Conditions', '<div class=\"page-header\">\r\n<div class=\"page-title text-center\">\r\n<div class=\"container py-2 my-4\">\r\n<h1>Terms &amp; Conditions</h1>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"container-xl\">\r\n<div class=\"mb-5\">\r\n<div class=\"ck-content\">\r\n<p><strong>Dear Customers,</strong><br /><br />Welcome to Aps Garland !</p>\r\n<p>The following Terms and Conditions shall apply to your use of the Website owned and operated by&nbsp;<strong>Nature Max Flourish Sdn Bhd</strong><strong>&nbsp;&nbsp;</strong>&nbsp;&nbsp;(formally known as Nature Flow Enterprise), a company incorporated under the Companies Act, 2013 and having its registered office at&nbsp;No 26,&nbsp;Jalan Padang Belia, Brickfields, 50470 Kuala Lumpur, Malaysia&nbsp;(hereinafter referred to as &acirc;&euro;&oelig;Aps Garland&acirc;&euro; / &acirc;&euro;&oelig;We&acirc;&euro; / &acirc;&euro;&oelig;us&acirc;&euro;) through its website (www.apsgarlands.com) (hereinafter referred to as &acirc;&euro;&oelig;Website&acirc;&euro;) under the brand name &acirc;&euro;&tilde;Aps Garland&acirc;&euro;&trade;, that inter alia allows its users to browse, select and order a Nature Flowers item for their loved ones or relative or friend or family member or to the recipient as per the request of user. Aps Garlands provides this Website to customers in accordance with these Terms and Conditions. The customers hereinafter have been referred to as &acirc;&euro;&oelig;You&acirc;&euro; / &acirc;&euro;&oelig;User&acirc;&euro; / &acirc;&euro;&oelig;Your&acirc;&euro;. These Terms and Conditions along with Terms of use, Disclaimer and Privacy Policy governs the relationship between the customers and Aps Garlands.</p>\r\n<p>This document is published in accordance with the provisions of Rule 3(1) of the Information Technology (Intermediary Guidelines and Digital Media Ethics Code) Rules, 2021 read with Rule 5 of the Consumer Protection (E-Commerce) Rules, 2020 that require publishing the rules and regulations, privacy policy and Terms of Use for access or usage of this Website.</p>\r\n<p>These Terms and Conditions together with the Terms of use, Disclaimer and Privacy Policy and all other additional terms and conditions and policies posted on the Website (collectively referred to as &acirc;&euro;&oelig;Terms and Conditions&acirc;&euro;) constitute a legally binding agreement between the user of the Website and Aps Garland, being the owner of the Website. Please read the Terms and Conditions carefully before proceeding, as by completing the registration process and/or by using the Website, you signify your agreement with these Terms and Conditions. If you do not agree with any of these Terms and Conditions, then please do not access the Website and/or complete the registration process on the Website. In case of any discrepancy between these Terms and Conditions and any other content on the Website, these Terms and Conditions shall prevail. By confirming your acceptance to these Terms and Conditions, you hereby</p>\r\n<p>(a) represent and warrant that you are entitled to enter into agreement with the Company and that no other person is accepting these Terms and Conditions on your behalf; and (b) accept the provisions of these Terms and Conditions and your responsibilities and obligations in all aspects related to your use of the Website and buying the products/services. If you confirm these Terms and Conditions as an employee, agent, contractor or other representative any entity, you hereby represent and warrant that you have the right and authority to validly bind such entity. Aps Garland reserves right to add on or discontinue any services from its Website at its discretion.</p>\r\n<p>As part of the Website, Aps Garland may provide certain tools or guidance for the benefit of its users and to facilitate and support the selection, configuration and purchase of the products/services through the Website. Any information or guidance which may be provided by Aps Garland to its users is solely for information purposes and the users, at their own discretion, may decide to follow such guidance.</p>\r\n<p>Aps Garland retains the right at any time to deny or suspend access to any or all sections of/services provided through the Website to any user, who Aps Garland believes, has violated any of the provisions of these Terms and Conditions.</p>\r\n<p>Aps Garland shall be responsible for fulfilling your orders (either directly or through its delivery partners) including but not limited to issue invoice, deliver product to recipient, and in no event shall any of its affiliate, director, representative, officers, consultant or employee be responsible for transactions made on this Website.</p>\r\n</div>\r\n</div>\r\n</div>');

-- --------------------------------------------------------

--
-- Table structure for table `persistences`
--

CREATE TABLE `persistences` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `persistences`
--

INSERT INTO `persistences` (`id`, `user_id`, `code`, `created_at`, `updated_at`) VALUES
(1, 1, 'nKhKMpcLC0WqxJNZ2tkEn20iTOKpYYBu', '2023-08-09 12:25:28', '2023-08-09 12:25:28'),
(4, 1, 'Jspr12LV7SAXevDgbzlpQV8ho5FRuCI3', '2023-08-09 12:32:27', '2023-08-09 12:32:27'),
(5, 1, 'eIL0SBROjFqwAx16o55wZduFW2YEm9vG', '2023-08-09 12:32:39', '2023-08-09 12:32:39'),
(6, 1, 'Tq7NcZQJvwdrKeuZjGYhHHvoCCdKshEY', '2023-08-09 12:32:57', '2023-08-09 12:32:57'),
(8, 1, 'DbJi5p72cpq7XN3NAe92TmwHTYOQNpVn', '2023-08-09 12:52:49', '2023-08-09 12:52:49'),
(9, 1, 'cORRyGUEh9G4sAEuhBsbFH83tYySr9jq', '2023-08-09 12:54:32', '2023-08-09 12:54:32'),
(11, 1, '9QQMWJ4nzum3i5igDHdD9tTO6BIYRO59', '2023-08-10 04:59:12', '2023-08-10 04:59:12'),
(12, 1, 'h7kHErlJXje1Yyo2wuHCpyE5styS5qUJ', '2023-08-10 08:04:02', '2023-08-10 08:04:02'),
(13, 1, 'lH2mQwUOCvY3MtxPY8W79vzCBHKvAdjO', '2023-08-11 04:30:24', '2023-08-11 04:30:24'),
(14, 1, 'T1cfjoAUNo5LCp1fUs02j6hsrWSgZ4Lw', '2023-08-11 10:49:50', '2023-08-11 10:49:50'),
(15, 1, 'GTZ31NxNmORdPdPeunwhGorKIZeHrtAG', '2023-08-11 12:20:45', '2023-08-11 12:20:45'),
(17, 1, 'MFzn7Zw1DHz9KYukY8Ae78MGZM36RnoG', '2023-08-12 04:48:02', '2023-08-12 04:48:02'),
(18, 1, 'uduluI5v3rmPpPpmua1KNcTWyJIkHBB4', '2023-08-12 05:08:36', '2023-08-12 05:08:36'),
(20, 1, 'iocMdrjLCMeYjUw1cfZqbD7bTuZyLrx9', '2023-08-12 06:19:44', '2023-08-12 06:19:44'),
(21, 1, '6XSzVxoLROvZGe24MjHLMwzEreHGtyor', '2023-08-12 06:40:59', '2023-08-12 06:40:59'),
(22, 1, '4jmkmbggXO3u0vlhW3eOGU7HZASu8E56', '2023-08-12 06:59:45', '2023-08-12 06:59:45'),
(23, 1, '8pxC5juwe81BmrYKIXygbANywVQXj5rl', '2023-08-12 08:29:11', '2023-08-12 08:29:11'),
(24, 1, '7ys1cu8dIe9V0FLZTiCbikj348z2Uf1Z', '2023-08-14 04:25:38', '2023-08-14 04:25:38'),
(25, 1, 'sbUlGFZIANLJyzsZQbgoEgSKF50JHAfd', '2023-08-14 04:31:43', '2023-08-14 04:31:43'),
(26, 1, 'dT60S94uZAsxPo63fnlYpGiCA0xbkpuO', '2023-08-14 11:55:26', '2023-08-14 11:55:26'),
(27, 1, 'UcDUf6MPOL1MJg8pe4nM7g0itY9Uxwnr', '2023-08-16 05:22:39', '2023-08-16 05:22:39'),
(29, 1, 'CE7d5VFLfZzOk5zMebanItDWpAs1OgbM', '2023-08-16 06:04:13', '2023-08-16 06:04:13'),
(30, 1, 'Z2nhbnY1PsfvVoiWtM5PuUt5wIMtbJ2I', '2023-08-16 06:04:18', '2023-08-16 06:04:18'),
(31, 1, 'QBTimtPOAGKKeU0u0vQReAmzyaqoVVBm', '2023-08-16 11:11:18', '2023-08-16 11:11:18'),
(32, 1, 'h4wKtNj3wBj2WrNZrxJ6zdyHMXafTAWv', '2023-08-16 11:12:45', '2023-08-16 11:12:45'),
(33, 1, 'FRzRhRv0uuW9eIcgdNcv4oFV6GqgFHU3', '2023-08-16 11:33:03', '2023-08-16 11:33:03'),
(34, 1, '7gyYbeUas0UxudPml5x3yRRqFEEI1w8Q', '2023-08-16 12:33:21', '2023-08-16 12:33:21'),
(35, 1, 'EfxpMRp81MBmkEzlmM8XydB5vVGSD16n', '2023-08-17 04:09:59', '2023-08-17 04:09:59'),
(36, 1, '0qoc1mzpGsFmgP1MTDxLmvonBlXsXZli', '2023-08-17 04:59:34', '2023-08-17 04:59:34'),
(38, 1, 'lP9PyaxpDwfzD2s8BceZkxZta6yfFZUZ', '2023-08-17 07:12:17', '2023-08-17 07:12:17'),
(39, 1, 'KYrPevsJ8EKoIJjLwlQf7UH7rWmTyidw', '2023-08-17 09:09:52', '2023-08-17 09:09:52'),
(40, 1, '3QBTN4XgZWovzDfPqScndJYhU3GgUBHq', '2023-08-17 10:41:35', '2023-08-17 10:41:35'),
(41, 1, 'ca7YiN7YrD3gFIsuenhtrSd780aclH1t', '2023-08-17 11:59:37', '2023-08-17 11:59:37'),
(42, 1, 'bqMrjtdd62gRyG3hXO62CWd69hK7r50W', '2023-08-17 12:12:33', '2023-08-17 12:12:33'),
(43, 1, 'yYtLwmSCc9Pu9OJB95v9Nga9ndiTaXu9', '2023-08-18 04:27:50', '2023-08-18 04:27:50'),
(44, 1, '8oSMQtCrj4AQAbQGgRJJohahWoiMOWVe', '2023-08-21 11:03:09', '2023-08-21 11:03:09'),
(45, 1, 'nXS0tEpaAWa5lwNCnVPKRHD7E2dv3wpR', '2023-08-21 11:17:14', '2023-08-21 11:17:14'),
(46, 1, 'oq9kFIDNJuZPhjEs9nb0mqaJFh3SwE1r', '2023-08-22 05:40:08', '2023-08-22 05:40:08'),
(47, 1, 'IO0wmvAiXjkEUPPjtSsjXRxRJzul9RK3', '2023-08-22 07:22:13', '2023-08-22 07:22:13'),
(49, 3, 'fOgjNdV1ojGSV1igoFF3CxKgeXTqzszU', '2023-08-22 10:56:52', '2023-08-22 10:56:52'),
(50, 1, 'il7hRxMndUFjrbuqdyuqPj8qieevx6EV', '2023-08-22 10:58:38', '2023-08-22 10:58:38'),
(52, 1, 'FnCw6Cqomw72jCKxJfrIY5MFFyiNP44V', '2023-08-24 05:53:05', '2023-08-24 05:53:05'),
(53, 1, 'dQscCeSvDMQXcIVoaxVQgiOVNnRWAgVm', '2023-08-24 06:11:16', '2023-08-24 06:11:16'),
(57, 4, 'aWjlXs5zoIQKmr8b9AZ6jgLSoVt9dmLk', '2023-08-24 09:47:20', '2023-08-24 09:47:20'),
(58, 5, 'XY0FIwMT8IorOKaM96E9RTEyPAsX9KpT', '2023-08-24 10:06:35', '2023-08-24 10:06:35'),
(59, 1, '86f1SL3Td80or2Mr5cB5OjbkUmdEAFDG', '2023-08-24 12:30:23', '2023-08-24 12:30:23'),
(60, 1, 'MpqDAwPT5phNEQ7tzPXKXRF1fgycrFhY', '2023-08-24 12:44:07', '2023-08-24 12:44:07'),
(61, 1, '4SuPVOvCawgpeDckr8ZtP4Ba1TDCSWwK', '2023-08-24 12:48:09', '2023-08-24 12:48:09'),
(62, 1, 'HEILScFJWENUAR6oOCqHqQEQ60t7NLGk', '2023-08-24 13:10:37', '2023-08-24 13:10:37'),
(63, 6, 'UOXAQPm6sEHYkQOUWeZuU9DaTnHUc6QC', '2023-08-24 13:48:33', '2023-08-24 13:48:33'),
(64, 1, 'mYDHtOuyhVJL6JJJrywOQS6qHx5JcbbH', '2023-08-25 06:32:59', '2023-08-25 06:32:59'),
(65, 1, 'XltdVCAosMXwJkk3ppIB1GnhfjN3k4Uj', '2023-08-25 06:35:19', '2023-08-25 06:35:19'),
(66, 1, 'hzKJK4BhOIqtVluiXYutw72QRR2uYRNt', '2023-08-25 07:11:33', '2023-08-25 07:11:33'),
(67, 1, 'RzQzzZcKFNhkNsVg0iox1MS8UyZn1St5', '2023-08-25 07:54:53', '2023-08-25 07:54:53'),
(68, 4, '8bDsLTkOhcGWRW0kTHrJuMdm9xvsNwaD', '2023-08-25 07:58:11', '2023-08-25 07:58:11'),
(69, 4, 'TxELXQPynSSSRHG3HxeXnvvHQDpNIwfV', '2023-08-25 12:49:09', '2023-08-25 12:49:09'),
(70, 1, 'JDk7rvdpfuDSZl6kqjHT6kRyTdZ9iSkr', '2023-08-25 12:51:25', '2023-08-25 12:51:25'),
(71, 1, 'LmXUz2qJikotjSzfMcieL2oMxUlRDfq0', '2023-08-25 13:25:39', '2023-08-25 13:25:39'),
(72, 1, 'r3EkXiEggko0yOld78PqsaGV5Hg9FoTB', '2023-08-25 13:44:44', '2023-08-25 13:44:44'),
(73, 1, 'HDVyLjEDLs2zkhKwXnBiV1HsNRLtEGDz', '2023-08-26 06:35:34', '2023-08-26 06:35:34'),
(74, 1, 'pdBDrDxgNQMRrq2Hg9bKjXjtx3SbdJqs', '2023-08-26 06:44:04', '2023-08-26 06:44:04'),
(75, 1, 'Y7GgPR6EbGf5NyNO94sKBRj4DqSpHUAv', '2023-08-26 07:37:36', '2023-08-26 07:37:36'),
(76, 1, 'pOM4axHNnxPcUxYB3kWlzkUcLlaDYvWq', '2023-08-28 06:43:09', '2023-08-28 06:43:09'),
(77, 1, 'Fm1n60OGXYsQODbuKiQI3yDxYcsAnhML', '2023-08-28 07:48:58', '2023-08-28 07:48:58'),
(78, 1, 'ukHjuIaPTdI1adUuklFtEZuYNSAILbFO', '2023-08-28 07:58:38', '2023-08-28 07:58:38'),
(79, 1, 'JeWdg1mYe4UAzdDaxFNBO2LKTa1yw89l', '2023-08-28 09:18:25', '2023-08-28 09:18:25'),
(80, 1, '9q2FbUnzASKaf3kFZhA8KhRBlbmWCkjb', '2023-08-29 12:07:03', '2023-08-29 12:07:03'),
(81, 1, 'AEJeKryXdYnemSX2LrwGIlAL0r93CZad', '2023-08-29 13:26:01', '2023-08-29 13:26:01'),
(82, 1, '7TZscpfLi7btbsDjKKQkanXkIsXfiOPn', '2023-08-29 14:13:58', '2023-08-29 14:13:58'),
(83, 1, 'cd6xAmdprC9qbzeH0bjzew46Z4J3pqUA', '2023-08-30 06:04:17', '2023-08-30 06:04:17'),
(84, 1, '9oJsmJ0DCzRXqpIwZW4iglvBzGXGeZAX', '2023-08-31 06:14:09', '2023-08-31 06:14:09'),
(85, 1, 'qaKdobxD1J2uWuXyxeyBfcSBIxMZa1fl', '2023-09-01 06:17:14', '2023-09-01 06:17:14'),
(86, 1, 'AHISEie2AfH6L5UqE6LIdPc9keXl3CI4', '2023-09-01 06:28:09', '2023-09-01 06:28:09'),
(87, 1, 'P6TdkE0L914JKuypJPUPPxntVVKJF0m5', '2023-09-01 10:00:55', '2023-09-01 10:00:55'),
(88, 1, 'Xy6B3mVEroMcPvqJrDK709mhiADV122A', '2023-09-02 05:42:00', '2023-09-02 05:42:00'),
(89, 1, 'IndvLZxlJqK1vuo3WG15zx3kd6VXwxt2', '2023-09-02 10:12:44', '2023-09-02 10:12:44'),
(90, 1, 'GhB6y1HMZKs54C8T8gOy7yG7VpVphdPh', '2023-09-04 07:48:48', '2023-09-04 07:48:48'),
(91, 1, 'dQ6V1DUDMvWotLJXDxITSJzdjyuf7C3m', '2023-09-05 06:56:12', '2023-09-05 06:56:12'),
(92, 1, 'oSmgOy2E6Mu2LGPBAKzlAaPcCyUREtFH', '2023-09-05 09:29:09', '2023-09-05 09:29:09'),
(93, 1, 'tdf30zovscajxL1GpxjyGCJY6fwWyker', '2023-09-06 06:59:54', '2023-09-06 06:59:54'),
(95, 1, '2SlzQ3QqRODePlYTfpxIQDkXqRP9Ud5L', '2023-09-06 11:42:03', '2023-09-06 11:42:03'),
(96, 6, 'WWtsquV3xdElH8nq4xXcTKGCCKZXZJfA', '2023-09-06 11:44:20', '2023-09-06 11:44:20'),
(97, 1, 'Ko2uMenx8p4jpA8VTzss8H5V9DaFl4Vk', '2023-09-06 14:51:08', '2023-09-06 14:51:08'),
(98, 6, 'mkCTHTddK18tHOL543T3VmUEm8Czoj6E', '2023-09-06 15:14:49', '2023-09-06 15:14:49'),
(99, 1, 'hp50R9jqaAapHVXuUvgrFFQTDeUHZRkj', '2023-09-07 06:11:54', '2023-09-07 06:11:54'),
(101, 1, 'PIMlaYgPaOleR2wis7DiZ5yUTRKO0YH7', '2023-09-08 08:25:41', '2023-09-08 08:25:41'),
(102, 1, 'HFQnwf7ZcdXZMs59dpaAp3o4RoFqunj9', '2023-09-08 08:35:28', '2023-09-08 08:35:28'),
(103, 1, 'UBMZk3wvvAkCz5amSrjw5ezuoeaKqmG5', '2023-09-08 11:14:20', '2023-09-08 11:14:20'),
(104, 1, 'UVitXsL6sdKLw2PXMaP6QgUqpYeyrNX6', '2023-09-08 13:25:28', '2023-09-08 13:25:28'),
(105, 1, 'Xj0yHbl90CL2Jnj2su4TjyGrmYNerIzb', '2023-09-09 07:04:12', '2023-09-09 07:04:12'),
(106, 1, 'Srit49vcyXGB9qfOcABnZ6LYnsaJG0Wp', '2023-09-11 06:49:38', '2023-09-11 06:49:38'),
(107, 1, 'bjRdTlD1P70kPL47B5yJZj6NfUejsyvB', '2023-09-12 06:24:22', '2023-09-12 06:24:22'),
(108, 1, 'EEQjCaYZlStw8zJwe1Hgm3SbbcKtQxEJ', '2023-09-12 07:28:09', '2023-09-12 07:28:09'),
(109, 1, '5ybczXllz1tr9P0PlpmOxLDwhIG7USon', '2023-09-12 10:53:04', '2023-09-12 10:53:04'),
(110, 1, 'eGvhurEEwMzbQFp0m5YcU4C1UjVo6m7b', '2023-09-13 06:18:49', '2023-09-13 06:18:49'),
(111, 1, 'QvOB5MafXloZIehjsqEKkQh8JWGHMfns', '2023-09-13 13:02:26', '2023-09-13 13:02:26'),
(112, 1, '4UYSjJfKXWP72nKfTA9LFUNPvDzzncgL', '2023-09-13 14:25:06', '2023-09-13 14:25:06'),
(113, 1, 'jdb2MW66fSTZGUBeIAJXP8FU2sXKtkS1', '2023-09-13 14:35:12', '2023-09-13 14:35:12'),
(114, 1, 'b4Wddgez066CrMc5F8dqno0BvnVu3ZYV', '2023-09-14 06:24:00', '2023-09-14 06:24:00'),
(116, 1, '5qi0kuiCDYSpXCjKVif2dtLTbCHHhxPB', '2023-09-14 12:33:27', '2023-09-14 12:33:27'),
(117, 1, 'cuLwnNhc67VENfegzb7DTkTT7lPC921d', '2023-09-14 14:49:07', '2023-09-14 14:49:07'),
(118, 1, 'aC7R6cHtSX5L6pMVHN4eQTW2HvtEGtYt', '2023-09-15 06:41:33', '2023-09-15 06:41:33'),
(119, 1, '5UB9JwrzxuFpBTXGhhmDbbIIS0uDYtq3', '2023-09-15 11:18:10', '2023-09-15 11:18:10'),
(120, 1, 'KbBMzhR3KAswbRT01kDAfGzJtjdqFAkN', '2023-09-16 06:38:30', '2023-09-16 06:38:30'),
(122, 1, 'N8yTn1BJDWaw8xqerXhwhwTGEyziy4ee', '2023-09-19 06:51:55', '2023-09-19 06:51:55'),
(123, 4, 'gCSuWYJy63rltEfS7jqOgNVWqDoJEw42', '2023-09-19 07:03:21', '2023-09-19 07:03:21'),
(124, 1, 'EDVtkjkGvj8kLhcXUSAuiSlmDgZnsiy1', '2023-09-21 06:26:15', '2023-09-21 06:26:15'),
(125, 1, 'QkYEu8fkkVPzUcG4QJWpW7m8uzdoENtb', '2023-09-21 09:46:38', '2023-09-21 09:46:38'),
(126, 1, 'Y6H3Lajc7gkLWSHnPBlOcChkC1CJzvoQ', '2023-09-21 14:58:34', '2023-09-21 14:58:34'),
(127, 1, '6ukoTlvpOeU3tAthHLlhWWK32d0h31nd', '2023-09-22 07:00:53', '2023-09-22 07:00:53'),
(128, 1, 'uX55zgKlVtByK3crzkxaVjiAHqGRcNbm', '2023-09-22 15:04:05', '2023-09-22 15:04:05'),
(129, 6, 'PSNisgoj2tdxlfKOwcM6BagcSgdkRxds', '2023-09-23 10:25:36', '2023-09-23 10:25:36'),
(130, 1, 'rFEqafkIPib2AAhMKJs66RfREibu2aQ2', '2023-09-23 10:25:51', '2023-09-23 10:25:51'),
(131, 1, 'KgLIwLC0ebdrN0bMMgGv43zrHEwpNcmv', '2023-09-23 10:27:54', '2023-09-23 10:27:54'),
(133, 1, '8ncSs4rIYbSvm0ovKTybz0JleGZ6At1W', '2023-09-25 11:08:26', '2023-09-25 11:08:26'),
(134, 4, 'F2piPzBbFE1nHJ1RF3f0jwHLmKBVgkbJ', '2023-09-27 06:30:54', '2023-09-27 06:30:54'),
(135, 1, 'mDFblK3Tw073KZrnjW0XdaP7nrhyisAe', '2023-09-27 10:25:19', '2023-09-27 10:25:19'),
(136, 1, 'iMrwpxykHsHaFZQhTk2S7TCfveTWMGQy', '2023-09-27 11:32:56', '2023-09-27 11:32:56'),
(138, 5, 'ztTQeIFLdMndbFJqpojsleZC3RdND0M8', '2023-09-28 06:37:15', '2023-09-28 06:37:15'),
(140, 5, 'Z5Hnh1YBaOEPn8GjkqJXP0BkoD4E98Lw', '2023-09-28 09:16:44', '2023-09-28 09:16:44'),
(141, 4, 'KBoPIU5Lm4of58a0osoe3JUP7tOBEB9c', '2023-09-28 11:21:36', '2023-09-28 11:21:36'),
(142, 5, 'LvGqcv1442f848wHMmIxe51zcKzrP7RF', '2023-09-28 12:54:01', '2023-09-28 12:54:01'),
(143, 5, 'dMTcAmy8I2yZgRyJsv6f80td6Uo8qTGb', '2023-09-28 15:05:03', '2023-09-28 15:05:03'),
(144, 4, 'dev6FuHMj27Ag0Py4QwwTVqPnf7BXMma', '2023-09-28 15:05:51', '2023-09-28 15:05:51'),
(146, 1, 'axEUAYk5erlCV0cxEV8NN3CP1stlZUh7', '2023-09-29 11:54:53', '2023-09-29 11:54:53'),
(147, 5, 'y6ra4IVccryaCTdPtnCf9SOWZEuvgqMd', '2023-09-29 12:37:18', '2023-09-29 12:37:18'),
(149, 1, 'KAVVAwzzIrdC0GtPk71xHgR2hRlg8oHk', '2023-09-30 07:32:55', '2023-09-30 07:32:55'),
(150, 1, 'Vcxw0e8GDaViQ0fUkK9ILWx4fScrsQjI', '2023-10-03 06:21:54', '2023-10-03 06:21:54'),
(152, 1, 'eekrDJtFqSWaHpjIkCxrvkQpfj5BYQZo', '2023-10-03 08:03:09', '2023-10-03 08:03:09'),
(154, 5, '77pI9DJNatkSNgGoZiyPvBelMRLomBNl', '2023-10-03 10:54:59', '2023-10-03 10:54:59'),
(155, 5, 'TTPJgLmfV6w2x5iC886AfPi5BKZZd2ZE', '2023-10-04 06:05:27', '2023-10-04 06:05:27'),
(157, 4, 'zMyTHQ4eVo2gdmPfOdfMAURch3BiNmyV', '2023-10-04 15:14:29', '2023-10-04 15:14:29'),
(158, 4, '5spXyExRB7xm3k3Qy6POzxTJdQTG8Ql0', '2023-10-05 07:08:25', '2023-10-05 07:08:25'),
(159, 1, 'VURYUe9QprAmqG6tumN8JvrwI4oh95Hl', '2023-10-05 12:23:28', '2023-10-05 12:23:28'),
(160, 5, 'ya0ZP9SkxCJ2IDE3Tq5sAq09WVLIt5eN', '2023-10-06 07:04:30', '2023-10-06 07:04:30'),
(161, 1, 'hHVC2VEW6tfycGnAWR2Xs0NAdQOaahM4', '2023-10-06 07:55:49', '2023-10-06 07:55:49'),
(162, 5, '5lxO8gQcSWq2P1MTngy6vF84gmI5Xcc6', '2023-10-06 08:23:05', '2023-10-06 08:23:05'),
(163, 4, 'x1dRziCkkySw7FZHPLuqoh7XRWFKxfJa', '2023-10-06 14:00:21', '2023-10-06 14:00:21'),
(164, 4, 'ErqiiEv9pYjCTrNIhNTkcWw0f5CtZ2KN', '2023-10-07 07:39:01', '2023-10-07 07:39:01'),
(165, 4, 'BeXBVcc7Y5PLUpim0XAjU29IJuRElx5l', '2023-10-07 08:12:05', '2023-10-07 08:12:05'),
(166, 4, '5927f6ipsKcyyp8sVCbHqBX6hthuHfIg', '2023-10-07 09:07:53', '2023-10-07 09:07:53'),
(167, 4, '3e44d87E3eyqMpsThv1LXGzAm1Uvdlz7', '2023-10-09 06:32:31', '2023-10-09 06:32:31'),
(168, 4, 'hy7OQ7aDHwWrUKEkMJEVFo7FEd4THnl6', '2023-10-09 11:49:48', '2023-10-09 11:49:48'),
(169, 4, 'p3U4xMUniiHN2eas7Fwi2k9xyEoEX2pb', '2023-10-10 10:57:52', '2023-10-10 10:57:52'),
(170, 4, 'g43MUlAmrE5o2He2alBQvWky0UZmHTCp', '2023-10-10 14:07:27', '2023-10-10 14:07:27'),
(171, 5, '48R7mlnHf2y7wHn1niXPYYhH4eWRCtwR', '2023-10-11 06:24:16', '2023-10-11 06:24:16'),
(172, 4, 'uclQoF7gTS3uMXgqAHfYHDwXzSOt2nkB', '2023-10-12 06:26:25', '2023-10-12 06:26:25'),
(173, 4, '7g2QyhydIuwk0MvJsAyrRQlYoYM7kCZX', '2023-10-12 14:00:59', '2023-10-12 14:00:59'),
(174, 4, 'U0LaRtFYZLscl79Vi6G6UWNLW4KPG89b', '2023-10-13 07:47:13', '2023-10-13 07:47:13'),
(175, 4, '6087igvcRRZD8cXSZeDvSqNGZMysDmSF', '2023-10-13 08:54:33', '2023-10-13 08:54:33'),
(176, 4, 'KSAArN5HMQedKRiDmLtJfb3aO9HY46kK', '2023-10-16 06:20:08', '2023-10-16 06:20:08'),
(180, 7, 'TyXOQqfZBm40roAUaCRzLorlairB1oA7', '2023-10-17 08:04:17', '2023-10-17 08:04:17'),
(181, 4, 'JyCbQKsplQUYYxgEFHW4f3G6JKTykXHJ', '2023-10-17 08:05:01', '2023-10-17 08:05:01'),
(182, 6, 'mwt7doRPgTr2YRF1NF7O3AcjkTjlLMdt', '2023-10-17 14:01:35', '2023-10-17 14:01:35'),
(183, 1, 'y4FRXLyLJf3Li7oQ1KJvvUf0l6vfr9x7', '2023-10-17 14:14:11', '2023-10-17 14:14:11'),
(184, 4, 'UFgjbfSQN8ga1a5R75rlVKAWDOWvvTaz', '2023-10-17 14:30:00', '2023-10-17 14:30:00'),
(185, 4, 'QrqxwvUCw2JOHc5r8zUb8fKtW73xrxlt', '2023-10-18 12:09:37', '2023-10-18 12:09:37'),
(186, 4, '5miOriyGdZsgigFMWaCjfZ5hEMWZwLuV', '2023-10-19 13:55:24', '2023-10-19 13:55:24'),
(187, 4, '5xTQRslvzrxKXtbF3yStJ3xKyCltTXqf', '2023-10-20 06:37:33', '2023-10-20 06:37:33'),
(189, 4, 'nb6UWOUdb3rPyXJqSwIRKOhnvsoOIvRh', '2023-10-20 13:23:08', '2023-10-20 13:23:08'),
(190, 4, 'HK1lV4qnZDmHietiFylYazoc5982ebLk', '2023-10-20 14:32:08', '2023-10-20 14:32:08'),
(192, 4, 'RFel8wUluvEzPyVJ51gSsfcZo2bbUYWH', '2023-10-21 09:45:25', '2023-10-21 09:45:25'),
(193, 4, 'E5F6BA4XQ0gyjPzsIq1LdCs487D1sPpJ', '2023-10-21 10:59:45', '2023-10-21 10:59:45'),
(194, 4, '7H71zycA07EjiiAXKLHn8GFVfg20cU54', '2023-10-25 07:23:35', '2023-10-25 07:23:35'),
(195, 1, 'A7IjsmpNdhQisOlEizLNkDpheWHqQ727', '2023-10-25 10:52:09', '2023-10-25 10:52:09'),
(196, 1, '2pTK16wXeFK0DrT5AAoOjC1hkYCTD3Ea', '2023-10-25 11:00:59', '2023-10-25 11:00:59'),
(197, 4, 'mWB5xsu1FktMg7xE71OmVUEMV3ZAeTMp', '2023-10-26 06:22:29', '2023-10-26 06:22:29'),
(198, 7, '5OKdozMtbLOOK2IK1zNVUjiVdgxAfTI2', '2023-10-26 06:29:32', '2023-10-26 06:29:32'),
(199, 1, '4qV5vQ7mgGpdTn9W0NhnE3Q1JfoHzFEK', '2023-10-26 06:45:04', '2023-10-26 06:45:04'),
(200, 4, '36MYAv9ACnZPwB8y6GWGyMFbfcam9DWp', '2023-10-26 12:50:23', '2023-10-26 12:50:23'),
(201, 1, 'iTpPe6yRSwBdQT9RVjiIy5AgZCWYsmu4', '2023-10-26 15:43:07', '2023-10-26 15:43:07'),
(202, 4, 'ylzWgmPXrlBjIB3R82CsOwSHXMjyFjEU', '2023-10-28 08:55:04', '2023-10-28 08:55:04'),
(203, 4, '2RxjvDTzkN6TQnKfhrfSgnwqIfgFnuAV', '2023-10-28 10:25:41', '2023-10-28 10:25:41'),
(204, 4, 'ejLXPUIGqN7b4jE3ZlCLpKIw9mfnd0LC', '2023-10-28 10:47:38', '2023-10-28 10:47:38'),
(205, 8, 'ck7BYETiruRbBg95qyqMe15FKTbNTR0P', '2023-10-28 11:11:01', '2023-10-28 11:11:01'),
(206, 4, 'UMqCoePMngT0WVFRNBMcSaLqZLh6NRoS', '2023-10-30 07:03:59', '2023-10-30 07:03:59'),
(211, 4, 'OkRV4sm4anC5reaHNeQRx1HhaqGgt5cf', '2023-10-30 15:16:06', '2023-10-30 15:16:06'),
(212, 1, 'W6wgV1mZ1YouwYqhTgoSihHYY4vsxUAP', '2023-10-31 06:45:27', '2023-10-31 06:45:27'),
(213, 1, 'p9xlhrULdhbW50pRVBoqd6PrwrB3q6Mt', '2023-10-31 06:46:06', '2023-10-31 06:46:06'),
(214, 4, 'qK9tNdXZ9msngLm9pCDdfnSh8wiF26ip', '2023-10-31 06:55:03', '2023-10-31 06:55:03'),
(215, 1, 'jaYIlSRqVtKaBxNCHGL67JblqjanEmqh', '2023-10-31 08:00:48', '2023-10-31 08:00:48'),
(216, 4, 'DI7CzU2ECfyDM3aBJY7aRWwdXXRcPn89', '2023-10-31 09:29:51', '2023-10-31 09:29:51'),
(217, 1, 'hkqlazPlO3wTNhbEAP9KDeRSLNriBgq4', '2023-10-31 09:56:54', '2023-10-31 09:56:54'),
(218, 1, 'sYfUz9rkljRBVyCAMYXmtSKvxinHa41n', '2023-10-31 12:11:22', '2023-10-31 12:11:22'),
(219, 1, 'tlD1FVRa3bnDJxuibJPejsOryWOE1vX9', '2023-10-31 13:13:39', '2023-10-31 13:13:39'),
(220, 4, 'gudyT3amFdYam8GEBKlOdyaiZWMvPyvk', '2023-11-01 06:17:24', '2023-11-01 06:17:24'),
(222, 1, 'nTQvuoDMhsAyE8fVtXEPY5mVLT0wxMac', '2023-11-01 13:55:37', '2023-11-01 13:55:37'),
(223, 5, 'XtH1TZY5jFXuPy2nJW6zMFDnWA6uWGcs', '2023-11-01 13:59:40', '2023-11-01 13:59:40'),
(224, 4, 'GbokfolVzyV3Ne7MwxZhBKIWX7oXMO9Y', '2023-11-01 14:48:30', '2023-11-01 14:48:30'),
(225, 1, '4wGotjA2CRwrvlbKQb0OxWgIsfwrW2Ma', '2023-11-01 15:32:53', '2023-11-01 15:32:53'),
(226, 1, 'jzbbTn5nMIdV58VAdoBROQQTOSfnZMZ9', '2023-11-02 06:20:21', '2023-11-02 06:20:21'),
(227, 1, 'ekee2If1egSPyfvK64RBjq02FH3OJHyN', '2023-11-02 06:32:34', '2023-11-02 06:32:34'),
(228, 1, 'zQdiEzcvV2Sa45WHutqW2ayZNZmgU34K', '2023-11-02 06:58:18', '2023-11-02 06:58:18'),
(229, 1, 'erwvfIN5cedwJfuuboe2pMKedzU5fzxp', '2023-11-02 08:51:48', '2023-11-02 08:51:48'),
(230, 4, 'jkRhBjvATwQ9HsG7LOqXafcQBqyFZHRf', '2023-11-02 11:06:15', '2023-11-02 11:06:15'),
(231, 1, '0v1ILJFBxqMdtPPlLLS7Sxwoul3yZ4x8', '2023-11-02 12:35:40', '2023-11-02 12:35:40'),
(232, 1, 'WbbYS6X61nBoFxwqa7OqJCxgZ15y5F8z', '2023-11-03 08:47:15', '2023-11-03 08:47:15'),
(233, 1, '9o4HWKnM0GSawWVC7qFnDH9wZFgqJuvR', '2023-11-03 11:49:57', '2023-11-03 11:49:57'),
(236, 1, 'fua1vFCNzc58TPPrZPrQyb5vmlNk4b7A', '2023-11-09 12:22:57', '2023-11-09 12:22:57'),
(237, 1, 'q6aaaiPtCDzIcOA2D076PhoVotUPc54B', '2023-11-09 13:49:05', '2023-11-09 13:49:05'),
(238, 4, 'R3zjpnZJCLsAAKNTseptqkvSnyKun2gm', '2023-11-10 06:32:53', '2023-11-10 06:32:53'),
(239, 5, 'M0w7sd5eX9AJDyZDrvjk2rRWlrHBsOKb', '2023-11-10 06:33:45', '2023-11-10 06:33:45'),
(240, 4, 'qhOqa6Lpg55aYwPeEi4AAOL0pZsZ2Eqs', '2023-11-10 12:15:36', '2023-11-10 12:15:36'),
(241, 4, 'tCV1v0gYmrAa8W0gXpmM4SA3PoQp3LuY', '2023-11-11 06:58:01', '2023-11-11 06:58:01'),
(242, 4, 'cM3CEvhRScDvQiHsfZR7V5Wgj2q2YMAl', '2023-11-11 07:13:07', '2023-11-11 07:13:07'),
(245, 6, 'WL1SxVNxUcaXyYEtsKhyQBLbr8vXyWrm', '2023-11-17 11:52:34', '2023-11-17 11:52:34'),
(246, 23, 'eCm6zZqTtuh4MuREdx1oRLiDqYYQn5EQ', '2023-11-17 11:54:37', '2023-11-17 11:54:37');

-- --------------------------------------------------------

--
-- Table structure for table `pickupstores`
--

CREATE TABLE `pickupstores` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(191) NOT NULL,
  `tagline` varchar(191) DEFAULT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `address_1` varchar(191) NOT NULL,
  `address_2` varchar(191) NOT NULL,
  `city` varchar(191) NOT NULL,
  `state` varchar(191) NOT NULL,
  `country` varchar(191) NOT NULL,
  `zip` varchar(191) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pickupstores`
--

INSERT INTO `pickupstores` (`id`, `first_name`, `tagline`, `email`, `phone`, `address_1`, `address_2`, `city`, `state`, `country`, `zip`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'APS Main', 'Grab Your Orders Here!', 'Aishah@gmail.com', '6090302050', 'Kuala Lumpur', 'Kuala Lumpur', 'Kuala Lumpur', 'KUL', 'MY', '59000', 1, '2023-10-26 06:45:48', NULL),
(2, 'APS Selangor', 'Grab Your Orders Here!', 'Ahmad@gmail.com', '6090302051', 'Selangorr', 'Selangor', 'Selangor', 'SGR', 'MY', '59001', 1, '2023-10-26 06:45:48', NULL),
(3, 'APS JHR', 'Grab Your Orders Here!', 'Zara@gmail.com', '6090302055', 'Johor Bahru', 'Johor Bahru', 'Johor Bahru', 'JHR', 'MY', '59002', 1, '2023-10-26 06:45:48', NULL),
(4, 'APS Penang', 'Grab Your Orders Here!', 'Rayyan@gmail.com', '6090302061', 'Penang', 'Penang', 'Penang', 'PNG', 'MY', '59006', 1, '2023-10-26 06:45:48', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `brand_id` int(10) UNSIGNED DEFAULT NULL,
  `tax_class_id` int(10) UNSIGNED DEFAULT NULL,
  `slug` varchar(191) NOT NULL,
  `price` decimal(18,4) UNSIGNED NOT NULL,
  `special_price` decimal(18,4) UNSIGNED DEFAULT NULL,
  `special_price_type` varchar(191) DEFAULT NULL,
  `special_price_start` date DEFAULT NULL,
  `special_price_end` date DEFAULT NULL,
  `selling_price` decimal(18,4) UNSIGNED DEFAULT NULL,
  `sku` varchar(191) DEFAULT NULL,
  `manage_stock` tinyint(1) NOT NULL DEFAULT 0,
  `qty` int(11) DEFAULT NULL,
  `in_stock` tinyint(1) NOT NULL DEFAULT 1,
  `viewed` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL,
  `new_from` datetime DEFAULT NULL,
  `new_to` datetime DEFAULT NULL,
  `prepare_days` int(10) UNSIGNED DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_virtual` tinyint(1) NOT NULL DEFAULT 0,
  `pre_short_description` text DEFAULT NULL,
  `is_preorder_status` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `brand_id`, `tax_class_id`, `slug`, `price`, `special_price`, `special_price_type`, `special_price_start`, `special_price_end`, `selling_price`, `sku`, `manage_stock`, `qty`, `in_stock`, `viewed`, `is_active`, `new_from`, `new_to`, `prepare_days`, `deleted_at`, `created_at`, `updated_at`, `is_virtual`, `pre_short_description`, `is_preorder_status`) VALUES
(1, NULL, NULL, 'wedding-garland', '200.0000', '150.0000', 'fixed', '2023-08-09', '2023-08-17', '200.0000', '25', 0, NULL, 0, 16, 1, '2023-08-09 00:00:00', '2023-08-19 00:00:00', 0, NULL, '2023-08-09 12:42:13', '2023-08-25 13:19:06', 0, NULL, 0),
(2, 1, NULL, 'lotus', '200.0000', '199.0000', 'fixed', NULL, NULL, '199.0000', NULL, 1, 10, 1, 26, 1, NULL, NULL, 5, NULL, '2023-08-09 12:57:27', '2023-11-03 10:14:11', 0, NULL, 0),
(3, 1, NULL, 'wedding-garlands-with-white-and-green-color-mixing', '50.0000', '20.0000', 'fixed', '2023-08-11', '2023-08-26', '20.0000', '25', 0, NULL, 1, 29, 1, '2023-08-19 00:00:00', '2023-08-11 00:00:00', 0, NULL, '2023-08-11 09:50:50', '2023-10-26 08:33:16', 0, NULL, 0),
(4, 1, 1, 'rose', '100.0000', '2.0000', 'percent', NULL, NULL, '98.0000', '1500014', 1, 1498, 1, 27, 1, NULL, NULL, 0, NULL, '2023-08-12 04:23:27', '2023-11-17 10:34:50', 0, NULL, 0),
(5, 1, NULL, 'rose-petal-garlands', '25.0000', '20.0000', 'fixed', '2023-08-07', '2023-08-31', '20.0000', '25', 0, NULL, 1, 7, 1, '2023-08-07 00:00:00', '2023-08-31 00:00:00', 0, NULL, '2023-08-14 09:58:24', '2023-11-03 12:08:25', 0, NULL, 0),
(6, 1, 1, 'jasmine', '1000.0000', '999.0000', 'fixed', '2023-08-03', '2023-08-24', '999.0000', '25', 0, NULL, 1, 10, 1, NULL, NULL, 0, NULL, '2023-08-14 10:02:57', '2023-09-23 10:26:06', 0, NULL, 0),
(7, 1, NULL, 'pink-rose-bouquet', '299.0000', '158.0000', 'fixed', NULL, NULL, '158.0000', '56dfg', 0, NULL, 1, 9, 1, NULL, NULL, 0, NULL, '2023-08-14 10:23:31', '2023-08-25 06:53:44', 0, NULL, 0),
(8, 1, NULL, 'red-rose-bouquet', '259.0000', '145.0000', 'fixed', NULL, NULL, '145.0000', NULL, 0, NULL, 1, 27, 1, NULL, NULL, 0, NULL, '2023-08-14 10:27:46', '2023-11-03 11:51:05', 0, NULL, 0),
(9, 1, NULL, 'manoranjitham', '150.0000', NULL, 'fixed', NULL, NULL, '150.0000', NULL, 0, NULL, 1, 4, 1, NULL, NULL, 0, NULL, '2023-08-14 10:33:11', '2023-08-25 14:42:03', 0, NULL, 0),
(10, 1, NULL, 'loose-flower-red', '20.0000', '19.0000', 'fixed', NULL, NULL, '19.0000', NULL, 0, NULL, 1, 2, 1, NULL, NULL, 0, NULL, '2023-08-14 10:38:11', '2023-08-14 12:23:09', 0, NULL, 0),
(11, 2, NULL, 'hand-bouquet', '19.0000', '18.0000', 'fixed', NULL, NULL, '18.0000', NULL, 0, NULL, 1, 2, 1, NULL, NULL, 0, NULL, '2023-08-14 10:42:56', '2023-08-25 11:51:19', 0, NULL, 0),
(12, 1, 1, 'orchids', '50.0000', '49.0000', 'fixed', '2023-08-02', '2023-08-23', '50.0000', NULL, 0, NULL, 1, 5, 1, NULL, NULL, 0, NULL, '2023-08-14 10:45:32', '2023-08-25 11:57:26', 0, NULL, 0),
(13, 1, 1, 'vadamalli', '150.0000', '2.0000', 'percent', NULL, NULL, '147.0000', NULL, 0, NULL, 1, 1, 1, NULL, NULL, 0, NULL, '2023-08-14 10:51:36', '2023-08-14 12:19:42', 0, NULL, 0),
(14, 1, 1, 'lotus-yeVHn5rz', '250.0000', NULL, 'fixed', NULL, NULL, '250.0000', NULL, 1, 1, 1, 12, 1, NULL, NULL, 0, NULL, '2023-08-14 10:53:42', '2023-11-03 10:12:19', 0, NULL, 0),
(15, 1, NULL, 'vettiver-malai-for-god', '25.0000', '24.0000', 'fixed', NULL, NULL, '24.0000', NULL, 0, NULL, 1, 7, 1, NULL, NULL, 0, NULL, '2023-08-14 11:05:18', '2023-11-03 11:59:16', 0, NULL, 0),
(16, NULL, NULL, 'combo-losse-flower', '14.0000', NULL, 'fixed', NULL, NULL, '14.0000', NULL, 0, NULL, 1, 5, 1, NULL, NULL, 0, NULL, '2023-08-14 11:27:22', '2023-11-03 12:07:05', 0, NULL, 0),
(17, 1, NULL, 'jasmine-saram', '5.0000', '2.0000', 'fixed', NULL, NULL, '2.0000', NULL, 0, NULL, 1, 7, 1, NULL, NULL, 0, NULL, '2023-08-14 12:06:21', '2023-08-28 12:53:07', 0, NULL, 0),
(18, 1, NULL, 'mullai-saram', '10.0000', '9.0000', 'fixed', NULL, NULL, '9.0000', 'MS-001', 1, 0, 0, 35, 1, NULL, NULL, 2, NULL, '2023-08-14 12:25:17', '2023-08-26 06:55:06', 1, NULL, 1),
(19, NULL, NULL, 'contact', '30.0000', NULL, 'fixed', NULL, NULL, '30.0000', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, '2023-08-25 09:13:19', '2023-08-25 09:12:24', '2023-08-25 09:13:19', 0, NULL, 0),
(20, NULL, NULL, 'testing-product', '10.0000', NULL, 'fixed', NULL, NULL, '10.0000', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, '2023-08-25 10:07:07', '2023-08-25 10:03:37', '2023-08-25 10:07:07', 0, NULL, 0),
(21, NULL, NULL, 'contact-JpP0Hhqy', '20.0000', NULL, 'fixed', NULL, NULL, '20.0000', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, '2023-08-25 10:22:37', '2023-08-25 10:20:53', '2023-08-25 10:22:37', 0, NULL, 0),
(22, 1, 1, 'mulai-saram-2', '100.0000', NULL, 'fixed', NULL, NULL, '100.0000', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, '2023-08-25 12:00:53', '2023-08-25 11:59:32', '2023-08-25 12:00:53', 0, NULL, 0),
(23, NULL, NULL, 'testing-product-1', '10.0000', NULL, 'fixed', NULL, NULL, '10.0000', NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, '2023-08-26 09:09:47', '2023-08-26 08:00:55', '2023-08-26 09:09:47', 0, NULL, 0),
(24, 1, NULL, 'arali-saram-flowers', '10.0000', '9.0000', 'fixed', NULL, NULL, '9.0000', 'PWS001', 0, 13900, 1, 0, 1, NULL, NULL, 1, NULL, '2023-08-28 09:34:19', '2023-08-28 09:34:19', 0, NULL, 1),
(25, 1, NULL, 'tetsya', '250.0000', NULL, 'fixed', NULL, NULL, '250.0000', '1000021', 0, NULL, 1, 0, 1, NULL, NULL, NULL, '2023-10-06 14:05:28', '2023-10-06 14:04:57', '2023-10-06 14:05:28', 0, NULL, 0),
(26, 1, NULL, 'malli-saram', '9.0000', '8.0000', 'percent', NULL, NULL, '8.2800', 'JASWHI001', 1, 2, 1, 9, 1, NULL, NULL, NULL, NULL, '2023-10-26 07:10:58', '2023-11-17 12:19:50', 0, NULL, 0),
(27, 1, NULL, 'violet-bouquet', '100.0000', '99.0000', 'fixed', '2023-11-17', '2024-02-01', '99.0000', NULL, 0, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, '2023-11-17 10:52:57', '2023-11-17 12:20:06', 0, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `product_attributes`
--

CREATE TABLE `product_attributes` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `attribute_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_attributes`
--

INSERT INTO `product_attributes` (`id`, `product_id`, `attribute_id`) VALUES
(40, 13, 5),
(42, 9, 5),
(43, 6, 5),
(45, 3, 1),
(47, 4, 5),
(49, 12, 5),
(50, 1, 1),
(54, 24, 5),
(59, 26, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_attribute_values`
--

CREATE TABLE `product_attribute_values` (
  `product_attribute_id` int(10) UNSIGNED NOT NULL,
  `attribute_value_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_attribute_values`
--

INSERT INTO `product_attribute_values` (`product_attribute_id`, `attribute_value_id`) VALUES
(40, 6),
(42, 6),
(43, 6),
(45, 1),
(47, 6),
(49, 6),
(50, 1),
(54, 6),
(59, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_categories`
--

CREATE TABLE `product_categories` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_categories`
--

INSERT INTO `product_categories` (`product_id`, `category_id`) VALUES
(1, 2),
(1, 3),
(1, 15),
(1, 18),
(1, 22),
(2, 2),
(2, 3),
(2, 20),
(2, 22),
(3, 2),
(3, 3),
(3, 20),
(3, 22),
(4, 4),
(4, 5),
(4, 12),
(4, 18),
(4, 25),
(5, 2),
(5, 3),
(5, 15),
(5, 18),
(5, 20),
(5, 22),
(6, 4),
(6, 5),
(6, 12),
(6, 18),
(6, 25),
(7, 2),
(7, 3),
(7, 18),
(7, 23),
(8, 2),
(8, 3),
(8, 20),
(8, 23),
(9, 4),
(9, 5),
(9, 12),
(9, 25),
(10, 2),
(10, 3),
(10, 4),
(10, 5),
(10, 12),
(10, 15),
(10, 25),
(11, 2),
(11, 3),
(11, 18),
(11, 24),
(12, 4),
(12, 5),
(12, 12),
(12, 18),
(12, 25),
(13, 4),
(13, 5),
(13, 12),
(13, 25),
(14, 4),
(14, 5),
(14, 12),
(14, 25),
(15, 15),
(16, 4),
(16, 12),
(16, 15),
(16, 19),
(17, 1),
(17, 2),
(17, 3),
(17, 4),
(17, 15),
(17, 18),
(17, 21),
(18, 1),
(18, 2),
(18, 3),
(18, 5),
(18, 15),
(18, 18),
(22, 21),
(24, 1),
(24, 4),
(24, 5),
(24, 12),
(24, 15),
(24, 18),
(24, 25),
(25, 18),
(25, 19),
(25, 21),
(26, 21),
(27, 3),
(27, 23),
(27, 24);

-- --------------------------------------------------------

--
-- Table structure for table `product_options`
--

CREATE TABLE `product_options` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `option_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_options`
--

INSERT INTO `product_options` (`product_id`, `option_id`) VALUES
(4, 6),
(8, 8),
(26, 9);

-- --------------------------------------------------------

--
-- Table structure for table `product_tags`
--

CREATE TABLE `product_tags` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_tags`
--

INSERT INTO `product_tags` (`product_id`, `tag_id`) VALUES
(3, 1),
(3, 2),
(4, 3),
(5, 2),
(6, 3),
(9, 3),
(10, 1),
(10, 3),
(12, 1),
(12, 3),
(13, 3),
(14, 3),
(17, 3),
(18, 1),
(18, 3),
(24, 2),
(24, 3),
(25, 3),
(26, 3),
(27, 1);

-- --------------------------------------------------------

--
-- Table structure for table `product_translations`
--

CREATE TABLE `product_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` longtext NOT NULL,
  `short_description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_translations`
--

INSERT INTO `product_translations` (`id`, `product_id`, `locale`, `name`, `description`, `short_description`) VALUES
(1, 1, 'en', 'WEDDING GARLAND', '<p>Wedding Garland</p>', 'wedding garland'),
(2, 2, 'en', 'Lotus Garland With White Sampangi Combination', '<p>ecause lotuses rise from the mud without stains, they are often viewed as a symbol of purity. Since they return to the murky water each evening and open their blooms at the break of day, lotus flowers are also symbols of&nbsp;<strong>strength, resilience, and rebirth</strong>.</p>', NULL),
(3, 3, 'en', 'Wedding Garlands with white and Green color mixing', '<p>Beautiful wedding garland with white and green combination... premium designer garlands&nbsp;</p>', NULL),
(4, 4, 'en', 'Yellow Cut Rose', '<p>A rose is either a woody perennial flowering plant of the genus Rosa, in the family Rosaceae, or the flower it bears. There are over three hundred species and tens of thousands of cultivars</p>', 'It\'s no wonder that roses have been referenced in literature and music for centuries. Archaeologists have discovered rose fossils that date back 35 million years. Even more shocking, the oldest living rose is 1,000 years old.'),
(5, 5, 'en', 'Rose petal Garlands', '<p>Rose petal garland are&nbsp;<strong>mostly used for special functions like marriage, engagement or reception</strong>. These are also used as garlands to worship god and goddess. Widely used in households and temples for rituals and worships. The aroma and fragrance of such rose petal garlands are mesmerising.</p>', NULL),
(6, 6, 'en', 'Jasmine', '<p>Jasmine is a genus of shrubs and vines in the olive family of Oleaceae. It contains around 200 species native to tropical and warm temperate regions of Eurasia, Africa, and Oceania. Jasmines are widely cultivated for the characteristic fragrance of their flowers.</p>', 'Fragrance. The main reason jasmine is so famous is its strong fragrance. People adore the flower for its strong, sweet smell. Countless cultures worldwide include it in aromatic products like candles, perfumes, soaps, and lotions.'),
(7, 7, 'en', 'Pink Rose Bouquet', '<p>The number of pink roses used in an arrangement also has its own unique meaning.&nbsp;<strong>A bunch of just three pink roses, for example, says \'I love you\', while a traditional arrangement of 12 roses is seen as a sign of gratitude and commitment</strong>.</p>', NULL),
(8, 8, 'en', 'Red Rose Bouquet', '<p>When used in a wedding bouquet, red roses are&nbsp;<strong>a token of appreciation and true respect</strong>. A dark red rose can convey the message that you are ready for commitment and represents passion. Red rosebuds can symbolize purity and loveliness along with romantic love</p>', NULL),
(9, 9, 'en', 'Manoranjitham', '<p>Manoranjitham, the climbing ylang-ylang, is&nbsp;<strong>a shrub found in India through to Burma, southern China and Taiwan, having flowers that are renowned for their exotic fragrance</strong>. Propagating the manoranjitham flower plant through cuttings is more difficult than growing it from seed.</p>', NULL),
(10, 10, 'en', 'Loose flowers(Red Rose)', '<p>Loose flowers are&nbsp;<strong>harvested without stalk</strong>. Examples are barleria, bedding dahlia, calotropis, chrysanthemum (spray type), chandni, crossandra, eranthemum, gaillardia, jasmine, kamini, kaner (yellow and red), lotus, marigold, rose (fragrant desi type), shoe flower (hibiscus), sunflower, tuberose, water lily, etc.</p>', NULL),
(11, 11, 'en', 'Hand Bouquet', '<p>Overall, a hand bouquet&nbsp;<strong>has the appearance that someone walked through a flower garden, picked flowers, and tied them up to give to someone else</strong>. Hand-tying is one of the simplest DIY bouquets, and the supply list is small&mdash;garden snips, flowers, fillers, and something to secure your stems, such as twine or ribbon.</p>', NULL),
(12, 12, 'en', 'Orchids', '<p>Orchids are plants that belong to the family Orchidaceae, a diverse and widespread group of flowering plants with blooms that are often colourful and fragrant. Orchidaceae is one of the two largest families of flowering plants, along with the Asteraceae.&nbsp;</p>', NULL),
(13, 13, 'en', 'Vadamalli', '<p>So that this book has been Titled as VADAMALLI. \'Vadamilli\' is&nbsp;<strong>an anthology which is full of positivity in the form of hope and inspiration</strong>. This book comprises powerful writing by 20 Co-author who have taken us to a different world through their quotes, poems and short stories, written in English and Tamil.</p>', 'Vadamalli garlands are traditional flower garlands made from fragrant and beautiful flowers'),
(14, 14, 'en', 'lotus', '<p>Nelumbo nucifera, also known as sacred lotus, Laxmi lotus, Indian lotus, or simply lotus, is one of two extant species of aquatic plant in the family Nelumbonaceae</p>', NULL),
(15, 15, 'en', 'VettiVer Malai For God', '<p>The Vetiver Garland or Vetiver malai is&nbsp;<strong>offered to god idols in temples during puja</strong>. The pleasant smell of this Vetiver malai makes the atmosphere filled with good fragrance. Vetiver malai or Vetiver garlands are an important part of puja (worship) both at the temple and in-home.</p>', NULL),
(16, 16, 'en', 'Combo Losse flower', '<p>Loose Flowers: The flower which is cut the stalk and leafless, which has an only flower is called loose flower. Like &ndash; marigold, moonshine, caner, jasmine, shoe flower, desi rose, Bedding Dahlia, etc. flowers. This type of flower is used for garland and decoration</p>', NULL),
(17, 17, 'en', 'Jasmine Saram', '<p>Fragrance. The main reason jasmine is so famous is its&nbsp;<strong>strong fragrance</strong>. People adore the flower for its strong, sweet smell. Countless cultures worldwide include it in aromatic products like candles, perfumes, soaps, and lotions.</p>', NULL),
(18, 18, 'en', 'Mullai Saram', '<p>The Mullai flowers also known as&nbsp;<strong>Arabian Jasmine</strong> are known for it\'s amazing fragrance.</p>', NULL),
(19, 19, 'en', 'contact', '<p>hj</p>', NULL),
(20, 20, 'en', 'testing product', '<p>s-l1200.webp</p>', NULL),
(21, 21, 'en', 'contact', '<p>The product won\'t be shipped.</p>', NULL),
(22, 22, 'en', 'Mulai Saram 2', '<p>The Jasminum auriculatum -juhi-mullai poo is&nbsp;<strong>a good houseplant with a good fragrant with many-petaled</strong>. This plant is categorized under flower, shrub &amp; ornamental plant</p>', NULL),
(23, 23, 'en', 'testing product 1', '<p>After Disable the Download Option.</p>', NULL),
(24, 24, 'en', 'Arali Saram', '<p><strong>A little shrub flower native to sub-tropical and temperate climates</strong>, the Arali Poo flower is also known as Nerium Oleander in English. It is cultivated for its incredible flower beauty. Although this flower is primarily found in the Mediterranean region, its actual origin is still unknown</p>', NULL),
(25, 25, 'en', 'TEtsya', '<p>TEsttvyuv</p>', NULL),
(26, 26, 'en', 'Malli saram', '<p>fresh jasmine direct from garden</p>', NULL),
(27, 27, 'en', 'Violet Bouquet', '<div class=\"kb0PBd cvP2Ce ieodic\" data-sncf=\"2\" data-snf=\"nke7rc\">\r\n<div class=\"VwiC3b yXK7lf lyLwlc yDYNvb W8l4ac\"><em>Violet Bouquet</em>&nbsp;by Afnan is a Floral fragrance for women.&nbsp;<em>Violet Bouquet</em>&nbsp;was launched in 2020. Top notes are Sweet Notes, Saffron, Woodsy Notes and Citruses;&nbsp;...</div>\r\n</div>\r\n<div class=\"kb0PBd cvP2Ce ieodic\" data-sncf=\"3\" data-snf=\"fhcVfc\">\r\n<div>Pros and cons:<span class=\"ADx4Yb\"><span class=\"s8CFQb\">&nbsp;Presentation is lovely and feminine</span><span class=\"s8CFQb\"><span aria-hidden=\"true\">&nbsp;&sdot;&nbsp;</span>Insane staying power and projection</span><span class=\"s8CFQb\"><span aria-hidden=\"true\">&nbsp;</span></span></span></div>\r\n</div>', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `recurrings`
--

CREATE TABLE `recurrings` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `recurring_date_count` int(11) DEFAULT NULL,
  `max_preparing_days` int(11) DEFAULT NULL,
  `delivery_time` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `recurrings`
--

INSERT INTO `recurrings` (`id`, `order_id`, `recurring_date_count`, `max_preparing_days`, `delivery_time`, `created_at`, `updated_at`) VALUES
(1, 103, 4, 5, '15:00:00', '2023-11-10 12:10:40', '2023-11-10 12:10:40'),
(2, 106, 7, 5, '13:26:00', '2023-11-17 10:29:17', '2023-11-17 10:29:17');

-- --------------------------------------------------------

--
-- Table structure for table `recurring_sub_orders`
--

CREATE TABLE `recurring_sub_orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `recurring_id` int(10) UNSIGNED NOT NULL,
  `selected_date` date DEFAULT NULL,
  `subscribe_status` enum('0','1') NOT NULL DEFAULT '1',
  `order_status` varchar(191) DEFAULT NULL,
  `updated_user_id` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `recurring_sub_orders`
--

INSERT INTO `recurring_sub_orders` (`id`, `recurring_id`, `selected_date`, `subscribe_status`, `order_status`, `updated_user_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-11-16', '1', 'pending', NULL, '2023-11-10 12:10:40', '2023-11-10 12:10:40'),
(2, 1, '2023-11-18', '1', 'pending', NULL, '2023-11-10 12:10:40', '2023-11-10 12:10:40'),
(3, 1, '2023-11-24', '0', 'pending', 4, '2023-11-10 12:10:40', '2023-11-10 10:41:45'),
(4, 1, '2023-11-23', '0', 'pending', 4, '2023-11-10 12:10:40', '2023-11-10 09:56:06'),
(5, 2, '2023-11-23', '1', 'completed', NULL, '2023-11-17 10:29:17', '2023-11-17 10:39:57'),
(6, 2, '2023-11-24', '1', 'completed', NULL, '2023-11-17 10:29:17', '2023-11-17 10:39:59'),
(7, 2, '2023-12-02', '1', 'completed', NULL, '2023-11-17 10:29:17', '2023-11-17 10:40:00'),
(8, 2, '2023-12-16', '1', 'completed', NULL, '2023-11-17 10:29:17', '2023-11-17 10:42:00'),
(9, 2, '2023-12-14', '1', 'completed', NULL, '2023-11-17 10:29:17', '2023-11-17 10:41:59'),
(10, 2, '2023-12-06', '1', 'completed', NULL, '2023-11-17 10:29:17', '2023-11-17 10:40:25'),
(11, 2, '2023-12-07', '1', 'completed', NULL, '2023-11-17 10:29:17', '2023-11-17 10:42:02');

-- --------------------------------------------------------

--
-- Table structure for table `related_products`
--

CREATE TABLE `related_products` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `related_product_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `related_products`
--

INSERT INTO `related_products` (`product_id`, `related_product_id`) VALUES
(3, 1),
(3, 2),
(5, 1),
(5, 2),
(7, 2),
(7, 3),
(7, 6),
(8, 2),
(8, 4),
(8, 5),
(8, 7),
(9, 4),
(9, 6),
(10, 2),
(10, 5),
(10, 7),
(10, 8),
(11, 5),
(11, 7),
(11, 8),
(11, 10),
(12, 6),
(12, 8),
(12, 9),
(13, 9),
(13, 12),
(15, 5),
(15, 7),
(15, 10),
(15, 11),
(15, 13),
(16, 7),
(16, 9),
(16, 12),
(16, 13),
(16, 15),
(17, 13),
(17, 14),
(17, 15),
(17, 16),
(18, 15),
(18, 16),
(18, 17),
(24, 15),
(24, 16),
(24, 17),
(24, 18),
(26, 16),
(26, 18);

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

CREATE TABLE `reminders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `code` varchar(191) NOT NULL,
  `completed` tinyint(1) NOT NULL DEFAULT 0,
  `completed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(10) UNSIGNED NOT NULL,
  `reviewer_id` int(10) UNSIGNED DEFAULT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `rating` int(11) NOT NULL,
  `reviewer_name` varchar(191) NOT NULL,
  `comment` text NOT NULL,
  `is_approved` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`id`, `reviewer_id`, `product_id`, `rating`, `reviewer_name`, `comment`, `is_approved`, `created_at`, `updated_at`) VALUES
(1, 1, 3, 3, 'indu', 'nice', 1, '2023-08-11 10:31:18', '2023-08-11 10:31:18'),
(2, 1, 4, 5, 'indu', 'nice', 1, '2023-08-14 07:08:05', '2023-08-14 07:08:05'),
(3, NULL, 4, 3, 'sangeetha', 'good', 1, '2023-08-17 11:45:00', '2023-08-17 11:45:00'),
(4, 3, 18, 4, 'Mahendran Sadhasivam', 'Good one product', 1, '2023-08-22 11:17:36', '2023-08-22 11:19:21'),
(10, 1, 17, 5, 'indu', 'nice product', 1, '2023-08-28 09:20:18', '2023-08-28 09:20:18');

-- --------------------------------------------------------

--
-- Table structure for table `rewardpoints`
--

CREATE TABLE `rewardpoints` (
  `id` int(10) UNSIGNED NOT NULL,
  `enable_bday_points` int(11) NOT NULL,
  `enable_referral_points` int(11) NOT NULL,
  `enable_show_customer_points` int(11) NOT NULL,
  `enable_show_points_with_order` int(11) NOT NULL,
  `enable_show_points_by_mail` int(11) NOT NULL,
  `enable_give_old_order_points` int(11) NOT NULL,
  `enable_apply_points_in_checkout_page` int(11) NOT NULL,
  `enable_remove_points_order_refund` int(11) NOT NULL,
  `add_days_reward_points_expiry` int(11) NOT NULL,
  `add_days_reward_points_assignment` int(11) NOT NULL,
  `use_points_per_order` int(11) NOT NULL,
  `min_order_cart_value_redemption` int(11) NOT NULL,
  `currency_value` int(11) NOT NULL,
  `point_value` int(11) NOT NULL,
  `redemption_point_value` int(11) NOT NULL,
  `redemption_currency_value` int(11) NOT NULL,
  `epoint_first_signup_value` int(11) NOT NULL,
  `epoint_ref_point_value` int(11) NOT NULL,
  `epoint_forder_point_value` int(11) NOT NULL,
  `epoint_freview_point_value` int(11) NOT NULL,
  `epoint_fpay_point_value` int(11) NOT NULL,
  `epoint_bday_point_value` int(11) NOT NULL,
  `apply_notification_message` varchar(191) NOT NULL,
  `enable_apply_points_rem_payment` int(11) NOT NULL,
  `apply_payment_noti_message` varchar(191) NOT NULL,
  `bday_noti_mail_message` varchar(191) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rewardpoints`
--

INSERT INTO `rewardpoints` (`id`, `enable_bday_points`, `enable_referral_points`, `enable_show_customer_points`, `enable_show_points_with_order`, `enable_show_points_by_mail`, `enable_give_old_order_points`, `enable_apply_points_in_checkout_page`, `enable_remove_points_order_refund`, `add_days_reward_points_expiry`, `add_days_reward_points_assignment`, `use_points_per_order`, `min_order_cart_value_redemption`, `currency_value`, `point_value`, `redemption_point_value`, `redemption_currency_value`, `epoint_first_signup_value`, `epoint_ref_point_value`, `epoint_forder_point_value`, `epoint_freview_point_value`, `epoint_fpay_point_value`, `epoint_bday_point_value`, `apply_notification_message`, `enable_apply_points_rem_payment`, `apply_payment_noti_message`, `bday_noti_mail_message`, `is_active`, `start_date`, `end_date`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 0, 0, 1, 0, 0, 0, 0, 0, 12, 0, 100, 150, 10, 1, 1, 1, 50, 0, 100, 25, 60, 40, '0', 0, '0', '1', 0, NULL, NULL, NULL, NULL, '2023-11-01 12:02:52');

-- --------------------------------------------------------

--
-- Table structure for table `reward_points_gifted`
--

CREATE TABLE `reward_points_gifted` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `reward_point_value` int(11) DEFAULT 0,
  `reward_point_remarks` varchar(100) DEFAULT NULL,
  `customer_reward_id` int(11) NOT NULL COMMENT 'reference to customer_reward_points table id value',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(10) UNSIGNED NOT NULL,
  `permissions` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `permissions`, `created_at`, `updated_at`) VALUES
(1, '{\"admin.attributes.index\":true,\"admin.attributes.create\":true,\"admin.attributes.edit\":true,\"admin.attributes.destroy\":true,\"admin.attribute_sets.index\":true,\"admin.attribute_sets.create\":true,\"admin.attribute_sets.edit\":true,\"admin.attribute_sets.destroy\":true,\"admin.brands.index\":true,\"admin.brands.create\":true,\"admin.brands.edit\":true,\"admin.brands.destroy\":true,\"admin.categories.index\":true,\"admin.categories.create\":true,\"admin.categories.edit\":true,\"admin.categories.destroy\":true,\"admin.coupons.index\":true,\"admin.coupons.create\":true,\"admin.coupons.edit\":true,\"admin.coupons.destroy\":true,\"admin.currency_rates.index\":true,\"admin.currency_rates.edit\":true,\"admin.emails.index\":true,\"admin.emails.create\":true,\"admin.emails.edit\":true,\"admin.emails.destroy\":true,\"admin.fixedrates.index\":true,\"admin.fixedrates.create\":true,\"admin.fixedrates.edit\":true,\"admin.fixedrates.destroy\":true,\"admin.flash_sales.index\":true,\"admin.flash_sales.create\":true,\"admin.flash_sales.edit\":true,\"admin.flash_sales.destroy\":true,\"admin.galleries.index\":true,\"admin.galleries.create\":true,\"admin.galleries.edit\":true,\"admin.galleries.destroy\":true,\"admin.importer.index\":true,\"admin.importer.create\":true,\"admin.media.index\":true,\"admin.media.create\":true,\"admin.media.destroy\":true,\"admin.menus.index\":true,\"admin.menus.create\":true,\"admin.menus.edit\":true,\"admin.menus.destroy\":true,\"admin.menu_items.index\":true,\"admin.menu_items.create\":true,\"admin.menu_items.edit\":true,\"admin.menu_items.destroy\":true,\"admin.options.index\":true,\"admin.options.create\":true,\"admin.options.edit\":true,\"admin.options.destroy\":true,\"admin.orders.index\":true,\"admin.orders.show\":true,\"admin.orders.create\":true,\"admin.orders.edit\":true,\"admin.pages.index\":true,\"admin.pages.create\":true,\"admin.pages.edit\":true,\"admin.pages.destroy\":true,\"admin.pickupstores.index\":true,\"admin.pickupstores.create\":true,\"admin.pickupstores.edit\":true,\"admin.pickupstores.destroy\":true,\"admin.products.index\":true,\"admin.products.create\":true,\"admin.products.edit\":true,\"admin.products.destroy\":true,\"admin.recurrings.index\":true,\"admin.recurrings.edit\":true,\"admin.reports.index\":true,\"admin.reviews.index\":true,\"admin.reviews.edit\":true,\"admin.reviews.destroy\":true,\"admin.rewardpoints.index\":true,\"admin.rewardpoints.create\":true,\"admin.rewardpoints.edit\":true,\"admin.rewardpoints.destroy\":true,\"admin.rewardpointsgift.index\":true,\"admin.rewardpointsgift.create\":true,\"admin.rewardpointsgift.edit\":true,\"admin.rewardpointsgift.destroy\":true,\"admin.customerrewardpoints.index\":true,\"admin.customerrewardpoints.create\":true,\"admin.customerrewardpoints.edit\":true,\"admin.customerrewardpoints.destroy\":true,\"admin.settings.edit\":true,\"admin.sliders.index\":true,\"admin.sliders.create\":true,\"admin.sliders.edit\":true,\"admin.sliders.destroy\":true,\"admin.subscribers.index\":true,\"admin.subscribers.create\":true,\"admin.subscribers.edit\":true,\"admin.subscribers.destroy\":true,\"admin.tags.index\":true,\"admin.tags.create\":true,\"admin.tags.edit\":true,\"admin.tags.destroy\":true,\"admin.templates.index\":true,\"admin.templates.create\":true,\"admin.templates.edit\":true,\"admin.templates.destroy\":true,\"admin.testimonials.index\":true,\"admin.testimonials.create\":true,\"admin.testimonials.edit\":true,\"admin.testimonials.destroy\":true,\"admin.transactions.index\":true,\"admin.translations.index\":true,\"admin.translations.edit\":true,\"admin.users.index\":true,\"admin.users.create\":true,\"admin.users.edit\":true,\"admin.users.destroy\":true,\"admin.roles.index\":true,\"admin.roles.create\":true,\"admin.roles.edit\":true,\"admin.roles.destroy\":true,\"admin.storefront.edit\":true}', '2023-08-09 06:24:33', '2023-11-09 11:30:37'),
(2, '{\"admin.subscribers.index\":true,\"admin.subscribers.create\":true,\"admin.subscribers.edit\":true,\"admin.subscribers.destroy\":true}', '2023-08-09 06:24:34', '2023-11-01 13:56:26');

-- --------------------------------------------------------

--
-- Table structure for table `role_translations`
--

CREATE TABLE `role_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_translations`
--

INSERT INTO `role_translations` (`id`, `role_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'Admin'),
(2, 2, 'en', 'Customer');

-- --------------------------------------------------------

--
-- Table structure for table `search_terms`
--

CREATE TABLE `search_terms` (
  `id` int(10) UNSIGNED NOT NULL,
  `term` varchar(191) NOT NULL,
  `results` int(10) UNSIGNED NOT NULL,
  `hits` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `search_terms`
--

INSERT INTO `search_terms` (`id`, `term`, `results`, `hits`, `created_at`, `updated_at`) VALUES
(1, 'rose', 5, 1, '2023-08-24 12:11:42', '2023-08-24 12:11:42'),
(2, 'rose1', 0, 4, '2023-08-24 12:12:05', '2023-08-25 10:41:16'),
(3, 'rose2', 0, 2, '2023-08-24 12:12:30', '2023-08-25 09:42:17'),
(4, 'rose3', 0, 1, '2023-08-24 12:12:44', '2023-08-24 12:12:44'),
(5, 'rose4', 0, 2, '2023-08-24 10:13:37', '2023-08-24 10:14:45'),
(6, 'rose5', 0, 1, '2023-08-24 10:14:13', '2023-08-24 10:14:13'),
(7, 'saram', 2, 1, '2023-08-24 10:16:14', '2023-08-24 10:16:14'),
(8, 'garland', 4, 20, '2023-08-24 10:17:45', '2023-08-25 14:11:19'),
(9, 'mull', 1, 7, '2023-08-24 15:20:28', '2023-08-26 06:55:03'),
(10, 'garl', 4, 3, '2023-08-25 10:48:50', '2023-08-25 11:39:37'),
(11, 'lotus', 2, 1, '2023-08-26 07:47:09', '2023-08-26 07:47:09');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(191) NOT NULL,
  `is_translatable` tinyint(1) NOT NULL DEFAULT 0,
  `plain_value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `is_translatable`, `plain_value`, `created_at`, `updated_at`) VALUES
(1, 'store_name', 1, NULL, '2023-08-09 06:24:33', '2023-08-09 06:24:33'),
(2, 'store_email', 0, 's:22:\"admin@apsgarlands.test\";', '2023-08-09 06:24:33', '2023-08-11 05:41:39'),
(3, 'store_phone', 0, 's:12:\"+121 9393939\";', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(4, 'search_engine', 0, 's:5:\"mysql\";', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(5, 'algolia_app_id', 0, 'N;', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(6, 'algolia_secret', 0, 'N;', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(7, 'active_theme', 0, 's:10:\"Storefront\";', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(8, 'supported_countries', 0, 'a:1:{i:0;s:2:\"MY\";}', '2023-08-09 06:24:34', '2023-08-24 10:27:13'),
(9, 'default_country', 0, 's:2:\"MY\";', '2023-08-09 06:24:34', '2023-08-10 12:11:31'),
(10, 'supported_locales', 0, 'a:1:{i:0;s:2:\"en\";}', '2023-08-09 06:24:35', '2023-09-29 11:55:23'),
(11, 'default_locale', 0, 's:2:\"en\";', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(12, 'default_timezone', 0, 's:17:\"Asia/Kuala_Lumpur\";', '2023-08-09 06:24:35', '2023-08-24 10:27:13'),
(13, 'customer_role', 0, 's:1:\"2\";', '2023-08-09 06:24:35', '2023-08-10 12:11:31'),
(14, 'reviews_enabled', 0, 's:1:\"1\";', '2023-08-09 06:24:35', '2023-09-06 12:03:08'),
(15, 'auto_approve_reviews', 0, 's:1:\"1\";', '2023-08-09 06:24:35', '2023-09-23 10:28:06'),
(16, 'cookie_bar_enabled', 0, 's:1:\"1\";', '2023-08-09 06:24:35', '2023-08-28 09:18:22'),
(17, 'supported_currencies', 0, 'a:1:{i:0;s:3:\"MYR\";}', '2023-08-09 06:24:35', '2023-08-26 06:54:31'),
(18, 'default_currency', 0, 's:3:\"MYR\";', '2023-08-09 06:24:35', '2023-08-26 06:54:31'),
(19, 'send_order_invoice_email', 0, 'b:0;', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(20, 'newsletter_enabled', 0, 's:1:\"0\";', '2023-08-09 06:24:35', '2023-11-09 15:26:45'),
(21, 'local_pickup_cost', 0, 's:1:\"2\";', '2023-08-09 06:24:36', '2023-08-11 05:41:40'),
(22, 'flat_rate_cost', 0, 's:1:\"0\";', '2023-08-09 06:24:36', '2023-09-23 11:00:48'),
(23, 'free_shipping_label', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(24, 'local_pickup_label', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(25, 'flat_rate_label', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(26, 'paypal_label', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(27, 'paypal_description', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(28, 'stripe_label', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(29, 'stripe_description', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(30, 'paytm_label', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(31, 'paytm_description', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(32, 'razorpay_label', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(33, 'razorpay_description', 1, NULL, '2023-08-09 06:24:36', '2023-08-09 06:24:36'),
(34, 'instamojo_label', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(35, 'instamojo_description', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(36, 'authorizenet_label', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(37, 'authorizenet_description', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(38, 'paystack_label', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(39, 'paystack_description', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(40, 'flutterwave_label', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(41, 'flutterwave_description', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(42, 'mercadopago_label', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(43, 'mercadopago_description', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(44, 'cod_label', 1, NULL, '2023-08-09 06:24:37', '2023-08-09 06:24:37'),
(45, 'cod_description', 1, NULL, '2023-08-09 06:24:38', '2023-08-09 06:24:38'),
(46, 'bank_transfer_label', 1, NULL, '2023-08-09 06:24:38', '2023-08-09 06:24:38'),
(47, 'bank_transfer_description', 1, NULL, '2023-08-09 06:24:38', '2023-08-09 06:24:38'),
(48, 'check_payment_label', 1, NULL, '2023-08-09 06:24:38', '2023-08-09 06:24:38'),
(49, 'check_payment_description', 1, NULL, '2023-08-09 06:24:38', '2023-08-09 06:24:38'),
(50, 'storefront_copyright_text', 1, 's:92:\"Copyright © <a href=\"{{ store_url }}\">{{ store_name }}</a> {{ year }}. All rights reserved.\";', '2023-08-09 06:24:38', '2023-08-10 05:00:12'),
(51, 'storefront_welcome_text', 1, NULL, '2023-08-10 05:00:11', '2023-08-10 05:00:11'),
(52, 'storefront_address', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(53, 'storefront_navbar_text', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(54, 'storefront_footer_menu_one_title', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(55, 'storefront_footer_menu_two_title', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(56, 'storefront_feature_1_title', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(57, 'storefront_feature_1_subtitle', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(58, 'storefront_feature_2_title', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(59, 'storefront_feature_2_subtitle', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(60, 'storefront_feature_3_title', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(61, 'storefront_feature_3_subtitle', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(62, 'storefront_feature_4_title', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(63, 'storefront_feature_4_subtitle', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(64, 'storefront_feature_5_title', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(65, 'storefront_feature_5_subtitle', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(66, 'storefront_product_page_banner_file_id', 1, NULL, '2023-08-10 05:00:12', '2023-08-10 05:00:12'),
(67, 'storefront_slider_banner_1_file_id', 1, NULL, '2023-08-10 05:00:13', '2023-08-10 05:00:13'),
(68, 'storefront_slider_banner_2_file_id', 1, NULL, '2023-08-10 05:00:13', '2023-08-10 05:00:13'),
(69, 'storefront_three_column_full_width_banners_1_file_id', 1, NULL, '2023-08-10 05:00:13', '2023-08-10 05:00:13'),
(70, 'storefront_three_column_full_width_banners_2_file_id', 1, NULL, '2023-08-10 05:00:13', '2023-08-10 05:00:13'),
(71, 'storefront_three_column_full_width_banners_3_file_id', 1, NULL, '2023-08-10 05:00:13', '2023-08-10 05:00:13'),
(72, 'storefront_featured_categories_section_title', 1, NULL, '2023-08-10 05:00:13', '2023-08-10 05:00:13'),
(73, 'storefront_featured_categories_section_subtitle', 1, NULL, '2023-08-10 05:00:13', '2023-08-10 05:00:13'),
(74, 'storefront_product_tabs_1_section_tab_1_title', 1, NULL, '2023-08-10 05:00:13', '2023-08-10 05:00:13'),
(75, 'storefront_product_tabs_1_section_tab_2_title', 1, NULL, '2023-08-10 05:00:13', '2023-08-10 05:00:13'),
(76, 'storefront_product_tabs_1_section_tab_3_title', 1, NULL, '2023-08-10 05:00:13', '2023-08-10 05:00:13'),
(77, 'storefront_product_tabs_1_section_tab_4_title', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(78, 'storefront_two_column_banners_1_file_id', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(79, 'storefront_two_column_banners_2_file_id', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(80, 'storefront_product_grid_section_tab_1_title', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(81, 'storefront_product_grid_section_tab_2_title', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(82, 'storefront_product_grid_section_tab_3_title', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(83, 'storefront_product_grid_section_tab_4_title', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(84, 'storefront_three_column_banners_1_file_id', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(85, 'storefront_three_column_banners_2_file_id', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(86, 'storefront_three_column_banners_3_file_id', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(87, 'storefront_product_tabs_2_section_title', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(88, 'storefront_product_tabs_2_section_tab_1_title', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(89, 'storefront_product_tabs_2_section_tab_2_title', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(90, 'storefront_product_tabs_2_section_tab_3_title', 1, NULL, '2023-08-10 05:00:14', '2023-08-10 05:00:14'),
(91, 'storefront_product_tabs_2_section_tab_4_title', 1, NULL, '2023-08-10 05:00:15', '2023-08-10 05:00:15'),
(92, 'storefront_one_column_banner_file_id', 1, NULL, '2023-08-10 05:00:15', '2023-08-10 05:00:15'),
(93, 'storefront_theme_color', 0, 's:4:\"pink\";', '2023-08-10 05:00:15', '2023-08-14 12:26:53'),
(94, 'storefront_custom_theme_color', 0, 's:7:\"#ffffff\";', '2023-08-10 05:00:15', '2023-08-14 12:26:53'),
(95, 'storefront_mail_theme_color', 0, 's:6:\"indigo\";', '2023-08-10 05:00:15', '2023-08-10 11:47:26'),
(96, 'storefront_custom_mail_theme_color', 0, 's:7:\"#000000\";', '2023-08-10 05:00:15', '2023-08-10 05:00:15'),
(97, 'storefront_slider', 0, 's:1:\"3\";', '2023-08-10 05:00:15', '2023-08-12 08:17:33'),
(98, 'storefront_terms_page', 0, 's:1:\"8\";', '2023-08-10 05:00:15', '2023-08-25 13:38:07'),
(99, 'storefront_privacy_page', 0, 's:1:\"3\";', '2023-08-10 05:00:15', '2023-08-11 05:04:44'),
(100, 'storefront_most_searched_keywords_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:15', '2023-09-06 09:55:23'),
(101, 'storefront_primary_menu', 0, 's:1:\"5\";', '2023-08-10 05:00:15', '2023-08-11 05:50:55'),
(102, 'storefront_category_menu', 0, 's:1:\"1\";', '2023-08-10 05:00:15', '2023-08-11 06:57:49'),
(103, 'storefront_footer_menu_one', 0, 's:1:\"8\";', '2023-08-10 05:00:15', '2023-10-17 14:31:51'),
(104, 'storefront_footer_menu_two', 0, 's:1:\"9\";', '2023-08-10 05:00:15', '2023-10-17 14:31:51'),
(105, 'storefront_features_section_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:15', '2023-08-14 04:55:43'),
(106, 'storefront_feature_1_icon', 0, 's:55:\"https://cdn.euroflorist.com/cmspr/Uk/calendaricon0.webp\";', '2023-08-10 05:00:15', '2023-08-14 04:56:10'),
(107, 'storefront_feature_2_icon', 0, 's:55:\"https://cdn.euroflorist.com/cmspr/Uk/deliveryicon0.webp\";', '2023-08-10 05:00:15', '2023-08-14 05:01:30'),
(108, 'storefront_feature_3_icon', 0, 's:54:\"https://cdn.euroflorist.com/cmspr/Uk/bouqueticon0.webp\";', '2023-08-10 05:00:15', '2023-08-14 05:01:30'),
(109, 'storefront_feature_4_icon', 0, 's:52:\"https://cdn.euroflorist.com/cmspr/Uk/hearticon0.webp\";', '2023-08-10 05:00:15', '2023-08-14 05:01:30'),
(110, 'storefront_feature_5_icon', 0, 's:45:\"<use xlink:href=\"/sprite.svg#delivery\"></use>\";', '2023-08-10 05:00:15', '2023-08-14 05:05:12'),
(111, 'storefront_product_page_banner_call_to_action_url', 0, 's:11:\"/categories\";', '2023-08-10 05:00:16', '2023-11-17 10:34:41'),
(112, 'storefront_product_page_banner_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(113, 'storefront_facebook_link', 0, 'N;', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(114, 'storefront_twitter_link', 0, 'N;', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(115, 'storefront_instagram_link', 0, 'N;', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(116, 'storefront_youtube_link', 0, 'N;', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(117, 'storefront_slider_banner_1_call_to_action_url', 0, 's:30:\"/categories/greetings/products\";', '2023-08-10 05:00:16', '2023-10-17 14:08:03'),
(118, 'storefront_slider_banner_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 11:05:22'),
(119, 'storefront_slider_banner_2_call_to_action_url', 0, 's:28:\"/categories/bouquet/products\";', '2023-08-10 05:00:16', '2023-10-17 14:08:03'),
(120, 'storefront_slider_banner_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(121, 'storefront_three_column_full_width_banners_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:16', '2023-08-14 08:35:41'),
(122, 'storefront_three_column_full_width_banners_1_call_to_action_url', 0, 's:38:\"/categories/same-day-delivery/products\";', '2023-08-10 05:00:16', '2023-10-17 14:08:03'),
(123, 'storefront_three_column_full_width_banners_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(124, 'storefront_three_column_full_width_banners_2_call_to_action_url', 0, 's:26:\"/categories/combo/products\";', '2023-08-10 05:00:16', '2023-10-17 14:08:03'),
(125, 'storefront_three_column_full_width_banners_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(126, 'storefront_three_column_full_width_banners_3_call_to_action_url', 0, 's:30:\"/categories/greetings/products\";', '2023-08-10 05:00:16', '2023-10-17 14:08:03'),
(127, 'storefront_three_column_full_width_banners_3_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(128, 'storefront_featured_categories_section_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:16', '2023-08-14 07:45:25'),
(129, 'storefront_featured_categories_section_category_1_category_id', 0, 's:2:\"15\";', '2023-08-10 05:00:16', '2023-08-14 11:54:30'),
(130, 'storefront_featured_categories_section_category_1_product_type', 0, 's:15:\"custom_products\";', '2023-08-10 05:00:16', '2023-08-14 11:54:30'),
(131, 'storefront_featured_categories_section_category_1_products_limit', 0, 's:1:\"9\";', '2023-08-10 05:00:16', '2023-08-10 11:51:36'),
(132, 'storefront_featured_categories_section_category_2_category_id', 0, 's:1:\"5\";', '2023-08-10 05:00:16', '2023-08-10 10:23:24'),
(133, 'storefront_featured_categories_section_category_2_product_type', 0, 's:15:\"custom_products\";', '2023-08-10 05:00:16', '2023-08-14 07:46:08'),
(134, 'storefront_featured_categories_section_category_2_products_limit', 0, 'N;', '2023-08-10 05:00:16', '2023-08-14 07:46:08'),
(135, 'storefront_featured_categories_section_category_3_category_id', 0, 's:1:\"3\";', '2023-08-10 05:00:16', '2023-08-10 11:03:21'),
(136, 'storefront_featured_categories_section_category_3_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:17', '2023-08-10 11:50:27'),
(137, 'storefront_featured_categories_section_category_3_products_limit', 0, 's:1:\"8\";', '2023-08-10 05:00:17', '2023-08-10 11:50:27'),
(138, 'storefront_featured_categories_section_category_4_category_id', 0, 's:1:\"4\";', '2023-08-10 05:00:17', '2023-08-10 11:03:22'),
(139, 'storefront_featured_categories_section_category_4_product_type', 0, 's:15:\"custom_products\";', '2023-08-10 05:00:17', '2023-08-14 11:36:18'),
(140, 'storefront_featured_categories_section_category_4_products_limit', 0, 's:1:\"6\";', '2023-08-10 05:00:17', '2023-08-10 11:50:28'),
(141, 'storefront_featured_categories_section_category_5_category_id', 0, 's:1:\"3\";', '2023-08-10 05:00:17', '2023-08-14 11:36:18'),
(142, 'storefront_featured_categories_section_category_5_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:17', '2023-08-14 11:36:18'),
(143, 'storefront_featured_categories_section_category_5_products_limit', 0, 's:1:\"9\";', '2023-08-10 05:00:17', '2023-08-14 11:36:18'),
(144, 'storefront_featured_categories_section_category_6_category_id', 0, 's:1:\"2\";', '2023-08-10 05:00:17', '2023-08-14 11:36:18'),
(145, 'storefront_featured_categories_section_category_6_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:17', '2023-08-10 11:50:28'),
(146, 'storefront_featured_categories_section_category_6_products_limit', 0, 's:1:\"7\";', '2023-08-10 05:00:17', '2023-08-10 11:50:28'),
(147, 'storefront_product_tabs_1_section_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:17', '2023-08-10 12:01:43'),
(148, 'storefront_product_tabs_1_section_tab_1_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:17', '2023-08-10 11:59:51'),
(149, 'storefront_product_tabs_1_section_tab_1_category_id', 0, 's:1:\"3\";', '2023-08-10 05:00:17', '2023-08-14 12:28:27'),
(150, 'storefront_product_tabs_1_section_tab_1_products_limit', 0, 's:2:\"20\";', '2023-08-10 05:00:17', '2023-08-14 12:28:27'),
(151, 'storefront_product_tabs_1_section_tab_2_product_type', 0, 's:15:\"latest_products\";', '2023-08-10 05:00:17', '2023-08-10 11:59:52'),
(152, 'storefront_product_tabs_1_section_tab_2_category_id', 0, 'N;', '2023-08-10 05:00:17', '2023-08-10 05:00:17'),
(153, 'storefront_product_tabs_1_section_tab_2_products_limit', 0, 's:2:\"20\";', '2023-08-10 05:00:17', '2023-08-14 12:28:27'),
(154, 'storefront_product_tabs_1_section_tab_3_product_type', 0, 's:24:\"recently_viewed_products\";', '2023-08-10 05:00:17', '2023-08-10 11:59:52'),
(155, 'storefront_product_tabs_1_section_tab_3_category_id', 0, 'N;', '2023-08-10 05:00:17', '2023-08-10 05:00:17'),
(156, 'storefront_product_tabs_1_section_tab_3_products_limit', 0, 's:2:\"20\";', '2023-08-10 05:00:17', '2023-08-14 12:28:27'),
(157, 'storefront_product_tabs_1_section_tab_4_product_type', 0, 's:15:\"custom_products\";', '2023-08-10 05:00:17', '2023-08-10 11:59:52'),
(158, 'storefront_product_tabs_1_section_tab_4_category_id', 0, 'N;', '2023-08-10 05:00:17', '2023-08-10 05:00:17'),
(159, 'storefront_product_tabs_1_section_tab_4_products_limit', 0, 'N;', '2023-08-10 05:00:17', '2023-08-10 05:00:17'),
(160, 'storefront_top_brands_section_enabled', 0, 's:1:\"0\";', '2023-08-10 05:00:17', '2023-08-14 05:14:41'),
(161, 'storefront_top_brands', 0, 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', '2023-08-10 05:00:17', '2023-08-10 11:52:04'),
(162, 'storefront_flash_sale_and_vertical_products_section_enabled', 0, 's:1:\"0\";', '2023-08-10 05:00:17', '2023-10-17 09:14:21'),
(163, 'storefront_flash_sale_title', 0, 's:9:\"AADI SALE\";', '2023-08-10 05:00:17', '2023-08-11 07:22:17'),
(164, 'storefront_active_flash_sale_campaign', 0, 's:1:\"4\";', '2023-08-10 05:00:18', '2023-10-17 08:11:53'),
(165, 'storefront_vertical_products_1_title', 0, 's:17:\"Same day delivery\";', '2023-08-10 05:00:18', '2023-08-14 11:30:00'),
(166, 'storefront_vertical_products_1_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:18', '2023-08-11 07:26:25'),
(167, 'storefront_vertical_products_1_category_id', 0, 's:2:\"18\";', '2023-08-10 05:00:18', '2023-08-14 11:30:00'),
(168, 'storefront_vertical_products_1_products_limit', 0, 's:1:\"9\";', '2023-08-10 05:00:18', '2023-08-11 07:26:25'),
(169, 'storefront_vertical_products_2_title', 0, 's:7:\"Flowers\";', '2023-08-10 05:00:18', '2023-08-14 11:21:22'),
(170, 'storefront_vertical_products_2_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:18', '2023-08-11 07:26:25'),
(171, 'storefront_vertical_products_2_category_id', 0, 's:1:\"5\";', '2023-08-10 05:00:18', '2023-08-14 11:21:22'),
(172, 'storefront_vertical_products_2_products_limit', 0, 's:1:\"9\";', '2023-08-10 05:00:18', '2023-08-11 07:26:25'),
(173, 'storefront_vertical_products_3_title', 0, 's:16:\"Wedding Garlands\";', '2023-08-10 05:00:18', '2023-08-14 05:43:21'),
(174, 'storefront_vertical_products_3_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:18', '2023-08-11 07:26:25'),
(175, 'storefront_vertical_products_3_category_id', 0, 's:1:\"2\";', '2023-08-10 05:00:18', '2023-08-14 05:43:21'),
(176, 'storefront_vertical_products_3_products_limit', 0, 's:1:\"9\";', '2023-08-10 05:00:18', '2023-08-11 07:26:25'),
(177, 'storefront_two_column_banners_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:18', '2023-08-14 07:46:46'),
(178, 'storefront_two_column_banners_1_call_to_action_url', 0, 's:38:\"/categories/festival-garlands/products\";', '2023-08-10 05:00:18', '2023-10-17 14:08:04'),
(179, 'storefront_two_column_banners_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:18', '2023-08-10 05:00:18'),
(180, 'storefront_two_column_banners_2_call_to_action_url', 0, 's:37:\"/categories/wedding-garlands/products\";', '2023-08-10 05:00:18', '2023-10-17 14:08:04'),
(181, 'storefront_two_column_banners_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:18', '2023-08-10 05:00:18'),
(182, 'storefront_product_grid_section_enabled', 0, 's:1:\"0\";', '2023-08-10 05:00:18', '2023-10-17 08:45:03'),
(183, 'storefront_product_grid_section_tab_1_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:18', '2023-08-11 07:57:14'),
(184, 'storefront_product_grid_section_tab_1_category_id', 0, 's:1:\"1\";', '2023-08-10 05:00:18', '2023-08-11 07:57:14'),
(185, 'storefront_product_grid_section_tab_1_products_limit', 0, 's:2:\"10\";', '2023-08-10 05:00:18', '2023-08-22 05:58:05'),
(186, 'storefront_product_grid_section_tab_2_product_type', 0, 'N;', '2023-08-10 05:00:18', '2023-08-22 05:58:05'),
(187, 'storefront_product_grid_section_tab_2_category_id', 0, 'N;', '2023-08-10 05:00:19', '2023-08-14 07:05:24'),
(188, 'storefront_product_grid_section_tab_2_products_limit', 0, 's:1:\"4\";', '2023-08-10 05:00:19', '2023-08-11 07:57:15'),
(189, 'storefront_product_grid_section_tab_3_product_type', 0, 'N;', '2023-08-10 05:00:19', '2023-08-22 05:58:05'),
(190, 'storefront_product_grid_section_tab_3_category_id', 0, 'N;', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(191, 'storefront_product_grid_section_tab_3_products_limit', 0, 's:1:\"4\";', '2023-08-10 05:00:19', '2023-08-11 07:57:15'),
(192, 'storefront_product_grid_section_tab_4_product_type', 0, 'N;', '2023-08-10 05:00:19', '2023-08-22 05:58:06'),
(193, 'storefront_product_grid_section_tab_4_category_id', 0, 'N;', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(194, 'storefront_product_grid_section_tab_4_products_limit', 0, 'N;', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(195, 'storefront_three_column_banners_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:19', '2023-08-14 05:51:24'),
(196, 'storefront_three_column_banners_1_call_to_action_url', 0, 's:40:\"/categories/devotional-garlands/products\";', '2023-08-10 05:00:19', '2023-10-17 14:08:04'),
(197, 'storefront_three_column_banners_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(198, 'storefront_three_column_banners_2_call_to_action_url', 0, 's:30:\"/categories/pre-order/products\";', '2023-08-10 05:00:19', '2023-10-17 14:08:04'),
(199, 'storefront_three_column_banners_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(200, 'storefront_three_column_banners_3_call_to_action_url', 0, 's:35:\"/categories/combo-IB1js2MR/products\";', '2023-08-10 05:00:19', '2023-10-17 14:08:04'),
(201, 'storefront_three_column_banners_3_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(202, 'storefront_product_tabs_2_section_enabled', 0, 's:1:\"0\";', '2023-08-10 05:00:19', '2023-08-14 05:43:21'),
(203, 'storefront_product_tabs_2_section_tab_1_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:19', '2023-08-11 07:59:20'),
(204, 'storefront_product_tabs_2_section_tab_1_category_id', 0, 's:1:\"1\";', '2023-08-10 05:00:19', '2023-08-11 07:59:20'),
(205, 'storefront_product_tabs_2_section_tab_1_products_limit', 0, 's:1:\"2\";', '2023-08-10 05:00:19', '2023-08-11 07:59:20'),
(206, 'storefront_product_tabs_2_section_tab_2_product_type', 0, 's:24:\"recently_viewed_products\";', '2023-08-10 05:00:19', '2023-08-11 07:59:20'),
(207, 'storefront_product_tabs_2_section_tab_2_category_id', 0, 'N;', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(208, 'storefront_product_tabs_2_section_tab_2_products_limit', 0, 's:1:\"2\";', '2023-08-10 05:00:19', '2023-08-11 07:59:20'),
(209, 'storefront_product_tabs_2_section_tab_3_product_type', 0, 's:24:\"recently_viewed_products\";', '2023-08-10 05:00:20', '2023-08-11 07:59:20'),
(210, 'storefront_product_tabs_2_section_tab_3_category_id', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(211, 'storefront_product_tabs_2_section_tab_3_products_limit', 0, 's:1:\"2\";', '2023-08-10 05:00:20', '2023-08-11 07:59:20'),
(212, 'storefront_product_tabs_2_section_tab_4_product_type', 0, 's:24:\"recently_viewed_products\";', '2023-08-10 05:00:20', '2023-08-11 07:59:20'),
(213, 'storefront_product_tabs_2_section_tab_4_category_id', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(214, 'storefront_product_tabs_2_section_tab_4_products_limit', 0, 's:1:\"2\";', '2023-08-10 05:00:20', '2023-08-11 07:59:20'),
(215, 'storefront_one_column_banner_enabled', 0, 's:1:\"0\";', '2023-08-10 05:00:20', '2023-08-14 05:43:21'),
(216, 'storefront_one_column_banner_call_to_action_url', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(217, 'storefront_one_column_banner_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(218, 'storefront_footer_tags', 0, 'a:2:{i:0;s:1:\"1\";i:1;s:1:\"2\";}', '2023-08-10 05:00:20', '2023-08-11 05:31:13'),
(219, 'storefront_featured_categories_section_category_1_products', 0, 'a:6:{i:0;s:1:\"4\";i:1;s:1:\"7\";i:2;s:1:\"8\";i:3;s:2:\"10\";i:4;s:1:\"5\";i:5;s:1:\"1\";}', '2023-08-10 05:00:20', '2023-08-14 11:54:30'),
(220, 'storefront_featured_categories_section_category_2_products', 0, 'a:10:{i:0;s:1:\"1\";i:1;s:2:\"10\";i:2;s:1:\"8\";i:3;s:2:\"16\";i:4;s:1:\"5\";i:5;s:1:\"7\";i:6;s:1:\"4\";i:7;s:2:\"11\";i:8;s:1:\"3\";i:9;s:1:\"2\";}', '2023-08-10 05:00:20', '2023-08-14 11:35:08'),
(221, 'storefront_featured_categories_section_category_3_products', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(222, 'storefront_featured_categories_section_category_4_products', 0, 'a:7:{i:0;s:1:\"1\";i:1;s:1:\"3\";i:2;s:1:\"2\";i:3;s:1:\"8\";i:4;s:1:\"5\";i:5;s:1:\"7\";i:6;s:2:\"10\";}', '2023-08-10 05:00:20', '2023-08-14 11:36:18'),
(223, 'storefront_featured_categories_section_category_5_products', 0, 'a:1:{i:0;s:1:\"1\";}', '2023-08-10 05:00:20', '2023-08-10 11:50:28'),
(224, 'storefront_featured_categories_section_category_6_products', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(225, 'storefront_product_tabs_1_section_tab_1_products', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(226, 'storefront_product_tabs_1_section_tab_2_products', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(227, 'storefront_product_tabs_1_section_tab_3_products', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(228, 'storefront_product_tabs_1_section_tab_4_products', 0, 'a:9:{i:0;s:1:\"1\";i:1;s:2:\"10\";i:2;s:1:\"5\";i:3;s:1:\"7\";i:4;s:1:\"4\";i:5;s:1:\"3\";i:6;s:1:\"8\";i:7;s:2:\"17\";i:8;s:1:\"2\";}', '2023-08-10 05:00:20', '2023-08-14 12:28:27'),
(229, 'storefront_vertical_products_1_products', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(230, 'storefront_vertical_products_2_products', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(231, 'storefront_vertical_products_3_products', 0, 'N;', '2023-08-10 05:00:20', '2023-08-10 05:00:20'),
(232, 'storefront_product_grid_section_tab_1_products', 0, 'N;', '2023-08-10 05:00:21', '2023-08-10 05:00:21'),
(233, 'storefront_product_grid_section_tab_2_products', 0, 'N;', '2023-08-10 05:00:21', '2023-08-10 05:00:21'),
(234, 'storefront_product_grid_section_tab_3_products', 0, 'N;', '2023-08-10 05:00:21', '2023-08-10 05:00:21'),
(235, 'storefront_product_grid_section_tab_4_products', 0, 'N;', '2023-08-10 05:00:21', '2023-08-10 05:00:21'),
(236, 'storefront_product_tabs_2_section_tab_1_products', 0, 'N;', '2023-08-10 05:00:21', '2023-08-10 05:00:21'),
(237, 'storefront_product_tabs_2_section_tab_2_products', 0, 'N;', '2023-08-10 05:00:21', '2023-08-10 05:00:21'),
(238, 'storefront_product_tabs_2_section_tab_3_products', 0, 'N;', '2023-08-10 05:00:21', '2023-08-10 05:00:21'),
(239, 'storefront_product_tabs_2_section_tab_4_products', 0, 'N;', '2023-08-10 05:00:21', '2023-08-10 05:00:21'),
(240, 'storefront_header_logo', 1, NULL, '2023-08-10 10:23:22', '2023-08-10 10:23:22'),
(241, 'storefront_favicon', 0, 's:3:\"225\";', '2023-08-10 10:23:23', '2023-10-17 14:15:23'),
(242, 'storefront_accepted_payment_methods_image', 0, 'N;', '2023-08-10 10:23:23', '2023-08-14 04:55:01'),
(243, 'storefront_three_column_full_width_banners_background_file_id', 0, 'N;', '2023-08-10 10:23:24', '2023-08-14 06:11:31'),
(244, 'maintenance_mode', 0, 's:1:\"0\";', '2023-08-10 12:11:31', '2023-10-20 06:38:38'),
(245, 'store_tagline', 1, NULL, '2023-08-10 12:11:31', '2023-08-10 12:11:31'),
(246, 'bank_transfer_instructions', 1, NULL, '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(247, 'check_payment_instructions', 1, NULL, '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(248, 'store_address_1', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(249, 'store_address_2', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(250, 'store_city', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(251, 'store_country', 0, 's:2:\"MY\";', '2023-08-10 12:11:32', '2023-08-11 05:41:39'),
(252, 'store_state', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(253, 'store_zip', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(254, 'store_phone_hide', 0, 's:1:\"0\";', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(255, 'store_email_hide', 0, 's:1:\"0\";', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(256, 'currency_rate_exchange_service', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(257, 'fixer_access_key', 0, 'N;', '2023-08-10 12:11:32', '2023-08-17 07:19:39'),
(258, 'forge_api_key', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(259, 'currency_data_feed_api_key', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(260, 'auto_refresh_currency_rates', 0, 's:1:\"0\";', '2023-08-10 12:11:33', '2023-08-17 07:19:39'),
(261, 'auto_refresh_currency_rate_frequency', 0, 's:5:\"daily\";', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(262, 'sms_from', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(263, 'sms_service', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(264, 'vonage_key', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(265, 'vonage_secret', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(266, 'twilio_sid', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(267, 'twilio_token', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(268, 'welcome_sms', 0, 's:1:\"0\";', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(269, 'new_order_admin_sms', 0, 's:1:\"0\";', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(270, 'new_order_sms', 0, 's:1:\"0\";', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(271, 'mail_from_address', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(272, 'mail_from_name', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(273, 'mail_host', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(274, 'mail_port', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(275, 'mail_username', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(276, 'mail_password', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(277, 'mail_encryption', 0, 'N;', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(278, 'welcome_email', 0, 's:1:\"0\";', '2023-08-10 12:11:33', '2023-08-10 12:11:33'),
(279, 'admin_order_email', 0, 's:1:\"0\";', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(280, 'invoice_email', 0, 's:1:\"0\";', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(281, 'mailchimp_api_key', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(282, 'mailchimp_list_id', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(283, 'custom_header_assets', 0, 's:5962:\"<style>\r\n.so-panel.widget.widget_media_image.panel-first-child.panel-last-child {\r\n  display: flex;\r\n  flex-direction: row;\r\n  justify-content: space-between;\r\n\r\n}\r\n.about_img{\r\nmargin: 0 10px;\r\n}\r\n\r\n@media screen and (max-width: 1100px) {\r\n  .so-panel.widget.widget_media_image.panel-first-child.panel-last-child {\r\n    flex-direction: column;\r\n  }\r\n.about_img{\r\nmargin: 10px 0;\r\n    width: 100%;\r\n}\r\n}\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n/* For Top Navigation */\r\n.header-column-right .header {\r\n    display: flex;\r\n}\r\n\r\n.header-column-right .header .menu-link {\r\n    display: flex;\r\n    margin-left: 35px;\r\n    justify-content: center;\r\n    align-items: center;\r\n}\r\n\r\n.menu-link span {\r\n    color: #000;\r\n}\r\n\r\n.header-column-right .menu-link:hover .icon-wrap>i,\r\n .header-column-right .menu-link:hover>span {\r\n    color: #0068e1;\r\n    color: var(--color-primary);\r\n}\r\n\r\n.view-menu {\r\n    display: block;\r\n    position: absolute;\r\n    top: 50px;\r\n    right: 23px;\r\n    background: rgb(249, 249, 249);\r\n}\r\n\r\n.quick-menu {\r\n    display: flex;\r\n    justify-content: center;\r\n    align-items: center;\r\n    margin-left: 35px;\r\n}\r\n\r\n.header-logo {\r\n  width: 115px !important\r\n}\r\n\r\n.header-column-right .icon-wrap>i{\r\n font-size:24px;\r\n}\r\n\r\n.header-column-right .icon-wrap>.count {\r\n  width: 16px;\r\n  height: 16px;\r\n  line-height: 18px;\r\n}\r\n\r\n.header-column-right .icon-wrap>i{\r\n font-size:24px;\r\n}\r\n\r\n.header-column-right .icon-wrap>.count {\r\n  width: 16px;\r\n  height: 16px;\r\n  line-height: 18px;\r\n}\r\n\r\n.shadow-effect {\r\n            background: #fff;\r\n            padding: 20px;\r\n            border-radius: 4px;\r\n            text-align: center;\r\n            border: 1px solid #ECECEC;\r\n            box-shadow: 0 19px 38px rgba(0, 0, 0, 0.10), 0 15px 12px rgba(0, 0, 0, 0.02);\r\n        }\r\n\r\n        #testimonials-list .shadow-effect p {\r\n            font-family: inherit;\r\n            font-size: 17px;\r\n            line-height: 1.5;\r\n            margin: 0 0 17px 0;\r\n            font-weight: 300;\r\n        }\r\n\r\n        .testimonial-name {\r\n            margin: -17px auto 0;\r\n            display: table;\r\n            width: auto;\r\n            background: #3190E7;\r\n            padding: 9px 35px;\r\n            border-radius: 12px;\r\n            text-align: center;\r\n            color: #fff;\r\n            box-shadow: 0 9px 18px rgba(0, 0, 0, 0.12), 0 5px 7px rgba(0, 0, 0, 0.05);\r\n        }\r\n\r\n        #testimonials-list .item {\r\n            text-align: center;\r\n            padding: 50px;\r\n            margin-bottom: 80px;\r\n            opacity: .2;\r\n            -webkit-transform: scale3d(0.8, 0.8, 1);\r\n            transform: scale3d(0.8, 0.8, 1);\r\n            transition: all 0.3s ease-in-out;\r\n        }\r\n\r\n        #testimonials-list .owl-item.active.center .item {\r\n            opacity: 1;\r\n            -webkit-transform: scale3d(1.0, 1.0, 1);\r\n            transform: scale3d(1.0, 1.0, 1);\r\n        }\r\n\r\n        .owl-carousel .owl-item img {\r\n           \r\n           \r\n            max-width: 180px;\r\n            max-hight:180px\r\n            border-radius: 50%;\r\n            margin: 0 auto 20px;\r\n        }\r\n\r\n        #testimonials-list.owl-carousel .owl-dots .owl-dot.active span,\r\n        #testimonials-list.owl-carousel .owl-dots .owl-dot:hover span {\r\n            background: #3190E7;\r\n            -webkit-transform: translate3d(0px, -50%, 0px) scale(0.7);\r\n            transform: translate3d(0px, -50%, 0px) scale(0.7);\r\n        }\r\n\r\n        #testimonials-list.owl-carousel .owl-dots {\r\n            display: inline-block;\r\n            width: 100%;\r\n            text-align: center;\r\n        }\r\n\r\n        #testimonials-list.owl-carousel .owl-dots .owl-dot {\r\n            display: inline-block;\r\n        }\r\n\r\n        #testimonials-list.owl-carousel .owl-dots .owl-dot span {\r\n            background: #3190E7;\r\n            display: inline-block;\r\n            height: 20px;\r\n            margin: 0 2px 5px;\r\n            -webkit-transform: translate3d(0px, -50%, 0px) scale(0.3);\r\n            transform: translate3d(0px, -50%, 0px) scale(0.3);\r\n            -webkit-transform-origin: 50% 50% 0;\r\n            transform-origin: 50% 50% 0;\r\n            transition: all 250ms ease-out 0s;\r\n            width: 20px;\r\n        }\r\n\r\n\r\n\r\n.Popup::before {\r\n    content: \' \';\r\n    background: #5f5a5a38;\r\n    height: 100%;\r\n    width: 100%;\r\n    position: fixed;\r\n    top: 0;\r\n    left: 0;\r\n    right: 0;\r\n    bottom: 0;\r\n    z-index: -1;\r\n}\r\n\r\n\r\n.Popup {\r\n   display: none;\r\n    position: absolute;\r\n    top: 50%;\r\n    left: 50%;\r\n    padding: 15px;\r\n    z-index: 10010;\r\n    transform: translate(-50%, -150%);\r\n    border-radius: 5px;\r\n    background: #fff;\r\n    width: 500px;\r\n}\r\n\r\n.Popup .header {\r\n    display: flex;\r\n    width: 100%;\r\n    justify-content: space-between;\r\n    align-items: center;\r\n}\r\n\r\n.Popup .body {\r\n  padding: 20px 0;\r\n}\r\n\r\n.Popup .body textarea {\r\n    width: 100%;\r\n    border: none;\r\n    border-radius: 3px;\r\n    margin-bottom: 10px;\r\n}\r\n\r\n.Popup .body .btn {\r\n    display: flex;\r\n    justify-content: center;\r\n    align-items: center;\r\n}\r\n\r\n.Popup .body .btn button {\r\n   width: 100px;\r\n    border: none;\r\n    border-radius: 3px;\r\n}\r\n\r\n\r\n\r\n\r\n.header-column-right .header {\r\n    display: flex;\r\n}\r\n\r\n\r\n.header-column-right .header .menu-link {\r\n    display: flex;\r\n    margin-left: 35px;\r\n    justify-content: center;\r\n    align-items: center;\r\n}\r\n\r\n.menu-link span {\r\n    color: #000;\r\n}\r\n\r\n\r\n\r\n\r\n.view-menu {\r\n    display: block;\r\n    position: absolute;\r\n    top: 50px;\r\n    right: 23px;\r\n    background: rgb(249, 249, 249);\r\n}\r\n\r\n.quick-menu {\r\n    display: flex;\r\n    justify-content: center;\r\n    align-items: center;\r\n    margin-left: 35px;\r\n}\r\n\r\n.header-logo {\r\n  width: 146px !important\r\n}\r\n .header-column-right .menu-link:hover>span {\r\n    color: #0068e1;\r\n    color: var(--color-primary);\r\n}\r\n\r\n.header-column-right .icon-wrap>i{\r\n font-size:24px;\r\n}\r\n\r\n.header-column-right .icon-wrap>.count {\r\n  width: 16px;\r\n  height: 16px;\r\n  line-height: 18px;\r\n}\r\n</style>\";', '2023-08-10 12:11:34', '2023-09-13 14:47:26'),
(284, 'custom_footer_assets', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(285, 'facebook_login_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(286, 'facebook_login_app_id', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(287, 'facebook_login_app_secret', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(288, 'google_login_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(289, 'google_login_client_id', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(290, 'google_login_client_secret', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(291, 'free_shipping_enabled', 0, 's:1:\"1\";', '2023-08-10 12:11:34', '2023-08-28 07:58:59'),
(292, 'free_shipping_min_amount', 0, 's:2:\"80\";', '2023-08-10 12:11:34', '2023-08-11 05:41:40'),
(293, 'local_pickup_enabled', 0, 's:1:\"1\";', '2023-08-10 12:11:34', '2023-08-28 07:58:59'),
(294, 'flat_rate_enabled', 0, 's:1:\"1\";', '2023-08-10 12:11:34', '2023-09-23 11:02:42'),
(295, 'paypal_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(296, 'paypal_test_mode', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(297, 'paypal_client_id', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(298, 'paypal_secret', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(299, 'stripe_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(300, 'stripe_publishable_key', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(301, 'stripe_secret_key', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(302, 'paytm_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(303, 'paytm_test_mode', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(304, 'paytm_merchant_id', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(305, 'paytm_merchant_key', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(306, 'razorpay_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(307, 'razorpay_key_id', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(308, 'razorpay_key_secret', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(309, 'instamojo_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(310, 'instamojo_test_mode', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(311, 'instamojo_api_key', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(312, 'instamojo_auth_token', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(313, 'paystack_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(314, 'paystack_test_mode', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(315, 'paystack_public_key', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(316, 'paystack_secret_key', 0, 'N;', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(317, 'authorizenet_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(318, 'authorizenet_test_mode', 0, 's:1:\"0\";', '2023-08-10 12:11:35', '2023-08-10 12:11:35'),
(319, 'authorizenet_merchant_login_id', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(320, 'authorizenet_merchant_transaction_key', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(321, 'mercadopago_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(322, 'mercadopago_test_mode', 0, 's:1:\"0\";', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(323, 'mercadopago_supported_currency', 0, 's:3:\"UYU\";', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(324, 'mercadopago_public_key', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(325, 'mercadopago_access_token', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(326, 'flutterwave_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(327, 'flutterwave_test_mode', 0, 's:1:\"0\";', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(328, 'flutterwave_public_key', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(329, 'flutterwave_secret_key', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(330, 'flutterwave_encryption_key', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(331, 'cod_enabled', 0, 's:1:\"1\";', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(332, 'bank_transfer_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:36', '2023-11-09 15:32:59'),
(333, 'check_payment_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:36', '2023-11-09 15:32:59'),
(334, 'sms_order_statuses', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(335, 'email_order_statuses', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(336, 'storefront_mail_logo', 1, NULL, '2023-08-14 13:01:26', '2023-08-14 13:01:26'),
(337, 'enable_bday_points', 0, 's:1:\"1\";', '2023-09-04 11:31:31', '2023-09-04 11:31:31'),
(338, 'enable_show_customer_points', 0, 's:1:\"0\";', '2023-09-04 11:31:31', '2023-09-04 11:31:31'),
(339, 'enable_show_points_with_order', 0, 's:1:\"0\";', '2023-09-04 11:31:31', '2023-09-04 11:31:31'),
(340, 'enable_show_points_by_mail', 0, 's:1:\"0\";', '2023-09-04 11:31:31', '2023-09-04 11:31:31'),
(341, 'enable_give_old_order_points', 0, 's:1:\"1\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(342, 'enable_remove_points_order_refund', 0, 's:1:\"1\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(343, 'add_days_reward_points_expiry', 0, 's:2:\"10\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(344, 'add_days_reward_points_assignment', 0, 's:1:\"1\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(345, 'use_points_per_order', 0, 's:2:\"50\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(346, 'min_order_cart_value_redemption', 0, 's:3:\"150\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(347, 'currency_value', 0, 's:2:\"10\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(348, 'point_value', 0, 's:1:\"1\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(349, 'redemption_point_value', 0, 's:2:\"10\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(350, 'redemption_currency_value', 0, 's:1:\"1\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(351, 'epoint_first_signup_value', 0, 's:2:\"50\";', '2023-09-04 11:31:31', '2023-09-04 12:50:08'),
(352, 'epoint_ref_point_value', 0, 's:1:\"0\";', '2023-09-04 11:31:31', '2023-09-04 11:31:31'),
(353, 'epoint_forder_point_value', 0, 's:2:\"50\";', '2023-09-04 11:31:31', '2023-09-04 12:50:09'),
(354, 'epoint_freview_point_value', 0, 's:2:\"50\";', '2023-09-04 11:31:31', '2023-09-04 12:50:09'),
(355, 'epoint_fpay_point_value', 0, 's:2:\"50\";', '2023-09-04 11:31:31', '2023-09-04 12:50:09'),
(356, 'epoint_bday_point_value', 0, 's:2:\"50\";', '2023-09-04 11:31:31', '2023-09-04 12:50:09'),
(357, 'testimonial_slider_enabled', 0, 's:1:\"1\";', '2023-09-06 06:59:07', '2023-11-17 10:44:32'),
(358, 'my_testimonial_enabled', 0, 's:1:\"1\";', '2023-09-06 06:59:08', '2023-09-28 11:35:46'),
(359, 'razerpay_label', 1, NULL, '2023-09-23 10:26:39', '2023-09-23 10:26:39'),
(360, 'razerpay_description', 1, NULL, '2023-09-23 10:26:39', '2023-09-23 10:26:39'),
(361, 'razerpay_enabled', 0, 's:1:\"1\";', '2023-09-23 10:26:40', '2023-09-23 10:38:25'),
(362, 'razerpay_test_mode', 0, 's:1:\"1\";', '2023-09-23 10:26:40', '2023-09-23 10:38:25'),
(363, 'razerpay_key_id', 0, 's:32:\"8ba1cdaca1c7f682a946588da20af3ca\";', '2023-09-23 10:26:40', '2023-09-23 10:38:25'),
(364, 'razerpay_key_secret', 0, 's:32:\"feec60f8de5da1639d47507400108f56\";', '2023-09-23 10:26:40', '2023-09-23 10:38:25'),
(365, 'razerpay_url', 0, 's:43:\"https://sandbox.merchant.razer.com/RMS/pay/\";', '2023-09-23 10:26:40', '2023-09-23 10:38:25'),
(366, 'razerpay_merchant_id', 0, 's:18:\"SB_lotusflowergift\";', '2023-09-23 10:26:40', '2023-09-23 10:38:25'),
(367, 'razerpay_instructions', 0, 's:134:\"Make your payment  using Razer Merchant Service by  directly  into our bank account. Please use your Order ID as the payment reference\";', '2023-09-23 10:26:40', '2023-09-23 10:38:25'),
(368, 'galleries_enabled', 0, 's:1:\"1\";', '2023-09-27 09:48:42', '2023-11-11 07:27:35'),
(369, 'rewardpoints_enabled', 0, 's:1:\"1\";', '2023-10-07 09:23:09', '2023-11-01 11:09:43'),
(370, 'recurring_order_enabled', 0, 's:1:\"1\";', '2023-10-07 09:23:09', '2023-11-09 15:32:58');

-- --------------------------------------------------------

--
-- Table structure for table `setting_translations`
--

CREATE TABLE `setting_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `setting_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `value` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `setting_translations`
--

INSERT INTO `setting_translations` (`id`, `setting_id`, `locale`, `value`) VALUES
(1, 1, 'en', 's:12:\"APS Garlands\";'),
(2, 23, 'en', 's:13:\"Free Shipping\";'),
(3, 24, 'en', 's:12:\"Local Pickup\";'),
(4, 25, 'en', 's:9:\"Flat Rate\";'),
(5, 26, 'en', 's:6:\"PayPal\";'),
(6, 27, 'en', 's:28:\"Pay via your PayPal account.\";'),
(7, 28, 'en', 's:6:\"Stripe\";'),
(8, 29, 'en', 's:29:\"Pay via credit or debit card.\";'),
(9, 30, 'en', 's:5:\"Paytm\";'),
(10, 31, 'en', 's:103:\"The best payment gateway provider in India for e-payment through credit card, debit card & net banking.\";'),
(11, 32, 'en', 's:8:\"Razorpay\";'),
(12, 33, 'en', 's:74:\"Pay securely by Credit or Debit card or Internet Banking through Razorpay.\";'),
(13, 34, 'en', 's:9:\"Instamojo\";'),
(14, 35, 'en', 's:16:\"CC/DB/NB/Wallets\";'),
(15, 36, 'en', 's:13:\"Authorize.net\";'),
(16, 37, 'en', 's:33:\"Accept payments anytime, anywhere\";'),
(17, 38, 'en', 's:8:\"Paystack\";'),
(18, 39, 'en', 's:45:\"Modern online and offline payments for Africa\";'),
(19, 40, 'en', 's:11:\"Flutterwave\";'),
(20, 41, 'en', 's:40:\"Endless possibilities for every business\";'),
(21, 42, 'en', 's:12:\"Mercado Pago\";'),
(22, 43, 'en', 's:36:\"From now on, do more with your money\";'),
(23, 44, 'en', 's:16:\"Cash On Delivery\";'),
(24, 45, 'en', 's:28:\"Pay with cash upon delivery.\";'),
(25, 46, 'en', 's:13:\"Bank Transfer\";'),
(26, 47, 'en', 's:100:\"Make your payment directly into our bank account. Please use your Order ID as the payment reference.\";'),
(27, 48, 'en', 's:19:\"Check / Money Order\";'),
(28, 49, 'en', 's:33:\"Please send a check to our store.\";'),
(29, 51, 'en', 's:40:\"🌟 Discover the Magic of Garlands!🌟\";'),
(30, 52, 'en', 's:92:\"No 66, Jalan Padang Belia brickfields  50470 brickfields, Kuala Lumpur.  HQ - +6012 357 0799\";'),
(31, 53, 'en', 'N;'),
(32, 54, 'en', 's:4:\"Help\";'),
(33, 55, 'en', 's:4:\"Info\";'),
(34, 50, 'en', 's:92:\"Copyright © <a href=\"{{ store_url }}\">{{ store_name }}</a> {{ year }}. All rights reserved.\";'),
(35, 56, 'en', 's:22:\"Delivery 7 Days A Week\";'),
(36, 57, 'en', 's:26:\"Choose your preferred date\";'),
(37, 58, 'en', 's:29:\"Order Before 9pm For Next Day\";'),
(38, 59, 'en', 's:44:\"Same day also available on selected Garlands\";'),
(39, 60, 'en', 's:16:\"Flower Freshness\";'),
(40, 61, 'en', 's:25:\"7 day freshness guarantee\";'),
(41, 62, 'en', 's:36:\"Rated 4.1 out of 5 on Google Reviews\";'),
(42, 63, 'en', 's:24:\"With over 31,000 reviews\";'),
(43, 64, 'en', 's:27:\"100% Safe & Secure Payments\";'),
(44, 65, 'en', 's:32:\"Pay using secure payment methods\";'),
(45, 66, 'en', 's:3:\"105\";'),
(46, 67, 'en', 's:2:\"72\";'),
(47, 68, 'en', 's:2:\"61\";'),
(48, 69, 'en', 's:2:\"94\";'),
(49, 70, 'en', 's:2:\"92\";'),
(50, 71, 'en', 's:2:\"94\";'),
(51, 72, 'en', 's:36:\"Top Categories in Sales and Trending\";'),
(52, 73, 'en', 's:285:\"The tradition of varamala (garland for the bridegroom) originated from the ancient ritual of svayamvara (the act of selecting a groom by self-choice), a type of marriage where a princess selected her husband from a public assembly of suitors by placing a flower garland around his neck\";'),
(53, 74, 'en', 's:8:\"Featured\";'),
(54, 75, 'en', 's:15:\"Latest Products\";'),
(55, 76, 'en', 's:15:\"Recently Viewed\";'),
(56, 77, 'en', 's:15:\"Custom Products\";'),
(57, 78, 'en', 's:3:\"111\";'),
(58, 79, 'en', 's:3:\"104\";'),
(59, 80, 'en', 's:4:\"test\";'),
(60, 81, 'en', 'N;'),
(61, 82, 'en', 'N;'),
(62, 83, 'en', 'N;'),
(63, 84, 'en', 's:2:\"93\";'),
(64, 85, 'en', 's:2:\"98\";'),
(65, 86, 'en', 's:3:\"223\";'),
(66, 87, 'en', 's:21:\"Fantastic Diwali Sale\";'),
(67, 88, 'en', 's:5:\"TEST2\";'),
(68, 89, 'en', 's:5:\"TEST2\";'),
(69, 90, 'en', 's:5:\"TEST2\";'),
(70, 91, 'en', 's:5:\"TEST2\";'),
(71, 92, 'en', 's:2:\"76\";'),
(72, 240, 'en', 's:3:\"225\";'),
(73, 245, 'en', 'N;'),
(74, 246, 'en', 's:100:\"Make your payment directly into our bank account. Please use your Order ID as the payment reference.\";'),
(75, 247, 'en', 's:33:\"Please send a check to our store.\";'),
(76, 336, 'en', 's:3:\"225\";'),
(77, 359, 'en', 's:23:\"Razer Merchant Services\";'),
(78, 360, 'en', 's:23:\"RMS Payment Integration\";');

-- --------------------------------------------------------

--
-- Table structure for table `sliders`
--

CREATE TABLE `sliders` (
  `id` int(10) UNSIGNED NOT NULL,
  `speed` int(11) DEFAULT NULL,
  `autoplay` tinyint(1) DEFAULT NULL,
  `autoplay_speed` int(11) DEFAULT NULL,
  `fade` tinyint(1) NOT NULL DEFAULT 0,
  `dots` tinyint(1) DEFAULT NULL,
  `arrows` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sliders`
--

INSERT INTO `sliders` (`id`, `speed`, `autoplay`, `autoplay_speed`, `fade`, `dots`, `arrows`, `created_at`, `updated_at`) VALUES
(1, 100, 1, 3000, 1, 1, 1, '2023-08-10 10:54:54', '2023-08-10 10:54:54'),
(2, NULL, 1, 3000, 0, 1, 1, '2023-08-10 11:01:03', '2023-08-10 11:01:03'),
(3, NULL, 1, 3000, 0, 1, 1, '2023-08-12 08:17:18', '2023-08-12 08:17:18');

-- --------------------------------------------------------

--
-- Table structure for table `slider_slides`
--

CREATE TABLE `slider_slides` (
  `id` int(10) UNSIGNED NOT NULL,
  `slider_id` int(10) UNSIGNED NOT NULL,
  `options` text DEFAULT NULL,
  `call_to_action_url` varchar(191) DEFAULT NULL,
  `open_in_new_window` tinyint(1) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `slider_slides`
--

INSERT INTO `slider_slides` (`id`, `slider_id`, `options`, `call_to_action_url`, `open_in_new_window`, `position`, `created_at`, `updated_at`) VALUES
(1, 1, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', NULL, 1, 0, '2023-08-10 10:54:54', '2023-08-10 10:54:54'),
(2, 1, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', NULL, 1, 1, '2023-08-10 10:54:54', '2023-08-10 10:54:54'),
(3, 1, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', NULL, 1, 2, '2023-08-10 10:54:54', '2023-08-10 10:54:54'),
(4, 2, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', NULL, 1, 0, '2023-08-10 11:01:03', '2023-08-10 11:01:03'),
(5, 2, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', NULL, 1, 1, '2023-08-10 11:01:04', '2023-08-10 11:01:04'),
(11, 3, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', '/categories/main-garland/products', 0, 3, '2023-08-14 04:46:27', '2023-10-17 14:10:12'),
(18, 3, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', '/categories/hand-bouquet/products', 0, 1, '2023-08-14 05:16:17', '2023-10-17 14:10:12'),
(19, 3, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', '/categories/hand-bouquet-1yQ0zKX4/products', 0, 0, '2023-08-14 09:46:49', '2023-10-17 14:10:12'),
(20, 3, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', '/categories/bouquet/products', 0, 2, '2023-08-14 09:46:50', '2023-10-17 14:10:12');

-- --------------------------------------------------------

--
-- Table structure for table `slider_slide_translations`
--

CREATE TABLE `slider_slide_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `slider_slide_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `file_id` int(10) UNSIGNED DEFAULT NULL,
  `caption_1` varchar(191) DEFAULT NULL,
  `caption_2` varchar(191) DEFAULT NULL,
  `call_to_action_text` varchar(191) DEFAULT NULL,
  `direction` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `slider_slide_translations`
--

INSERT INTO `slider_slide_translations` (`id`, `slider_slide_id`, `locale`, `file_id`, `caption_1`, `caption_2`, `call_to_action_text`, `direction`) VALUES
(1, 1, 'en', 46, 'test1', 'test2', NULL, 'left'),
(2, 2, 'en', 32, 'test3', 'test4', NULL, 'left'),
(3, 3, 'en', 32, 'test5', 'test6', NULL, 'left'),
(4, 4, 'en', 33, 'test1', 'test2', NULL, 'left'),
(5, 5, 'en', 32, 'test3', 'test4', NULL, 'left'),
(11, 11, 'en', 224, NULL, NULL, NULL, 'right'),
(18, 18, 'en', 76, NULL, NULL, NULL, 'right'),
(19, 19, 'en', 222, NULL, NULL, NULL, 'right'),
(20, 20, 'en', 80, NULL, NULL, NULL, 'right');

-- --------------------------------------------------------

--
-- Table structure for table `slider_translations`
--

CREATE TABLE `slider_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `slider_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `slider_translations`
--

INSERT INTO `slider_translations` (`id`, `slider_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'aps garlands'),
(2, 2, 'en', 'Aps -g'),
(3, 3, 'en', 'aps');

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(191) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subscribers`
--

INSERT INTO `subscribers` (`id`, `email`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'prabakaranpbk@gmail.com', 1, '2023-11-01 14:03:15', '2023-11-01 14:03:15'),
(2, 'prabakaran@santhila.co', 1, '2023-11-01 14:04:53', '2023-11-01 14:04:53'),
(3, 'test@gm233.com', 1, '2023-11-03 08:16:36', '2023-11-03 08:16:36');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `slug`, `created_at`, `updated_at`) VALUES
(1, 'garlands', '2023-08-10 08:06:41', '2023-08-10 08:06:41'),
(2, 'saram-flowers', '2023-08-10 08:07:00', '2023-08-10 08:07:00'),
(3, 'flowers', '2023-08-14 10:11:06', '2023-08-14 10:11:06');

-- --------------------------------------------------------

--
-- Table structure for table `tag_translations`
--

CREATE TABLE `tag_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tag_translations`
--

INSERT INTO `tag_translations` (`id`, `tag_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'Garlands'),
(2, 2, 'en', 'Saram flowers'),
(3, 3, 'en', 'Flowers');

-- --------------------------------------------------------

--
-- Table structure for table `tax_classes`
--

CREATE TABLE `tax_classes` (
  `id` int(10) UNSIGNED NOT NULL,
  `based_on` varchar(191) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tax_classes`
--

INSERT INTO `tax_classes` (`id`, `based_on`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'shipping_address', NULL, '2023-08-12 07:48:11', '2023-08-12 07:48:11');

-- --------------------------------------------------------

--
-- Table structure for table `tax_class_translations`
--

CREATE TABLE `tax_class_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `tax_class_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `label` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tax_class_translations`
--

INSERT INTO `tax_class_translations` (`id`, `tax_class_id`, `locale`, `label`) VALUES
(1, 1, 'en', 'GST');

-- --------------------------------------------------------

--
-- Table structure for table `tax_rates`
--

CREATE TABLE `tax_rates` (
  `id` int(10) UNSIGNED NOT NULL,
  `tax_class_id` int(10) UNSIGNED NOT NULL,
  `country` varchar(191) NOT NULL,
  `state` varchar(191) NOT NULL,
  `city` varchar(191) NOT NULL,
  `zip` varchar(191) NOT NULL,
  `rate` decimal(8,4) UNSIGNED NOT NULL,
  `position` int(10) UNSIGNED NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tax_rates`
--

INSERT INTO `tax_rates` (`id`, `tax_class_id`, `country`, `state`, `city`, `zip`, `rate`, `position`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'MY', 'KUL', 'Kula Lumbur', '55100', '18.0000', 0, NULL, '2023-08-12 07:48:11', '2023-08-12 07:48:11'),
(2, 1, 'MY', 'KUL', 'Kuala Limbur', '55100', '12.0000', 1, NULL, '2023-08-12 07:48:11', '2023-08-12 07:48:11');

-- --------------------------------------------------------

--
-- Table structure for table `tax_rate_translations`
--

CREATE TABLE `tax_rate_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `tax_rate_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `tax_rate_translations`
--

INSERT INTO `tax_rate_translations` (`id`, `tax_rate_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'GST'),
(2, 2, 'en', 'GST');

-- --------------------------------------------------------

--
-- Table structure for table `templates`
--

CREATE TABLE `templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `slug` varchar(191) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `templates`
--

INSERT INTO `templates` (`id`, `slug`, `is_active`, `created_at`, `updated_at`) VALUES
(1, 'welcome-mail', 1, '2023-11-01 14:04:04', '2023-11-01 14:04:04');

-- --------------------------------------------------------

--
-- Table structure for table `template_translations`
--

CREATE TABLE `template_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `template_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `body` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `template_translations`
--

INSERT INTO `template_translations` (`id`, `template_id`, `locale`, `name`, `body`) VALUES
(1, 1, 'en', 'Welcome Mail', '<p>Welcome to APS&nbsp;</p>');

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`id`, `user_id`, `user_name`, `comment`, `is_active`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'Prabakaran', 'Positive Review:\r\n\r\n\"I\'m incredibly impressed with the service I received from this company. They went above and beyond to meet my needs and exceeded my expectations. I highly recommend them!\"\r\n\"The quat', 0, NULL, '2023-09-06 07:12:36', '2023-09-06 07:12:36'),
(2, 1, 'Prabakaran', 'Appreciation for Support:\r\n\r\n\"The customer support team is fantastic! They were patient and helped me resolve my issue quickly. Thank you for the excellent support!\"\r\n\"I want to express my gratitude\"', 1, NULL, '2023-09-06 07:14:49', '2023-09-06 09:48:20'),
(3, 1, 'Prabakaran', 'From Testing Branch \r\n\r\nThis command will combine the changes from the \"san\" branch into the \"testing\" branch. If there are any conflicts, Git will prompt you to resolve them. After resolving conflicts', 1, NULL, '2023-09-06 08:10:15', '2023-09-06 08:31:40'),
(4, 1, 'Sangeetha', 'Very Good', 1, NULL, '2023-09-06 09:51:03', '2023-09-06 09:53:43'),
(6, 1, 'Sabari', 'Creating clean and meaningful commit history: By staging and committing changes in a controlled manner, you can maintain a clean and meaningful history of your project\'s development, making it easier', 1, NULL, '2023-09-08 11:32:55', '2023-09-22 07:37:19'),
(7, 1, 'Navin', 'With this query, you can accurately calculate the points based on the scenario where claimed points are stored in separate rows, and unclaimed points can be utilized for multiple purchases if a reward', 1, NULL, '2023-09-08 14:47:02', '2023-09-22 07:37:27'),
(8, 6, 'sangeetha', 'Good', 0, NULL, '2023-11-17 11:47:11', '2023-11-17 11:47:11');

-- --------------------------------------------------------

--
-- Table structure for table `throttle`
--

CREATE TABLE `throttle` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `type` varchar(191) NOT NULL,
  `ip` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `throttle`
--

INSERT INTO `throttle` (`id`, `user_id`, `type`, `ip`, `created_at`, `updated_at`) VALUES
(1, NULL, 'global', NULL, '2023-08-10 07:59:11', '2023-08-10 07:59:11'),
(2, NULL, 'ip', '192.168.1.67', '2023-08-10 07:59:11', '2023-08-10 07:59:11'),
(3, 1, 'user', NULL, '2023-08-10 07:59:11', '2023-08-10 07:59:11'),
(4, NULL, 'global', NULL, '2023-08-10 08:02:47', '2023-08-10 08:02:47'),
(5, NULL, 'ip', '192.168.1.67', '2023-08-10 08:02:47', '2023-08-10 08:02:47'),
(6, 1, 'user', NULL, '2023-08-10 08:02:47', '2023-08-10 08:02:47'),
(7, NULL, 'global', NULL, '2023-08-10 08:03:26', '2023-08-10 08:03:26'),
(8, NULL, 'ip', '192.168.1.67', '2023-08-10 08:03:26', '2023-08-10 08:03:26'),
(9, 1, 'user', NULL, '2023-08-10 08:03:26', '2023-08-10 08:03:26'),
(10, NULL, 'global', NULL, '2023-08-10 08:03:46', '2023-08-10 08:03:46'),
(11, NULL, 'ip', '192.168.1.67', '2023-08-10 08:03:46', '2023-08-10 08:03:46'),
(12, 1, 'user', NULL, '2023-08-10 08:03:46', '2023-08-10 08:03:46'),
(13, NULL, 'global', NULL, '2023-08-12 03:55:32', '2023-08-12 03:55:32'),
(14, NULL, 'ip', '192.168.1.20', '2023-08-12 03:55:32', '2023-08-12 03:55:32'),
(15, 1, 'user', NULL, '2023-08-12 03:55:32', '2023-08-12 03:55:32'),
(16, NULL, 'global', NULL, '2023-08-12 03:55:37', '2023-08-12 03:55:37'),
(17, NULL, 'ip', '192.168.1.20', '2023-08-12 03:55:37', '2023-08-12 03:55:37'),
(18, 1, 'user', NULL, '2023-08-12 03:55:37', '2023-08-12 03:55:37'),
(19, NULL, 'global', NULL, '2023-08-12 03:55:42', '2023-08-12 03:55:42'),
(20, NULL, 'ip', '192.168.1.20', '2023-08-12 03:55:42', '2023-08-12 03:55:42'),
(21, 1, 'user', NULL, '2023-08-12 03:55:42', '2023-08-12 03:55:42'),
(22, NULL, 'global', NULL, '2023-08-16 05:22:28', '2023-08-16 05:22:28'),
(23, NULL, 'ip', '192.168.1.20', '2023-08-16 05:22:28', '2023-08-16 05:22:28'),
(24, 1, 'user', NULL, '2023-08-16 05:22:28', '2023-08-16 05:22:28'),
(25, NULL, 'global', NULL, '2023-08-17 10:41:13', '2023-08-17 10:41:13'),
(26, NULL, 'ip', '192.168.1.20', '2023-08-17 10:41:13', '2023-08-17 10:41:13'),
(27, NULL, 'global', NULL, '2023-08-22 05:39:58', '2023-08-22 05:39:58'),
(28, NULL, 'ip', '192.168.1.70', '2023-08-22 05:39:59', '2023-08-22 05:39:59'),
(29, 1, 'user', NULL, '2023-08-22 05:39:59', '2023-08-22 05:39:59'),
(30, NULL, 'global', NULL, '2023-08-24 05:52:45', '2023-08-24 05:52:45'),
(31, NULL, 'ip', '192.168.1.70', '2023-08-24 05:52:45', '2023-08-24 05:52:45'),
(32, 1, 'user', NULL, '2023-08-24 05:52:45', '2023-08-24 05:52:45'),
(33, NULL, 'global', NULL, '2023-08-24 09:45:52', '2023-08-24 09:45:52'),
(34, NULL, 'ip', '192.168.1.20', '2023-08-24 09:45:52', '2023-08-24 09:45:52'),
(35, 4, 'user', NULL, '2023-08-24 09:45:52', '2023-08-24 09:45:52'),
(36, NULL, 'global', NULL, '2023-08-24 09:46:34', '2023-08-24 09:46:34'),
(37, NULL, 'ip', '192.168.1.20', '2023-08-24 09:46:34', '2023-08-24 09:46:34'),
(38, 4, 'user', NULL, '2023-08-24 09:46:35', '2023-08-24 09:46:35'),
(39, NULL, 'global', NULL, '2023-08-24 12:55:09', '2023-08-24 12:55:09'),
(40, NULL, 'ip', '192.168.1.70', '2023-08-24 12:55:09', '2023-08-24 12:55:09'),
(41, 1, 'user', NULL, '2023-08-24 12:55:09', '2023-08-24 12:55:09'),
(42, NULL, 'global', NULL, '2023-08-24 12:55:19', '2023-08-24 12:55:19'),
(43, NULL, 'ip', '192.168.1.70', '2023-08-24 12:55:19', '2023-08-24 12:55:19'),
(44, 1, 'user', NULL, '2023-08-24 12:55:20', '2023-08-24 12:55:20'),
(45, NULL, 'global', NULL, '2023-08-24 12:55:33', '2023-08-24 12:55:33'),
(46, NULL, 'ip', '192.168.1.70', '2023-08-24 12:55:33', '2023-08-24 12:55:33'),
(47, 1, 'user', NULL, '2023-08-24 12:55:33', '2023-08-24 12:55:33'),
(48, NULL, 'global', NULL, '2023-08-24 12:56:57', '2023-08-24 12:56:57'),
(49, NULL, 'ip', '192.168.1.70', '2023-08-24 12:56:57', '2023-08-24 12:56:57'),
(50, 1, 'user', NULL, '2023-08-24 12:56:57', '2023-08-24 12:56:57'),
(51, NULL, 'global', NULL, '2023-08-24 12:57:07', '2023-08-24 12:57:07'),
(52, NULL, 'ip', '192.168.1.70', '2023-08-24 12:57:07', '2023-08-24 12:57:07'),
(53, 1, 'user', NULL, '2023-08-24 12:57:07', '2023-08-24 12:57:07'),
(54, NULL, 'global', NULL, '2023-08-24 13:45:18', '2023-08-24 13:45:18'),
(55, NULL, 'ip', '192.168.1.70', '2023-08-24 13:45:18', '2023-08-24 13:45:18'),
(56, 2, 'user', NULL, '2023-08-24 13:45:18', '2023-08-24 13:45:18'),
(57, NULL, 'global', NULL, '2023-08-24 13:45:34', '2023-08-24 13:45:34'),
(58, NULL, 'ip', '192.168.1.70', '2023-08-24 13:45:35', '2023-08-24 13:45:35'),
(59, 2, 'user', NULL, '2023-08-24 13:45:35', '2023-08-24 13:45:35'),
(60, NULL, 'global', NULL, '2023-08-25 07:53:39', '2023-08-25 07:53:39'),
(61, NULL, 'ip', '192.168.1.24', '2023-08-25 07:53:39', '2023-08-25 07:53:39'),
(62, 1, 'user', NULL, '2023-08-25 07:53:39', '2023-08-25 07:53:39'),
(63, NULL, 'global', NULL, '2023-08-25 07:53:56', '2023-08-25 07:53:56'),
(64, NULL, 'ip', '192.168.1.24', '2023-08-25 07:53:56', '2023-08-25 07:53:56'),
(65, 1, 'user', NULL, '2023-08-25 07:53:56', '2023-08-25 07:53:56'),
(66, NULL, 'global', NULL, '2023-08-25 07:57:34', '2023-08-25 07:57:34'),
(67, NULL, 'ip', '192.168.1.20', '2023-08-25 07:57:34', '2023-08-25 07:57:34'),
(68, 4, 'user', NULL, '2023-08-25 07:57:34', '2023-08-25 07:57:34'),
(69, NULL, 'global', NULL, '2023-08-25 07:57:51', '2023-08-25 07:57:51'),
(70, NULL, 'ip', '192.168.1.20', '2023-08-25 07:57:51', '2023-08-25 07:57:51'),
(71, NULL, 'global', NULL, '2023-08-25 12:48:50', '2023-08-25 12:48:50'),
(72, NULL, 'ip', '192.168.1.20', '2023-08-25 12:48:50', '2023-08-25 12:48:50'),
(73, 4, 'user', NULL, '2023-08-25 12:48:51', '2023-08-25 12:48:51'),
(74, NULL, 'global', NULL, '2023-08-28 09:18:08', '2023-08-28 09:18:08'),
(75, NULL, 'ip', '192.168.1.20', '2023-08-28 09:18:09', '2023-08-28 09:18:09'),
(76, 1, 'user', NULL, '2023-08-28 09:18:09', '2023-08-28 09:18:09'),
(77, NULL, 'global', NULL, '2023-08-28 09:18:15', '2023-08-28 09:18:15'),
(78, NULL, 'ip', '192.168.1.20', '2023-08-28 09:18:15', '2023-08-28 09:18:15'),
(79, 1, 'user', NULL, '2023-08-28 09:18:15', '2023-08-28 09:18:15'),
(80, NULL, 'global', NULL, '2023-09-21 14:58:05', '2023-09-21 14:58:05'),
(81, NULL, 'ip', '192.168.1.20', '2023-09-21 14:58:05', '2023-09-21 14:58:05'),
(82, NULL, 'global', NULL, '2023-10-03 09:45:29', '2023-10-03 09:45:29'),
(83, NULL, 'ip', '192.168.1.20', '2023-10-03 09:45:29', '2023-10-03 09:45:29'),
(84, 3, 'user', NULL, '2023-10-03 09:45:29', '2023-10-03 09:45:29'),
(85, NULL, 'global', NULL, '2023-10-03 09:45:38', '2023-10-03 09:45:38'),
(86, NULL, 'ip', '192.168.1.20', '2023-10-03 09:45:38', '2023-10-03 09:45:38'),
(87, 3, 'user', NULL, '2023-10-03 09:45:38', '2023-10-03 09:45:38'),
(88, NULL, 'global', NULL, '2023-10-03 09:45:49', '2023-10-03 09:45:49'),
(89, NULL, 'ip', '192.168.1.20', '2023-10-03 09:45:49', '2023-10-03 09:45:49'),
(90, 3, 'user', NULL, '2023-10-03 09:45:49', '2023-10-03 09:45:49'),
(91, NULL, 'global', NULL, '2023-10-03 09:46:12', '2023-10-03 09:46:12'),
(92, NULL, 'ip', '192.168.1.20', '2023-10-03 09:46:12', '2023-10-03 09:46:12'),
(93, 3, 'user', NULL, '2023-10-03 09:46:12', '2023-10-03 09:46:12'),
(94, NULL, 'global', NULL, '2023-10-03 09:46:21', '2023-10-03 09:46:21'),
(95, NULL, 'ip', '192.168.1.20', '2023-10-03 09:46:21', '2023-10-03 09:46:21'),
(96, 3, 'user', NULL, '2023-10-03 09:46:21', '2023-10-03 09:46:21'),
(97, NULL, 'global', NULL, '2023-10-16 06:17:44', '2023-10-16 06:17:44'),
(98, NULL, 'ip', '192.168.1.24', '2023-10-16 06:17:44', '2023-10-16 06:17:44'),
(99, 4, 'user', NULL, '2023-10-16 06:17:44', '2023-10-16 06:17:44'),
(100, NULL, 'global', NULL, '2023-10-16 06:17:59', '2023-10-16 06:17:59'),
(101, NULL, 'ip', '192.168.1.24', '2023-10-16 06:17:59', '2023-10-16 06:17:59'),
(102, 4, 'user', NULL, '2023-10-16 06:17:59', '2023-10-16 06:17:59'),
(103, NULL, 'global', NULL, '2023-10-16 06:18:13', '2023-10-16 06:18:13'),
(104, NULL, 'ip', '192.168.1.24', '2023-10-16 06:18:13', '2023-10-16 06:18:13'),
(105, 4, 'user', NULL, '2023-10-16 06:18:13', '2023-10-16 06:18:13'),
(106, NULL, 'global', NULL, '2023-10-26 06:44:54', '2023-10-26 06:44:54'),
(107, NULL, 'ip', '192.168.1.51', '2023-10-26 06:44:54', '2023-10-26 06:44:54'),
(108, 1, 'user', NULL, '2023-10-26 06:44:54', '2023-10-26 06:44:54'),
(109, NULL, 'global', NULL, '2023-10-30 15:15:35', '2023-10-30 15:15:35'),
(110, NULL, 'ip', '192.168.1.24', '2023-10-30 15:15:35', '2023-10-30 15:15:35'),
(111, 4, 'user', NULL, '2023-10-30 15:15:35', '2023-10-30 15:15:35'),
(112, NULL, 'global', NULL, '2023-10-31 06:45:16', '2023-10-31 06:45:16'),
(113, NULL, 'ip', '192.168.1.67', '2023-10-31 06:45:16', '2023-10-31 06:45:16'),
(114, 1, 'user', NULL, '2023-10-31 06:45:16', '2023-10-31 06:45:16'),
(115, NULL, 'global', NULL, '2023-10-31 09:56:40', '2023-10-31 09:56:40'),
(116, NULL, 'ip', '192.168.1.14', '2023-10-31 09:56:40', '2023-10-31 09:56:40'),
(117, 1, 'user', NULL, '2023-10-31 09:56:40', '2023-10-31 09:56:40'),
(118, NULL, 'global', NULL, '2023-11-10 06:33:21', '2023-11-10 06:33:21'),
(119, NULL, 'ip', '192.168.1.24', '2023-11-10 06:33:21', '2023-11-10 06:33:21'),
(120, 22, 'user', NULL, '2023-11-10 06:33:22', '2023-11-10 06:33:22'),
(121, NULL, 'global', NULL, '2023-11-17 10:25:15', '2023-11-17 10:25:15'),
(122, NULL, 'ip', '192.168.1.70', '2023-11-17 10:25:15', '2023-11-17 10:25:15'),
(123, 1, 'user', NULL, '2023-11-17 10:25:15', '2023-11-17 10:25:15'),
(124, NULL, 'global', NULL, '2023-11-17 11:52:08', '2023-11-17 11:52:08'),
(125, NULL, 'ip', '192.168.1.70', '2023-11-17 11:52:08', '2023-11-17 11:52:08');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `transaction_id` varchar(191) NOT NULL,
  `payment_method` varchar(191) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `translation_translations`
--

CREATE TABLE `translation_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `translation_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `value` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `updater_scripts`
--

CREATE TABLE `updater_scripts` (
  `id` int(10) UNSIGNED NOT NULL,
  `script` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `updater_scripts`
--

INSERT INTO `updater_scripts` (`id`, `script`) VALUES
(1, 'V2_0_0');

-- --------------------------------------------------------

--
-- Table structure for table `up_sell_products`
--

CREATE TABLE `up_sell_products` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `up_sell_product_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `up_sell_products`
--

INSERT INTO `up_sell_products` (`product_id`, `up_sell_product_id`) VALUES
(3, 2),
(5, 2),
(5, 3),
(7, 1),
(7, 2),
(7, 3),
(7, 5),
(8, 2),
(8, 3),
(8, 4),
(8, 5),
(9, 7),
(9, 8),
(10, 1),
(10, 2),
(10, 4),
(10, 7),
(10, 8),
(11, 4),
(11, 5),
(11, 6),
(11, 7),
(11, 8),
(12, 9),
(13, 12),
(15, 1),
(15, 2),
(15, 3),
(15, 13),
(16, 1),
(16, 6),
(16, 7),
(16, 8),
(17, 9),
(17, 10),
(17, 11),
(17, 12),
(17, 13),
(18, 10),
(18, 11),
(18, 12),
(18, 13),
(18, 17),
(24, 11),
(24, 12),
(24, 13),
(24, 14),
(24, 15),
(24, 16),
(24, 17),
(24, 18),
(26, 18),
(26, 24);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `first_name` varchar(191) NOT NULL,
  `last_name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `user_type` tinyint(4) NOT NULL DEFAULT 0,
  `permissions` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `is_sso_google` smallint(6) NOT NULL DEFAULT 0,
  `sso_id` varchar(50) DEFAULT NULL,
  `sso_username` varchar(50) DEFAULT NULL,
  `sso_locale` varchar(25) DEFAULT NULL,
  `sso_avatar` text DEFAULT NULL,
  `is_sso_fb` smallint(6) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `password`, `user_type`, `permissions`, `last_login`, `created_at`, `updated_at`, `image_url`, `is_sso_google`, `sso_id`, `sso_username`, `sso_locale`, `sso_avatar`, `is_sso_fb`) VALUES
(1, 'GIRISH', 'SHANKAR', 'giri@santhila.co', '91404040404', '$2y$10$N9NQ0/x4BwItEArqEIKg2uzB6C/7D3.SNF9uPDVm34vxHtGAatpDu', 0, '{\"admin.attributes.index\":true,\"admin.attributes.create\":true,\"admin.attributes.edit\":true,\"admin.attributes.destroy\":true,\"admin.attribute_sets.index\":true,\"admin.attribute_sets.create\":true,\"admin.attribute_sets.edit\":true,\"admin.attribute_sets.destroy\":true,\"admin.brands.index\":true,\"admin.brands.create\":true,\"admin.brands.edit\":true,\"admin.brands.destroy\":true,\"admin.categories.index\":true,\"admin.categories.create\":true,\"admin.categories.edit\":true,\"admin.categories.destroy\":true,\"admin.coupons.index\":true,\"admin.coupons.create\":true,\"admin.coupons.edit\":true,\"admin.coupons.destroy\":true,\"admin.currency_rates.index\":true,\"admin.currency_rates.edit\":true,\"admin.flash_sales.index\":true,\"admin.flash_sales.create\":true,\"admin.flash_sales.edit\":true,\"admin.flash_sales.destroy\":true,\"admin.importer.index\":true,\"admin.importer.create\":true,\"admin.media.index\":true,\"admin.media.create\":true,\"admin.media.destroy\":true,\"admin.menus.index\":true,\"admin.menus.create\":true,\"admin.menus.edit\":true,\"admin.menus.destroy\":true,\"admin.menu_items.index\":true,\"admin.menu_items.create\":true,\"admin.menu_items.edit\":true,\"admin.menu_items.destroy\":true,\"admin.options.index\":true,\"admin.options.create\":true,\"admin.options.edit\":true,\"admin.options.destroy\":true,\"admin.orders.index\":true,\"admin.orders.show\":true,\"admin.orders.edit\":true,\"admin.ordersubscription.index\":true,\"admin.ordersubscription.create\":true,\"admin.ordersubscription.edit\":true,\"admin.ordersubscription.destroy\":true,\"admin.pages.index\":true,\"admin.pages.create\":true,\"admin.pages.edit\":true,\"admin.pages.destroy\":true,\"admin.products.index\":true,\"admin.products.create\":true,\"admin.products.edit\":true,\"admin.products.destroy\":true,\"admin.reports.index\":true,\"admin.reviews.index\":true,\"admin.reviews.edit\":true,\"admin.reviews.destroy\":true,\"admin.rewardpoints.index\":true,\"admin.rewardpoints.create\":true,\"admin.rewardpoints.edit\":true,\"admin.rewardpoints.destroy\":true,\"admin.settings.edit\":true,\"admin.sliders.index\":true,\"admin.sliders.create\":true,\"admin.sliders.edit\":true,\"admin.sliders.destroy\":true,\"admin.tags.index\":true,\"admin.tags.create\":true,\"admin.tags.edit\":true,\"admin.tags.destroy\":true,\"admin.taxes.index\":true,\"admin.taxes.create\":true,\"admin.taxes.edit\":true,\"admin.taxes.destroy\":true,\"admin.testimonials.index\":true,\"admin.testimonials.create\":true,\"admin.testimonials.edit\":true,\"admin.testimonials.destroy\":true,\"admin.transactions.index\":true,\"admin.translations.index\":true,\"admin.translations.edit\":true,\"admin.users.index\":true,\"admin.users.create\":true,\"admin.users.edit\":true,\"admin.users.destroy\":true,\"admin.roles.index\":true,\"admin.roles.create\":true,\"admin.roles.edit\":true,\"admin.roles.destroy\":true,\"admin.storefront.edit\":true}', '2023-11-17 15:55:30', '2023-08-09 06:24:33', '2023-11-17 10:25:30', 'storage/profile/1/6517c1d73e3c7.png', 0, NULL, NULL, NULL, NULL, 0),
(2, 'kiruthika', 's', 'kiruthika@gmail.com', '9788894897', '$2y$10$c4p8cbYj1hIxqiBV2pCH7ONrdT8jGP3fIdqKtr9Hwjo1KPRxUgSx6', 0, NULL, NULL, '2023-08-16 11:05:35', '2023-08-16 11:05:35', NULL, 0, NULL, NULL, NULL, NULL, 0),
(3, 'Mahendran', 'Sadhasivam', 'mahi@santhila.co', '9994520822', '$2y$10$ps/PgTA4UPkQWdt8ylEeSOozSb.AWkDGF8..Fd1BnaewFv2cxTaa6', 0, NULL, '2023-08-22 16:26:52', '2023-08-22 10:55:43', '2023-08-22 10:56:52', NULL, 0, NULL, NULL, NULL, NULL, 0),
(4, 'APS', 'Admin', 'prabakaran@santhila.co', '9578009264', '$2y$10$N9NQ0/x4BwItEArqEIKg2uzB6C/7D3.SNF9uPDVm34vxHtGAatpDu', 0, '{\"admin.reviews.index\":true,\"admin.reviews.edit\":true,\"admin.reviews.destroy\":true,\"admin.rewardpoints.index\":true,\"admin.rewardpoints.create\":true,\"admin.rewardpoints.edit\":true,\"admin.rewardpoints.destroy\":true}', '2023-11-11 12:43:07', '2023-08-09 06:24:33', '2023-11-11 07:13:07', '', 0, NULL, NULL, NULL, NULL, 0),
(5, 'Prabakaran', 'V', 'prabakaran13@santhila.co', '9578009264', '$2y$10$NFaYfYYqUB73CFvpx6oCmuQGUXKsssp6NhSZ1HGIuTwNrBBzbxj7S', 0, NULL, '2023-11-10 12:03:45', '2023-08-24 10:05:50', '2023-11-10 06:33:45', NULL, 0, NULL, NULL, NULL, NULL, 0),
(6, 'Sangeetha', 'M', 'sangeetha@gmail.com', '9788894897', '$2y$10$Q9ytB41b.RVx9igKPINZtOPGBktJMcGHRKOBQCJXAaHlWSOP6kvKG', 1, '[]', '2023-11-17 17:22:34', '2023-08-24 13:46:45', '2023-11-17 11:52:34', NULL, 0, NULL, NULL, NULL, NULL, 0),
(7, 'Indumathi', 'E', 'indhumathi@santhila.co', '9995511447', '$2y$10$2m4CHsAPoujEZENnIL1cIujN5DnjKPdpPG/o5Rz7dBWak4q/Be28K', 0, '[]', '2023-10-30 20:05:10', '2023-09-25 07:48:06', '2023-10-30 14:35:10', NULL, 0, NULL, NULL, NULL, NULL, 0),
(8, 'Prabakaran1', 'V', 'prabakaran@santhila.co1', '9578009226', '$2y$10$eAy2yNkcC/0X0NPn8fHUBOfvhsvfWpuxlZ84CZ4K3oCLxxAbXLyv2', 0, NULL, '2023-10-28 16:41:01', '2023-10-28 11:11:01', '2023-10-28 11:11:01', NULL, 0, NULL, NULL, NULL, NULL, 0),
(22, 'Prabakaran', 'V', 'prabakaranpbk@gmail.com', '9578009264', '$2y$10$FjFIWjq2iihi.Qn79do/2OFQjNFnsm7L0mBGagLDSWOpLH34yyTve', 0, NULL, NULL, '2023-10-30 14:38:17', '2023-10-30 14:38:17', NULL, 0, NULL, NULL, NULL, NULL, 0),
(23, 'udhaya', 's', 'udhaya@gmail.com', '546465', '$2y$10$V70r8LiB1OMbFTMAMz710OdneXysEDQ0RNORc2Or/OUrFpE6neXZ2', 0, NULL, '2023-11-17 17:24:37', '2023-11-17 11:54:21', '2023-11-17 11:54:37', NULL, 0, NULL, NULL, NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `role_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2023-08-09 06:24:33', '2023-08-09 06:24:33'),
(2, 2, '2023-08-16 11:05:36', '2023-08-16 11:05:36'),
(3, 2, '2023-08-22 10:55:43', '2023-08-22 10:55:43'),
(4, 1, '2023-08-09 06:24:33', '2023-08-09 06:24:33'),
(5, 2, '2023-08-24 10:05:50', '2023-08-24 10:05:50'),
(6, 1, '2023-08-24 13:46:45', '2023-08-24 13:46:45'),
(6, 2, '2023-08-24 13:46:45', '2023-08-24 13:46:45'),
(7, 1, '2023-10-17 08:05:23', '2023-10-17 08:05:23'),
(7, 2, '2023-09-25 07:48:06', '2023-09-25 07:48:06'),
(8, 2, '2023-10-28 11:11:01', '2023-10-28 11:11:01'),
(22, 2, '2023-10-30 14:38:17', '2023-10-30 14:38:17'),
(23, 2, '2023-11-17 11:54:21', '2023-11-17 11:54:21');

-- --------------------------------------------------------

--
-- Table structure for table `wish_lists`
--

CREATE TABLE `wish_lists` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_deleted` int(11) DEFAULT NULL,
  `reason` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `wish_lists`
--

INSERT INTO `wish_lists` (`user_id`, `product_id`, `created_at`, `updated_at`, `is_deleted`, `reason`) VALUES
(1, 5, '2023-09-25 08:06:29', '2023-09-25 08:08:48', 1, 'Test Delete all Selected Items'),
(1, 8, '2023-09-25 08:06:26', '2023-09-25 08:08:48', 1, 'Test Delete all Selected Items'),
(1, 10, '2023-09-08 14:45:07', '2023-09-08 14:45:19', 1, 'Test'),
(1, 11, '2023-09-25 08:06:44', '2023-09-25 08:08:48', 1, 'Test Delete all Selected Items'),
(1, 12, '2023-09-13 14:26:44', '2023-09-13 14:48:41', 1, 'Test Entry 3'),
(1, 16, '2023-09-13 14:26:41', '2023-09-13 14:48:41', 1, 'Test Entry 3'),
(1, 17, '2023-09-23 10:42:25', '2023-09-25 08:08:13', 1, 'Jasmine Saram'),
(1, 18, '2023-09-23 10:42:22', '2023-09-25 08:07:06', 1, 'Out of stock'),
(1, 24, '2023-09-13 14:26:34', '2023-09-13 14:47:58', 1, 'Test entry 1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `abandonedcartlistreport`
--
ALTER TABLE `abandonedcartlistreport`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `activations`
--
ALTER TABLE `activations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `activations_user_id_index` (`user_id`);

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addresses_customer_id_foreign` (`customer_id`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attributes_slug_unique` (`slug`),
  ADD KEY `attributes_attribute_set_id_index` (`attribute_set_id`);

--
-- Indexes for table `attribute_categories`
--
ALTER TABLE `attribute_categories`
  ADD PRIMARY KEY (`attribute_id`,`category_id`),
  ADD KEY `attribute_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `attribute_sets`
--
ALTER TABLE `attribute_sets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attribute_set_translations`
--
ALTER TABLE `attribute_set_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attribute_set_translations_attribute_set_id_locale_unique` (`attribute_set_id`,`locale`);

--
-- Indexes for table `attribute_translations`
--
ALTER TABLE `attribute_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attribute_translations_attribute_id_locale_unique` (`attribute_id`,`locale`);

--
-- Indexes for table `attribute_values`
--
ALTER TABLE `attribute_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attribute_values_attribute_id_index` (`attribute_id`);

--
-- Indexes for table `attribute_value_translations`
--
ALTER TABLE `attribute_value_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attribute_value_translations_attribute_value_id_locale_unique` (`attribute_value_id`,`locale`);

--
-- Indexes for table `blogcategorys`
--
ALTER TABLE `blogcategorys`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blogcategorys_category_name_unique` (`category_name`);

--
-- Indexes for table `blogcomment`
--
ALTER TABLE `blogcomment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blogcomment_post_id_foreign` (`post_id`),
  ADD KEY `blogcomment_author_id_foreign` (`author_id`);

--
-- Indexes for table `blogfeedback`
--
ALTER TABLE `blogfeedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `blogfeedback_post_id_foreign` (`post_id`),
  ADD KEY `blogfeedback_author_id_foreign` (`author_id`);

--
-- Indexes for table `blogposts`
--
ALTER TABLE `blogposts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `blogtags`
--
ALTER TABLE `blogtags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blogtags_tag_name_unique` (`tag_name`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `brands_slug_unique` (`slug`);

--
-- Indexes for table `brand_translations`
--
ALTER TABLE `brand_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `brand_translations_brand_id_locale_unique` (`brand_id`,`locale`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `category_translations`
--
ALTER TABLE `category_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `category_translations_category_id_locale_unique` (`category_id`,`locale`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coupons_code_index` (`code`);

--
-- Indexes for table `coupon_categories`
--
ALTER TABLE `coupon_categories`
  ADD PRIMARY KEY (`coupon_id`,`category_id`,`exclude`),
  ADD KEY `coupon_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `coupon_products`
--
ALTER TABLE `coupon_products`
  ADD PRIMARY KEY (`coupon_id`,`product_id`),
  ADD KEY `coupon_products_product_id_foreign` (`product_id`);

--
-- Indexes for table `coupon_translations`
--
ALTER TABLE `coupon_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupon_translations_coupon_id_locale_unique` (`coupon_id`,`locale`);

--
-- Indexes for table `cross_sell_products`
--
ALTER TABLE `cross_sell_products`
  ADD PRIMARY KEY (`product_id`,`cross_sell_product_id`),
  ADD KEY `cross_sell_products_cross_sell_product_id_foreign` (`cross_sell_product_id`);

--
-- Indexes for table `currency_rates`
--
ALTER TABLE `currency_rates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `currency_rates_currency_unique` (`currency`);

--
-- Indexes for table `customer_reward_points`
--
ALTER TABLE `customer_reward_points`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_reward_points_customer_id_index` (`customer_id`),
  ADD KEY `customer_reward_points_order_id_foreign` (`order_id`),
  ADD KEY `customer_reward_points_review_id_foreign` (`review_id`);

--
-- Indexes for table `default_addresses`
--
ALTER TABLE `default_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `default_addresses_customer_id_foreign` (`customer_id`),
  ADD KEY `default_addresses_address_id_foreign` (`address_id`);

--
-- Indexes for table `emails`
--
ALTER TABLE `emails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `entity_files`
--
ALTER TABLE `entity_files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `entity_files_entity_type_entity_id_index` (`entity_type`,`entity_id`),
  ADD KEY `entity_files_file_id_index` (`file_id`),
  ADD KEY `entity_files_zone_index` (`zone`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD PRIMARY KEY (`id`),
  ADD KEY `files_user_id_index` (`user_id`),
  ADD KEY `files_filename_index` (`filename`);

--
-- Indexes for table `fixedrates`
--
ALTER TABLE `fixedrates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flash_sales`
--
ALTER TABLE `flash_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `flash_sale_products`
--
ALTER TABLE `flash_sale_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `flash_sale_products_flash_sale_id_foreign` (`flash_sale_id`),
  ADD KEY `flash_sale_products_product_id_foreign` (`product_id`);

--
-- Indexes for table `flash_sale_product_orders`
--
ALTER TABLE `flash_sale_product_orders`
  ADD PRIMARY KEY (`flash_sale_product_id`,`order_id`),
  ADD KEY `flash_sale_product_orders_order_id_foreign` (`order_id`);

--
-- Indexes for table `flash_sale_translations`
--
ALTER TABLE `flash_sale_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `flash_sale_translations_flash_sale_id_locale_unique` (`flash_sale_id`,`locale`);

--
-- Indexes for table `galleries`
--
ALTER TABLE `galleries`
  ADD PRIMARY KEY (`id`),
  ADD KEY `galleries_user_id_index` (`user_id`),
  ADD KEY `galleries_videoid_index` (`videoID`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_items_parent_id_foreign` (`parent_id`),
  ADD KEY `menu_items_category_id_foreign` (`category_id`),
  ADD KEY `menu_items_page_id_foreign` (`page_id`),
  ADD KEY `menu_items_menu_id_index` (`menu_id`);

--
-- Indexes for table `menu_item_translations`
--
ALTER TABLE `menu_item_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menu_item_translations_menu_item_id_locale_unique` (`menu_item_id`,`locale`);

--
-- Indexes for table `menu_translations`
--
ALTER TABLE `menu_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menu_translations_menu_id_locale_unique` (`menu_id`,`locale`);

--
-- Indexes for table `meta_data`
--
ALTER TABLE `meta_data`
  ADD PRIMARY KEY (`id`),
  ADD KEY `meta_data_entity_type_entity_id_index` (`entity_type`,`entity_id`);

--
-- Indexes for table `meta_data_translations`
--
ALTER TABLE `meta_data_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `meta_data_translations_meta_data_id_locale_unique` (`meta_data_id`,`locale`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `option_translations`
--
ALTER TABLE `option_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `option_translations_option_id_locale_unique` (`option_id`,`locale`);

--
-- Indexes for table `option_values`
--
ALTER TABLE `option_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `option_values_option_id_index` (`option_id`);

--
-- Indexes for table `option_value_translations`
--
ALTER TABLE `option_value_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `option_value_translations_option_value_id_locale_unique` (`option_value_id`,`locale`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_customer_id_index` (`customer_id`),
  ADD KEY `orders_coupon_id_index` (`coupon_id`),
  ADD KEY `customer_reward_points_id` (`rewardpoints_id`);

--
-- Indexes for table `order_downloads`
--
ALTER TABLE `order_downloads`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_downloads_order_id_foreign` (`order_id`),
  ADD KEY `order_downloads_file_id_foreign` (`file_id`);

--
-- Indexes for table `order_products`
--
ALTER TABLE `order_products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_products_order_id_foreign` (`order_id`),
  ADD KEY `order_products_product_id_foreign` (`product_id`);

--
-- Indexes for table `order_product_options`
--
ALTER TABLE `order_product_options`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_product_options_order_product_id_option_id_unique` (`order_product_id`,`option_id`),
  ADD KEY `order_product_options_option_id_foreign` (`option_id`);

--
-- Indexes for table `order_product_option_values`
--
ALTER TABLE `order_product_option_values`
  ADD PRIMARY KEY (`order_product_option_id`,`option_value_id`),
  ADD KEY `order_product_option_values_option_value_id_foreign` (`option_value_id`);

--
-- Indexes for table `order_taxes`
--
ALTER TABLE `order_taxes`
  ADD PRIMARY KEY (`order_id`,`tax_rate_id`),
  ADD KEY `order_taxes_tax_rate_id_foreign` (`tax_rate_id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`);

--
-- Indexes for table `page_translations`
--
ALTER TABLE `page_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `page_translations_page_id_locale_unique` (`page_id`,`locale`);

--
-- Indexes for table `persistences`
--
ALTER TABLE `persistences`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `persistences_code_unique` (`code`),
  ADD KEY `persistences_user_id_foreign` (`user_id`);

--
-- Indexes for table `pickupstores`
--
ALTER TABLE `pickupstores`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_slug_unique` (`slug`),
  ADD KEY `products_brand_id_foreign` (`brand_id`);

--
-- Indexes for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_attributes_product_id_index` (`product_id`),
  ADD KEY `product_attributes_attribute_id_index` (`attribute_id`);

--
-- Indexes for table `product_attribute_values`
--
ALTER TABLE `product_attribute_values`
  ADD PRIMARY KEY (`product_attribute_id`,`attribute_value_id`),
  ADD KEY `product_attribute_values_attribute_value_id_foreign` (`attribute_value_id`);

--
-- Indexes for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD PRIMARY KEY (`product_id`,`category_id`),
  ADD KEY `product_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `product_options`
--
ALTER TABLE `product_options`
  ADD PRIMARY KEY (`product_id`,`option_id`),
  ADD KEY `product_options_option_id_foreign` (`option_id`);

--
-- Indexes for table `product_tags`
--
ALTER TABLE `product_tags`
  ADD PRIMARY KEY (`product_id`,`tag_id`),
  ADD KEY `product_tags_tag_id_foreign` (`tag_id`);

--
-- Indexes for table `product_translations`
--
ALTER TABLE `product_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_translations_product_id_locale_unique` (`product_id`,`locale`);
ALTER TABLE `product_translations` ADD FULLTEXT KEY `name` (`name`);

--
-- Indexes for table `recurrings`
--
ALTER TABLE `recurrings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indexes for table `recurring_sub_orders`
--
ALTER TABLE `recurring_sub_orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `recurring_id` (`recurring_id`),
  ADD KEY `updated_user_id` (`updated_user_id`);

--
-- Indexes for table `related_products`
--
ALTER TABLE `related_products`
  ADD PRIMARY KEY (`product_id`,`related_product_id`),
  ADD KEY `related_products_related_product_id_foreign` (`related_product_id`);

--
-- Indexes for table `reminders`
--
ALTER TABLE `reminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reminders_user_id_foreign` (`user_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_reviewer_id_index` (`reviewer_id`),
  ADD KEY `reviews_product_id_index` (`product_id`);

--
-- Indexes for table `rewardpoints`
--
ALTER TABLE `rewardpoints`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reward_points_settings_enable_bday_points_index` (`enable_bday_points`),
  ADD KEY `reward_points_settings_enable_referral_points_index` (`enable_referral_points`),
  ADD KEY `reward_points_settings_enable_show_customer_points_index` (`enable_show_customer_points`),
  ADD KEY `reward_points_settings_enable_show_points_with_order_index` (`enable_show_points_with_order`),
  ADD KEY `reward_points_settings_enable_show_points_by_mail_index` (`enable_show_points_by_mail`),
  ADD KEY `reward_points_settings_enable_give_old_order_points_index` (`enable_give_old_order_points`),
  ADD KEY `reward_points_settings_enable_remove_points_order_refund_index` (`enable_remove_points_order_refund`),
  ADD KEY `reward_points_settings_add_days_reward_points_expiry_index` (`add_days_reward_points_expiry`),
  ADD KEY `reward_points_settings_add_days_reward_points_assignment_index` (`add_days_reward_points_assignment`),
  ADD KEY `reward_points_settings_use_points_per_order_index` (`use_points_per_order`),
  ADD KEY `reward_points_settings_min_order_cart_value_redemption_index` (`min_order_cart_value_redemption`),
  ADD KEY `reward_points_values_currency_value_index` (`currency_value`),
  ADD KEY `reward_points_values_point_value_index` (`point_value`),
  ADD KEY `reward_points_values_redemption_point_value_index` (`redemption_point_value`),
  ADD KEY `reward_points_values_redemption_currency_value_index` (`redemption_currency_value`),
  ADD KEY `reward_points_values_epoint_first_signup_value_index` (`epoint_first_signup_value`),
  ADD KEY `reward_points_values_epoint_ref_point_value_index` (`epoint_ref_point_value`),
  ADD KEY `reward_points_values_epoint_forder_point_value_index` (`epoint_forder_point_value`),
  ADD KEY `reward_points_values_epoint_freview_point_value_index` (`epoint_freview_point_value`),
  ADD KEY `reward_points_values_epoint_fpay_point_value_index` (`epoint_fpay_point_value`),
  ADD KEY `reward_points_values_epoint_bday_point_value_index` (`epoint_bday_point_value`),
  ADD KEY `reward_notifications_enable_apply_points_in_checkout_page_index` (`enable_apply_points_in_checkout_page`),
  ADD KEY `reward_notifications_apply_notification_message_index` (`apply_notification_message`),
  ADD KEY `reward_notifications_enable_apply_points_rem_payment_index` (`enable_apply_points_rem_payment`),
  ADD KEY `reward_notifications_apply_payment_noti_message_index` (`apply_payment_noti_message`),
  ADD KEY `reward_notifications_bday_noti_mail_message_index` (`bday_noti_mail_message`);

--
-- Indexes for table `reward_points_gifted`
--
ALTER TABLE `reward_points_gifted`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reward_points_gifted_user_id_index` (`user_id`),
  ADD KEY `reward_points_gifted_reward_point_value_index` (`reward_point_value`),
  ADD KEY `reward_points_gifted_reward_point_remarks_index` (`reward_point_remarks`),
  ADD KEY `reward_points_gifted_customer_reward_id_index` (`customer_reward_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_translations`
--
ALTER TABLE `role_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `role_translations_role_id_locale_unique` (`role_id`,`locale`);

--
-- Indexes for table `search_terms`
--
ALTER TABLE `search_terms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `search_terms_term_unique` (`term`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `setting_translations`
--
ALTER TABLE `setting_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `setting_translations_setting_id_locale_unique` (`setting_id`,`locale`);

--
-- Indexes for table `sliders`
--
ALTER TABLE `sliders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slider_slides`
--
ALTER TABLE `slider_slides`
  ADD PRIMARY KEY (`id`),
  ADD KEY `slider_slides_slider_id_foreign` (`slider_id`);

--
-- Indexes for table `slider_slide_translations`
--
ALTER TABLE `slider_slide_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slider_slide_translations_slider_slide_id_locale_unique` (`slider_slide_id`,`locale`);

--
-- Indexes for table `slider_translations`
--
ALTER TABLE `slider_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slider_translations_slider_id_locale_unique` (`slider_id`,`locale`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tags_slug_unique` (`slug`);

--
-- Indexes for table `tag_translations`
--
ALTER TABLE `tag_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tag_translations_tag_id_locale_unique` (`tag_id`,`locale`);

--
-- Indexes for table `tax_classes`
--
ALTER TABLE `tax_classes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tax_class_translations`
--
ALTER TABLE `tax_class_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tax_class_translations_tax_class_id_locale_unique` (`tax_class_id`,`locale`);

--
-- Indexes for table `tax_rates`
--
ALTER TABLE `tax_rates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tax_rates_tax_class_id_index` (`tax_class_id`);

--
-- Indexes for table `tax_rate_translations`
--
ALTER TABLE `tax_rate_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tax_rate_translations_tax_rate_id_locale_unique` (`tax_rate_id`,`locale`);

--
-- Indexes for table `templates`
--
ALTER TABLE `templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `templates_slug_unique` (`slug`);

--
-- Indexes for table `template_translations`
--
ALTER TABLE `template_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `template_translations_template_id_locale_unique` (`template_id`,`locale`);

--
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `throttle`
--
ALTER TABLE `throttle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `throttle_user_id_foreign` (`user_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transactions_order_id_unique` (`order_id`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `translations_key_index` (`key`);

--
-- Indexes for table `translation_translations`
--
ALTER TABLE `translation_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `translation_translations_translation_id_locale_unique` (`translation_id`,`locale`);

--
-- Indexes for table `updater_scripts`
--
ALTER TABLE `updater_scripts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `up_sell_products`
--
ALTER TABLE `up_sell_products`
  ADD PRIMARY KEY (`product_id`,`up_sell_product_id`),
  ADD KEY `up_sell_products_up_sell_product_id_foreign` (`up_sell_product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `user_roles_role_id_foreign` (`role_id`);

--
-- Indexes for table `wish_lists`
--
ALTER TABLE `wish_lists`
  ADD PRIMARY KEY (`user_id`,`product_id`),
  ADD KEY `wish_lists_product_id_foreign` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `abandonedcartlistreport`
--
ALTER TABLE `abandonedcartlistreport`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `activations`
--
ALTER TABLE `activations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `attribute_sets`
--
ALTER TABLE `attribute_sets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `attribute_set_translations`
--
ALTER TABLE `attribute_set_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `attribute_translations`
--
ALTER TABLE `attribute_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `attribute_values`
--
ALTER TABLE `attribute_values`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `attribute_value_translations`
--
ALTER TABLE `attribute_value_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `blogcategorys`
--
ALTER TABLE `blogcategorys`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `blogcomment`
--
ALTER TABLE `blogcomment`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `blogfeedback`
--
ALTER TABLE `blogfeedback`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `blogposts`
--
ALTER TABLE `blogposts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `blogtags`
--
ALTER TABLE `blogtags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `brand_translations`
--
ALTER TABLE `brand_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `category_translations`
--
ALTER TABLE `category_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `coupon_translations`
--
ALTER TABLE `coupon_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `currency_rates`
--
ALTER TABLE `currency_rates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customer_reward_points`
--
ALTER TABLE `customer_reward_points`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `default_addresses`
--
ALTER TABLE `default_addresses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `emails`
--
ALTER TABLE `emails`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `entity_files`
--
ALTER TABLE `entity_files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=595;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=227;

--
-- AUTO_INCREMENT for table `fixedrates`
--
ALTER TABLE `fixedrates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `flash_sales`
--
ALTER TABLE `flash_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `flash_sale_products`
--
ALTER TABLE `flash_sale_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `flash_sale_translations`
--
ALTER TABLE `flash_sale_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `galleries`
--
ALTER TABLE `galleries`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `menu_item_translations`
--
ALTER TABLE `menu_item_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `menu_translations`
--
ALTER TABLE `menu_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `meta_data`
--
ALTER TABLE `meta_data`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=130;

--
-- AUTO_INCREMENT for table `meta_data_translations`
--
ALTER TABLE `meta_data_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `option_translations`
--
ALTER TABLE `option_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `option_values`
--
ALTER TABLE `option_values`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `option_value_translations`
--
ALTER TABLE `option_value_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- AUTO_INCREMENT for table `order_downloads`
--
ALTER TABLE `order_downloads`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `order_products`
--
ALTER TABLE `order_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=182;

--
-- AUTO_INCREMENT for table `order_product_options`
--
ALTER TABLE `order_product_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `page_translations`
--
ALTER TABLE `page_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `persistences`
--
ALTER TABLE `persistences`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=247;

--
-- AUTO_INCREMENT for table `pickupstores`
--
ALTER TABLE `pickupstores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `product_translations`
--
ALTER TABLE `product_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `recurrings`
--
ALTER TABLE `recurrings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `recurring_sub_orders`
--
ALTER TABLE `recurring_sub_orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `reminders`
--
ALTER TABLE `reminders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `rewardpoints`
--
ALTER TABLE `rewardpoints`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reward_points_gifted`
--
ALTER TABLE `reward_points_gifted`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `role_translations`
--
ALTER TABLE `role_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `search_terms`
--
ALTER TABLE `search_terms`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=371;

--
-- AUTO_INCREMENT for table `setting_translations`
--
ALTER TABLE `setting_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `slider_slides`
--
ALTER TABLE `slider_slides`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `slider_slide_translations`
--
ALTER TABLE `slider_slide_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `slider_translations`
--
ALTER TABLE `slider_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tag_translations`
--
ALTER TABLE `tag_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tax_classes`
--
ALTER TABLE `tax_classes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tax_class_translations`
--
ALTER TABLE `tax_class_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tax_rates`
--
ALTER TABLE `tax_rates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tax_rate_translations`
--
ALTER TABLE `tax_rate_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `templates`
--
ALTER TABLE `templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `template_translations`
--
ALTER TABLE `template_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `throttle`
--
ALTER TABLE `throttle`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `translation_translations`
--
ALTER TABLE `translation_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `updater_scripts`
--
ALTER TABLE `updater_scripts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activations`
--
ALTER TABLE `activations`
  ADD CONSTRAINT `activations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attributes`
--
ALTER TABLE `attributes`
  ADD CONSTRAINT `attributes_attribute_set_id_foreign` FOREIGN KEY (`attribute_set_id`) REFERENCES `attribute_sets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attribute_categories`
--
ALTER TABLE `attribute_categories`
  ADD CONSTRAINT `attribute_categories_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attribute_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attribute_set_translations`
--
ALTER TABLE `attribute_set_translations`
  ADD CONSTRAINT `attribute_set_translations_attribute_set_id_foreign` FOREIGN KEY (`attribute_set_id`) REFERENCES `attribute_sets` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attribute_translations`
--
ALTER TABLE `attribute_translations`
  ADD CONSTRAINT `attribute_translations_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attribute_values`
--
ALTER TABLE `attribute_values`
  ADD CONSTRAINT `attribute_values_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attribute_value_translations`
--
ALTER TABLE `attribute_value_translations`
  ADD CONSTRAINT `attribute_value_translations_attribute_value_id_foreign` FOREIGN KEY (`attribute_value_id`) REFERENCES `attribute_values` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blogcomment`
--
ALTER TABLE `blogcomment`
  ADD CONSTRAINT `blogcomment_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blogcomment_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `blogposts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `blogfeedback`
--
ALTER TABLE `blogfeedback`
  ADD CONSTRAINT `blogfeedback_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blogfeedback_post_id_foreign` FOREIGN KEY (`post_id`) REFERENCES `blogposts` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category_translations`
--
ALTER TABLE `category_translations`
  ADD CONSTRAINT `category_translations_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `coupon_categories`
--
ALTER TABLE `coupon_categories`
  ADD CONSTRAINT `coupon_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coupon_categories_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `coupon_products`
--
ALTER TABLE `coupon_products`
  ADD CONSTRAINT `coupon_products_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coupon_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `coupon_translations`
--
ALTER TABLE `coupon_translations`
  ADD CONSTRAINT `coupon_translations_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `cross_sell_products`
--
ALTER TABLE `cross_sell_products`
  ADD CONSTRAINT `cross_sell_products_cross_sell_product_id_foreign` FOREIGN KEY (`cross_sell_product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cross_sell_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `customer_reward_points`
--
ALTER TABLE `customer_reward_points`
  ADD CONSTRAINT `customer_reward_points_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  ADD CONSTRAINT `customer_reward_points_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Constraints for table `default_addresses`
--
ALTER TABLE `default_addresses`
  ADD CONSTRAINT `default_addresses_address_id_foreign` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `default_addresses_customer_id_foreign` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `entity_files`
--
ALTER TABLE `entity_files`
  ADD CONSTRAINT `entity_files_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flash_sale_products`
--
ALTER TABLE `flash_sale_products`
  ADD CONSTRAINT `flash_sale_products_flash_sale_id_foreign` FOREIGN KEY (`flash_sale_id`) REFERENCES `flash_sales` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flash_sale_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flash_sale_product_orders`
--
ALTER TABLE `flash_sale_product_orders`
  ADD CONSTRAINT `flash_sale_product_orders_flash_sale_product_id_foreign` FOREIGN KEY (`flash_sale_product_id`) REFERENCES `flash_sale_products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `flash_sale_product_orders_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `flash_sale_translations`
--
ALTER TABLE `flash_sale_translations`
  ADD CONSTRAINT `flash_sale_translations_flash_sale_id_foreign` FOREIGN KEY (`flash_sale_id`) REFERENCES `flash_sales` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `menu_items_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `menu_items_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `menu_item_translations`
--
ALTER TABLE `menu_item_translations`
  ADD CONSTRAINT `menu_item_translations_menu_item_id_foreign` FOREIGN KEY (`menu_item_id`) REFERENCES `menu_items` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `menu_translations`
--
ALTER TABLE `menu_translations`
  ADD CONSTRAINT `menu_translations_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `meta_data_translations`
--
ALTER TABLE `meta_data_translations`
  ADD CONSTRAINT `meta_data_translations_meta_data_id_foreign` FOREIGN KEY (`meta_data_id`) REFERENCES `meta_data` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `option_translations`
--
ALTER TABLE `option_translations`
  ADD CONSTRAINT `option_translations_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `option_values`
--
ALTER TABLE `option_values`
  ADD CONSTRAINT `option_values_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `option_value_translations`
--
ALTER TABLE `option_value_translations`
  ADD CONSTRAINT `option_value_translations_option_value_id_foreign` FOREIGN KEY (`option_value_id`) REFERENCES `option_values` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `customer_reward_points_id` FOREIGN KEY (`rewardpoints_id`) REFERENCES `customer_reward_points` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `order_downloads`
--
ALTER TABLE `order_downloads`
  ADD CONSTRAINT `order_downloads_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_downloads_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_products`
--
ALTER TABLE `order_products`
  ADD CONSTRAINT `order_products_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_product_options`
--
ALTER TABLE `order_product_options`
  ADD CONSTRAINT `order_product_options_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_product_options_order_product_id_foreign` FOREIGN KEY (`order_product_id`) REFERENCES `order_products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_product_option_values`
--
ALTER TABLE `order_product_option_values`
  ADD CONSTRAINT `order_product_option_values_option_value_id_foreign` FOREIGN KEY (`option_value_id`) REFERENCES `option_values` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_product_option_values_order_product_option_id_foreign` FOREIGN KEY (`order_product_option_id`) REFERENCES `order_product_options` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `order_taxes`
--
ALTER TABLE `order_taxes`
  ADD CONSTRAINT `order_taxes_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_taxes_tax_rate_id_foreign` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `page_translations`
--
ALTER TABLE `page_translations`
  ADD CONSTRAINT `page_translations_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `persistences`
--
ALTER TABLE `persistences`
  ADD CONSTRAINT `persistences_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD CONSTRAINT `product_attributes_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_attributes_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_attribute_values`
--
ALTER TABLE `product_attribute_values`
  ADD CONSTRAINT `product_attribute_values_attribute_value_id_foreign` FOREIGN KEY (`attribute_value_id`) REFERENCES `attribute_values` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_attribute_values_product_attribute_id_foreign` FOREIGN KEY (`product_attribute_id`) REFERENCES `product_attributes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_categories`
--
ALTER TABLE `product_categories`
  ADD CONSTRAINT `product_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_categories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_options`
--
ALTER TABLE `product_options`
  ADD CONSTRAINT `product_options_option_id_foreign` FOREIGN KEY (`option_id`) REFERENCES `options` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_options_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_tags`
--
ALTER TABLE `product_tags`
  ADD CONSTRAINT `product_tags_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_translations`
--
ALTER TABLE `product_translations`
  ADD CONSTRAINT `product_translations_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `recurrings`
--
ALTER TABLE `recurrings`
  ADD CONSTRAINT `order_id` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `recurring_sub_orders`
--
ALTER TABLE `recurring_sub_orders`
  ADD CONSTRAINT `recurring_id` FOREIGN KEY (`recurring_id`) REFERENCES `recurrings` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `updated_user_id` FOREIGN KEY (`updated_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `related_products`
--
ALTER TABLE `related_products`
  ADD CONSTRAINT `related_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `related_products_related_product_id_foreign` FOREIGN KEY (`related_product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reminders`
--
ALTER TABLE `reminders`
  ADD CONSTRAINT `reminders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `role_translations`
--
ALTER TABLE `role_translations`
  ADD CONSTRAINT `role_translations_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `setting_translations`
--
ALTER TABLE `setting_translations`
  ADD CONSTRAINT `setting_translations_setting_id_foreign` FOREIGN KEY (`setting_id`) REFERENCES `settings` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `slider_slides`
--
ALTER TABLE `slider_slides`
  ADD CONSTRAINT `slider_slides_slider_id_foreign` FOREIGN KEY (`slider_id`) REFERENCES `sliders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `slider_slide_translations`
--
ALTER TABLE `slider_slide_translations`
  ADD CONSTRAINT `slider_slide_translations_slider_slide_id_foreign` FOREIGN KEY (`slider_slide_id`) REFERENCES `slider_slides` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `slider_translations`
--
ALTER TABLE `slider_translations`
  ADD CONSTRAINT `slider_translations_slider_id_foreign` FOREIGN KEY (`slider_id`) REFERENCES `sliders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tag_translations`
--
ALTER TABLE `tag_translations`
  ADD CONSTRAINT `tag_translations_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tax_class_translations`
--
ALTER TABLE `tax_class_translations`
  ADD CONSTRAINT `tax_class_translations_tax_class_id_foreign` FOREIGN KEY (`tax_class_id`) REFERENCES `tax_classes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tax_rates`
--
ALTER TABLE `tax_rates`
  ADD CONSTRAINT `tax_rates_tax_class_id_foreign` FOREIGN KEY (`tax_class_id`) REFERENCES `tax_classes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tax_rate_translations`
--
ALTER TABLE `tax_rate_translations`
  ADD CONSTRAINT `tax_rate_translations_tax_rate_id_foreign` FOREIGN KEY (`tax_rate_id`) REFERENCES `tax_rates` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `template_translations`
--
ALTER TABLE `template_translations`
  ADD CONSTRAINT `template_translations_template_id_foreign` FOREIGN KEY (`template_id`) REFERENCES `templates` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `throttle`
--
ALTER TABLE `throttle`
  ADD CONSTRAINT `throttle_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `translation_translations`
--
ALTER TABLE `translation_translations`
  ADD CONSTRAINT `translation_translations_translation_id_foreign` FOREIGN KEY (`translation_id`) REFERENCES `translations` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `up_sell_products`
--
ALTER TABLE `up_sell_products`
  ADD CONSTRAINT `up_sell_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `up_sell_products_up_sell_product_id_foreign` FOREIGN KEY (`up_sell_product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `wish_lists`
--
ALTER TABLE `wish_lists`
  ADD CONSTRAINT `wish_lists_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `wish_lists_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
