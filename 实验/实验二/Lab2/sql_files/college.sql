DROP TABLE IF EXISTS `college`;
CREATE TABLE `college` (
  `college_num` varchar(3) NOT NULL,
  `college_name` varchar(50) NOT NULL,
  PRIMARY KEY (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `college` WRITE;
INSERT INTO `college` (`college_num`, `college_name`) VALUES
('001', '计算机科学与技术学院'),
('002', '化学工程学院'),
('003', '外国语学院'),
('004', '艺术与设计学院'),
('005', '物理与电子工程学院');
UNLOCK TABLES;