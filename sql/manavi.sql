-- phpMyAdmin SQL Dump
-- version 4.2.7.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2016 年 2 月 22 日 09:24
-- サーバのバージョン： 5.5.39
-- PHP Version: 5.4.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `manavi`
--

-- --------------------------------------------------------

--
-- テーブルの構造 `answers`
--

CREATE TABLE IF NOT EXISTS `answers` (
`answer_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `answer` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `start_point` point NOT NULL,
  `end_point` point NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- テーブルの構造 `questions`
--

CREATE TABLE IF NOT EXISTS `questions` (
`question_id` int(11) NOT NULL,
  `title` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `starting_point_flg` int(1) NOT NULL DEFAULT '0',
  `starting_point` point NOT NULL,
  `start_flg` int(1) NOT NULL,
  `end_flg` int(1) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- テーブルの構造 `users`
--

CREATE TABLE IF NOT EXISTS `users` (
`user_id` int(10) NOT NULL,
  `login_id` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
 ADD PRIMARY KEY (`answer_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
 ADD PRIMARY KEY (`question_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
 ADD PRIMARY KEY (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
MODIFY `user_id` int(10) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
