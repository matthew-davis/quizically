-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Aug 25, 2014 at 11:54 PM
-- Server version: 5.5.35
-- PHP Version: 5.3.10-1ubuntu3.11

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `quizzically`
--

-- --------------------------------------------------------

--
-- Table structure for table `A_CLIENT`
--

CREATE TABLE IF NOT EXISTS `A_CLIENT` (
  `CLIENT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CLIENT_EMAIL` varchar(100) NOT NULL,
  `CLIENT_PASSWORD` varchar(100) NOT NULL,
  `ORGANISATION` varchar(100) DEFAULT NULL,
  `LOCATION_ID` int(11) DEFAULT NULL,
  `CLIENT_UPDATES` varchar(1) DEFAULT NULL,
  `CLIENT_CREATED` datetime NOT NULL,
  `QUIZ_CREDIT` int(11) NOT NULL,
  `QUIZ_HOSTED` int(11) NOT NULL,
  `RESET` varchar(100) DEFAULT NULL,
  `EXPIRE` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`CLIENT_ID`),
  KEY `LOCATION_ID` (`LOCATION_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30027 ;

--
-- Dumping data for table `A_CLIENT`
--

INSERT INTO `A_CLIENT` (`CLIENT_ID`, `CLIENT_EMAIL`, `CLIENT_PASSWORD`, `ORGANISATION`, `LOCATION_ID`, `CLIENT_UPDATES`, `CLIENT_CREATED`, `QUIZ_CREDIT`, `QUIZ_HOSTED`, `RESET`, `EXPIRE`) VALUES
(30000, 'test@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'Wittin', 40013, 'Y', '2014-05-18 12:53:21', 0, 41, NULL, NULL),
(30001, 'matthew.davis.1978@gmail.com', '5a105e8b9d40e1329780d62ea2265d8a', 'Wittin', 40013, 'Y', '2014-05-18 19:27:48', 0, 2, NULL, NULL),
(30019, 'apple@apple.com', '26402cc420affb03828fc87f89996f0b', 'Apple', 40032, 'N', '2014-05-28 22:09:33', 0, 1, NULL, NULL),
(30020, 'paul1@paul.com', 'e668feb13dab099b551ebd560174832f', 'Paul''s Gigalo Services', 40032, 'Y', '2014-06-08 18:12:02', 0, 0, NULL, NULL),
(30021, 'mike1@mike.com', '56d4d5840f3c27e4190e420ddab9a6cb', 'Mike''s Gigalo Services', 40032, 'Y', '2014-06-08 18:12:41', 0, 1, NULL, NULL),
(30022, 'test2@test.com', '098f6bcd4621d373cade4e832627b4f6', '', 40032, 'Y', '2014-06-11 19:11:50', 0, 2, NULL, NULL),
(30023, 'pissflap@test.com', '5e556ff29ec1f8c4f1d6f63e1c2dd53b', '', 40018, 'Y', '2014-06-11 19:23:59', 0, 1, NULL, NULL),
(30024, 'goon@test.com', '098f6bcd4621d373cade4e832627b4f6', 'abc', 40013, 'Y', '2014-06-11 19:29:23', 0, 0, NULL, NULL),
(30025, 'd.romilly@waracle.com', '64734ca1b899627a00d997a364b08762', 'Waracle', 40007, 'Y', '2014-06-16 14:25:10', 0, 0, NULL, NULL),
(30026, 'office@nicolerobertlaurent.com', '79cf7c931ff439aa2199146077f29300', 'Nicole Robert Laurent Limited', 40032, 'Y', '2014-07-09 16:07:12', 0, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `A_USER`
--

CREATE TABLE IF NOT EXISTS `A_USER` (
  `USER_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_EMAIL` varchar(100) NOT NULL,
  `USER_PASSWORD` varchar(100) NOT NULL,
  `GENDER` varchar(1) DEFAULT NULL,
  `BIRTHDAY` datetime DEFAULT NULL,
  `LOCATION_ID` int(11) DEFAULT NULL,
  `USER_UPDATES` varchar(1) DEFAULT NULL,
  `USER_CREATED` datetime NOT NULL,
  `RESET` varchar(100) DEFAULT NULL,
  `EXPIRE` varchar(100) DEFAULT NULL,
  `QUIZ_PLAYED` int(11) NOT NULL,
  PRIMARY KEY (`USER_ID`),
  KEY `LOCATION_ID` (`LOCATION_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=50016 ;

--
-- Dumping data for table `A_USER`
--

INSERT INTO `A_USER` (`USER_ID`, `USER_EMAIL`, `USER_PASSWORD`, `GENDER`, `BIRTHDAY`, `LOCATION_ID`, `USER_UPDATES`, `USER_CREATED`, `RESET`, `EXPIRE`, `QUIZ_PLAYED`) VALUES
(2, 'matthew.davis.1978@gmail.com', '5a105e8b9d40e1329780d62ea2265d8a', 'M', '1978-11-02 00:00:00', 40013, 'Y', '2014-05-27 20:18:09', 'f1198825dc37146c308272ec460517ad160ad350', '1401407360', 0),
(3, 'katie@wittin.com', '5a105e8b9d40e1329780d62ea2265d8a', 'F', '1970-01-01 00:00:00', 40007, 'Y', '2014-05-27 20:37:44', NULL, NULL, 0),
(4, 'jdrmackintosh@gmail.com', 'e2f4c26bf75c8042b3ca28c32d9d57a6', 'M', '1970-01-01 00:00:00', 40013, 'N', '2014-05-27 20:46:07', NULL, NULL, 0),
(5, 'sony@me.com', '33561003f44d374c719506bef4faeba4', 'F', '2014-05-27 00:00:00', 40004, 'N', '2014-05-27 20:58:33', NULL, NULL, 0),
(6, 'jamie@me.com', '1c138fd52ddd771388a5b4c410a9603a', 'M', '1978-05-28 00:00:00', 40022, 'N', '2014-05-28 21:42:13', NULL, NULL, 0),
(7, 'apple@apple.com', '26402cc420affb03828fc87f89996f0b', 'X', '1970-01-01 00:00:00', 40032, 'N', '2014-05-28 22:13:50', NULL, NULL, 0),
(50000, 'test@test.com', '1c138fd52ddd771388a5b4c410a9603a', 'F', '2014-05-18 00:00:00', 40003, 'Y', '2014-05-18 13:42:41', NULL, NULL, 0),
(50001, 'mike2@mike.com', '1edaf845bcbf7f59a00f5696e7264e1d', 'M', '1986-07-11 00:00:00', 40032, 'Y', '2014-06-08 18:15:07', NULL, NULL, 0),
(50002, 'paul2@paul.com', 'a10b9a45d9e82f96a2ccf12108cd5009', 'M', '1982-07-26 00:00:00', 40032, 'Y', '2014-06-08 18:15:53', NULL, NULL, 0),
(50003, 'brian1@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'M', '1977-07-15 00:00:00', 40032, 'Y', '2014-06-11 18:41:48', NULL, NULL, 0),
(50004, 'paul@test1.co.uk', '5a105e8b9d40e1329780d62ea2265d8a', 'M', '1992-10-20 00:00:00', 40032, 'N', '2014-06-11 18:44:25', NULL, NULL, 0),
(50005, 'matthew2@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'X', '1970-01-01 00:00:00', 40032, 'Y', '2014-06-11 18:44:43', NULL, NULL, 0),
(50006, 'brian2@test.com', 'ad0234829205b9033196ba818f7a872b', 'M', '2014-06-11 00:00:00', 40032, 'Y', '2014-06-11 18:45:19', NULL, NULL, 0),
(50007, 'may@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'F', '2014-06-11 00:00:00', 40032, 'Y', '2014-06-11 18:46:34', NULL, NULL, 0),
(50008, 'matthew3@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'X', '1970-01-01 00:00:00', 40032, 'Y', '2014-06-11 18:46:36', NULL, NULL, 0),
(50009, 'kev1@test.com', '098f6bcd4621d373cade4e832627b4f6', 'M', '1970-01-01 00:00:00', 40032, 'Y', '2014-06-11 18:46:49', NULL, NULL, 0),
(50010, 'matthew4@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'X', '1970-01-01 00:00:00', 40032, 'Y', '2014-06-11 18:47:24', NULL, NULL, 0),
(50011, 'kev2@test.com', '098f6bcd4621d373cade4e832627b4f6', 'M', '1970-01-01 00:00:00', 40032, 'Y', '2014-06-11 18:47:34', NULL, NULL, 0),
(50012, 'paul2@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'X', '1970-01-01 00:00:00', 40032, 'Y', '2014-06-11 18:51:27', NULL, NULL, 0),
(50013, 'brian3@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'M', '1970-01-01 00:00:00', 40032, 'Y', '2014-06-11 18:52:28', NULL, NULL, 0),
(50014, 'matthew1@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'X', '1970-01-01 00:00:00', 40032, 'Y', '2014-06-11 18:56:21', NULL, NULL, 0),
(50015, 'gaffney721@gmail.com', '764d936fc7a5083299ac59cff146dd47', 'F', '1993-10-01 00:00:00', 40027, 'Y', '2014-08-10 14:23:41', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `B_GAME`
--

CREATE TABLE IF NOT EXISTS `B_GAME` (
  `GAME_ID` int(11) NOT NULL AUTO_INCREMENT,
  `QUIZ_ID` int(11) NOT NULL,
  `QUESTIONS_LEFT` int(11) NOT NULL,
  `DIFFICULTY_ID` int(11) NOT NULL,
  `QUESTION_ID` int(11) DEFAULT NULL,
  `QUIZ_STATUS` varchar(1) NOT NULL,
  PRIMARY KEY (`GAME_ID`),
  KEY `QUIZ_ID` (`QUIZ_ID`),
  KEY `QUESTION_ID` (`QUESTION_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=60239 ;

--
-- Dumping data for table `B_GAME`
--

INSERT INTO `B_GAME` (`GAME_ID`, `QUIZ_ID`, `QUESTIONS_LEFT`, `DIFFICULTY_ID`, `QUESTION_ID`, `QUIZ_STATUS`) VALUES
(60114, 90039, 2, 10000, NULL, 'I'),
(60115, 90039, 1, 10000, 80321, 'I'),
(60116, 90039, 0, 10000, 80829, 'F'),
(60117, 90040, 2, 10000, NULL, 'I'),
(60118, 90040, 1, 10000, 80315, 'I'),
(60119, 90040, 0, 10000, 80522, 'F'),
(60120, 90041, 2, 10000, NULL, 'I'),
(60121, 90041, 1, 10000, 80535, 'I'),
(60122, 90041, 0, 10000, 80505, 'F'),
(60123, 90042, 2, 10000, NULL, 'I'),
(60124, 90042, 1, 10000, 80578, 'I'),
(60125, 90042, 0, 10000, 80345, 'F'),
(60126, 90043, 5, 10001, NULL, 'I'),
(60127, 90043, 4, 10001, 80357, 'I'),
(60128, 90043, 3, 10001, 80717, 'I'),
(60129, 90043, 2, 10001, 80648, 'I'),
(60130, 90043, 1, 10001, 80598, 'R'),
(60131, 90043, 0, 10001, 80760, 'F'),
(60132, 90044, 2, 10000, NULL, 'R'),
(60133, 90045, 2, 10000, NULL, 'I'),
(60134, 90045, 1, 10000, 80735, 'I'),
(60135, 90045, 0, 10000, 80554, 'F'),
(60136, 90046, 2, 10000, NULL, 'I'),
(60137, 90046, 1, 10000, 80554, 'I'),
(60138, 90046, 0, 10000, 80587, 'F'),
(60139, 90047, 2, 10000, NULL, 'I'),
(60140, 90047, 1, 10000, 80483, 'I'),
(60141, 90047, 0, 10000, 80655, 'F'),
(60142, 90048, 5, 10000, NULL, 'I'),
(60143, 90048, 4, 10000, 80626, 'I'),
(60144, 90048, 3, 10000, 80615, 'I'),
(60145, 90048, 2, 10000, 80361, 'I'),
(60146, 90048, 1, 10000, 80593, 'I'),
(60147, 90048, 0, 10000, 80671, 'F'),
(60148, 90049, 2, 10000, NULL, 'N'),
(60149, 90049, 1, 10000, 80804, 'R'),
(60150, 90050, 2, 10000, NULL, 'I'),
(60151, 90050, 1, 10000, 80358, 'I'),
(60152, 90050, 0, 10000, 80516, 'F'),
(60153, 90051, 2, 10000, NULL, 'I'),
(60154, 90051, 1, 10000, 80405, 'I'),
(60155, 90051, 0, 10000, 80393, 'F'),
(60156, 90052, 2, 10000, NULL, 'I'),
(60157, 90052, 1, 10000, 80505, 'I'),
(60158, 90052, 0, 10000, 80469, 'F'),
(60159, 90053, 2, 10000, NULL, 'I'),
(60160, 90053, 1, 10000, 80638, 'I'),
(60161, 90053, 0, 10000, 80625, 'F'),
(60162, 90054, 2, 10000, NULL, 'I'),
(60163, 90054, 1, 10000, 80653, 'I'),
(60164, 90054, 0, 10000, 80768, 'I'),
(60165, 90055, 2, 10000, NULL, 'I'),
(60166, 90055, 1, 10000, 80829, 'I'),
(60167, 90055, 0, 10000, 80462, 'F'),
(60168, 90056, 2, 10000, NULL, 'I'),
(60169, 90056, 1, 10000, 80522, 'I'),
(60170, 90056, 0, 10000, 80554, 'F'),
(60171, 90057, 5, 10000, NULL, 'I'),
(60172, 90058, 10, 10002, NULL, 'N'),
(60173, 90057, 4, 10000, 80380, 'I'),
(60174, 90057, 3, 10000, 80395, 'I'),
(60175, 90058, 9, 10002, 80674, 'R'),
(60176, 90057, 2, 10000, 80560, 'I'),
(60177, 90057, 1, 10000, 80404, 'R'),
(60178, 90058, 8, 10002, 80440, 'R'),
(60179, 90057, 0, 10000, 80361, 'F'),
(60180, 90058, 7, 10002, 80788, 'R'),
(60181, 90058, 6, 10002, 80776, 'R'),
(60182, 90058, 5, 10002, 80599, 'R'),
(60183, 90058, 4, 10002, 80353, 'R'),
(60184, 90058, 3, 10002, 80817, 'R'),
(60185, 90058, 2, 10002, 80662, 'R'),
(60186, 90058, 1, 10002, 80830, 'R'),
(60187, 90058, 0, 10002, 80478, 'F'),
(60188, 90059, 5, 10004, NULL, 'I'),
(60189, 90059, 4, 10004, 80689, 'I'),
(60190, 90059, 3, 10004, 80745, 'I'),
(60191, 90059, 2, 10004, 80709, 'I'),
(60192, 90059, 1, 10004, 80352, 'I'),
(60193, 90059, 0, 10004, 80731, 'F'),
(60194, 90060, 5, 10004, NULL, 'I'),
(60195, 90061, 5, 10002, NULL, 'I'),
(60196, 90060, 4, 10004, 80387, 'I'),
(60197, 90061, 4, 10002, 80324, 'I'),
(60198, 90060, 3, 10004, 80683, 'I'),
(60199, 90061, 3, 10002, 80616, 'I'),
(60200, 90060, 2, 10004, 80731, 'I'),
(60201, 90061, 2, 10002, 80341, 'I'),
(60202, 90061, 1, 10002, 80555, 'I'),
(60203, 90060, 1, 10004, 80654, 'I'),
(60204, 90061, 0, 10002, 80673, 'F'),
(60205, 90060, 0, 10004, 80461, 'F'),
(60206, 90062, 5, 10000, NULL, 'I'),
(60207, 90063, 5, 10001, NULL, 'I'),
(60208, 90062, 4, 10000, 80646, 'I'),
(60209, 90064, 5, 10004, NULL, 'I'),
(60210, 90063, 4, 10001, 80564, 'I'),
(60211, 90064, 4, 10004, 80461, 'I'),
(60212, 90063, 3, 10001, 80453, 'I'),
(60213, 90062, 3, 10000, 80761, 'I'),
(60214, 90063, 2, 10001, 80489, 'I'),
(60215, 90062, 2, 10000, 80483, 'I'),
(60216, 90063, 1, 10001, 80755, 'I'),
(60217, 90064, 3, 10004, 80699, 'I'),
(60218, 90062, 1, 10000, 80586, 'I'),
(60219, 90063, 0, 10001, 80360, 'F'),
(60220, 90062, 0, 10000, 80380, 'F'),
(60221, 90064, 2, 10004, 80556, 'I'),
(60222, 90064, 1, 10004, 80654, 'I'),
(60223, 90064, 0, 10004, 80488, 'F'),
(60224, 90065, 10, 10002, NULL, 'I'),
(60225, 90065, 9, 10002, 80341, 'I'),
(60226, 90066, 2, 10000, NULL, 'I'),
(60227, 90066, 1, 10000, 80626, 'I'),
(60228, 90066, 0, 10000, 80402, 'N'),
(60229, 90067, 24, 10002, NULL, 'N'),
(60230, 90068, 5, 10002, NULL, 'N'),
(60231, 90069, 1, 10000, NULL, 'N'),
(60232, 90069, 0, 10000, 80657, 'F'),
(60233, 90070, 5, 10000, NULL, 'I'),
(60234, 90070, 4, 10000, 80544, 'I'),
(60235, 90070, 3, 10000, 80573, 'N'),
(60236, 90071, 10, 10004, NULL, 'I'),
(60237, 90071, 9, 10004, 80322, 'I'),
(60238, 90071, 8, 10004, 80711, 'R');

-- --------------------------------------------------------

--
-- Table structure for table `B_PARTICIPANT`
--

CREATE TABLE IF NOT EXISTS `B_PARTICIPANT` (
  `PARTICIPANT_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) NOT NULL,
  `QUIZ_ID` int(11) NOT NULL,
  `PARTICIPANT_CREATED` datetime NOT NULL,
  `SCORE` int(11) NOT NULL,
  PRIMARY KEY (`PARTICIPANT_ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `QUIZ_ID` (`QUIZ_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=70082 ;

--
-- Dumping data for table `B_PARTICIPANT`
--

INSERT INTO `B_PARTICIPANT` (`PARTICIPANT_ID`, `USER_ID`, `QUIZ_ID`, `PARTICIPANT_CREATED`, `SCORE`) VALUES
(70000, 50000, 90000, '2014-05-18 13:52:43', 0),
(70001, 50000, 90001, '2014-05-18 14:08:39', 1583),
(70002, 50000, 90002, '2014-05-18 14:18:29', 0),
(70003, 50000, 90003, '2014-05-18 14:42:16', 1851),
(70004, 50000, 90008, '2014-05-19 21:08:38', 882),
(70008, 50000, 90022, '2014-05-27 20:17:35', 2797),
(70009, 2, 90022, '2014-05-27 20:27:55', 2651),
(70010, 50000, 90023, '2014-05-27 20:47:38', 4458),
(70011, 3, 90023, '2014-05-27 20:47:40', 0),
(70012, 2, 90023, '2014-05-27 20:47:48', 2315),
(70013, 4, 90023, '2014-05-27 20:47:51', 3551),
(70014, 50000, 90024, '2014-05-27 20:59:09', 3592),
(70015, 2, 90024, '2014-05-27 20:59:11', 3615),
(70016, 4, 90024, '2014-05-27 20:59:16', 3423),
(70017, 5, 90024, '2014-05-27 20:59:22', 3659),
(70018, 50000, 90025, '2014-05-27 21:19:35', 4754),
(70019, 5, 90025, '2014-05-27 21:19:36', 1792),
(70020, 50000, 90027, '2014-05-28 19:54:20', 1895),
(70021, 50000, 90028, '2014-05-28 21:13:51', 1820),
(70022, 50000, 90029, '2014-05-28 21:15:31', 1893),
(70023, 50000, 90030, '2014-05-28 21:36:22', 1748),
(70024, 50000, 90031, '2014-05-28 21:37:44', 1727),
(70025, 6, 90032, '2014-05-28 21:42:31', 1625),
(70026, 2, 90033, '2014-05-28 21:43:22', 1894),
(70027, 2, 90034, '2014-05-28 21:50:54', 1922),
(70028, 2, 90036, '2014-05-29 14:30:19', 1782),
(70029, 2, 90037, '2014-05-29 19:54:27', 938),
(70030, 2, 90038, '2014-05-29 20:01:29', 1904),
(70031, 2, 90039, '2014-05-30 16:38:44', 1885),
(70032, 50000, 90040, '2014-05-30 16:46:46', 976),
(70033, 2, 90040, '2014-05-30 16:46:48', 1825),
(70034, 2, 90041, '2014-05-30 16:51:23', 1782),
(70035, 50000, 90041, '2014-05-30 16:51:23', 0),
(70036, 2, 90042, '2014-05-30 16:55:14', 513),
(70037, 6, 90043, '2014-05-30 17:25:32', 4848),
(70038, 2, 90043, '2014-05-30 17:25:33', 4376),
(70039, 50000, 90044, '2014-05-30 17:30:14', 0),
(70040, 2, 90044, '2014-05-30 17:30:29', 0),
(70041, 2, 90045, '2014-05-30 17:31:58', 0),
(70042, 50000, 90045, '2014-05-30 17:32:15', 972),
(70043, 7, 90048, '2014-06-06 17:25:36', 3683),
(70044, 2, 90057, '2014-06-08 18:29:51', 2821),
(70045, 50001, 90058, '2014-06-08 18:35:11', 4773),
(70046, 6, 90059, '2014-06-11 18:52:30', 4802),
(70047, 50013, 90059, '2014-06-11 18:52:43', 2775),
(70048, 50011, 90059, '2014-06-11 18:52:48', 3727),
(70049, 50004, 90059, '2014-06-11 18:52:53', 832),
(70050, 50012, 90059, '2014-06-11 18:52:54', 1194),
(70051, 50007, 90059, '2014-06-11 18:52:55', 1856),
(70052, 50006, 90059, '2014-06-11 18:53:00', 3480),
(70053, 50003, 90059, '2014-06-11 18:53:08', 1751),
(70054, 50009, 90059, '2014-06-11 18:53:11', 3813),
(70055, 50005, 90059, '2014-06-11 18:53:28', 4539),
(70056, 50008, 90059, '2014-06-11 18:53:40', 4622),
(70057, 50010, 90059, '2014-06-11 18:53:56', 4661),
(70058, 50014, 90059, '2014-06-11 18:56:29', 4562),
(70059, 50011, 90061, '2014-06-11 19:14:58', 984),
(70060, 6, 90060, '2014-06-11 19:15:01', 4847),
(70061, 50008, 90060, '2014-06-11 19:15:02', 3862),
(70062, 50004, 90060, '2014-06-11 19:15:04', 966),
(70063, 50003, 90061, '2014-06-11 19:15:07', 841),
(70064, 50006, 90061, '2014-06-11 19:15:09', 2717),
(70065, 50010, 90060, '2014-06-11 19:15:11', 3820),
(70066, 50007, 90061, '2014-06-11 19:15:12', 0),
(70067, 50009, 90061, '2014-06-11 19:15:16', 1951),
(70068, 50005, 90060, '2014-06-11 19:15:23', 3410),
(70069, 50014, 90060, '2014-06-11 19:15:28', 3618),
(70070, 50006, 90062, '2014-06-11 19:24:23', 2663),
(70071, 50003, 90062, '2014-06-11 19:24:24', 828),
(70072, 50007, 90063, '2014-06-11 19:25:08', 1869),
(70073, 50009, 90063, '2014-06-11 19:25:21', 4922),
(70074, 6, 90064, '2014-06-11 19:27:07', 4846),
(70075, 50014, 90064, '2014-06-11 19:28:12', 2792),
(70076, 50004, 90064, '2014-06-11 19:28:13', 1825),
(70077, 50005, 90064, '2014-06-11 19:28:20', 2705),
(70078, 50008, 90064, '2014-06-11 19:30:12', 3889),
(70079, 50010, 90064, '2014-06-11 19:30:21', 2803),
(70080, 50000, 90066, '2014-06-17 09:23:41', 0),
(70081, 50003, 90071, '2014-07-24 15:21:36', 737);

-- --------------------------------------------------------

--
-- Table structure for table `B_QUESTION`
--

CREATE TABLE IF NOT EXISTS `B_QUESTION` (
  `QUESTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CATEGORY_ID` int(11) NOT NULL,
  `SUB_CATEGORY_ID` int(11) DEFAULT NULL,
  `DIFFICULTY_ID` int(11) NOT NULL,
  `LOCATION_ID` int(11) DEFAULT NULL,
  `ERA_ID` int(11) DEFAULT NULL,
  `QUESTION` varchar(1000) NOT NULL,
  `CORRECT_ANSWER` varchar(1000) NOT NULL,
  `WRONG_ANSWER_1` varchar(1000) NOT NULL,
  `WRONG_ANSWER_2` varchar(1000) NOT NULL,
  `WRONG_ANSWER_3` varchar(1000) NOT NULL,
  `QUESTION_CREATED` datetime NOT NULL,
  `CREATED_BY_USER` int(11) DEFAULT NULL,
  `CREATED_BY_CLIENT` int(11) DEFAULT NULL,
  PRIMARY KEY (`QUESTION_ID`),
  KEY `CATEGORY_ID` (`CATEGORY_ID`),
  KEY `SUB_CATEGORY_ID` (`SUB_CATEGORY_ID`),
  KEY `DIFFICULTY_ID` (`DIFFICULTY_ID`),
  KEY `LOCATION_ID` (`LOCATION_ID`),
  KEY `ERA_ID` (`ERA_ID`),
  KEY `CREATED_BY_USER` (`CREATED_BY_USER`),
  KEY `CREATED_BY_CLIENT` (`CREATED_BY_CLIENT`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=80834 ;

--
-- Dumping data for table `B_QUESTION`
--

INSERT INTO `B_QUESTION` (`QUESTION_ID`, `CATEGORY_ID`, `SUB_CATEGORY_ID`, `DIFFICULTY_ID`, `LOCATION_ID`, `ERA_ID`, `QUESTION`, `CORRECT_ANSWER`, `WRONG_ANSWER_1`, `WRONG_ANSWER_2`, `WRONG_ANSWER_3`, `QUESTION_CREATED`, `CREATED_BY_USER`, `CREATED_BY_CLIENT`) VALUES
(80000, 20001, NULL, 10000, NULL, NULL, 'Which major French river runs through the heart of Paris?', 'Seine', 'Rhine', 'Thames', 'Nile', '2014-05-18 13:31:28', NULL, 30000),
(80001, 20005, NULL, 10001, NULL, NULL, 'What percentage of people can roll their tongue into a tube?', '0.65', '0.02', '0.14', '0.25', '2014-05-22 11:48:24', NULL, 30000),
(80314, 20005, NULL, 10001, NULL, NULL, 'What is the nominal output voltage of an alkaline AA battery?', '1.5 volts', '4.5 volts', '9 volts', '1.3 Volts', '2014-05-22 11:50:14', NULL, 30000),
(80315, 20005, NULL, 10000, NULL, NULL, 'Which temperature has the same value in Fahrenheit and Celsius?', '-40', '-15', '0', '10', '2014-05-22 11:50:14', NULL, 30000),
(80316, 20005, NULL, 10000, NULL, NULL, 'How many noble gases are there?', '6', '5', '3', '10', '2014-05-22 11:50:44', NULL, 30000),
(80317, 20000, NULL, 10004, NULL, NULL, 'Which sport or game consists of a pick, approach, plant, and toss?', 'Caber Toss', 'Snooker Or Pool', 'Bowls', '10 Pin Bowling', '2014-05-22 11:50:44', NULL, 30000),
(80318, 20004, NULL, 10001, NULL, NULL, 'How many Horsemen of the Apocalypse feature in the Bibles Book of Revelation?', '4', '3', '5', '10000', '2014-05-22 11:50:44', NULL, 30000),
(80319, 20004, NULL, 10002, NULL, NULL, 'How long did the 100 Years War last?', '116 Years', '100 Years', '105 Years', '110 Years', '2014-05-22 11:50:44', NULL, 30000),
(80320, 20000, NULL, 10004, NULL, NULL, 'How many rooms are on the Cluedo game board?', '8', '9', '10', '12', '2014-05-22 11:50:44', NULL, 30000),
(80321, 20005, NULL, 10000, NULL, NULL, 'How many legs (including arms or pincers according to certain definitions) does a crab have?', '10', '8', '6', '12', '2014-05-22 11:50:44', NULL, 30000),
(80322, 20000, NULL, 10004, NULL, NULL, 'What total do the two numbers on the opposite side of a dice always add up to?', '7', '8', '6', '12', '2014-05-22 11:50:44', NULL, 30000),
(80323, 20001, NULL, 10000, NULL, NULL, 'New York City comprises how many boroughs?', '5', '6', '7', '12', '2014-05-22 11:50:44', NULL, 30000),
(80324, 20005, NULL, 10002, NULL, NULL, 'How many points or sides does a snowflake have?', '6', '5', '7', '12', '2014-05-22 11:50:44', NULL, 30000),
(80325, 20004, NULL, 10004, NULL, NULL, 'How many pennies were in a British pre-decimal pound?', '240', '200', '204', '120', '2014-05-22 11:50:44', NULL, 30000),
(80326, 20005, NULL, 10004, NULL, NULL, 'How many chromosome pairs are there in the Human genome?', '23', '46', '27', '14', '2014-05-22 11:50:44', NULL, 30000),
(80327, 20000, NULL, 10001, NULL, NULL, 'How many hurdles are there in the mens 110m race?', '10', '20', '30', '15', '2014-05-22 11:50:44', NULL, 30000),
(80328, 20005, NULL, 10002, NULL, NULL, 'What is 0 Fahrenheit in centigrade?', '-18 degrees', '0 degrees', '-10 degrees', '-15 degrees', '2014-05-22 11:50:44', NULL, 30000),
(80329, 20005, NULL, 10001, NULL, NULL, 'How many square metres in a hectare?', '10000', '1000', '20000', '15000', '2014-05-22 11:50:44', NULL, 30000),
(80330, 20001, NULL, 10003, NULL, NULL, 'What was the name of the infamous nuclear reactor in Harrisburg Penn.?', '3 Mile Island', '1 Mile Island', '9 Mile Creek', '16 Mile Creek', '2014-05-22 11:50:44', NULL, 30000),
(80331, 20005, NULL, 10003, NULL, NULL, 'How deep in metres is 100 fathoms?', '182.88m', '1828.88m', '183.00m', '18288.80m', '2014-05-22 11:50:44', NULL, 30000),
(80332, 20004, NULL, 10002, NULL, NULL, 'In which decade does the Indian Mutiny take place, work on the Suez Canal commences, and Louis Napoleon becomes Emperor Napoleon III?', '1850s', '1840s', '1830s', '1860s', '2014-05-22 11:50:44', NULL, 30000),
(80333, 20004, NULL, 10004, NULL, NULL, 'In which decade does the Battle of Wounded Knee take place, Marconi invent the wireless, and the Dreyfuss Affair take place in France?', '1890s', '1900s', '1880s', '1910s', '2014-05-22 11:50:44', NULL, 30000),
(80334, 20004, NULL, 10003, NULL, NULL, 'In which year does Lebanon become a republic, Hirohito becomes Emperor of Japan, and Britain is hit by a nine-day General Strike?', '1926', '1925', '1924', '1923', '2014-05-22 11:50:44', NULL, 30000),
(80335, 20004, NULL, 10002, NULL, NULL, 'In what year was NATO founded?', '1949', '1950', '1948', '1947', '2014-05-22 11:50:44', NULL, 30000),
(80336, 20004, NULL, 10001, NULL, NULL, 'In which year was Malcolm X assassinated, Singapore became independent from Malaya, and Sir Winston Churchill died?', '1965', '1960', '1970', '1961', '2014-05-22 11:50:44', NULL, 30000),
(80338, 20004, NULL, 10000, NULL, NULL, 'In which year did the Yom Kippur War take place, Ceylon changed its name to Sri Lanka, and a revolution in Chile overthrows Presidente Allende?', '1973', '1975', '1970', '1983', '2014-05-22 11:50:44', NULL, 30000),
(80339, 20002, NULL, 10003, NULL, NULL, 'Twain is an Old English word for which number?', '2', '3', '12', '20', '2014-05-22 11:50:44', NULL, 30000),
(80340, 20005, NULL, 10004, NULL, NULL, 'In the Imperial Measurement system how many pounds are in a stone?', '14', '10', '16', '20', '2014-05-22 11:50:44', NULL, 30000),
(80341, 20005, NULL, 10002, NULL, NULL, 'In which year were Concorde planes retired from service?', '2003', '2000', '1998', '2006', '2014-05-22 11:50:44', NULL, 30000),
(80342, 20005, NULL, 10000, NULL, NULL, 'What was the number of the last Apollo mission?', '17', '14', '13', '22', '2014-05-22 11:50:44', NULL, 30000),
(80343, 20005, NULL, 10002, NULL, NULL, 'How many carats in pure gold?', '24', '14', '16', '22', '2014-05-22 11:50:44', NULL, 30000),
(80344, 20004, NULL, 10000, NULL, NULL, 'The core rules of the Muslim faith are known as the (how many) Pillars of Islam?', '5', '7', '9', '23', '2014-05-22 11:50:44', NULL, 30000),
(80345, 20000, NULL, 10000, NULL, NULL, 'How many balls are there on a snooker table at the start of a game?', '22', '15', '20', '24', '2014-05-22 11:50:44', NULL, 30000),
(80346, 20003, NULL, 10002, NULL, NULL, 'According to the singer Katie Melua: how many million bicycles are there in Beijing?', '9', '5', '10', '25', '2014-05-22 11:50:44', NULL, 30000),
(80347, 20000, NULL, 10002, NULL, NULL, 'How many counters does a player start with in Backgammon?', '15', '10', '20', '25', '2014-05-22 11:50:44', NULL, 30000),
(80348, 20004, NULL, 10003, NULL, NULL, 'When did the Euro banknotes and coins officially become currency in Europe?', '37257', '36892', '37347', '36982', '2014-05-22 11:50:44', NULL, 30000),
(80349, 20005, NULL, 10003, NULL, NULL, 'What number has the square root (to the nearest four decimal places) of 1.4142?', '2', '1', '3', '4', '2014-05-22 11:50:44', NULL, 30000),
(80350, 20000, NULL, 10000, NULL, NULL, 'How many pieces are on the board at the start of a game of chess?', '32', '28', '36', '40', '2014-05-22 11:50:44', NULL, 30000),
(80351, 20005, NULL, 10002, NULL, NULL, 'What was the smallest recorded waist measured on a living woman?', '38cm', '35cm', '32cm', '42cm', '2014-05-22 11:50:44', NULL, 30000),
(80352, 20000, NULL, 10004, NULL, NULL, 'How many pockets does a snooker table have?', '6', '4', '8', '5', '2014-05-22 11:50:44', NULL, 30000),
(80353, 20005, NULL, 10002, NULL, NULL, 'Europeans are familiar with A-4 size paper. What is the area of A-0 paper?', '1000mm x 1000mm', '420mm x 594mm', '1000mm x 707mm', '594mm x 841mm', '2014-05-22 11:50:44', NULL, 30000),
(80354, 20001, NULL, 10003, NULL, NULL, 'What number Pennsylvania Avenue is the White House?', '1600', '1500', '501', '65000', '2014-05-22 11:50:44', NULL, 30000),
(80355, 20004, NULL, 10004, NULL, NULL, 'How British King Georges have there been?', '6', '5', '4', '7', '2014-05-22 11:50:44', NULL, 30000),
(80356, 20005, NULL, 10000, NULL, NULL, 'A sesquicentennial celebrates how many years?', '150 Years', '100 Years', '50 Years', '75 Years', '2014-05-22 11:50:44', NULL, 30000),
(80357, 20005, NULL, 10001, NULL, NULL, 'How many feet are in a furlong?', '660', '550', '440', '770', '2014-05-22 11:50:44', NULL, 30000),
(80358, 20005, NULL, 10000, NULL, NULL, 'What is the atomic number of oxygen?', '8', '1', '35', '86', '2014-05-22 11:50:44', NULL, 30000),
(80359, 20003, NULL, 10002, NULL, NULL, 'How old has the ageless Bart Simpson been ever since his TV show began?', '10', '8', '12', '9', '2014-05-22 11:50:44', NULL, 30000),
(80360, 20005, NULL, 10001, NULL, NULL, 'What is the only number known to be both the sum and product of its factors?', '4', '6', '8', '9', '2014-05-22 11:50:44', NULL, 30000),
(80361, 20005, NULL, 10000, NULL, NULL, 'What kind of animal is a basilisk?', 'A Lizard', 'A Buffalo', 'A Deer', 'A Bird', '2014-05-22 11:50:44', NULL, 30000),
(80362, 20000, NULL, 10001, NULL, NULL, 'In Golf, what is sometimes called a 10-iron?', 'A Wedge', 'A Putter', 'A Driver', 'A Caddie', '2014-05-22 11:50:44', NULL, 30000),
(80363, 20005, NULL, 10002, NULL, NULL, 'What type of grazing animal is an Onager?', 'The Onager', 'Red Kangaroo', 'Brachiosaurus', 'A Cow', '2014-05-22 11:50:44', NULL, 30000),
(80364, 20005, NULL, 10001, NULL, NULL, 'What type of animal are Belugas?', 'Whales', 'Monkey', 'Elephant', 'A Dog', '2014-05-22 11:50:44', NULL, 30000),
(80366, 20005, NULL, 10002, NULL, NULL, 'What kind of animal is a blue-fronted parrot?', 'A Parrot', 'A Budgie', 'A Pelican', 'A Flamingo', '2014-05-22 11:50:44', NULL, 30000),
(80367, 20005, NULL, 10004, NULL, NULL, 'Which unit of measurement was defined by Henry III of England by placing three barleycorns in a line?', 'An Inch', 'A Yard', 'A Foot', 'A Furlong', '2014-05-22 11:50:44', NULL, 30000),
(80368, 20005, NULL, 10003, NULL, NULL, 'What is myrrh?', 'A Resin', 'A Metal', 'A Water Substance', 'A Gas', '2014-05-22 11:50:44', NULL, 30000),
(80369, 20004, NULL, 10003, NULL, NULL, 'What single creature did Professor Aharoni find in Syria in 1930 that is the direct ancestor of an estimated 50 million pets?', 'A Hamster', 'White Mouse', 'Albino Milk Snake', 'A Gerbil', '2014-05-22 11:50:44', NULL, 30000),
(80370, 20005, NULL, 10002, NULL, NULL, 'For fans of Mad magazine: what is an axolotl?', 'A Salamander', 'A Spotted Whiptail', 'A Dessert Branded Gecko', 'A Goat', '2014-05-22 11:50:44', NULL, 30000),
(80373, 20005, NULL, 10002, NULL, NULL, 'What (very) common item measures 210 mm by 297 mm by approximately 0.5 mm and weighs about 5g?', 'A Sheet Of A4 Paper', 'An American Dollar Bill', 'A Newspaper', 'A Letter', '2014-05-22 11:50:44', NULL, 30000),
(80374, 20005, NULL, 10003, NULL, NULL, 'What sort of animal is a Rhodesian Ridgeback?', 'A Dog', 'A Horse', 'A Wild Cat', 'A Pig', '2014-05-22 11:50:44', NULL, 30000),
(80376, 20005, NULL, 10003, NULL, NULL, 'What can be categorised as Flip, Bar, Slide, Swivel, or Brick?', 'Mobile Phones', 'Watches', 'Switch', 'A Stool', '2014-05-22 11:50:44', NULL, 30000),
(80377, 20005, NULL, 10003, NULL, NULL, 'If, in Japan, you were travelling on a Shinkansen, what mode of transport would you be using?', 'A Bullet Train', 'A Bicycle', 'A Taxi', 'A Tramway System', '2014-05-22 11:50:44', NULL, 30000),
(80378, 20005, NULL, 10003, NULL, NULL, 'Which is the only muscle in your body that is only attached at one end?', 'The Tongue', 'The Biceps', 'Rotator Cuff', 'Adductor Muscle', '2014-05-22 11:50:44', NULL, 30000),
(80379, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of New Zealand?', 'Wellington', 'Christchurch', 'Auckland', 'Adelaide', '2014-05-22 11:50:44', NULL, 30000),
(80380, 20005, NULL, 10000, NULL, NULL, 'Alligators are native to only which two countries?', 'USA And China', 'Australia And USA', 'China And Australia', 'Africa And USA', '2014-05-22 11:50:44', NULL, 30000),
(80381, 20005, NULL, 10001, NULL, NULL, 'Riboflavin, Niacin, and Folic Acid are examples of what?', 'Vitamins', 'Chemicals', 'Acids', 'Alcohol', '2014-05-22 11:50:44', NULL, 30000),
(80382, 20004, NULL, 10004, NULL, NULL, 'Who was defence minister for Israel during the Six Day War?', 'Moshe Dayan', 'Levi Eshkol', 'Shimon Peres', 'Alexey Rykov', '2014-05-22 11:50:44', NULL, 30000),
(80383, 20005, NULL, 10002, NULL, NULL, 'Which crop is attacked by the boll weevil?', 'Cotton', 'Corn', 'Wheat', 'Alfalfa', '2014-05-22 11:50:44', NULL, 30000),
(80385, 20005, NULL, 10004, NULL, NULL, 'What in radio does AM stand for?', 'Amplitude Modulation', 'Audible Mic', 'Audible Modulation', 'Amateur Modulation', '2014-05-22 11:50:44', NULL, 30000),
(80387, 20005, NULL, 10004, NULL, NULL, 'What is the SI unit of electrical current?', 'Ampere', 'Ammeter', 'Immersion', 'Ampacity', '2014-05-22 11:50:44', NULL, 30000),
(80388, 20005, NULL, 10004, NULL, NULL, 'What type of fruit is a McIntosh?', 'An Apple', 'A Pear', 'A Banana', 'An Orange', '2014-05-22 11:50:44', NULL, 30000),
(80389, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Cyprus?', 'Nicosia', 'St Helier', 'St Peter Port', 'Andorra La Vella', '2014-05-22 11:50:44', NULL, 30000),
(80393, 20005, NULL, 10000, NULL, NULL, 'What was the name of the first spacecraft to land softly on the moon?', 'Luna 9', 'Surveyor 1', 'Luna 13', 'Apollo 11', '2014-05-22 11:50:44', NULL, 30000),
(80394, 20005, NULL, 10001, NULL, NULL, 'Which Apollo mission landed the first humans on the Moon?', 'Apollo 11', 'Apollo 9', 'Apollo 7', 'Apollo 13', '2014-05-22 11:50:44', NULL, 30000),
(80395, 20006, NULL, 10000, NULL, NULL, 'What is the name of the fruit originally called Yang Tao in Southwest China, where it originates? There is a golden variety call Hinabelle.', 'Kiwi Or Kiwifruit', 'Meyer Lemon', 'Yuzu', 'Apricot', '2014-05-22 11:50:44', NULL, 30000),
(80397, 20004, NULL, 10000, NULL, NULL, 'What was the name of the foot soldiers that moved on horseback, especially popular in the 17th and 18th centuries?', 'Dragoons', 'Cavalry', 'The Watchdogs', 'Armoured Knights', '2014-05-22 11:50:44', NULL, 30000),
(80398, 20005, NULL, 10000, NULL, NULL, 'What is the name of a single dot on a computer monitor screen?', 'Pixel', 'Perforation', 'Cursor', 'Arrow', '2014-05-22 11:50:44', NULL, 30000),
(80399, 20005, NULL, 10001, NULL, NULL, 'Hansens Disease was traditionally known as what?', 'Leprosy', 'Aids', 'Leukaemia', 'Arthritis', '2014-05-22 11:50:44', NULL, 30000),
(80401, 20005, NULL, 10001, NULL, NULL, 'Fredrick Sanger invented which life saver?', 'Insulin', 'Safety Pin', 'Inflatable Life Raft', 'Aspirin', '2014-05-22 11:50:44', NULL, 30000),
(80402, 20005, NULL, 10000, NULL, NULL, 'What are Lyrids, Perseids, and Leonids?', 'Meteor Showers', 'Animals', 'Milky Ways', 'Asteroid Field', '2014-05-22 11:50:44', NULL, 30000),
(80404, 20005, NULL, 10000, NULL, NULL, 'Which small egg-shaped computer, released in 1996, had only three buttons (A, B, and C) to feed it, clean it and play games?', 'Tamagotchi', 'Gameboy Advance', 'Bitcorp Gamate', 'Atari Lynx', '2014-05-22 11:50:44', NULL, 30000),
(80405, 20000, NULL, 10000, NULL, NULL, 'Which is always the third grand slam event in the tennis calendar?', 'Wimbledon', 'French Open', 'Australian Open', 'ATP Masters', '2014-05-22 11:50:44', NULL, 30000),
(80406, 20004, NULL, 10000, NULL, NULL, 'In 1579, the Netherlands achieved independence from which country?', 'Spain', 'Portugal', 'Germany', 'Austria', '2014-05-22 11:50:44', NULL, 30000),
(80407, 20000, NULL, 10002, NULL, NULL, 'What did football referees get in 1970 that they had not had before?', 'Red And Yellow Cards', 'Whistles', 'Football Boots', 'Authority', '2014-05-22 11:50:44', NULL, 30000),
(80408, 20002, NULL, 10001, NULL, NULL, 'Which character, created by Hugh Lofting, talked to the Animals?', 'Dr Doolittle', 'St Christopher', 'St Francis Of Assisi', 'Babe The Talking Pig', '2014-05-22 11:50:44', NULL, 30000),
(80409, 20004, NULL, 10004, NULL, NULL, 'The Roman Appian Way went from Rome to where?', 'Brindisi', 'Lecce', 'Naples', 'Bari', '2014-05-22 11:50:44', NULL, 30000),
(80411, 20004, NULL, 10001, NULL, NULL, 'What in 1982 were Operation Rosario and Operation Corporate?', 'The Falklands War', 'The Attack On Rio Grande', 'The Spanish Civil War', 'Battle Of The Marshes', '2014-05-22 11:50:44', NULL, 30000),
(80412, 20004, NULL, 10002, NULL, NULL, 'The American M4 tank was better known by a Generals name. What was it?', 'Sherman', 'Smith', 'Conrad', 'Beattie', '2014-05-22 11:50:44', NULL, 30000),
(80414, 20005, NULL, 10004, NULL, NULL, 'Anteaters prefer what to ants?', 'Termites', 'Fruit', 'Birds Eggs', 'Bees', '2014-05-22 11:50:44', NULL, 30000),
(80415, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Hungary?', 'Budapest', 'Ljubljana', 'Zagreb', 'Belgrade', '2014-05-22 11:50:44', NULL, 30000),
(80416, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Spain?', 'Madrid', 'Lisbon', 'Athens', 'Berlin', '2014-05-22 11:50:44', NULL, 30000),
(80417, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Denmark?', 'Copenhagen', 'Oslo', 'Reykjavik', 'Bern', '2014-05-22 11:50:44', NULL, 30000),
(80418, 20000, NULL, 10004, NULL, NULL, 'In cross-country cycling, what do the initials BMX stand for?', 'Bicycle Moto Cross', 'Bicycle Motorcross', 'Bicycle Multiplexer', 'Bicycles Made Xtreme', '2014-05-22 11:50:44', NULL, 30000),
(80419, 20000, NULL, 10000, NULL, NULL, 'What colour is zero on a roulette wheel?', 'Green', 'Red', 'White', 'Black', '2014-05-22 11:50:44', NULL, 30000),
(80421, 20005, NULL, 10001, NULL, NULL, 'What can be classified (using the Hertzsprung-Russell diagram) as white dwarfs, main sequence, sub-giants, giants, bright giants, super-giants?', 'Stars', 'Planets', 'Asteroids', 'Black Holes', '2014-05-22 11:50:44', NULL, 30000),
(80422, 20005, NULL, 10001, NULL, NULL, 'Solid carbon dioxide is known by what name?', 'Dry Ice', 'Solid Carbon Dioxide', 'Electricity Conductor', 'Bleach', '2014-05-22 11:50:44', NULL, 30000),
(80423, 20000, NULL, 10002, NULL, NULL, 'What colour jersey does the leader of the Giro dItalia wear?', 'Pink', 'Yellow', 'Green', 'Blue', '2014-05-22 11:50:44', NULL, 30000),
(80424, 20004, NULL, 10004, NULL, NULL, 'From which country did Panama declare independence in 1903?', 'Colombia', 'Peru', 'Venezuela', 'Bolivia', '2014-05-22 11:50:44', NULL, 30000),
(80425, 20005, NULL, 10003, NULL, NULL, 'What is a camels hump made of? Water, fat or muscle?', 'Fat', 'Water', 'Muscle', 'Bone', '2014-05-22 11:50:44', NULL, 30000),
(80426, 20005, NULL, 10004, NULL, NULL, 'What is the name of the oil (or fat) obtained from wool?', 'Lanolin', 'Linseed', 'Quinoa', 'Borage', '2014-05-22 11:50:44', NULL, 30000),
(80427, 20005, NULL, 10003, NULL, NULL, 'Which element has atomic number 2?', 'Helium', 'Hydrogen', 'Lithium', 'Boron', '2014-05-22 11:50:44', NULL, 30000),
(80428, 20001, NULL, 10000, NULL, NULL, 'What is the Capital city of the USA?', 'Washington DC', 'New York', 'San Francisco', 'Boston', '2014-05-22 11:50:44', NULL, 30000),
(80429, 20001, NULL, 10000, NULL, NULL, 'The British Naval Ensign features a Union Jack in which corner?', 'Top Left', 'Top Right', 'Bottom Left', 'Bottom Right', '2014-05-22 11:50:44', NULL, 30000),
(80430, 20000, NULL, 10002, NULL, NULL, 'If your balls are black and blue and your opponents are red and yellow, what would you be playing?', 'Croquet', 'Boxing', 'Pool', 'Bowls', '2014-05-22 11:50:44', NULL, 30000),
(80431, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of the Netherlands?', 'The Hague', 'Luxembourg City', 'Ottawa', 'Brasilia', '2014-05-22 11:50:44', NULL, 30000),
(80432, 20000, NULL, 10003, NULL, NULL, 'Which country won the first FIFA World Cup held in 1930?', 'Uruguay', 'Italy', 'France', 'Brazil', '2014-05-22 11:50:44', NULL, 30000),
(80433, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Australia?', 'Canberra', 'Sydney', 'Melbourne', 'Brisbane', '2014-05-22 11:50:44', NULL, 30000),
(80436, 20000, NULL, 10002, NULL, NULL, 'Whose ears did Mike Tyson bite in The Sound and the Fury fight held in Las Vegas in 1997?', 'Evander Holyfield', 'Muhammad Ali', 'Razor Ruddick', 'Bruce Seldon', '2014-05-22 11:50:44', NULL, 30000),
(80437, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of the Czech Republic?', 'Prague', 'Warsaw', 'Tallinn', 'Brussels', '2014-05-22 11:50:44', NULL, 30000),
(80438, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Lithuania?', 'Vilnius', 'Riga', 'Kiev', 'Bucharest', '2014-05-22 11:50:44', NULL, 30000),
(80439, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Brazil?', 'Brasilia', 'Rio De Janeiro', 'Sao Paulo', 'Bueno Aires', '2014-05-22 11:50:44', NULL, 30000),
(80440, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Luxembourg?', 'Luxembourg City', 'Ottawa', 'Brasilia', 'Buenos Aires', '2014-05-22 11:50:44', NULL, 30000),
(80441, 20005, NULL, 10003, NULL, NULL, 'What is the psychological condition of displaying loyalty to ones captors, regardless of the danger they have placed you in?', 'Stockholm Syndrome', 'Ekboms Syndrome', 'Huntingtons Disease', 'Bulimia Nervosa', '2014-05-22 11:50:44', NULL, 30000),
(80442, 20000, NULL, 10004, NULL, NULL, 'Which sport did Oscar Wilde describe as the unspeakable in pursuit of the uneatable?', 'Fox Hunting', 'Archery', 'Goose Pulling', 'Bull Fighting', '2014-05-22 11:50:44', NULL, 30000),
(80443, 20000, NULL, 10004, NULL, NULL, 'What swimming stroke is the first leg of the medley relay?', 'Backstroke', 'Breaststroke', 'Freestyle Stroke', 'Butterfly Stroke', '2014-05-22 11:50:44', NULL, 30000),
(80444, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Iceland?', 'Reykjavik', 'Bern', 'Mexico City', 'Canberra', '2014-05-22 11:50:44', NULL, 30000),
(80445, 20005, NULL, 10002, NULL, NULL, 'What is the negatively charged electrode called? (one in which the current flows out)', 'Cathode', 'Coulomb', 'Bound Charge', 'Capacitor', '2014-05-22 11:50:44', NULL, 30000),
(80446, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Colombia?', 'Bogota', 'La Paz', 'Santiago', 'Caracas', '2014-05-22 11:50:44', NULL, 30000),
(80447, 20005, NULL, 10000, NULL, NULL, 'What is the main gas (by volume) in car exhaust?', 'Nitrogen', 'Water Vapour', 'Carbon Dioxide', 'Carbon Monoxide', '2014-05-22 11:50:44', NULL, 30000),
(80448, 20005, NULL, 10003, NULL, NULL, 'A radioactive isotope of Americium can be found in many homes and workplaces. Where?', 'Smoke Detectors', 'Fire Extinguisher', 'Kettles', 'Carbon Monoxide Detector', '2014-05-22 11:50:44', NULL, 30000),
(80449, 20005, NULL, 10004, NULL, NULL, 'What is calcium carbonate normally known as?', 'Chalk', 'Talcum Powder', 'Milk', 'Carbonated Soda', '2014-05-22 11:50:44', NULL, 30000),
(80453, 20005, NULL, 10001, NULL, NULL, 'What does a nidologist study?', 'Bird Nests', 'Clouds', 'Waves', 'Caves', '2014-05-22 11:50:44', NULL, 30000),
(80454, 20005, NULL, 10001, NULL, NULL, 'Which metal is named after Cyprus where it was mined in the Roman era?', 'Copper', 'Cobalt', 'Chromium', 'Cerium', '2014-05-22 11:50:44', NULL, 30000),
(80455, 20001, NULL, 10004, NULL, NULL, 'What is the Capital of the island of Alderney?', 'St Anne', 'Tirana', 'Prishtina', 'Chisinau', '2014-05-22 11:50:44', NULL, 30000),
(80456, 20004, NULL, 10003, NULL, NULL, 'How many earths would fit inside the sun?', 'Circa 1,000,000', 'Circa 100', 'Circa 10,000', 'Circa 100,000', '2014-05-22 11:50:44', NULL, 30000),
(80457, 20000, NULL, 10004, NULL, NULL, 'Where do Portuguese Formula 1 Grand Prix races take place (at least since 1984 and when they happen)?', 'Autodromo De Estoril', 'Circuito Da Boavista', 'Mosanto Park Circuit', 'Circuito Vasco Sameiro', '2014-05-22 11:50:44', NULL, 30000),
(80459, 20005, NULL, 10002, NULL, NULL, 'The three wise men supposedly brought gold, frankincense and myrrh. What are frankincense and myrrh?', 'Resins', 'Chemicals', 'Food', 'Clothing', '2014-05-22 11:50:44', NULL, 30000),
(80460, 20005, NULL, 10004, NULL, NULL, 'What in Asia is a Tuk-tuk?', 'An Auto-Rickshaw', 'A Chain Of Restaurants', 'Travel Company', 'Clothing Outlet', '2014-05-22 11:50:44', NULL, 30000),
(80461, 20005, NULL, 10004, NULL, NULL, 'Which gas has the chemical formula CO?', 'Carbon Monoxide', 'Water', 'Carbon Dioxide', 'Cobalt', '2014-05-22 11:50:44', NULL, 30000),
(80462, 20005, NULL, 10000, NULL, NULL, 'Vaseline is a trademark for what?', 'Petroleum Jelly', 'Healthcare', 'Moisture Products', 'Cocoa Butter', '2014-05-22 11:50:44', NULL, 30000),
(80464, 20005, NULL, 10004, NULL, NULL, 'BASIC, Perl, and Python are types of what?', 'Computer Languages', 'Animal', 'Chemical', 'Computer Overdrive', '2014-05-22 11:50:44', NULL, 30000),
(80465, 20005, NULL, 10004, NULL, NULL, 'Evaporation is changing from a liquid to gas. What is changing from a solid to a gas called?', 'Sublimation', 'Stabilisation', 'Solidification', 'Condensate', '2014-05-22 11:50:44', NULL, 30000),
(80466, 20000, NULL, 10003, NULL, NULL, 'What is South Americs equivalent of the Champions League called?', 'Copa Libertadores', 'Copa America', 'Copa Conmebol', 'Copa Alberto', '2014-05-22 11:50:44', NULL, 30000),
(80467, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Germany?', 'Berlin', 'Vienna', 'Moscow', 'Copenhagen', '2014-05-22 11:50:44', NULL, 30000),
(80468, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Uruguay?', 'Montevideo', 'Porto Alegre', 'Rio De Janeiro', 'Cordoba', '2014-05-22 11:50:44', NULL, 30000),
(80469, 20005, NULL, 10000, NULL, NULL, 'What medical speciality studies the anatomy and physiology of the heart?', 'Cardiology', 'Corpus Daius', 'Neurology', 'Corpus Christi', '2014-05-22 11:50:44', NULL, 30000),
(80470, 20003, NULL, 10000, NULL, NULL, 'What genre of Music was Luciano Pavarotti most famous for?', 'Opera', 'Drum And Bass', 'Punk', 'Country', '2014-05-22 11:50:44', NULL, 30000),
(80471, 20004, NULL, 10004, NULL, NULL, 'Sitting Bull belonged to which tribe?', 'Sioux', 'Mohican', 'Hopi People', 'Creek', '2014-05-22 11:50:44', NULL, 30000),
(80472, 20005, NULL, 10001, NULL, NULL, 'From which well-known type of flower are Vanilla pods obtained?', 'Orchids', 'Runner Beans', 'Milkweed Flower', 'Crepe Myrtle', '2014-05-22 11:50:44', NULL, 30000),
(80474, 20000, NULL, 10000, NULL, NULL, 'Which sport cannot be played left handed since 1975, for safety reasons?', 'Polo', 'Golf', 'Pool', 'Croquet', '2014-05-22 11:50:44', NULL, 30000),
(80475, 20000, NULL, 10003, NULL, NULL, 'Which sport has the highest ratio of officials to players?', 'Tennis', 'Volleyball', 'Swimming', 'Curling', '2014-05-22 11:50:44', NULL, 30000),
(80477, 20000, NULL, 10003, NULL, NULL, 'Who was the first American to win the Formula 1 World Championship?', 'Phil Hill', 'Eddie Cheever', 'Mario Andretti', 'Dan Gurney', '2014-05-22 11:50:44', NULL, 30000),
(80478, 20005, NULL, 10002, NULL, NULL, 'Who was the scientist who measured, on his honeymoon, the amount of heat produced by a local waterfall? (He never had children).', 'James Prescott Joule', 'James Watson', 'Bill Nye', 'David Bohm', '2014-05-22 11:50:44', NULL, 30000),
(80479, 20001, NULL, 10004, NULL, NULL, 'What was the capital city of India until December 1911?', 'Calcutta', 'Shimla', 'Jahangir', 'Delhi', '2014-05-22 11:50:44', NULL, 30000),
(80480, 20004, NULL, 10002, NULL, NULL, 'What was the operation to liberate Kuwait in 1991 called?', 'Desert Storm', 'Desert Shield', 'Desert Fox', 'Desert Falcon', '2014-05-22 11:50:44', NULL, 30000),
(80481, 20005, NULL, 10003, NULL, NULL, 'What is an explosive mixture of sulphur, charcoal, and saltpetre (potassium nitrate) more commonly known as?', 'Gunpowder', 'Flashpowder', 'TNT', 'Detasheet', '2014-05-22 11:50:44', NULL, 30000),
(80482, 20002, NULL, 10003, NULL, NULL, 'Which novel won author J.M. Coetzee the Booker Prize?', 'Disgrace', 'Discretion', 'Discourse', 'Direction', '2014-05-22 11:50:44', NULL, 30000),
(80483, 20005, NULL, 10000, NULL, NULL, 'What does DVD stand for?', 'Digital Versatile Disc', 'Digital Video Disc', 'Data Versatile Disc', 'Disc Video Data', '2014-05-22 11:50:44', NULL, 30000),
(80484, 20005, NULL, 10004, NULL, NULL, 'What are the two types of camel called?', 'Dromedary And Bactrian', 'Guanacos And Llamas', 'Alpacas And Bactrian', 'Dromedary And Alpacas', '2014-05-22 11:50:44', NULL, 30000),
(80485, 20006, NULL, 10001, NULL, NULL, 'The Islamic and Jewish faiths outlaw the eating of which farm yard animal?', 'Pig', 'Horse', 'Cow', 'Duck', '2014-05-22 11:50:44', NULL, 30000),
(80486, 20001, NULL, 10003, NULL, NULL, 'What is the old name for Sri Lanka?', 'Ceylon', 'Mandalay', 'Spice Islands', 'East Pakistan', '2014-05-22 11:50:44', NULL, 30000),
(80487, 20005, NULL, 10004, NULL, NULL, 'The winter solstice (summer in the Southern hemisphere) occurs when the sun is furthest from the equator (on December 22nd). What do we call the days the sun crosses the equator in March and September?', 'Equinox', 'Autumnal Equinox', 'Vernal Equinox', 'Eclipse', '2014-05-22 11:50:44', NULL, 30000),
(80488, 20004, NULL, 10004, NULL, NULL, 'Which battle does the French Foreign Legion celebrate every year?', 'Camerone', 'Fleurus', 'Genoa', 'Engen', '2014-05-22 11:50:44', NULL, 30000),
(80489, 20005, NULL, 10001, NULL, NULL, 'What two time Nobel Prize winner was a proponent of Vitamin C?', 'Linus Pauling', 'Sir James W Black', 'Joseph Brodsky', 'Ernst Ruska', '2014-05-22 11:50:44', NULL, 30000),
(80491, 20005, NULL, 10001, NULL, NULL, 'Which law states that, at a constant temperature, the pressure of a gas is inversely proportional to its volume?', 'Boyles Law', 'Braggs Law', 'Charles Law', 'Faradays Law', '2014-05-22 11:50:44', NULL, 30000),
(80493, 20005, NULL, 10003, NULL, NULL, 'What is agliophobia?', 'Fear Of Pain', 'Fear Of Sourness', 'Fear Of Heights', 'Fear Of Noise', '2014-05-22 11:50:44', NULL, 30000),
(80494, 20000, NULL, 10003, NULL, NULL, 'The Marquis of Queensbury Rules are the accepted code of rules for which sport?', 'Boxing', 'Golf', 'Tennis', 'Fencing', '2014-05-22 11:50:44', NULL, 30000),
(80496, 20000, NULL, 10001, NULL, NULL, 'Brazil have been world football champions more times than any other nation. Whom did they beat to become World Champions the first time?', 'Sweden And Finland', 'Italy And France', 'Greece And Holland', 'Finland And England', '2014-05-22 11:50:44', NULL, 30000),
(80497, 20005, NULL, 10003, NULL, NULL, 'During which phase of the moon can a solar eclipse occur?', 'New Moon', 'Half Moon', 'Waxing Crescent Moon', 'First Quarter Moon', '2014-05-22 11:50:44', NULL, 30000),
(80498, 20004, NULL, 10003, NULL, NULL, 'In which war did jet aircraft first fight each other?', 'The Korean War', 'Spanish Civil War', 'Second World War', 'First World War', '2014-05-22 11:50:44', NULL, 30000),
(80499, 20005, NULL, 10003, NULL, NULL, 'How many leaves does a shamrock have?', 'Three', 'Two', 'Four', 'Five', '2014-05-22 11:50:44', NULL, 30000),
(80500, 20005, NULL, 10000, NULL, NULL, 'How many astronauts crewed the Gemini series of spacecraft?', 'Two', 'Three', 'One', 'Five', '2014-05-22 11:50:44', NULL, 30000),
(80501, 20000, NULL, 10000, NULL, NULL, 'Which baseball team has won the World Series most often?', 'The New York Yankees', 'Boston Red Socks', 'Philadelphia Phillies', 'Florida Marlins', '2014-05-22 11:50:44', NULL, 30000),
(80502, 20000, NULL, 10001, NULL, NULL, 'What is the name of the multi discipline sporting event that occurs every 4 years that is based on the ancient Greeks festival of games?', 'The Olympics', 'The Super Bowl', 'Fa Cup Final', 'Football World Cup', '2014-05-22 11:50:44', NULL, 30000),
(80503, 20000, NULL, 10001, NULL, NULL, 'In which sport do neither the participants nor the spectators know the score until the end?', 'Boxing', 'Chess', 'Swimming', 'Formula 1', '2014-05-22 11:50:44', NULL, 30000),
(80504, 20000, NULL, 10003, NULL, NULL, 'Which nation held the world team archery title throughout the 1970s?', 'USA', 'Germany', 'Great Britain', 'France', '2014-05-22 11:50:44', NULL, 30000),
(80505, 20004, NULL, 10000, NULL, NULL, 'Who claimed responsibility for the kidnapping and murder of Italian prime minister Aldo Moro in 1978?', 'The Red Brigades', 'His Own Party', 'The Italian Mafia', 'Francesco Tritto', '2014-05-22 11:50:44', NULL, 30000),
(80506, 20004, NULL, 10001, NULL, NULL, 'Which three letters replaced CQD?', 'SOS', 'KGB', 'TNT', 'FYI', '2014-05-22 11:50:44', NULL, 30000),
(80507, 20005, NULL, 10001, NULL, NULL, 'Pencil lead is made out what?', 'Graphite And Clay', 'Lead', 'Chalk', 'Galena', '2014-05-22 11:50:44', NULL, 30000),
(80508, 20005, NULL, 10003, NULL, NULL, 'On the Moh Hardness scale, what has a hardness of 10?', 'Diamond', 'Corundum', 'Beryl', 'Garnet', '2014-05-22 11:50:44', NULL, 30000),
(80509, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Switzerland?', 'Bern', 'Mexico City', 'Zurich', 'Geneva', '2014-05-22 11:50:44', NULL, 30000),
(80511, 20004, NULL, 10002, NULL, NULL, 'Who is the only American President to have served non-consecutive terms in office?', 'Grover Cleveland', 'James Madison', 'John Tyler', 'Gerald Ford', '2014-05-22 11:50:44', NULL, 30000),
(80512, 20000, NULL, 10004, NULL, NULL, 'The 1000 Lakes Rally was held in which country?', 'Finland', 'Spain', 'Portugal', 'Germany', '2014-05-22 11:50:44', NULL, 30000),
(80513, 20000, NULL, 10003, NULL, NULL, 'Which country has won the most medals in the Winter Olympics (to January 2010)?', 'Norway', 'USA', 'Russia', 'Germany', '2014-05-22 11:50:44', NULL, 30000),
(80514, 20005, NULL, 10004, NULL, NULL, 'What is the name of the shortest route between two points on a sphere? (Such as flying between two points on earth.)', 'Great Circle', 'Great Square', 'Pole Circle', 'Great Pole', '2014-05-22 11:50:44', NULL, 30000),
(80515, 20001, NULL, 10002, NULL, NULL, 'What colour is the cross on the Finnish flag?', 'Blue', 'White', 'Red', 'Green', '2014-05-22 11:50:44', NULL, 30000),
(80516, 20000, NULL, 10000, NULL, NULL, 'What are the only two colours allowed for the ball in Table Tennis competitions?', 'White And Orange', 'Purple And Orange', 'White And Green', 'Green And Orange', '2014-05-22 11:50:44', NULL, 30000),
(80517, 20005, NULL, 10000, NULL, NULL, 'In the physical world (as opposed to art) what are the primary colours?', 'Red, Green And Blue', 'Blue, Green And Purple', 'Yellow, Red And Pink', 'Green, Red And Orange', '2014-05-22 11:50:44', NULL, 30000),
(80518, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Mexico?', 'Mexico City', 'Cancun', 'Acapulco', 'Guadalajara', '2014-05-22 11:50:44', NULL, 30000),
(80519, 20004, NULL, 10000, NULL, NULL, 'What is the ruling family of Monaco called?', 'Grimaldi', 'Gerald', 'Germunia', 'Gustaf', '2014-05-22 11:50:44', NULL, 30000),
(80520, 20001, NULL, 10001, NULL, NULL, 'Only one South American country had a Monarchy. Which was it?', 'Brazil', 'Argentina', 'Columbia', 'Guyana', '2014-05-22 11:50:44', NULL, 30000),
(80521, 20000, NULL, 10001, NULL, NULL, 'In which sport would you go to a Basho?', 'Sumo Wrestling', 'Kick-Boxing', 'Table Tennis', 'Gymnastics', '2014-05-22 11:50:44', NULL, 30000),
(80522, 20000, NULL, 10000, NULL, NULL, 'What is the most common distance of a drag race?', 'A Quarter Of A Mile', '100 Meters', 'A Mile', 'Half A Mile', '2014-05-22 11:50:44', NULL, 30000),
(80525, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Ukraine?', 'Kiev', 'Bucharest', 'Sofia', 'Helsinki', '2014-05-22 11:50:44', NULL, 30000),
(80526, 20004, NULL, 10001, NULL, NULL, 'Who was the first Tudor King of England, crowned in 1485?', 'Henry VII', 'Henry VIII', 'Edward VI', 'Henry V', '2014-05-22 11:50:44', NULL, 30000),
(80527, 20004, NULL, 10002, NULL, NULL, 'What was Papa Docs real name (president of Haiti)?', 'Dr Francois Duvalier', 'Jean Claude Duvalier', 'Prosper Avril', 'Herald Abraham', '2014-05-22 11:50:44', NULL, 30000),
(80528, 20005, NULL, 10003, NULL, NULL, 'The bark of the Cinchona, historically known as Jesuits Bark or Peruvian Bark, was the original source of which drug?', 'Quinine', 'Aspirin', 'Penicillin', 'Heroin', '2014-05-22 11:50:44', NULL, 30000),
(80529, 20005, NULL, 10004, NULL, NULL, 'What is the SI unit of frequency (used in measuring audio and radio transmissions among many others)?', 'Hertz', 'Waves', 'Rotation', 'Heterodyne', '2014-05-22 11:50:44', NULL, 30000),
(80530, 20005, NULL, 10003, NULL, NULL, 'What is the name of the alloy made of 95% aluminium, 4% copper and small amounts of magnesium and manganese?', 'Duraluminium', 'Magnalium', 'Alnico', 'Hiduminium', '2014-05-22 11:50:44', NULL, 30000),
(80531, 20000, NULL, 10001, NULL, NULL, 'Which is always the first event of the Mens Decathlon?', '100 Metres', 'Shot Putt', '400 Meters', 'High Jump', '2014-05-22 11:50:44', NULL, 30000),
(80532, 20005, NULL, 10002, NULL, NULL, 'What were (and still are) Skyscrapers before the term was applied to tall buildings?', 'Sails', 'Superstructure', 'Edifice', 'High-Rise Building', '2014-05-22 11:50:44', NULL, 30000),
(80534, 20005, NULL, 10000, NULL, NULL, 'If your Wassermann test came up positive, what would you be suffering from?', 'Syphyllis', 'Coeliac Disease', 'Alzheimers', 'HIV', '2014-05-22 11:50:44', NULL, 30000),
(80535, 20004, NULL, 10000, NULL, NULL, 'Which town was the scene of the gunfight at the OK Corral?', 'Tombstone, Arizona', 'Springfield , Missouri', 'Las Vegas , New Mexico', 'Holbrook , Arizona', '2014-05-22 11:50:44', NULL, 30000),
(80536, 20005, NULL, 10003, NULL, NULL, 'Which species of animal has the greatest variety of shape and size?', 'Dogs', 'Cat', 'Birds', 'Horses', '2014-05-22 11:50:44', NULL, 30000),
(80537, 20004, NULL, 10001, NULL, NULL, 'The Kings of Italy all belonged to which house?', 'House Of Savoy', 'House Of Glen', 'House Of Pain', 'House Of Fraser', '2014-05-22 11:50:44', NULL, 30000),
(80538, 20001, NULL, 10004, NULL, NULL, 'What is the Capital City of Illinois?', 'Springfield', 'Chicago', 'Rockford', 'Houston', '2014-05-22 11:50:44', NULL, 30000),
(80540, 20005, NULL, 10000, NULL, NULL, 'Who invented natural logarithms?', 'John Napier', 'Wallace Smith Broecker', 'John Dalton', 'Humphrey Davie', '2014-05-22 11:50:44', NULL, 30000),
(80541, 20007, NULL, 10003, NULL, NULL, 'Who was the penultimate King of Egypt?', 'King Farouk I', 'King Ahmed Fuad', 'King Ahmed Fuad II', 'Hussein Kamel', '2014-05-22 11:50:44', NULL, 30000),
(80542, 20005, NULL, 10001, NULL, NULL, 'Which isotope is commonly used to date decayed organic matter?', 'Carbon 14', 'Carbob 12', 'Carbon 13', 'Hydrogen 3', '2014-05-22 11:50:44', NULL, 30000),
(80543, 20005, NULL, 10003, NULL, NULL, 'Which is the lightest gas?', 'Hydrogen', 'Water Vapour (Steam)', 'Deuterium', 'Hydroxyl', '2014-05-22 11:50:44', NULL, 30000),
(80544, 20004, NULL, 10000, NULL, NULL, 'What was the Roman name for Ireland?', 'Hibernia', 'Gallia', 'Helvetia', 'Iberia', '2014-05-22 11:50:44', NULL, 30000),
(80545, 20000, NULL, 10003, NULL, NULL, 'What is the name of the chess move in which a piece takes another but does not move into the square of the captured piece?', 'En Passant', 'En Prise', 'Expanded Centre', 'Illegal Move', '2014-05-22 11:50:44', NULL, 30000),
(80546, 20005, NULL, 10002, NULL, NULL, 'Where, in a household, would you find a magnetron?', 'In A Microwave Oven', 'In An Oven', 'In A Hoover', 'In A Smoke Detector', '2014-05-22 11:50:44', NULL, 30000),
(80551, 20005, NULL, 10003, NULL, NULL, 'Which element takes its name from the Greek for pale green?', 'Chlorine', 'Sulphur', 'Gallium', 'Iodine', '2014-05-22 11:50:44', NULL, 30000),
(80552, 20005, NULL, 10003, NULL, NULL, 'Which metal do you get from bauxite?', 'Aluminium', 'Copper', 'Steel', 'Iron', '2014-05-22 11:50:44', NULL, 30000),
(80553, 20005, NULL, 10003, NULL, NULL, 'What is the name given to lines of equal underwater depth on maps?', 'Isobath', 'Parallel', 'Opisometer', 'Isodapane', '2014-05-22 11:50:44', NULL, 30000),
(80554, 20002, NULL, 10000, NULL, NULL, 'Harry Potter was the creation of which British author?', 'J K Rowling', 'Roald Dahl', 'Julia Donaldson', 'J R R Tolkien', '2014-05-22 11:50:44', NULL, 30000),
(80555, 20000, NULL, 10002, NULL, NULL, 'Who is the only professional boxer to have retired undefeated holding the world heavyweight title?', 'Rocky Marciano', 'Floyd Patterson', 'Cassius Clay', 'Jack Dempsey', '2014-05-22 11:50:44', NULL, 30000),
(80556, 20000, NULL, 10004, NULL, NULL, 'Who was the first non-European to win the Tour de France?.', 'Greg Lemond', 'Lance Armstrong', 'Tyler Farrar', 'Jeff Pierce', '2014-05-22 11:50:44', NULL, 30000),
(80557, 20003, NULL, 10001, NULL, NULL, 'Who plays Lara Croft in the Tomb Raider series of films?', 'Angelina Jolie', 'Minnie Driver', 'Nell Mcandrew', 'Jennifer Aniston', '2014-05-22 11:50:44', NULL, 30000),
(80558, 20004, NULL, 10000, NULL, NULL, 'Who was the first US president to be shot and survive (whilst in office)?', 'Ronald Reagan', 'James A Garfield', 'William Mckinley', 'Jimmy Carter', '2014-05-22 11:50:44', NULL, 30000),
(80559, 20000, NULL, 10003, NULL, NULL, 'What is Tiger Woods first name?', 'Eldrick', 'Tiger', 'Mohammed', 'John', '2014-05-22 11:50:44', NULL, 30000),
(80560, 20004, NULL, 10000, NULL, NULL, 'Who was Queen Victoria married to?', 'Prince Albert', 'Prince George', 'King Henry VII', 'John Balliol', '2014-05-22 11:50:44', NULL, 30000),
(80561, 20000, NULL, 10002, NULL, NULL, 'Who was the first person to swim the English Channel?', 'Captain Matthew Webb', 'Thomas William Burgess', 'Henry Sullivan', 'John Maclean', '2014-05-22 11:50:44', NULL, 30000),
(80562, 20000, NULL, 10002, NULL, NULL, 'Who was the first unseeded player to win the Mens singles at Wimbledon?', 'Boris Becker In 1985', 'Goran Ivanisevic In 2001', 'Venus Williams', 'John Mcenroe', '2014-05-22 11:50:44', NULL, 30000),
(80563, 20000, NULL, 10003, NULL, NULL, 'Who won his fourth consecutive Olympic long jump gold in 1996?', 'Carl Lewis', 'Jesse Owens', 'Mike Powell', 'Jonathan Edwards', '2014-05-22 11:50:44', NULL, 30000),
(80564, 20004, NULL, 10001, NULL, NULL, 'Who was the real spy (for the Germans) in the Dreyfuss Affair?', 'Major Esterhazy', 'Kurt Jahnke', 'Johhny Jebsen', 'Jose Waldberg', '2014-05-22 11:50:44', NULL, 30000),
(80565, 20004, NULL, 10003, NULL, NULL, 'Which 20th century dictator ordered that all sparrows in the land be killed?', 'Mao Zedong', 'Adolf Hitler', 'Mobutu Sese Seko', 'Joseph Stalin', '2014-05-22 11:50:44', NULL, 30000),
(80566, 20007, NULL, 10003, NULL, NULL, 'Who succeeded Paul von Hindenburg as the German head of state?', 'Adolf Hitler', 'Walter Simons', 'Hans Luther', 'Karl Donitz', '2014-05-22 11:50:44', NULL, 30000),
(80567, 20006, NULL, 10002, NULL, NULL, 'Which edible bean produces the most flatulence?', 'Soya', 'Baked Beans', 'Runner Beans', 'Kidney Beans', '2014-05-22 11:50:44', NULL, 30000),
(80568, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Slovakia?', 'Bratislava', 'Vilnius', 'Riga', 'Kiev', '2014-05-22 11:50:44', NULL, 30000),
(80569, 20005, NULL, 10003, NULL, NULL, 'The prefix mega- is a millionfold in the SI units and giga- is a billion. Tera is a trillion but what is the quadrillionfold (10 to the power of 15) prefix?', 'Peta', 'Fera', 'Una', 'Kilo', '2014-05-22 11:50:44', NULL, 30000),
(80570, 20004, NULL, 10002, NULL, NULL, 'Bulgaria achieved independence in 1908 from which country?', 'The Ottoman Empire', 'Croatia', 'Egypt', 'Kingdom Of Bosnia', '2014-05-22 11:50:44', NULL, 30000),
(80571, 20000, NULL, 10000, NULL, NULL, 'Which sport invented at the Outrigger Canoe Club in Waikiki, Hawaii, and popularised in Santa Monica, California, since the 1920s became an Olympic sport in 1996?', 'Beach Volleyball', 'Beach Football', 'Body Surfing', 'Kite Boarding', '2014-05-22 11:50:44', NULL, 30000),
(80572, 20000, NULL, 10003, NULL, NULL, 'Which US sports team fell under the Curse of the Bambino causing it to have an 86 year drought of championship trophies after its star player was sold in 1919 to its major rival?', 'The Boston Red Sox', 'Detroit Lions', 'Houston Texans', 'La Dodgers', '2014-05-22 11:50:44', NULL, 30000),
(80573, 20000, NULL, 10000, NULL, NULL, 'Where were the Harlem Globetrotters formed?', 'Chicago In 1926', 'Detroit 1932', 'Cleveland In 1946', 'La In 1960', '2014-05-22 11:50:44', NULL, 30000),
(80575, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Albania?', 'Tirana', 'Prishtina', 'Chisinau', 'La Paz', '2014-05-22 11:50:44', NULL, 30000),
(80576, 20003, NULL, 10003, NULL, NULL, 'What famous piece of classical music is acclaimed to have been written by King Henry the VIII?', 'Greensleaves', 'Brandenburg Concerto', 'Air On A G String', 'Land Of Hope And Glory', '2014-05-22 11:50:44', NULL, 30000),
(80577, 20001, NULL, 10002, NULL, NULL, 'What is the modern name of ancient Mesopotamia?', 'Iraq', 'Iran', 'Israel', 'Lebanon', '2014-05-22 11:50:44', NULL, 30000),
(80578, 20001, NULL, 10000, NULL, NULL, 'What is the International Air Transport Association airport code for Heathrow Airport?', 'LHR', 'HTR', 'HRW', 'LHW', '2014-05-22 11:50:44', NULL, 30000),
(80579, 20004, NULL, 10001, NULL, NULL, 'The ancient region of Nubia is in which two modern countries?', 'Egypt And Sudan', 'Egypt And Ethiopia', 'Ethiopia And Sudan', 'Libya And Egypt', '2014-05-22 11:50:44', NULL, 30000),
(80580, 20004, NULL, 10004, NULL, NULL, 'Air Force One is the US Presidents plane. What is Marine One?', 'A Helicopter', 'A Boat', 'Sports Car', 'Limousine', '2014-05-22 11:50:44', NULL, 30000),
(80582, 20005, NULL, 10001, NULL, NULL, 'What is the name of the study of the motion of the earths crust?', 'Plate Tectonics', 'Dynamic Earth', 'Wilson Cycle', 'Lithosphere Observation', '2014-05-22 11:50:44', NULL, 30000),
(80583, 20000, NULL, 10003, NULL, NULL, 'Which swimmer won six gold medals at the Athens Olympics in 2004?', 'Michael Phelps', 'Mark Spitz', 'Matt Biondi', 'Lloyd Spooner', '2014-05-22 11:50:44', NULL, 30000),
(80584, 20005, NULL, 10003, NULL, NULL, 'In which animal species does the male get pregnant?', 'Sea Horses', 'Spiders', 'Grasshoppers', 'Lobsters', '2014-05-22 11:50:44', NULL, 30000),
(80585, 20005, NULL, 10001, NULL, NULL, 'Which castle was the childhood home of Elizabeth Bowes-Lyon, the late Queen Mother?', 'Glamis Castle', 'Craigievar Castle', 'Invergarry Castle', 'Loch Leven Castle', '2014-05-22 11:50:44', NULL, 30000),
(80586, 20001, NULL, 10000, NULL, NULL, 'What is the Capital city of France?', 'Paris', 'Madrid', 'Berlin', 'London', '2014-05-22 11:50:44', NULL, 30000),
(80587, 20001, NULL, 10000, NULL, NULL, 'What is the Capital city of the Republic city of Ireland?', 'Dublin', 'Washington DC', 'Edinburgh', 'London', '2014-05-22 11:50:44', NULL, 30000),
(80588, 20000, NULL, 10002, NULL, NULL, 'In Cricket, what does LBW stand for?', 'Leg Before Wicket', 'Long Boundary Way', 'Lose Both Wickets', 'Loose Bad And Wide', '2014-05-22 11:50:44', NULL, 30000),
(80589, 20006, NULL, 10002, NULL, NULL, 'What was the name of the blind Benedictine monk who allegedly invented Champagne?', 'Dom Perignon', 'Adrian Urmanov', 'Brendan Smyth', 'Losang Samten', '2014-05-22 11:50:44', NULL, 30000),
(80590, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Estonia?', 'Tallinn', 'Brussels', 'The Hague', 'Luxembourg City', '2014-05-22 11:50:44', NULL, 30000),
(80591, 20005, NULL, 10000, NULL, NULL, 'What is the more usual name for Roentgen Rays?', 'X Rays', 'Gamma Rays', 'Ultraviolet Rays', 'Magnetic Resonance', '2014-05-22 11:50:44', NULL, 30000),
(80593, 20000, NULL, 10000, NULL, NULL, 'Who is the youngest winner of a Formula 1 Grand Prix?', 'Sebastian Vettel', 'Lewis Hamilton', 'Michael Schumacher', 'Marcos Senna', '2014-05-22 11:50:44', NULL, 30000),
(80594, 20005, NULL, 10004, NULL, NULL, 'Which is the densest planet in our solar system?', 'The Earth', 'Mercury', 'Venus', 'Mars', '2014-05-22 11:50:44', NULL, 30000),
(80595, 20007, NULL, 10003, NULL, NULL, 'Who was offered but declined the presidency of the State of Israel in 1952?', 'Albert Einstein', 'Marilyn Monroe', 'James Dean', 'Martin Luther King Jr', '2014-05-22 11:50:44', NULL, 30000),
(80596, 20005, NULL, 10000, NULL, NULL, 'What did John Logie Baird invent in 1925?', 'Television', 'Telephone', 'Washing Machine', 'Masking Tape', '2014-05-22 11:50:44', NULL, 30000),
(80598, 20004, NULL, 10001, NULL, NULL, 'When Spaniards first arrived in the Canary Islands they found a native population, what were they called?', 'Guanches', 'Phoenicians', 'Carthaginians', 'Maxos', '2014-05-22 11:50:44', NULL, 30000),
(80599, 20004, NULL, 10002, NULL, NULL, 'What did the 1936 Public Health Act say must be free for men that women could be charged to use?', 'Urinals', 'Contraceptives', 'Public Baths', 'Medical Care', '2014-05-22 11:50:44', NULL, 30000),
(80601, 20003, NULL, 10001, NULL, NULL, 'Where did The Flowerpot Men want to go in 1967?', 'San Francisco', 'New York', 'Woodstock', 'Memphis', '2014-05-22 11:50:44', NULL, 30000),
(80602, 20000, NULL, 10000, NULL, NULL, 'Who bought the Benetton Formula 1 racing team in 2001?', 'Renault', 'Ferrari', 'Aston Martin', 'Mercedes', '2014-05-22 11:50:44', NULL, 30000),
(80603, 20005, NULL, 10003, NULL, NULL, 'What lies above the troposphere?', 'The Stratosphere', 'Space', 'Atmosphere', 'Mesosphere', '2014-05-22 11:50:44', NULL, 30000),
(80604, 20000, NULL, 10004, NULL, NULL, 'The duration of a game of Polo is measured in what?', 'Chukkas', 'Minutes', 'Hours', 'Meters', '2014-05-22 11:50:44', NULL, 30000),
(80605, 20004, NULL, 10003, NULL, NULL, 'Which two countries fought the Pastry War (La guerra de los pasteles) of 1838?', 'Mexico And France', 'Mexico And Portugal', 'France And Portugal', 'Mexico And Spain', '2014-05-22 11:50:44', NULL, 30000),
(80606, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Norway?', 'Oslo', 'Reykjavik', 'Bern', 'Mexico City', '2014-05-22 11:50:44', NULL, 30000),
(80607, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Georgia?', 'Tbilisi', 'Podegrica', 'Yerevan', 'Minsk', '2014-05-22 11:50:44', NULL, 30000),
(80608, 20005, NULL, 10001, NULL, NULL, 'What is -459.7 Fahrenheit also known as?', 'Absolute Zero', 'Above Freezing', 'Room Temperature', 'Minus 10', '2014-05-22 11:50:44', NULL, 30000),
(80609, 20001, NULL, 10003, NULL, NULL, 'What is the Capital of the island of Jersey?', 'St Helier', 'St Peter Port', 'Andorra La Vella', 'Monaco', '2014-05-22 11:50:44', NULL, 30000);
INSERT INTO `B_QUESTION` (`QUESTION_ID`, `CATEGORY_ID`, `SUB_CATEGORY_ID`, `DIFFICULTY_ID`, `LOCATION_ID`, `ERA_ID`, `QUESTION`, `CORRECT_ANSWER`, `WRONG_ANSWER_1`, `WRONG_ANSWER_2`, `WRONG_ANSWER_3`, `QUESTION_CREATED`, `CREATED_BY_USER`, `CREATED_BY_CLIENT`) VALUES
(80610, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Argentina?', 'Buenos Aires', 'Rio De Janeiro', 'Cordoba', 'Montevideo', '2014-05-22 11:50:44', NULL, 30000),
(80611, 20001, NULL, 10003, NULL, NULL, 'What is the Capital of the island of Guernsey?', 'St Peter Port', 'Andorra La Vella', 'Monaco', 'Montevideo', '2014-05-22 11:50:44', NULL, 30000),
(80612, 20005, NULL, 10002, NULL, NULL, 'The word Galaxy comes from the Greek word for what?', 'Milk', 'Chocolate', 'Sky', 'Moon', '2014-05-22 11:50:45', NULL, 30000),
(80613, 20005, NULL, 10001, NULL, NULL, 'What does MG in the car brand stand for?', 'Morris Garages', 'Machine Garages', 'Metro Garage', 'Morris Group', '2014-05-22 11:50:45', NULL, 30000),
(80614, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Greece?', 'Athens', 'Berlin', 'Vienna', 'Moscow', '2014-05-22 11:50:45', NULL, 30000),
(80615, 20005, NULL, 10000, NULL, NULL, 'By what name is Jerrys Guide to the World Wide Web now known?', 'Yahoo', 'Google', 'Ask Jeeves', 'MSN', '2014-05-22 11:50:45', NULL, 30000),
(80616, 20004, NULL, 10002, NULL, NULL, 'Herodotus is known as the father of what?', 'History', 'Medicine', 'Theatre', 'Music', '2014-05-22 11:50:45', NULL, 30000),
(80617, 20005, NULL, 10003, NULL, NULL, 'What does the mp stand for in mp3 players?', 'Moving Picture', 'Music Player', 'Moving Player', 'Music Picture', '2014-05-22 11:50:45', NULL, 30000),
(80618, 20004, NULL, 10001, NULL, NULL, 'Which country has been ruled by the Chakri dynasty since 1782?', 'Thailand', 'Taiwan', 'Cambodia', 'Naha', '2014-05-22 11:50:45', NULL, 30000),
(80619, 20005, NULL, 10002, NULL, NULL, 'On which planet is the tallest mountain in the Solar System?', 'Mars', 'Earth', 'Jupiter', 'Neptune', '2014-05-22 11:50:45', NULL, 30000),
(80620, 20005, NULL, 10001, NULL, NULL, 'Which planet of the solar system has its 27 moons named after characters from the works of William Shakespeare and Alexander Pope?', 'Uranus', 'Jupiter', 'Saturn', 'Neptune', '2014-05-22 11:50:45', NULL, 30000),
(80621, 20005, NULL, 10004, NULL, NULL, 'What sort of substances are adrenaline, cortisone, insulin, and oestrogens?', 'Hormones', 'Amphetamines', 'Barbiturates', 'Nerves', '2014-05-22 11:50:45', NULL, 30000),
(80622, 20000, NULL, 10002, NULL, NULL, 'Which NHL hockey team has won the most Stanley Cups?', 'Montreal Canadiens', 'Boston Bruins', 'Toronto Maple Leafs', 'New York Rangers', '2014-05-22 11:50:45', NULL, 30000),
(80623, 20001, NULL, 10000, NULL, NULL, 'What is the Capital city of Italy?', 'Rome', 'Dublin', 'Washington Dc', 'New York', '2014-05-22 11:50:45', NULL, 30000),
(80625, 20005, NULL, 10000, NULL, NULL, 'Which is the main component of Brass and Bronze?', 'Copper', 'Iron', 'Lead', 'Nickel', '2014-05-22 11:50:45', NULL, 30000),
(80626, 20004, NULL, 10000, NULL, NULL, 'Who succeeded Charles de Gaulle as President of France?', 'Georges Pompidou', 'Rene Coty', 'Valery Giscard Destaing', 'Nicolas Sarkozy', '2014-05-22 11:50:45', NULL, 30000),
(80627, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Finland?', 'Helsinki', 'Stockholm', 'Valetta', 'Nicosia', '2014-05-22 11:50:45', NULL, 30000),
(80628, 20005, NULL, 10002, NULL, NULL, 'Which branch of physics deals with sound?', 'Acoustics', 'Medium', 'Vibration', 'Noise', '2014-05-22 11:50:45', NULL, 30000),
(80629, 20005, NULL, 10001, NULL, NULL, 'How many astronauts crewed the Mercury series of spacecraft?', 'One', 'Two', 'Three', 'None', '2014-05-22 11:50:45', NULL, 30000),
(80630, 20004, NULL, 10002, NULL, NULL, 'Where was the ancient Kingdom of Iberia from where the Iberians in Spain probably came from?', 'Modern Georgia', 'Portugal', 'Greece', 'Norway', '2014-05-22 11:50:45', NULL, 30000),
(80631, 20005, NULL, 10001, NULL, NULL, 'What is the Macintosh computer named after?', 'A Variety Of Apple', 'The Inventor', 'A Famous Scientist', 'Nothing At All', '2014-05-22 11:50:45', NULL, 30000),
(80632, 20005, NULL, 10004, NULL, NULL, 'What do Aspirin, Dry Ice, Kerosene and Linoleum have in common?', 'They Were All Trademarks', 'All Made From Elements', 'Taken From Plants', 'Nothing At All', '2014-05-22 11:50:45', NULL, 30000),
(80633, 20005, NULL, 10002, NULL, NULL, 'What is an eolic power station?', 'Wind Powered', 'Water Powered', 'Light Powered', 'Nuclear Powered', '2014-05-22 11:50:45', NULL, 30000),
(80634, 20005, NULL, 10001, NULL, NULL, 'What is the chemical symbol for Ozone?', 'O3', 'O2', 'O5', 'O1', '2014-05-22 11:50:45', NULL, 30000),
(80635, 20005, NULL, 10001, NULL, NULL, 'Hypermetropic people are what?', 'Far Sighted', 'Underfed', 'Moody', 'Obese', '2014-05-22 11:50:45', NULL, 30000),
(80637, 20005, NULL, 10002, NULL, NULL, 'Which is the largest fish?', 'Whale Shark', 'Basking Shark', 'Great White Shark', 'Ocean Sunfish', '2014-05-22 11:50:45', NULL, 30000),
(80638, 20004, NULL, 10000, NULL, NULL, 'The Poem Defence of Fort McHenry written during the bombing of Baltimore is now much better known by another name?', 'The Star-Spangled Banner', 'Stuka', 'Hibakusha', 'Ode To The Full Moon', '2014-05-22 11:50:45', NULL, 30000),
(80639, 20005, NULL, 10001, NULL, NULL, 'In which US state did the Wright brothers first fly?', 'North Carolina', 'Alabama', 'Montana', 'Ohio', '2014-05-22 11:50:45', NULL, 30000),
(80640, 20005, NULL, 10000, NULL, NULL, 'How much does a cubic metre of water weigh?', 'One Tonne', 'Half A Tonne', 'Three Tonne', 'One Metric Tonne', '2014-05-22 11:50:45', NULL, 30000),
(80641, 20005, NULL, 10002, NULL, NULL, 'Do astronauts have mass in outer space?', 'Yes', 'No', 'Only In The Shuttle', 'Only When Moving', '2014-05-22 11:50:45', NULL, 30000),
(80642, 20000, NULL, 10001, NULL, NULL, 'Sicilian, Ponziani, Russian, Scottish, Nimzo-Indian and Sokolsky are all examples of what kind of movement?', 'Opening Moves In Chess', 'Moves In Curling', 'Moves In Bowls', 'Opening Moves In Tennis', '2014-05-22 11:50:45', NULL, 30000),
(80643, 20004, NULL, 10004, NULL, NULL, 'What was the code name for the American landings in Morocco in 1942?', 'Operation Torch', 'Operation Light', 'Operation Fire', 'Operation Heat', '2014-05-22 11:50:45', NULL, 30000),
(80644, 20005, NULL, 10000, NULL, NULL, 'Which period came after the Triassic?', 'Jurassic', 'Cretaceous', 'Permian', 'Ordovician', '2014-05-22 11:50:45', NULL, 30000),
(80645, 20002, NULL, 10002, NULL, NULL, 'Old Curiosity Shop was written by which author?', 'Charles Dickens', 'Mark Twain', 'Frederick Forsyth', 'Oscar Wilde', '2014-05-22 11:50:45', NULL, 30000),
(80646, 20000, NULL, 10000, NULL, NULL, 'Only one modern Olympic games was not named after the host city - the Interim Olympic Games of 1906. In which city were they held?', 'Athens', 'Paris', 'Berlin', 'Oslo', '2014-05-22 11:50:45', NULL, 30000),
(80647, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Austria?', 'Vienna', 'Moscow', 'Copenhagen', 'Oslo', '2014-05-22 11:50:45', NULL, 30000),
(80648, 20005, NULL, 10001, NULL, NULL, 'Which element, used in electric light filaments and in aviation, has the highest melting point?', 'Tungsten At 3,683K', 'Carbon At 3,823K', 'Rhenium At 3,459K', 'Osmium At 3,306K', '2014-05-22 11:50:45', NULL, 30000),
(80649, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Belgium?', 'Brussels', 'The Hague', 'Luxembourg City', 'Ottawa', '2014-05-22 11:50:45', NULL, 30000),
(80650, 20004, NULL, 10002, NULL, NULL, 'Which two out of the 54 members of the Commonwealth of Nations have no historical connection with the UK?', 'Mozambique And Rwanda', 'Australia And New Zealand', 'Oman And Qatar', 'Pakistan And India', '2014-05-22 11:50:45', NULL, 30000),
(80651, 20000, NULL, 10002, NULL, NULL, 'From which city is the Gimnastic football (soccer) team?', 'Tarragona', 'Salou', 'Reus', 'Palamos', '2014-05-22 11:50:45', NULL, 30000),
(80652, 20005, NULL, 10002, NULL, NULL, 'Which was the first jet airliner to enter commercial service?', 'The Dh Comet', 'The Dh Ghost', 'Vickers VC Viking', 'Pan Am', '2014-05-22 11:50:45', NULL, 30000),
(80653, 20000, NULL, 10000, NULL, NULL, 'Envelope, basket and burner are the three main parts of what?', 'Hot Air Balloon', 'Kayak', 'Cycling', 'Paper', '2014-05-22 11:50:45', NULL, 30000),
(80654, 20000, NULL, 10004, NULL, NULL, 'Vijay Singh, US Masters champion, comes from where?', 'Fiji', 'China', 'Japan', 'Papua New Guinea', '2014-05-22 11:50:45', NULL, 30000),
(80655, 20001, NULL, 10000, NULL, NULL, 'The Eiffel Tower is located where in Paris?', 'Champ De Mars', 'Bois De Boulogne', 'Jardin Des Plantes', 'Parc De Belleville', '2014-05-22 11:50:45', NULL, 30000),
(80657, 20005, NULL, 10000, NULL, NULL, 'Who invented the Centigrade scale?', 'Anders Celsius', 'Soren Sorenson', 'Richard Salter', 'Phillip Mattha', '2014-05-22 11:50:45', NULL, 30000),
(80658, 20005, NULL, 10004, NULL, NULL, 'What is the female term equivalent to a phallic symbol?', 'A Yonic Symbol', 'Tick Symbol', 'Chai Symbol', 'Pictographic Symbol', '2014-05-22 11:50:45', NULL, 30000),
(80660, 20000, NULL, 10004, NULL, NULL, 'Which sport was founded by Japanese master Kano Jigoro?', 'Judo', 'Karate', 'Taekwondo', 'Ping Pong', '2014-05-22 11:50:45', NULL, 30000),
(80662, 20005, NULL, 10002, NULL, NULL, 'Litmus paper turns what colour when in contact with an acid?', 'Red', 'Blue', 'Green', 'Pink', '2014-05-22 11:50:45', NULL, 30000),
(80663, 20005, NULL, 10003, NULL, NULL, 'Strange, charm, up, down, top, and bottom are types of what?', 'Quarks', 'People', 'Pictures', 'Planets', '2014-05-22 11:50:45', NULL, 30000),
(80664, 20000, NULL, 10004, NULL, NULL, 'With which game would you associate the names of Mikhail Botvinnik, Alexander Alekhine, and Jose Capablanca?', 'Chess', 'Dominoes', 'Snooker', 'Poker', '2014-05-22 11:50:45', NULL, 30000),
(80665, 20005, NULL, 10003, NULL, NULL, 'Which is the main protein in milk?', 'Casein', 'Histones', 'Whey', 'Potassium', '2014-05-22 11:50:45', NULL, 30000),
(80666, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Croatia?', 'Zagreb', 'Belgrade', 'Sarajevo', 'Prague', '2014-05-22 11:50:45', NULL, 30000),
(80667, 20005, NULL, 10002, NULL, NULL, 'What in meteorology is measured in Oktas?', 'Cloud Cover', 'Air Temperature', 'Solar Radiation', 'Precipitation', '2014-05-22 11:50:45', NULL, 30000),
(80669, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Liechtenstein?', 'Vaduz', 'St Anne', 'Tirana', 'Prishtina', '2014-05-22 11:50:45', NULL, 30000),
(80670, 20000, NULL, 10003, NULL, NULL, 'Who is the Greek goddess of Victory?', 'Nike', 'Adidas', 'Reebok', 'Puma', '2014-05-22 11:50:45', NULL, 30000),
(80671, 20005, NULL, 10000, NULL, NULL, 'What is the name given to rain with a particularly low pH?', 'Acid Rain', 'Acidic Lake', 'Clean Rain', 'Pure Rain Water', '2014-05-22 11:50:45', NULL, 30000),
(80672, 20005, NULL, 10001, NULL, NULL, 'Which computer operating system has a penguin as its logo?', 'Linux', 'Android', 'BBSD', 'QNX', '2014-05-22 11:50:45', NULL, 30000),
(80673, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Peru?', 'Lima', 'Cordoba', 'Caracas', 'Quito', '2014-05-22 11:50:45', NULL, 30000),
(80674, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Venezuela?', 'Caracas', 'Cordoba', 'Lima', 'Quito', '2014-05-22 11:50:45', NULL, 30000),
(80675, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Chile?', 'Santiago', 'Caracas', 'Lima', 'Quito', '2014-05-22 11:50:45', NULL, 30000),
(80676, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Andorra?', 'Andorra La Vella', 'Monaco', 'Montevideo', 'Quito', '2014-05-22 11:50:45', NULL, 30000),
(80678, 20005, NULL, 10003, NULL, NULL, 'What is the SI unit of temperature?', 'The Kelvin', 'Celsius', 'Fahrenheit', 'Rankine', '2014-05-22 11:50:45', NULL, 30000),
(80679, 20005, NULL, 10001, NULL, NULL, 'What is Opera associated with in Information Technology?', 'A Web Browser', 'Control Panel', 'Documents', 'Recycling Bin', '2014-05-22 11:50:45', NULL, 30000),
(80680, 20005, NULL, 10001, NULL, NULL, 'On the moon, what colour is the sky?', 'Black', 'Blue', 'White', 'Red', '2014-05-22 11:50:45', NULL, 30000),
(80681, 20001, NULL, 10001, NULL, NULL, 'What two colours are in the Greek flag?', 'Blue And White', 'Red And Black', 'Red And White', 'Red And Blue', '2014-05-22 11:50:45', NULL, 30000),
(80682, 20005, NULL, 10001, NULL, NULL, 'What does a circle with a cross through it mean on a clothing label?', 'Do Not Dry Clean', 'Do Not Use', 'Dry Clean In Any Solvent', 'Reduce Cycle', '2014-05-22 11:50:45', NULL, 30000),
(80683, 20005, NULL, 10004, NULL, NULL, 'Who or what is ataxia?', 'Loss Of Muscle Control', 'Greek God', 'Facial Acne', 'Religious Leader Of Peace', '2014-05-22 11:50:45', NULL, 30000),
(80684, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Russia?', 'Moscow', 'Copenhagen', 'Oslo', 'Reykjavik', '2014-05-22 11:50:45', NULL, 30000),
(80685, 20000, NULL, 10001, NULL, NULL, 'In American Football, where would you find the Orange Bowl?', 'Miami', 'Tampa', 'Jacksonville', 'Richmond', '2014-05-22 11:50:45', NULL, 30000),
(80686, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of pre-unified West Germany?', 'Bonn', 'Bratislava', 'Vilnius', 'Riga', '2014-05-22 11:50:45', NULL, 30000),
(80687, 20004, NULL, 10004, NULL, NULL, 'Who was the founder of Lotus Cars Ltd?', 'Colin Chapman', 'Henry Ford', 'Ferdinand Porsche', 'Robert Bamford', '2014-05-22 11:50:45', NULL, 30000),
(80688, 20000, NULL, 10004, NULL, NULL, 'Who is the only Irish cyclist to win the Tour de France?', 'Stephen Roche', 'Sean Kelly', 'Nicolas Roche', 'Robin Seymour', '2014-05-22 11:50:45', NULL, 30000),
(80689, 20005, NULL, 10004, NULL, NULL, 'What is the name of the type of self-contained cable railway in which a cable attached to a pair of tram-like vehicles on rails moves them up and down a very steep slope, the ascending and descending vehicles counterbalancing each other?', 'Funicular', 'Multiple Unit', 'Freight Train', 'Rolling Stock', '2014-05-22 11:50:45', NULL, 30000),
(80690, 20004, NULL, 10003, NULL, NULL, 'Which US President gave a plastic bust of himself as a Christmas gift to Pope Paul VI?', 'Lyndon B Johnson', 'Richard Nixon', 'Jimmy Carter', 'Ronald Regan', '2014-05-22 11:50:45', NULL, 30000),
(80691, 20004, NULL, 10002, NULL, NULL, 'Who was the American President at the start of the Vietnam war?', 'John F Kennedy', 'Eisenhower', 'Richard Nixon', 'Ronald Regan', '2014-05-22 11:50:45', NULL, 30000),
(80692, 20000, NULL, 10003, NULL, NULL, 'In which alpine resort were the first ever Winter Olympics held in 1924?', 'Chamonix', 'Squaw Valley', 'Alpine Valley', 'Rosa Khutor', '2014-05-22 11:50:45', NULL, 30000),
(80693, 20000, NULL, 10004, NULL, NULL, 'Which former Olympic sport required the athletes to move backwards to win?', 'Tug Of War', 'Backstroke', 'High Jump', 'Rowing', '2014-05-22 11:50:45', NULL, 30000),
(80694, 20000, NULL, 10002, NULL, NULL, 'The Vince Lombardi Trophy is awarded at which event?', 'The Superbowl', 'The World Cup', 'Barclays Premier League', 'Rugby World Cup', '2014-05-22 11:50:45', NULL, 30000),
(80695, 20001, NULL, 10003, NULL, NULL, 'The reactor at the site of the Chernobyl nuclear disaster is now in which country?', 'Ukraine', 'Slovakia', 'Hungary', 'Russia', '2014-05-22 11:50:45', NULL, 30000),
(80696, 20005, NULL, 10004, NULL, NULL, 'Which element has the chemical symbol Rf?', 'Rutherfordium', 'Radon', 'Roentgenium', 'Ruthenium', '2014-05-22 11:50:45', NULL, 30000),
(80697, 20004, NULL, 10002, NULL, NULL, 'Which Irish saint supposedly sailed to America in the sixth century?', 'Saint Brendan', 'Saint Adrian', 'Saint Francis', 'Saint Patrick', '2014-05-22 11:50:45', NULL, 30000),
(80698, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Paraguay?', 'Asuncan', 'Caracas', 'Santiago', 'San Juan', '2014-05-22 11:50:45', NULL, 30000),
(80699, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Bolivia?', 'La Paz', 'Bogota', 'Santiago', 'San Juan', '2014-05-22 11:50:45', NULL, 30000),
(80700, 20007, NULL, 10004, NULL, NULL, 'Karol Wojtyla is better known under which name?', 'Pope John Paul II', 'Liberace', 'Carole King', 'Santa', '2014-05-22 11:50:45', NULL, 30000),
(80701, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Ecuador?', 'Quito', 'Cordoba', 'Lima', 'Santiago', '2014-05-22 11:50:45', NULL, 30000),
(80702, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Monaco?', 'Monaco', 'Montevideo', 'Quito', 'Santiago', '2014-05-22 11:50:45', NULL, 30000),
(80703, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Slovenia?', 'Ljubljana', 'Zagreb', 'Belgrade', 'Sarajevo', '2014-05-22 11:50:45', NULL, 30000),
(80704, 20005, NULL, 10000, NULL, NULL, 'What lies between Mars and Jupiter?', 'The Asteroid Belt', 'Simply Space', 'Ceres', 'Saturn', '2014-05-22 11:50:45', NULL, 30000),
(80705, 20005, NULL, 10004, NULL, NULL, 'Which planet in our solar system has an orbital period of 687 days?', 'Mars', 'Venus', 'Mercury', 'Saturn', '2014-05-22 11:50:45', NULL, 30000),
(80706, 20005, NULL, 10002, NULL, NULL, 'What does the distress signal SOS stand for?', 'Nothing', 'Save Our Souls', 'Save Our Skin', 'Save Our Ship', '2014-05-22 11:50:45', NULL, 30000),
(80707, 20000, NULL, 10001, NULL, NULL, 'When New Zealand won the inaugural Rugby World Cup in 1987, who did they defeat?', 'France', 'England', 'Australia', 'Scotland', '2014-05-22 11:50:45', NULL, 30000),
(80708, 20000, NULL, 10001, NULL, NULL, 'Which team defeated the world champions Argentina in the opening game of 1990 World Championship?', 'Cameroon', 'West Germany', 'Brazil', 'Scotland', '2014-05-22 11:50:45', NULL, 30000),
(80709, 20004, NULL, 10004, NULL, NULL, 'Christopher Columbus died on May 20, 1506 in which Spanish city?', 'Valladolid', 'Bilbao', 'Madrid', 'Seville', '2014-05-22 11:50:45', NULL, 30000),
(80710, 20004, NULL, 10002, NULL, NULL, 'What was found under the patio of 10 Brookside Close?', 'Trevor Jordaches Body', 'Roman Artefacts', 'First Edition Beano Comic', 'Shergar', '2014-05-22 11:50:45', NULL, 30000),
(80711, 20004, NULL, 10004, NULL, NULL, 'Before the Euro, the Irish Punt was divided into 100 what?', 'Pence', 'Cents', 'Pounds', 'Shillings', '2014-05-22 11:50:45', NULL, 30000),
(80712, 20005, NULL, 10004, NULL, NULL, 'The first nuclear powered ship was designed for what purpose?', 'Icebreaking', 'War', 'Fishing', 'Shipping', '2014-05-22 11:50:45', NULL, 30000),
(80713, 20000, NULL, 10004, NULL, NULL, 'Which event from the 2012 Summer Olympics was held at Lords Cricket Ground?', 'Archery', 'Fencing', 'Handball', 'Shooting', '2014-05-22 11:50:45', NULL, 30000),
(80714, 20003, NULL, 10000, NULL, NULL, 'Festfolk was the original name for whichÂ group?', 'Abba', 'The Beach Boys', 'Motorhead', 'Simon And Garfunkel', '2014-05-22 11:50:45', NULL, 30000),
(80715, 20005, NULL, 10000, NULL, NULL, 'In photography, what does SLR stand for?', 'Single Lens Reflex', 'Several Lens Reflex', 'Subtly Low Reflex', 'Single Low Reflex', '2014-05-22 11:50:45', NULL, 30000),
(80716, 20005, NULL, 10004, NULL, NULL, 'Which Admiral has a wind speed scale named after him?', 'Sir Francis Beaufort', 'Yi Sun Shin', 'David Glasgow Farragut', 'Sir John Kelly', '2014-05-22 11:50:45', NULL, 30000),
(80717, 20005, NULL, 10001, NULL, NULL, 'Who won the 1954 Nobel Prize for Chemistry and the 1962 Nobel Peace Prize?', 'Linus Pauling', 'Patrick Maynard', 'Thomas Stearns Elliot', 'Sir Robert Robinson', '2014-05-22 11:50:45', NULL, 30000),
(80718, 20000, NULL, 10003, NULL, NULL, 'How many rounds are there in an Olympic boxing match?', 'Four', 'Twelve', 'Seven', 'Six', '2014-05-22 11:50:45', NULL, 30000),
(80719, 20004, NULL, 10001, NULL, NULL, 'The Penny Black was the first modern postage stamp in the world but the Penny Red was the first to have what?', 'Perforations', 'Dates', 'Pictures', 'Size Difference', '2014-05-22 11:50:45', NULL, 30000),
(80720, 20005, NULL, 10003, NULL, NULL, 'In which organ would you find the pineal gland?', 'The Brain', 'Liver', 'The Bladder', 'Skin', '2014-05-22 11:50:45', NULL, 30000),
(80721, 20005, NULL, 10004, NULL, NULL, 'WhichÂ kind of animalÂ did Florence Nightingale often carryÂ around in her pocket?', 'Owl', 'Puppy', 'Kitten', 'Snake', '2014-05-22 11:50:45', NULL, 30000),
(80722, 20005, NULL, 10004, NULL, NULL, 'Hydrated magnesium silicate is found in most bathrooms. By what name is it better known?', 'Talc Or Talcum Powder', 'Shampoo', 'Deodorant', 'Soap', '2014-05-22 11:50:45', NULL, 30000),
(80723, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Latvia?', 'Riga', 'Kiev', 'Bucharest', 'Sofia', '2014-05-22 11:50:45', NULL, 30000),
(80724, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Azerbaijan?', 'Baku', 'Tel Aviv', 'Tashkent', 'Sofia', '2014-05-22 11:50:45', NULL, 30000),
(80725, 20000, NULL, 10002, NULL, NULL, 'Countries from which continent boycotted the 1976 summer Olympics in Montreal?', 'Africa', 'Europe', 'Asia', 'South America', '2014-05-22 11:50:45', NULL, 30000),
(80726, 20004, NULL, 10001, NULL, NULL, 'In which war in the second half of the twentieth century did the Free World Military Forces take part?', 'The Vietnam War', 'Revolutionary War', 'Chinese Civil War', 'Spanish Civil War', '2014-05-22 11:50:45', NULL, 30000),
(80727, 20005, NULL, 10002, NULL, NULL, 'Anemophobia is the fear of what?', 'Wind', 'The Dark', 'Fire', 'Spiders', '2014-05-22 11:50:45', NULL, 30000),
(80728, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Armenia?', 'Yerevan', 'Minsk', 'Vaduz', 'St Anne', '2014-05-22 11:50:45', NULL, 30000),
(80729, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Sweden?', 'Stockholm', 'Valletta', 'Nicosia', 'St Helier', '2014-05-22 11:50:45', NULL, 30000),
(80730, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Malta?', 'Valletta', 'Nicosia', 'St Helier', 'St Peter Port', '2014-05-22 11:50:45', NULL, 30000),
(80731, 20005, NULL, 10004, NULL, NULL, 'Who wrote The Road Ahead about the future of personal computing in 1995 and got it so wrong he had to rewrite large parts of it the following year?', 'Bill Gates', 'Gary Kildall', 'Adam Osborne', 'Steve Wozniak', '2014-05-22 11:50:45', NULL, 30000),
(80732, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Romania?', 'Bucharest', 'Sofia', 'Helsinki', 'Stockholm', '2014-05-22 11:50:45', NULL, 30000),
(80733, 20005, NULL, 10004, NULL, NULL, 'Where in the human body do you find aqueous humour?', 'Eye', 'Elbow', 'Leg', 'Stomach', '2014-05-22 11:50:45', NULL, 30000),
(80734, 20005, NULL, 10001, NULL, NULL, 'Which is the largest gland in the human body?', 'Liver', 'Lacrimal', 'Tongue', 'Stomach', '2014-05-22 11:50:45', NULL, 30000),
(80735, 20000, NULL, 10000, NULL, NULL, 'In which Olympic sport do players slide stones to houses?', 'Curling', 'Shot Putt', 'Croquet', 'Stone Bench', '2014-05-22 11:50:45', NULL, 30000),
(80736, 20000, NULL, 10001, NULL, NULL, 'The streets of Atlantic City, New Jersey, were used in the original version of what?', 'Monopoly Game', 'The Olympic Games', 'As Superbowl Hosts', 'Street Football', '2014-05-22 11:50:45', NULL, 30000),
(80737, 20005, NULL, 10004, NULL, NULL, 'Which sugar makes up nearly 8% of milk and is also known as milk sugar?', 'Lactose', 'Fructose', 'Glucose', 'Sucrose', '2014-05-22 11:50:45', NULL, 30000),
(80738, 20001, NULL, 10002, NULL, NULL, 'Which country boasts most of the Kalahari desert?', 'Botswana', 'South Africa', 'Zimbabwe', 'Sudan', '2014-05-22 11:50:45', NULL, 30000),
(80739, 20005, NULL, 10003, NULL, NULL, 'What is the more common name for dead keratinised cells which appear in the epidermis of mammals?', 'Hair', 'Dandruff', 'Freckles', 'Sun Tan', '2014-05-22 11:50:45', NULL, 30000),
(80740, 20005, NULL, 10002, NULL, NULL, 'The nearest spiral galaxy to this quiz is named Messier 31, M31, or NGC 224, but is more commonly called what?', 'Andromeda Galaxy', 'Bodes Galaxy', 'Triangulum Galaxy', 'Sunflower Galaxy', '2014-05-22 11:50:45', NULL, 30000),
(80741, 20005, NULL, 10003, NULL, NULL, 'The ABO grouping classifies what?', 'Blood Groups', 'Television Companies', 'Religious Groups', 'Support Group', '2014-05-22 11:50:45', NULL, 30000),
(80742, 20005, NULL, 10002, NULL, NULL, 'The Indian-Pacific train links the two oceans. Between which two cities does it run?', 'Perth And Sydney', 'Cairns And Melbourne', 'Perth And Brisbane', 'Sydney And Darwin', '2014-05-22 11:50:45', NULL, 30000),
(80743, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Bosnia & Herzegovina?', 'Sarajevo', 'Prague', 'Warsaw', 'Tallinn', '2014-05-22 11:50:45', NULL, 30000),
(80744, 20005, NULL, 10002, NULL, NULL, 'Which of these senses deteriorates first with age?', 'Smell', 'Sight', 'Hearing', 'Taste', '2014-05-22 11:50:45', NULL, 30000),
(80745, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Kosovo?', 'Prishtina', 'Chisinau', 'Zagreb', 'Tbilisi', '2014-05-22 11:50:45', NULL, 30000),
(80746, 20005, NULL, 10001, NULL, NULL, 'In Roman numerals, what is the letter M with a bar over it?', 'One Million', 'One Thousand', 'One Hundred Thousand', 'Ten Thousand', '2014-05-22 11:50:45', NULL, 30000),
(80747, 20000, NULL, 10001, NULL, NULL, 'In which sport do you have a short stop and you can have a pinch hitter, a long reliever or a closer?', 'Baseball', 'Fishing', 'Karate', 'Tennis', '2014-05-22 11:50:45', NULL, 30000),
(80748, 20007, NULL, 10000, NULL, NULL, 'Anna Pavlowa excelled in which of the following?', 'Ballet', 'Chess', 'Painting', 'Tennis', '2014-05-22 11:50:45', NULL, 30000),
(80749, 20000, NULL, 10001, NULL, NULL, 'Which Olympic sport has a playing area that is 9ft (2.74m) by 5ft (1.525m)?', 'Table Tennis', 'Archery', 'Snooker Or Pool', 'Tennis', '2014-05-22 11:50:45', NULL, 30000),
(80750, 20006, NULL, 10001, NULL, NULL, 'What is the main spirit base of a classic Bloody Mary?', 'Vodka', 'Whiskey', 'Brandy', 'Tequila', '2014-05-22 11:50:45', NULL, 30000),
(80751, 20001, NULL, 10002, NULL, NULL, 'Which city became the capital of the USA in 1788?', 'New York', 'California', 'Utah', 'Texas', '2014-05-22 11:50:45', NULL, 30000),
(80752, 20004, NULL, 10001, NULL, NULL, 'During which battle did the charge of the Light Brigade take place?', 'The Battle Of Balaclava', 'The Battle Of Bilbao', 'The Battle Of Bailen', 'The Battle Of Brescia', '2014-05-22 11:50:45', NULL, 30000),
(80753, 20004, NULL, 10001, NULL, NULL, 'Which was the most important battle fought by the Lincoln Brigade in the Spanish Civil War?', 'The Battle Of Jarama', 'The Battle Of Bilbao', 'The Battle Of Caspe', 'The Battle Of Majorca', '2014-05-22 11:50:45', NULL, 30000),
(80754, 20005, NULL, 10002, NULL, NULL, 'Which is the largest organ in the human body?', 'The Skin', 'The Large Intestine', 'The Stomach', 'The Brain', '2014-05-22 11:50:45', NULL, 30000),
(80755, 20005, NULL, 10001, NULL, NULL, 'What is decompression sickness commonly known as?', 'The Bends', 'The Bug', 'The Bag', 'The Bulge', '2014-05-22 11:50:45', NULL, 30000),
(80756, 20004, NULL, 10000, NULL, NULL, 'What was the name of the cult that Charles Manson led which killed at least seven people?', 'The Family', 'The Cousins', 'The Relatives', 'The Couple', '2014-05-22 11:50:45', NULL, 30000),
(80759, 20004, NULL, 10002, NULL, NULL, 'What did members of the Nazi SS have tattooed on their armpits?', 'Their Blood Group', 'Swastika', 'Lightning Bolts', 'The Eagle', '2014-05-22 11:50:45', NULL, 30000),
(80760, 20004, NULL, 10001, NULL, NULL, 'Which agreement resulted in the splitting of Germany?', 'The Yalta Agreement', 'The Schengen Agreement', 'The Munich Agreement', 'The Felt Agreement', '2014-05-22 11:50:45', NULL, 30000),
(80761, 20005, NULL, 10000, NULL, NULL, 'What are the largest and smallest bones in the human body?', 'The Femur And The Stirrup', 'The Tibia And Carpal', 'The Fibula And Tarsal', 'The Fibula And Carpal', '2014-05-22 11:50:45', NULL, 30000),
(80762, 20000, NULL, 10001, NULL, NULL, 'The Web Ellis Cup is given to the winners of which tournament?', 'The Rugby World Cup', 'Formula 1', 'The Ryder Cup', 'The Football World Cup', '2014-05-22 11:50:45', NULL, 30000),
(80764, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Poland?', 'Warsaw', 'Tallinn', 'Brussels', 'The Hague', '2014-05-22 11:50:45', NULL, 30000),
(80765, 20002, NULL, 10004, NULL, NULL, 'What was the name of the 2002 Man Booker prize winning Book by Yann Martel?', 'Life Of Pi', 'The English Patient', 'The Cat In The Hat', 'The Line Of Beauty', '2014-05-22 11:50:45', NULL, 30000),
(80766, 20005, NULL, 10004, NULL, NULL, 'What part of the body is affected by Otitis?', 'The Ear', 'The Eye', 'The Brain', 'The Liver', '2014-05-22 11:50:45', NULL, 30000),
(80768, 20000, NULL, 10000, NULL, NULL, 'Which race over 200 laps is started with the words, Ladies and gentlemen, start your engines?', 'The Indianapolis 500', 'The Little 500', 'Hoosier Hundred', 'The Night Before', '2014-05-22 11:50:45', NULL, 30000),
(80770, 20000, NULL, 10004, NULL, NULL, 'What is the second largest multi-sport gathering after the Olympics?', 'The Commonwealth Games', 'The Pan American Games', 'Mediterranean Games', 'The Paralympic Games', '2014-05-22 11:50:45', NULL, 30000),
(80771, 20000, NULL, 10001, NULL, NULL, 'In Judo, what is a judogi?', 'The Traditional Uniform', 'A Kick', 'A Punch', 'The Referee', '2014-05-22 11:50:45', NULL, 30000),
(80772, 20004, NULL, 10004, NULL, NULL, 'Who was the principle enemy to Athens in the Peloponnesian War?', 'Sparta', 'Macedonia', 'The French', 'The Romans', '2014-05-22 11:50:45', NULL, 30000),
(80773, 20000, NULL, 10000, NULL, NULL, 'What is the longest distance race in Olympic athletics?', 'Chamonix', 'Vancouver Sun Run', 'Bay To Breakers', 'The Self Transcendence', '2014-05-22 11:50:45', NULL, 30000),
(80775, 20006, NULL, 10002, NULL, NULL, 'Angostura Bitters is produced from what?', 'Tree Bark', 'Watermelon', 'Orange Peel', 'The Stamens Of A Crocus', '2014-05-22 11:50:45', NULL, 30000),
(80776, 20005, NULL, 10002, NULL, NULL, 'What is thanatosis?', 'Playing Dead', 'A Disease Of The Liver', 'Memory Loss', 'The Study Of Animals', '2014-05-22 11:50:45', NULL, 30000),
(80777, 20004, NULL, 10003, NULL, NULL, 'The Nazi regime was the III Reich. Which was the first?', 'The Holy Roman Empire', 'The German Empire', 'The German Reich', 'The Tudors', '2014-05-22 11:50:45', NULL, 30000),
(80780, 20005, NULL, 10002, NULL, NULL, 'Parkesine and Bakelite were two early examples of what?', 'Synthetic Plastic', 'Paracetamol', 'Polystyrene', 'Thermometal', '2014-05-22 11:50:45', NULL, 30000),
(80781, 20000, NULL, 10003, NULL, NULL, 'Who scored the winning goal in the 1995 FA Cup final?', 'Paul Rideout', 'Eric Cantona', 'Duncan Ferguson', 'Thierry Henri', '2014-05-22 11:50:45', NULL, 30000),
(80782, 20005, NULL, 10000, NULL, NULL, 'What does 3G mean in the mobile phone ads?', 'Third Generation', 'Three Gigabytes', 'Three Generation', 'Third Gigabytes', '2014-05-22 11:50:45', NULL, 30000),
(80783, 20005, NULL, 10000, NULL, NULL, 'What is the laryngeal prominence formed by the angle of the thyroid cartilage surrounding the larynx commonly called?', 'Adams Apple', 'Funny Bone', 'Knee Cap', 'Thumb', '2014-05-22 11:50:45', NULL, 30000),
(80784, 20000, NULL, 10002, NULL, NULL, 'The first long distance car race was held in 1907 and finished after nearly 10,000 miles in Paris. The winners were Prince Scipione Borghese and journalist Luigi Barzini, Sr. who claimed the prize of a bottle of Mumm champagne. Where did the race start?', 'Beijing', 'Shanghai', 'Bangkok', 'Tibet', '2014-05-22 11:50:45', NULL, 30000),
(80785, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Belarus?', 'Minsk', 'Vaduz', 'St Anne', 'Tirana', '2014-05-22 11:50:45', NULL, 30000),
(80786, 20005, NULL, 10002, NULL, NULL, 'What is the name given to nitro-glycerine after it has been mixed with sawdust or clay (diatomaceous earth) to stabilise it?', 'Dynamite', 'Gunpowder', 'Glyceryl Trinitrate', 'TNT', '2014-05-22 11:50:45', NULL, 30000),
(80788, 20004, NULL, 10002, NULL, NULL, 'To which city was Tsar Nicholas II and his family taken to and executed in after the Russian Revolution?', 'Yekaterinburg', 'Chelyabinsk', 'Omsk', 'Tolyatti', '2014-05-22 11:50:45', NULL, 30000),
(80789, 20000, NULL, 10003, NULL, NULL, 'Who irritated Hitler by winning four gold medals in the Olympics?', 'Jesse Owens', 'Helene Mayer', 'Halet Cambel', 'Toni Merkens', '2014-05-22 11:50:45', NULL, 30000),
(80790, 20005, NULL, 10003, NULL, NULL, 'On the Mohs scale of hardness, what is the second hardest mineral, after diamond?', 'Corundum', 'Chromium', 'Titanium', 'Topaz', '2014-05-22 11:50:45', NULL, 30000),
(80791, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Canada?', 'Ottawa', 'Montreal', 'Calgary', 'Toronto', '2014-05-22 11:50:45', NULL, 30000),
(80792, 20005, NULL, 10004, NULL, NULL, 'The elements Palladium, Cerium, Uranium, Neptunium, Plutonium are all named after what?', 'Planets', 'Scientists', 'Their Greek Translation', 'Towns And Cities', '2014-05-22 11:50:45', NULL, 30000),
(80794, 20005, NULL, 10002, NULL, NULL, 'What is the name of the mascot on the bonnet of a Rolls Royce?', 'The Spirit Of Ecstacy', 'Archer', 'Chief Pontiac', 'Trishields', '2014-05-22 11:50:45', NULL, 30000),
(80795, 20001, NULL, 10004, NULL, NULL, 'The crown of which New York City landmark was originally built as an airship dock?', 'Empire State Building', 'Chrysler Building', 'Statue Of Liberty', 'Trump Tower', '2014-05-22 11:50:45', NULL, 30000),
(80796, 20005, NULL, 10003, NULL, NULL, 'What shape is the DNA molecule?', 'A Double Helix', 'A Single Helix', 'A Triple Helix', 'Twin Helix', '2014-05-22 11:50:45', NULL, 30000),
(80797, 20005, NULL, 10002, NULL, NULL, 'In radio and television, among other things, what does UHF stand for?', 'Ultra High Frequency', 'Under High Frequency', 'Up High Frequency', 'Ultimate Higher Frequency', '2014-05-22 11:50:45', NULL, 30000),
(80799, 20005, NULL, 10003, NULL, NULL, 'Which chemical element gets its name from a Greek word meaning stranger?', 'Xenon', 'Barium', 'Krypton', 'Uranium', '2014-05-22 11:50:45', NULL, 30000),
(80800, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Montenegro?', 'Podegrica', 'Yerevan', 'Minsk', 'Vaduz', '2014-05-22 11:50:45', NULL, 30000),
(80801, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Moldova?', 'Chisinau', 'Tirana', 'Oslo', 'Valletta', '2014-05-22 11:50:45', NULL, 30000),
(80802, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Bulgaria?', 'Sofia', 'Helsinki', 'Stockholm', 'Valletta', '2014-05-22 11:50:45', NULL, 30000),
(80803, 20005, NULL, 10000, NULL, NULL, 'What is the more common name for Ethylene Glycol?', 'Antifreeze', 'Window Washer', 'Bleach', 'Vegetable Oil', '2014-05-22 11:50:45', NULL, 30000),
(80804, 20005, NULL, 10000, NULL, NULL, 'Which planet has the Great Red Spot in its atmosphere?', 'Jupiter', 'Saturn', 'Mars', 'Venus', '2014-05-22 11:50:45', NULL, 30000),
(80805, 20005, NULL, 10001, NULL, NULL, 'Which is the tenth largest body orbiting the sun?', 'Pluto', 'Mercury', 'Mars', 'Venus', '2014-05-22 11:50:45', NULL, 30000),
(80806, 20005, NULL, 10002, NULL, NULL, 'Which two planets do not have moons?', 'Mercury And Venus', 'Earth And Mars', 'Mars And Mercury', 'Venus And Saturn', '2014-05-22 11:50:45', NULL, 30000),
(80809, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Portugal?', 'Lisbon', 'Athens', 'Berlin', 'Vienna', '2014-05-22 11:50:45', NULL, 30000),
(80810, 20005, NULL, 10001, NULL, NULL, 'Which vitamin is thiamine?', 'Vitamin B1', 'Vitamin K', 'Vitamin B12', 'Vitamin B4', '2014-05-22 11:50:45', NULL, 30000),
(80812, 20007, NULL, 10003, NULL, NULL, 'Who was the first Prime Minister of the Soviet Union?', 'Vladimir Lenin', 'Boris Yeltsin', 'Joseph Stalin', 'Vyacheslav Molotov', '2014-05-22 11:50:45', NULL, 30000),
(80813, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Serbia?', 'Belgrade', 'Sarajevo', 'Prague', 'Warsaw', '2014-05-22 11:50:45', NULL, 30000),
(80815, 20000, NULL, 10002, NULL, NULL, 'In which sport would you perform an Eskimo roll?', 'Kayaking', 'Skiing', 'Snowboarding', 'Water Polo', '2014-05-22 11:50:45', NULL, 30000),
(80816, 20000, NULL, 10004, NULL, NULL, 'Which NBA player, son of an NBA player, was named after a steak his parents saw on a restaurant menu just before he was born?', 'Kobe Bryant', 'Dell Curry', 'Glen Rice', 'Wes Matthews', '2014-05-22 11:50:45', NULL, 30000),
(80817, 20005, NULL, 10002, NULL, NULL, 'Where is the hypocentre of an earthquake in relation to its epicentre?', 'Directly Beneath It', 'Opposite It', 'Directly Above It', 'Where It Starts', '2014-05-22 11:50:45', NULL, 30000),
(80818, 20004, NULL, 10001, NULL, NULL, 'Who was the first President of the United States whose father was also President of the United States?', 'John Quincy Adams', 'George W Bush', 'John F Kennedy', 'William Henry Harrison', '2014-05-22 11:50:45', NULL, 30000),
(80819, 20007, NULL, 10003, NULL, NULL, 'Who was the last British Prime Minister not to have a wife?', 'Margaret Thatcher', 'John Major', 'Harold Wilson', 'Winston Churchill', '2014-05-22 11:50:45', NULL, 30000),
(80821, 20005, NULL, 10000, NULL, NULL, 'Which is the only insect that can turn its head to look directly behind itself?', 'The Praying Mantis', 'Common Fly', 'Bumble Bees', 'Wood Ants', '2014-05-22 11:50:45', NULL, 30000),
(80822, 20004, NULL, 10004, NULL, NULL, 'In which war did the Battle of Hamburger Hill take place?', 'The Vietnam War', 'The Spanish Civil War', 'The Gulf War', 'World War 1', '2014-05-22 11:50:45', NULL, 30000),
(80823, 20005, NULL, 10004, NULL, NULL, 'What is a John Dory?', 'A Fish', 'A Politician', 'A Sword', 'World War II Tank', '2014-05-22 11:50:45', NULL, 30000),
(80824, 20005, NULL, 10000, NULL, NULL, 'What was the Wright Brothers first successful aeroplane called?', 'Flyer', 'Glider', 'Model A', 'Wright Type-A', '2014-05-22 11:50:45', NULL, 30000),
(80825, 20005, NULL, 10004, NULL, NULL, 'Which is the last chemical element (in alphabetical order)?', 'Zirconium', 'Zinc', 'Yttrium', 'Xenon', '2014-05-22 11:50:45', NULL, 30000),
(80826, 20000, NULL, 10003, NULL, NULL, 'Who was the first gymnast to score a maximum 10 points (seven 10s) in the Olympics?', 'Nadia Comaneci', 'Mary Lou Retton', 'Daniela Silivas', 'Yang Tae-Young', '2014-05-22 11:50:45', NULL, 30000),
(80827, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Macedonia?', 'Skopje', 'Tbilisi', 'Podegrica', 'Yerevan', '2014-05-22 11:50:45', NULL, 30000),
(80828, 20000, NULL, 10003, NULL, NULL, 'One Soviet Bloc country participated in the 1984 Los Angeles Olympic Games. Which one?', 'Romania', 'Poland', 'Cuba', 'Yugoslavia', '2014-05-22 11:50:45', NULL, 30000),
(80829, 20004, NULL, 10000, NULL, NULL, 'Poland was the first country occupied by Nazi Germany in World War II. Which was the last?', 'Greece', 'Denmark', 'France', 'Yugoslavia', '2014-05-22 11:50:45', NULL, 30000),
(80830, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Turkey?', 'Ankara', 'Budapest', 'Ljubljana', 'Zagreb', '2014-05-22 11:50:45', NULL, 30000),
(80831, 20004, NULL, 10000, NULL, NULL, 'Complutum was the Roman name for which Spanish town?', 'Alcala De Henares', 'Aranda De Duero', 'Don Benito', 'Zamora', '2014-05-22 11:50:45', NULL, 30000),
(80832, 20005, NULL, 10000, NULL, NULL, 'Which metal do you get out of Hematite?', 'Iron', 'Manganese', 'Silver', 'Zinc', '2014-05-22 11:50:45', NULL, 30000),
(80833, 20000, NULL, 10004, NULL, NULL, 'Which martial art, when translated, originally meant Chinese hand and now means empty hand?', 'Karate', 'Taekwondo', 'Five Ancestors', 'Zui Quan', '2014-05-22 11:50:45', NULL, 30000);

-- --------------------------------------------------------

--
-- Table structure for table `B_QUIZ`
--

CREATE TABLE IF NOT EXISTS `B_QUIZ` (
  `QUIZ_ID` int(11) NOT NULL AUTO_INCREMENT,
  `QUIZ_CODE` varchar(100) NOT NULL,
  `NO_OF_QUESTIONS` int(11) NOT NULL,
  `DIFFICULTY_ID` int(11) NOT NULL,
  `LOCATION_ID` int(11) NOT NULL,
  `QUIZ_REGISTERED` datetime NOT NULL,
  `QUIZ_COMPLETED` datetime DEFAULT NULL,
  `NO_OF_USERS` int(11) NOT NULL,
  `CLIENT_ID` int(11) NOT NULL,
  PRIMARY KEY (`QUIZ_ID`),
  KEY `DIFFICULTY_ID` (`DIFFICULTY_ID`),
  KEY `CLIENT_ID` (`CLIENT_ID`),
  KEY `LOCATION_ID` (`LOCATION_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=90072 ;

--
-- Dumping data for table `B_QUIZ`
--

INSERT INTO `B_QUIZ` (`QUIZ_ID`, `QUIZ_CODE`, `NO_OF_QUESTIONS`, `DIFFICULTY_ID`, `LOCATION_ID`, `QUIZ_REGISTERED`, `QUIZ_COMPLETED`, `NO_OF_USERS`, `CLIENT_ID`) VALUES
(90000, 'test', 5, 10000, 40013, '2014-05-18 13:50:40', NULL, 3, 30000),
(90001, 'plods', 2, 10000, 40032, '2014-05-18 13:59:46', '2014-05-18 14:13:38', 0, 30000),
(90002, 'datum', 2, 10000, 40032, '2014-05-18 14:18:15', NULL, 0, 30000),
(90003, 'fixer', 2, 10000, 40032, '2014-05-18 14:42:00', '2014-05-18 14:43:03', 0, 30000),
(90004, 'sires', 2, 10000, 40032, '2014-05-18 14:45:10', NULL, 0, 30000),
(90005, 'swell', 2, 10000, 40032, '2014-05-18 14:57:15', NULL, 0, 30000),
(90006, 'mixes', 2, 10000, 40032, '2014-05-18 15:22:58', NULL, 0, 30000),
(90007, 'joker', 2, 10000, 40032, '2014-05-18 15:28:28', '2014-05-18 15:29:53', 0, 30000),
(90008, 'dicut', 2, 10000, 40032, '2014-05-19 21:08:31', '2014-05-19 21:09:13', 0, 30000),
(90015, 'spiny', 2, 10000, 40032, '2014-05-27 10:55:52', '2014-05-27 10:56:01', 0, 30001),
(90016, 'shoer', 2, 10000, 40001, '2014-05-27 10:56:06', '2014-05-27 10:56:16', 0, 30001),
(90017, 'jakes', 2, 10000, 40032, '2014-05-27 11:03:32', NULL, 0, 30001),
(90018, 'itchy', 2, 10000, 40032, '2014-05-27 14:27:00', '2014-05-27 14:27:15', 0, 30000),
(90019, 'exist', 2, 10000, 40032, '2014-05-27 14:59:02', '2014-05-27 14:59:21', 0, 30000),
(90021, 'kenaf', 2, 10000, 40032, '2014-05-27 15:15:15', '2014-05-27 15:16:35', 0, 30000),
(90022, 'ought', 3, 10002, 40012, '2014-05-27 20:16:04', '2014-05-27 20:31:20', 0, 30000),
(90023, 'avail', 5, 10004, 40012, '2014-05-27 20:47:31', '2014-05-27 20:52:12', 0, 30000),
(90024, 'veiny', 4, 10003, 40013, '2014-05-27 20:59:02', '2014-05-27 21:00:49', 0, 30000),
(90025, 'aargh', 5, 10002, 40013, '2014-05-27 21:19:09', '2014-05-27 21:22:20', 0, 30000),
(90026, 'table', 2, 10000, 40032, '2014-05-28 18:56:04', NULL, 0, 30000),
(90027, 'phlox', 2, 10000, 40032, '2014-05-28 19:54:14', '2014-05-28 19:54:47', 0, 30000),
(90028, 'runny', 2, 10004, 40013, '2014-05-28 21:13:31', '2014-05-28 21:14:51', 0, 30000),
(90029, 'poled', 2, 10000, 40032, '2014-05-28 21:14:53', '2014-05-28 21:16:45', 0, 30000),
(90030, 'baldy', 2, 10000, 40032, '2014-05-28 21:35:19', '2014-05-28 21:36:54', 0, 30000),
(90031, 'cocky', 2, 10002, 40013, '2014-05-28 21:37:09', '2014-05-28 21:38:34', 0, 30000),
(90032, 'biked', 2, 10002, 40000, '2014-05-28 21:38:52', '2014-05-28 21:43:45', 0, 30000),
(90033, 'dingy', 2, 10000, 40032, '2014-05-28 21:40:03', '2014-05-28 21:44:36', 0, 30000),
(90034, 'coats', 2, 10001, 40032, '2014-05-28 21:49:44', '2014-05-28 21:51:22', 0, 30000),
(90035, 'lisps', 2, 10000, 40032, '2014-05-28 22:10:21', NULL, 0, 30019),
(90036, 'bevel', 2, 10000, 40032, '2014-05-29 14:30:11', '2014-05-29 14:30:47', 0, 30000),
(90037, 'serge', 2, 10000, 40032, '2014-05-29 19:54:20', '2014-05-29 19:56:27', 0, 30000),
(90038, 'rajas', 2, 10000, 40032, '2014-05-29 19:59:09', '2014-05-29 20:01:48', 0, 30000),
(90039, 'cliff', 2, 10000, 40002, '2014-05-30 16:37:51', '2014-05-30 16:46:23', 0, 30000),
(90040, 'hexes', 2, 10000, 40002, '2014-05-30 16:46:39', '2014-05-30 16:47:45', 0, 30000),
(90041, 'casts', 2, 10000, 40002, '2014-05-30 16:51:14', '2014-05-30 16:52:50', 0, 30000),
(90042, 'quads', 2, 10000, 40032, '2014-05-30 16:54:33', '2014-05-30 17:21:38', 0, 30000),
(90043, 'rheum', 5, 10001, 40002, '2014-05-30 17:25:17', '2014-05-30 17:29:38', 0, 30000),
(90044, 'slave', 2, 10000, 40032, '2014-05-30 17:30:08', NULL, 0, 30000),
(90045, 'clots', 2, 10000, 40032, '2014-05-30 17:31:51', '2014-05-30 17:34:57', 0, 30000),
(90046, 'bowie', 2, 10000, 40032, '2014-05-30 17:42:31', '2014-05-30 17:43:23', 0, 30000),
(90047, 'softs', 2, 10000, 40032, '2014-05-30 17:44:28', '2014-05-30 17:44:49', 0, 30000),
(90048, 'gooey', 5, 10000, 40014, '2014-06-06 17:25:20', '2014-06-06 17:27:59', 0, 30019),
(90049, 'larch', 2, 10000, 40032, '2014-06-08 13:25:08', NULL, 0, 30000),
(90050, 'along', 2, 10000, 40032, '2014-06-08 13:30:25', '2014-06-08 13:30:38', 0, 30000),
(90051, 'novae', 2, 10000, 40032, '2014-06-08 13:32:51', '2014-06-08 13:33:06', 0, 30000),
(90052, 'duddy', 2, 10000, 40032, '2014-06-08 13:46:21', '2014-06-08 13:46:44', 0, 30000),
(90053, 'deign', 2, 10000, 40032, '2014-06-08 14:00:56', '2014-06-08 14:01:08', 0, 30000),
(90054, 'tagua', 2, 10000, 40032, '2014-06-08 14:10:59', NULL, 0, 30000),
(90055, 'loped', 2, 10000, 40032, '2014-06-08 14:28:15', '2014-06-08 14:28:25', 0, 30000),
(90056, 'decay', 2, 10000, 40032, '2014-06-08 14:40:10', '2014-06-08 14:40:21', 0, 30000),
(90057, 'lines', 5, 10000, 40032, '2014-06-08 18:27:40', '2014-06-08 18:38:04', 0, 30000),
(90058, 'smear', 10, 10002, 40032, '2014-06-08 18:33:32', '2014-06-08 18:46:16', 0, 30021),
(90059, 'forks', 5, 10004, 40013, '2014-06-11 18:50:47', '2014-06-11 19:07:46', 0, 30000),
(90060, 'vetch', 5, 10004, 40013, '2014-06-11 19:10:39', '2014-06-11 19:19:46', 0, 30000),
(90061, 'bauds', 5, 10002, 40032, '2014-06-11 19:12:05', '2014-06-11 19:19:30', 0, 30022),
(90062, 'moldy', 5, 10000, 40032, '2014-06-11 19:24:00', '2014-06-11 19:34:01', 0, 30022),
(90063, 'houri', 5, 10001, 40018, '2014-06-11 19:24:42', '2014-06-11 19:33:31', 0, 30023),
(90064, 'slows', 5, 10004, 40013, '2014-06-11 19:26:54', '2014-06-11 19:35:52', 0, 30000),
(90065, 'loped', 10, 10002, 40007, '2014-06-16 14:25:36', NULL, 0, 30025),
(90066, 'pizza', 2, 10000, 40014, '2014-06-17 09:23:21', NULL, 0, 30000),
(90067, 'swats', 24, 10002, 40032, '2014-06-19 17:52:35', NULL, 0, 30000),
(90068, 'rummy', 5, 10002, 40004, '2014-07-06 12:41:20', NULL, 0, 30000),
(90069, 'uncap', 1, 10000, 40032, '2014-07-09 16:07:30', '2014-07-09 16:08:59', 0, 30026),
(90070, 'newer', 5, 10000, 40032, '2014-07-09 16:18:31', NULL, 0, 30026),
(90071, 'reedy', 10, 10004, 40007, '2014-07-24 15:21:18', NULL, 0, 30000);

-- --------------------------------------------------------

--
-- Table structure for table `C_INTERACTION`
--

CREATE TABLE IF NOT EXISTS `C_INTERACTION` (
  `INTERACTION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `PARTICIPANT_ID` int(11) NOT NULL,
  `QUESTION_ID` int(11) NOT NULL,
  `SELECTED_ANSWER` int(11) DEFAULT NULL,
  `CURRENT_SCORE` int(11) NOT NULL,
  `INTERACTION_DATE` datetime NOT NULL,
  PRIMARY KEY (`INTERACTION_ID`),
  KEY `PARTICIPANT_ID` (`PARTICIPANT_ID`),
  KEY `QUESTION_ID` (`QUESTION_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=100001 ;

--
-- Dumping data for table `C_INTERACTION`
--

INSERT INTO `C_INTERACTION` (`INTERACTION_ID`, `PARTICIPANT_ID`, `QUESTION_ID`, `SELECTED_ANSWER`, `CURRENT_SCORE`, `INTERACTION_DATE`) VALUES
(100000, 70000, 80000, NULL, 0, '2014-05-18 13:54:11');

-- --------------------------------------------------------

--
-- Table structure for table `C_LOGIN`
--

CREATE TABLE IF NOT EXISTS `C_LOGIN` (
  `LOGIN_ID` int(11) NOT NULL AUTO_INCREMENT,
  `USER_ID` int(11) DEFAULT NULL,
  `CLIENT_ID` int(11) DEFAULT NULL,
  `LOGIN_DATE` datetime NOT NULL,
  PRIMARY KEY (`LOGIN_ID`),
  KEY `USER_ID` (`USER_ID`),
  KEY `CLIENT_ID` (`CLIENT_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=110291 ;

--
-- Dumping data for table `C_LOGIN`
--

INSERT INTO `C_LOGIN` (`LOGIN_ID`, `USER_ID`, `CLIENT_ID`, `LOGIN_DATE`) VALUES
(110000, 50000, NULL, '2014-05-18 13:55:10'),
(110001, NULL, 30000, '2014-05-18 13:59:38'),
(110002, 50000, NULL, '2014-05-18 13:59:54'),
(110003, NULL, 30000, '2014-05-18 14:18:07'),
(110004, NULL, 30000, '2014-05-18 14:41:53'),
(110005, 50000, NULL, '2014-05-18 14:42:08'),
(110006, NULL, 30000, '2014-05-18 14:57:09'),
(110007, NULL, 30000, '2014-05-18 15:22:52'),
(110008, NULL, 30000, '2014-05-18 15:28:23'),
(110009, NULL, 30001, '2014-05-18 19:27:48'),
(110010, 50000, NULL, '2014-05-18 20:52:16'),
(110011, 50000, NULL, '2014-05-18 20:53:51'),
(110012, 50000, NULL, '2014-05-18 21:00:37'),
(110013, 50000, NULL, '2014-05-18 21:15:25'),
(110014, 50000, NULL, '2014-05-18 21:17:10'),
(110015, 50000, NULL, '2014-05-18 21:19:57'),
(110016, 50000, NULL, '2014-05-18 21:26:21'),
(110017, 50000, NULL, '2014-05-18 21:28:16'),
(110018, 50000, NULL, '2014-05-18 21:38:28'),
(110019, 50000, NULL, '2014-05-18 21:40:38'),
(110020, 50000, NULL, '2014-05-18 21:45:56'),
(110021, 50000, NULL, '2014-05-18 21:46:25'),
(110022, 50000, NULL, '2014-05-18 21:48:40'),
(110023, 50000, NULL, '2014-05-18 21:50:42'),
(110024, 50000, NULL, '2014-05-18 21:53:33'),
(110025, 50000, NULL, '2014-05-18 21:56:19'),
(110026, 50000, NULL, '2014-05-18 21:56:56'),
(110027, 50000, NULL, '2014-05-19 06:52:16'),
(110028, 50000, NULL, '2014-05-19 06:54:00'),
(110029, 50000, NULL, '2014-05-19 06:57:42'),
(110030, 50000, NULL, '2014-05-19 21:07:03'),
(110031, 50000, NULL, '2014-05-19 21:07:48'),
(110032, NULL, 30000, '2014-05-19 21:08:23'),
(110033, 50000, NULL, '2014-05-19 21:19:06'),
(110034, 50000, NULL, '2014-05-20 06:54:51'),
(110035, 50000, NULL, '2014-05-21 15:22:27'),
(110036, 50000, NULL, '2014-05-21 15:25:01'),
(110037, 50000, NULL, '2014-05-21 15:25:03'),
(110038, 50000, NULL, '2014-05-21 15:25:04'),
(110039, 50000, NULL, '2014-05-21 15:25:10'),
(110040, 50000, NULL, '2014-05-21 15:28:04'),
(110041, 50000, NULL, '2014-05-21 15:28:06'),
(110042, 50000, NULL, '2014-05-21 15:28:07'),
(110043, 50000, NULL, '2014-05-21 15:40:25'),
(110044, 50000, NULL, '2014-05-21 20:46:40'),
(110045, 50000, NULL, '2014-05-22 12:55:24'),
(110046, 50000, NULL, '2014-05-22 12:56:52'),
(110047, 50000, NULL, '2014-05-22 12:56:53'),
(110048, 50000, NULL, '2014-05-22 17:25:55'),
(110049, 50000, NULL, '2014-05-22 18:09:10'),
(110050, 50000, NULL, '2014-05-22 18:11:08'),
(110051, 50000, NULL, '2014-05-22 18:19:39'),
(110052, 50000, NULL, '2014-05-22 18:31:25'),
(110053, 50000, NULL, '2014-05-22 18:32:13'),
(110054, 50000, NULL, '2014-05-22 18:32:53'),
(110055, 50000, NULL, '2014-05-22 18:44:41'),
(110056, 50000, NULL, '2014-05-22 18:45:26'),
(110057, 50000, NULL, '2014-05-22 18:52:03'),
(110058, 50000, NULL, '2014-05-22 19:38:11'),
(110059, 50000, NULL, '2014-05-22 19:38:48'),
(110060, 50000, NULL, '2014-05-22 19:41:08'),
(110061, 50000, NULL, '2014-05-22 19:41:31'),
(110062, 50000, NULL, '2014-05-22 19:42:21'),
(110063, 50000, NULL, '2014-05-22 19:44:17'),
(110064, 50000, NULL, '2014-05-22 19:52:02'),
(110065, 50000, NULL, '2014-05-22 19:53:29'),
(110066, 50000, NULL, '2014-05-22 19:55:46'),
(110067, 50000, NULL, '2014-05-22 19:56:52'),
(110068, 50000, NULL, '2014-05-22 20:00:58'),
(110069, 50000, NULL, '2014-05-22 20:06:15'),
(110070, 50000, NULL, '2014-05-22 20:06:18'),
(110071, NULL, 30000, '2014-05-23 17:49:27'),
(110073, NULL, 30000, '2014-05-26 17:57:16'),
(110075, NULL, 30000, '2014-05-26 18:34:01'),
(110078, NULL, 30000, '2014-05-26 19:04:49'),
(110079, NULL, 30000, '2014-05-26 19:04:53'),
(110080, NULL, 30000, '2014-05-26 19:08:27'),
(110081, NULL, 30000, '2014-05-26 19:08:28'),
(110082, NULL, 30000, '2014-05-26 19:08:29'),
(110083, NULL, 30000, '2014-05-26 19:08:30'),
(110084, NULL, 30000, '2014-05-26 19:08:40'),
(110087, NULL, 30000, '2014-05-26 19:33:03'),
(110089, NULL, 30000, '2014-05-26 20:22:49'),
(110101, NULL, 30000, '2014-05-26 20:50:43'),
(110102, NULL, 30000, '2014-05-26 20:50:45'),
(110103, NULL, 30000, '2014-05-26 20:50:56'),
(110104, NULL, 30000, '2014-05-26 20:51:05'),
(110105, NULL, 30000, '2014-05-26 20:56:16'),
(110106, NULL, 30000, '2014-05-26 20:56:23'),
(110107, NULL, 30000, '2014-05-26 20:59:08'),
(110143, NULL, 30000, '2014-05-27 15:12:24'),
(110145, NULL, 30000, '2014-05-27 20:10:59'),
(110146, NULL, 30000, '2014-05-27 20:11:03'),
(110147, NULL, 30000, '2014-05-27 20:11:20'),
(110148, NULL, 30000, '2014-05-27 20:11:21'),
(110149, NULL, 30000, '2014-05-27 20:13:02'),
(110150, NULL, 30000, '2014-05-27 20:15:45'),
(110151, 50000, NULL, '2014-05-27 20:17:28'),
(110152, 2, NULL, '2014-05-27 20:18:09'),
(110153, 50000, NULL, '2014-05-27 20:21:47'),
(110154, 50000, NULL, '2014-05-27 20:22:23'),
(110155, 50000, NULL, '2014-05-27 20:23:14'),
(110156, 50000, NULL, '2014-05-27 20:23:46'),
(110157, 50000, NULL, '2014-05-27 20:23:49'),
(110158, 50000, NULL, '2014-05-27 20:23:52'),
(110159, 50000, NULL, '2014-05-27 20:23:53'),
(110160, 50000, NULL, '2014-05-27 20:24:33'),
(110161, 50000, NULL, '2014-05-27 20:24:42'),
(110162, 50000, NULL, '2014-05-27 20:25:00'),
(110163, 50000, NULL, '2014-05-27 20:25:07'),
(110164, 50000, NULL, '2014-05-27 20:25:08'),
(110165, 50000, NULL, '2014-05-27 20:25:59'),
(110166, 50000, NULL, '2014-05-27 20:26:02'),
(110167, 50000, NULL, '2014-05-27 20:27:19'),
(110168, 50000, NULL, '2014-05-27 20:28:06'),
(110169, 50000, NULL, '2014-05-27 20:28:07'),
(110170, 50000, NULL, '2014-05-27 20:28:08'),
(110171, 50000, NULL, '2014-05-27 20:28:09'),
(110172, 50000, NULL, '2014-05-27 20:28:10'),
(110173, 50000, NULL, '2014-05-27 20:34:05'),
(110174, 50000, NULL, '2014-05-27 20:34:07'),
(110175, 3, NULL, '2014-05-27 20:37:44'),
(110176, 50000, NULL, '2014-05-27 20:39:34'),
(110177, 4, NULL, '2014-05-27 20:46:07'),
(110178, 4, NULL, '2014-05-27 20:55:21'),
(110179, 5, NULL, '2014-05-27 20:58:33'),
(110180, 50000, NULL, '2014-05-28 13:43:12'),
(110181, 50000, NULL, '2014-05-28 13:43:15'),
(110182, 50000, NULL, '2014-05-28 15:43:18'),
(110183, NULL, 30000, '2014-05-28 18:53:09'),
(110184, NULL, 30000, '2014-05-28 19:53:12'),
(110185, 50000, NULL, '2014-05-28 19:54:04'),
(110186, NULL, 30000, '2014-05-28 21:06:39'),
(110187, 50000, NULL, '2014-05-28 21:06:41'),
(110188, NULL, 30000, '2014-05-28 21:13:17'),
(110189, NULL, 30000, '2014-05-28 21:14:46'),
(110190, 50000, NULL, '2014-05-28 21:15:25'),
(110191, 50000, NULL, '2014-05-28 21:36:15'),
(110192, NULL, 30000, '2014-05-28 21:36:53'),
(110193, 50000, NULL, '2014-05-28 21:39:45'),
(110194, 6, NULL, '2014-05-28 21:42:13'),
(110195, 2, NULL, '2014-05-28 21:43:13'),
(110196, 2, NULL, '2014-05-28 21:50:48'),
(110197, NULL, 30019, '2014-05-28 22:09:33'),
(110198, 2, NULL, '2014-05-28 22:11:23'),
(110199, 7, NULL, '2014-05-28 22:13:50'),
(110200, NULL, 30000, '2014-05-29 14:29:01'),
(110201, 2, NULL, '2014-05-29 14:29:58'),
(110202, 2, NULL, '2014-05-29 18:49:31'),
(110203, NULL, 30000, '2014-05-29 19:36:32'),
(110204, NULL, 30000, '2014-05-29 19:36:46'),
(110205, NULL, 30000, '2014-05-29 19:36:50'),
(110206, NULL, 30000, '2014-05-29 19:37:02'),
(110207, NULL, 30000, '2014-05-29 19:37:53'),
(110208, NULL, 30000, '2014-05-29 19:37:53'),
(110209, NULL, 30000, '2014-05-29 19:38:02'),
(110210, NULL, 30000, '2014-05-29 19:38:13'),
(110211, NULL, 30000, '2014-05-29 19:38:17'),
(110212, 2, NULL, '2014-05-29 19:54:03'),
(110213, NULL, 30000, '2014-05-29 19:54:14'),
(110214, 2, NULL, '2014-05-29 19:59:48'),
(110215, 2, NULL, '2014-05-29 20:01:13'),
(110216, 50000, NULL, '2014-05-30 12:27:37'),
(110217, NULL, 30000, '2014-05-30 16:37:38'),
(110218, 2, NULL, '2014-05-30 16:38:36'),
(110219, 2, NULL, '2014-05-30 17:19:52'),
(110220, 6, NULL, '2014-05-30 17:25:02'),
(110221, NULL, 30000, '2014-05-30 17:31:25'),
(110222, 2, NULL, '2014-05-30 17:31:44'),
(110223, NULL, 30019, '2014-06-06 17:19:01'),
(110224, NULL, 30019, '2014-06-06 17:19:05'),
(110225, NULL, 30019, '2014-06-06 17:19:19'),
(110226, NULL, 30019, '2014-06-06 17:19:20'),
(110227, 7, NULL, '2014-06-06 17:22:57'),
(110228, NULL, 30019, '2014-06-06 17:24:50'),
(110229, NULL, 30000, '2014-06-08 12:49:22'),
(110230, NULL, 30000, '2014-06-08 12:49:35'),
(110231, NULL, 30000, '2014-06-08 12:50:02'),
(110232, NULL, 30000, '2014-06-08 13:02:17'),
(110233, NULL, 30000, '2014-06-08 13:03:48'),
(110234, NULL, 30001, '2014-06-08 13:07:04'),
(110235, NULL, 30001, '2014-06-08 13:08:30'),
(110236, NULL, 30000, '2014-06-08 13:14:49'),
(110237, NULL, 30001, '2014-06-08 13:16:46'),
(110238, NULL, 30000, '2014-06-08 13:17:04'),
(110239, NULL, 30000, '2014-06-08 13:17:07'),
(110240, NULL, 30000, '2014-06-08 13:23:22'),
(110241, NULL, 30000, '2014-06-08 13:23:28'),
(110242, NULL, 30000, '2014-06-08 13:24:50'),
(110243, NULL, 30000, '2014-06-08 13:30:15'),
(110244, NULL, 30000, '2014-06-08 13:32:39'),
(110245, NULL, 30000, '2014-06-08 14:28:05'),
(110246, NULL, 30020, '2014-06-08 18:12:02'),
(110247, NULL, 30021, '2014-06-08 18:12:41'),
(110248, 2, NULL, '2014-06-08 18:12:58'),
(110249, 50001, NULL, '2014-06-08 18:15:07'),
(110250, 50002, NULL, '2014-06-08 18:15:53'),
(110251, NULL, 30000, '2014-06-08 18:18:53'),
(110252, NULL, 30021, '2014-06-08 18:27:43'),
(110253, 2, NULL, '2014-06-08 18:29:42'),
(110254, 50001, NULL, '2014-06-08 18:34:55'),
(110255, 6, NULL, '2014-06-11 18:29:57'),
(110256, NULL, 30000, '2014-06-11 18:35:35'),
(110257, 50003, NULL, '2014-06-11 18:41:48'),
(110258, 50004, NULL, '2014-06-11 18:44:25'),
(110259, 50005, NULL, '2014-06-11 18:44:43'),
(110260, 50006, NULL, '2014-06-11 18:45:19'),
(110261, 50007, NULL, '2014-06-11 18:46:34'),
(110262, 50008, NULL, '2014-06-11 18:46:36'),
(110263, 50009, NULL, '2014-06-11 18:46:49'),
(110264, 50010, NULL, '2014-06-11 18:47:24'),
(110265, 50011, NULL, '2014-06-11 18:47:34'),
(110266, 50012, NULL, '2014-06-11 18:51:27'),
(110267, 50013, NULL, '2014-06-11 18:52:28'),
(110268, 50014, NULL, '2014-06-11 18:56:21'),
(110269, NULL, 30022, '2014-06-11 19:11:50'),
(110270, NULL, 30023, '2014-06-11 19:23:59'),
(110271, NULL, 30000, '2014-06-11 19:26:39'),
(110272, NULL, 30000, '2014-06-11 19:27:11'),
(110273, NULL, 30024, '2014-06-11 19:29:23'),
(110274, 50006, NULL, '2014-06-11 19:35:50'),
(110275, NULL, 30025, '2014-06-16 14:25:10'),
(110276, NULL, 30000, '2014-06-17 09:19:17'),
(110277, 50000, NULL, '2014-06-17 09:22:23'),
(110278, NULL, 30000, '2014-06-19 17:24:36'),
(110279, 6, NULL, '2014-06-19 21:56:22'),
(110280, NULL, 30000, '2014-06-23 08:46:21'),
(110281, 6, NULL, '2014-07-03 20:14:52'),
(110282, 6, NULL, '2014-07-06 10:43:06'),
(110283, NULL, 30026, '2014-07-09 16:07:12'),
(110284, 50003, NULL, '2014-07-24 15:19:23'),
(110285, NULL, 30000, '2014-07-24 15:20:15'),
(110286, 50003, NULL, '2014-07-24 15:20:26'),
(110287, NULL, 30000, '2014-07-24 15:21:07'),
(110288, 50015, NULL, '2014-08-10 14:23:41'),
(110289, 50003, NULL, '2014-08-15 18:32:21'),
(110290, NULL, 30000, '2014-08-17 20:48:19');

-- --------------------------------------------------------

--
-- Table structure for table `D_CATEGORY`
--

CREATE TABLE IF NOT EXISTS `D_CATEGORY` (
  `CATEGORY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `CATEGORY` varchar(100) NOT NULL,
  PRIMARY KEY (`CATEGORY_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20008 ;

--
-- Dumping data for table `D_CATEGORY`
--

INSERT INTO `D_CATEGORY` (`CATEGORY_ID`, `CATEGORY`) VALUES
(20000, 'SPORT'),
(20001, 'GEOGRAPHY'),
(20002, 'ART & LITERATURE'),
(20003, 'ENTERTAINMENT'),
(20004, 'HISTORY'),
(20005, 'SCIENCE & NATURE'),
(20006, 'FOOD & DRINK'),
(20007, 'PEOPLE');

-- --------------------------------------------------------

--
-- Table structure for table `D_DIFFICULTY`
--

CREATE TABLE IF NOT EXISTS `D_DIFFICULTY` (
  `DIFFICULTY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `DIFFICULTY` int(1) NOT NULL,
  PRIMARY KEY (`DIFFICULTY_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10005 ;

--
-- Dumping data for table `D_DIFFICULTY`
--

INSERT INTO `D_DIFFICULTY` (`DIFFICULTY_ID`, `DIFFICULTY`) VALUES
(10000, 1),
(10001, 2),
(10002, 3),
(10003, 4),
(10004, 5);

-- --------------------------------------------------------

--
-- Table structure for table `D_ERA`
--

CREATE TABLE IF NOT EXISTS `D_ERA` (
  `ERA_ID` int(11) NOT NULL AUTO_INCREMENT,
  `ERA` varchar(100) NOT NULL,
  PRIMARY KEY (`ERA_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=120001 ;

--
-- Dumping data for table `D_ERA`
--

INSERT INTO `D_ERA` (`ERA_ID`, `ERA`) VALUES
(120000, '1980s');

-- --------------------------------------------------------

--
-- Table structure for table `D_LOCATION`
--

CREATE TABLE IF NOT EXISTS `D_LOCATION` (
  `LOCATION_ID` int(11) NOT NULL AUTO_INCREMENT,
  `LOCATION` varchar(100) NOT NULL,
  PRIMARY KEY (`LOCATION_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=40033 ;

--
-- Dumping data for table `D_LOCATION`
--

INSERT INTO `D_LOCATION` (`LOCATION_ID`, `LOCATION`) VALUES
(40000, 'Aberdeen City'),
(40001, 'Aberdeenshire'),
(40002, 'Angus'),
(40003, 'Argyll and Bute'),
(40004, 'City of Edinburgh'),
(40005, 'Clackmannanshire'),
(40006, 'Dumfries and Galloway'),
(40007, 'Dundee City'),
(40008, 'East Ayrshire'),
(40009, 'East Dunbartonshire'),
(40010, 'East Lothian'),
(40011, 'East Renfrewshire'),
(40012, 'Falkirk'),
(40013, 'Fife'),
(40014, 'Glasgow City'),
(40015, 'Highland'),
(40016, 'Inverclyde'),
(40017, 'Midlothian'),
(40018, 'Moray'),
(40019, 'Na h-Eileanan Siar'),
(40020, 'North Ayrshire'),
(40021, 'North Lanarkshire'),
(40022, 'Orkney Islands'),
(40023, 'Perth and Kinross'),
(40024, 'Renfrewshire'),
(40025, 'Scottish Borders'),
(40026, 'Shetland Islands'),
(40027, 'South Ayrshire'),
(40028, 'South Lanarkshire'),
(40029, 'Stirling'),
(40030, 'West Dunbartonshire'),
(40031, 'West Lothian'),
(40032, 'No Location');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `A_CLIENT`
--
ALTER TABLE `A_CLIENT`
  ADD CONSTRAINT `A_CLIENT_ibfk_1` FOREIGN KEY (`LOCATION_ID`) REFERENCES `D_LOCATION` (`LOCATION_ID`);

--
-- Constraints for table `A_USER`
--
ALTER TABLE `A_USER`
  ADD CONSTRAINT `A_USER_ibfk_1` FOREIGN KEY (`LOCATION_ID`) REFERENCES `D_LOCATION` (`LOCATION_ID`);

--
-- Constraints for table `B_GAME`
--
ALTER TABLE `B_GAME`
  ADD CONSTRAINT `B_GAME_ibfk_1` FOREIGN KEY (`QUIZ_ID`) REFERENCES `B_QUIZ` (`QUIZ_ID`),
  ADD CONSTRAINT `B_GAME_ibfk_2` FOREIGN KEY (`QUESTION_ID`) REFERENCES `B_QUESTION` (`QUESTION_ID`);

--
-- Constraints for table `B_PARTICIPANT`
--
ALTER TABLE `B_PARTICIPANT`
  ADD CONSTRAINT `B_PARTICIPANT_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `A_USER` (`USER_ID`),
  ADD CONSTRAINT `B_PARTICIPANT_ibfk_2` FOREIGN KEY (`QUIZ_ID`) REFERENCES `B_QUIZ` (`QUIZ_ID`);

--
-- Constraints for table `B_QUESTION`
--
ALTER TABLE `B_QUESTION`
  ADD CONSTRAINT `B_QUESTION_ibfk_1` FOREIGN KEY (`CATEGORY_ID`) REFERENCES `D_CATEGORY` (`CATEGORY_ID`),
  ADD CONSTRAINT `B_QUESTION_ibfk_2` FOREIGN KEY (`SUB_CATEGORY_ID`) REFERENCES `D_CATEGORY` (`CATEGORY_ID`),
  ADD CONSTRAINT `B_QUESTION_ibfk_3` FOREIGN KEY (`DIFFICULTY_ID`) REFERENCES `D_DIFFICULTY` (`DIFFICULTY_ID`),
  ADD CONSTRAINT `B_QUESTION_ibfk_4` FOREIGN KEY (`LOCATION_ID`) REFERENCES `D_LOCATION` (`LOCATION_ID`),
  ADD CONSTRAINT `B_QUESTION_ibfk_5` FOREIGN KEY (`ERA_ID`) REFERENCES `D_ERA` (`ERA_ID`),
  ADD CONSTRAINT `B_QUESTION_ibfk_6` FOREIGN KEY (`CREATED_BY_USER`) REFERENCES `A_USER` (`USER_ID`),
  ADD CONSTRAINT `B_QUESTION_ibfk_7` FOREIGN KEY (`CREATED_BY_CLIENT`) REFERENCES `A_CLIENT` (`CLIENT_ID`);

--
-- Constraints for table `B_QUIZ`
--
ALTER TABLE `B_QUIZ`
  ADD CONSTRAINT `B_QUIZ_ibfk_1` FOREIGN KEY (`DIFFICULTY_ID`) REFERENCES `D_DIFFICULTY` (`DIFFICULTY_ID`),
  ADD CONSTRAINT `B_QUIZ_ibfk_2` FOREIGN KEY (`CLIENT_ID`) REFERENCES `A_CLIENT` (`CLIENT_ID`),
  ADD CONSTRAINT `B_QUIZ_ibfk_3` FOREIGN KEY (`LOCATION_ID`) REFERENCES `D_LOCATION` (`LOCATION_ID`);

--
-- Constraints for table `C_INTERACTION`
--
ALTER TABLE `C_INTERACTION`
  ADD CONSTRAINT `C_INTERACTION_ibfk_1` FOREIGN KEY (`PARTICIPANT_ID`) REFERENCES `B_PARTICIPANT` (`PARTICIPANT_ID`),
  ADD CONSTRAINT `C_INTERACTION_ibfk_2` FOREIGN KEY (`QUESTION_ID`) REFERENCES `B_QUESTION` (`QUESTION_ID`);

--
-- Constraints for table `C_LOGIN`
--
ALTER TABLE `C_LOGIN`
  ADD CONSTRAINT `C_LOGIN_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `A_USER` (`USER_ID`),
  ADD CONSTRAINT `C_LOGIN_ibfk_2` FOREIGN KEY (`CLIENT_ID`) REFERENCES `A_CLIENT` (`CLIENT_ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
