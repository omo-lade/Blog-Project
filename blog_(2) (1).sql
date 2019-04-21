-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 20, 2019 at 04:01 PM
-- Server version: 10.1.28-MariaDB
-- PHP Version: 7.0.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `blog`
CREATE DATABASE IF NOT EXISTS `blog` DEFAULT CHARACTER SET latin1 COLLATE latin1_general_ci;
USE `blog`;

--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewAll` Begin
SELECT blogger.first_name, blogger.last_name, blogger.avatar_file, article.headline, article.text, comments.comment_text, tag.tag_name, image.image_file
FROM Article
INNER JOIN blogger
ON blogger.blogger_id = article.blogger_id
INNER JOIN comments
ON comments.comment_id = article.comment_id
inner join tag_article
on tag_article.article_id = article.article_id
inner join tag
on tag.tag_id = tag_article.tag_id
inner join image_article
on image_article.article_id = article.article_id
inner join image
on image.image_id = image_article.image_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewBlogger` (IN `p_first_name` VARCHAR(50))  BEGIN
SELECT blogger.first_name, blogger.first_name, blogger.avatar_file, article.headline, article.text, comments.comment_text, tag.tag_name, image.image_file
FROM Article
INNER JOIN comments
ON comments.comment_id = article.comment_id
inner join tag_article
on tag_article.article_id = article.article_id
inner join tag
on tag.tag_id = tag_article.tag_id
inner join image_article
on image_article.article_id = article.article_id
inner join image
on image.image_id = image_article.image_id
INNER JOIN blogger
ON blogger.blogger_id = article.blogger_id
where blogger.first_name = p_first_name;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ViewTag` (IN `TagName` VARCHAR(50))  BEgin
SELECT blogger.first_name, blogger.avatar_file, article.headline, article.text, comments.comment_text, tag.tag_name, image.image_file
FROM Article
INNER JOIN blogger
ON blogger.blogger_id = article.blogger_id
INNER JOIN comments
ON comments.comment_id = article.comment_id
inner join image_article
on image_article.article_id = article.article_id
inner join image
on image.image_id = image_article.image_id
inner join tag_article
on tag_article.article_id = article.article_id
inner join tag
on tag.tag_id = tag_article.tag_id
where tag.tag_name = TagName;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `article`
--

CREATE TABLE `article` (
  `article_id` int(11) NOT NULL,
  `blogger_id` int(11) NOT NULL,
  `comment_id` int(11) DEFAULT NULL,
  `headline` text COLLATE latin1_general_ci,
  `text` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `article`
--

INSERT INTO `article` (`article_id`, `blogger_id`, `comment_id`, `headline`, `text`) VALUES
(1, 1, 6, 'Cheese and Vegetable Muffins', 0x68747470733a2f2f64726976652e676f6f676c652e636f6d2f64726976652f752f302f666f6c646572732f3170354a4d75437a6a7446705351515a5f5a66666c4852774145554f5475595a78),
(2, 1, 4, 'Cheese and Vegetable Muffins', 0x3c21444f43545950452068746d6c3e0d0a3c68746d6c3e0d0a202020203c686561643e0d0a20202020202020203c7469746c653e464f4f443c2f7469746c653e0d0a20202020202020203c6d65746120636861727365743d225554462d38223e0d0a202020202020202020200d0a3c7374796c653e0d0a7461626c65207b0d0a2020666f6e742d66616d696c793a20617269616c2c2073616e732d73657269663b0d0a2020626f726465722d636f6c6c617073653a20636f6c6c617073653b0d0a202077696474683a203430253b0d0a7d0d0a0d0a74642c207468207b0d0a2020626f726465723a2031707820736f6c696420236464646464643b0d0a2020746578742d616c69676e3a206c6566743b0d0a202070616464696e673a203870783b0d0a7d0d0a0d0a74723a6e74682d6368696c64286576656e29207b0d0a20206261636b67726f756e642d636f6c6f723a20236464646464643b0d0a7d0d0a3c2f7374796c653e0d0a3c2f686561643e0d0a3c626f64793e0d0a0d0a20202020203c68313e43686565736520616e6420566567657461626c65204d756666696e733c2f68313e0d0a20202020202020203c68333e48656c6c6f2053756d6d6572213c2f68333e0d0a20202020202020203c703e0d0a20202020202020202020202057652068617665206265656e207175697465206c75636b7920746f206861766520736f6d652073756e6e79207765617468657220696e20746865206c61737420666577206461797320616e64204920616d206a757374206c6f6f6b696e6720666f727761726420746f206d6f7265206f662069742e20497420697320717569746520706c656173616e7420617420746865206d6f6d656e742c20627574204920616d207375726520647572696e67207065616b204a756c792d4175677573742c20697420697320676f696e6720746f207377656c746572696e67210d0a20202020202020203c2f703e0d0a20202020202020203c703e0d0a2020202020202020202020205768656e206974e2809973207761726d20616e642073756e6e79206f7574736964652c204920646f6ee2809974206c696b652073746179696e6720696e646f6f727320616e64207370656e642061206c6f74206f662074696d6520696e206120686f74206b69746368656e2e204920726174686572207370656e64206d6f7374206f66206d792074696d65206f7574207370656e64696e672074696d652077697468206d792066616d696c7920616e6420656e6a6f79696e67207468652073756e2028776869636820776520676574206f6e6c7920666f7220612073686f727420706572696f64206f662074696d65206865726520696e20554b21292e2057652074656e6420746f20676f206f757420746f207061726b732c2068617665207069636e6963732c2068696b696e6720616e6420646f696e67206c6f7473206f66206f7574646f6f7273792073747566662c20707265747479206d7563682065766572797468696e672074686174206d79206368696c6472656e206c696b652e20416e6420617320776520617265206f6e20746865206d6f7665206d6f7374206f66207468652074696d652c20706f727461626c6520666f6f642c20746861742063616e20626520656174656e20686f74206f7220636f6c642c206265636f6d65732061206d75737420686176652e20536f6d657468696e6720746861742065766572796f6e6520656e6a6f797320656174696e672c206368696c6472656e20616e642067726f776e75707320616c696b652e0d0a20202020202020203c2f703e0d0a20202020202020203c703e0d0a2020202020202020202054686973207265636970652c2043686565736520616e6420566567657461626c65204d756666696e732c20697320612077696e6e657220696e206f75722066616d696c792061732069742069732073696d706c652c206865616c7468792c207061636b6564206f66206865616c7468792070726f7465696e20616e6420766567657461626c657320616e64207375706572206561737920746f206d616b652e20416e64207468652062657374207468696e672069732c20697420697320706f636b657420667269656e646c792c2063616e206265206d616465207769746820776861746576657220766567657461626c657320796f75206861766520617420686f6d6520616e642063616e20626520656174656e20686f74206f7220636f6c642e204974206b656570732077656c6c20666f72206c6f6e67207768656e206b65707420696e206120636f6f6c65722e205765206c696b6520746f2065617420697420666f72206c756e63682c206275742069732070657266656374206173206120736e61636b2c206f7220666f72206c756e6368626f7865732e20536f2c20746865726520796f7520676f2120200d0a20202020202020203c2f703e0d0a20202020202020203c6120687265663d22223e3c696d67207372633d2222207374796c653d2277696474683a31303025223e3c2f613e203c212d2d20496d61676520312073686f756c6420676f20686572652d2d3e0d0a20202020202020203c62723e3c62723e3c62723e3c62723e0d0a20202020200d0a3c7461626c653e0d0a20203c74723e0d0a202020203c74683e496e6772656469656e74733c2f74683e0d0a202020203c74683e5175616e746974793c2f74683e0d0a202020200d0a20203c2f74723e0d0a20203c74723e0d0a202020203c74643e53656c662072616973696e6720466c6f75723c2f74643e0d0a202020203c74643e3220437570733c2f74643e0d0a202020200d0a20203c2f74723e0d0a20203c74723e0d0a202020203c74643e0d0a4d6978206f6620566567657461626c65732c20636f617273656c7920677261746564202849207573656420636f757267657474652c20436172726f74732c20537765657420436f726e2c205370696e6163682c204f6e696f6e73293c2f74643e0d0a202020203c74643e3320437570733c2f74643e0d0a202020200d0a20203c2f74723e0d0a20203c74723e0d0a202020203c74643e506172736c6579202d2043686f707065643c2f74643e0d0a202020203c74643e48616e6466756c3c2f74643e0d0a202020200d0a20203c2f74723e0d0a20203c74723e0d0a202020203c74643e43686564646172204368656573653c2f74643e0d0a202020203c74643e31c2bd204375703c2f74643e0d0a2020200d0a20203c2f74723e0d0a20203c74723e0d0a202020203c74643e4d696c6b3c2f74643e0d0a202020203c74643e31c2bd204375703c2f74643e0d0a202020200d0a20203c2f74723e0d0a20203c74723e0d0a202020203c74643e456767733c2f74643e0d0a202020203c74643e33204d656469756d3c2f74643e0d0a2020200d0a20203c2f74723e0d0a20200d0a20200d0a20203c74723e0d0a202020203c74643e4275747465722c206d656c74656420616e6420636f6f6c65643c2f74643e0d0a202020203c74643e3530204772616d733c2f74643e0d0a2020200d0a20203c2f74723e0d0a20203c2f7461626c653e0d0a20203c68343e4d6574686f643c2f68343e0d0a20200d0a20203c703e200d0a202020202050726568656174206f76656e2061742031383020c2b0432f313630c2b0432066616e2061737369737465642e2047726561736520616e64206475737420612031322063757073206d756666696e20747261792e2020496e2061206c61726765206d6978696e6720626f776c2c2074616b652074686520666c6f757220616e64206d69782074686520766567657461626c657320616e64206368656573652e20536561736f6e2077656c6c2e20506c65617365206265206361726566756c2077697468207468652073616c742061732074686572652077696c6c20626520736f6d6520696e207468652063686565736520616e642062757474657220746f6f2e204d69782077656c6c2e20496e20616e6f7468657220626f776c2c20626561742065676773206c696768746c7920616e64207468656e20616464206d696c6b20616e642062757474657220616e6420776869736b2077656c6c2e2020506f757220746865206c6971756964206d69787475726520696e2074686520666c6f7572206d69787475726520616e64206d69782067656e746c7920756e74696c20696e636f72706f72617465642e2020446976696465206576656e6c7920696e20746865206d756666696e207472617920616e642062616b652032352d3330206d696e7574657320756e74696c20676f6c64656e2062726f776e20616e642074686520746f6f74687069636b20636f6d65206f757420636c65616e207768656e20696e73657274656420696e207468652063656e7472652e20204c657420697420636f6f6c20696e20746865207472617920666f722061626f75742035206d696e75746573206166746572207768696368207475726e206974206f7574206f6e2074686520636f6f6c696e67207261636b20756e74696c20636f6f6c2e205468657365207361766f757279206d756666696e7320667265657a652077656c6c20616e6420796f752063616e206861766520616e7920766172696174696f6e206f6620766567657461626c65206f72206d656174206f6620796f75722063686f6963652e20546869732072656369706520686173206265656e20612066616d696c79206661766f757269746520616e64206f7574207069636e69637320617265206e6576657220776974686f7574207468656d21204920616d207375726520746865792077696c6c20626520796f75727320746f6f2c20486170707920436f6f6b696e67210d0a20203c2f703e0d0a20203c6120687265663d22223e3c696d67207372633d2222207374796c653d2277696474683a31303025223e3c2f613e203c212d2d20496d61676520322073686f756c6420676f20686572652d2d3e0d0a20203c6120687265663d22223e3c696d67207372633d2222207374796c653d2277696474683a31303025223e3c2f613e203c212d2d20496d61676520332073686f756c6420676f20686572652d2d3e0d0a20200d0a20203c68343e2353756d6d6572323031393c62723e736e61636b732c20656173792c206275646765743c2f68343e0d0a0d0a203c2f626f64793e0d0a3c2f68746d6c3e);

-- --------------------------------------------------------

--
-- Table structure for table `blogger`
--

CREATE TABLE `blogger` (
  `blogger_id` int(11) NOT NULL,
  `first_name` varchar(10) COLLATE latin1_general_ci NOT NULL,
  `last_name` varchar(20) COLLATE latin1_general_ci NOT NULL,
  `logo_file` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `avatar_file` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `signature_file` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `Password` char(60) COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `blogger`
--

INSERT INTO `blogger` (`blogger_id`, `first_name`, `last_name`, `logo_file`, `avatar_file`, `signature_file`, `Password`) VALUES
(1, 'Omolade', 'Ojo', 'https://drive.google.com/drive/u/0/folders/1vKSpBXJf7ByIZPGkvuYXIi5THfJFYOzY', 'https://drive.google.com/drive/u/0/folders/1vKSpBXJf7ByIZPGkvuYXIi5THfJFYOzY', 'https://docs.google.com/document/d/14Xy0bdI2LHs93o1CiAzKv_K92oTyC2-X4GcPNYCr-dI/edit', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `comment_id` int(11) NOT NULL,
  `comment_text` text COLLATE latin1_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`comment_id`, `comment_text`) VALUES
(1, 'What great tips to save money!'),
(2, 'This is such a classic fashion look!'),
(3, 'This looks delicious! Can you substitue the flour for a gluten free one?'),
(4, 'What interesting analysis! What other poems would you say is similar to The Waste Land?'),
(5, 'This review sounds great, is it suitable for all ages?'),
(6, 'This looks like such a healthy treat! What a good idea');

-- --------------------------------------------------------

--
-- Table structure for table `image`
--

CREATE TABLE `image` (
  `image_id` int(11) NOT NULL,
  `image_file` varchar(100) COLLATE latin1_general_ci DEFAULT NULL
  `cover` BOOLEAN COLLATE latin1_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `image`
--

INSERT INTO `image` (`image_id`, `image_file`) VALUES
(1, ' <a href= https://www.pinterest.co.uk/pin/723109283899738394/>'),
(2, '<a href= https://www.pinterest.co.uk/pin/723109283899738355/>'),
(3, '<a href= https://www.pinterest.co.uk/pin/723109283899738604/>'),
(4, '<a href= https://www.pinterest.co.uk/pin/723109283899738596/>'),
(5, '<a href= https://www.pinterest.co.uk/pin/723109283899738307/>'),
(6, '<a href= https://www.pinterest.co.uk/pin/723109283899738287/>'),
(7, '<a href= https://www.pinterest.co.uk/pin/723109283899738325/>'),
(8, '<a href = https://www.pinterest.co.uk/pin/723109283899738269/>'),
(9, '<a href= https://www.pinterest.co.uk/pin/723109283899738342/>'),
(10, '<a href= https://www.pinterest.co.uk/pin/723109283899738233/>');

-- --------------------------------------------------------

--
-- Table structure for table `image_article`
--

CREATE TABLE `image_article` (
  `article_id` int(11) NOT NULL,
  `image_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `image_article`
--

INSERT INTO `image_article` (`article_id`, `image_id`) VALUES
(1, 3),
(2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` int(11) NOT NULL,
  `name` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `price` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `price`) VALUES
(30, 'test', '66.00'),
(36, 'KopB', '2.00'),
(39, 'Bourneville', '4.44'),
(40, 'testZZZ', '16.00'),
(41, 'testabc', '1234.00'),
(42, 'testabc', '1234.00'),
(43, 'Test123', '5.00');

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `tag_id` int(11) NOT NULL,
  `tag_name` varchar(50) COLLATE latin1_general_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `tag`
--

INSERT INTO `tag` (`tag_id`, `tag_name`) VALUES
(1, 'Food'),
(2, 'Fashion'),
(3, 'Theatre'),
(4, 'Tips'),
(5, 'Literature');

-- --------------------------------------------------------

--
-- Table structure for table `tag_article`
--

CREATE TABLE `tag_article` (
  `tag_id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `tag_article`
--

INSERT INTO `tag_article` (`tag_id`, `article_id`) VALUES
(1, 1),
(1, 2);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `article`
--
ALTER TABLE `article`
  ADD PRIMARY KEY (`article_id`),
  ADD KEY `comment_id` (`comment_id`),
  ADD KEY `FK_blogger_id` (`blogger_id`);

--
-- Indexes for table `blogger`
--
ALTER TABLE `blogger`
  ADD PRIMARY KEY (`blogger_id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`comment_id`);

--
-- Indexes for table `image`
--
ALTER TABLE `image`
  ADD PRIMARY KEY (`image_id`);

--
-- Indexes for table `image_article`
--
ALTER TABLE `image_article`
  ADD KEY `FK_image_id` (`image_id`),
  ADD KEY `FK_article_id` (`article_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`tag_id`);

--
-- Indexes for table `tag_article`
--
ALTER TABLE `tag_article`
  ADD KEY `FK_tag_id` (`tag_id`),
  ADD KEY `FK_article_id2` (`article_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `article`
--
ALTER TABLE `article`
  MODIFY `article_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `blogger`
--
ALTER TABLE `blogger`
  MODIFY `blogger_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `comment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `image`
--
ALTER TABLE `image`
  MODIFY `image_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `tag_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `article`
--
ALTER TABLE `article`
  ADD CONSTRAINT `FK_blogger_id` FOREIGN KEY (`blogger_id`) REFERENCES `blogger` (`blogger_id`),
  ADD CONSTRAINT `article_ibfk_1` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`),
  ADD CONSTRAINT `blogger_id` FOREIGN KEY (`blogger_id`) REFERENCES `blogger` (`blogger_id`),
  ADD CONSTRAINT `comment_id` FOREIGN KEY (`comment_id`) REFERENCES `comments` (`comment_id`);

--
-- Constraints for table `image_article`
--
ALTER TABLE `image_article`
  ADD CONSTRAINT `FK_article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`),
  ADD CONSTRAINT `FK_image_id` FOREIGN KEY (`image_id`) REFERENCES `image` (`image_id`);

--
-- Constraints for table `tag_article`
--
ALTER TABLE `tag_article`
  ADD CONSTRAINT `FK_article_id2` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`),
  ADD CONSTRAINT `FK_tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`),
  ADD CONSTRAINT `article_id` FOREIGN KEY (`article_id`) REFERENCES `article` (`article_id`),
  ADD CONSTRAINT `tag_id` FOREIGN KEY (`tag_id`) REFERENCES `tag` (`tag_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
