-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 13, 2026 at 11:35 AM
-- Server version: 8.4.3
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `soilcheck`
--

-- --------------------------------------------------------

--
-- Table structure for table `hasil_analisis`
--

CREATE TABLE `hasil_analisis` (
  `id` int NOT NULL,
  `tanaman` varchar(50) DEFAULT NULL,
  `luas` double DEFAULT NULL,
  `n_analisis` double DEFAULT NULL,
  `p_analisis` double DEFAULT NULL,
  `k_analisis` double DEFAULT NULL,
  `kebutuhan_n` double DEFAULT NULL,
  `kebutuhan_p` double DEFAULT NULL,
  `kebutuhan_k` double DEFAULT NULL,
  `urea` double DEFAULT NULL,
  `sp36` double DEFAULT NULL,
  `kcl` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `hasil_analisis`
--

INSERT INTO `hasil_analisis` (`id`, `tanaman`, `luas`, `n_analisis`, `p_analisis`, `k_analisis`, `kebutuhan_n`, `kebutuhan_p`, `kebutuhan_k`, `urea`, `sp36`, `kcl`, `created_at`) VALUES
(1, 'TEST', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, '2026-01-12 15:37:49'),
(2, 'Sawit', 23, 23, 23, 23, 23, 23, 23, 0, 0, 0, '2026-01-12 15:38:50'),
(3, 'Sawit', 2, 2, 2, 2, 2, 2, 2, 0, 0, 0, '2026-01-12 15:47:17');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hasil_analisis`
--
ALTER TABLE `hasil_analisis`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hasil_analisis`
--
ALTER TABLE `hasil_analisis`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
