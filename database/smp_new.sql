-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Aug 26, 2021 at 04:20 PM
-- Server version: 5.7.21-1ubuntu1
-- PHP Version: 7.2.25-1+ubuntu18.04.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smp_new`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address_one` text NOT NULL,
  `address_two` text NOT NULL,
  `pincode` varchar(50) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `latitude` varchar(50) NOT NULL,
  `longitude` varchar(50) NOT NULL,
  `cancel_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-no,1-yes',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `address_one`, `address_two`, `pincode`, `city`, `state`, `country`, `latitude`, `longitude`, `cancel_status`, `created_at`) VALUES
(9, 18, '2, University Road, Jala Ram Nagar', '', '360005', 'Rajkot', 'Gujarat', 'India', '22.2897351', '70.7731778', 0, '2020-10-27 07:03:36'),
(10, 14, 'Raiya Telephone Excenge, Tulsi Park, Rajkot, Gujarat 360005, India', '', '360005', 'Rajkot', 'GJ', 'India', '22.2950433042291', '70.769580937922', 0, '2020-10-29 11:49:12'),
(15, 1, 'indira circle,rajkot', '', '360005', 'Rajkot', 'Gujarat', 'India', '22.356477', '77.214563', 0, '2020-10-31 05:15:42'),
(16, 28, 'SBI Bank Chowk, Jala Ram Nagar, Rajkot, Gujarat 360007, India', '', '360007', 'Rajkot', 'GJ', 'India', '22.28926797300748', '70.77400624752045', 0, '2021-08-24 10:38:12');

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `user_name` varchar(55) NOT NULL,
  `password` varchar(150) NOT NULL,
  `first_name` varchar(55) NOT NULL,
  `last_name` varchar(55) NOT NULL,
  `email` text NOT NULL,
  `free_homedelivery_on_amount` float(10,2) NOT NULL,
  `shipping_charge` float(10,2) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `user_name`, `password`, `first_name`, `last_name`, `email`, `free_homedelivery_on_amount`, `shipping_charge`, `created_date`) VALUES
(1, 'admin', 'b3f4388fc5c9c04df9cc4f526b9484ea11aecc6203a7a6f8b75ded926f37a1e23221f45945572d1fef0df2535336933cb811af2ec1f2a5d35b3119a9b05c1318', 'Swayam', 'Patel', 'admin@admin.com', 0.00, 0.00, '2021-08-26 09:29:41');

-- --------------------------------------------------------

--
-- Table structure for table `buyers`
--

CREATE TABLE `buyers` (
  `id` int(11) NOT NULL,
  `phone` varchar(55) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `address_id` int(11) NOT NULL DEFAULT '0',
  `selected_category` text,
  `device_type` int(1) NOT NULL DEFAULT '0',
  `device_token` varchar(255) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `buyers`
--

INSERT INTO `buyers` (`id`, `phone`, `name`, `email`, `country_id`, `state_id`, `city_id`, `profile_picture`, `address_id`, `selected_category`, `device_type`, `device_token`, `created_date`) VALUES
(1, '9978789985', 'Rajesh jadav', 'rajesh@gmail.com', 101, 1, 1, '347_gallery.jpg', 15, '1,2,3', 1, 'dfsdfdf', '2021-08-26 06:00:27'),
(2, '9978789986', 'Rajesh', 'rajesh1@gmail.com', 101, 0, 0, '', 0, '', 0, '', '2020-10-14 11:38:55'),
(13, '9727312770', 'Kishan Chotaliya', 'kc@gmail.com', 2, 2, 25, 'swift_file.jpeg', 0, NULL, 1, 'ADFLdfdjf54654SS', '2020-10-21 10:09:38'),
(14, '7203060015', 'Kishan', 'kishan@gmail.com', 101, 2, 24, 'tmp-2-1603966853754', 10, '4,16', 1, 'ADFLdfdjf54654SS', '2020-10-29 11:49:15'),
(16, '+9197230333356', 'Dipali Buddhadev', 'dipali@gmail.com', 101, 4, 318, '', 0, '1,4,8,17,20,2', 0, '', '2020-10-26 13:13:30'),
(18, '+919723033369', 'Dipali Buddhadev', 'dipali@swayaminfotech.com', 101, 2, 24, 'woman-doing-a-yoga-pose-on-the-beach.jpg', 9, '1,4,16,12,19,8,17', 0, '', '2020-10-27 07:03:44'),
(21, '919978789985', 'Rajesh Jadav', 'rajeshjadav@swayaminfotech.com', 101, 1, 1, 'no_image.png', 0, NULL, 0, '', '2020-12-18 06:51:33'),
(22, '9109978789985', 'Rajesh Jadav', 'jay@gmail.com', 101, 1, 1, 'mic.png', 0, NULL, 0, '', '2020-12-08 10:29:42'),
(23, '9199787885858', 'ert', 'swayam.test8@gmail.com', 101, 1, 1, 'no_video.jpg', 0, NULL, 0, '', '2021-01-06 10:39:47'),
(24, '91234234234324', '', '', 0, 0, 0, NULL, 0, NULL, 0, '', '2021-01-06 10:42:55'),
(25, '+917046462576', 'Vasudev Rathod', 'vasudevrathod133999@gmail.com', 101, 2, 24, '', 0, '4', 0, '', '2021-08-21 05:14:46'),
(26, '+917046462579', 'Fujg', 'uffu@yg.com', 101, 1, 1, '', 0, '1,4,16,12,19,8', 0, '', '2021-08-21 09:46:38'),
(27, '984567123', 'Swayam Patel', 'swayam@test.om', 101, 1, 3, '', 0, '1,4', 1, 'ADFLdfdjf54654SS', '2021-08-24 09:42:42'),
(28, '98555254544', 'Swayam Patel', 'swayam@demo.com', 0, 0, 0, 'tmp-1-1629803724485', 16, '1,4', 1, 'ADFLdfdjf54654SS', '2021-08-24 11:23:37');

-- --------------------------------------------------------

--
-- Table structure for table `cart`
--

CREATE TABLE `cart` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` float(10,2) NOT NULL,
  `selling_price` float(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` float(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cart`
--

INSERT INTO `cart` (`id`, `user_id`, `product_id`, `price`, `selling_price`, `quantity`, `total_price`, `created_at`) VALUES
(251, 1, 10, 10000.00, 7000.00, 1, 7000.00, '2020-10-19 13:05:01'),
(252, 1, 11, 700.00, 650.00, 1, 650.00, '2020-10-19 13:05:09'),
(254, 14, 38, 800.00, 900.00, 1, 900.00, '2020-10-21 13:08:01'),
(255, 18, 28, 90.00, 0.00, 2, 180.00, '2020-10-27 06:49:08'),
(256, 25, 151, 123.00, 111.00, 1, 111.00, '2021-08-21 05:17:15'),
(257, 25, 12, 1500.00, 1400.00, 2, 2800.00, '2021-08-21 05:26:59'),
(258, 25, 150, 369.00, 333.00, 1, 333.00, '2021-08-21 06:16:35'),
(259, 25, 86, 80.00, 90.00, 1, 90.00, '2021-08-21 06:41:36'),
(260, 25, 152, 369.00, 333.00, 1, 333.00, '2021-08-21 06:58:36'),
(261, 26, 153, 369.00, 369.00, 1, 369.00, '2021-08-21 09:47:07'),
(262, 27, 153, 369.00, 369.00, 1, 369.00, '2021-08-24 09:23:43'),
(264, 27, 10, 10000.00, 7000.00, 1, 7000.00, '2021-08-24 09:33:34'),
(266, 28, 153, 369.00, 369.00, 2, 738.00, '2021-08-24 10:33:35');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(55) NOT NULL,
  `image` varchar(55) DEFAULT NULL,
  `cancel_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-no,1-yes',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`id`, `name`, `image`, `cancel_status`, `created_at`) VALUES
(1, 'Cars and Other Vehicles1', '191-car.jpeg', 0, '2018-10-12 23:59:22'),
(2, 'Money &  Bank', '346-money.jpg', 0, '2018-10-13 00:16:03'),
(3, 'Watches', '684-cassio.jpg', 0, '2018-10-13 00:16:03'),
(4, 'E-Products', '358-lp.jpg', 0, '2018-10-13 00:16:28'),
(8, 'Home Appliances', '692-home.jpg', 0, '2018-10-13 00:17:21'),
(10, 'Phones,Tablets and TVs', '1093-phone.jpg', 0, '2018-10-13 00:18:06'),
(11, 'Sports and Games', '395-ball.jpg', 0, '2018-10-13 00:18:06'),
(12, 'Furniture', '162-furniture.jpg', 0, '2018-10-13 00:18:31'),
(13, 'Houses and Apartments', '866-house.jpg', 0, '2018-10-13 00:18:31'),
(16, 'Entertainment,Shows and Tickets', '832-entertainment.jpg', 0, '2018-10-13 00:20:35'),
(17, 'Jewellery', '144-jwellery.jpg', 0, '2018-10-13 00:20:35'),
(18, 'Women', '850-fashin.jpg', 0, '2018-10-13 00:20:52'),
(19, 'Gaming', '613-game.jpg', 0, '2019-02-21 22:54:08'),
(20, 'Men', '165-men.jpg', 0, '2020-11-24 03:46:00'),
(21, 'Kids', '64-kids.jpg', 0, '2020-11-08 22:43:17');

-- --------------------------------------------------------

--
-- Table structure for table `cities`
--

CREATE TABLE `cities` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `state_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cities`
--

INSERT INTO `cities` (`id`, `name`, `state_id`) VALUES
(1, 'Bombuflat', 1),
(2, 'Garacharma', 1),
(3, 'Port Blair', 1),
(4, 'Rangat', 1),
(23, 'Avanigadda', 2),
(24, 'Badepalli', 2),
(25, 'Badvel', 2),
(301, 'Bondila', 3),
(302, 'Changlang', 3),
(303, 'Daporijo', 3),
(304, 'Deomali', 3),
(316, 'Abhayapuri', 4),
(317, 'Ambikapur', 4),
(318, 'Amguri', 4);

-- --------------------------------------------------------

--
-- Table structure for table `cms`
--

CREATE TABLE `cms` (
  `id` int(10) NOT NULL,
  `page_name` varchar(100) NOT NULL,
  `content` text NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `cms`
--

INSERT INTO `cms` (`id`, `page_name`, `content`, `created_date`, `updated_date`) VALUES
(6, 'Terms & Conditions', '<p style=\\\"margin-bottom:0px;\\\">All content of the application will be monitored by moderators. Inappropriate content will be deleted immediately by moderators without any prior notice.Pornographic or adult content is strictly prohibited. Any kind of such activity won&#39;t be tolerated and respective user account will be deleted immediately without any notice.Users are not allowed to post any kind of copy right video materials. Any kind of claims may result in suspension of user account. We allow you to upload, submit, store, send or receive content. You retain ownership of any intellectual property rights that you hold in that content. In short, what belongs to you stays yours but make it sure its yours only and you are not violating anyone&#39;s rights.<br />\r\n<br />\r\n<strong>Personal&nbsp;Information:</strong><br />\r\nWe collect information to provide better services to all of our user. we&#39;ll ask for personal information, like your name, email address, telephone number to store with your account, We are not sharing any of your personal detail out side the app and keep all data securely.<br />\r\n<br />\r\n<strong>Device&nbsp;Information:</strong><br />\r\nWe collect few require information from your device for as per the requirement of the application like accessing your gallery in in front of you, device camera, your location, device cache for better performance. We are keeping all your device information within the app and does not sharing any of those information out side application.</p>\r\n', '2018-02-26 21:32:18', '2019-07-17 04:21:29'),
(7, 'Privacy & Policy', '<p style=\\\"margin-bottom:0px;\\\">All content of the application will be monitored by moderators. Inappropriate content will be deleted immediately by moderators without any prior notice.Pornographic or adult content is strictly prohibited. Any kind of such activity won&#39;t be tolerated and respective user account will be deleted immediately without any notice.Users are not allowed to post any kind of copy right video materials. Any kind of claims may result in suspension of user account. We allow you to upload, submit, store, send or receive content. You retain ownership of any intellectual property rights that you hold in that content. In short, what belongs to you stays yours but make it sure its yours only and you are not violating anyone&#39;s rights.<br />\r\n<br />\r\n<em><strong>Personal&nbsp;Information:</strong></em><br />\r\n<em>We collect information to provide better services to all of our user. we&#39;ll ask for personal information, like your name, email address, telephone number to store with your account, We are not sharing any of your personal detail out side the app and keep all data securely.</em><br />\r\n<br />\r\n<em><strong>Device&nbsp;Information:</strong></em><br />\r\n<em>We collect few require information from your device for as per the requirement of the application like accessing your gallery in in front of you, device camera, your location, device cache for better performance. We are keeping all your device information within the app and does not sharing any of those information out side application.</em></p>\r\n', '2019-06-09 22:13:00', '2019-07-12 09:19:23');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `sortname` varchar(3) NOT NULL,
  `name` varchar(150) NOT NULL,
  `phonecode` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `sortname`, `name`, `phonecode`) VALUES
(101, 'IN', 'India', 91),
(102, 'IN', 'India1', 92);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `active` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `email`, `name`, `active`) VALUES
(1, 'rajesh@gmail.com', 'rajesh', 1);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` bigint(20) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `seller_feedback` text NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `seller_id`, `user_id`, `product_id`, `seller_feedback`, `created_date`) VALUES
(3, 1, 2, 11, 'rwerrwrewrwer', '2021-08-18 13:03:02'),
(4, 3, 2, 11, 'rwerrwrewrwer', '2021-08-18 13:09:37');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `price` float(10,2) NOT NULL,
  `selling_price` float(10,2) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_price` float(10,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-pending,1->Under Process,2->Dispatched,3->Received4->Cancelled',
  `under_process_date` datetime DEFAULT NULL,
  `dispatched_date` datetime DEFAULT NULL,
  `received_date` datetime DEFAULT NULL,
  `cancelled_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `category_id`, `price`, `selling_price`, `quantity`, `total_price`, `status`, `under_process_date`, `dispatched_date`, `received_date`, `cancelled_date`, `created_at`) VALUES
(4, 1, 14, 18, 100.00, 0.00, 1, 100.00, 1, '2020-10-31 09:19:16', '2020-10-30 12:09:34', '2020-10-30 12:09:38', NULL, '2019-07-27 05:04:22'),
(5, 2, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 05:03:56'),
(6, 4, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 08:04:02'),
(7, 5, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 08:04:43'),
(8, 6, 16, 8, 7000.00, 0.00, 1, 7000.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 08:05:24'),
(9, 7, 16, 8, 7000.00, 0.00, 1, 7000.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 10:21:37'),
(10, 8, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 10:41:10'),
(11, 9, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 10:41:11'),
(12, 10, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 10:41:13'),
(13, 11, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 10:41:14'),
(14, 12, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 10:41:15'),
(15, 13, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 10:41:16'),
(16, 14, 7, 18, 12000.00, 0.00, 1, 12000.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 11:46:17'),
(17, 14, 8, 18, 10000.00, 0.00, 1, 10000.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 11:46:17'),
(18, 15, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 13:25:32'),
(19, 16, 13, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-07-29 13:59:18'),
(20, 17, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-08-01 10:21:33'),
(21, 18, 15, 8, 15000.00, 0.00, 1, 15000.00, 0, NULL, NULL, NULL, NULL, '2019-08-01 10:27:53'),
(27, 23, 18, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:33:42'),
(28, 24, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:33:54'),
(29, 25, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:34:08'),
(30, 26, 7, 18, 12000.00, 0.00, 1, 12000.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:34:29'),
(31, 27, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:35:06'),
(32, 28, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:37:49'),
(33, 29, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:39:41'),
(34, 30, 11, 18, 700.00, 0.00, 1, 700.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:39:57'),
(35, 31, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:40:24'),
(36, 32, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:41:22'),
(37, 33, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:41:34'),
(38, 34, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-08-02 07:41:49'),
(39, 35, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-03 08:21:04'),
(40, 35, 18, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-03 08:21:04'),
(41, 36, 16, 8, 7000.00, 0.00, 1, 7000.00, 0, NULL, NULL, NULL, NULL, '2019-08-05 05:12:06'),
(42, 36, 18, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-05 05:12:07'),
(43, 37, 3, 18, 500.00, 0.00, 1, 500.00, 0, NULL, NULL, NULL, NULL, '2019-08-05 05:28:05'),
(44, 37, 11, 18, 700.00, 0.00, 1, 700.00, 0, NULL, NULL, NULL, NULL, '2019-08-05 05:28:05'),
(45, 37, 16, 8, 7000.00, 0.00, 1, 7000.00, 0, NULL, NULL, NULL, NULL, '2019-08-05 05:28:05'),
(46, 37, 18, 17, 25000.00, 0.00, 2, 50000.00, 0, NULL, NULL, NULL, NULL, '2019-08-05 05:28:06'),
(47, 38, 14, 18, 100.00, 0.00, 1, 100.00, 0, NULL, NULL, NULL, NULL, '2019-08-07 06:35:15'),
(48, 39, 10, 18, 10000.00, 7000.00, 2, 14000.00, 0, NULL, NULL, NULL, NULL, '2019-08-07 12:22:03'),
(49, 39, 14, 18, 100.00, 0.00, 2, 200.00, 0, NULL, NULL, NULL, NULL, '2019-08-07 12:22:04'),
(50, 40, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-07 12:23:44'),
(51, 41, 5, 3, 1998.00, 0.00, 1, 2000.00, 0, NULL, NULL, NULL, NULL, '2019-08-07 12:24:59'),
(52, 42, 16, 8, 7000.00, 0.00, 1, 7000.00, 0, NULL, NULL, NULL, NULL, '2019-08-07 13:29:11'),
(53, 43, 27, 20, 500.00, 0.00, 1, 500.00, 0, NULL, NULL, NULL, NULL, '2019-08-08 05:13:00'),
(54, 44, 10, 18, 10000.00, 0.00, 1, 10000.00, 0, NULL, NULL, NULL, NULL, '2019-08-09 08:10:49'),
(55, 45, 16, 8, 7000.00, 0.00, 1, 7000.00, 0, NULL, NULL, NULL, NULL, '2019-08-10 03:44:28'),
(56, 46, 28, 20, 90.00, 0.00, 1, 90.00, 0, NULL, NULL, NULL, NULL, '2019-08-16 13:32:54'),
(59, 48, 28, 20, 90.00, 0.00, 1, 90.00, 0, NULL, NULL, NULL, NULL, '2019-08-17 12:00:17'),
(62, 50, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-21 13:23:34'),
(63, 51, 10, 18, 7000.00, 7000.00, 1, 7000.00, 0, NULL, NULL, NULL, NULL, '2019-08-22 05:10:26'),
(64, 51, 28, 20, 90.00, 0.00, 1, 90.00, 0, NULL, NULL, NULL, NULL, '2019-08-22 05:10:26'),
(65, 52, 10, 18, 7000.00, 7000.00, 1, 7000.00, 0, NULL, NULL, NULL, NULL, '2019-08-22 06:17:53'),
(66, 52, 26, 21, 100.00, 0.00, 2, 200.00, 0, NULL, NULL, NULL, NULL, '2019-08-22 06:17:53'),
(67, 53, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-22 08:32:58'),
(68, 53, 28, 20, 90.00, 0.00, 2, 180.00, 0, NULL, NULL, NULL, NULL, '2019-08-22 08:32:58'),
(69, 54, 28, 20, 90.00, 0.00, 2, 180.00, 0, NULL, NULL, NULL, NULL, '2019-08-26 13:27:47'),
(70, 55, 10, 18, 7000.00, 7000.00, 1, 7000.00, 0, NULL, NULL, NULL, NULL, '2019-08-28 12:04:25'),
(71, 55, 14, 18, 100.00, 0.00, 2, 200.00, 0, NULL, NULL, NULL, NULL, '2019-08-28 12:04:25'),
(72, 55, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-28 12:04:25'),
(73, 55, 18, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-08-28 12:04:25'),
(74, 55, 28, 20, 90.00, 0.00, 4, 360.00, 0, NULL, NULL, NULL, NULL, '2019-08-28 12:04:25'),
(75, 56, 7, 18, 11500.00, 11500.00, 1, 11500.00, 0, NULL, NULL, NULL, NULL, '2019-11-27 12:19:41'),
(76, 57, 10, 18, 7000.00, 7000.00, 1, 7000.00, 0, NULL, NULL, NULL, NULL, '2019-11-30 05:01:32'),
(77, 57, 17, 17, 25000.00, 0.00, 1, 25000.00, 0, NULL, NULL, NULL, NULL, '2019-11-30 05:01:32'),
(78, 57, 28, 20, 90.00, 0.00, 3, 270.00, 0, NULL, NULL, NULL, NULL, '2019-11-30 05:01:32'),
(81, 64, 147, 13, 400.00, 400.00, 2, 800.00, 0, NULL, NULL, NULL, NULL, '2021-08-26 09:42:39'),
(82, 64, 149, 4, 200.00, 200.00, 2, 400.00, 0, NULL, NULL, NULL, NULL, '2021-08-26 09:42:39');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `sellers_id` int(11) NOT NULL,
  `product_key` varchar(64) DEFAULT NULL,
  `category_id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `image` varchar(50) DEFAULT NULL,
  `price` float(10,2) NOT NULL,
  `selling_price` float(10,2) NOT NULL,
  `description` text NOT NULL,
  `avg_rating` float(10,2) NOT NULL DEFAULT '0.00',
  `total_review` int(11) NOT NULL DEFAULT '0',
  `expected_delivery_time` varchar(50) NOT NULL,
  `cancel_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-no,1-yes',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-No,1-Yes',
  `featured_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `sellers_id`, `product_key`, `category_id`, `country_id`, `state_id`, `city_id`, `name`, `image`, `price`, `selling_price`, `description`, `avg_rating`, `total_review`, `expected_delivery_time`, `cancel_status`, `is_featured`, `featured_date`, `created_at`) VALUES
(3, 1, '39352592-52fc-11ea-b4b3-e0d55e528d90', 18, 0, 0, 0, 'watch', '347_gallery.jpg', 500.00, 0.00, 'black watch', 2.75, 2, '3 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(4, 24, '0002db68-52fc-11ea-b4b3-e0d55e528d90', 18, 0, 0, 0, 'Fastract Watch', '347_gallery.jpg', 1500.00, 1455.00, 'black watch', 0.00, 0, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(5, 24, 'f553a77e-52fb-11ea-b4b3-e0d55e528d90', 3, 0, 0, 0, 'Titan Watch', '347_gallery.jpg', 2000.00, 1998.00, 'black watch', 0.00, 0, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(6, 24, '121972a9-52fc-11ea-b4b3-e0d55e528d90', 18, 0, 0, 0, 'Cavin Klein Watch', '347_gallery.jpg', 1200.00, 1100.00, 'Ck Magnet Chain (Date & Crono Working) cash on delivery available', 0.00, 0, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(7, 1, '32e3b9a7-172e-11ea-a974-e0d55e528d90', 18, 0, 0, 0, 'Fossil Watch', '347_gallery.jpg', 12000.00, 11500.00, 'Amazing watch model. Looks great.  Colour combination is awesome.', 4.62, 4, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(8, 1, 'd6af09e5-52fb-11ea-b4b3-e0d55e528d90', 20, 0, 0, 0, 'Gaint Watch', '347_gallery.jpg', 10000.00, 9000.00, '2017 trendy style slim stone quartz watch roles watches men gold oem your brand', 0.00, 0, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(9, 24, 'e1687af4-52fb-11ea-b4b3-e0d55e528d90', 18, 0, 0, 0, 'Rado Watch', '347_gallery.jpg', 10000.00, 8550.00, 'The Rado New Original represents a classic Rado look and feel with the very latest in high performance materials. This is a Rado icon, reimagined for twenty-first century wearers.', 0.00, 0, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(10, 24, 'eab05199-52fb-11ea-b4b3-e0d55e528d90', 18, 0, 0, 0, 'Cassio Watch', '347_gallery.jpg', 10000.00, 7000.00, 'A product description is the marketing copy used to describe a product\'s value proposition to potential customers. ... As the shopper browses, they instinctively imagine having each product in hand, using it and enjoying it. The more powerful the customer\'s fantasy of owning the product, the more likely they are to buy it.', 0.00, 6, '7 days', 0, 1, '2019-08-07 11:08:47', '2019-07-26 06:37:27'),
(11, 24, '1adf4099-52fc-11ea-b4b3-e0d55e528d90', 21, 0, 0, 0, 'Skme Watch', '347_gallery.jpg', 700.00, 650.00, 'black watch', 0.00, 0, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(12, 24, '09ee4766-52fc-11ea-b4b3-e0d55e528d90', 18, 0, 0, 0, 'Daniel Klein Watch', '347_gallery.jpg', 1500.00, 1400.00, 'black watch', 0.00, 0, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(13, 24, '4280f466-52fc-11ea-b4b3-e0d55e528d90', 18, 0, 0, 0, 'Watch', '347_gallery.jpg', 100.00, 0.00, 'black watch', 0.00, 0, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(14, 1, '4acbc394-52fc-11ea-b4b3-e0d55e528d90', 18, 0, 0, 0, 'Watch', '347_gallery.jpg', 100.00, 0.00, 'black watch', 4.50, 1, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(15, 24, '5490946f-52fc-11ea-b4b3-e0d55e528d90\r\n', 8, 0, 0, 0, 'TV', '347_gallery.jpg', 15000.00, 0.00, 'LED TV', 0.00, 0, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(16, 24, '6172216c-52fc-11ea-b4b3-e0d55e528d90', 8, 0, 0, 0, 'Juicer', '347_gallery.jpg', 7000.00, 0.00, 'Fruit juicer metal body', 4.00, 1, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(17, 24, '6c164229-52fc-11ea-b4b3-e0d55e528d90', 17, 0, 0, 0, 'Neckless', '347_gallery.jpg', 25000.00, 0.00, 'Diamond neckless', 4.50, 1, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(18, 24, '758b0881-52fc-11ea-b4b3-e0d55e528d90', 17, 0, 0, 0, 'Ring', '347_gallery.jpg', 25000.00, 0.00, 'Rose gold', 0.00, 0, '7 days', 0, 0, '0000-00-00 00:00:00', '2019-07-26 06:37:27'),
(24, 24, '24ede79a-52fc-11ea-b4b3-e0d55e528d90', 4, 0, 0, 0, 'test', '347_gallery.jpg', 100.00, 95.00, 'Test', 4.00, 1, '20', 0, 0, '0000-00-00 00:00:00', '2019-08-06 08:12:05'),
(25, 24, '2e68196e-52fc-11ea-b4b3-e0d55e528d90', 12, 0, 0, 0, 'test', '347_gallery.jpg', 100.00, 80.00, 'Test', 0.00, 0, '20', 0, 0, '0000-00-00 00:00:00', '2019-08-06 08:13:00'),
(26, 24, '7f112f30-52fc-11ea-b4b3-e0d55e528d90\r\n', 21, 0, 0, 0, 'Shirt', '347_gallery.jpg', 100.00, 0.00, 'Shirt', 0.00, 0, '30', 0, 0, '0000-00-00 00:00:00', '2019-08-06 13:15:11'),
(27, 24, '86cc0cf6-52fc-11ea-b4b3-e0d55e528d90', 20, 0, 0, 0, 'Men Shirt', '347_gallery.jpg', 500.00, 0.00, 'Shirt', 3.50, 1, '20', 0, 0, '0000-00-00 00:00:00', '2019-08-06 13:17:27'),
(28, 24, '95372e94-52fc-11ea-b4b3-e0d55e528d90', 20, 0, 0, 0, 'Camisa formal shirts', '347_gallery.jpg', 90.00, 0.00, 'Casual Social Formal Shirt Legible long sleeve shirt for men slim business office shirt cotton mens white dress shirts 4XL 5XL', 3.75, 2, '5 working days', 0, 1, '2019-08-10 09:08:07', '2019-08-10 04:20:48'),
(29, 1, 'ec7511c7-1364-11eb-a725-9829a694ccea', 18, 101, 1, 1, 'Test Product', '347_gallery.jpg', 500.00, 500.00, 'test Product', 0.00, 0, '3 days', 0, 0, NULL, '2020-10-21 06:16:14'),
(30, 1, 'b11caa17-1365-11eb-a725-9829a694ccea', 18, 101, 1, 1, 'Test Product', '347_gallery.jpg', 500.00, 500.00, 'test Product', 0.00, 0, '3 days', 0, 0, NULL, '2020-10-21 06:21:44'),
(38, 2, '68c663a8-1399-11eb-8291-9829a694ccea', 4, 101, 1, 2, 'One Plus 7T New ', '347_gallery.jpg', 2300.00, 900.00, 'ybun', 0.00, 0, '4 Days', 0, 0, NULL, '2020-10-21 12:31:57'),
(41, 2, '4e4346ae-1428-11eb-a30b-9829a694ccea', 1, 101, 1, 1, 'Motorola G9', '347_gallery.jpg', 800.00, 800.00, 'ybub', 0.00, 0, '4 Days', 0, 0, NULL, '2020-10-22 05:34:50'),
(42, 2, 'ee9e76b1-142b-11eb-a30b-9829a694ccea', 1, 101, 1, 1, 'Iphone 11', '347_gallery.jpg', 788.00, 1100.00, 'jjj', 0.00, 0, 'Uijj', 0, 0, NULL, '2020-10-22 06:00:48'),
(43, 2, '8197554e-142d-11eb-a30b-9829a694ccea', 1, 101, 1, 1, 'Airdrop', '347_gallery.jpg', 200.00, 200.00, 'light blue boat wireless bluetooth.', 0.00, 0, '4 Days', 0, 0, NULL, '2020-10-22 06:12:04'),
(45, 8, '70af93fe-1434-11eb-a30b-9829a694ccea', 1, 101, 1, 1, 'Yb', '347_gallery.jpg', 900.00, 9000.00, 'vfuvb', 0.00, 0, '4 Days', 0, 0, NULL, '2020-10-22 07:01:42'),
(81, 2, 'e3b1d56f-1754-11eb-a45f-9829a694ccea', 1, 101, 1, 1, 'Jun', '347_gallery.jpg', 88.00, 99.00, 'hnni', 0.00, 0, '8 Gu', 0, 0, NULL, '2020-10-26 06:31:32'),
(82, 2, 'f6e4cb7d-1754-11eb-a45f-9829a694ccea', 1, 101, 1, 2, 'Uhi', '347_gallery.jpg', 8.00, 8.00, 'ybub', 0.00, 0, '7bb', 0, 0, NULL, '2020-10-26 06:32:05'),
(83, 2, '09ab0340-1755-11eb-a45f-9829a694ccea', 1, 101, 1, 2, 'H7i', '347_gallery.jpg', 8.00, 8.00, 'gbhuni', 0.00, 0, '6 Thuh', 0, 0, NULL, '2020-10-26 06:32:36'),
(84, 2, '30506b6e-1755-11eb-a45f-9829a694ccea', 1, 101, 1, 1, 'Yhij', '347_gallery.jpg', 89.00, 89.00, 'bynun', 0.00, 0, '7 Uj', 0, 0, NULL, '2020-10-26 06:33:41'),
(85, 2, '910e7abf-1755-11eb-a45f-9829a694ccea', 1, 101, 1, 1, 'Ubb', '347_gallery.jpg', 79.00, 89.00, 'uyni', 0.00, 0, '8 Un', 0, 0, NULL, '2020-10-26 06:36:23'),
(86, 2, 'a71e0d25-1755-11eb-a45f-9829a694ccea', 4, 101, 1, 2, 'Tinii', '347_gallery.jpg', 80.00, 90.00, 'tbuh', 3.50, 1, '8 Yb', 0, 0, NULL, '2020-10-26 06:37:00'),
(87, 2, 'c79b56a4-1755-11eb-a45f-9829a694ccea', 1, 101, 1, 2, 'Yhuh', '347_gallery.jpg', 89.00, 99.00, 'lyj8j', 0.00, 0, '8 Unn', 0, 0, NULL, '2020-10-26 06:37:55'),
(116, 10, '25c85ab6-1823-11eb-9112-9829a694ccea', 4, 101, 3, 303, 'kki', '347_gallery.jpg', 34.00, 23.00, 'Gdfg', 0.00, 0, '45', 0, 0, NULL, '2020-10-27 07:08:00'),
(147, 15, '2424b20e-1a65-11eb-9f33-9829a694ccea', 13, 101, 3, 302, '3rd', '347_gallery.jpg', 420.00, 400.00, 'This is Home Product', 0.00, 0, '3', 0, 0, NULL, '2020-10-30 04:05:26'),
(148, 15, '9b3c80b2-1aa8-11eb-b5dc-9829a694ccea', 12, 101, 3, 303, 'fgd', '347_gallery.jpg', 232.00, 23.00, 'Dfg', 0.00, 0, '98', 0, 0, NULL, '2020-10-30 12:08:22'),
(149, 18, '08457ded-d7f9-11eb-8c3d-9829a694ccea', 4, 101, 4, 318, 'Test', '347_gallery.jpg', 200.00, 200.00, 'test', 0.00, 0, '2 Days', 0, 0, NULL, '2021-06-28 10:10:15'),
(150, 18, '6e055fd9-023d-11ec-a820-9829a694cb06', 4, 101, 2, 23, 'Vjjv', '347_gallery.jpg', 369.00, 333.00, 'ugr7hikgcbivh tgubyfugtcigftguvyvy gvg h g g u t ubh g h h hch hch g hvy ycy yv', 3.00, 1, 'Vu6ft8', 0, 0, NULL, '2021-08-21 05:05:40'),
(151, 18, '8e3781ac-023d-11ec-a820-9829a694cb06', 4, 101, 2, 25, 'Ufyfvu', '347_gallery.jpg', 123.00, 111.00, 'ufufs3fthionj h tcxth n jh g  g u hu y xg h uh  y g y gh y y yx u yt ycfitv t tuc ytcu  tvy', 0.00, 0, 'Uffutcr Bugiuft Yc', 0, 0, NULL, '2021-08-21 05:06:34'),
(152, 18, '20f136b5-024d-11ec-a820-9829a694cb06', 4, 101, 2, 24, 'Ojeein', '347_gallery.jpg', 369.00, 333.00, '0jgjuutkc9yvc9uc9och7tc', 2.50, 1, 'Iggy', 0, 0, NULL, '2021-08-21 06:58:03'),
(153, 24, '1731af21-0264-11ec-a820-9829a694cb06', 4, 101, 1, 1, 'Uggu', '347_gallery.jpg', 369.00, 369.00, 'cjhdcuv', 3.50, 1, 'Vuuv7', 0, 0, NULL, '2021-08-21 09:42:25');

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `products_BEFORE_INSERT` BEFORE INSERT ON `products` FOR EACH ROW BEGIN
    IF NEW.product_key IS NULL OR ASCII(NEW.product_key) = 0 THEN
		SET NEW.product_key = UUID();
	END IF;
    SET @last_uuid = NEW.product_key;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL,
  `delete_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0-No,1-Yes',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_images`
--

INSERT INTO `product_images` (`id`, `product_id`, `image`, `delete_status`, `created_at`) VALUES
(7, 24, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 13:42:05'),
(8, 24, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 13:42:05'),
(9, 24, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 13:42:06'),
(10, 25, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 13:43:00'),
(11, 25, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 13:43:00'),
(12, 25, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 13:43:00'),
(13, 25, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 13:43:00'),
(14, 9, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 15:57:35'),
(15, 26, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:45:11'),
(16, 26, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:45:11'),
(18, 27, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:47:27'),
(19, 27, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:47:27'),
(20, 27, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:47:27'),
(21, 10, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:49:25'),
(22, 6, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:49:44'),
(23, 12, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:50:01'),
(24, 4, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:50:18'),
(25, 7, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:50:32'),
(26, 8, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:51:01'),
(27, 17, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:51:16'),
(28, 15, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:51:30'),
(29, 16, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:51:42'),
(30, 18, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:51:56'),
(31, 11, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:52:18'),
(32, 5, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 18:52:42'),
(33, 26, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 19:16:49'),
(34, 18, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 19:19:32'),
(35, 18, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 19:19:32'),
(36, 18, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-06 19:19:32'),
(37, 28, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-10 09:50:48'),
(38, 28, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-10 09:50:48'),
(39, 28, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-10 09:50:48'),
(40, 3, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-10 11:18:08'),
(41, 13, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-10 11:18:28'),
(42, 14, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2019-08-10 15:04:19'),
(126, 38, 'Screenshot_20201016-174636_Amazon.jpg', 0, '2020-10-22 10:33:39'),
(130, 41, 'Screenshot_20201017-092602_Chrome.jpg', 0, '2020-10-22 11:04:51'),
(131, 41, 'Screenshot_20201016-172328_Amazon.jpg', 0, '2020-10-22 11:04:51'),
(146, 42, 'Screenshot_20201016-172328_Amazon.jpg', 0, '2020-10-22 11:30:49'),
(149, 42, 'Screenshot_20201016-174636_Amazon.jpg', 0, '2020-10-22 11:37:54'),
(153, 42, 'Screenshot_20201017-092602_Chrome.jpg', 0, '2020-10-22 11:38:43'),
(156, 43, '20201014_214328.jpg', 0, '2020-10-22 11:42:04'),
(157, 43, '20201014_214314.jpg', 0, '2020-10-22 11:42:05'),
(158, 43, '20201014_214211.jpg', 0, '2020-10-22 11:42:05'),
(161, 45, 'Screenshot_20201017-092602_Chrome.jpg', 0, '2020-10-22 12:31:42'),
(162, 45, 'Screenshot_20201016-172328_Amazon.jpg', 0, '2020-10-22 12:31:43'),
(163, 38, '20201014_213653.jpg', 0, '2020-10-22 15:40:49'),
(164, 38, '20201014_213750.jpg', 0, '2020-10-22 15:40:50'),
(238, 81, '20201014_214349.jpg', 0, '2020-10-26 12:01:33'),
(239, 82, '20201023_222700.jpg', 0, '2020-10-26 12:02:05'),
(240, 84, '20201023_222647.jpg', 0, '2020-10-26 12:03:41'),
(241, 85, '20201014_214349.jpg', 0, '2020-10-26 12:06:24'),
(242, 86, 'Screenshot_20201025-162733_Instagram.jpg', 0, '2020-10-26 12:07:01'),
(262, 148, 'tmp-15-1604150778974', 0, '2020-10-31 18:56:18'),
(263, 148, 'tmp-16-1604150789637', 0, '2020-10-31 18:56:29'),
(266, 149, 'Screenshot_20210526-143338_Instagram.jpg', 0, '2021-06-28 15:40:16'),
(267, 149, 'Screenshot_20210525-070911_Instagram.jpg', 0, '2021-06-28 15:40:16'),
(268, 149, 'Screenshot_20210525-070029_Instagram.jpg', 0, '2021-06-28 15:40:16'),
(269, 149, 'Screenshot_20210525-070001_Instagram.jpg', 0, '2021-06-28 15:40:17'),
(270, 149, 'Screenshot_20210525-070008_Instagram.jpg', 0, '2021-06-28 15:40:17'),
(271, 149, 'Screenshot_20210525-070017_Instagram.jpg', 0, '2021-06-28 15:40:17'),
(272, 150, 'Screenshot_20210820-103522_NewsBoard.jpg', 0, '2021-08-21 10:35:40'),
(273, 150, 'Screenshot_20210820-103346_NewsBoard.jpg', 0, '2021-08-21 10:35:41'),
(274, 150, 'Screenshot_20210820-103322_NewsBoard.jpg', 0, '2021-08-21 10:35:41'),
(275, 150, 'Screenshot_20210820-103304_NewsBoard.jpg', 0, '2021-08-21 10:35:42'),
(276, 150, 'Screenshot_20210820-103223_NewsBoard.jpg', 0, '2021-08-21 10:35:42'),
(277, 150, 'Screenshot_20210820-103113_NewsBoard.jpg', 0, '2021-08-21 10:35:42'),
(278, 151, 'Screenshot_20210818-161932_Calling Arrow.jpg', 0, '2021-08-21 10:36:36'),
(279, 151, 'Screenshot_20210818-152014_Calling Arrow.jpg', 0, '2021-08-21 10:36:37'),
(280, 151, 'Screenshot_20210818-151224_Calling Arrow.jpg', 0, '2021-08-21 10:36:37'),
(281, 151, 'Screenshot_20210818-150918_Calling Arrow.jpg', 0, '2021-08-21 10:36:38'),
(282, 151, 'Screenshot_20210818-150926_Calling Arrow.jpg', 0, '2021-08-21 10:36:40'),
(283, 152, 'Screenshot_20210812-160308_MSA.jpg', 0, '2021-08-21 12:28:03'),
(284, 152, 'Screenshot_20210812-185357_MSA.jpg', 0, '2021-08-21 12:28:03'),
(285, 152, 'Screenshot_20210812-160206_MSA.jpg', 0, '2021-08-21 12:28:03'),
(286, 152, 'Screenshot_20210807-092303_Review App.jpg', 0, '2021-08-21 12:28:04'),
(287, 152, 'Screenshot_20210807-092309_Review App.jpg', 0, '2021-08-21 12:28:05'),
(288, 152, 'Screenshot_20210807-092332_Review App.jpg', 0, '2021-08-21 12:28:05'),
(289, 152, 'Screenshot_20210807-092321_Review App.jpg', 0, '2021-08-21 12:28:06'),
(290, 152, 'Screenshot_20210807-130004_Travel Portal Of India.jpg', 0, '2021-08-21 12:28:07'),
(291, 153, 'Screenshot_20210820-103304_NewsBoard.jpg', 0, '2021-08-21 15:12:25'),
(292, 153, 'Screenshot_20210820-103223_NewsBoard.jpg', 0, '2021-08-21 15:12:25'),
(293, 153, 'Screenshot_20210820-103113_NewsBoard.jpg', 0, '2021-08-21 15:12:25');

-- --------------------------------------------------------

--
-- Table structure for table `product_order`
--

CREATE TABLE `product_order` (
  `id` int(11) NOT NULL,
  `unique_order_id` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address_id` int(11) NOT NULL,
  `total_shipping` float(10,2) NOT NULL,
  `total_price` float(10,2) NOT NULL,
  `order_total` float(10,2) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0-Pending,1-partially delivered, 2-Delivered',
  `full_address` text NOT NULL,
  `latitude` varchar(50) NOT NULL,
  `longitude` varchar(50) NOT NULL,
  `partially_delivered_date` datetime DEFAULT NULL,
  `delivered_date` datetime DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_order`
--

INSERT INTO `product_order` (`id`, `unique_order_id`, `user_id`, `address_id`, `total_shipping`, `total_price`, `order_total`, `status`, `full_address`, `latitude`, `longitude`, `partially_delivered_date`, `delivered_date`, `created_at`) VALUES
(1, 'OD20190727070422274', 1, 1, 0.00, 100.00, 100.00, 1, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '2020-10-31 09:19:16', '2020-10-30 12:09:38', '2019-07-27 05:04:22'),
(2, 'OD20190729070356023', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '2019-07-29 13:18:55', '0000-00-00 00:00:00', '2019-07-29 05:03:56'),
(4, 'OD20190729100402026', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '2019-07-29 13:19:03', '0000-00-00 00:00:00', '2019-07-29 08:04:02'),
(5, 'OD20190729100443243', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-07-29 08:04:43'),
(6, 'OD20190729100524416', 1, 1, 0.00, 7000.00, 7000.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-07-29 08:05:24'),
(7, 'OD20190729122137353', 1, 1, 0.00, 7000.00, 7000.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '2019-07-29 13:18:06', '0000-00-00 00:00:00', '2019-07-29 10:21:37'),
(8, 'OD20190729124110350', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-07-29 10:41:10'),
(9, 'OD20190729124111326', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-07-29 10:41:11'),
(10, 'OD20190729124113366', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '2019-07-29 13:18:13', '0000-00-00 00:00:00', '2019-07-29 10:41:13'),
(11, 'OD20190729124114203', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-07-29 10:41:14'),
(12, 'OD20190729124115534', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '2019-07-29 13:18:39', '0000-00-00 00:00:00', '2019-07-29 10:41:15'),
(13, 'OD20190729124116311', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '2019-07-29 13:18:02', '0000-00-00 00:00:00', '2019-07-29 10:41:16'),
(14, 'OD20190729014617106', 1, 1, 0.00, 22000.00, 22000.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat', '22.2886331', '70.7691655', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-07-29 11:46:17'),
(15, 'OD20190729032532630', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat, rajkot, , , ', '22.2886331', '70.7691655', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-07-29 13:25:32'),
(16, 'OD20190729035917544', 1, 3, 0.00, 100.00, 100.00, 0, 'indira circle,rajkot, 360005, rajkot, gujrat, india', '22.356485', '77.214563', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-07-29 13:59:17'),
(17, 'OD20190801122133342', 1, 4, 0.00, 100.00, 100.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-01 10:21:33'),
(18, 'OD20190801122753125', 1, 4, 0.00, 15000.00, 15000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-01 10:27:53'),
(23, 'OD20190802093342142', 1, 4, 0.00, 25000.00, 25000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:33:42'),
(24, 'OD20190802093354135', 1, 4, 0.00, 25000.00, 25000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:33:54'),
(25, 'OD20190802093408334', 1, 4, 0.00, 25000.00, 25000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:34:08'),
(26, 'OD20190802093429444', 1, 4, 0.00, 12000.00, 12000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:34:29'),
(27, 'OD20190802093506361', 1, 4, 0.00, 25000.00, 25000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:35:06'),
(28, 'OD20190802093749666', 1, 4, 0.00, 25000.00, 25000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:37:49'),
(29, 'OD20190802093941644', 1, 4, 0.00, 25000.00, 25000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:39:41'),
(30, 'OD20190802093957665', 1, 4, 0.00, 700.00, 700.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:39:57'),
(31, 'OD20190802094024511', 1, 4, 0.00, 100.00, 100.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:40:24'),
(32, 'OD20190802094122160', 1, 4, 0.00, 25000.00, 25000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:41:22'),
(33, 'OD20190802094134135', 1, 4, 0.00, 100.00, 100.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:41:34'),
(34, 'OD20190802094149303', 1, 4, 0.00, 100.00, 100.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-02 07:41:49'),
(35, 'OD20190803102104063', 1, 4, 0.00, 50000.00, 50000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '2019-08-07 15:19:50', '0000-00-00 00:00:00', '2019-08-03 08:21:04'),
(36, 'OD20190805071206332', 1, 4, 0.00, 32000.00, 32000.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '2019-08-07 15:19:40', '0000-00-00 00:00:00', '2019-08-05 05:12:06'),
(37, 'OD20190805072805140', 1, 4, 0.00, 58200.00, 58200.00, 0, 'Doctor Rajendra Prasad Road, Street Number 8, Trikon Baug, 360001, Rajkot, Gujarat, India', '22.2944271', '70.7995584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-05 05:28:05'),
(38, 'OD20190807120515534', 1, 1, 0.00, 100.00, 100.00, 0, 'Indira Circle, Royal Park, Rajkot, Gujarat, rajkot, , , ', '22.2886331', '70.7691655', '0000-00-00 00:00:00', '2019-08-07 15:19:36', '2019-08-07 06:35:15'),
(39, 'OD20190807055203223', 2, 16, 0.00, 14200.00, 14200.00, 0, 'Rajkot Highway, Gandhi Society, Gayatri Dham, Bajrang Wadi, 360006, Rajkot, Gujarat, India', '22.3278136', '70.7710843', '2019-08-07 18:57:59', '0000-00-00 00:00:00', '2019-08-07 12:22:03'),
(40, 'OD20190807055344653', 2, 16, 0.00, 25000.00, 25000.00, 0, 'Rajkot Highway, Gandhi Society, Gayatri Dham, Bajrang Wadi, 360006, Rajkot, Gujarat, India', '22.3278136', '70.7710843', '2019-08-07 18:57:35', '2019-08-08 10:45:40', '2019-08-07 12:23:44'),
(41, 'OD20190807055459153', 2, 16, 0.00, 1998.00, 1998.00, 0, 'Rajkot Highway, Gandhi Society, Gayatri Dham, Bajrang Wadi, 360006, Rajkot, Gujarat, India', '22.3278136', '70.7710843', '2019-08-07 18:57:29', '2019-08-07 18:57:49', '2019-08-07 12:24:59'),
(42, 'OD20190807065911401', 2, 16, 0.00, 7000.00, 7000.00, 0, 'Rajkot Highway, Gandhi Society, Gayatri Dham, Bajrang Wadi, 360006, Rajkot, Gujarat, India', '22.3278136', '70.7710843', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-07 13:29:11'),
(43, 'OD20190808104300646', 2, 16, 0.00, 500.00, 500.00, 0, 'Rajkot Highway, Gandhi Society, Gayatri Dham, Bajrang Wadi, 360006, Rajkot, Gujarat, India', '22.3278136', '70.7710843', '2019-08-08 10:45:30', '0000-00-00 00:00:00', '2019-08-08 05:13:00'),
(44, 'OD20190809014049531', 1, 18, 0.00, 10000.00, 10000.00, 0, 'Rajkot - Ahmedabad Hwy, Chotila, Gujarat 363520, India 363520, 363520, Chotila, Gujarat, India', '22.4328215100407', '71.2099996581674', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-09 08:10:49'),
(45, 'OD20190810091428154', 10, 19, 0.00, 7000.00, 7000.00, 0, 'Delhi Rd, Rajiv Nagar, Sector 13, 122001, Gurugram, Haryana, India', '28.4813266', '77.04902059999999', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-10 03:44:28'),
(46, 'OD20190816070254265', 2, 23, 0.00, 90.00, 90.00, 0, 'Arvindbhai Maniyar Apartment, Nutan Nagar, Kotecha Nagar, 360001, Rajkot, Gujarat, India', '22.2894', '70.77939833333333', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-16 13:32:54'),
(48, 'OD20190817053017160', 2, 31, 0.00, 90.00, 90.00, 0, 'Unnamed Road, Jala Ram Nagar, 360007, Rajkot, Gujarat, India', '22.2895553', '70.7730572', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-17 12:00:17'),
(50, 'OD20190821065334655', 11, 31, 0.00, 25000.00, 25000.00, 0, 'Rajkot Hwy, Chotila, Gujarat 363520, India, 363520, Chotila, Gujarat, India', '22.4258416547268', '71.2040307372808', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-21 13:23:34'),
(51, 'OD20190822104026425', 11, 32, 0.00, 7090.00, 7090.00, 0, 'AA/17, Vinayak Vatika B/h, Somnath Petrol Pump, Manharpura 1, Madhapar, Rajkot, Gujarat 360006, India, 360006, Rajkot, Gujarat, India', '22.3275462993429', '70.7648384571075', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-22 05:10:26'),
(52, 'OD20190822114753511', 13, 33, 0.00, 7200.00, 7200.00, 0, '256, Rd Number 19, Wadla Village, Wadala, Mumbai, Maharashtra 400031, India, 400031, Mumbai, Maharashtra, India', '19.0176146774927', '72.8561645373702', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-22 06:17:53'),
(53, 'OD20190822020258614', 11, 32, 0.00, 25180.00, 25180.00, 0, 'AA/17, Vinayak Vatika B/h, Somnath Petrol Pump, Manharpura 1, Madhapar, Rajkot, Gujarat 360006, India, 360006, Rajkot, Gujarat, India', '22.3275462993429', '70.7648384571075', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-22 08:32:58'),
(54, 'OD20190826065747653', 11, 32, 0.00, 180.00, 180.00, 0, 'AA/17, Vinayak Vatika B/h, Somnath Petrol Pump, Manharpura 1, Madhapar, Rajkot, Gujarat 360006, India, 360006, Rajkot, Gujarat, India', '22.3275462993429', '70.7648384571075', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-26 13:27:47'),
(55, 'OD20190828053425630', 11, 32, 0.00, 57560.00, 57560.00, 0, 'AA/17, Vinayak Vatika B/h, Somnath Petrol Pump, Manharpura 1, Madhapar, Rajkot, Gujarat 360006, India, 360006, Rajkot, Gujarat, India', '22.3275462993429', '70.7648384571075', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-08-28 12:04:25'),
(56, 'OD20191127054941310', 12, 24, 0.00, 11500.00, 11500.00, 0, 'Kalakruti Complex, University Road, Jala Ram Nagar, 360007, Rajkot, Gujarat, India', '22.289397336587246', '70.77297393232584', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-11-27 12:19:41'),
(57, 'OD20191130103131062', 11, 32, 0.00, 32270.00, 32270.00, 0, 'AA/17, Vinayak Vatika B/h, Somnath Petrol Pump, Manharpura 1, Madhapar, Rajkot, Gujarat 360006, India, 360006, Rajkot, Gujarat, India', '22.3275462993429', '70.7648384571075', '0000-00-00 00:00:00', '0000-00-00 00:00:00', '2019-11-30 05:01:31'),
(58, 'OD20210824050109727', 28, 16, 0.00, 0.00, 0.00, 0, 'SBI Bank Chowk, Jala Ram Nagar, Rajkot, Gujarat 360007, India, 360007, null, null, null', '22.28926797300748', '70.77400624752045', NULL, NULL, '2021-08-24 11:31:09'),
(64, 'OD20210826031238365', 28, 9, 0.00, 1200.00, 1200.00, 0, '2, University Road, Jala Ram Nagar, 360005, null, null, null', '22.2897351', '70.7731778', NULL, NULL, '2021-08-26 09:42:38');

-- --------------------------------------------------------

--
-- Table structure for table `product_review`
--

CREATE TABLE `product_review` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `seller_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `rating` float(10,2) NOT NULL,
  `review` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_review`
--

INSERT INTO `product_review` (`id`, `user_id`, `seller_id`, `product_id`, `rating`, `review`, `created_at`) VALUES
(4, 2, 0, 81, 8.00, 'Model design & its body will great.\r\nEasily wear in all types of cloths', '2021-05-26 06:11:52'),
(5, 10, 0, 81, 3.50, 'Not bad', '2021-05-26 06:13:05'),
(6, 1, 0, 14, 4.50, 'Superb....', '2019-08-01 08:29:03'),
(7, 9, 0, 7, 2.50, 'So the Explanation of the British Course on Review Text. Hopefully by reading our explanation above can add to the understanding of this material. Okay enough so, and thanks for the visit. If you have any questions or comments regarding this material please leave a comment, So the Explanation of the British Course on Review Text. Hopefully by reading our explanation above can add to the understanding of this material. Okay enough so, and thanks for the visit. If you have any questions or comments regarding this material please leave a comment.So the Explanation of the British Course on Review Text. Hopefully by reading our explanation above can add to the understanding of this material. Okay enough so, and thanks for the visit. If you have any questions or comments regarding this material please leave a comment, So the Explanation of the British Course on Review Text. Hopefully by reading our explanation above can add to the understanding of this material. Okay enough so, and thanks for the visit. If you have any questions or comments regarding this material please leave a comment.So the Explanation of the British Course on Review Text. Hopefully by reading our explanation above can add to the understanding of this material. Okay enough so, and thanks for the visit. If you have any questions or comments regarding this material please leave a comment, So the Explanation of the British Course on Review Text. Hopefully by reading our explanation above can add to the understanding of this material. Okay enough so, and thanks for the visit. If you have any questions or comments regarding this material please leave a comment.', '2019-08-08 11:42:05'),
(8, 1, 0, 4, 4.00, 'Superb Product', '2019-08-12 10:33:03'),
(9, 1, 0, 28, 2.50, 'Material of shirt is great and amazing color.', '2019-08-13 04:39:39'),
(10, 12, 0, 24, 4.00, 'Niccccc watch... ', '2019-08-17 12:31:13'),
(11, 12, 0, 17, 4.50, 'Nice design', '2019-08-17 12:31:56'),
(12, 12, 0, 16, 4.00, 'Great function of this juicer', '2019-08-17 12:33:07'),
(13, 2, 0, 27, 3.50, 'Nice color. Fitting of shirt is great', '2019-08-17 12:33:57'),
(17, 18, 15, 128, 4.50, 'Nice product.. must buy..', '2020-10-27 10:46:25'),
(18, 14, 15, 148, 4.50, 'Xyzzzzzzzz', '2021-05-26 05:48:16'),
(24, 1, 1, 148, 3.50, 'good', '2021-05-26 05:49:05'),
(25, 2, 1, 3, 2.00, 'good', '2020-10-31 04:21:45'),
(26, 25, 2, 86, 3.50, 'Nice', '2021-08-21 06:41:58'),
(27, 25, 18, 150, 3.00, 'Nice', '2021-08-21 06:46:42'),
(28, 25, 18, 152, 2.50, 'Good', '2021-08-21 06:59:03'),
(29, 26, 24, 153, 3.50, 'Nice', '2021-08-21 09:46:58'),
(30, 27, 24, 28, 5.00, 'Great', '2021-08-24 10:08:42');

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

CREATE TABLE `sellers` (
  `id` int(11) NOT NULL,
  `phone` varchar(55) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `country_id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `city_id` int(11) NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `seller_total_review` int(11) NOT NULL DEFAULT '0',
  `seller_avg_rating` float(10,2) NOT NULL DEFAULT '0.00',
  `device_type` int(1) NOT NULL DEFAULT '0',
  `device_token` varchar(255) NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `sellers`
--

INSERT INTO `sellers` (`id`, `phone`, `name`, `email`, `country_id`, `state_id`, `city_id`, `profile_picture`, `seller_total_review`, `seller_avg_rating`, `device_type`, `device_token`, `created_date`) VALUES
(1, '9978789985', 'Rajesh', 'rajesh@gmail.com', 101, 2, 24, '347_gallery.jpg', 2, 2.75, 0, '', '2020-10-31 04:21:45'),
(2, '1236547890', 'Tony', 'tonystark@gmail.com', 101, 2, 24, 'IMG-20201022-WA0021.jpg', 1, 3.50, 0, '', '2021-08-21 06:41:58'),
(4, '777788899', '', '', 0, 0, 0, NULL, 0, 0.00, 1, 'android', '2020-10-20 11:46:33'),
(5, '1236547899', 'Tony Stark', 'tony@gmail.com', 101, 2, 23, '', 0, 0.00, 1, 'android', '2020-10-20 12:12:44'),
(6, '1236547888', 'Tiny', 'tiny@gmail.com', 101, 2, 23, '', 0, 0.00, 1, 'android', '2020-10-20 12:19:11'),
(7, '1236548890', '', '', 0, 0, 0, NULL, 0, 0.00, 1, 'android', '2020-10-21 03:56:45'),
(8, '1478523690', 'Tony', 'tonys@gmail.com', 101, 1, 1, '1603284980967.jpg', 0, 0.00, 0, '', '2020-10-22 09:18:10'),
(10, '9727312770', 'Kishan', 'kc@gmail.com', 101, 3, 303, '', 0, 0.00, 0, '', '2020-10-28 12:05:35'),
(11, '1212121212', '', '', 0, 0, 0, NULL, 0, 0.00, 0, '', '2020-10-22 09:49:47'),
(12, '1231231231', 'Tony Stark', 'tony1@gmail.com', 101, 1, 1, '', 0, 0.00, 0, '', '2020-10-26 04:51:11'),
(13, '5485584869', '', '', 0, 0, 0, NULL, 0, 0.00, 1, 'android', '2020-10-22 10:47:17'),
(14, '9727312270', '', '', 0, 0, 0, NULL, 0, 0.00, 1, 'IOSBLANKFCMTOKEN', '2020-10-22 10:58:44'),
(15, '7203060015', 'Jacky', 'jacky@gmail.com', 101, 4, 4, 'tmp-1-1604051370692', 0, 0.00, 0, '', '2020-10-31 13:27:55'),
(16, '9727312789', '', '', 0, 0, 0, NULL, 0, 0.00, 1, 'IOSBLANKFCMTOKEN', '2020-10-22 11:39:36'),
(17, '0000000000', '', '', 0, 0, 0, NULL, 0, 0.00, 1, 'android', '2020-10-26 05:58:27'),
(18, '7046462574', 'Tony Stark', 'tonystarkone@gmail.com', 101, 4, 318, 'IMG-20210821-WA0021.jpg', 1, 2.50, 1, 'android', '2021-08-21 06:59:58'),
(19, '9998552523', '', '', 0, 0, 0, NULL, 0, 0.00, 1, 'eRRDXsOM2B8:APA91bHUp_5jgv3FM5ocj4ggy2YmtuABtOl-9RtGGfnyk-cojXxtMqdJ7nudI5J0fzMYJmYcVcdqssG2OheeLgizg5-quB1PPOUKsTvvNnRfkZ9M7N_xtWP77lFJaolH5hFWS0pR8rSS', '2020-10-29 05:10:14'),
(20, '7203006015', '', '', 0, 0, 0, NULL, 0, 0.00, 1, 'android', '2020-10-29 05:14:54'),
(21, '7203060150', '', '', 0, 0, 0, NULL, 0, 0.00, 1, 'eRRDXsOM2B8:APA91bHUp_5jgv3FM5ocj4ggy2YmtuABtOl-9RtGGfnyk-cojXxtMqdJ7nudI5J0fzMYJmYcVcdqssG2OheeLgizg5-quB1PPOUKsTvvNnRfkZ9M7N_xtWP77lFJaolH5hFWS0pR8rSS', '2020-10-29 05:16:44'),
(22, '1234567890', '', '', 0, 0, 0, NULL, 0, 0.00, 0, '', '2020-10-29 12:02:54'),
(23, '7897897897', '', '', 0, 0, 0, NULL, 0, 0.00, 0, '', '2020-10-31 13:29:01'),
(24, '7046462578', 'Vasudev Rathod', 'vasudevrathod133999@gmail.com', 101, 1, 1, 'IMG-20210821-WA0054.jpg', 2, 3.75, 1, 'android', '2021-08-24 10:08:42');

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `country_id` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`id`, `name`, `country_id`) VALUES
(1, 'Andaman and Nicobar Islands', 101),
(2, 'Andhra Pradesh', 101),
(3, 'Arunachal Pradesh', 101),
(4, 'Assam', 101);

-- --------------------------------------------------------

--
-- Table structure for table `verify_phone`
--

CREATE TABLE `verify_phone` (
  `id` int(11) NOT NULL,
  `phone` varchar(25) NOT NULL,
  `verification_code` varchar(10) NOT NULL,
  `verified` int(1) NOT NULL DEFAULT '0',
  `user_type` tinyint(1) NOT NULL COMMENT '0->buyer,1->sellers',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `wishlist`
--

CREATE TABLE `wishlist` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `wishlist`
--

INSERT INTO `wishlist` (`id`, `user_id`, `product_id`, `created_at`) VALUES
(46, 9, 16, '2019-07-31 13:41:39'),
(47, 9, 15, '2019-08-01 10:41:54'),
(48, 9, 17, '2019-08-02 05:21:00'),
(53, 9, 12, '2019-08-06 10:33:32'),
(57, 9, 14, '2019-08-06 10:38:17'),
(62, 9, 18, '2019-08-06 13:47:00'),
(184, 2, 26, '2019-08-20 04:15:04'),
(195, 2, 8, '2019-08-20 05:07:50'),
(198, 2, 12, '2019-08-20 05:08:21'),
(219, 2, 25, '2019-08-20 10:38:48'),
(221, 2, 10, '2019-08-20 11:19:04'),
(222, 2, 16, '2019-08-20 11:19:12'),
(239, 12, 10, '2019-08-21 09:00:55'),
(241, 12, 28, '2019-08-21 09:21:38'),
(242, 12, 17, '2019-08-21 09:26:01'),
(244, 2, 14, '2019-08-21 09:30:44'),
(245, 2, 3, '2019-08-21 09:30:53'),
(251, 13, 17, '2019-08-22 06:17:04'),
(252, 13, 15, '2019-08-22 06:17:09'),
(253, 2, 17, '2019-08-22 07:47:35'),
(254, 2, 15, '2019-08-22 07:47:42'),
(258, 11, 24, '2019-08-27 04:47:20'),
(272, 11, 28, '2019-08-27 11:29:08'),
(275, 11, 10, '2019-08-27 12:58:22'),
(276, 11, 15, '2019-08-28 13:50:00'),
(277, 11, 25, '2019-08-28 13:50:03'),
(278, 11, 17, '2019-08-29 05:50:42'),
(279, 11, 16, '2019-08-29 05:52:01'),
(283, 1, 10, '2019-11-27 13:55:22'),
(286, 2, 28, '2020-02-18 07:04:20'),
(291, 1, 17, '2020-03-14 11:29:50'),
(292, 1, 28, '2020-03-14 11:29:52'),
(293, 1, 16, '2020-03-14 11:29:54'),
(294, 1, 18, '2020-03-14 11:29:59'),
(295, 1, 27, '2020-03-14 11:30:03'),
(296, 1, 26, '2020-03-14 11:30:05'),
(297, 1, 15, '2020-03-14 11:30:07'),
(298, 1, 25, '2020-03-14 11:30:09'),
(299, 1, 24, '2020-03-14 11:30:12'),
(305, 1, 3, '2020-10-14 13:06:28'),
(314, 14, 37, '2020-10-21 12:47:51'),
(316, 14, 38, '2020-10-21 12:55:26'),
(317, 25, 150, '2021-08-21 06:16:31'),
(318, 25, 86, '2021-08-21 06:41:38'),
(319, 25, 152, '2021-08-21 06:58:37'),
(320, 26, 153, '2021-08-21 09:47:10'),
(321, 27, 87, '2021-08-24 09:33:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `buyers`
--
ALTER TABLE `buyers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cart`
--
ALTER TABLE `cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `ix_categories_active_categoryid` (`id`);

--
-- Indexes for table `cities`
--
ALTER TABLE `cities`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cms`
--
ALTER TABLE `cms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `product_key` (`product_key`);

--
-- Indexes for table `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `product_order`
--
ALTER TABLE `product_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_review`
--
ALTER TABLE `product_review`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `verify_phone`
--
ALTER TABLE `verify_phone`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wishlist`
--
ALTER TABLE `wishlist`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `buyers`
--
ALTER TABLE `buyers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;
--
-- AUTO_INCREMENT for table `cart`
--
ALTER TABLE `cart`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=267;
--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
--
-- AUTO_INCREMENT for table `cities`
--
ALTER TABLE `cities`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=319;
--
-- AUTO_INCREMENT for table `cms`
--
ALTER TABLE `cms`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=103;
--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;
--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154;
--
-- AUTO_INCREMENT for table `product_images`
--
ALTER TABLE `product_images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=294;
--
-- AUTO_INCREMENT for table `product_order`
--
ALTER TABLE `product_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;
--
-- AUTO_INCREMENT for table `product_review`
--
ALTER TABLE `product_review`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT for table `sellers`
--
ALTER TABLE `sellers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `verify_phone`
--
ALTER TABLE `verify_phone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `wishlist`
--
ALTER TABLE `wishlist`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=322;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `product_order` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `order_details_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
