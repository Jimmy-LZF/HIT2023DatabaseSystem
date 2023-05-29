-- MySQL dump 10.13  Distrib 8.0.32, for Win64 (x86_64)
--
-- Host: localhost    Database: university
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `class`
--

DROP TABLE IF EXISTS `class`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class` (
  `class_num` varchar(3) NOT NULL,
  `department_num` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`class_num`),
  KEY `class_fk_department` (`department_num`),
  CONSTRAINT `class_fk_department` FOREIGN KEY (`department_num`) REFERENCES `department` (`department_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class`
--

LOCK TABLES `class` WRITE;
/*!40000 ALTER TABLE `class` DISABLE KEYS */;
INSERT INTO `class` VALUES ('001','001'),('002','001'),('003','002'),('004','002'),('005','003');
/*!40000 ALTER TABLE `class` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college`
--

DROP TABLE IF EXISTS `college`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `college` (
  `college_num` varchar(3) NOT NULL,
  `college_name` varchar(50) NOT NULL,
  PRIMARY KEY (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college`
--

LOCK TABLES `college` WRITE;
/*!40000 ALTER TABLE `college` DISABLE KEYS */;
INSERT INTO `college` VALUES ('001','计算学部'),('002','化学工程学院'),('003','外国语学院'),('004','艺术与设计学院'),('005','物理与电子工程学院');
/*!40000 ALTER TABLE `college` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course`
--

DROP TABLE IF EXISTS `course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course` (
  `course_num` varchar(3) NOT NULL,
  `course_name` varchar(50) NOT NULL,
  `teacher_num` varchar(5) NOT NULL DEFAULT '10001',
  PRIMARY KEY (`course_num`),
  KEY `course_fk_teacher` (`teacher_num`),
  CONSTRAINT `course_fk_teacher` FOREIGN KEY (`teacher_num`) REFERENCES `teacher` (`teacher_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course`
--

LOCK TABLES `course` WRITE;
/*!40000 ALTER TABLE `course` DISABLE KEYS */;
INSERT INTO `course` VALUES ('001','数据库原理','10001'),('002','数据结构','10002'),('003','高等数学','10003'),('004','大学英语','10004'),('005','线性代数','10005');
/*!40000 ALTER TABLE `course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `cs_student0`
--

DROP TABLE IF EXISTS `cs_student0`;
/*!50001 DROP VIEW IF EXISTS `cs_student0`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cs_student0` AS SELECT 
 1 AS `student_num`,
 1 AS `student_name`,
 1 AS `class_num`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `cs_student1`
--

DROP TABLE IF EXISTS `cs_student1`;
/*!50001 DROP VIEW IF EXISTS `cs_student1`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cs_student1` AS SELECT 
 1 AS `student_num`,
 1 AS `student_name`,
 1 AS `class_num`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department` (
  `department_num` varchar(3) NOT NULL,
  `department_name` varchar(40) NOT NULL,
  `college_num` varchar(3) NOT NULL,
  PRIMARY KEY (`department_num`),
  KEY `department_fk_college` (`college_num`),
  CONSTRAINT `department_fk_college` FOREIGN KEY (`college_num`) REFERENCES `college` (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('001','计算机科学与技术系','001'),('002','化学工程系','002'),('003','英语系','003'),('004','美术系','004'),('005','电子工程系','005'),('006','信息安全系','001'),('007','软件工程系','001');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dormitory`
--

DROP TABLE IF EXISTS `dormitory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dormitory` (
  `dormitory_num` varchar(3) NOT NULL,
  `college_num` varchar(3) NOT NULL,
  PRIMARY KEY (`dormitory_num`),
  KEY `dormitory_fk_college` (`college_num`),
  CONSTRAINT `dormitory_fk_college` FOREIGN KEY (`college_num`) REFERENCES `college` (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dormitory`
--

LOCK TABLES `dormitory` WRITE;
/*!40000 ALTER TABLE `dormitory` DISABLE KEYS */;
INSERT INTO `dormitory` VALUES ('A01','001'),('A02','002'),('A03','003'),('A04','004'),('A05','005');
/*!40000 ALTER TABLE `dormitory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `laboratory`
--

DROP TABLE IF EXISTS `laboratory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `laboratory` (
  `laboratory_num` varchar(3) NOT NULL,
  `laboratory_name` varchar(40) NOT NULL,
  `college_num` varchar(3) NOT NULL,
  PRIMARY KEY (`laboratory_num`),
  KEY `laboratory_fk_college` (`college_num`),
  CONSTRAINT `laboratory_fk_college` FOREIGN KEY (`college_num`) REFERENCES `college` (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `laboratory`
--

LOCK TABLES `laboratory` WRITE;
/*!40000 ALTER TABLE `laboratory` DISABLE KEYS */;
INSERT INTO `laboratory` VALUES ('001','计算机实验室','001'),('002','化学实验室','002'),('003','英语实验室','003'),('004','美术实验室','004'),('005','电子实验室','005');
/*!40000 ALTER TABLE `laboratory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `score`
--

DROP TABLE IF EXISTS `score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `score` (
  `course_num` varchar(3) NOT NULL,
  `student_num` varchar(10) NOT NULL,
  `grade` varchar(3) DEFAULT '60',
  PRIMARY KEY (`course_num`,`student_num`),
  KEY `score_fk_student` (`student_num`),
  CONSTRAINT `score_fk_course` FOREIGN KEY (`course_num`) REFERENCES `course` (`course_num`),
  CONSTRAINT `score_fk_student` FOREIGN KEY (`student_num`) REFERENCES `student` (`student_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `score`
--

LOCK TABLES `score` WRITE;
/*!40000 ALTER TABLE `score` DISABLE KEYS */;
INSERT INTO `score` VALUES ('001','2020001001','85'),('002','2020001001','81'),('002','2020001002','76'),('003','2020001003','90'),('004','2020001004','67'),('005','2020001005','92');
/*!40000 ALTER TABLE `score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `student_num` varchar(10) NOT NULL,
  `student_name` varchar(20) NOT NULL,
  `class_num` varchar(3) NOT NULL DEFAULT '001',
  `age` varchar(3) DEFAULT '20',
  `gender` varchar(10) DEFAULT '男',
  PRIMARY KEY (`student_num`),
  KEY `student_fk_class` (`class_num`),
  KEY `student_name_index` (`student_name` DESC),
  CONSTRAINT `student_fk_class` FOREIGN KEY (`class_num`) REFERENCES `class` (`class_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student`
--

LOCK TABLES `student` WRITE;
/*!40000 ALTER TABLE `student` DISABLE KEYS */;
INSERT INTO `student` VALUES ('2020001001','张三','001','19','男'),('2020001002','李四','001','20','男'),('2020001003','王五','002','18','女'),('2020001004','赵六','002','21','男'),('2020001005','钱七','003','20','女');
/*!40000 ALTER TABLE `student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `teacher_num` varchar(5) NOT NULL,
  `teacher_name` varchar(20) NOT NULL,
  `department_num` varchar(3) NOT NULL,
  PRIMARY KEY (`teacher_num`),
  KEY `teacher_fk_department` (`department_num`),
  CONSTRAINT `teacher_fk_department` FOREIGN KEY (`department_num`) REFERENCES `department` (`department_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher`
--

LOCK TABLES `teacher` WRITE;
/*!40000 ALTER TABLE `teacher` DISABLE KEYS */;
INSERT INTO `teacher` VALUES ('10001','陈思宇','001'),('10002','王磊','001'),('10003','李婷婷','002'),('10004','张伟','003'),('10005','赵雪峰','005');
/*!40000 ALTER TABLE `teacher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `cs_student0`
--

/*!50001 DROP VIEW IF EXISTS `cs_student0`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cs_student0` AS select `student`.`student_num` AS `student_num`,`student`.`student_name` AS `student_name`,`student`.`class_num` AS `class_num` from `student` where `student`.`class_num` in (select `class`.`class_num` from `class` where `class`.`department_num` in (select `department`.`department_num` from `department` where ((`department`.`college_num` = '001') and (`department`.`department_name` = '计算机科学与技术系')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `cs_student1`
--

/*!50001 DROP VIEW IF EXISTS `cs_student1`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `cs_student1` AS select `student`.`student_num` AS `student_num`,`student`.`student_name` AS `student_name`,`student`.`class_num` AS `class_num` from `student` where `student`.`class_num` in (select `class`.`class_num` from `class` where `class`.`department_num` in (select `department`.`department_num` from `department` where ((`department`.`college_num` = '001') and (`department`.`department_name` = '信息安全系')))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-30 21:38:17
