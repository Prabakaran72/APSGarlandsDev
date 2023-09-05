-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 16, 2023 at 05:52 AM
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
(1, 1, 'TveyR9rvS1pumbnTwCerCFJ8H6ssW2i2', 1, '2023-08-09 11:54:33', '2023-08-09 06:24:33', '2023-08-09 06:24:33');

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

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `customer_id`, `first_name`, `last_name`, `address_1`, `address_2`, `city`, `state`, `zip`, `country`, `created_at`, `updated_at`) VALUES
(1, 1, 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', '2023-08-10 12:13:43', '2023-08-10 12:13:43');

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
(5, 6, 0, '2023-08-14 10:08:54', '2023-08-14 10:08:54', 'weight');

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
(2, 2, 'en', 'APS=G');

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
(20, NULL, 'pre-order', NULL, 0, 1, '2023-08-14 06:54:57', '2023-08-14 06:54:57'),
(21, 1, 'jasmine-saram', NULL, 0, 1, '2023-08-14 06:57:28', '2023-08-14 06:57:28'),
(22, 3, 'main-garland', NULL, 0, 1, '2023-08-14 07:46:50', '2023-08-14 07:46:50'),
(23, 3, 'bouquet', NULL, 0, 1, '2023-08-14 07:47:17', '2023-08-14 07:47:17'),
(24, 3, 'hand-bouquet', NULL, 0, 1, '2023-08-14 07:47:48', '2023-08-14 07:47:48'),
(25, 3, 'hand-bouquet-1yQ0zKX4', NULL, 0, 1, '2023-08-14 07:48:03', '2023-08-14 07:48:03'),
(26, 23, 'with-vase', NULL, 0, 1, '2023-08-14 08:05:30', '2023-08-14 08:05:30');

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
(25, 25, 'en', 'Loose Flowers'),
(26, 26, 'en', 'With Vase');

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
(1, 'fyi56', 10.0000, 0, 1, 200.0000, 2000.0000, 1, 1, 1, 1, '2023-08-10', '2023-08-18', NULL, '2023-08-10 12:10:22', '2023-08-11 10:41:20'),
(2, 'fyi5623', 9.0000, 0, 0, NULL, NULL, NULL, NULL, 0, 1, '2023-08-04', '2023-08-26', NULL, '2023-08-11 10:43:13', '2023-08-11 10:47:50');

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

--
-- Dumping data for table `coupon_translations`
--

INSERT INTO `coupon_translations` (`id`, `coupon_id`, `locale`, `name`) VALUES
(1, 1, 'en', 'aadi Offer'),
(2, 2, 'en', 'diwali sale');

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
(18, 16);

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
(1, 'USD', 1.0000, '2023-08-09 06:24:38', '2023-08-09 06:24:38'),
(2, 'MYR', 1.0000, '2023-08-11 05:41:39', '2023-08-11 05:41:39');

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
(1, 1, 1);

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
(22, 12, 'Modules\\Brand\\Entities\\Brand', 2, 'logo', '2023-08-10 08:10:46', '2023-08-10 08:10:46'),
(23, 3, 'Modules\\Brand\\Entities\\Brand', 2, 'banner', '2023-08-10 08:10:46', '2023-08-10 08:10:46'),
(24, 27, 'Modules\\Menu\\Entities\\MenuItem', 2, 'background_image', '2023-08-10 09:45:50', '2023-08-10 09:45:50'),
(25, 27, 'Modules\\Menu\\Entities\\MenuItem', 3, 'background_image', '2023-08-10 09:50:43', '2023-08-10 09:50:43'),
(57, 82, 'Modules\\Category\\Entities\\Category', 16, 'logo', '2023-08-14 06:21:16', '2023-08-14 06:21:16'),
(58, 82, 'Modules\\Category\\Entities\\Category', 16, 'banner', '2023-08-14 06:21:16', '2023-08-14 06:21:16'),
(59, 82, 'Modules\\Category\\Entities\\Category', 17, 'logo', '2023-08-14 06:50:49', '2023-08-14 06:50:49'),
(60, 82, 'Modules\\Category\\Entities\\Category', 17, 'banner', '2023-08-14 06:50:49', '2023-08-14 06:50:49'),
(73, 80, 'Modules\\Menu\\Entities\\MenuItem', 16, 'background_image', '2023-08-14 07:00:16', '2023-08-14 07:00:16'),
(74, 82, 'Modules\\Category\\Entities\\Category', 19, 'logo', '2023-08-14 07:04:17', '2023-08-14 07:04:17'),
(75, 87, 'Modules\\Category\\Entities\\Category', 20, 'logo', '2023-08-14 07:04:36', '2023-08-14 07:04:36'),
(76, 86, 'Modules\\Category\\Entities\\Category', 18, 'logo', '2023-08-14 07:05:12', '2023-08-14 07:05:12'),
(77, 89, 'Modules\\Category\\Entities\\Category', 21, 'logo', '2023-08-14 07:06:25', '2023-08-14 07:06:25'),
(78, 15, 'Modules\\Category\\Entities\\Category', 3, 'logo', '2023-08-14 09:24:25', '2023-08-14 09:24:25'),
(82, 8, 'Modules\\Category\\Entities\\Category', 1, 'logo', '2023-08-14 09:45:09', '2023-08-14 09:45:09'),
(85, 8, 'Modules\\Category\\Entities\\Category', 15, 'logo', '2023-08-14 09:46:04', '2023-08-14 09:46:04'),
(86, 113, 'Modules\\Product\\Entities\\Product', 5, 'base_image', '2023-08-14 09:58:24', '2023-08-14 09:58:24'),
(87, 113, 'Modules\\Product\\Entities\\Product', 5, 'additional_images', '2023-08-14 09:58:24', '2023-08-14 09:58:24'),
(88, 26, 'Modules\\Product\\Entities\\Product', 1, 'base_image', '2023-08-14 09:59:34', '2023-08-14 09:59:34'),
(89, 26, 'Modules\\Product\\Entities\\Product', 1, 'additional_images', '2023-08-14 09:59:34', '2023-08-14 09:59:34'),
(92, 34, 'Modules\\Product\\Entities\\Product', 2, 'base_image', '2023-08-14 10:01:16', '2023-08-14 10:01:16'),
(93, 34, 'Modules\\Product\\Entities\\Product', 2, 'additional_images', '2023-08-14 10:01:16', '2023-08-14 10:01:16'),
(109, 116, 'Modules\\Product\\Entities\\Product', 3, 'base_image', '2023-08-14 10:15:56', '2023-08-14 10:15:56'),
(110, 116, 'Modules\\Product\\Entities\\Product', 3, 'additional_images', '2023-08-14 10:15:56', '2023-08-14 10:15:56'),
(111, 33, 'Modules\\Product\\Entities\\Product', 3, 'additional_images', '2023-08-14 10:15:56', '2023-08-14 10:15:56'),
(162, 145, 'Modules\\Product\\Entities\\Product', 11, 'base_image', '2023-08-14 10:43:25', '2023-08-14 10:43:25'),
(163, 145, 'Modules\\Product\\Entities\\Product', 11, 'additional_images', '2023-08-14 10:43:26', '2023-08-14 10:43:26'),
(164, 146, 'Modules\\Product\\Entities\\Product', 11, 'additional_images', '2023-08-14 10:43:26', '2023-08-14 10:43:26'),
(165, 147, 'Modules\\Product\\Entities\\Product', 11, 'additional_images', '2023-08-14 10:43:26', '2023-08-14 10:43:26'),
(166, 149, 'Modules\\Product\\Entities\\Product', 11, 'additional_images', '2023-08-14 10:43:26', '2023-08-14 10:43:26'),
(175, 132, 'Modules\\Product\\Entities\\Product', 8, 'base_image', '2023-08-14 10:43:48', '2023-08-14 10:43:48'),
(176, 134, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-14 10:43:48', '2023-08-14 10:43:48'),
(177, 133, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-14 10:43:48', '2023-08-14 10:43:48'),
(178, 132, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-14 10:43:48', '2023-08-14 10:43:48'),
(179, 131, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-14 10:43:48', '2023-08-14 10:43:48'),
(180, 130, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-14 10:43:48', '2023-08-14 10:43:48'),
(181, 129, 'Modules\\Product\\Entities\\Product', 8, 'additional_images', '2023-08-14 10:43:48', '2023-08-14 10:43:48'),
(182, 125, 'Modules\\Product\\Entities\\Product', 7, 'base_image', '2023-08-14 10:43:58', '2023-08-14 10:43:58'),
(183, 127, 'Modules\\Product\\Entities\\Product', 7, 'additional_images', '2023-08-14 10:43:59', '2023-08-14 10:43:59'),
(184, 126, 'Modules\\Product\\Entities\\Product', 7, 'additional_images', '2023-08-14 10:43:59', '2023-08-14 10:43:59'),
(185, 125, 'Modules\\Product\\Entities\\Product', 7, 'additional_images', '2023-08-14 10:43:59', '2023-08-14 10:43:59'),
(186, 124, 'Modules\\Product\\Entities\\Product', 7, 'additional_images', '2023-08-14 10:43:59', '2023-08-14 10:43:59'),
(187, 122, 'Modules\\Product\\Entities\\Product', 7, 'additional_images', '2023-08-14 10:43:59', '2023-08-14 10:43:59'),
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
(271, 167, 'Modules\\Product\\Entities\\Product', 14, 'base_image', '2023-08-14 12:17:35', '2023-08-14 12:17:35'),
(272, 167, 'Modules\\Product\\Entities\\Product', 14, 'additional_images', '2023-08-14 12:17:35', '2023-08-14 12:17:35'),
(273, 165, 'Modules\\Product\\Entities\\Product', 14, 'additional_images', '2023-08-14 12:17:35', '2023-08-14 12:17:35'),
(274, 166, 'Modules\\Product\\Entities\\Product', 14, 'additional_images', '2023-08-14 12:17:35', '2023-08-14 12:17:35'),
(275, 164, 'Modules\\Product\\Entities\\Product', 14, 'additional_images', '2023-08-14 12:17:35', '2023-08-14 12:17:35'),
(276, 198, 'Modules\\Product\\Entities\\Product', 13, 'base_image', '2023-08-14 12:19:42', '2023-08-14 12:19:42'),
(277, 198, 'Modules\\Product\\Entities\\Product', 13, 'additional_images', '2023-08-14 12:19:42', '2023-08-14 12:19:42'),
(278, 156, 'Modules\\Product\\Entities\\Product', 13, 'additional_images', '2023-08-14 12:19:42', '2023-08-14 12:19:42'),
(279, 155, 'Modules\\Product\\Entities\\Product', 12, 'base_image', '2023-08-14 12:20:09', '2023-08-14 12:20:09'),
(280, 154, 'Modules\\Product\\Entities\\Product', 12, 'additional_images', '2023-08-14 12:20:09', '2023-08-14 12:20:09'),
(281, 192, 'Modules\\Product\\Entities\\Product', 9, 'base_image', '2023-08-14 12:20:29', '2023-08-14 12:20:29'),
(282, 193, 'Modules\\Product\\Entities\\Product', 9, 'additional_images', '2023-08-14 12:20:29', '2023-08-14 12:20:29'),
(283, 190, 'Modules\\Product\\Entities\\Product', 9, 'additional_images', '2023-08-14 12:20:29', '2023-08-14 12:20:29'),
(284, 192, 'Modules\\Product\\Entities\\Product', 9, 'additional_images', '2023-08-14 12:20:29', '2023-08-14 12:20:29'),
(285, 191, 'Modules\\Product\\Entities\\Product', 9, 'additional_images', '2023-08-14 12:20:29', '2023-08-14 12:20:29'),
(286, 114, 'Modules\\Product\\Entities\\Product', 6, 'base_image', '2023-08-14 12:22:16', '2023-08-14 12:22:16'),
(287, 183, 'Modules\\Product\\Entities\\Product', 6, 'additional_images', '2023-08-14 12:22:16', '2023-08-14 12:22:16'),
(288, 114, 'Modules\\Product\\Entities\\Product', 6, 'additional_images', '2023-08-14 12:22:16', '2023-08-14 12:22:16'),
(289, 199, 'Modules\\Product\\Entities\\Product', 6, 'additional_images', '2023-08-14 12:22:16', '2023-08-14 12:22:16'),
(290, 196, 'Modules\\Product\\Entities\\Product', 4, 'base_image', '2023-08-14 12:22:36', '2023-08-14 12:22:36'),
(291, 197, 'Modules\\Product\\Entities\\Product', 4, 'additional_images', '2023-08-14 12:22:37', '2023-08-14 12:22:37'),
(292, 180, 'Modules\\Product\\Entities\\Product', 4, 'additional_images', '2023-08-14 12:22:37', '2023-08-14 12:22:37'),
(309, 205, 'Modules\\Product\\Entities\\Product', 18, 'base_image', '2023-08-14 12:25:18', '2023-08-14 12:25:18'),
(310, 205, 'Modules\\Product\\Entities\\Product', 18, 'additional_images', '2023-08-14 12:25:18', '2023-08-14 12:25:18'),
(311, 204, 'Modules\\Product\\Entities\\Product', 18, 'additional_images', '2023-08-14 12:25:18', '2023-08-14 12:25:18'),
(312, 202, 'Modules\\Product\\Entities\\Product', 18, 'additional_images', '2023-08-14 12:25:18', '2023-08-14 12:25:18'),
(313, 201, 'Modules\\Product\\Entities\\Product', 18, 'additional_images', '2023-08-14 12:25:18', '2023-08-14 12:25:18'),
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
(327, 208, 'Modules\\Category\\Entities\\Category', 4, 'logo', '2023-08-14 12:42:31', '2023-08-14 12:42:31');

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
(208, 1, 'vase-flowers-is-vase-with-flowers-it_1340-28192.jpg', 'public_storage', 'media/9q08QuQ9EkVAruw6y0kKGTupv1Nx0hYd3kD7oN9f.jpg', 'jpg', 'image/jpeg', '82908', '2023-08-14 12:42:25', '2023-08-14 12:42:25');

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
(3, '2023-08-10 09:22:57', '2023-08-10 09:22:57');

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
(1, 3, 1, '2023-08-17', 56.0000, 5, 0),
(2, 3, 2, '2023-08-18', 5.0000, 5, 1);

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
(3, 3, 'en', 'aadi sale');

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
(6, 1, '2023-08-11 07:15:27', '2023-08-11 07:15:27');

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
(12, 5, 10, NULL, 3, 'page', NULL, NULL, '_self', 3, 0, 0, 1, '2023-08-11 05:55:52', '2023-08-11 06:04:32'),
(13, 5, 10, NULL, 2, 'page', NULL, NULL, '_self', 2, 0, 0, 1, '2023-08-11 05:58:04', '2023-08-11 06:04:32'),
(14, 5, 10, NULL, NULL, 'url', 'http://192.168.1.67:8000/products', NULL, '_self', 0, 0, 0, 1, '2023-08-11 06:04:23', '2023-08-11 06:25:38'),
(15, 5, 10, NULL, 4, 'page', NULL, NULL, '_self', NULL, 0, 0, 1, '2023-08-11 06:07:20', '2023-08-11 06:07:20'),
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
(38, 2, 4, NULL, NULL, 'url', 'http://192.168.1.67:8000/testimonial', NULL, '_self', NULL, 0, 0, 1, '2023-08-14 12:41:06', '2023-08-14 12:41:06');

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
(12, 12, 'en', 'Privacy Policy'),
(13, 13, 'en', 'About Us'),
(14, 14, 'en', 'Shop'),
(15, 15, 'en', 'FAQ'),
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
(38, 38, 'en', 'Testimonial');

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
(6, 6, 'en', 'Flash sale');

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
(25, 'Modules\\Product\\Entities\\Product', 18, '2023-08-14 12:25:18', '2023-08-14 12:25:18');

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
(25, 25, 'en', NULL, NULL);

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
(89, '2023_05_04_194556_rename_column_virtual_to_is_virtual', 2);

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
(6, 'checkbox', 0, 0, 0, NULL, '2023-08-14 10:19:42', '2023-08-14 10:19:42'),
(7, 'checkbox', 0, 0, 0, NULL, '2023-08-14 10:23:31', '2023-08-14 10:23:31'),
(8, 'checkbox', 0, 0, 0, NULL, '2023-08-14 10:27:46', '2023-08-14 10:27:46');

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
(8, 8, 'en', 'Pre Order');

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
(4, 4, 50.0000, 'fixed', 0, '2023-08-11 09:52:02', '2023-08-11 09:52:02'),
(5, 5, 20.0000, 'fixed', 0, '2023-08-11 11:18:21', '2023-08-11 11:18:21'),
(6, 3, 200.0000, 'fixed', 0, '2023-08-14 09:59:33', '2023-08-14 09:59:33'),
(7, 6, 190.0000, 'fixed', 0, '2023-08-14 10:19:42', '2023-08-14 10:19:42'),
(8, 6, 280.0000, 'fixed', 1, '2023-08-14 10:19:42', '2023-08-14 10:19:42'),
(9, 7, 10.0000, 'fixed', 0, '2023-08-14 10:23:31', '2023-08-14 10:23:31'),
(10, 8, 15.0000, 'fixed', 0, '2023-08-14 10:27:46', '2023-08-14 10:27:46');

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
(8, 10, 'en', 'Pre-order');

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

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_id`, `customer_email`, `customer_phone`, `customer_first_name`, `customer_last_name`, `billing_first_name`, `billing_last_name`, `billing_address_1`, `billing_address_2`, `billing_city`, `billing_state`, `billing_zip`, `billing_country`, `shipping_first_name`, `shipping_last_name`, `shipping_address_1`, `shipping_address_2`, `shipping_city`, `shipping_state`, `shipping_zip`, `shipping_country`, `sub_total`, `shipping_method`, `shipping_cost`, `coupon_id`, `discount`, `total`, `payment_method`, `currency`, `currency_rate`, `locale`, `status`, `note`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 300.0000, NULL, 0.0000, 1, 0.0000, 300.0000, 'cod', 'USD', 1.0000, 'en', 'pending', NULL, NULL, '2023-08-10 12:13:44', '2023-08-10 12:13:44'),
(2, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 5.0000, 'local_pickup', 2.0000, NULL, 0.0000, 7.0000, 'cod', 'MYR', 1.0000, 'en', 'completed', NULL, NULL, '2023-08-11 09:11:54', '2023-08-11 09:12:49'),
(3, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 56.0000, NULL, 0.0000, NULL, 0.0000, 56.0000, 'cod', 'MYR', 1.0000, 'en', 'pending', NULL, NULL, '2023-08-11 09:14:18', '2023-08-11 09:14:19'),
(4, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 56.0000, NULL, 0.0000, NULL, 0.0000, 56.0000, 'cod', 'MYR', 1.0000, 'en', 'completed', NULL, NULL, '2023-08-11 09:14:38', '2023-08-11 09:23:35'),
(5, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 5.0000, 'local_pickup', 2.0000, NULL, 0.0000, 7.0000, 'cod', 'MYR', 1.0000, 'en', 'completed', NULL, NULL, '2023-08-11 09:15:48', '2023-08-11 09:23:18'),
(6, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 140.0000, 'free_shipping', 0.0000, NULL, 0.0000, 140.0000, 'cod', 'MYR', 1.0000, 'en', 'completed', NULL, NULL, '2023-08-11 10:27:44', '2023-08-11 11:25:14'),
(7, 1, 'giri@santhila.co', '91404040404', 'Indu', 'mathi', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 'Indu', 'mathi', 'erode', NULL, 'erode', 'KUL', '638052', 'MY', 5.0000, 'local_pickup', 2.0000, NULL, 0.0000, 7.0000, 'cod', 'MYR', 1.0000, 'en', 'processing', NULL, NULL, '2023-08-12 04:40:06', '2023-08-12 08:47:20');

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

--
-- Dumping data for table `order_products`
--

INSERT INTO `order_products` (`id`, `order_id`, `product_id`, `unit_price`, `qty`, `line_total`) VALUES
(1, 1, 1, 150.0000, 2, 300.0000),
(2, 2, 2, 5.0000, 1, 5.0000),
(3, 3, 1, 56.0000, 1, 56.0000),
(4, 4, 1, 56.0000, 1, 56.0000),
(5, 5, 2, 5.0000, 1, 5.0000),
(6, 6, 3, 70.0000, 2, 140.0000),
(7, 7, 2, 5.0000, 1, 5.0000);

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
(1, 6, 4, NULL);

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
(1, 4, 50.0000);

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
(5, 'brands', 1, '2023-08-11 05:46:15', '2023-08-11 05:46:15');

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
(2, 2, 'en', 'About Us', '<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</li>\r\n<li>In luctus nunc id lectus pellentesque lacinia.</li>\r\n<li>Pellentesque laoreet mi molestie tortor aliquam, sed hendrerit nisi consectetur.</li>\r\n<li>Nam sed sapien sed lacus placerat euismod in consectetur ex.</li>\r\n<li>Sed et odio ultrices, semper sem sed, scelerisque libero.</li>\r\n<li>Proin ut ex varius libero viverra pellentesque.</li>\r\n</ul>'),
(3, 3, 'en', 'Privacy Policy', '<p>Your privacy is as important to us as it is to you. We know you hate SPAM and so do we. That is why we will never sell or share your information with anyone without your express permission. We respect your rights and will do everything in our power to protect your personal information. In the interest of full disclosure, we provide this notice explaining our online information collection practices. This privacy notice discloses the privacy practices for&nbsp;<a href=\"https://envaysoft.com/\">EnvaySoft</a>&nbsp;(herein known as we, us and our company) and applies solely to information collected by this web site.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Information Collection, Use, and Sharing</h4>\r\n<p>We are the sole owners of the information collected on this site. We only have access to information that you voluntarily give us via email or other direct contact from you. We will not sell or rent this information to anyone. We will use your information to respond to you, regarding the reason you contacted us. We will not share your information with any third party outside of our organization, other than as necessary to fulfill your request, e.g. to ship an order.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Disclosure</h4>\r\n<p>This site uses Google web analytics service. Google may record mouse clicks, mouse movements, scrolling activity as well as text you type in this website. This site does not use Google to collect any personally identifiable information entered in this website. Google does track your browsing habits across web sites which do not use Google services.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Security</h4>\r\n<p>We take precautions to protect your information. When you submit sensitive information via the website, your information is protected both online and offline.</p>\r\n<p>Wherever we collect sensitive information (such as credit card data), that information is encrypted and transmitted to us in a secure way. You can verify this by looking for a closed lock icon at the bottom of your web browser, or looking for &ldquo;https&rdquo; at the beginning of the address of the web page.</p>\r\n<p>While we use encryption to protect sensitive information transmitted online, we also protect your information offline. Only employees who need the information to perform a specific job (for example, billing or customer service) are granted access to personally identifiable information. The computers/servers in which we store personally identifiable information are kept in a secure environment.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Email Policy</h4>\r\n<p>The following are situations in which you may provide Your Information to us:</p>\r\n<p>&nbsp;</p>\r\n<ul>\r\n<li>\r\n<p>When you fill out forms or fields through our Services.</p>\r\n</li>\r\n<li>\r\n<p>When you register for an account with our Service.</p>\r\n</li>\r\n<li>\r\n<p>When you create a subscription for our newsletter or Services.</p>\r\n</li>\r\n<li>\r\n<p>When you provide responses to a survey.</p>\r\n</li>\r\n<li>\r\n<p>When you answer questions on a quiz.</p>\r\n</li>\r\n<li>\r\n<p>When you join or enroll in an event through our Services.</p>\r\n</li>\r\n<li>\r\n<p>When you order services or products from, or through our Service.</p>\r\n</li>\r\n<li>\r\n<p>When you provide information to us through a third-party application, service or Website.</p>\r\n</li>\r\n</ul>'),
(4, 4, 'en', 'Help & FAQ', '<h1>Help &amp; FAQ</h1>\r\n<p>&nbsp;</p>\r\n<p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>What does LOREM mean?</h4>\r\n<p>&lsquo;Lorem ipsum dolor sit amet, consectetur adipisici elit&hellip;&rsquo; (complete text) is dummy text that is not meant to mean anything. It is used as a placeholder in magazine layouts, for example, in order to give an impression of the finished document. The text is intentionally unintelligible so that the viewer is not distracted by the content. The language is not real Latin and even the first word &lsquo;Lorem&rsquo; does not exist. It is said that the lorem ipsum text has been common among typesetters since the 16th century.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Why do we use it?</h4>\r\n<p>It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Where does it come from?</h4>\r\n<p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Where can I get some?</h4>\r\n<p>There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<h4>Why do we use Lorem Ipsum?</h4>\r\n<p>Many times, readers will get distracted by readable text when looking at the layout of a page. Instead of using filler text that says &ldquo;Insert content here,&rdquo; Lorem Ipsum uses a normal distribution of letters, making it resemble standard English. This makes it easier for designers to focus on visual elements, as opposed to what the text on a page actually says. Lorem Ipsum is absolutely necessary in most design cases, too. Web design projects like landing pages, website redesigns and so on only look as intended when they\'re fully-fleshed out with content.</p>'),
(5, 5, 'en', 'Brands', '<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/apple/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/jZG1juhijMhWSrn8B4jgsX5x4Vb8dOTdZTtGNACo.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/samsung/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/nshpkDL124reDq8apPXBcpVrnV8ABDzC88R5gg3K.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/huawei/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/SbgS1CCecSpvvnBeBmG6xP49q2NymXQzJpiHbMAi.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/oneplus/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/JwT1Wydv8ADuSHBh7ZtCaWLkuO2Jy9WYZRovQW1W.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/hp/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/j2WP3lfi8JTanXQsxrNDclJAb2RHKxBOtlQwlK2g.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/dell/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/8bmlnpJluQBwAAJolyS708652aY6Kj8dEmYQ7woo.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/acer/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/rCfwklCfNTBKz4JGeloPqqI7BTS8PdYibzEkB8mS.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/asus/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/JnH5uK3QY3mOamQ8NsHCbtqj0xULHsjOTHtHTbeO.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/microsoft/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/HSvr36xBFke3Jh6mbDaeAG8jJZ4RH78ousrLr1i2.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/xiaomi/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/vW30vojYODrqYBs9x3ToIpBHm1zyrKU7ZhmD9SQG.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/google/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/RlQnH51zyXArkeBhIT0BCaJiyqAIcdCHCNjnsiZW.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/msi/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/8DfT3LNUhYbei3YrhJ1FscMVKiPPQi43LdCY29Am.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/lg/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/P9UF8sprnzBNqEnbAd2j82UA4b0fzk85uIZp4H4s.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/beats/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/3IcUp71JfyiH3wkWU0omhlcs0xqgdWzmY3Z4imMO.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/adidas/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/H0BnQ6XoB6vBb1YAkRg22mncLS76Yv0zGz4T4M04.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/nike/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/DbwfoaPYxERzjV8qsFUSpS9UMjskuZ5yauWC3Wtn.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/levis/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/Quysi8IloZADWNe2ZxeK98PN4FgHpoQWBXSnhlQV.png\" alt=\"brand image\" /></a></div>\r\n<div class=\"col-lg-3 col-md-6 col-9\"><a class=\"brand-image\" href=\"https://fleetcart.envaysoft.com/en/brands/nokia/products\"><img src=\"https://fleetcart.envaysoft.com/storage/media/cpX550XTke137wP71XC4bd6vGf68l6emVynXq3HJ.png\" alt=\"brand image\" /></a></div>');

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
(26, 1, 'dT60S94uZAsxPo63fnlYpGiCA0xbkpuO', '2023-08-14 11:55:26', '2023-08-14 11:55:26');

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
(1, NULL, NULL, 'wedding-garland', 200.0000, 150.0000, 'fixed', '2023-08-09', '2023-08-17', 150.0000, '25', 0, NULL, 1, 12, 1, '2023-08-09 00:00:00', '2023-08-19 00:00:00', NULL, '2023-08-09 12:42:13', '2023-08-12 08:09:20', 1),
(2, 1, NULL, 'lotus', 200.0000, 199.0000, 'fixed', NULL, NULL, 199.0000, NULL, 0, NULL, 1, 19, 1, NULL, NULL, NULL, '2023-08-09 12:57:27', '2023-08-14 12:54:05', 0),
(3, 1, NULL, 'wedding-garlands-with-white-and-green-color-mixing', 50.0000, 20.0000, 'fixed', '2023-08-11', '2023-08-26', 20.0000, '25', 0, NULL, 1, 23, 1, '2023-08-19 00:00:00', '2023-08-11 00:00:00', NULL, '2023-08-11 09:50:50', '2023-08-14 05:57:34', 0),
(4, 1, 1, 'rose', 100.0000, 2.0000, 'percent', NULL, NULL, 98.0000, '1500014', 1, 1500, 1, 17, 1, NULL, NULL, NULL, '2023-08-12 04:23:27', '2023-08-14 12:25:12', 0),
(5, 1, NULL, 'rose-petal-garlands', 25.0000, 20.0000, 'fixed', '2023-08-07', '2023-08-31', 20.0000, '25', 0, NULL, 1, 2, 1, '2023-08-07 00:00:00', '2023-08-31 00:00:00', NULL, '2023-08-14 09:58:24', '2023-08-14 10:56:27', 0),
(6, 1, 1, 'jasmine', 1000.0000, 999.0000, 'fixed', '2023-08-03', '2023-08-24', 999.0000, '25', 0, NULL, 1, 5, 1, NULL, NULL, NULL, '2023-08-14 10:02:57', '2023-08-14 12:10:24', 0),
(7, 1, NULL, 'pink-rose-bouquet', 299.0000, 158.0000, 'fixed', NULL, NULL, 158.0000, '56dfg', 0, NULL, 1, 1, 1, NULL, NULL, NULL, '2023-08-14 10:23:31', '2023-08-14 10:23:46', 0),
(8, 1, NULL, 'red-rose-bouquet', 259.0000, 145.0000, 'fixed', NULL, NULL, 145.0000, NULL, 0, NULL, 1, 1, 1, NULL, NULL, NULL, '2023-08-14 10:27:46', '2023-08-14 10:35:42', 0),
(9, 1, NULL, 'manoranjitham', 150.0000, NULL, 'fixed', NULL, NULL, 150.0000, NULL, 0, NULL, 1, 3, 1, NULL, NULL, NULL, '2023-08-14 10:33:11', '2023-08-14 12:09:53', 0),
(10, 1, NULL, 'loose-flower-red', 20.0000, 19.0000, 'fixed', NULL, NULL, 19.0000, NULL, 0, NULL, 1, 2, 1, NULL, NULL, NULL, '2023-08-14 10:38:11', '2023-08-14 12:23:09', 0),
(11, 1, NULL, 'hand-bouquet', 19.0000, 18.0000, 'fixed', NULL, NULL, 18.0000, NULL, 0, NULL, 1, 1, 1, NULL, NULL, NULL, '2023-08-14 10:42:56', '2023-08-14 10:58:10', 1),
(12, 1, 1, 'orchids', 50.0000, 49.0000, 'fixed', '2023-08-02', '2023-08-23', 49.0000, NULL, 0, NULL, 1, 5, 1, NULL, NULL, NULL, '2023-08-14 10:45:32', '2023-08-14 12:09:52', 0),
(13, 1, 1, 'vadamalli', 150.0000, 2.0000, 'percent', NULL, NULL, 147.0000, NULL, 0, NULL, 1, 1, 1, NULL, NULL, NULL, '2023-08-14 10:51:36', '2023-08-14 12:19:42', 0),
(14, 1, 1, 'lotus-yeVHn5rz', 250.0000, NULL, 'fixed', NULL, NULL, 250.0000, NULL, 0, NULL, 1, 6, 1, NULL, NULL, NULL, '2023-08-14 10:53:42', '2023-08-14 12:09:51', 0),
(15, 1, NULL, 'vettiver-malai-for-god', 25.0000, 24.0000, 'fixed', NULL, NULL, 24.0000, NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, '2023-08-14 11:05:18', '2023-08-14 11:05:18', 0),
(16, NULL, NULL, 'combo-losse-flower', 14.0000, NULL, 'fixed', NULL, NULL, 14.0000, NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, '2023-08-14 11:27:22', '2023-08-14 11:27:22', 0),
(17, 1, NULL, 'jasmine-saram', 5.0000, 2.0000, 'fixed', NULL, NULL, 2.0000, NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, '2023-08-14 12:06:21', '2023-08-14 12:06:21', 0),
(18, 1, NULL, 'mullai-saram', 10.0000, 9.0000, 'fixed', NULL, NULL, 9.0000, NULL, 0, NULL, 1, 0, 1, NULL, NULL, NULL, '2023-08-14 12:25:17', '2023-08-14 12:25:17', 0);

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
(11, 1, 1),
(17, 3, 1),
(40, 13, 5),
(41, 12, 5),
(42, 9, 5),
(43, 6, 5),
(44, 4, 5);

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
(11, 1),
(17, 1),
(40, 6),
(41, 6),
(42, 6),
(43, 6),
(44, 6);

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
(11, 20),
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
(18, 18);

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
(1, 3),
(2, 5),
(3, 4),
(4, 6),
(7, 7),
(8, 8);

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
(12, 3),
(13, 3),
(14, 3),
(17, 3),
(18, 1),
(18, 3);

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
(18, 18, 'en', 'Mullai Saram', '<p>The Mullai flowers also known as&nbsp;<strong>Arabian Jasmine</strong>&nbsp;are known for it\'s amazing fragrance.</p>', NULL);

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
(18, 17);

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
(2, 1, 4, 5, 'indu', 'nice', 1, '2023-08-14 07:08:05', '2023-08-14 07:08:05');

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
(1, '{\"admin.attributes.index\":true,\"admin.attributes.create\":true,\"admin.attributes.edit\":true,\"admin.attributes.destroy\":true,\"admin.attribute_sets.index\":true,\"admin.attribute_sets.create\":true,\"admin.attribute_sets.edit\":true,\"admin.attribute_sets.destroy\":true,\"admin.brands.index\":true,\"admin.brands.create\":true,\"admin.brands.edit\":true,\"admin.brands.destroy\":true,\"admin.categories.index\":true,\"admin.categories.create\":true,\"admin.categories.edit\":true,\"admin.categories.destroy\":true,\"admin.coupons.index\":true,\"admin.coupons.create\":true,\"admin.coupons.edit\":true,\"admin.coupons.destroy\":true,\"admin.currency_rates.index\":true,\"admin.currency_rates.edit\":true,\"admin.flash_sales.index\":true,\"admin.flash_sales.create\":true,\"admin.flash_sales.edit\":true,\"admin.flash_sales.destroy\":true,\"admin.importer.index\":true,\"admin.importer.create\":true,\"admin.media.index\":true,\"admin.media.create\":true,\"admin.media.destroy\":true,\"admin.menus.index\":true,\"admin.menus.create\":true,\"admin.menus.edit\":true,\"admin.menus.destroy\":true,\"admin.menu_items.index\":true,\"admin.menu_items.create\":true,\"admin.menu_items.edit\":true,\"admin.menu_items.destroy\":true,\"admin.options.index\":true,\"admin.options.create\":true,\"admin.options.edit\":true,\"admin.options.destroy\":true,\"admin.orders.index\":true,\"admin.orders.show\":true,\"admin.orders.edit\":true,\"admin.pages.index\":true,\"admin.pages.create\":true,\"admin.pages.edit\":true,\"admin.pages.destroy\":true,\"admin.products.index\":true,\"admin.products.create\":true,\"admin.products.edit\":true,\"admin.products.destroy\":true,\"admin.reports.index\":true,\"admin.reviews.index\":true,\"admin.reviews.edit\":true,\"admin.reviews.destroy\":true,\"admin.settings.edit\":true,\"admin.sliders.index\":true,\"admin.sliders.create\":true,\"admin.sliders.edit\":true,\"admin.sliders.destroy\":true,\"admin.tags.index\":true,\"admin.tags.create\":true,\"admin.tags.edit\":true,\"admin.tags.destroy\":true,\"admin.taxes.index\":true,\"admin.taxes.create\":true,\"admin.taxes.edit\":true,\"admin.taxes.destroy\":true,\"admin.transactions.index\":true,\"admin.translations.index\":true,\"admin.translations.edit\":true,\"admin.users.index\":true,\"admin.users.create\":true,\"admin.users.edit\":true,\"admin.users.destroy\":true,\"admin.roles.index\":true,\"admin.roles.create\":true,\"admin.roles.edit\":true,\"admin.roles.destroy\":true,\"admin.storefront.edit\":true}', '2023-08-09 06:24:33', '2023-08-11 12:43:05'),
(2, NULL, '2023-08-09 06:24:34', '2023-08-09 06:24:34');

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
(2, 'store_email', 0, 's:22:\"admin@apsgarlands.test\";', '2023-08-09 06:24:33', '2023-08-11 05:41:39'),
(3, 'store_phone', 0, 's:12:\"+121 9393939\";', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(4, 'search_engine', 0, 's:5:\"mysql\";', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(5, 'algolia_app_id', 0, 'N;', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(6, 'algolia_secret', 0, 'N;', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(7, 'active_theme', 0, 's:10:\"Storefront\";', '2023-08-09 06:24:34', '2023-08-09 06:24:34'),
(8, 'supported_countries', 0, 'a:2:{i:0;s:2:\"BD\";i:1;s:2:\"MY\";}', '2023-08-09 06:24:34', '2023-08-10 12:11:31'),
(9, 'default_country', 0, 's:2:\"MY\";', '2023-08-09 06:24:34', '2023-08-10 12:11:31'),
(10, 'supported_locales', 0, 'a:1:{i:0;s:2:\"en\";}', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(11, 'default_locale', 0, 's:2:\"en\";', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(12, 'default_timezone', 0, 's:10:\"Asia/Dhaka\";', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(13, 'customer_role', 0, 's:1:\"2\";', '2023-08-09 06:24:35', '2023-08-10 12:11:31'),
(14, 'reviews_enabled', 0, 's:1:\"1\";', '2023-08-09 06:24:35', '2023-08-10 12:11:31'),
(15, 'auto_approve_reviews', 0, 's:1:\"1\";', '2023-08-09 06:24:35', '2023-08-10 12:11:31'),
(16, 'cookie_bar_enabled', 0, 's:1:\"1\";', '2023-08-09 06:24:35', '2023-08-10 12:11:31'),
(17, 'supported_currencies', 0, 'a:1:{i:0;s:3:\"MYR\";}', '2023-08-09 06:24:35', '2023-08-11 05:41:39'),
(18, 'default_currency', 0, 's:3:\"MYR\";', '2023-08-09 06:24:35', '2023-08-11 05:41:40'),
(19, 'send_order_invoice_email', 0, 'b:0;', '2023-08-09 06:24:35', '2023-08-09 06:24:35'),
(20, 'newsletter_enabled', 0, 's:1:\"0\";', '2023-08-09 06:24:35', '2023-08-10 12:11:34'),
(21, 'local_pickup_cost', 0, 's:1:\"2\";', '2023-08-09 06:24:36', '2023-08-11 05:41:40'),
(22, 'flat_rate_cost', 0, 's:3:\"200\";', '2023-08-09 06:24:36', '2023-08-11 05:41:40'),
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
(98, 'storefront_terms_page', 0, 's:1:\"2\";', '2023-08-10 05:00:15', '2023-08-11 05:04:44'),
(99, 'storefront_privacy_page', 0, 's:1:\"3\";', '2023-08-10 05:00:15', '2023-08-11 05:04:44'),
(100, 'storefront_most_searched_keywords_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:15', '2023-08-14 06:11:30'),
(101, 'storefront_primary_menu', 0, 's:1:\"5\";', '2023-08-10 05:00:15', '2023-08-11 05:50:55'),
(102, 'storefront_category_menu', 0, 's:1:\"1\";', '2023-08-10 05:00:15', '2023-08-11 06:57:49'),
(103, 'storefront_footer_menu_one', 0, 's:1:\"2\";', '2023-08-10 05:00:15', '2023-08-11 05:33:34'),
(104, 'storefront_footer_menu_two', 0, 's:1:\"5\";', '2023-08-10 05:00:15', '2023-08-11 06:11:59'),
(105, 'storefront_features_section_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:15', '2023-08-14 04:55:43'),
(106, 'storefront_feature_1_icon', 0, 's:55:\"https://cdn.euroflorist.com/cmspr/Uk/calendaricon0.webp\";', '2023-08-10 05:00:15', '2023-08-14 04:56:10'),
(107, 'storefront_feature_2_icon', 0, 's:55:\"https://cdn.euroflorist.com/cmspr/Uk/deliveryicon0.webp\";', '2023-08-10 05:00:15', '2023-08-14 05:01:30'),
(108, 'storefront_feature_3_icon', 0, 's:54:\"https://cdn.euroflorist.com/cmspr/Uk/bouqueticon0.webp\";', '2023-08-10 05:00:15', '2023-08-14 05:01:30'),
(109, 'storefront_feature_4_icon', 0, 's:52:\"https://cdn.euroflorist.com/cmspr/Uk/hearticon0.webp\";', '2023-08-10 05:00:15', '2023-08-14 05:01:30'),
(110, 'storefront_feature_5_icon', 0, 's:45:\"<use xlink:href=\"/sprite.svg#delivery\"></use>\";', '2023-08-10 05:00:15', '2023-08-14 05:05:12'),
(111, 'storefront_product_page_banner_call_to_action_url', 0, 's:35:\"http://192.168.1.67:8000/categories\";', '2023-08-10 05:00:16', '2023-08-14 13:13:39'),
(112, 'storefront_product_page_banner_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(113, 'storefront_facebook_link', 0, 'N;', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(114, 'storefront_twitter_link', 0, 'N;', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(115, 'storefront_instagram_link', 0, 'N;', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(116, 'storefront_youtube_link', 0, 'N;', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(117, 'storefront_slider_banner_1_call_to_action_url', 0, 's:54:\"http://192.168.1.67:8000/categories/greetings/products\";', '2023-08-10 05:00:16', '2023-08-14 13:03:24'),
(118, 'storefront_slider_banner_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 11:05:22'),
(119, 'storefront_slider_banner_2_call_to_action_url', 0, 's:52:\"http://192.168.1.67:8000/categories/bouquet/products\";', '2023-08-10 05:00:16', '2023-08-14 13:03:24'),
(120, 'storefront_slider_banner_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(121, 'storefront_three_column_full_width_banners_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:16', '2023-08-14 08:35:41'),
(122, 'storefront_three_column_full_width_banners_1_call_to_action_url', 0, 's:62:\"http://192.168.1.67:8000/categories/same-day-delivery/products\";', '2023-08-10 05:00:16', '2023-08-14 13:11:52'),
(123, 'storefront_three_column_full_width_banners_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(124, 'storefront_three_column_full_width_banners_2_call_to_action_url', 0, 's:50:\"http://192.168.1.67:8000/categories/combo/products\";', '2023-08-10 05:00:16', '2023-08-14 13:11:52'),
(125, 'storefront_three_column_full_width_banners_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:16', '2023-08-10 05:00:16'),
(126, 'storefront_three_column_full_width_banners_3_call_to_action_url', 0, 's:54:\"http://192.168.1.67:8000/categories/greetings/products\";', '2023-08-10 05:00:16', '2023-08-14 13:11:53'),
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
(162, 'storefront_flash_sale_and_vertical_products_section_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:17', '2023-08-11 07:45:49'),
(163, 'storefront_flash_sale_title', 0, 's:9:\"AADI SALE\";', '2023-08-10 05:00:17', '2023-08-11 07:22:17'),
(164, 'storefront_active_flash_sale_campaign', 0, 's:1:\"3\";', '2023-08-10 05:00:18', '2023-08-11 07:23:32'),
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
(178, 'storefront_two_column_banners_1_call_to_action_url', 0, 's:62:\"http://192.168.1.67:8000/categories/festival-garlands/products\";', '2023-08-10 05:00:18', '2023-08-14 13:12:32'),
(179, 'storefront_two_column_banners_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:18', '2023-08-10 05:00:18'),
(180, 'storefront_two_column_banners_2_call_to_action_url', 0, 's:61:\"http://192.168.1.67:8000/categories/wedding-garlands/products\";', '2023-08-10 05:00:18', '2023-08-14 13:12:32'),
(181, 'storefront_two_column_banners_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:18', '2023-08-10 05:00:18'),
(182, 'storefront_product_grid_section_enabled', 0, 's:1:\"0\";', '2023-08-10 05:00:18', '2023-08-14 05:43:21'),
(183, 'storefront_product_grid_section_tab_1_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:18', '2023-08-11 07:57:14'),
(184, 'storefront_product_grid_section_tab_1_category_id', 0, 's:1:\"1\";', '2023-08-10 05:00:18', '2023-08-11 07:57:14'),
(185, 'storefront_product_grid_section_tab_1_products_limit', 0, 's:1:\"4\";', '2023-08-10 05:00:18', '2023-08-11 07:57:14'),
(186, 'storefront_product_grid_section_tab_2_product_type', 0, 's:17:\"category_products\";', '2023-08-10 05:00:18', '2023-08-11 07:57:14'),
(187, 'storefront_product_grid_section_tab_2_category_id', 0, 'N;', '2023-08-10 05:00:19', '2023-08-14 07:05:24'),
(188, 'storefront_product_grid_section_tab_2_products_limit', 0, 's:1:\"4\";', '2023-08-10 05:00:19', '2023-08-11 07:57:15'),
(189, 'storefront_product_grid_section_tab_3_product_type', 0, 's:24:\"recently_viewed_products\";', '2023-08-10 05:00:19', '2023-08-11 07:57:15'),
(190, 'storefront_product_grid_section_tab_3_category_id', 0, 'N;', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(191, 'storefront_product_grid_section_tab_3_products_limit', 0, 's:1:\"4\";', '2023-08-10 05:00:19', '2023-08-11 07:57:15'),
(192, 'storefront_product_grid_section_tab_4_product_type', 0, 's:15:\"custom_products\";', '2023-08-10 05:00:19', '2023-08-11 07:57:15'),
(193, 'storefront_product_grid_section_tab_4_category_id', 0, 'N;', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(194, 'storefront_product_grid_section_tab_4_products_limit', 0, 'N;', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(195, 'storefront_three_column_banners_enabled', 0, 's:1:\"1\";', '2023-08-10 05:00:19', '2023-08-14 05:51:24'),
(196, 'storefront_three_column_banners_1_call_to_action_url', 0, 's:64:\"http://192.168.1.67:8000/categories/devotional-garlands/products\";', '2023-08-10 05:00:19', '2023-08-14 13:08:57'),
(197, 'storefront_three_column_banners_1_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(198, 'storefront_three_column_banners_2_call_to_action_url', 0, 's:54:\"http://192.168.1.67:8000/categories/pre-order/products\";', '2023-08-10 05:00:19', '2023-08-14 13:08:57'),
(199, 'storefront_three_column_banners_2_open_in_new_window', 0, 's:1:\"0\";', '2023-08-10 05:00:19', '2023-08-10 05:00:19'),
(200, 'storefront_three_column_banners_3_call_to_action_url', 0, 's:59:\"http://192.168.1.67:8000/categories/combo-IB1js2MR/products\";', '2023-08-10 05:00:19', '2023-08-14 13:08:57'),
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
(241, 'storefront_favicon', 0, 's:1:\"4\";', '2023-08-10 10:23:23', '2023-08-14 13:01:26'),
(242, 'storefront_accepted_payment_methods_image', 0, 'N;', '2023-08-10 10:23:23', '2023-08-14 04:55:01'),
(243, 'storefront_three_column_full_width_banners_background_file_id', 0, 'N;', '2023-08-10 10:23:24', '2023-08-14 06:11:31'),
(244, 'maintenance_mode', 0, 's:1:\"1\";', '2023-08-10 12:11:31', '2023-08-14 05:46:35'),
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
(257, 'fixer_access_key', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(258, 'forge_api_key', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(259, 'currency_data_feed_api_key', 0, 'N;', '2023-08-10 12:11:32', '2023-08-10 12:11:32'),
(260, 'auto_refresh_currency_rates', 0, 's:1:\"1\";', '2023-08-10 12:11:33', '2023-08-11 05:41:40'),
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
(283, 'custom_header_assets', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(284, '', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(285, 'facebook_login_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(286, 'facebook_login_app_id', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(287, 'facebook_login_app_secret', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(288, 'google_login_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(289, 'google_login_client_id', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(290, 'google_login_client_secret', 0, 'N;', '2023-08-10 12:11:34', '2023-08-10 12:11:34'),
(291, 'free_shipping_enabled', 0, 's:1:\"1\";', '2023-08-10 12:11:34', '2023-08-11 05:41:40'),
(292, 'free_shipping_min_amount', 0, 's:2:\"80\";', '2023-08-10 12:11:34', '2023-08-11 05:41:40'),
(293, 'local_pickup_enabled', 0, 's:1:\"1\";', '2023-08-10 12:11:34', '2023-08-11 05:41:40'),
(294, 'flat_rate_enabled', 0, 's:1:\"1\";', '2023-08-10 12:11:34', '2023-08-11 05:41:40'),
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
(332, 'bank_transfer_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(333, 'check_payment_enabled', 0, 's:1:\"0\";', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(334, 'sms_order_statuses', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(335, 'email_order_statuses', 0, 'N;', '2023-08-10 12:11:36', '2023-08-10 12:11:36'),
(336, 'storefront_mail_logo', 1, NULL, '2023-08-14 13:01:26', '2023-08-14 13:01:26');

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
(1, 1, 'en', 's:12:\"Aps Garlands\";'),
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
(29, 51, 'en', 's:13:\"Welcome APS!!\";'),
(30, 52, 'en', 's:92:\"No 66, Jalan Padang Belia brickfields  50470 brickfields, Kuala Lumpur.  HQ - +6012 357 0799\";'),
(31, 53, 'en', 's:13:\"Free shipping\";'),
(32, 54, 'en', 's:12:\"Our Services\";'),
(33, 55, 'en', 's:11:\"Information\";'),
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
(60, 81, 'en', 's:4:\"test\";'),
(61, 82, 'en', 's:4:\"test\";'),
(62, 83, 'en', 's:4:\"test\";'),
(63, 84, 'en', 's:2:\"93\";'),
(64, 85, 'en', 's:2:\"98\";'),
(65, 86, 'en', 's:2:\"80\";'),
(66, 87, 'en', 's:21:\"Fantastic Diwali Sale\";'),
(67, 88, 'en', 's:5:\"TEST2\";'),
(68, 89, 'en', 's:5:\"TEST2\";'),
(69, 90, 'en', 's:5:\"TEST2\";'),
(70, 91, 'en', 's:5:\"TEST2\";'),
(71, 92, 'en', 's:2:\"76\";'),
(72, 240, 'en', 's:2:\"77\";'),
(73, 245, 'en', 'N;'),
(74, 246, 'en', 'N;'),
(75, 247, 'en', 'N;'),
(76, 336, 'en', 's:1:\"4\";');

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
(11, 3, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', 'http://192.168.1.67:8000/categories/main-garland/products', 0, 3, '2023-08-14 04:46:27', '2023-08-14 13:06:09'),
(18, 3, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', 'http://192.168.1.67:8000/categories/hand-bouquet/products', 0, 1, '2023-08-14 05:16:17', '2023-08-14 13:06:09'),
(19, 3, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', 'http://192.168.1.67:8000/categories/hand-bouquet-1yQ0zKX4/products', 0, 0, '2023-08-14 09:46:49', '2023-08-14 13:06:09'),
(20, 3, '{\"caption_1\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"caption_2\":{\"delay\":null,\"effect\":\"fadeInUp\"},\"call_to_action\":{\"delay\":null,\"effect\":\"fadeInUp\"}}', 'http://192.168.1.67:8000/categories/bouquet/products', 0, 2, '2023-08-14 09:46:50', '2023-08-14 13:06:09');

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
(11, 11, 'en', 68, NULL, NULL, 'Click here', 'right'),
(18, 18, 'en', 76, NULL, NULL, 'Click here', 'right'),
(19, 19, 'en', 109, NULL, NULL, 'Click here', 'right'),
(20, 20, 'en', 108, NULL, NULL, 'Click here', 'right');

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
(1, 1, 'MY', 'KUL', 'Kula Lumbur', '55100', 18.0000, 0, NULL, '2023-08-12 07:48:11', '2023-08-12 07:48:11'),
(2, 1, 'MY', 'KUL', 'Kuala Limbur', '55100', 12.0000, 1, NULL, '2023-08-12 07:48:11', '2023-08-12 07:48:11');

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
(21, 1, 'user', NULL, '2023-08-12 03:55:42', '2023-08-12 03:55:42');

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
(18, 17);

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
(1, 'GIRISH', 'SHANKAR', 'giri@santhila.co', '91404040404', '$2y$10$N9NQ0/x4BwItEArqEIKg2uzB6C/7D3.SNF9uPDVm34vxHtGAatpDu', NULL, '2023-08-14 17:25:26', '2023-08-09 06:24:33', '2023-08-14 11:55:26');

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
(1, 1, '2023-08-09 06:24:33', '2023-08-09 06:24:33');

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `category_translations`
--
ALTER TABLE `category_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `coupon_translations`
--
ALTER TABLE `coupon_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currency_rates`
--
ALTER TABLE `currency_rates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `default_addresses`
--
ALTER TABLE `default_addresses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `entity_files`
--
ALTER TABLE `entity_files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=328;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=209;

--
-- AUTO_INCREMENT for table `flash_sales`
--
ALTER TABLE `flash_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `flash_sale_products`
--
ALTER TABLE `flash_sale_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `flash_sale_translations`
--
ALTER TABLE `flash_sale_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `menu_item_translations`
--
ALTER TABLE `menu_item_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `menu_translations`
--
ALTER TABLE `menu_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `meta_data`
--
ALTER TABLE `meta_data`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `meta_data_translations`
--
ALTER TABLE `meta_data_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `option_translations`
--
ALTER TABLE `option_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `option_values`
--
ALTER TABLE `option_values`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `option_value_translations`
--
ALTER TABLE `option_value_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `order_downloads`
--
ALTER TABLE `order_downloads`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_products`
--
ALTER TABLE `order_products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `order_product_options`
--
ALTER TABLE `order_product_options`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `page_translations`
--
ALTER TABLE `page_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `persistences`
--
ALTER TABLE `persistences`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `product_translations`
--
ALTER TABLE `product_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `reminders`
--
ALTER TABLE `reminders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=337;

--
-- AUTO_INCREMENT for table `setting_translations`
--
ALTER TABLE `setting_translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

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
-- AUTO_INCREMENT for table `throttle`
--
ALTER TABLE `throttle`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
