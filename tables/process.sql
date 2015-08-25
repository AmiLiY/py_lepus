/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 5.6.24-log : Database - operations
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/*Table structure for table `process` */

DROP TABLE IF EXISTS `process`;

CREATE TABLE `process` (
  `host` varchar(40) DEFAULT NULL,
  `pid` int(10) DEFAULT NULL,
  `cpu` float(10,2) DEFAULT NULL,
  `memory` bigint(100) DEFAULT NULL,
  `cpu_times` float(10,2) DEFAULT NULL,
  `ppid` int(10) DEFAULT NULL,
  `username` varchar(20) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `cmd` varchar(100) DEFAULT NULL,
  `cmdline` mediumtext,
  `status` varchar(20) DEFAULT NULL,
  `tty` varchar(10) DEFAULT NULL,
  `num_threads` int(20) DEFAULT NULL,
  UNIQUE KEY `host` (`host`,`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
