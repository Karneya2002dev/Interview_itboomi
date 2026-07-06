-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 06, 2026 at 02:02 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `itboomi`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `password` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `email`, `password`, `city`, `created_at`) VALUES
(1, 'Karneya', 'karneya.r2002@gmail.com', '$2a$10$S1YpvdD8n2SaxCxihfwvUOpxiQWRYjdX3ScW7VBLFuW67PzFRV3eq', 'Madurai', '2026-07-06 10:56:21'),
(2, 'Senthil', 'jaya.nisanth@gmail.com', '$2a$10$q07LfgPj.94WmkF4L69bO.L86oFOyX2DGH.G5N3JW7yW80FdnhlTO', 'Chennai', '2026-07-06 11:24:38'),
(3, 'Shruthi', 'suruthi@gmail.com', '$2a$10$ta06WnjgmmxZsWJj0N0hCuZx0iqX9/ZGQGVJfirLIuW.60Zrgw.Ja', 'Thiruppur', '2026-07-06 11:32:30'),
(4, 'Jaya', '20ita07@emgywomenscollege.ac.in', '$2a$10$AR3BAeF.vcQTFveRgmZSZuN7DZySBACFPUHYXfPQfjkheLwmPh37C', 'Coimbatore', '2026-07-06 11:37:28'),
(8, 'Devi', 'd@gmail.com', '$2a$10$kNiav/zR64KwdnNtzgV.BOtMA9CHR3N/ft29lIJEuwqrh9ptB/Nxi', 'Madurai', '2026-07-06 11:46:06'),
(9, 'Dee', 'dee@gmail.com', '$2a$10$4r96Z2UbVW1NF510xO1l6OBXNKuaSvPUXINB3TDtoUG2GQ6jGWbFu', 'Tuo', '2026-07-06 11:48:44');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
