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
/*Table structure for table `admin_menu` */

DROP TABLE IF EXISTS `admin_menu`;

CREATE TABLE `admin_menu` (
  `menu_id` smallint(4) NOT NULL AUTO_INCREMENT,
  `menu_title` varchar(30) NOT NULL,
  `menu_level` tinyint(2) NOT NULL DEFAULT '0',
  `parent_id` tinyint(2) NOT NULL,
  `menu_url` varchar(255) DEFAULT NULL,
  `menu_icon` varchar(50) DEFAULT NULL,
  `system` tinyint(2) NOT NULL DEFAULT '0',
  `status` tinyint(2) NOT NULL DEFAULT '1',
  `display_order` smallint(4) NOT NULL DEFAULT '0',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;

/*Data for the table `admin_menu` */

insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (3,'MySQL Monitor',1,0,'/lp_mysql','icon-dashboard',0,1,3,'2014-02-25 19:57:29');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (5,'Permission System',1,0,'/rabc','icon-legal',0,1,10,'2014-02-26 12:24:33');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (6,'Health Monitor',2,3,'/lp_mysql/index',' icon-list',0,1,1,'2014-02-26 12:25:15');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (8,'Replication Monitor',2,3,'/lp_mysql/replication',' icon-list',0,1,6,'2014-02-26 12:26:05');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (9,'Slowquery Analysis',2,3,'/lp_mysql/slowquery','icon-list',0,1,9,'2014-02-26 12:26:52');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (10,'User',2,5,'/user/index','',0,1,1,'2014-02-26 12:43:02');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (11,'Role',2,5,'/role/index','',0,1,2,'2014-02-26 12:43:19');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (12,'Menu',2,5,'/menu/index','',0,1,3,'2014-02-26 12:43:41');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (13,'Privilege',2,5,'/privilege/index','',0,1,4,'2014-02-26 12:45:01');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (15,'Authorization',2,5,'/auth/index','',0,1,2,'2014-03-03 22:23:28');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (16,'Servers Configure',1,0,'/server','icon-dashboard',0,1,2,'2014-03-05 18:31:17');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (18,'MySQL',2,16,'/servers_mysql/index','icon-list',0,1,3,'2014-03-05 18:33:40');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (19,'AWR Report',2,3,'/lp_mysql/awrreport','icon-list',0,1,12,'2014-03-06 13:47:17');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (20,'Alarm Panel',1,0,'/alarm','icon-dashboard',0,1,9,'2014-03-11 21:41:13');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (21,'Alarm List',2,20,'/alarm/index','',0,1,0,'2014-03-11 21:46:28');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (22,'OS Monitor',1,0,'/lp_os','icon-dashboard',0,1,8,'2014-03-24 15:33:42');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (26,'Disk',2,22,'/lp_os/disk','icon-list',0,1,4,'2014-03-24 17:46:29');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (28,'BigTable Analysis',2,3,'/lp_mysql/bigtable','icon-list',0,1,7,'2014-04-02 13:38:15');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (29,'Key Cache Monitor',2,3,'/lp_mysql/key_cache','icon-list',0,1,3,'2014-04-09 15:52:12');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (30,'InnoDB Monitor',2,3,'/lp_mysql/innodb','icon-list',0,1,4,'2014-04-09 15:54:47');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (31,'Resource Monitor',2,3,'/lp_mysql/resource','icon-list',0,1,2,'2014-04-10 13:23:06');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (32,'MongoDB',2,16,'/servers_mongodb/index','icon-list',0,1,5,'2014-04-14 12:26:35');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (33,'MongoDB Monitor',1,0,'/lp_mongodb','icon-dashboard',0,1,5,'2014-04-14 14:15:52');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (34,'Health Montior',2,33,'/lp_mongodb/index','icon-list',0,1,1,'2014-04-14 14:17:23');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (35,'Indexes Monitor',2,33,'/lp_mongodb/indexes','icon-list',0,1,2,'2014-04-14 16:25:48');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (36,'Memory Monitor',2,33,'/lp_mongodb/memory','icon-list',0,1,3,'2014-04-14 16:26:50');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (40,'Oracle',2,16,'/servers_oracle/index','icon-list',0,1,4,'2014-05-27 13:21:49');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (43,'Health Monitor',2,22,'/lp_os/index','icon-list',0,1,0,'2014-07-08 09:19:11');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (44,'Disk IO',2,22,'/lp_os/disk_io','icon-list',0,1,5,'2014-07-15 15:35:56');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (45,'OS',2,16,'/servers_os/index','icon-list',0,1,8,'2014-07-16 10:32:13');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (46,'Settings',2,16,'/settings/index','icon-list',0,1,0,'2014-08-12 15:30:54');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (48,'Redis Monitor',1,0,'/lp_redis','icon-dashboard',0,1,6,'2014-09-02 12:36:41');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (50,'Health Monitor',2,48,'/lp_redis/index','icon-list',0,1,2,'2014-09-02 12:39:58');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (51,'Redis',2,16,'/servers_redis/index','icon-list',0,1,6,'2014-09-09 17:15:41');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (52,'Memory Monitor',2,48,'/lp_redis/memory','icon-list',0,1,3,'2014-09-11 14:34:13');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (54,'Replication Monitor',2,48,'/lp_redis/replication','icon-list',0,0,5,'2014-09-11 14:37:12');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (56,'Oracle Monitor',1,0,'/lp_oracle','icon-dashboard',0,1,4,'2014-10-24 15:34:50');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (57,'Health Montior',2,56,'/lp_oracle/index','icon-list',0,1,1,'2014-10-24 15:35:47');
insert  into `admin_menu`(`menu_id`,`menu_title`,`menu_level`,`parent_id`,`menu_url`,`menu_icon`,`system`,`status`,`display_order`,`create_time`) values (58,'Tablespace Monitor',2,56,'/lp_oracle/tablespace','icon-list',0,1,2,'2014-10-24 15:37:19');

/*Table structure for table `admin_privilege` */

DROP TABLE IF EXISTS `admin_privilege`;

CREATE TABLE `admin_privilege` (
  `privilege_id` smallint(4) NOT NULL AUTO_INCREMENT,
  `privilege_title` varchar(30) DEFAULT NULL,
  `menu_id` smallint(4) DEFAULT NULL,
  `action` varchar(100) DEFAULT NULL,
  `display_order` smallint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`privilege_id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

/*Data for the table `admin_privilege` */

insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (1,'MySQL Health Monitor',6,'lp_mysql/index',1);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (3,'MySQL Replication Monitor',8,'lp_mysql/replication',2);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (4,'MySQLSlowQuery',9,'lp_mysql/slowquery',4);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (6,'Admin User View',10,'user/index',52);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (7,'Admin User Add ',10,'user/add',52);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (8,'Admin User Edit',10,'user/edit',53);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (9,'Admin User Delete',10,'user/forever_delete',54);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (10,'Admin Role View',11,'role/index',61);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (11,'Admin Role Add',11,'role/add',62);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (12,'Admin Role Edit',11,'role/edit',63);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (13,'Admin Role Delete',11,'role/forever_delete',64);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (14,'Admin Menu View',12,'menu/index',71);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (15,'Admin Menu Add',12,'menu/add',72);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (16,'Admin Menu Edit',12,'menu/edit',73);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (17,'Admin Menu Delete',12,'menu/forever_delete',74);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (18,'Admin Privilege View',13,'privilege/index',81);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (19,'Admin Privilege Add',13,'privilege/add',82);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (20,'Admin Privilege Edit',13,'privilege/edit',83);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (21,'Admin Privilege Delete',13,'privilege/forever_delete',84);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (22,'Admin Auth View',15,'auth/index',91);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (23,'Admin Role Privilege Update',15,'auth/update_role_privilege',92);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (24,'Login System',0,'index/index',0);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (25,'Admin User Role Update',13,'auth/update_user_role',93);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (31,'MySQL Servers View',18,'servers_mysql/index',36);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (32,'MySQL Servers Add',18,'servers_mysql/add',37);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (33,'MySQL Servers Edit',18,'servers_mysql/edit',38);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (34,'MySQL Servers Trash',18,'servers_mysql/trash',39);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (35,'MySQL Servers Delete',18,'servers_mysql/delete',40);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (36,'MySQLSlowQuery Detail',9,'lp_mysql/slowquery_detail',4);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (37,'MySQL AWR Report',19,'lp_mysql/awrreport',5);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (38,'MySQL Health Chart',6,'lp_mysql/chart',1);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (39,'MySQL Replication Chart',8,'lp_mysql/replication_chart',2);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (40,'Alarm View',21,'alarm/index',8);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (41,'OS Health View',43,'lp_os/index',100);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (44,'OS Disk View',26,'lp_os/disk',100);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (46,'OS Disk Chart View',26,'lp_os/disk_chart',100);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (48,'OS Health Chart View',43,'lp_os/chart',100);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (49,'MySQL BigTable Analysis',28,'lp_mysql/bigtable',8);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (50,'MySQL BigTable Analysis Chart',28,'lp_mysql/bigtable_chart',8);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (51,'MySQL Key Cache Monitor',29,'lp_mysql/key_cache',2);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (52,'MySQL InnoDB Monitor',30,'lp_mysql/innodb',2);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (53,'MySQL Resource Monitor',31,'lp_mysql/resource',2);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (54,'MongoDB Servers View',32,'servers_mongodb/index',42);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (55,'MongoDB Servers Add',32,'servers_mongodb/add',43);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (56,'MongoDB Servers Edit',32,'servers_mongodb/edit',44);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (57,'MongoDB Servers Trash',32,'servers_mongodb/trash',44);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (58,'MongoDB Servers Delete',32,'servers_mongodb/delete',44);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (59,'MongoDB Health View',34,'lp_mongodb/index',10);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (60,'MongoDB Indexes View',35,'lp_mongodb/indexes',11);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (61,'MongoDB Memory View',36,'lp_mongodb/memory',12);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (67,'Oracle Servers View',40,'servers_oracle/index',45);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (68,'Oracle Servers Add',40,'servers_oracle/add',46);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (69,'Oracle Servers Edit',40,'servers_oracle/edit',47);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (76,'Mongodb Health Chart View',34,'lp_mongodb/chart',13);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (77,'OS Disk View',44,'lp_os/disk_io',100);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (78,'OS Disk Chart View',44,'lp_os/disk_io_chart',100);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (79,'OS Servers View',45,'servers_os/index',50);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (80,'OS  Servers Add',45,'servers_os/add',50);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (81,'OS Servers Edit',45,'servers_os/edit',50);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (82,'OS Servers Delete',45,'servers_os/delete',50);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (83,'OS Servers Trash',45,'servers_os/trash',50);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (84,'OS Servers Batch Add',45,'servers_os/batch_add',50);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (85,'MongoDB Servers Batch Add',32,'servers_mongodb/batch_add',44);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (86,'MySQL Servers Batch Add',18,'servers_mysql/batch_add',40);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (87,'Settings View',46,'settings/index',30);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (92,'Redis Health View',50,'lp_redis/index',19);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (93,'Redis Health Chart View',50,'lp_redis/chart',20);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (94,'Redis Servers View',51,'servers_redis/index',51);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (95,'Redis Servers Add',51,'servers_redis/add',51);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (96,'Redis Servers Edit',51,'servers_redis/edit',51);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (97,'Redis Servers Trash',51,'servers_redis/trash',51);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (98,'Redis Servers Delete',51,'servers_redis/delete',51);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (99,'Redis Servers Batch Add',51,'servers_redis/batch_add',51);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (100,'Redis Memory View',52,'lp_redis/memory',21);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (101,'Redis Memory Chart View',52,'lp_redis/memory_chart',21);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (104,'Redis Replication View',54,'lp_redis/replication',23);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (105,'Redis Replication Chart View',54,'lp_redis/replication_chart',23);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (110,'Oracle Health Monitor',57,'lp_oracle/index',25);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (111,'Oracle Health Chart',57,'lp_oracle/chart',26);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (112,'Oracle Tablespace Monitor',58,'lp_oracle/tablespace',27);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (113,'Settings Save',46,'settings/save',31);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (114,'Oracle Servers Trash',40,'servers_oracle/trash',48);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (115,'Oracle Servers Delete',40,'servers_oracle/delete',48);
insert  into `admin_privilege`(`privilege_id`,`privilege_title`,`menu_id`,`action`,`display_order`) values (116,'Oracle Servers Batch Add',40,'servers_oracle/batch_add',48);

/*Table structure for table `admin_role` */

DROP TABLE IF EXISTS `admin_role`;

CREATE TABLE `admin_role` (
  `role_id` smallint(6) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `admin_role` */

insert  into `admin_role`(`role_id`,`role_name`) values (1,'Administrator');
insert  into `admin_role`(`role_id`,`role_name`) values (3,'IT-DBA');
insert  into `admin_role`(`role_id`,`role_name`) values (5,'IT-Developer');
insert  into `admin_role`(`role_id`,`role_name`) values (7,'guest_group');

/*Table structure for table `admin_role_privilege` */

DROP TABLE IF EXISTS `admin_role_privilege`;

CREATE TABLE `admin_role_privilege` (
  `role_id` smallint(4) NOT NULL,
  `privilege_id` smallint(4) NOT NULL,
  PRIMARY KEY (`role_id`,`privilege_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `admin_role_privilege` */

insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,1);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,3);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,4);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,6);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,7);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,8);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,9);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,10);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,11);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,12);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,13);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,14);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,15);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,16);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,17);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,18);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,19);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,20);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,21);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,22);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,23);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,24);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,25);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,31);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,32);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,33);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,34);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,35);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,36);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,37);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,38);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,39);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,40);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,41);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,44);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,46);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,48);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,49);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,50);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,51);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,52);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,53);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,54);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,55);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,56);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,57);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,58);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,59);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,60);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,61);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,67);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,68);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,69);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,76);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,77);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,78);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,79);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,80);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,81);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,82);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,83);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,84);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,85);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,86);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,87);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,92);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,93);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,94);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,95);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,96);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,97);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,98);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,99);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,100);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,101);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,104);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,105);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,110);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,111);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,112);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,113);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,114);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,115);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (1,116);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (2,4);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,1);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,2);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,3);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,4);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,6);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,7);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,8);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,9);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,10);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,11);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,12);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,13);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,14);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,15);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,16);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,17);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,18);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,19);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,20);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,21);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,22);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,23);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,24);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,25);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,26);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,27);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,28);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,29);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,30);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,31);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,32);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,33);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,34);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,35);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,36);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,37);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,38);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,39);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,40);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,41);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,42);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,43);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,44);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,46);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,47);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,48);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,49);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,50);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,51);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,52);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,53);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,54);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,55);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,56);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,57);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,58);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,59);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,60);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,61);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,67);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,68);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,69);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,70);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,71);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,72);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,74);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,75);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,76);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,77);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,78);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,79);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,80);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,81);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,82);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,83);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,84);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,85);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,86);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,87);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,88);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,89);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (3,90);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,1);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,3);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,4);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,24);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,36);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,38);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,39);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,42);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,43);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,44);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,46);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,47);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,48);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,59);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,60);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,61);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,74);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,75);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,76);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,77);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,78);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,88);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,89);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (5,90);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,1);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,3);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,4);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,6);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,10);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,14);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,18);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,22);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,24);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,36);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,37);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,38);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,39);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,40);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,41);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,44);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,46);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,48);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,49);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,50);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,51);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,52);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,53);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,59);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,60);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,61);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,76);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,77);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,78);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,87);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,92);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,93);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,100);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,101);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,104);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,105);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,110);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,111);
insert  into `admin_role_privilege`(`role_id`,`privilege_id`) values (7,112);

/*Table structure for table `admin_user` */

DROP TABLE IF EXISTS `admin_user`;

CREATE TABLE `admin_user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `realname` varchar(50) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `login_count` int(11) DEFAULT '0',
  `last_login_ip` varchar(100) DEFAULT NULL,
  `last_login_time` datetime DEFAULT NULL,
  `status` tinyint(2) DEFAULT '1',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `admin_user` */

insert  into `admin_user`(`user_id`,`username`,`password`,`realname`,`email`,`mobile`,`login_count`,`last_login_ip`,`last_login_time`,`status`,`create_time`) values (1,'admin','21232f297a57a5a743894a0e4a801fc3','Administrator','admin@mail.com','',0,'','2015-02-09 13:55:31',1,'2013-12-25 15:58:34');
insert  into `admin_user`(`user_id`,`username`,`password`,`realname`,`email`,`mobile`,`login_count`,`last_login_ip`,`last_login_time`,`status`,`create_time`) values (8,'guest','084e0343a0486ff05530df6c705c8bb4','Guest','','',624,'114.86.1.166','2015-02-09 13:39:57',1,'2014-03-12 17:06:36');

/*Table structure for table `admin_user_role` */

DROP TABLE IF EXISTS `admin_user_role`;

CREATE TABLE `admin_user_role` (
  `user_id` int(10) NOT NULL,
  `role_id` smallint(4) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `admin_user_role` */

insert  into `admin_user_role`(`user_id`,`role_id`) values (1,1);
insert  into `admin_user_role`(`user_id`,`role_id`) values (2,1);
insert  into `admin_user_role`(`user_id`,`role_id`) values (2,2);
insert  into `admin_user_role`(`user_id`,`role_id`) values (2,3);
insert  into `admin_user_role`(`user_id`,`role_id`) values (2,5);
insert  into `admin_user_role`(`user_id`,`role_id`) values (8,7);
insert  into `admin_user_role`(`user_id`,`role_id`) values (9,3);

/*Table structure for table `lepus_status` */

DROP TABLE IF EXISTS `lepus_status`;

CREATE TABLE `lepus_status` (
  `lepus_variables` varchar(255) NOT NULL,
  `lepus_value` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `lepus_status` */

insert  into `lepus_status`(`lepus_variables`,`lepus_value`) values ('lepus_running','1');
insert  into `lepus_status`(`lepus_variables`,`lepus_value`) values ('lepus_version','3.7');
insert  into `lepus_status`(`lepus_variables`,`lepus_value`) values ('lepus_checktime','none');

/*Table structure for table `options` */

DROP TABLE IF EXISTS `options`;

CREATE TABLE `options` (
  `name` varchar(50) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `description` varchar(100) DEFAULT NULL,
  KEY `idx_name` (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `options` */

insert  into `options`(`name`,`value`,`description`) values ('monitor','1','是否开启全局监控,此项如果关闭则所有项目都不会被监控，下面监控选项都失效');
insert  into `options`(`name`,`value`,`description`) values ('monitor_mysql','1','是否开启MySQL状态监控');
insert  into `options`(`name`,`value`,`description`) values ('send_alarm_mail','1','是否发送报警邮件');
insert  into `options`(`name`,`value`,`description`) values ('send_mail_to_list','','报警邮件通知人员');
insert  into `options`(`name`,`value`,`description`) values ('monitor_os','1','是否开启OS监控');
insert  into `options`(`name`,`value`,`description`) values ('monitor_mongodb','1','是否监控MongoDB');
insert  into `options`(`name`,`value`,`description`) values ('alarm','1','是否开启告警');
insert  into `options`(`name`,`value`,`description`) values ('send_mail_max_count','1','发送邮件最大次数');
insert  into `options`(`name`,`value`,`description`) values ('report_mail_to_list','','报告邮件推送接收人员');
insert  into `options`(`name`,`value`,`description`) values ('frequency_monitor','60','监控频率');
insert  into `options`(`name`,`value`,`description`) values ('send_mail_sleep_time','720','发送邮件休眠时间(分钟)');
insert  into `options`(`name`,`value`,`description`) values ('mailtype','html','邮件发送配置:邮件类型');
insert  into `options`(`name`,`value`,`description`) values ('mailprotocol','smtp','邮件发送配置:邮件协议');
insert  into `options`(`name`,`value`,`description`) values ('smtp_host','smtp.126.com','邮件发送配置:邮件主机');
insert  into `options`(`name`,`value`,`description`) values ('smtp_port','25','邮件发送配置:邮件端口');
insert  into `options`(`name`,`value`,`description`) values ('smtp_user','noreplymail','邮件发送配置:用户');
insert  into `options`(`name`,`value`,`description`) values ('smtp_pass','','邮件发送配置:密码');
insert  into `options`(`name`,`value`,`description`) values ('smtp_timeout','10','邮件发送配置:超时时间');
insert  into `options`(`name`,`value`,`description`) values ('mailfrom','noreplymail@126.com','邮件发送配置:发件人');
insert  into `options`(`name`,`value`,`description`) values ('monitor_redis','1','是否监控Redis');
insert  into `options`(`name`,`value`,`description`) values ('monitor_oracle','1','是否监控Oracle');
insert  into `options`(`name`,`value`,`description`) values ('send_alarm_sms','1','是否发生短信');
insert  into `options`(`name`,`value`,`description`) values ('send_sms_to_list','','短信收件人列表');
insert  into `options`(`name`,`value`,`description`) values ('send_sms_max_count','1','发送短信最大次数');
insert  into `options`(`name`,`value`,`description`) values ('send_sms_sleep_time','180','发送短信休眠时间(分钟)');
insert  into `options`(`name`,`value`,`description`) values ('sms_fetion_user','','飞信发送短信账号');
insert  into `options`(`name`,`value`,`description`) values ('sms_fetion_pass','','飞信发送短信密码');
insert  into `options`(`name`,`value`,`description`) values ('smstype','fetion','发送短信方式：fetion/api');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
