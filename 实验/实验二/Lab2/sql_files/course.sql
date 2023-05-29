DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `course_num` varchar(3) NOT NULL,
  `course_name` varchar(40) NOT NULL,
  `teacher_num` varchar(10) NOT NULL DEFAULT '1887415157',
  PRIMARY KEY (`course_num`),
  KEY `course_fk_teacher` (`teacher_num`),
  CONSTRAINT `course_fk_teacher` FOREIGN KEY (`teacher_num`) REFERENCES `teacher` (`teacher_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `course` WRITE;
INSERT INTO `course` (`course_num`, `course_name`, `teacher_num`) VALUES
('001', '数据库原理', '10001'),
('002', '数据结构', '10002'),
('003', '高等数学', '10003'),
('004', '大学英语', '10004'),
('005', '线性代数', '10005');
UNLOCK TABLES;