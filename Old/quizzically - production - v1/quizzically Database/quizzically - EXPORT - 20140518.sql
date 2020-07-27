-- phpMyAdmin SQL Dump
-- version 3.4.10.1deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: May 18, 2014 at 03:32 PM
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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30001 ;

--
-- Dumping data for table `A_CLIENT`
--

INSERT INTO `A_CLIENT` (`CLIENT_ID`, `CLIENT_EMAIL`, `CLIENT_PASSWORD`, `ORGANISATION`, `LOCATION_ID`, `CLIENT_UPDATES`, `CLIENT_CREATED`, `QUIZ_CREDIT`, `QUIZ_HOSTED`, `RESET`, `EXPIRE`) VALUES
(30000, 'test@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'Wittin', 40013, 'Y', '2014-05-18 12:53:21', 0, 3, NULL, NULL);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `A_USER`
--

INSERT INTO `A_USER` (`USER_ID`, `USER_EMAIL`, `USER_PASSWORD`, `GENDER`, `BIRTHDAY`, `LOCATION_ID`, `USER_UPDATES`, `USER_CREATED`, `RESET`, `EXPIRE`, `QUIZ_PLAYED`) VALUES
(50000, 'test@test.com', '5a105e8b9d40e1329780d62ea2265d8a', 'F', '2014-05-18 00:00:00', 40003, 'Y', '2014-05-18 13:42:41', NULL, NULL, 0);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=60020 ;

--
-- Dumping data for table `B_GAME`
--

INSERT INTO `B_GAME` (`GAME_ID`, `QUIZ_ID`, `QUESTIONS_LEFT`, `DIFFICULTY_ID`, `QUESTION_ID`, `QUIZ_STATUS`) VALUES
(60000, 90000, 0, 0, NULL, 'N'),
(60001, 90001, 2, 10000, NULL, 'I'),
(60002, 90001, 1, 10000, 80295, 'I'),
(60003, 90001, 0, 10000, 80142, 'R'),
(60004, 90002, 2, 10000, NULL, 'N'),
(60005, 90002, 1, 10000, 80213, 'R'),
(60006, 90002, 0, 10000, 80295, 'R'),
(60007, 90003, 2, 10000, NULL, 'I'),
(60008, 90003, 1, 10000, 80101, 'I'),
(60009, 90003, 0, 10000, 80135, 'F'),
(60010, 90004, 2, 10000, NULL, 'N'),
(60011, 90004, 1, 10000, 80015, 'R'),
(60012, 90004, 0, 10000, 80022, 'R'),
(60013, 90005, 2, 10000, NULL, 'N'),
(60014, 90005, 1, 10000, 80219, 'R'),
(60015, 90006, 2, 10000, NULL, 'N'),
(60016, 90006, 1, 10000, 80019, 'R'),
(60017, 90007, 2, 10000, NULL, 'I'),
(60018, 90007, 1, 10000, 80213, 'I'),
(60019, 90007, 0, 10000, 80015, 'F');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=70004 ;

--
-- Dumping data for table `B_PARTICIPANT`
--

INSERT INTO `B_PARTICIPANT` (`PARTICIPANT_ID`, `USER_ID`, `QUIZ_ID`, `PARTICIPANT_CREATED`, `SCORE`) VALUES
(70000, 50000, 90000, '2014-05-18 13:52:43', 0),
(70001, 50000, 90001, '2014-05-18 14:08:39', 1583),
(70002, 50000, 90002, '2014-05-18 14:18:29', 0),
(70003, 50000, 90003, '2014-05-18 14:42:16', 1851);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=80313 ;

--
-- Dumping data for table `B_QUESTION`
--

INSERT INTO `B_QUESTION` (`QUESTION_ID`, `CATEGORY_ID`, `SUB_CATEGORY_ID`, `DIFFICULTY_ID`, `LOCATION_ID`, `ERA_ID`, `QUESTION`, `CORRECT_ANSWER`, `WRONG_ANSWER_1`, `WRONG_ANSWER_2`, `WRONG_ANSWER_3`, `QUESTION_CREATED`, `CREATED_BY_USER`, `CREATED_BY_CLIENT`) VALUES
(80000, 20001, NULL, 10000, NULL, NULL, 'Which major French river runs through the heart of Paris?', 'Seine', 'Rhine', 'Thames', 'Nile', '2014-05-18 13:31:28', NULL, 30000),
(80002, 20000, NULL, 10000, NULL, NULL, 'How many pieces are on the board at the start of a game of chess?', '32', '28', '36', '40', '2014-05-18 13:33:42', NULL, 30000),
(80003, 20000, NULL, 10001, NULL, NULL, 'What is the name of the multi discipline sporting event that occurs every 4 years that is based on the ancient Greeks festival of games?', 'The Olympics', 'The Super Bowl', 'FA Cup Final', 'Football World Cup', '2014-05-18 13:33:42', NULL, 30000),
(80004, 20000, NULL, 10002, NULL, NULL, 'Countries from which continent boycotted the 1976 summer Olympics in Montreal?', 'Africa', 'Europe', 'Asia', 'South America', '2014-05-18 13:33:42', NULL, 30000),
(80005, 20000, NULL, 10002, NULL, NULL, 'How many players are (on the field) in a men’s lacrosse team (one team not both teams)?', '10', '7', '11', '13', '2014-05-18 13:33:42', NULL, 30000),
(80006, 20000, NULL, 10002, NULL, NULL, 'In Cricket, what does LBW stand for?', 'Leg Before Wicket', 'Long Boundary Way', 'Lose Both Wickets', 'Loose Bad and Wide', '2014-05-18 13:33:42', NULL, 30000),
(80007, 20000, NULL, 10002, NULL, NULL, 'Which NHL hockey team has won the most Stanley Cups?', 'Montreal Canadiens', 'Boston Bruins', 'Toronto Maple Leafs', 'New York Rangers', '2014-05-18 13:33:42', NULL, 30000),
(80008, 20000, NULL, 10003, NULL, NULL, 'Due to superstition, what didn’t Bjorn Borg do at Wimbledon?', 'shave', 'wash', 'change his socks', 'brush his teeth', '2014-05-18 13:33:42', NULL, 30000),
(80009, 20000, NULL, 10003, NULL, NULL, 'Which nation held the world team archery title throughout the 1970s?', 'USA', 'Germany', 'Great Britain', 'France', '2014-05-18 13:33:42', NULL, 30000),
(80010, 20000, NULL, 10003, NULL, NULL, 'Who scored the winning goal in the 1995 FA Cup final?', 'Paul Rideout', 'Eric Cantona', 'Duncan Ferguson', 'Thierry Henri', '2014-05-18 13:33:42', NULL, 30000),
(80011, 20000, NULL, 10003, NULL, NULL, 'Who won his fourth consecutive Olympic long jump gold in 1996?', 'Carl Lewis', 'Jesse Owens', 'Mike Powell', 'Jonathan Edwards', '2014-05-18 13:33:42', NULL, 30000),
(80012, 20000, NULL, 10004, NULL, NULL, 'A ’Miller’ is a move in which sport?', 'Trampolining', 'Ice Hockey', 'Diving', 'Chess', '2014-05-18 13:33:42', NULL, 30000),
(80013, 20000, NULL, 10004, NULL, NULL, 'How many rooms are on the Cluedo game board?', '8', '9', '10', '12', '2014-05-18 13:33:42', NULL, 30000),
(80014, 20000, NULL, 10004, NULL, NULL, 'Which event from the 2012 Summer Olympics was held at Lords Cricket Ground?', 'Archery', 'Fencing', 'Handball', 'Shooting', '2014-05-18 13:33:42', NULL, 30000),
(80015, 20001, NULL, 10000, NULL, NULL, 'New York City comprises how many boroughs?', '5', '6', '7', '12', '2014-05-18 13:33:42', NULL, 30000),
(80016, 20001, NULL, 10000, NULL, NULL, 'The British Naval Ensign features a Union Jack in which corner?', 'Top left', 'Top right', 'Bottom left', 'Bottom right', '2014-05-18 13:33:42', NULL, 30000),
(80017, 20001, NULL, 10000, NULL, NULL, 'The Eiffel Tower is located where in Paris?', 'Champ de Mars', 'Bois de Boulogne', 'Jardin des Plantes', 'Parc de Belleville', '2014-05-18 13:33:42', NULL, 30000),
(80018, 20001, NULL, 10000, NULL, NULL, 'What is the Capital city of France?', 'Paris', 'Madrid', 'Berlin', 'London', '2014-05-18 13:33:42', NULL, 30000),
(80019, 20001, NULL, 10000, NULL, NULL, 'What is the Capital city of Italy?', 'Rome', 'Dublin', 'Washington DC', 'New York ', '2014-05-18 13:33:42', NULL, 30000),
(80020, 20001, NULL, 10000, NULL, NULL, 'What is the Capital city of the Republic city of Ireland?', 'Dublin', 'Washington DC', 'Edinburgh', 'London', '2014-05-18 13:33:42', NULL, 30000),
(80021, 20001, NULL, 10000, NULL, NULL, 'What is the Capital city of the USA?', 'Washington DC', 'New York', 'San Francisco', 'Boston', '2014-05-18 13:33:42', NULL, 30000),
(80022, 20001, NULL, 10000, NULL, NULL, 'What is the International Air Transport Association airport code for Heathrow Airport?', 'LHR', 'HTR', 'HRW', 'LHW', '2014-05-18 13:33:42', NULL, 30000),
(80023, 20001, NULL, 10000, NULL, NULL, 'Which European country had a ’Carnation Revolution’ on the 25th of April 1974?', 'Portugal', 'Spain', 'Germany', 'Holland', '2014-05-18 13:33:42', NULL, 30000),
(80024, 20001, NULL, 10001, NULL, NULL, 'Only one South American country had a Monarchy. Which was it?', 'Brazil', 'Argentina', 'Columbia', 'Guyana', '2014-05-18 13:33:42', NULL, 30000),
(80025, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Australia?', 'Canberra', 'Sydney', 'Melbourne', 'Brisbane', '2014-05-18 13:33:42', NULL, 30000),
(80026, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Austria?', 'Vienna', 'Moscow', 'Copenhagen', 'Oslo', '2014-05-18 13:33:42', NULL, 30000),
(80027, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Denmark?', 'Copenhagen', 'Oslo', 'Reykjavik', 'Bern', '2014-05-18 13:33:42', NULL, 30000),
(80028, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Germany?', 'Berlin', 'Vienna', 'Moscow', 'Copenhagen', '2014-05-18 13:33:42', NULL, 30000),
(80029, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Greece?', 'Athens', 'Berlin', 'Vienna', 'Moscow', '2014-05-18 13:33:42', NULL, 30000),
(80030, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Iceland?', 'Reykjavik', 'Bern', 'Mexico City', 'Canberra', '2014-05-18 13:33:42', NULL, 30000),
(80031, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Mexico?', 'Mexico City', 'Cancun', 'Acapulco', 'Guadalajara', '2014-05-18 13:33:42', NULL, 30000),
(80032, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of New Zealand?', 'Wellington', 'Christchurch', 'Auckland', 'Adelaide', '2014-05-18 13:33:42', NULL, 30000),
(80033, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Norway?', 'Oslo', 'Reykjavik', 'Bern', 'Mexico City', '2014-05-18 13:33:42', NULL, 30000),
(80034, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Portugal?', 'Lisbon', 'Athens', 'Berlin', 'Vienna', '2014-05-18 13:33:42', NULL, 30000),
(80035, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Russia?', 'Moscow', 'Copenhagen', 'Oslo', 'Reykjavik', '2014-05-18 13:33:42', NULL, 30000),
(80036, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Spain?', 'Madrid', 'Lisbon', 'Athens', 'Berlin', '2014-05-18 13:33:42', NULL, 30000),
(80037, 20001, NULL, 10001, NULL, NULL, 'What is the Capital city of Switzerland?', 'Bern', 'Mexico City', 'Zurich', 'Geneva', '2014-05-18 13:33:42', NULL, 30000),
(80038, 20001, NULL, 10001, NULL, NULL, 'What two colours are in the Greek flag?', 'Blue and White', 'Red and Black', 'Red and White', 'Red and Blue', '2014-05-18 13:33:42', NULL, 30000),
(80039, 20001, NULL, 10002, NULL, NULL, 'What colour is the cross on the Finnish flag?', 'Blue', 'White', 'Red', 'Green', '2014-05-18 13:33:42', NULL, 30000),
(80040, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Argentina?', 'Buenos Aires', 'Rio de Janeiro', 'Cordoba', 'Montevideo', '2014-05-18 13:33:42', NULL, 30000),
(80041, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Azerbaijan', 'Baku', 'Tel Aviv', 'Tashkent', 'Sofia', '2014-05-18 13:33:42', NULL, 30000),
(80042, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Belgium?', 'Brussels', 'The Hague', 'Luxembourg City', 'Ottawa', '2014-05-18 13:33:42', NULL, 30000),
(80043, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Bosnia & Herzegovina?', 'Sarajevo', 'Prague', 'Warsaw', 'Tallinn', '2014-05-18 13:33:42', NULL, 30000),
(80044, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Brazil?', 'Brasilia', 'Rio de Janeiro', 'Sao Paulo', 'Bueno Aires', '2014-05-18 13:33:42', NULL, 30000),
(80045, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Canada?', 'Ottawa', 'Montreal', 'Calgary', 'Toronto', '2014-05-18 13:33:42', NULL, 30000),
(80046, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Colombia?', 'Bogotta', 'La Paz', 'Santiago', 'Caracas', '2014-05-18 13:33:42', NULL, 30000),
(80047, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Croatia?', 'Zagreb', 'Belgrade', 'Sarajevo', 'Prague', '2014-05-18 13:33:42', NULL, 30000),
(80048, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Estonia?', 'Tallinn', 'Brussels', 'The Hague', 'Luxembourg City', '2014-05-18 13:33:42', NULL, 30000),
(80049, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Hungary?', 'Budapest', 'Ljubljana', 'Zagreb', 'Belgrade', '2014-05-18 13:33:42', NULL, 30000),
(80050, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Luxembourg?', 'Luxembourg City', 'Ottawa', 'Brasilia', 'Buenos Aires', '2014-05-18 13:33:42', NULL, 30000),
(80051, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Peru?', 'Lima', 'Cordoba', 'Caracas', 'Quito', '2014-05-18 13:33:42', NULL, 30000),
(80052, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Poland?', 'Warsaw', 'Tallinn', 'Brussels', 'The Hague', '2014-05-18 13:33:42', NULL, 30000),
(80053, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Serbia?', 'Belgrade', 'Sarajevo', 'Prague', 'Warsaw', '2014-05-18 13:33:42', NULL, 30000),
(80054, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Slovenia?', 'Ljubljana', 'Zagreb', 'Belgrade', 'Sarajevo', '2014-05-18 13:33:42', NULL, 30000),
(80055, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of the Czech Republic?', 'Prague', 'Warsaw', 'Tallinn', 'Brussels', '2014-05-18 13:33:42', NULL, 30000),
(80056, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of the Netherlands?', 'The Hague', 'Luxembourg City', 'Ottawa', 'Brasilia', '2014-05-18 13:33:42', NULL, 30000),
(80057, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Turkey?', 'Ankara', 'Budapest', 'Ljubljana', 'Zagreb', '2014-05-18 13:33:42', NULL, 30000),
(80058, 20001, NULL, 10002, NULL, NULL, 'What is the Capital city of Venezuela?', 'Caracas', 'Cordoba', 'Lima', 'Quito', '2014-05-18 13:33:42', NULL, 30000),
(80059, 20001, NULL, 10002, NULL, NULL, 'What is the modern name of ancient Mesopotamia?', 'Iraq', 'Iran', 'Israel', 'Lebanon', '2014-05-18 13:33:42', NULL, 30000),
(80060, 20001, NULL, 10002, NULL, NULL, 'Which city became the capital of the USA in 1788?', 'New York', 'California', 'Utah', 'Texas', '2014-05-18 13:33:42', NULL, 30000),
(80061, 20001, NULL, 10002, NULL, NULL, 'Which country boasts most of the Kalahari desert?', 'Botswana', 'South Africa', 'Zimbabwe', 'Sudan', '2014-05-18 13:33:42', NULL, 30000),
(80062, 20001, NULL, 10003, NULL, NULL, 'The reactor at the site of the Chernobyl nuclear disaster is now in which country?', 'Ukraine', 'Slovakia', 'Hungary', 'Russia', '2014-05-18 13:33:42', NULL, 30000),
(80063, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Andorra?', 'Andorra la Vella', 'Monaco', 'Montevideo', 'Quito', '2014-05-18 13:33:42', NULL, 30000),
(80064, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Azerbaijan', 'Baku', 'Tel Aviv', 'Tashkent', 'Sofia', '2014-05-18 13:33:42', NULL, 30000),
(80065, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Bulgaria?', 'Sofia', 'Helsinki', 'Stockholm', 'Valletta', '2014-05-18 13:33:42', NULL, 30000),
(80066, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Chile?', 'Santiago', 'Caracas', 'Lima', 'Quito', '2014-05-18 13:33:42', NULL, 30000),
(80067, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Cyprus?', 'Nicosia', 'St. Helier', 'St. Peter Port', 'Andorra la Vella', '2014-05-18 13:33:42', NULL, 30000),
(80068, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Ecuador?', 'Quito', 'Cordoba', 'Lima', 'Santiago', '2014-05-18 13:33:42', NULL, 30000),
(80069, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Finland?', 'Helsinki', 'Stockholm', 'Valetta', 'Nicosia', '2014-05-18 13:33:42', NULL, 30000),
(80070, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Latvia?', 'Riga', 'Kiev', 'Bucharest', 'Sofia', '2014-05-18 13:33:42', NULL, 30000),
(80071, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Lithuania?', 'Vilnius', 'Riga', 'Kiev', 'Bucharest', '2014-05-18 13:33:42', NULL, 30000),
(80072, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Malta?', 'Valletta', 'Nicosia', 'St. Helier', 'St. Peter Port', '2014-05-18 13:33:42', NULL, 30000),
(80073, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Monaco?', 'Monaco', 'Montevideo', 'Quito', 'Santiago', '2014-05-18 13:33:42', NULL, 30000),
(80074, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Paraguay?', 'Asunción', 'Caracas', 'Santiago', 'San Juan', '2014-05-18 13:33:42', NULL, 30000),
(80075, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of pre-unified West Germany?', 'Bonn', 'Bratislava', 'Vilnius', 'Riga', '2014-05-18 13:33:42', NULL, 30000),
(80076, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Romania?', 'Bucharest', 'Sofia', 'Helsinki', 'Stockholm', '2014-05-18 13:33:42', NULL, 30000),
(80077, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Slovakia?', 'Bratislava', 'Vilnius', 'Riga', 'Kiev', '2014-05-18 13:33:42', NULL, 30000),
(80078, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Sweden?', 'Stockholm', 'Valletta', 'Nicosia', 'St. Helier', '2014-05-18 13:33:42', NULL, 30000),
(80079, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Ukraine?', 'Kiev', 'Bucharest', 'Sofia', 'Helsinki', '2014-05-18 13:33:42', NULL, 30000),
(80080, 20001, NULL, 10003, NULL, NULL, 'What is the Capital city of Uruguay?', 'Montevideo', 'Porto Alegre', 'Rio de Janeiro', 'Cordoba', '2014-05-18 13:33:42', NULL, 30000),
(80081, 20001, NULL, 10003, NULL, NULL, 'What is the Capital of the island of Guernsey?', 'St. Peter Port', 'Andorra la Vella', 'Monaco', 'Montevideo', '2014-05-18 13:33:42', NULL, 30000),
(80082, 20001, NULL, 10003, NULL, NULL, 'What is the Capital of the island of Jersey?', 'St. Helier', 'St. Peter Port', 'Andorra la Vella', 'Monaco', '2014-05-18 13:33:42', NULL, 30000),
(80083, 20001, NULL, 10003, NULL, NULL, 'What is the old name for Sri Lanka?', 'Ceylon', 'Mandalay', 'Spice Islands', 'East Pakistan', '2014-05-18 13:33:42', NULL, 30000),
(80084, 20001, NULL, 10003, NULL, NULL, 'What number Pennsylvania Avenue is the White House?', '1600', '1500', '501', '65000', '2014-05-18 13:33:42', NULL, 30000),
(80085, 20001, NULL, 10003, NULL, NULL, 'What was the name of the infamous nuclear reactor in Harrisburg Penn.?', '3 mile island', '1 mile island', '9 mile creek', '16 mile creek', '2014-05-18 13:33:42', NULL, 30000),
(80086, 20001, NULL, 10004, NULL, NULL, 'The crown of which New York City landmark was originally built as an airship dock?', 'Empire State Building', 'Chrysler Building', 'Statue of Liberty', 'Trump Tower', '2014-05-18 13:33:42', NULL, 30000),
(80087, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Albania?', 'Tirana', 'Prishtina', 'Chisinau', 'La Paz', '2014-05-18 13:33:42', NULL, 30000),
(80088, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Armenia?', 'Yerevan', 'Minsk', 'Vaduz', 'St. Anne', '2014-05-18 13:33:42', NULL, 30000),
(80089, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Belarus?', 'Minsk', 'Vaduz', 'St. Anne', 'Tirana', '2014-05-18 13:33:42', NULL, 30000),
(80090, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Bolivia?', 'La Paz', 'Bogotá', 'Santiago', 'San Juan', '2014-05-18 13:33:42', NULL, 30000),
(80091, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Georgia', 'Tbilisi', 'Podegrica', 'Yerevan', 'Minsk', '2014-05-18 13:33:42', NULL, 30000),
(80092, 20001, NULL, 10004, NULL, NULL, 'What is the Capital City of Illinois?', 'Springfield', 'Chicago', 'Rockford', 'Houston', '2014-05-18 13:33:42', NULL, 30000),
(80093, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Kosovo?', 'Prishtina', 'Chisinau', 'Zagreb', 'Tbilisi', '2014-05-18 13:33:42', NULL, 30000),
(80094, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Liechtenstein?', 'Vaduz', 'St. Anne', 'Tirana', 'Prishtina', '2014-05-18 13:33:42', NULL, 30000),
(80095, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Macedonia?', 'Skopje', 'Tbilisi', 'Podegrica', 'Yerevan', '2014-05-18 13:33:42', NULL, 30000),
(80096, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Moldova?', 'Chisinau', 'Tirana', 'Oslo', 'Valletta', '2014-05-18 13:33:42', NULL, 30000),
(80097, 20001, NULL, 10004, NULL, NULL, 'What is the Capital city of Montenegro?', 'Podegrica', 'Yerevan', 'Minsk', 'Vaduz', '2014-05-18 13:33:42', NULL, 30000),
(80098, 20001, NULL, 10004, NULL, NULL, 'What is the Capital of the island of Alderney?', 'St. Anne', 'Tirana', 'Prishtina', 'Chisinau', '2014-05-18 13:33:42', NULL, 30000),
(80099, 20001, NULL, 10004, NULL, NULL, 'What was the capital city of India until December 1911?', 'Calcutta', 'Shimla', 'Jahangir', 'Delhi', '2014-05-18 13:33:42', NULL, 30000),
(80100, 20002, NULL, 10000, NULL, NULL, 'Harry Potter was the creation of which British author?', 'J K Rowling', 'Roald Dahl', 'Julia Donaldson', 'J R R Tolkien', '2014-05-18 13:33:42', NULL, 30000),
(80101, 20002, NULL, 10000, NULL, NULL, 'In which book is there an inn called ’Admiral Benbow’?', 'Treasure Island', 'Gulliver?s Travels', 'Lord of the Rings', 'Peter Pan', '2014-05-18 13:33:42', NULL, 30000),
(80102, 20002, NULL, 10001, NULL, NULL, 'Which character, created by Hugh Lofting, talked to the Animals?', 'Dr Doolittle', 'St Christopher', 'St Francis of Assisi', 'Babe the talking pig', '2014-05-18 13:33:42', NULL, 30000),
(80103, 20002, NULL, 10002, NULL, NULL, 'Old Curiosity Shop was written by which author?', 'Charles Dickens', 'Mark Twain', 'Frederick Forsyth', 'Oscar Wilde', '2014-05-18 13:33:42', NULL, 30000),
(80105, 20002, NULL, 10003, NULL, NULL, 'From whom did Shakespeare steal the phrase ’Love is blind’?', 'Geoffrey Chaucer', 'Charles Dickens', 'Jonathan Swift', 'He did not steal the phrase', '2014-05-18 13:33:42', NULL, 30000),
(80106, 20002, NULL, 10003, NULL, NULL, 'Twain is an Old English word for which number?', '2', '3', '12', '20', '2014-05-18 13:33:42', NULL, 30000),
(80107, 20002, NULL, 10003, NULL, NULL, 'Which novel won author J.M. Coetzee the Booker Prize?', 'Disgrace', 'Discretion', 'Discourse', 'Direction', '2014-05-18 13:33:42', NULL, 30000),
(80108, 20002, NULL, 10004, NULL, NULL, '’The Agony and the Ecstasy’ was a book and film about which man?', 'Michaelangelo', 'Jesus', 'Churchill', 'Marquis de Sade', '2014-05-18 13:33:42', NULL, 30000),
(80109, 20002, NULL, 10004, NULL, NULL, 'What is the name of the man servant in ’Around the world in 80 days’?', 'Pas Partout', 'Cato', 'Giles', 'Machu Picchu', '2014-05-18 13:33:42', NULL, 30000),
(80110, 20002, NULL, 10004, NULL, NULL, 'What was the name of the 2002 Man Booker prize winning Book by Yann Martel?', 'Life of Pi', 'The English Patient', 'The Cat in the Hat', 'The Line of Beauty', '2014-05-18 13:33:42', NULL, 30000),
(80111, 20002, NULL, 10004, NULL, NULL, 'Which author, sometimes known as ’Q ’,was the inspiration for Ratty in ’The Wind in the Willows’?', 'Sir Arthur Quiller Couch', 'Laurence Olivier', 'Sir Alec Guinness', 'Richard Burton', '2014-05-18 13:33:42', NULL, 30000),
(80112, 20003, NULL, 10000, NULL, NULL, 'Festfolk was the original name for which group?', 'ABBA', 'The Beach Boys', 'Motorhead', 'Simon and Garfunkel', '2014-05-18 13:33:42', NULL, 30000),
(80113, 20003, NULL, 10000, NULL, NULL, 'What genre of Music was Luciano Pavarotti most famous for?', 'Opera', 'Drum and Bass', 'Punk', 'Country', '2014-05-18 13:33:42', NULL, 30000),
(80114, 20003, NULL, 10000, NULL, NULL, 'Which actor appeared in the Cranberries music video ’Ridiculous Thought’?', 'Elijah Wood', 'Donald Sutherland', 'George Clooney', 'Bruce Willis', '2014-05-18 13:33:42', NULL, 30000),
(80115, 20003, NULL, 10001, NULL, NULL, 'The title of which Pink Floyd album is also a chapter in ’The Wind In The Willows’?', 'The piper at the gates of dawn', 'Wish you were here', 'Meddle', 'Animals', '2014-05-18 13:33:42', NULL, 30000),
(80116, 20003, NULL, 10001, NULL, NULL, 'Where did The Flowerpot Men want to go in 1967?', 'San Francisco', 'New York', 'Woodstock', 'Memphis', '2014-05-18 13:33:42', NULL, 30000),
(80117, 20003, NULL, 10001, NULL, NULL, 'Who plays Lara Croft in the Tomb Raider series of films?', 'Angelina Jolie', 'Minnie Driver', 'Nell McAndrew', 'Jennifer Aniston', '2014-05-18 13:33:42', NULL, 30000),
(80118, 20003, NULL, 10002, NULL, NULL, 'According to the singer Katie Melua: how many million bicycles are there in Beijing?', '5', '9', '10', '25', '2014-05-18 13:33:42', NULL, 30000),
(80119, 20003, NULL, 10002, NULL, NULL, 'How old has the ageless Bart Simpson been ever since his TV show began?', '10', '8', '12', '9', '2014-05-18 13:33:42', NULL, 30000),
(80120, 20003, NULL, 10002, NULL, NULL, 'In which film do the words ’I love you’ save the planet earth?', 'The 5th Element', 'The Day After Tomorrow', 'Mars Attacks', 'Independence Day', '2014-05-18 13:33:42', NULL, 30000),
(80122, 20003, NULL, 10003, NULL, NULL, '’Goodbye Farewell and Amen’ was the final episode of which TV series?', 'MASH', 'Dallas', 'Friends', 'The Muppet Show', '2014-05-18 13:33:42', NULL, 30000),
(80123, 20003, NULL, 10003, NULL, NULL, 'James Bond was searching for what kind of airplane in ’Thunderball’?', 'Vulkan', 'Piper Cub', '707', 'B-52', '2014-05-18 13:33:42', NULL, 30000),
(80124, 20003, NULL, 10003, NULL, NULL, 'What famous piece of classical music is acclaimed to have been written by King Henry the VIII?', 'Greensleaves', 'Brandenburg Concerto', 'Air on a G String', 'Land of Hope and Glory', '2014-05-18 13:33:42', NULL, 30000),
(80125, 20004, NULL, 10000, NULL, NULL, 'Complutum was the Roman name for which Spanish town?', 'Alcala de Henares', 'Aranda de Duero', 'Don Benito', 'Zamora', '2014-05-18 13:33:42', NULL, 30000),
(80126, 20004, NULL, 10000, NULL, NULL, 'In 1554 a Portuguese ship sighted a beautiful island in East Asia and in an imaginative mood named it ’Ilha Formosa’. What is its current name?', 'Taiwan', 'Palawan', 'Naha', 'Hainan', '2014-05-18 13:33:42', NULL, 30000),
(80127, 20004, NULL, 10000, NULL, NULL, 'In 1579, the Netherlands achieved independence from which country?', 'Spain', 'Portugal', 'Germany', 'Austria', '2014-05-18 13:33:42', NULL, 30000),
(80128, 20004, NULL, 10000, NULL, NULL, 'In which year did the Yom Kippur War take place, Ceylon changed its name to Sri Lanka, and a revolution in Chile overthrows Presidente Allende?', '1973', '1975', '1970', '1983', '2014-05-18 13:33:42', NULL, 30000),
(80129, 20004, NULL, 10000, NULL, NULL, 'Poland was the first country occupied by Nazi Germany in World War II. Which was the last?', 'Greece', 'Denmark', 'France', 'Yugoslavia', '2014-05-18 13:33:42', NULL, 30000),
(80130, 20004, NULL, 10000, NULL, NULL, 'The core rules of the Muslim faith are known as the (how many) Pillars of Islam?', '5', '7', '9', '23', '2014-05-18 13:33:42', NULL, 30000),
(80131, 20004, NULL, 10000, NULL, NULL, 'The Poem "Defence of Fort McHenry" written during the bombing of Baltimore is now much better known by another name.', 'The Star-Spangled Banner', 'Stuka', 'Hibakusha', 'Ode to The Full Moon', '2014-05-18 13:33:42', NULL, 30000),
(80132, 20004, NULL, 10000, NULL, NULL, 'What happened to the Archbishop of Krakow in 1978?', 'He became Pope John Paul II', 'He was Assassinated', 'He Died', 'He was invited into Parliament', '2014-05-18 13:33:42', NULL, 30000),
(80133, 20004, NULL, 10000, NULL, NULL, 'What is the ruling family of Monaco called?', 'Grimaldi', 'Gerald', 'Germunia', 'Gustaf', '2014-05-18 13:33:42', NULL, 30000),
(80134, 20004, NULL, 10000, NULL, NULL, 'What official title do ambassadors to the UK have?', 'Ambassador to the Court of Saint James', 'Official Ambassador of The UK', 'Ambassador to the Court of Saint John', 'Ambassador to the Court that is the UK', '2014-05-18 13:33:42', NULL, 30000),
(80135, 20004, NULL, 10000, NULL, NULL, 'What was the name of the cult that Charles Manson led which killed at least seven people?', 'The Family', 'The Cousins', 'The Relatives', 'The Couple', '2014-05-18 13:33:42', NULL, 30000),
(80136, 20004, NULL, 10000, NULL, NULL, 'What was the name of the foot soldiers that moved on horseback, especially popular in the 17th and 18th centuries?', 'Dragoons', 'Cavalry', 'The Watchdogs', 'Armoured Knights', '2014-05-18 13:33:42', NULL, 30000),
(80137, 20004, NULL, 10000, NULL, NULL, 'What was the Roman name for Ireland?', 'Hibernia', 'Gallia', 'Helvetia', 'Iberia', '2014-05-18 13:33:42', NULL, 30000),
(80138, 20004, NULL, 10000, NULL, NULL, 'Which town was the scene of the gunfight at the OK Corral?', 'Tombstone, Arizona', 'Springfield , Missouri', 'Las Vegas , New Mexico', 'Holbrook , Arizona', '2014-05-18 13:33:42', NULL, 30000),
(80139, 20004, NULL, 10000, NULL, NULL, 'Who claimed responsibility for the kidnapping and murder of Italian prime minister Aldo Moro in 1978?', 'The Red Brigades', 'His own Party', 'The Italian Mafia', 'Francesco Tritto', '2014-05-18 13:33:42', NULL, 30000),
(80140, 20004, NULL, 10000, NULL, NULL, 'Who succeeded Charles de Gaulle as President of France?', 'Georges Pompidou', 'Rene Coty', 'Valery Giscard dEstaing', 'Nicolas Sarkozy', '2014-05-18 13:33:42', NULL, 30000),
(80141, 20004, NULL, 10000, NULL, NULL, 'Who was Queen Victoria married to?', 'Prince Albert', 'Prince George', 'King Henry VII', 'John Balliol', '2014-05-18 13:33:42', NULL, 30000),
(80142, 20004, NULL, 10000, NULL, NULL, 'Who was the first US president to be shot and survive (whilst in office)?', 'Ronald Reagan', 'James A. Garfield', 'William McKinley', 'Jimmy Carter', '2014-05-18 13:33:42', NULL, 30000),
(80143, 20004, NULL, 10001, NULL, NULL, 'During which battle did the charge of the Light Brigade take place?', 'The Battle of Balaclava', 'The Battle of Bilbao', 'The Battle Of Bailen', 'The Battle of Brescia', '2014-05-18 13:33:42', NULL, 30000),
(80144, 20004, NULL, 10001, NULL, NULL, 'How many Horsemen of the Apocalypse feature in the Bibles Book of Revelation?', '4', '3', '5', '10000', '2014-05-18 13:33:42', NULL, 30000),
(80145, 20004, NULL, 10001, NULL, NULL, 'In which war in the second half of the twentieth century did the Free World Military Forces take part?', 'The Vietnam War', 'Revolutionary War', 'Chinese Civil War', 'Spanish Civil War', '2014-05-18 13:33:42', NULL, 30000),
(80146, 20004, NULL, 10001, NULL, NULL, 'In which year was Malcolm X assassinated, Singapore became independent from Malaya, and Sir Winston Churchill died?', '1965', '1960', '1970', '1961', '2014-05-18 13:33:42', NULL, 30000),
(80147, 20004, NULL, 10001, NULL, NULL, 'The ancient region of Nubia is in which two modern countries?', 'Egypt and Sudan', 'Egypt and Ethiopia', 'Ethiopia and Sudan', 'Libya and Egypt', '2014-05-18 13:33:42', NULL, 30000),
(80148, 20004, NULL, 10001, NULL, NULL, 'The Kings of Italy all belonged to which house?', 'House of Savoy', 'House of Glen', 'House of Pain', 'House of Fraser', '2014-05-18 13:33:42', NULL, 30000),
(80149, 20004, NULL, 10001, NULL, NULL, 'The Penny Black was the first modern postage stamp in the world but the Penny Red was the first to have what?', 'Perforations', 'Dates', 'Pictures', 'Size difference', '2014-05-18 13:33:42', NULL, 30000),
(80150, 20004, NULL, 10001, NULL, NULL, 'What did the acronym MAD, coined by then Secretary of State John Foster Dulles, referring to nuclear weapons stand for?', 'Mutually Assured Destruction', 'Mass Assured Destruction', 'Mutually Assembled Destruction', 'Mass Assembled Devastation', '2014-05-18 13:33:42', NULL, 30000),
(80151, 20004, NULL, 10001, NULL, NULL, 'What in 1982 were Operation Rosario and Operation Corporate?', 'The Falklands War', 'The Attack on Rio Grande', 'The Spanish Civil War', 'Battle of the Marshes', '2014-05-18 13:33:42', NULL, 30000),
(80152, 20004, NULL, 10001, NULL, NULL, 'What was Operation Dynamo in World War II?', 'The evacuation at Dunkirk', 'First of the Arctic Convoy to Soviet Union', 'British Anti-Shipping Operation in Norway', 'Occupation of Abadan', '2014-05-18 13:33:42', NULL, 30000),
(80153, 20004, NULL, 10001, NULL, NULL, 'When Spaniards first arrived in the Canary Islands they found a native population, what were they called?', 'Guanches', 'Phoenicians', 'Carthaginians', 'Maxos', '2014-05-18 13:33:42', NULL, 30000),
(80154, 20004, NULL, 10001, NULL, NULL, 'Which agreement resulted in the splitting of Germany?', 'The Yalta agreement', 'The Schengen Agreement', 'The Munich Agreement', 'The Felt agreement', '2014-05-18 13:33:42', NULL, 30000),
(80155, 20004, NULL, 10001, NULL, NULL, 'Which country has been ruled by the Chakri dynasty since 1782?', 'Thailand', 'Taiwan', 'Cambodia', 'Naha', '2014-05-18 13:33:42', NULL, 30000),
(80156, 20004, NULL, 10001, NULL, NULL, 'Which three letters replaced CQD?', 'SOS', 'KGB', 'TNT', 'FYI', '2014-05-18 13:33:42', NULL, 30000),
(80157, 20004, NULL, 10001, NULL, NULL, 'Which was the most important battle fought by the Lincoln Brigade in the Spanish Civil War?', 'The Battle of Jarama', 'The Battle of Bilbao', 'The Battle of Caspe', 'The Battle of Majorca', '2014-05-18 13:33:42', NULL, 30000),
(80158, 20004, NULL, 10001, NULL, NULL, 'Who was the first President of the United States whose father was also President of the United States?', 'John Quincy Adams', 'George W Bush', 'John F Kennedy', 'William Henry Harrison', '2014-05-18 13:33:42', NULL, 30000),
(80159, 20004, NULL, 10001, NULL, NULL, 'Who was the first Tudor King of England, crowned in 1485?', 'Henry VII', 'Henry VIII', 'Edward VI', 'Henry V', '2014-05-18 13:33:42', NULL, 30000),
(80160, 20004, NULL, 10001, NULL, NULL, 'Who was the real spy (for the Germans) in the Dreyfuss Affair?', 'Major Esterhazy', 'Kurt Jahnke', 'Johhny Jebsen', 'Jose Waldberg', '2014-05-18 13:33:42', NULL, 30000),
(80161, 20004, NULL, 10002, NULL, NULL, 'Bulgaria achieved independence in 1908 from which country?', 'The Ottoman Empire', 'Croatia', 'Egypt', 'Kingdom of Bosnia', '2014-05-18 13:33:42', NULL, 30000),
(80162, 20004, NULL, 10002, NULL, NULL, 'Herodotus is known as the father of what?', 'History', 'Medicine', 'Theatre', 'Music', '2014-05-18 13:33:42', NULL, 30000),
(80163, 20004, NULL, 10002, NULL, NULL, 'How long did the 100 Years War last?', '116 years', '100 years', '105 years', '110 years', '2014-05-18 13:33:42', NULL, 30000),
(80164, 20004, NULL, 10002, NULL, NULL, 'In what year was NATO founded?', '1949', '1950', '1948', '1947', '2014-05-18 13:33:42', NULL, 30000),
(80165, 20004, NULL, 10002, NULL, NULL, 'In which decade does the Indian Mutiny take place, work on the Suez Canal commences, and Louis Napoleon becomes Emperor Napoleon III?', '1850s', '1840s', '1830s', '1860s', '2014-05-18 13:33:42', NULL, 30000),
(80166, 20004, NULL, 10002, NULL, NULL, 'The American M4 tank was better known by a Generals name. What was it?', 'Sherman', 'Smith', 'Conrad', 'Beattie', '2014-05-18 13:33:42', NULL, 30000),
(80167, 20004, NULL, 10002, NULL, NULL, 'To which city was Tsar Nicholas II and his family taken to and executed in after the Russian Revolution?', 'Yekaterinburg', 'Chelyabinsk', 'Omsk', 'Tolyatti', '2014-05-18 13:33:42', NULL, 30000),
(80168, 20004, NULL, 10002, NULL, NULL, 'What did members of the Nazi SS have tattooed on their armpits?', 'Their blood group', 'Swastika', 'Lightning Bolts', 'The Eagle', '2014-05-18 13:33:42', NULL, 30000),
(80169, 20004, NULL, 10002, NULL, NULL, 'What did the 1936 Public Health Act say must be free for men that women could be charged to use?', 'Urinals', 'Contraceptives', 'Public Baths', 'Medical care', '2014-05-18 13:33:42', NULL, 30000),
(80170, 20004, NULL, 10002, NULL, NULL, 'What was found under the patio of 10 Brookside Close?', 'Trevor Jordache''s Body', 'Roman artefacts', 'First edition Beano comic', 'Shergar', '2014-05-18 13:33:42', NULL, 30000),
(80171, 20004, NULL, 10002, NULL, NULL, 'What was Papa Docs real name (president of Haiti)?', 'Dr Francois Duvalier', 'Jean Claude Duvalier', 'Prosper Avril', 'Herald Abraham', '2014-05-18 13:33:42', NULL, 30000),
(80172, 20004, NULL, 10002, NULL, NULL, 'What was the operation to liberate Kuwait in 1991 called?', 'Desert Storm', 'Desert Shield', 'Desert Fox', 'Desert Falcon', '2014-05-18 13:33:42', NULL, 30000),
(80173, 20004, NULL, 10002, NULL, NULL, 'Where was the ancient Kingdom of Iberia from where the Iberians in Spain probably came from?', 'Modern Georgia', 'Portugal', 'Greece', 'Norway', '2014-05-18 13:33:42', NULL, 30000),
(80174, 20004, NULL, 10002, NULL, NULL, 'Which Irish saint supposedly sailed to America in the sixth century?', 'Saint Brendan', 'Saint Adrian', 'Saint Francis', 'Saint Patrick', '2014-05-18 13:33:42', NULL, 30000),
(80175, 20004, NULL, 10002, NULL, NULL, 'Which two out of the 54 members of the Commonwealth of Nations have no historical connection with the UK?', 'Mozambique and Rwanda', 'Australia and New Zealand', 'Oman and Qatar', 'Pakistan and India', '2014-05-18 13:33:42', NULL, 30000),
(80176, 20004, NULL, 10002, NULL, NULL, 'Who banned Christmas in England from 1647 to 1660 and in Boston from 1659 to 1681?', 'Puritans', 'Atheists', 'King Charles II', 'Archbishop Gilbert Sheldon', '2014-05-18 13:33:42', NULL, 30000),
(80177, 20004, NULL, 10002, NULL, NULL, 'Who is the only American President to have served non-consecutive terms in office?', 'Grover Cleveland', 'James Madison', 'John Tyler', 'Gerald Ford', '2014-05-18 13:33:42', NULL, 30000),
(80178, 20004, NULL, 10002, NULL, NULL, 'Who was the American President at the start of the Vietnam war?', 'John F Kennedy', 'Eisenhower', 'Richard Nixon', 'Ronald Regan', '2014-05-18 13:33:42', NULL, 30000),
(80179, 20004, NULL, 10003, NULL, NULL, '’The War of Jenkins Ear’ was waged between which two countries?', 'Britain and Spain', 'Spain and Germany', 'Britain and France', 'Spain and France', '2014-05-18 13:33:42', NULL, 30000),
(80180, 20004, NULL, 10003, NULL, NULL, 'How many earths would fit inside the sun?', 'circa 1,000,000', 'circa 100', 'circa 10,000', 'circa 100,000', '2014-05-18 13:33:42', NULL, 30000),
(80181, 20004, NULL, 10003, NULL, NULL, 'In the Second World War, what was the British Free Corps?', 'British and Commonwealth volunteers in the Waffen-SS', 'No Tax', 'A Battleship', 'The Officers in Charge', '2014-05-18 13:33:42', NULL, 30000),
(80182, 20004, NULL, 10003, NULL, NULL, 'In which war did jet aircraft first fight each other?', 'The Korean War', 'Spanish Civil War', 'Second World War', 'First World War', '2014-05-18 13:33:42', NULL, 30000),
(80183, 20004, NULL, 10003, NULL, NULL, 'In which year does Lebanon become a republic, Hirohito becomes Emperor of Japan, and Britain is hit by a nine-day General Strike?', '1926', '1925', '1924', '1923', '2014-05-18 13:33:42', NULL, 30000),
(80184, 20004, NULL, 10003, NULL, NULL, 'The Nazi regime was the III Reich. Which was the first?', 'The Holy Roman Empire', 'The German Empire', 'The German Reich', 'The Tudors', '2014-05-18 13:33:42', NULL, 30000),
(80185, 20004, NULL, 10003, NULL, NULL, 'What is the meaning of the word ’Bolshevik’?', 'majority', 'altogether', 'separate', 'least', '2014-05-18 13:33:42', NULL, 30000),
(80186, 20004, NULL, 10003, NULL, NULL, 'What single creature did Professor Aharoni find in Syria in 1930 that is the direct ancestor of an estimated 50 million pets?', 'A hamster', 'White mouse', 'Albino milk snake', 'A gerbil', '2014-05-18 13:33:42', NULL, 30000),
(80187, 20004, NULL, 10003, NULL, NULL, 'What was adopted in the United States on June 14th 1777, and is celebrated every year on that day?', 'The flag of the United States', 'Independence Day', 'Thanksgiving', 'Washington Day', '2014-05-18 13:33:42', NULL, 30000),
(80188, 20004, NULL, 10003, NULL, NULL, 'What were Little Boy and Fat Man?', 'The two atom bombs dropped on Japan', 'Films During The 2nd World War', 'Two Warships', 'Carrier Planes during 1st World War', '2014-05-18 13:33:42', NULL, 30000),
(80189, 20004, NULL, 10003, NULL, NULL, 'When did the Euro banknotes and coins officially become currency in Europe?', '1 January 2002', '1 January 2001', '1 April 2002', '1 April 2001', '2014-05-18 13:33:42', NULL, 30000),
(80190, 20004, NULL, 10003, NULL, NULL, 'Which 20th century dictator ordered that all sparrows in the land be killed?', 'Mao Zedong', 'Adolf Hitler', 'Mobutu Sese Seko', 'Joseph Stalin', '2014-05-18 13:33:42', NULL, 30000),
(80191, 20004, NULL, 10003, NULL, NULL, 'Which two countries fought the Pastry War (La guerra de los pasteles) of 1838?', 'Mexico and France', 'Mexico and Portugal', 'France and Portugal', 'Mexico and Spain', '2014-05-18 13:33:42', NULL, 30000),
(80192, 20004, NULL, 10003, NULL, NULL, 'Which US President gave a plastic bust of himself as a Christmas gift to Pope Paul VI?', 'Lyndon B Johnson', 'Richard Nixon', 'Jimmy Carter', 'Ronald Regan', '2014-05-18 13:33:42', NULL, 30000),
(80193, 20004, NULL, 10004, NULL, NULL, 'Air Force One is the US Presidents plane. What is Marine One?', 'A helicopter', 'A Boat', 'Sports Car', 'Limousine', '2014-05-18 13:33:42', NULL, 30000),
(80194, 20004, NULL, 10004, NULL, NULL, 'Before the Euro, the Irish Punt was divided into 100 what?', 'Pence', 'Cents', 'Pounds', 'Shillings', '2014-05-18 13:33:42', NULL, 30000),
(80195, 20004, NULL, 10004, NULL, NULL, 'Christopher Columbus died on May 20, 1506 in which Spanish city?', 'Valladolid', 'Bilbao', 'Madrid', 'Seville', '2014-05-18 13:33:42', NULL, 30000),
(80196, 20004, NULL, 10004, NULL, NULL, 'From which country did Panama declare independence in 1903?', 'Colombia', 'Peru', 'Venezuela', 'Bolivia', '2014-05-18 13:33:42', NULL, 30000),
(80197, 20004, NULL, 10004, NULL, NULL, 'How British King Georges have there been?', '6', '5', '4', '7', '2014-05-18 13:33:42', NULL, 30000),
(80198, 20004, NULL, 10004, NULL, NULL, 'How many pennies were in a British pre-decimal pound?', '240', '200', '204', '120', '2014-05-18 13:33:42', NULL, 30000),
(80199, 20004, NULL, 10004, NULL, NULL, 'In which decade does the Battle of Wounded Knee take place, Marconi invent the wireless, and the Dreyfuss Affair take place in France?', '1890s', '1900s', '1880s', '1910s', '2014-05-18 13:33:42', NULL, 30000),
(80200, 20004, NULL, 10004, NULL, NULL, 'In which war did the Battle of Hamburger Hill take place?', 'The Vietnam War', 'The Spanish Civil War', 'The Gulf War', 'World War 1', '2014-05-18 13:33:42', NULL, 30000),
(80201, 20004, NULL, 10004, NULL, NULL, 'Sitting Bull belonged to which tribe?', 'Sioux', 'Mohican', 'Hopi People', 'Creek', '2014-05-18 13:33:42', NULL, 30000),
(80202, 20004, NULL, 10004, NULL, NULL, 'The Roman Appian Way went from Rome to where?', 'Brindisi', 'Lecce', 'Naples', 'Bari', '2014-05-18 13:33:42', NULL, 30000),
(80203, 20004, NULL, 10004, NULL, NULL, 'What was the code name for the American landings in Morocco in 1942?', 'Operation Torch', 'Operation Light', 'Operation fire', 'Operation Heat', '2014-05-18 13:33:42', NULL, 30000),
(80204, 20004, NULL, 10004, NULL, NULL, 'What was unusual about Khaled Ibrahim Tafeesh, who was running for election (for Hamas) in 2006?', 'He was in an Israeli prison', 'First Scientist to Run', 'First non-politician to run', 'He was in an Indian Prison', '2014-05-18 13:33:42', NULL, 30000),
(80205, 20004, NULL, 10004, NULL, NULL, 'What were the Janissaries?', 'Christian troops fighting for the Ottoman Empire', 'Catholic troops fighting the Romans', 'Christian troops fighting the Romans', 'Catholic troops fighting the Ottoman Empire', '2014-05-18 13:33:42', NULL, 30000),
(80206, 20004, NULL, 10004, NULL, NULL, 'Which battle does the French Foreign Legion celebrate every year?', 'Camerone', 'Fleurus', 'Genoa', 'Engen', '2014-05-18 13:33:42', NULL, 30000),
(80210, 20004, NULL, 10004, NULL, NULL, 'Who was the founder of Lotus Cars Ltd.?', 'Colin Chapman', 'Henry Ford', 'Ferdinand Porsche', 'Robert Bamford', '2014-05-18 13:33:42', NULL, 30000),
(80211, 20004, NULL, 10004, NULL, NULL, 'Who was the principle enemy to Athens in the Peloponnesian War?', 'Sparta', 'Macedonia', 'The French', 'The Romans', '2014-05-18 13:33:42', NULL, 30000),
(80212, 20005, NULL, 10000, NULL, NULL, 'How many legs (including arms or pincers according to certain definitions) does a crab have?', '10', '8', '6', '12', '2014-05-18 13:33:42', NULL, 30000),
(80213, 20005, NULL, 10000, NULL, NULL, 'How much does a cubic metre of water weigh?', 'One tonne', 'Half a Tonne', 'Three Tonne', 'One Metric Tonne', '2014-05-18 13:33:42', NULL, 30000),
(80214, 20005, NULL, 10000, NULL, NULL, 'In photography, what does SLR stand for?', 'Single lens reflex', 'Several Lens Reflex', 'Subtly Low Reflex', 'Single Low Reflex', '2014-05-18 13:33:42', NULL, 30000),
(80215, 20005, NULL, 10000, NULL, NULL, 'What did Foucault’s pendulum prove?', 'That the earth rotates', 'That the earth is not flat', 'The Laws of Physics', 'Laws Of Gravity', '2014-05-18 13:33:42', NULL, 30000),
(80216, 20005, NULL, 10000, NULL, NULL, 'What does DVD stand for?', 'Digital Versatile Disc', 'Digital Video Disc', 'Data Versatile Disc', 'Disc Video Data', '2014-05-18 13:33:43', NULL, 30000),
(80217, 20005, NULL, 10000, NULL, NULL, 'What is the angle between the hands of a clock at 1 o’clock?', '30 degrees', '45 degrees', '90 degrees', '180 degrees', '2014-05-18 13:33:43', NULL, 30000),
(80218, 20005, NULL, 10000, NULL, NULL, 'What is the atomic number of oxygen?', '8', '1', '35', '86', '2014-05-18 13:33:43', NULL, 30000),
(80219, 20005, NULL, 10000, NULL, NULL, 'What is the common name of the animal known as ’Vulpes Vulpes’?', 'Fox', 'Vulture', 'Gecko', 'A Bat', '2014-05-18 13:33:43', NULL, 30000),
(80220, 20005, NULL, 10000, NULL, NULL, 'What is the main gas (by volume) in car exhaust?', 'Nitrogen', 'Water Vapour', 'Carbon Dioxide', 'Carbon Monoxide', '2014-05-18 13:33:43', NULL, 30000),
(80221, 20005, NULL, 10000, NULL, NULL, 'What is the more usual name for Roentgen Rays?', 'X Rays', 'Gamma Rays', 'Ultraviolet Rays', 'Magnetic Resonance', '2014-05-18 13:33:43', NULL, 30000),
(80222, 20005, NULL, 10000, NULL, NULL, 'What medical condition gets its name from the Greek ’half a head’?', 'Migraine', 'Tumour', 'Parkinsons', 'Dementia', '2014-05-18 13:33:43', NULL, 30000),
(80223, 20005, NULL, 10000, NULL, NULL, 'What medical specialty studies the anatomy and physiology of the heart?', 'Cardiology', 'Corpus Daius', 'Neurology', 'Corpus Christi', '2014-05-18 13:33:43', NULL, 30000),
(80224, 20005, NULL, 10000, NULL, NULL, 'What was the name of the first spacecraft to land softly on the moon?', 'Luna 9', 'Surveyor 1', 'Luna 13', 'Apollo 11', '2014-05-18 13:33:43', NULL, 30000),
(80225, 20005, NULL, 10000, NULL, NULL, 'What was the number of the last Apollo mission?', '17', '14', '13', '22', '2014-05-18 13:33:43', NULL, 30000),
(80226, 20005, NULL, 10000, NULL, NULL, 'Which period came after the Triassic?', 'Jurassic', 'Cretaceous', 'Permian', 'Ordovician', '2014-05-18 13:33:43', NULL, 30000),
(80227, 20005, NULL, 10000, NULL, NULL, 'Who invented the Centigrade scale?', 'Anders Celsius', 'Soren Sorenson', 'Richard Salter', 'Phillip Mattha', '2014-05-18 13:33:43', NULL, 30000),
(80228, 20005, NULL, 10001, NULL, NULL, 'Besides humans, which are the only primates that live freely in Europe?', 'Barbary Macaques in Gibraltar', 'The Owl Monkey', 'Household Dogs', 'Apes', '2014-05-18 13:33:43', NULL, 30000),
(80229, 20005, NULL, 10001, NULL, NULL, 'Fredrick Sanger invented which life saver?', 'Insulin', 'Safety Pin', 'Inflatable Life Raft', 'Aspirin', '2014-05-18 13:33:43', NULL, 30000),
(80230, 20005, NULL, 10001, NULL, NULL, 'How many feet are in a furlong?', '660', '550', '440', '770', '2014-05-18 13:33:43', NULL, 30000),
(80231, 20005, NULL, 10001, NULL, NULL, 'Hypermetropic people are what?', 'far sighted', 'underfed', 'moody', 'obese', '2014-05-18 13:33:43', NULL, 30000),
(80232, 20005, NULL, 10001, NULL, NULL, 'On the moon, what colour is the sky?', 'Black', 'Blue', 'White', 'Red', '2014-05-18 13:33:43', NULL, 30000),
(80233, 20005, NULL, 10001, NULL, NULL, 'Riboflavin, Niacin, and Folic Acid are examples of what?', 'Vitamins', 'Chemicals', 'Acids', 'Alcohol', '2014-05-18 13:33:43', NULL, 30000),
(80234, 20005, NULL, 10001, NULL, NULL, 'What does a nidologist study?', 'Bird Nests', 'Clouds', 'Waves', 'Caves', '2014-05-18 13:33:43', NULL, 30000),
(80235, 20005, NULL, 10001, NULL, NULL, 'What is -459.7 Fahrenheit also known as?', 'Absolute Zero', 'Above Freezing', 'Room Temperature', 'Minus 10', '2014-05-18 13:33:43', NULL, 30000),
(80236, 20005, NULL, 10001, NULL, NULL, 'What is decompression sickness commonly known as?', 'The Bends', 'The Bug', 'The Bag', 'The Bulge', '2014-05-18 13:33:43', NULL, 30000),
(80237, 20005, NULL, 10001, NULL, NULL, 'What is known as the ’Golden Number’?', '1.618', '3.142', '7', '33?', '2014-05-18 13:33:43', NULL, 30000),
(80238, 20005, NULL, 10001, NULL, NULL, 'What is the only number known to be both the sum and product of its factors?', '4', '6', '8', '9', '2014-05-18 13:33:43', NULL, 30000),
(80239, 20005, NULL, 10001, NULL, NULL, 'What percentage of people can roll their tongue into a tube?', '65%', '2%', '14%', '25%', '2014-05-18 13:33:43', NULL, 30000),
(80240, 20005, NULL, 10001, NULL, NULL, 'What two time Nobel Prize winner was a proponent of Vitamin C?', 'Linus Pauling', 'Sir James W. Black', 'Joseph Brodsky', 'Ernst Ruska', '2014-05-18 13:33:43', NULL, 30000),
(80241, 20005, NULL, 10001, NULL, NULL, 'What type of animal are Belugas?', 'Whales', 'Monkey', 'Elephant', 'A Dog', '2014-05-18 13:33:43', NULL, 30000),
(80242, 20005, NULL, 10001, NULL, NULL, 'Which Apollo mission landed the first humans on the Moon?', 'Apollo 11', 'Apollo 9', 'Apollo 7', 'Apollo 13', '2014-05-18 13:33:43', NULL, 30000),
(80243, 20005, NULL, 10001, NULL, NULL, 'Which castle was the childhood home of Elizabeth Bowes-Lyon, the late Queen Mother?', 'Glamis Castle', 'Craigievar Castle', 'Invergarry Castle', 'Loch Leven Castle', '2014-05-18 13:33:43', NULL, 30000),
(80244, 20005, NULL, 10001, NULL, NULL, 'Which computer operating system has a penguin as its logo?', 'Linux', 'Android', 'BSD', 'QNX', '2014-05-18 13:33:43', NULL, 30000),
(80245, 20005, NULL, 10001, NULL, NULL, 'Which planet of the solar system has its 27 moons named after characters from the works of William Shakespeare and Alexander Pope?', 'Uranus', 'Jupiter', 'Saturn', 'Neptune', '2014-05-18 13:33:43', NULL, 30000),
(80246, 20005, NULL, 10001, NULL, NULL, 'Who won the 1954 Nobel Prize for Chemistry and the 1962 Nobel Peace Prize?', 'Linus Pauling', 'Patrick Maynard', 'Thomas Stearns Elliot', 'Sir Robert Robinson', '2014-05-18 13:33:43', NULL, 30000),
(80247, 20005, NULL, 10002, NULL, NULL, 'Anemophobia is the fear of what?', 'Wind', 'The Dark', 'Fire', 'Spiders', '2014-05-18 13:33:43', NULL, 30000),
(80248, 20005, NULL, 10002, NULL, NULL, 'In radio and television, among other things, what does UHF stand for?', 'Ultra High Frequency', 'Under High Frequency', 'Up High Frequency', 'Ultimate Higher Frequency', '2014-05-18 13:33:43', NULL, 30000),
(80249, 20005, NULL, 10002, NULL, NULL, 'In which year were Concorde planes retired from service?', '2003', '2000', '1998', '2006', '2014-05-18 13:33:43', NULL, 30000),
(80250, 20005, NULL, 10002, NULL, NULL, 'Parkesine and Bakelite were two early examples of what?', 'Synthetic plastic', 'Paracetamol', 'Polystyrene', 'ThermoMetal', '2014-05-18 13:33:43', NULL, 30000),
(80251, 20005, NULL, 10002, NULL, NULL, 'Referring to internet connections, what does ADSL mean?', 'Asymmetric Digital Subscriber Line', 'Adaptable Digital Subscriber Line', 'Audio Diverse Subscriber Line', 'Asymmetric Diverse Subscriber Line', '2014-05-18 13:33:43', NULL, 30000),
(80252, 20005, NULL, 10002, NULL, NULL, 'The Indian-Pacific train links the two oceans. Between which two cities does it run?', 'Perth and Sydney', 'Cairns and Melbourne', 'Perth and Brisbane', 'Sydney and Darwin', '2014-05-18 13:33:43', NULL, 30000),
(80253, 20005, NULL, 10002, NULL, NULL, 'What causes dimples?', 'Genetics', 'A forceps birth', 'Sex in the third trimester', 'In-vitro spasms', '2014-05-18 13:33:43', NULL, 30000),
(80254, 20005, NULL, 10002, NULL, NULL, 'What does IBM stand for?', 'International Business Machines', 'International Branch Machines', 'Interim Business Merchandise', 'International Branch Merchandise', '2014-05-18 13:33:43', NULL, 30000),
(80255, 20005, NULL, 10002, NULL, NULL, 'What is an eolic power station?', 'Wind powered', 'Water Powered', 'Light Powered', 'Nuclear Powered', '2014-05-18 13:33:43', NULL, 30000),
(80256, 20005, NULL, 10002, NULL, NULL, 'What is thanatosis?', 'Playing dead', 'A Disease of the Liver', 'Memory Loss', 'The study of Animals', '2014-05-18 13:33:43', NULL, 30000),
(80257, 20005, NULL, 10002, NULL, NULL, 'What is the most abundant chemical element in the earth’s atmosphere?', 'Hydrogen', 'Nitrogen', 'Oxygen', 'Carbon', '2014-05-18 13:33:43', NULL, 30000),
(80258, 20005, NULL, 10002, NULL, NULL, 'What type of grazing animal is an Onager?', 'The Onager', 'Red Kangaroo', 'Brachiosaurus', 'A Cow', '2014-05-18 13:33:43', NULL, 30000),
(80259, 20005, NULL, 10002, NULL, NULL, 'What was the smallest recorded waist measured on a living woman?', '38cm', '35cm', '32cm', '42cm', '2014-05-18 13:33:43', NULL, 30000),
(80260, 20005, NULL, 10002, NULL, NULL, 'Where is the hypocentre of an earthquake in relation to its epicentre?', 'Directly beneath it', 'Opposite it', 'Directly Above it', 'Where it Starts', '2014-05-18 13:33:43', NULL, 30000),
(80261, 20005, NULL, 10002, NULL, NULL, 'Which branch of physics deals with sound?', 'Acoustics', 'Medium', 'Vibration', 'Noise', '2014-05-18 13:33:43', NULL, 30000),
(80262, 20005, NULL, 10002, NULL, NULL, 'Which is the largest organ in the human body?', 'The skin', 'The Large Intestine', 'The Stomach', 'The Brain', '2014-05-18 13:33:43', NULL, 30000);
INSERT INTO `B_QUESTION` (`QUESTION_ID`, `CATEGORY_ID`, `SUB_CATEGORY_ID`, `DIFFICULTY_ID`, `LOCATION_ID`, `ERA_ID`, `QUESTION`, `CORRECT_ANSWER`, `WRONG_ANSWER_1`, `WRONG_ANSWER_2`, `WRONG_ANSWER_3`, `QUESTION_CREATED`, `CREATED_BY_USER`, `CREATED_BY_CLIENT`) VALUES
(80263, 20005, NULL, 10002, NULL, NULL, 'Which of these senses deteriorates first with age?', 'Smell', 'Sight', 'Hearing', 'Taste', '2014-05-18 13:33:43', NULL, 30000),
(80264, 20005, NULL, 10002, NULL, NULL, 'Which two planets do not have moons?', 'Mercury and Venus', 'Earth and Mars', 'Mars and Mercury', 'Venus and Saturn', '2014-05-18 13:33:43', NULL, 30000),
(80265, 20005, NULL, 10003, NULL, NULL, 'A radioactive isotope of Americium can be found in many homes and workplaces. Where?', 'Smoke detectors', 'Fire Extinguisher', 'Kettles', 'Carbon Monoxide Detector', '2014-05-18 13:33:43', NULL, 30000),
(80266, 20005, NULL, 10003, NULL, NULL, 'During which phase of the moon can a solar eclipse occur?', 'New moon', 'Half Moon', 'Waxing Crescent Moon', 'First Quarter Moon', '2014-05-18 13:33:43', NULL, 30000),
(80267, 20005, NULL, 10003, NULL, NULL, 'In which organ would you find the pineal gland?', 'The brain', 'Liver', 'The Bladder', 'Skin', '2014-05-18 13:33:43', NULL, 30000),
(80268, 20005, NULL, 10003, NULL, NULL, 'Strange, charm, up, down, top, and bottom are types of what?', 'Quarks', 'People', 'Pictures', 'Planets', '2014-05-18 13:33:43', NULL, 30000),
(80269, 20005, NULL, 10003, NULL, NULL, 'The bark of the Cinchona, historically known as Jesuits Bark or Peruvian Bark, was the original source of which drug?', 'Quinine', 'Aspirin', 'Penicillin', 'Heroin', '2014-05-18 13:33:43', NULL, 30000),
(80271, 20005, NULL, 10003, NULL, NULL, 'What is myrrh?', 'A resin', 'A Metal', 'A Water Substance', 'A gas', '2014-05-18 13:33:43', NULL, 30000),
(80272, 20005, NULL, 10003, NULL, NULL, 'What is panophobia or pantophobia?', 'Fear of everything', 'Fear Of Powder', 'Fear Of Suffering and Disease', 'Fear of Ice or Frost', '2014-05-18 13:33:43', NULL, 30000),
(80273, 20005, NULL, 10003, NULL, NULL, 'What is the more common name for dead keratinised cells which appear in the epidermis of mammals?', 'Hair', 'Dandruff', 'Freckles', 'Sun tan', '2014-05-18 13:33:43', NULL, 30000),
(80274, 20005, NULL, 10003, NULL, NULL, 'What is the name given to lines of equal underwater depth on maps?', 'Isobath', 'Parallel', 'Opisometer', 'Isodapane', '2014-05-18 13:33:43', NULL, 30000),
(80275, 20005, NULL, 10003, NULL, NULL, 'What lies above the troposphere?', 'The stratosphere', 'Space', 'Atmosphere', 'Mesosphere', '2014-05-18 13:33:43', NULL, 30000),
(80276, 20005, NULL, 10003, NULL, NULL, 'What number has the square root (to the nearest four decimal places) of 1.4142?', '2', '1', '3', '4', '2014-05-18 13:33:43', NULL, 30000),
(80277, 20005, NULL, 10003, NULL, NULL, 'What shape is the DNA molecule?', 'A double helix', 'A Single Helix', 'A Triple Helix', 'Twin Helix', '2014-05-18 13:33:43', NULL, 30000),
(80278, 20005, NULL, 10003, NULL, NULL, 'What sort of animal is a Rhodesian Ridgeback?', 'A dog', 'A Horse', 'A Wild Cat', 'A Pig', '2014-05-18 13:33:43', NULL, 30000),
(80279, 20005, NULL, 10003, NULL, NULL, 'What was the name of America’s first artificial satellite?', 'Explorer I', 'Friendship I', 'Ariel I', 'Gemini I', '2014-05-18 13:33:43', NULL, 30000),
(80280, 20005, NULL, 10003, NULL, NULL, 'Which metal do you get from bauxite?', 'Aluminium', 'Copper', 'Steel', 'Iron', '2014-05-18 13:33:43', NULL, 30000),
(80281, 20005, NULL, 10004, NULL, NULL, 'Evaporation is changing from a liquid to gas. What is changing from a solid to a gas called?', 'Sublimation', 'Stabilisation', 'Solidification', 'Condensate', '2014-05-18 13:33:43', NULL, 30000),
(80282, 20005, NULL, 10004, NULL, NULL, 'How many chromosome pairs are there in the Human genome?', '23', '46', '27', '14', '2014-05-18 13:33:43', NULL, 30000),
(80283, 20005, NULL, 10004, NULL, NULL, 'In Australia, what is a ’kylie’?', 'A boomerang or hunting stick', 'A Female Singer', 'A Kangaroo', 'Type Of Fruit', '2014-05-18 13:33:43', NULL, 30000),
(80284, 20005, NULL, 10004, NULL, NULL, 'In the Imperial Measurement system how many pounds are in a stone?', '14', '10', '16', '20', '2014-05-18 13:33:43', NULL, 30000),
(80285, 20005, NULL, 10004, NULL, NULL, 'What did Einstein get the Nobel Prize for?', 'The Photoelectric effect', 'Theoretical Physics', 'Medical Research', 'His Design of a Refrigerator', '2014-05-18 13:33:43', NULL, 30000),
(80286, 20005, NULL, 10004, NULL, NULL, 'What in radio does AM stand for?', 'Amplitude Modulation', 'Audible Mic', 'Audible Modulation', 'Amateur Modulation', '2014-05-18 13:33:43', NULL, 30000),
(80287, 20005, NULL, 10004, NULL, NULL, 'What is the SI unit of electrical current?', 'Ampere', 'Ammeter', 'Immersion', 'Ampacity', '2014-05-18 13:33:43', NULL, 30000),
(80288, 20005, NULL, 10004, NULL, NULL, 'What is Zulu time?', 'Universal Coordinated Time (UTC)', 'Daylight Saving Time (DST)', 'Greenwich Mean Time (GMT)', 'British Summer Time (BST)', '2014-05-18 13:33:43', NULL, 30000),
(80289, 20005, NULL, 10004, NULL, NULL, 'What sort of substances are adrenaline, cortisone, insulin, and oestrogens?', 'Hormones', 'Amphetamines', 'Barbiturates', 'Nerves', '2014-05-18 13:33:43', NULL, 30000),
(80290, 20005, NULL, 10004, NULL, NULL, 'Where in the human body do you find aqueous humour?', 'Eye', 'Elbow', 'Leg', 'Stomach', '2014-05-18 13:33:43', NULL, 30000),
(80291, 20005, NULL, 10004, NULL, NULL, 'Which Admiral has a wind speed scale named after him?', 'Sir Francis Beaufort', 'Yi Sun Shin', 'David Glasgow Farragut', 'Sir John Kelly', '2014-05-18 13:33:43', NULL, 30000),
(80292, 20005, NULL, 10004, NULL, NULL, 'Which gas has the chemical formula CO?', 'Carbon Monoxide', 'Water.', 'Carbon Dioxide', 'Cobalt', '2014-05-18 13:33:43', NULL, 30000),
(80293, 20005, NULL, 10004, NULL, NULL, 'Which kind of animal did Florence Nightingale often carry around in her pocket?', 'Owl', 'Puppy', 'Kitten', 'Snake', '2014-05-18 13:33:43', NULL, 30000),
(80294, 20005, NULL, 10004, NULL, NULL, 'Which unit of measurement was defined by Henry III of England by placing three barleycorns in a line?', 'An Inch', 'A Yard', 'A Foot', 'A Furlong', '2014-05-18 13:33:43', NULL, 30000),
(80295, 20006, NULL, 10000, NULL, NULL, 'What is the name of the fruit originally called Yang Tao in Southwest China, where it originates? There is a golden variety call Hinabelle.', 'Kiwi or Kiwifruit', 'Meyer Lemon', 'Yuzu', 'Apricot', '2014-05-18 13:33:43', NULL, 30000),
(80296, 20006, NULL, 10001, NULL, NULL, 'Mrs. Thomas Smith of Ryde, NSW, Australia, produced a new variety of fruit in 1868. What is it called?', 'The Granny Smith Apple', 'The Galia Melon', 'Orangetti Spaghetti Squash', 'Black Galaxy Tomato', '2014-05-18 13:33:43', NULL, 30000),
(80297, 20006, NULL, 10001, NULL, NULL, 'The Islamic and Jewish faiths outlaw the eating of which farm yard animal?', 'Pig', 'Horse', 'Cow', 'Duck', '2014-05-18 13:33:43', NULL, 30000),
(80298, 20006, NULL, 10001, NULL, NULL, 'What is the main spirit base of a classic Bloody Mary?', 'Vodka', 'Whiskey', 'Brandy', 'Tequila', '2014-05-18 13:33:43', NULL, 30000),
(80299, 20006, NULL, 10002, NULL, NULL, 'Angostura Bitters is produced from what?', 'Tree bark', 'Watermelon', 'Orange peel', 'The stamens of a crocus', '2014-05-18 13:33:43', NULL, 30000),
(80300, 20006, NULL, 10002, NULL, NULL, 'What was the name of the blind Benedictine monk who allegedly invented Champagne?', 'Dom Perignon', 'Adrian Urmanov', 'Brendan Smyth', 'Losang Samten', '2014-05-18 13:33:43', NULL, 30000),
(80301, 20006, NULL, 10002, NULL, NULL, 'Which edible bean produces the most flatulence?', 'Soya', 'Baked beans', 'Runner beans', 'Kidney beans', '2014-05-18 13:33:43', NULL, 30000),
(80302, 20007, NULL, 10000, NULL, NULL, 'Anna Pavlowa excelled in which of the following?', 'ballet', 'chess', 'painting', 'tennis', '2014-05-18 13:33:43', NULL, 30000),
(80303, 20007, NULL, 10002, NULL, NULL, 'What were the Stradivarius family famous for?', 'Violin & Cello makers', 'A Travelling Minstrels band', 'Court composers to the King of Italy', 'The development of Baroque music', '2014-05-18 13:33:43', NULL, 30000),
(80304, 20007, NULL, 10002, NULL, NULL, 'Which comic actor once coughed up the information, ’I never smoked a cigarette until I was nine’?', 'W C Fields', 'Stephen Fry', 'Hugh Laurie', 'Spike Milligan', '2014-05-18 13:33:43', NULL, 30000),
(80305, 20007, NULL, 10003, NULL, NULL, 'Which resident of 10 Downing Street confessed he would ’rather be at Twickenham’?', 'Denis Thatcher', 'Tony Blair', 'John Major', 'Gordon Brown', '2014-05-18 13:33:43', NULL, 30000),
(80306, 20007, NULL, 10003, NULL, NULL, 'Who succeeded Paul von Hindenburg as the German head of state?', 'Adolf Hitler', 'Walter Simons', 'Hans Luther', 'Karl Donitz', '2014-05-18 13:33:43', NULL, 30000),
(80308, 20007, NULL, 10003, NULL, NULL, 'Who was offered but declined the presidency of the State of Israel in 1952?', 'Albert Einstein', 'Marilyn Monroe', 'James Dean', 'Martin Luther King Jr', '2014-05-18 13:33:43', NULL, 30000),
(80309, 20007, NULL, 10003, NULL, NULL, 'Who was the first Prime Minister of the Soviet Union?', 'Vladimir Lenin', 'Boris Yeltsin', 'Joseph Stalin', 'Vyacheslav Molotov', '2014-05-18 13:33:43', NULL, 30000),
(80310, 20007, NULL, 10003, NULL, NULL, 'Who was the last British Prime Minister not to have a wife?', 'Margaret Thatcher', 'John Major', 'Harold Wilson', 'Winston Churchill', '2014-05-18 13:33:43', NULL, 30000),
(80311, 20007, NULL, 10003, NULL, NULL, 'Who was the penultimate King of Egypt?', 'King Farouk I', 'King Ahmed Fuad', 'King Ahmed Fuad II', 'Hussein Kamel', '2014-05-18 13:33:43', NULL, 30000),
(80312, 20007, NULL, 10004, NULL, NULL, 'Karol Wojtyla is better known under which name?', 'Pope John Paul II', 'Liberace', 'Carole King', 'Santa', '2014-05-18 13:33:43', NULL, 30000);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=90008 ;

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
(90007, 'joker', 2, 10000, 40032, '2014-05-18 15:28:28', '2014-05-18 15:29:53', 0, 30000);

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=110009 ;

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
(110008, NULL, 30000, '2014-05-18 15:28:23');

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
