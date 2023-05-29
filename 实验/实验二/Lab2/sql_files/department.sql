DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_num` varchar(3) NOT NULL,
  `department_name` varchar(40) NOT NULL,
  `college_num` varchar(3) NOT NULL,
  PRIMARY KEY (`department_num`),
  KEY `department_fk_college` (`college_num`),
  CONSTRAINT `department_fk_college` FOREIGN KEY (`college_num`) REFERENCES `college` (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `department` WRITE;
INSERT INTO `department` (`department_num`, `department_name`, `college_num`) VALUES
('001', '计算机科学与技术系', '001'),
('002', '化学工程系', '002'),
('003', '英语系', '003'),
('004', '美术系', '004'),
('005', '电子工程系', '005');
UNLOCK TABLES;