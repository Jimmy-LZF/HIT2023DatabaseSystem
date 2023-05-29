DROP TABLE IF EXISTS `student`;
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

LOCK TABLES `student` WRITE;
INSERT INTO `student` (`student_num`, `student_name`, `class_num`, `age`, `gender`) VALUES
('202001001', '张三', '001', '19', '男'),
('202001002', '李四', '001', '20', '男'),
('202001003', '王五', '002', '18', '女'),
('202001004', '赵六', '002', '21', '男'),
('202001005', '钱七', '003', '20', '女');
UNLOCK TABLES;