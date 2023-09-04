-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 30, 2023 at 02:53 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `apsgarland`
--

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
(2, 2, 'TFNpXihVNw4DrZboC7NEtJm23p4Tdofp', 1, '2023-08-30 15:58:59', '2023-08-30 10:28:59', '2023-08-30 10:28:59');

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(3, 3, 1, '2023-08-09 12:51:16', '2023-08-09 12:51:16', 'price');

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
(3, 5);

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
(5, '2023-08-09 12:48:35', '2023-08-09 12:48:35');

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
(5, 5, 'en', 'Color');

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
(3, 3, 'en', 'price');

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
(3, 3, 0, '2023-08-09 12:51:38', '2023-08-09 12:51:38');

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
(3, 3, 'en', 'price');

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
(1, 'aps', 1, '2023-08-09 12:44:27', '2023-08-09 12:44:27');

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
(1, 1, 'en', 'APS');

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
(1, NULL, 'devotional-garlands', NULL, 1, 1, '2023-08-09 12:34:25', '2023-08-09 12:34:25'),
(2, NULL, 'wedding-garlands', NULL, 1, 1, '2023-08-09 12:34:44', '2023-08-09 12:34:44'),
(3, NULL, 'funeral-garlands', NULL, 1, 1, '2023-08-09 12:35:01', '2023-08-09 12:35:01'),
(4, NULL, 'festival-garlands', NULL, 1, 1, '2023-08-09 12:35:23', '2023-08-09 12:35:23'),
(5, NULL, 'greetings', NULL, 1, 1, '2023-08-09 12:42:40', '2023-08-09 12:42:40');

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
(1, 1, 'en', 'Devotional Garlands'),
(2, 2, 'en', 'Wedding Garlands'),
(3, 3, 'en', 'Funeral  Garlands'),
(4, 4, 'en', 'Festival Garlands'),
(5, 5, 'en', 'Greetings');

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

-- --------------------------------------------------------

--
-- Table structure for table `coupon_categories`
--

CREATE TABLE `coupon_categories` (
  `coupon_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `exclude` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `cross_sell_products`
--

CREATE TABLE `cross_sell_products` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `cross_sell_product_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'USD', 1.0000, '2023-08-09 06:24:38', '2023-08-09 06:24:38');

-- --------------------------------------------------------

--
-- Table structure for table `default_addresses`
--

CREATE TABLE `default_addresses` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `address_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 8, 'Modules\\Category\\Entities\\Category', 1, 'logo', '2023-08-09 12:40:02', '2023-08-09 12:40:02'),
(2, 21, 'Modules\\Category\\Entities\\Category', 2, 'logo', '2023-08-09 12:41:21', '2023-08-09 12:41:21'),
(3, 15, 'Modules\\Category\\Entities\\Category', 3, 'logo', '2023-08-09 12:41:44', '2023-08-09 12:41:44'),
(4, 6, 'Modules\\Category\\Entities\\Category', 4, 'logo', '2023-08-09 12:42:19', '2023-08-09 12:42:19'),
(5, 3, 'Modules\\Category\\Entities\\Category', 5, 'logo', '2023-08-09 12:43:01', '2023-08-09 12:43:01'),
(6, 4, 'Modules\\Brand\\Entities\\Brand', 1, 'logo', '2023-08-09 12:45:05', '2023-08-09 12:45:05'),
(17, 29, 'Modules\\Product\\Entities\\Product', 2, 'base_image', '2023-08-09 12:57:27', '2023-08-09 12:57:27'),
(18, 28, 'Modules\\Product\\Entities\\Product', 2, 'additional_images', '2023-08-09 12:57:27', '2023-08-09 12:57:27'),
(19, 29, 'Modules\\Product\\Entities\\Product', 2, 'additional_images', '2023-08-09 12:57:27', '2023-08-09 12:57:27'),
(20, 26, 'Modules\\Product\\Entities\\Product', 1, 'base_image', '2023-08-09 12:58:11', '2023-08-09 12:58:11'),
(21, 26, 'Modules\\Product\\Entities\\Product', 1, 'additional_images', '2023-08-09 12:58:11', '2023-08-09 12:58:11');

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
(29, 1, 'DSC_2078.jpg', 'public_storage', 'media/NL0ET0aQzsqYzrGHjR0ox1dT1b6DQ1VB9UBR0jDg.jpg', 'jpg', 'image/jpeg', '337498', '2023-08-09 12:56:53', '2023-08-09 12:56:53');

-- --------------------------------------------------------

--
-- Table structure for table `flash_sales`
--

CREATE TABLE `flash_sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `flash_sale_product_orders`
--

CREATE TABLE `flash_sale_product_orders` (
  `flash_sale_product_id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 1, '2023-08-30 08:38:44', '2023-08-30 08:38:44');

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
(1, 1, NULL, NULL, NULL, 'URL', NULL, NULL, '_self', 0, 1, 0, 1, '2023-08-30 08:38:44', '2023-08-30 08:38:44'),
(2, 1, 1, NULL, NULL, 'url', 'create_testimonials', NULL, '_self', NULL, 0, 0, 1, '2023-08-30 08:39:22', '2023-08-30 10:05:27');

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
(2, 2, 'en', 'New Testimonial');

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
(1, 1, 'en', 'testimonial menu');

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
(3, 'Modules\\Product\\Entities\\Product', 2, '2023-08-09 12:57:27', '2023-08-09 12:57:27');

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
(3, 3, 'en', NULL, NULL);

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
(90, '2018_02_04_150917488267_create_testimonials_table', 3),
(91, '2018_02_04_150917488698_create_testimonial_translations_table', 3),
(92, '2018_03_11_181317_create_testimonial_products_table', 3),
(93, '2018_03_15_091937_create_testimonial_categories_table', 3),
(94, '2019_12_14_000001_create_personal_access_tokens_table', 3);

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
(3, 'field', 0, 0, 0, NULL, '2023-08-09 12:58:10', '2023-08-09 12:58:10');

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
(3, 3, 'en', 'Garland');

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
(1, 1, 10.0000, 'percent', 0, '2023-08-09 12:53:11', '2023-08-09 12:53:11'),
(2, 2, NULL, 'percent', 0, '2023-08-09 12:56:06', '2023-08-09 12:56:06'),
(3, 3, 200.0000, 'fixed', 0, '2023-08-09 12:58:10', '2023-08-09 12:58:10');

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
(2, 2, 'en', 'Yes');

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
  `shipping_last_name` varchar(191) NOT NULL,
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
  `note` text DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_downloads`
--

CREATE TABLE `order_downloads` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(10) UNSIGNED NOT NULL,
  `file_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `line_total` decimal(18,4) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `order_product_option_values`
--

CREATE TABLE `order_product_option_values` (
  `order_product_option_id` int(10) UNSIGNED NOT NULL,
  `option_value_id` int(10) UNSIGNED NOT NULL,
  `price` decimal(18,4) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(11, 1, 'SzZEupHB400mhFjTXuXXH8JNvjbcJwfl', '2023-08-29 12:15:59', '2023-08-29 12:15:59'),
(12, 1, 'kwursNn1DO2ZSyF3cb7dAuOcNzdzKeEp', '2023-08-30 04:27:34', '2023-08-30 04:27:34'),
(14, 2, '1guRRVG1Nuyq1SzJ3LhV4w3XV2KI8L1U', '2023-08-30 11:06:53', '2023-08-30 11:06:53');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(191) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_virtual` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `brand_id`, `tax_class_id`, `slug`, `price`, `special_price`, `special_price_type`, `special_price_start`, `special_price_end`, `selling_price`, `sku`, `manage_stock`, `qty`, `in_stock`, `viewed`, `is_active`, `new_from`, `new_to`, `deleted_at`, `created_at`, `updated_at`, `is_virtual`) VALUES
(1, NULL, NULL, 'wedding-garland', 200.0000, 150.0000, 'fixed', '2023-08-09', '2023-08-17', 150.0000, '25', 0, NULL, 1, 0, 1, '2023-08-09 00:00:00', '2023-08-19 00:00:00', NULL, '2023-08-09 12:42:13', '2023-08-09 12:58:09', 1),
(2, 1, NULL, 'lotus', 200.0000, 199.0000, 'fixed', NULL, NULL, 199.0000, NULL, 0, NULL, 1, 2, 1, NULL, NULL, NULL, '2023-08-09 12:57:27', '2023-08-30 06:04:38', 0);

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
(6, 1, 1);

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
(6, 1);

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
(1, 1),
(2, 2);

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
(1, 3);

-- --------------------------------------------------------

--
-- Table structure for table `product_tags`
--

CREATE TABLE `product_tags` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(2, 2, 'en', 'lotus', '<p>lotus</p>', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `related_products`
--

CREATE TABLE `related_products` (
  `product_id` int(10) UNSIGNED NOT NULL,
  `related_product_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 1, 2, 3, 'sangeetha', 'good', 1, '2023-08-30 05:35:29', '2023-08-30 05:35:29');

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
(1, '{\"admin.attributes.index\":true,\"admin.attributes.create\":true,\"admin.attributes.edit\":true,\"admin.attributes.destroy\":true,\"admin.attribute_sets.index\":true,\"admin.attribute_sets.create\":true,\"admin.attribute_sets.edit\":true,\"admin.attribute_sets.destroy\":true,\"admin.brands.index\":true,\"admin.brands.create\":true,\"admin.brands.edit\":true,\"admin.brands.destroy\":true,\"admin.categories.index\":true,\"admin.categories.create\":true,\"admin.categories.edit\":true,\"admin.categories.destroy\":true,\"admin.coupons.index\":true,\"admin.coupons.create\":true,\"admin.coupons.edit\":true,\"admin.coupons.destroy\":true,\"admin.currency_rates.index\":true,\"admin.currency_rates.edit\":true,\"admin.flash_sales.index\":true,\"admin.flash_sales.create\":true,\"admin.flash_sales.edit\":true,\"admin.flash_sales.destroy\":true,\"admin.importer.index\":true,\"admin.importer.create\":true,\"admin.media.index\":true,\"admin.media.create\":true,\"admin.media.destroy\":true,\"admin.menus.index\":true,\"admin.menus.create\":true,\"admin.menus.edit\":true,\"admin.menus.destroy\":true,\"admin.menu_items.index\":true,\"admin.menu_items.create\":true,\"admin.menu_items.edit\":true,\"admin.menu_items.destroy\":true,\"admin.options.index\":true,\"admin.options.create\":true,\"admin.options.edit\":true,\"admin.options.destroy\":true,\"admin.orders.index\":true,\"admin.orders.show\":true,\"admin.orders.edit\":true,\"admin.pages.index\":true,\"admin.pages.create\":true,\"admin.pages.edit\":true,\"admin.pages.destroy\":true,\"admin.products.index\":true,\"admin.products.create\":true,\"admin.products.edit\":true,\"admin.products.destroy\":true,\"admin.reports.index\":true,\"admin.reviews.index\":true,\"admin.reviews.edit\":true,\"admin.reviews.destroy\":true,\"admin.settings.edit\":true,\"admin.sliders.index\":true,\"admin.sliders.create\":true,\"admin.sliders.edit\":true,\"admin.sliders.destroy\":true,\"admin.tags.index\":true,\"admin.tags.create\":true,\"admin.tags.edit\":true,\"admin.tags.destroy\":true,\"admin.taxes.index\":true,\"admin.taxes.create\":true,\"admin.taxes.edit\":true,\"admin.taxes.destroy\":true,\"admin.testimonials.index\":true,\"admin.testimonials.create\":true,\"admin.testimonials.edit\":true,\"admin.testimonials.destroy\":true,\"admin.transactions.index\":true,\"admin.translations.index\":true,\"admin.translations.edit\":true,\"admin.users.index\":true,\"admin.users.create\":true,\"admin.users.edit\":true,\"admin.users.destroy\":true,\"admin.roles.index\":true,\"admin.roles.create\":true,\"admin.roles.edit\":true,\"admin.roles.destroy\":true,\"admin.storefront.edit\":true}', '2023-08-09 06:24:33', '2023-08-29 12:16:33'),
(2, '{\"admin.testimonials.index\":true,\"admin.testimonials.create\":true,\"admin.testimonials.edit\":true,\"admin.testimonials.destroy\":true}', '2023-08-09 06:24:34', '2023-08-29 12:16:50');

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
(2, 'store_email', 0, 's:20:\"admin@fleetcart.test\";', '2023-08-09 06:24:33', '2023-08-09 06:24:35'),
(3, 'store_phone', 0, 's:12:\"+121 9393939\";', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(4, 'search_engine', 0, 's:5:\"mysql\";', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(5, 'algolia_app_id', 0, 'N;', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(6, 'algolia_secret', 0, 'N;', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(7, 'active_theme', 0, 's:10:\"Storefront\";', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(8, 'supported_countries', 0, 'a:1:{i:0;s:2:\"BD\";}', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(9, 'default_country', 0, 's:2:\"BD\";', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(10, 'supported_locales', 0, 'a:1:{i:0;s:2:\"en\";}', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(11, 'default_locale', 0, 's:2:\"en\";', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(12, 'default_timezone', 0, 's:10:\"Asia/Dhaka\";', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(13, 'customer_role', 0, 's:1:\"2\";', '2023-08-09 06:24:35', '2023-08-30 10:09:09'),
(14, 'reviews_enabled', 0, 's:1:\"1\";', '2023-08-09 06:24:35', '2023-08-30 10:09:09'),
(15, 'auto_approve_reviews', 0, 's:1:\"1\";', '2023-08-09 06:24:35', '2023-08-30 10:09:09'),
(16, 'cookie_bar_enabled', 0, 's:1:\"1\";', '2023-08-09 06:24:35', '2023-08-30 10:09:09'),
(17, 'supported_currencies', 0, 'a:1:{i:0;s:3:\"USD\";}', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(18, 'default_currency', 0, 's:3:\"USD\";', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(19, 'send_order_invoice_email', 0, 'b:0;', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(20, 'newsletter_enabled', 0, 's:1:\"0\";', '2023-08-09 06:24:35', '2023-08-30 10:09:11'),
(21, 'local_pickup_cost', 0, 's:1:\"0\";', '2023-08-09 06:24:36', '2023-08-30 10:09:12'),
(22, 'flat_rate_cost', 0, 's:1:\"0\";', '2023-08-09 06:24:36', '2023-08-30 10:09:12'),
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
(50, 'storefront_copyright_text', 1, 's:92:\"Copyright © <a href=\"{{ store_url }}\">{{ store_name }}</a> {{ year }}. All rights reserved.\";', '2023-08-09 06:24:38', '2023-08-30 08:39:37'),
(51, 'storefront_welcome_text', 1, NULL, '2023-08-30 08:39:36', '2023-08-30 08:39:36'),
(52, 'storefront_address', 1, NULL, '2023-08-30 08:39:36', '2023-08-30 08:39:36'),
(53, 'storefront_navbar_text', 1, NULL, '2023-08-30 08:39:36', '2023-08-30 08:39:36'),
(54, 'storefront_footer_menu_one_title', 1, NULL, '2023-08-30 08:39:36', '2023-08-30 08:39:36'),
(55, 'storefront_footer_menu_two_title', 1, NULL, '2023-08-30 08:39:36', '2023-08-30 08:39:36'),
(56, 'storefront_feature_1_title', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(57, 'storefront_feature_1_subtitle', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(58, 'storefront_feature_2_title', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(59, 'storefront_feature_2_subtitle', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(60, 'storefront_feature_3_title', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(61, 'storefront_feature_3_subtitle', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(62, 'storefront_feature_4_title', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(63, 'storefront_feature_4_subtitle', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(64, 'storefront_feature_5_title', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(65, 'storefront_feature_5_subtitle', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(66, 'storefront_product_page_banner_file_id', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(67, 'storefront_slider_banner_1_file_id', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(68, 'storefront_slider_banner_2_file_id', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(69, 'storefront_three_column_full_width_banners_1_file_id', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(70, 'storefront_three_column_full_width_banners_2_file_id', 1, NULL, '2023-08-30 08:39:37', '2023-08-30 08:39:37'),
(71, 'storefront_three_column_full_width_banners_3_file_id', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(72, 'storefront_featured_categories_section_title', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(73, 'storefront_featured_categories_section_subtitle', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(74, 'storefront_product_tabs_1_section_tab_1_title', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(75, 'storefront_product_tabs_1_section_tab_2_title', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(76, 'storefront_product_tabs_1_section_tab_3_title', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(77, 'storefront_product_tabs_1_section_tab_4_title', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(78, 'storefront_two_column_banners_1_file_id', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(79, 'storefront_two_column_banners_2_file_id', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(80, 'storefront_product_grid_section_tab_1_title', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(81, 'storefront_product_grid_section_tab_2_title', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(82, 'storefront_product_grid_section_tab_3_title', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(83, 'storefront_product_grid_section_tab_4_title', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(84, 'storefront_three_column_banners_1_file_id', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(85, 'storefront_three_column_banners_2_file_id', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(86, 'storefront_three_column_banners_3_file_id', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(87, 'storefront_product_tabs_2_section_title', 1, NULL, '2023-08-30 08:39:38', '2023-08-30 08:39:38'),
(88, 'storefront_product_tabs_2_section_tab_1_title', 1, NULL, '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(89, 'storefront_product_tabs_2_section_tab_2_title', 1, NULL, '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(90, 'storefront_product_tabs_2_section_tab_3_title', 1, NULL, '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(91, 'storefront_product_tabs_2_section_tab_4_title', 1, NULL, '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(92, 'storefront_one_column_banner_file_id', 1, NULL, '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(93, 'storefront_theme_color', 0, 's:4:\"blue\";', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(94, 'storefront_custom_theme_color', 0, 's:7:\"#000000\";', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(95, 'storefront_mail_theme_color', 0, 's:4:\"blue\";', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(96, 'storefront_custom_mail_theme_color', 0, 's:7:\"#000000\";', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(97, 'storefront_slider', 0, 'N;', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(98, 'storefront_terms_page', 0, 'N;', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(99, 'storefront_privacy_page', 0, 'N;', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(100, 'storefront_most_searched_keywords_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(101, 'storefront_primary_menu', 0, 's:1:\"1\";', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(102, 'storefront_category_menu', 0, 'N;', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(103, 'storefront_footer_menu_one', 0, 'N;', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(104, 'storefront_footer_menu_two', 0, 'N;', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(105, 'storefront_features_section_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(106, 'storefront_feature_1_icon', 0, 'N;', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(107, 'storefront_feature_2_icon', 0, 'N;', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(108, 'storefront_feature_3_icon', 0, 'N;', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(109, 'storefront_feature_4_icon', 0, 'N;', '2023-08-30 08:39:39', '2023-08-30 08:39:39'),
(110, 'storefront_feature_5_icon', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(111, 'storefront_product_page_banner_call_to_action_url', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(112, 'storefront_product_page_banner_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(113, 'storefront_facebook_link', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(114, 'storefront_twitter_link', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(115, 'storefront_instagram_link', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(116, 'storefront_youtube_link', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(117, 'storefront_slider_banner_1_call_to_action_url', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(118, 'storefront_slider_banner_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(119, 'storefront_slider_banner_2_call_to_action_url', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(120, 'storefront_slider_banner_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(121, 'storefront_three_column_full_width_banners_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(122, 'storefront_three_column_full_width_banners_1_call_to_action_url', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(123, 'storefront_three_column_full_width_banners_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(124, 'storefront_three_column_full_width_banners_2_call_to_action_url', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(125, 'storefront_three_column_full_width_banners_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(126, 'storefront_three_column_full_width_banners_3_call_to_action_url', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(127, 'storefront_three_column_full_width_banners_3_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(128, 'storefront_featured_categories_section_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(129, 'storefront_featured_categories_section_category_1_category_id', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(130, 'storefront_featured_categories_section_category_1_product_type', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(131, 'storefront_featured_categories_section_category_1_products_limit', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(132, 'storefront_featured_categories_section_category_2_category_id', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(133, 'storefront_featured_categories_section_category_2_product_type', 0, 'N;', '2023-08-30 08:39:40', '2023-08-30 08:39:40'),
(134, 'storefront_featured_categories_section_category_2_products_limit', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(135, 'storefront_featured_categories_section_category_3_category_id', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(136, 'storefront_featured_categories_section_category_3_product_type', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(137, 'storefront_featured_categories_section_category_3_products_limit', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(138, 'storefront_featured_categories_section_category_4_category_id', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(139, 'storefront_featured_categories_section_category_4_product_type', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(140, 'storefront_featured_categories_section_category_4_products_limit', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(141, 'storefront_featured_categories_section_category_5_category_id', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(142, 'storefront_featured_categories_section_category_5_product_type', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(143, 'storefront_featured_categories_section_category_5_products_limit', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(144, 'storefront_featured_categories_section_category_6_category_id', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(145, 'storefront_featured_categories_section_category_6_product_type', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(146, 'storefront_featured_categories_section_category_6_products_limit', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(147, 'storefront_product_tabs_1_section_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(148, 'storefront_product_tabs_1_section_tab_1_product_type', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(149, 'storefront_product_tabs_1_section_tab_1_category_id', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(150, 'storefront_product_tabs_1_section_tab_1_products_limit', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(151, 'storefront_product_tabs_1_section_tab_2_product_type', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(152, 'storefront_product_tabs_1_section_tab_2_category_id', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(153, 'storefront_product_tabs_1_section_tab_2_products_limit', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(154, 'storefront_product_tabs_1_section_tab_3_product_type', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(155, 'storefront_product_tabs_1_section_tab_3_category_id', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(156, 'storefront_product_tabs_1_section_tab_3_products_limit', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(157, 'storefront_product_tabs_1_section_tab_4_product_type', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(158, 'storefront_product_tabs_1_section_tab_4_category_id', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(159, 'storefront_product_tabs_1_section_tab_4_products_limit', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(160, 'storefront_top_brands_section_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(161, 'storefront_flash_sale_and_vertical_products_section_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(162, 'storefront_flash_sale_title', 0, 'N;', '2023-08-30 08:39:41', '2023-08-30 08:39:41'),
(163, 'storefront_active_flash_sale_campaign', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(164, 'storefront_vertical_products_1_title', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(165, 'storefront_vertical_products_1_product_type', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(166, 'storefront_vertical_products_1_category_id', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(167, 'storefront_vertical_products_1_products_limit', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(168, 'storefront_vertical_products_2_title', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(169, 'storefront_vertical_products_2_product_type', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(170, 'storefront_vertical_products_2_category_id', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(171, 'storefront_vertical_products_2_products_limit', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(172, 'storefront_vertical_products_3_title', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(173, 'storefront_vertical_products_3_product_type', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(174, 'storefront_vertical_products_3_category_id', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(175, 'storefront_vertical_products_3_products_limit', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(176, 'storefront_two_column_banners_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(177, 'storefront_two_column_banners_1_call_to_action_url', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(178, 'storefront_two_column_banners_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(179, 'storefront_two_column_banners_2_call_to_action_url', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(180, 'storefront_two_column_banners_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(181, 'storefront_product_grid_section_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(182, 'storefront_product_grid_section_tab_1_product_type', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(183, 'storefront_product_grid_section_tab_1_category_id', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(184, 'storefront_product_grid_section_tab_1_products_limit', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(185, 'storefront_product_grid_section_tab_2_product_type', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(186, 'storefront_product_grid_section_tab_2_category_id', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(187, 'storefront_product_grid_section_tab_2_products_limit', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(188, 'storefront_product_grid_section_tab_3_product_type', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(189, 'storefront_product_grid_section_tab_3_category_id', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(190, 'storefront_product_grid_section_tab_3_products_limit', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(191, 'storefront_product_grid_section_tab_4_product_type', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(192, 'storefront_product_grid_section_tab_4_category_id', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(193, 'storefront_product_grid_section_tab_4_products_limit', 0, 'N;', '2023-08-30 08:39:42', '2023-08-30 08:39:42'),
(194, 'storefront_three_column_banners_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(195, 'storefront_three_column_banners_1_call_to_action_url', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(196, 'storefront_three_column_banners_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(197, 'storefront_three_column_banners_2_call_to_action_url', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(198, 'storefront_three_column_banners_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(199, 'storefront_three_column_banners_3_call_to_action_url', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(200, 'storefront_three_column_banners_3_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(201, 'storefront_product_tabs_2_section_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(202, 'storefront_product_tabs_2_section_tab_1_product_type', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(203, 'storefront_product_tabs_2_section_tab_1_category_id', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(204, 'storefront_product_tabs_2_section_tab_1_products_limit', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(205, 'storefront_product_tabs_2_section_tab_2_product_type', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(206, 'storefront_product_tabs_2_section_tab_2_category_id', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(207, 'storefront_product_tabs_2_section_tab_2_products_limit', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(208, 'storefront_product_tabs_2_section_tab_3_product_type', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(209, 'storefront_product_tabs_2_section_tab_3_category_id', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(210, 'storefront_product_tabs_2_section_tab_3_products_limit', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(211, 'storefront_product_tabs_2_section_tab_4_product_type', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(212, 'storefront_product_tabs_2_section_tab_4_category_id', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(213, 'storefront_product_tabs_2_section_tab_4_products_limit', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(214, 'storefront_one_column_banner_enabled', 0, 's:1:\"0\";', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(215, 'storefront_one_column_banner_call_to_action_url', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(216, 'storefront_one_column_banner_open_in_new_window', 0, 's:1:\"0\";', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(217, 'storefront_footer_tags', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(218, 'storefront_featured_categories_section_category_1_products', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(219, 'storefront_featured_categories_section_category_2_products', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(220, 'storefront_featured_categories_section_category_3_products', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(221, 'storefront_featured_categories_section_category_4_products', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(222, 'storefront_featured_categories_section_category_5_products', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(223, 'storefront_featured_categories_section_category_6_products', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(224, 'storefront_product_tabs_1_section_tab_1_products', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(225, 'storefront_product_tabs_1_section_tab_2_products', 0, 'N;', '2023-08-30 08:39:43', '2023-08-30 08:39:43'),
(226, 'storefront_product_tabs_1_section_tab_3_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(227, 'storefront_product_tabs_1_section_tab_4_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(228, 'storefront_top_brands', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(229, 'storefront_vertical_products_1_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(230, 'storefront_vertical_products_2_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(231, 'storefront_vertical_products_3_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(232, 'storefront_product_grid_section_tab_1_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(233, 'storefront_product_grid_section_tab_2_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(234, 'storefront_product_grid_section_tab_3_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(235, 'storefront_product_grid_section_tab_4_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(236, 'storefront_product_tabs_2_section_tab_1_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(237, 'storefront_product_tabs_2_section_tab_2_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(238, 'storefront_product_tabs_2_section_tab_3_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(239, 'storefront_product_tabs_2_section_tab_4_products', 0, 'N;', '2023-08-30 08:39:44', '2023-08-30 08:39:44'),
(240, 'testimonials_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:09', '2023-08-30 10:09:09'),
(241, 'auto_approve_testimonials', 0, 's:1:\"0\";', '2023-08-30 10:09:09', '2023-08-30 10:09:09'),
(242, 'maintenance_mode', 0, 's:1:\"0\";', '2023-08-30 10:09:09', '2023-08-30 10:09:09'),
(243, 'store_tagline', 1, NULL, '2023-08-30 10:09:09', '2023-08-30 10:09:09'),
(244, 'bank_transfer_instructions', 1, NULL, '2023-08-30 10:09:10', '2023-08-30 10:09:10'),
(245, 'check_payment_instructions', 1, NULL, '2023-08-30 10:09:10', '2023-08-30 10:09:10'),
(246, 'store_address_1', 0, 'N;', '2023-08-30 10:09:10', '2023-08-30 10:09:10'),
(247, 'store_address_2', 0, 'N;', '2023-08-30 10:09:10', '2023-08-30 10:09:10'),
(248, 'store_city', 0, 'N;', '2023-08-30 10:09:10', '2023-08-30 10:09:10'),
(249, 'store_country', 0, 's:2:\"AF\";', '2023-08-30 10:09:10', '2023-08-30 10:09:10'),
(250, 'store_state', 0, 'N;', '2023-08-30 10:09:10', '2023-08-30 10:09:10'),
(251, 'store_zip', 0, 'N;', '2023-08-30 10:09:10', '2023-08-30 10:09:10'),
(252, 'store_phone_hide', 0, 's:1:\"0\";', '2023-08-30 10:09:10', '2023-08-30 10:09:10'),
(253, 'store_email_hide', 0, 's:1:\"0\";', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(254, 'currency_rate_exchange_service', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(255, 'fixer_access_key', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(256, 'forge_api_key', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(257, 'currency_data_feed_api_key', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(258, 'auto_refresh_currency_rates', 0, 's:1:\"0\";', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(259, 'auto_refresh_currency_rate_frequency', 0, 's:5:\"daily\";', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(260, 'sms_from', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(261, 'sms_service', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(262, 'vonage_key', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(263, 'vonage_secret', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(264, 'twilio_sid', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(265, 'twilio_token', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(266, 'welcome_sms', 0, 's:1:\"0\";', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(267, 'new_order_admin_sms', 0, 's:1:\"0\";', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(268, 'new_order_sms', 0, 's:1:\"0\";', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(269, 'mail_from_address', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(270, 'mail_from_name', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(271, 'mail_host', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(272, 'mail_port', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(273, 'mail_username', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(274, 'mail_password', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(275, 'mail_encryption', 0, 'N;', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(276, 'welcome_email', 0, 's:1:\"0\";', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(277, 'admin_order_email', 0, 's:1:\"0\";', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(278, 'invoice_email', 0, 's:1:\"0\";', '2023-08-30 10:09:11', '2023-08-30 10:09:11'),
(279, 'mailchimp_api_key', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(280, 'mailchimp_list_id', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(281, 'custom_header_assets', 0, 's:3442:\"<style>\r\n        /*  Code By Webdevtrick ( https://webdevtrick.com )  */\r\n        body {\r\n            margin-top: 10%;\r\n        }\r\n\r\n        .shadow-effect {\r\n            background: #fff;\r\n            padding: 20px;\r\n            border-radius: 4px;\r\n            text-align: center;\r\n            border: 1px solid #ECECEC;\r\n            box-shadow: 0 19px 38px rgba(0, 0, 0, 0.10), 0 15px 12px rgba(0, 0, 0, 0.02);\r\n        }\r\n\r\n        #testimonials-list .shadow-effect p {\r\n            font-family: inherit;\r\n            font-size: 17px;\r\n            line-height: 1.5;\r\n            margin: 0 0 17px 0;\r\n            font-weight: 300;\r\n        }\r\n\r\n        .testimonial-name {\r\n            margin: -17px auto 0;\r\n            display: table;\r\n            width: auto;\r\n            background: #3190E7;\r\n            padding: 9px 35px;\r\n            border-radius: 12px;\r\n            text-align: center;\r\n            color: #fff;\r\n            box-shadow: 0 9px 18px rgba(0, 0, 0, 0.12), 0 5px 7px rgba(0, 0, 0, 0.05);\r\n        }\r\n\r\n        #testimonials-list .item {\r\n            text-align: center;\r\n            padding: 50px;\r\n            margin-bottom: 80px;\r\n            opacity: .2;\r\n            -webkit-transform: scale3d(0.8, 0.8, 1);\r\n            transform: scale3d(0.8, 0.8, 1);\r\n            transition: all 0.3s ease-in-out;\r\n        }\r\n\r\n        #testimonials-list .owl-item.active.center .item {\r\n            opacity: 1;\r\n            -webkit-transform: scale3d(1.0, 1.0, 1);\r\n            transform: scale3d(1.0, 1.0, 1);\r\n        }\r\n\r\n        .owl-carousel .owl-item img {\r\n            -webkit-transform-style: preserve-3d;\r\n            transform-style: preserve-3d;\r\n            max-width: 90px;\r\n            border-radius: 50%;\r\n            margin: 0 auto 17px;\r\n        }\r\n\r\n        #testimonials-list.owl-carousel .owl-dots .owl-dot.active span,\r\n        #testimonials-list.owl-carousel .owl-dots .owl-dot:hover span {\r\n            background: #3190E7;\r\n            -webkit-transform: translate3d(0px, -50%, 0px) scale(0.7);\r\n            transform: translate3d(0px, -50%, 0px) scale(0.7);\r\n        }\r\n\r\n        #testimonials-list.owl-carousel .owl-dots {\r\n            display: inline-block;\r\n            width: 100%;\r\n            text-align: center;\r\n        }\r\n\r\n        #testimonials-list.owl-carousel .owl-dots .owl-dot {\r\n            display: inline-block;\r\n        }\r\n\r\n        #testimonials-list.owl-carousel .owl-dots .owl-dot span {\r\n            background: #3190E7;\r\n            display: inline-block;\r\n            height: 20px;\r\n            margin: 0 2px 5px;\r\n            -webkit-transform: translate3d(0px, -50%, 0px) scale(0.3);\r\n            transform: translate3d(0px, -50%, 0px) scale(0.3);\r\n            -webkit-transform-origin: 50% 50% 0;\r\n            transform-origin: 50% 50% 0;\r\n            transition: all 250ms ease-out 0s;\r\n            width: 20px;\r\n        }\r\n    </style>\r\n\r\n<script>\r\n    function updateCharCount() {\r\n\r\n        const commentInput = document.getElementById(\'comment\');\r\n        const charCountElement = document.getElementById(\'char-count\');\r\n\r\n        const currentCharCount = commentInput.value.length;\r\n        charCountElement.textContent = `${currentCharCount} / 200 characters`;\r\n        // if (currentCharCount > 200) {\r\n        //     charCountElement.style.color = \'red\';\r\n        // } else {\r\n        //     charCountElement.style.color = \'black\';\r\n        // }\r\n    }\r\n</script>\";', '2023-08-30 10:09:12', '2023-08-30 12:44:01'),
(282, 'custom_footer_assets', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(283, 'facebook_login_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(284, 'facebook_login_app_id', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(285, 'facebook_login_app_secret', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(286, 'google_login_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(287, 'google_login_client_id', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(288, 'google_login_client_secret', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(289, 'free_shipping_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(290, 'free_shipping_min_amount', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(291, 'local_pickup_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(292, 'flat_rate_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(293, 'paypal_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(294, 'paypal_test_mode', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(295, 'paypal_client_id', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(296, 'paypal_secret', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(297, 'stripe_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(298, 'stripe_publishable_key', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(299, 'stripe_secret_key', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(300, 'paytm_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(301, 'paytm_test_mode', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(302, 'paytm_merchant_id', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(303, 'paytm_merchant_key', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(304, 'razorpay_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(305, 'razorpay_key_id', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(306, 'razorpay_key_secret', 0, 'N;', '2023-08-30 10:09:12', '2023-08-30 10:09:12'),
(307, 'instamojo_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(308, 'instamojo_test_mode', 0, 's:1:\"0\";', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(309, 'instamojo_api_key', 0, 'N;', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(310, 'instamojo_auth_token', 0, 'N;', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(311, 'paystack_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(312, 'paystack_test_mode', 0, 's:1:\"0\";', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(313, 'paystack_public_key', 0, 'N;', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(314, 'paystack_secret_key', 0, 'N;', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(315, 'authorizenet_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(316, 'authorizenet_test_mode', 0, 's:1:\"0\";', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(317, 'authorizenet_merchant_login_id', 0, 'N;', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(318, 'authorizenet_merchant_transaction_key', 0, 'N;', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(319, 'mercadopago_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(320, 'mercadopago_test_mode', 0, 's:1:\"0\";', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(321, 'mercadopago_supported_currency', 0, 's:3:\"UYU\";', '2023-08-30 10:09:13', '2023-08-30 10:09:13'),
(322, 'mercadopago_public_key', 0, 'N;', '2023-08-30 10:09:14', '2023-08-30 10:09:14'),
(323, 'mercadopago_access_token', 0, 'N;', '2023-08-30 10:09:14', '2023-08-30 10:09:14'),
(324, 'flutterwave_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:14', '2023-08-30 10:09:14'),
(325, 'flutterwave_test_mode', 0, 's:1:\"0\";', '2023-08-30 10:09:14', '2023-08-30 10:09:14'),
(326, 'flutterwave_public_key', 0, 'N;', '2023-08-30 10:09:14', '2023-08-30 10:09:14'),
(327, 'flutterwave_secret_key', 0, 'N;', '2023-08-30 10:09:14', '2023-08-30 10:09:14'),
(328, 'flutterwave_encryption_key', 0, 'N;', '2023-08-30 10:09:14', '2023-08-30 10:09:14'),
(329, 'cod_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:14', '2023-08-30 10:09:14'),
(330, 'bank_transfer_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:14', '2023-08-30 10:09:14'),
(331, 'check_payment_enabled', 0, 's:1:\"0\";', '2023-08-30 10:09:14', '2023-08-30 10:09:14'),
(332, 'sms_order_statuses', 0, 'N;', '2023-08-30 10:09:15', '2023-08-30 10:09:15'),
(333, 'email_order_statuses', 0, 'N;', '2023-08-30 10:09:15', '2023-08-30 10:09:15');

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
(1, 1, 'en', 's:9:\"FleetCart\";'),
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
(29, 51, 'en', 'N;'),
(30, 52, 'en', 'N;'),
(31, 53, 'en', 'N;'),
(32, 54, 'en', 'N;'),
(33, 55, 'en', 'N;'),
(34, 50, 'en', 's:92:\"Copyright © <a href=\"{{ store_url }}\">{{ store_name }}</a> {{ year }}. All rights reserved.\";'),
(35, 56, 'en', 'N;'),
(36, 57, 'en', 'N;'),
(37, 58, 'en', 'N;'),
(38, 59, 'en', 'N;'),
(39, 60, 'en', 'N;'),
(40, 61, 'en', 'N;'),
(41, 62, 'en', 'N;'),
(42, 63, 'en', 'N;'),
(43, 64, 'en', 'N;'),
(44, 65, 'en', 'N;'),
(45, 66, 'en', 'N;'),
(46, 67, 'en', 'N;'),
(47, 68, 'en', 'N;'),
(48, 69, 'en', 'N;'),
(49, 70, 'en', 'N;'),
(50, 71, 'en', 'N;'),
(51, 72, 'en', 'N;'),
(52, 73, 'en', 'N;'),
(53, 74, 'en', 'N;'),
(54, 75, 'en', 'N;'),
(55, 76, 'en', 'N;'),
(56, 77, 'en', 'N;'),
(57, 78, 'en', 'N;'),
(58, 79, 'en', 'N;'),
(59, 80, 'en', 'N;'),
(60, 81, 'en', 'N;'),
(61, 82, 'en', 'N;'),
(62, 83, 'en', 'N;'),
(63, 84, 'en', 'N;'),
(64, 85, 'en', 'N;'),
(65, 86, 'en', 'N;'),
(66, 87, 'en', 'N;'),
(67, 88, 'en', 'N;'),
(68, 89, 'en', 'N;'),
(69, 90, 'en', 'N;'),
(70, 91, 'en', 'N;'),
(71, 92, 'en', 'N;'),
(72, 243, 'en', 'N;'),
(73, 244, 'en', 'N;'),
(74, 245, 'en', 'N;');

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

-- --------------------------------------------------------

--
-- Table structure for table `testimonials`
--

CREATE TABLE `testimonials` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(50) NOT NULL,
  `comment` varchar(200) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `testimonials`
--

INSERT INTO `testimonials` (`id`, `user_id`, `user_name`, `comment`, `is_active`, `deleted_at`, `created_at`, `updated_at`) VALUES
(24, 2, 'sangeetha', 'good , it is frt comment in my account', 1, '2023-08-30 11:10:53', '2023-08-30 11:04:49', '2023-08-30 11:10:53'),
(25, 1, 'gayathri', 'nice -  giris sir account', 0, NULL, '2023-08-30 11:07:55', '2023-08-30 11:11:57'),
(26, 1, 'pavi', 'super', 1, NULL, '2023-08-30 11:08:50', '2023-08-30 11:08:50'),
(27, 2, 'Sangeetha M1', 'nice1', 1, NULL, '2023-08-30 11:09:48', '2023-08-30 11:12:38'),
(28, 1, 'Prabakaran', 'Where does it come from? Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classicalWhere does it come from? Contrary to popular belief, Lorem Ipsum is not', 1, NULL, '2023-08-30 11:24:18', '2023-08-30 12:23:38'),
(29, 1, 'sangeetha', 'good', 0, NULL, '2023-08-30 11:52:27', '2023-08-30 11:52:27'),
(30, 1, 'pavi', 'nice', 1, NULL, '2023-08-30 11:57:45', '2023-08-30 12:53:06');

-- --------------------------------------------------------

--
-- Table structure for table `testimonial_categories`
--

CREATE TABLE `testimonial_categories` (
  `testimonial_id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `exclude` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testimonial_products`
--

CREATE TABLE `testimonial_products` (
  `testimonial_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `exclude` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `testimonial_translations`
--

CREATE TABLE `testimonial_translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `testimonial_id` int(10) UNSIGNED NOT NULL,
  `locale` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  `permissions` text DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `password`, `permissions`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'GIRISH', 'SHANKAR', 'giri@santhila.co', '91404040404', '$2y$10$N9NQ0/x4BwItEArqEIKg2uzB6C/7D3.SNF9uPDVm34vxHtGAatpDu', NULL, '2023-08-30 09:57:35', '2023-08-09 06:24:33', '2023-08-30 04:27:35'),
(2, 'sangeetha', 'm', 'msangeethaece2001@gmail.com', '9788894897', '$2y$10$zXhvzjMrgCD15/tuz1NrYOttecVoUF7vxdFlfgo6XhKb1ada35VTS', '[]', '2023-08-30 16:36:53', '2023-08-30 10:28:59', '2023-08-30 11:06:53');

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
(2, 1, '2023-08-30 10:28:59', '2023-08-30 10:28:59'),
(2, 2, '2023-08-30 10:28:59', '2023-08-30 10:28:59');

-- --------------------------------------------------------

--
-- Table structure for table `wish_lists`
--

CREATE TABLE `wish_lists` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `product_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

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
-- Indexes for table `default_addresses`
--
ALTER TABLE `default_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `default_addresses_customer_id_foreign` (`customer_id`),
  ADD KEY `default_addresses_address_id_foreign` (`address_id`);

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
  ADD KEY `orders_coupon_id_index` (`coupon_id`);

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
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

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
-- Indexes for table `testimonials`
--
ALTER TABLE `testimonials`
  ADD PRIMARY KEY (`id`),
  ADD KEY `testimonials_code_index` (`comment`);

--
-- Indexes for table `testimonial_categories`
--
ALTER TABLE `testimonial_categories`
  ADD PRIMARY KEY (`testimonial_id`,`category_id`,`exclude`),
  ADD KEY `testimonial_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `testimonial_products`
--
ALTER TABLE `testimonial_products`
  ADD PRIMARY KEY (`testimonial_id`,`product_id`),
  ADD KEY `testimonial_products_product_id_foreign` (`product_id`);

--
-- Indexes for table `testimonial_translations`
--
ALTER TABLE `testimonial_translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `testimonial_translations_testimonial_id_locale_unique` (`testimonial_id`,`locale`);

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
-- AUTO_INCREMENT for table `activations`
--
ALTER TABLE `activations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `attribute_sets`
--
ALTER TABLE `attribute_sets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `attribute_set_translations`
--
ALTER TABLE `attribute_set_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `attribute_translations`
--
ALTER TABLE `attribute_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `attribute_values`
--
ALTER TABLE `attribute_values`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `attribute_value_translations`
--
ALTER TABLE `attribute_value_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `brand_translations`
--
ALTER TABLE `brand_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `category_translations`
--
ALTER TABLE `category_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupon_translations`
--
ALTER TABLE `coupon_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currency_rates`
--
ALTER TABLE `currency_rates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `default_addresses`
--
ALTER TABLE `default_addresses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `entity_files`
--
ALTER TABLE `entity_files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `flash_sales`
--
ALTER TABLE `flash_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flash_sale_products`
--
ALTER TABLE `flash_sale_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `flash_sale_translations`
--
ALTER TABLE `flash_sale_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu_item_translations`
--
ALTER TABLE `menu_item_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu_translations`
--
ALTER TABLE `menu_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `meta_data`
--
ALTER TABLE `meta_data`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `meta_data_translations`
--
ALTER TABLE `meta_data_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=95;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `option_translations`
--
ALTER TABLE `option_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `option_values`
--
ALTER TABLE `option_values`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `option_value_translations`
--
ALTER TABLE `option_value_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_downloads`
--
ALTER TABLE `order_downloads`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_products`
--
ALTER TABLE `order_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_product_options`
--
ALTER TABLE `order_product_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `page_translations`
--
ALTER TABLE `page_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `persistences`
--
ALTER TABLE `persistences`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `product_translations`
--
ALTER TABLE `product_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `reminders`
--
ALTER TABLE `reminders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=334;

--
-- AUTO_INCREMENT for table `setting_translations`
--
ALTER TABLE `setting_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `sliders`
--
ALTER TABLE `sliders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `slider_slides`
--
ALTER TABLE `slider_slides`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `slider_slide_translations`
--
ALTER TABLE `slider_slide_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `slider_translations`
--
ALTER TABLE `slider_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tag_translations`
--
ALTER TABLE `tag_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tax_classes`
--
ALTER TABLE `tax_classes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tax_class_translations`
--
ALTER TABLE `tax_class_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tax_rates`
--
ALTER TABLE `tax_rates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tax_rate_translations`
--
ALTER TABLE `tax_rate_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `testimonials`
--
ALTER TABLE `testimonials`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `testimonial_translations`
--
ALTER TABLE `testimonial_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `throttle`
--
ALTER TABLE `throttle`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
-- Constraints for table `testimonial_categories`
--
ALTER TABLE `testimonial_categories`
  ADD CONSTRAINT `testimonial_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `testimonial_categories_testimonial_id_foreign` FOREIGN KEY (`testimonial_id`) REFERENCES `testimonials` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `testimonial_products`
--
ALTER TABLE `testimonial_products`
  ADD CONSTRAINT `testimonial_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `testimonial_products_testimonial_id_foreign` FOREIGN KEY (`testimonial_id`) REFERENCES `testimonials` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `testimonial_translations`
--
ALTER TABLE `testimonial_translations`
  ADD CONSTRAINT `testimonial_translations_testimonial_id_foreign` FOREIGN KEY (`testimonial_id`) REFERENCES `testimonials` (`id`) ON DELETE CASCADE;

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
