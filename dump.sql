-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Jan 23, 2025 at 11:15 AM
-- Server version: 5.7.44
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `taxi_app`
--

-- --------------------------------------------------------

-- Eemalda tabelid, kui need eksisteerivad
DROP TABLE IF EXISTS `client_feedback`;
DROP TABLE IF EXISTS `ratings`;
DROP TABLE IF EXISTS `route`;
DROP TABLE IF EXISTS `orders`;
DROP TABLE IF EXISTS `vehicles`;
DROP TABLE IF EXISTS `drivers`;

-- Tabeli struktuur `drivers`
CREATE TABLE `drivers` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unikaalne identifikaator iga juhi jaoks, kasutades UNSIGNED, et vältida negatiivseid väärtusi. TINYINT oleks liiga väike, BIGINT liiga suur.',
  `name` varchar(255) NOT NULL COMMENT 'Juhi nimi, lubades kuni 255 tähemärki. CHAR oleks raiskav, TEXT liiga suur.',
  `license_number` varchar(20) NOT NULL COMMENT 'Unikaalne litsentsinumber juhi jaoks, kuni 20 tähemärki. CHAR oleks raiskav.',
  `phone_number` varchar(15) NOT NULL COMMENT 'Telefoninumber, lubades erinevaid vorminguid, kuni 15 tähemärki. CHAR oleks raiskav.',
  `email` varchar(255) DEFAULT NULL COMMENT 'E-posti aadress, lubades kuni 255 tähemärki, võib olla NULL, kui ei ole esitatud. CHAR oleks raiskav.',
  `hire_date` date NOT NULL COMMENT 'Tööle asumise kuupäev, kasutades DATE tüüpi täpse kuupäeva salvestamiseks.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `license_number` (`license_number`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Andmete dumpimine tabelis `drivers`
INSERT INTO `drivers` (`name`, `license_number`, `phone_number`, `email`, `hire_date`) VALUES
('John Doe', 'D123456', '555-1234', 'john@example.com', '2022-01-15'),
('Jane Smith', 'D654321', '555-5678', 'jane@example.com', '2022-02-20'),
('Alice Johnson', 'D789012', '555-8765', 'alice@example.com', '2022-03-10'),
('Bob Brown', 'D345678', '555-4321', 'bob@example.com', '2022-04-05'),
('Charlie Davis', 'D987654', '555-6789', 'charlie@example.com', '2022-05-25');

-- --------------------------------------------------------

-- Tabeli struktuur `vehicles`
CREATE TABLE `vehicles` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unikaalne identifikaator iga sõiduki jaoks.',
  `driver_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Võõrvõti, mis viitab juhile, võib olla NULL, kui ei ole määratud. TINYINT oleks liiga väike.',
  `make` varchar(50) NOT NULL COMMENT 'Sõiduki mark, lubades kuni 50 tähemärki. CHAR oleks raiskav.',
  `model` varchar(50) NOT NULL COMMENT 'Sõiduki mudel, lubades kuni 50 tähemärki. CHAR oleks raiskav.',
  `year` year(4) NOT NULL COMMENT 'Tootmisaasta, kasutades 4 numbrit aasta esindamiseks. TINYINT oleks liiga väike.',
  `license_plate` varchar(10) NOT NULL COMMENT 'Sõiduki registreerimisnumber, lubades kuni 10 tähemärki. CHAR oleks raiskav.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `license_plate` (`license_plate`),
  KEY `driver_id` (`driver_id`),
  FOREIGN KEY (`driver_id`) REFERENCES `drivers`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Andmete dumpimine tabelis `vehicles`
INSERT INTO `vehicles` (`driver_id`, `make`, `model`, `year`, `license_plate`) VALUES
(1, 'Toyota', 'Camry', 2020, 'ABC123'),
(2, 'Honda', 'Civic', 2019, 'XYZ456'),
(1, 'Ford', 'Focus', 2021, 'LMN789'),
(3, 'Chevrolet', 'Malibu', 2020, 'DEF012'),
(4, 'Nissan', 'Altima', 2018, 'GHI345');

-- --------------------------------------------------------

-- Tabeli struktuur `orders`
CREATE TABLE `orders` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unikaalne identifikaator iga tellimuse jaoks.',
  `customer_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Võõrvõti, mis viitab kliendile, võib olla NULL, kui ei ole määratud. TINYINT oleks liiga väike.',
  `vehicle_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Võõrvõti, mis viitab sõidukile, võib olla NULL, kui ei ole määratud. TINYINT oleks liiga väike.',
  `order_date` datetime NOT NULL COMMENT 'Tellimuse kuupäev ja kellaaeg, kasutades DATETIME täpse ajamärgi jaoks.',
  `pickup_location` varchar(255) NOT NULL COMMENT 'Korjamise asukoht, lubades kuni 255 tähemärki detailsete aadresside jaoks.',
  `dropoff_location` varchar(255) NOT NULL COMMENT 'Kohaletoimetamise asukoht, lubades kuni 255 tähemärki detailsete aadresside jaoks.',
  `status` enum('pending','completed','canceled') DEFAULT 'pending' COMMENT 'Tellimuse olek, kasutades ENUM fikseeritud väärtuste jaoks.',
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `vehicle_id` (`vehicle_id`),
  FOREIGN KEY (`vehicle_id`) REFERENCES `vehicles`(`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Andmete dumpimine tabelis `orders`
INSERT INTO `orders` (`customer_id`, `vehicle_id`, `order_date`, `pickup_location`, `dropoff_location`, `status`) VALUES
(1, 1, '2023-01-01 10:00:00', '123 Main St', '456 Elm St', 'completed'),
(2, 2, '2023-01-02 11:00:00', '789 Oak St', '321 Pine St', 'pending'),
(1, 3, '2023-01-03 12:00:00', '654 Maple St', '987 Birch St', 'canceled'),
(3, 1, '2023-01-04 13:00:00', '159 Cedar St', '753 Walnut St', 'completed'),
(4, 2, '2023-01-05 14:00:00', '852 Spruce St', '369 Ash St', 'pending');

-- --------------------------------------------------------

-- Tabeli struktuur `client_feedback`
CREATE TABLE `client_feedback` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unikaalne identifikaator iga tagasiside jaoks.',
  `order_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Võõrvõti, mis viitab tellimusele, võib olla NULL, kui ei ole määratud. TINYINT oleks liiga väike.',
  `feedback` text COMMENT 'Tagasiside tekst, kasutades TEXT tüüpi muutuva pikkusega sisendi jaoks.',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Tagasiside loomise ajamärk, vaikimisi praegune aeg.',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Andmete dumpimine tabelis `client_feedback`
INSERT INTO `client_feedback` (`order_id`, `feedback`) VALUES
(1, 'Suurepärane teenus!'),
(2, 'Juht hilines.'),
(3, 'Auto oli puhas ja mugav.'),
(1, 'Kasutaksin uuesti.'),
(2, 'Oli meeldiv kogemus.');

-- --------------------------------------------------------

-- Tabeli struktuur `ratings`
CREATE TABLE `ratings` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unikaalne identifikaator iga hinnangu jaoks.',
  `order_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Võõrvõti, mis viitab tellimusele, võib olla NULL, kui ei ole määratud. TINYINT oleks liiga väike.',
  `rating` int(11) DEFAULT NULL COMMENT 'Hinnangu väärtus, võib olla NULL, kui ei ole esitatud.',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP COMMENT 'Hinnangu loomise ajamärk, vaikimisi praegune aeg.',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Andmete dumpimine tabelis `ratings`
INSERT INTO `ratings` (`order_id`, `rating`) VALUES
(1, 5),
(2, 3),
(3, 4),
(1, 5),
(2, 2);

-- --------------------------------------------------------

-- Tabeli struktuur `route`
CREATE TABLE `route` (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Unikaalne identifikaator iga marsruudi jaoks.',
  `order_id` int(11) UNSIGNED DEFAULT NULL COMMENT 'Võõrvõti, mis viitab tellimusele, võib olla NULL, kui ei ole määratud. TINYINT oleks liiga väike.',
  `route_description` text COMMENT 'Marsruudi kirjeldus, kasutades TEXT tüüpi muutuva pikkusega sisendi jaoks.',
  `distance` decimal(10,2) UNSIGNED DEFAULT NULL COMMENT 'Marsruudi kaugus, kasutades DECIMAL täpsete väärtuste jaoks.',
  `estimated_time` int(11) UNSIGNED DEFAULT NULL COMMENT 'Hinnanguline aeg minutites, kasutades UNSIGNED, et vältida negatiivseid väärtusi.',
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  FOREIGN KEY (`order_id`) REFERENCES `orders`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Andmete dumpimine tabelis `route`
INSERT INTO `route` (`order_id`, `route_description`, `distance`, `estimated_time`) VALUES
(1, 'Main St to Elm St', 5.00, 15),
(2, 'Oak St to Pine St', 3.50, 10),
(3, 'Maple St to Birch St', 4.25, 12),
(1, 'Cedar St to Walnut St', 6.00, 18),
(2, 'Spruce St to Ash St', 2.75, 8);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
