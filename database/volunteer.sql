-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 23, 2023 at 10:23 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `volunteer`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `booking_report` (IN `_hall_name` VARCHAR(100))   BEGIN

IF(_hall_name=' ')THEN

SELECT concat(c.fristname,' ',c.lastname) AS customer_name,h.hall_name,concat(w.male_name,' & ',w.female_name) AS couple,b.start_time,b.End_time,b.Total_Guests,b.Total_price FROM booking b JOIN customer c ON b.customer_id=c.customer_id JOIN hall h ON b.hall_id=h.hall_id JOIN wedding w ON b.w_id=w.w_id;

ELSE

SELECT concat(c.fristname,' ',c.lastname) AS customer_name,h.hall_name,concat(w.male_name,' & ',w.female_name) AS couple,b.start_time,b.End_time,b.Total_Guests,b.Total_price FROM booking b JOIN customer c ON b.customer_id=c.customer_id JOIN hall h ON b.hall_id=h.hall_id JOIN wedding w ON b.w_id=w.w_id WHERE h.hall_name=_hall_name;

END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `charging` (IN `_customer_id` INT, IN `_amount` INT, IN `_description` TEXT, IN `_user_id` VARCHAR(30))   BEGIN

INSERT INTO `charging`(`customer_id`, `amount`,`description`,`user_id`)
        VALUES (_customer_id, _amount, _description, _user_id);


-- SELECT _customer_id,_amount,_description,_user_id,
-- CURRENT_DATE from booking;
 -- CURRENT_DATE from booking b JOIN jop_title j on e.title_id=j.title_id;

if(row_count()> 0)THEN
SELECT "registered" as msg;

ELSE

SELECT "Not" as msg;
END IF;
 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `forget` (IN `_username` VARCHAR(50), IN `_password` INT)   BEGIN

if EXISTS(SELECT * FROM users WHERE users.username = _username)THEN	

UPDATE `users` SET password = MD5(_password) WHERE username = _username;
 
 SELECT 'success' Msg;

ELSE

SELECT 'deny' Msg;

end if;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `get_charging` (IN `_month_id` VARCHAR(50), IN `_year` VARCHAR(50), IN `_description` TEXT, IN `_account_id` INT, IN `_user_id` VARCHAR(100))   BEGIN

if(read_salary() > read_balance(_account_id))THEN

SELECT "Deny" as msg;
ELSE
INSERT IGNORE INTO `charge`(`emp_id`, `title_id`, `Amount`, `month_id`, `year`, `description`, `account_id`,`user_id`, `date`)
SELECT e.emp_id,j.title_id,j.salary,_month_id,_year,_description,_account_id,_user_id,
CURRENT_DATE from employee e JOIN jop_title j on e.title_id=j.title_id;

if(row_count()> 0)THEN
SELECT "Registered" as msg;

ELSE

SELECT "Not" as msg;
END IF;
END IF;
 
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `login_sp` (IN `_username` VARCHAR(100), IN `_password` VARCHAR(100))   BEGIN

if EXISTS(SELECT * FROM users WHERE users.username = _username and users.password = MD5(_password))THEN	


if EXISTS(SELECT * FROM users WHERE users.username = _username and 	users.status = 'Active')THEN
 
SELECT * FROM users where users.username = _username;

ELSE

SELECT 'Locked' Msg;

end if;
ELSE


SELECT 'Deny' Msg;

END if;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `programprod` (IN `_name` VARCHAR(200), IN `_ptype` VARCHAR(200), IN `_desc` TEXT, IN `_durations` VARCHAR(200), IN `_from_date` DATE, IN `_to_date` DATE)   BEGIN


INSERT INTO programs(name, ptype, description, durations,from_date,to_date)
        VALUES (_name, _ptype, _desc, _durations,_from_date,_to_date);

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_booking_price` (IN `_customer_id` INT)   BEGIN
SELECT `balance` as Total_amount from customer where customer_id=_customer_id;


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_employee_total` (IN `_employee_id` INT)   BEGIN
SELECT `Amount` as Total_amount from charge where emp_id=_employee_id;


END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `read_balance` (`_account_id` INT) RETURNS INT(11)  BEGIN
set @balance=0.00;
SELECT sum(balance)into @balance from account
WHERE account_id=_account_id;
RETURN @balance;

END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `read_salary` () RETURNS DECIMAL(11,2)  BEGIN
set @salary=0.00;

SELECT sum(salary)into @salary from jop_title;

RETURN @salary;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `applay`
--

CREATE TABLE `applay` (
  `applay_id` int(11) NOT NULL,
  `program_id` int(11) DEFAULT NULL,
  `volunteers_id` int(11) DEFAULT NULL,
  `applay_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `applay`
--

INSERT INTO `applay` (`applay_id`, `program_id`, `volunteers_id`, `applay_date`) VALUES
(12, 12, 8, '2023-09-18 06:19:31'),
(13, 12, 6, '2023-09-18 06:19:53'),
(15, 12, 11, '2023-09-18 13:12:54'),
(16, 15, 8, '2023-09-20 10:53:01'),
(17, 12, 11, '2023-09-20 11:30:43'),
(18, 12, 0, '2023-09-23 04:50:25');

-- --------------------------------------------------------

--
-- Table structure for table `branch`
--

CREATE TABLE `branch` (
  `branch_id` int(11) NOT NULL,
  `branch_name` varchar(100) NOT NULL,
  `address` varchar(100) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `branch`
--

INSERT INTO `branch` (`branch_id`, `branch_name`, `address`, `date`) VALUES
(1, 'Km4', 'Yaqshid', '2023-06-24 06:57:58'),
(2, 'gaalkacyo', 'wxara cade', '2023-09-17 05:54:05');

-- --------------------------------------------------------

--
-- Table structure for table `coordinators`
--

CREATE TABLE `coordinators` (
  `Coordinators_id` int(11) NOT NULL,
  `fullname` varchar(50) DEFAULT NULL,
  `sex` varchar(50) DEFAULT NULL,
  `tell` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `joined_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `coordinators`
--

INSERT INTO `coordinators` (`Coordinators_id`, `fullname`, `sex`, `tell`, `email`, `joined_date`) VALUES
(2, 'Marisa Mohamed', 'male', '616097896', 'aabaha201@gmail.com', '2023-09-17 12:23:50'),
(3, 'xasan caabi shire', 'male', '24558877', ' munniomer@gmail.com', '2023-09-17 05:58:08');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `volunteers_id` int(11) DEFAULT NULL,
  `Coordinators_id` int(11) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`feedback_id`, `volunteers_id`, `Coordinators_id`, `program_id`, `comments`, `date`) VALUES
(9, 8, 3, 12, 'ccc', '2023-09-18 13:12:37'),
(10, 0, 2, 12, '222', '2023-09-22 19:27:21');

-- --------------------------------------------------------

--
-- Table structure for table `jop_title`
--

CREATE TABLE `jop_title` (
  `title_id` int(11) NOT NULL,
  `position` varchar(100) NOT NULL,
  `salary` float NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jop_title`
--

INSERT INTO `jop_title` (`title_id`, `position`, `salary`, `date`) VALUES
(2, 'codinatar', 100, '2023-09-14 05:54:52'),
(3, 'adminstrator', 8009, '2023-09-18 06:06:51');

-- --------------------------------------------------------

--
-- Table structure for table `programs`
--

CREATE TABLE `programs` (
  `program_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ptype` varchar(50) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `durations` varchar(200) DEFAULT NULL,
  `from_date` date DEFAULT NULL,
  `to_date` date DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `programs`
--

INSERT INTO `programs` (`program_id`, `name`, `ptype`, `description`, `durations`, `from_date`, `to_date`, `date`) VALUES
(12, 'vacceine', 'volunteer', 'iiiihj', '34', '2023-09-21', '2023-09-09', '2023-09-17 12:25:04'),
(15, 'siminar', 'Enternurship', 'ddd', '2m', '2023-09-12', '2023-09-20', '2023-09-18 13:13:29');

-- --------------------------------------------------------

--
-- Table structure for table `reward`
--

CREATE TABLE `reward` (
  `reward_id` int(11) NOT NULL,
  `reward_type` varchar(50) DEFAULT NULL,
  `volunteers_id` int(11) DEFAULT NULL,
  `program_id` int(11) DEFAULT NULL,
  `donation_date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reward`
--

INSERT INTO `reward` (`reward_id`, `reward_type`, `volunteers_id`, `program_id`, `donation_date`) VALUES
(10, 'money', 6, 5, '2023-09-17 10:33:46'),
(11, 'certificate', 3, 3, '2023-09-17 11:25:51'),
(15, 'money', 6, 12, '2023-09-18 06:46:08'),
(17, 'certificate', 6, 10, '2023-09-18 06:45:43'),
(19, 'certificate', 11, 10, '2023-09-18 13:54:45'),
(20, 'job', 8, 10, '2023-09-18 17:53:00'),
(21, 'certificate', 0, 12, '2023-09-23 06:22:47');

-- --------------------------------------------------------

--
-- Table structure for table `roll`
--

CREATE TABLE `roll` (
  `roll_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `roll`
--

INSERT INTO `roll` (`roll_id`, `name`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(100) NOT NULL,
  `usertype` varchar(250) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `image` varchar(100) NOT NULL,
  `status` varchar(100) NOT NULL DEFAULT 'active',
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `usertype`, `username`, `password`, `image`, `status`, `date`) VALUES
('USR001', 'volunteer', 'mahad', '202cb962ac59075b964b07152d234b70', 'USR001.png', 'active', '2023-09-18 12:36:33'),
('USR003', 'coordinator', 'mahad cali gee', 'd79c8788088c2193f0244d8f1f36d2db', 'USR003.png', 'active', '2023-09-22 19:22:33'),
('USR002', 'volunteer', 'mahad yare', '827ccb0eea8a706c4c34a16891f84e7b', 'USR002.png', 'active', '2023-09-18 17:52:21');

-- --------------------------------------------------------

--
-- Table structure for table `volunteers`
--

CREATE TABLE `volunteers` (
  `volunteers_id` varchar(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `sex` varchar(100) NOT NULL,
  `phone` varchar(100) NOT NULL,
  `age` varchar(100) NOT NULL,
  `education` varchar(200) NOT NULL,
  `branch_id` int(11) NOT NULL,
  `image` varchar(250) NOT NULL,
  `method` varchar(250) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `volunteers`
--

INSERT INTO `volunteers` (`volunteers_id`, `fullname`, `sex`, `phone`, `age`, `education`, `branch_id`, `image`, `method`, `date`) VALUES
('VOL001', 'mahad yRE', 'male', '123', '123', 'primary', 222, 'VOL001.png', 'self', '2023-09-23 07:06:29'),
('VOL002', 'Abdi', 'female', '12399999999', '1238888888', 'primary', 222, 'VOL002.png', 'self', '2023-09-23 08:09:03');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applay`
--
ALTER TABLE `applay`
  ADD PRIMARY KEY (`applay_id`);

--
-- Indexes for table `branch`
--
ALTER TABLE `branch`
  ADD PRIMARY KEY (`branch_id`);

--
-- Indexes for table `coordinators`
--
ALTER TABLE `coordinators`
  ADD PRIMARY KEY (`Coordinators_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`);

--
-- Indexes for table `jop_title`
--
ALTER TABLE `jop_title`
  ADD PRIMARY KEY (`title_id`);

--
-- Indexes for table `programs`
--
ALTER TABLE `programs`
  ADD PRIMARY KEY (`program_id`);

--
-- Indexes for table `reward`
--
ALTER TABLE `reward`
  ADD PRIMARY KEY (`reward_id`);

--
-- Indexes for table `roll`
--
ALTER TABLE `roll`
  ADD PRIMARY KEY (`roll_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `student_id` (`usertype`);

--
-- Indexes for table `volunteers`
--
ALTER TABLE `volunteers`
  ADD PRIMARY KEY (`volunteers_id`),
  ADD KEY `branch_id` (`branch_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applay`
--
ALTER TABLE `applay`
  MODIFY `applay_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `branch`
--
ALTER TABLE `branch`
  MODIFY `branch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `coordinators`
--
ALTER TABLE `coordinators`
  MODIFY `Coordinators_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `jop_title`
--
ALTER TABLE `jop_title`
  MODIFY `title_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `programs`
--
ALTER TABLE `programs`
  MODIFY `program_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `reward`
--
ALTER TABLE `reward`
  MODIFY `reward_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `roll`
--
ALTER TABLE `roll`
  MODIFY `roll_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
