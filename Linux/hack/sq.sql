-- --------------------------------------------------------
-- Хост:                         127.0.0.1
-- Версия сервера:               8.0.39 - MySQL Community Server - GPL
-- Операционная система:         Win64
-- HeidiSQL Версия:              12.8.0.6908
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Дамп структуры базы данных restaurant1
CREATE DATABASE IF NOT EXISTS `restaurant1` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `restaurant1`;

-- Дамп структуры для таблица restaurant1.client
CREATE TABLE IF NOT EXISTS `client` (
  `Client_ID` int NOT NULL AUTO_INCREMENT,
  `Client_Full_Name` mediumtext NOT NULL,
  `Address` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`Client_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.client: ~3 rows (приблизительно)
DELETE FROM `client`;
INSERT INTO `client` (`Client_ID`, `Client_Full_Name`, `Address`) VALUES
	(1, 'Margo', 'street'),
	(2, 'andrew', 'walk'),
	(13, 'Robert', 'mama');

-- Дамп структуры для таблица restaurant1.cook
CREATE TABLE IF NOT EXISTS `cook` (
  `Cook_ID` int NOT NULL,
  `Cook_Name` mediumtext NOT NULL,
  `Position` mediumtext NOT NULL,
  PRIMARY KEY (`Cook_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.cook: ~3 rows (приблизительно)
DELETE FROM `cook`;
INSERT INTO `cook` (`Cook_ID`, `Cook_Name`, `Position`) VALUES
	(11, 'Victor', 'Shef'),
	(12, 'Lev', 'Su-Shef'),
	(13, 'Maksim', 'oguzok');

-- Дамп структуры для таблица restaurant1.dish
CREATE TABLE IF NOT EXISTS `dish` (
  `Food_ID` int NOT NULL,
  `Name` mediumtext NOT NULL,
  `Structure` mediumtext NOT NULL,
  PRIMARY KEY (`Food_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.dish: ~0 rows (приблизительно)
DELETE FROM `dish`;

-- Дамп структуры для таблица restaurant1.feedback
CREATE TABLE IF NOT EXISTS `feedback` (
  `Rate_ID` int NOT NULL,
  `Rate` mediumtext NOT NULL,
  `Client_ID` int NOT NULL,
  PRIMARY KEY (`Rate_ID`),
  KEY `feedback` (`Client_ID`),
  CONSTRAINT `feedback` FOREIGN KEY (`Client_ID`) REFERENCES `client` (`Client_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.feedback: ~0 rows (приблизительно)
DELETE FROM `feedback`;

-- Дамп структуры для таблица restaurant1.menu
CREATE TABLE IF NOT EXISTS `menu` (
  `Menu_ID` int NOT NULL,
  `Version` mediumtext NOT NULL,
  `Kids` mediumtext NOT NULL,
  `Normal` mediumtext NOT NULL,
  `Food_ID` int DEFAULT NULL,
  PRIMARY KEY (`Menu_ID`),
  KEY `Food_ID` (`Food_ID`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`Food_ID`) REFERENCES `dish` (`Food_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.menu: ~0 rows (приблизительно)
DELETE FROM `menu`;

-- Дамп структуры для таблица restaurant1.order_menu
CREATE TABLE IF NOT EXISTS `order_menu` (
  `Order_ID` int NOT NULL,
  `Menu_ID` int NOT NULL,
  PRIMARY KEY (`Order_ID`,`Menu_ID`),
  KEY `Menu_ID` (`Menu_ID`),
  CONSTRAINT `order_menu_ibfk_1` FOREIGN KEY (`Order_ID`) REFERENCES `order_table` (`Order_ID`),
  CONSTRAINT `order_menu_ibfk_2` FOREIGN KEY (`Menu_ID`) REFERENCES `menu` (`Menu_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.order_menu: ~0 rows (приблизительно)
DELETE FROM `order_menu`;

-- Дамп структуры для таблица restaurant1.order_table
CREATE TABLE IF NOT EXISTS `order_table` (
  `Client_ID` int DEFAULT NULL,
  `Waiter_ID` int DEFAULT NULL,
  `Cook_ID` int DEFAULT NULL,
  `Order_ID` int NOT NULL AUTO_INCREMENT,
  `Stat` enum('ready','not ready') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `Waiter_ID` (`Waiter_ID`),
  KEY `Cook_ID` (`Cook_ID`),
  KEY `order_table_ibfk_1` (`Client_ID`),
  CONSTRAINT `order_table_ibfk_1` FOREIGN KEY (`Client_ID`) REFERENCES `client` (`Client_ID`),
  CONSTRAINT `order_table_ibfk_2` FOREIGN KEY (`Waiter_ID`) REFERENCES `waiter` (`Waiter_ID`),
  CONSTRAINT `order_table_ibfk_3` FOREIGN KEY (`Cook_ID`) REFERENCES `cook` (`Cook_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.order_table: ~0 rows (приблизительно)
DELETE FROM `order_table`;
INSERT INTO `order_table` (`Client_ID`, `Waiter_ID`, `Cook_ID`, `Order_ID`, `Stat`) VALUES
	(1, 21, 11, 12, 'ready');

-- Дамп структуры для таблица restaurant1.passcook
CREATE TABLE IF NOT EXISTS `passcook` (
  `Cook_ID` int NOT NULL,
  `PassCook` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `login` varchar(50) NOT NULL,
  PRIMARY KEY (`Cook_ID`),
  CONSTRAINT `FK_passcook_cook` FOREIGN KEY (`Cook_ID`) REFERENCES `cook` (`Cook_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.passcook: ~3 rows (приблизительно)
DELETE FROM `passcook`;
INSERT INTO `passcook` (`Cook_ID`, `PassCook`, `login`) VALUES
	(11, 'Whiskey1', 'Avrora'),
	(12, 'cameron26', 'Mama'),
	(13, 'falcon27', 'Alfa');

-- Дамп структуры для таблица restaurant1.passwaiter
CREATE TABLE IF NOT EXISTS `passwaiter` (
  `Waiter_ID` int NOT NULL,
  `PassWaiter` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `login` varchar(50) NOT NULL,
  PRIMARY KEY (`Waiter_ID`),
  CONSTRAINT `FK_passwaiter_waiter` FOREIGN KEY (`Waiter_ID`) REFERENCES `waiter` (`Waiter_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.passwaiter: ~0 rows (приблизительно)
DELETE FROM `passwaiter`;

-- Дамп структуры для таблица restaurant1.tokens
CREATE TABLE IF NOT EXISTS `tokens` (
  `token` varchar(50) NOT NULL,
  `user` varchar(50) NOT NULL,
  `type` enum('Повар','Официант') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'Повар',
  PRIMARY KEY (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.tokens: ~9 rows (приблизительно)
DELETE FROM `tokens`;
INSERT INTO `tokens` (`token`, `user`, `type`) VALUES
	('2TWv7Umi9TGENfo8egTQkSqawKtY8EzI', '11', 'Повар'),
	('40EjYz9oiLppLY3FzZ9j4RGKHogbUXjv', '11', 'Повар'),
	('6oSHWKHhIzMNl4niTSMxH4kuGvH7tH1u', '11', 'Повар'),
	('eBdfjjXKcMvdTr2oyERWnjJ9Vr1W1wB1', '11', 'Повар'),
	('FDTC3WbhLQqdRFdX63uHH9rujFlJClzy', '11', 'Повар'),
	('fWHFzIfMZMJLLY7uSxIBf9w46LZuzzkV', '11', 'Повар'),
	('G2roMKuhSsh6BbOMQBkZzcDlvU1hPvNI', '11', 'Повар'),
	('MgmxO6ufg5GJ82kxYIrf21lENY6uqCHj', '11', 'Повар'),
	('nwjS81DWHlEMc8X06SNI4IpTrlHLwenB', '11', 'Повар'),
	('tHyJ4ehvEdVePIOFnkpT63UuLHLFnQnE', '11', 'Повар'),
	('uE9wl86dZ7W111hoxfoRxavVTzkZMFkC', '11', 'Повар'),
	('wWvMbsAgSj4UV6jc1ATSp8Ov0GEboC5U', '11', 'Повар');

-- Дамп структуры для таблица restaurant1.waiter
CREATE TABLE IF NOT EXISTS `waiter` (
  `Waiter_ID` int NOT NULL,
  `WaiterName` mediumtext NOT NULL,
  PRIMARY KEY (`Waiter_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.waiter: ~2 rows (приблизительно)
DELETE FROM `waiter`;
INSERT INTO `waiter` (`Waiter_ID`, `WaiterName`) VALUES
	(21, 'Nastya'),
	(22, 'Polya');

-- Дамп структуры для таблица restaurant1.work
CREATE TABLE IF NOT EXISTS `work` (
  `rezume` varchar(2000) DEFAULT NULL,
  `R_ID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`R_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Дамп данных таблицы restaurant1.work: ~0 rows (приблизительно)
DELETE FROM `work`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
