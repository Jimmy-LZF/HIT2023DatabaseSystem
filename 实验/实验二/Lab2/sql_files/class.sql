DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `class_num` varchar(3) NOT NULL,
  `department_num` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`class_num`),
  KEY `class_fk_department` (`department_num`),
  CONSTRAINT `class_fk_department` FOREIGN KEY (`department_num`) REFERENCES `department` (`department_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `class` WRITE;
INSERT INTO `class` (`class_num`, `department_num`) VALUES
('001', '001'),
('002', '001'),
('003', '002'),
('004', '002'),
('005', '003');
UNLOCK TABLES;