DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `course_num` varchar(3) NOT NULL,
  `student_num` varchar(10) NOT NULL,
  `grade` varchar(3) DEFAULT '60',
  PRIMARY KEY (`course_num`,`student_num`),
  KEY `score_fk_student` (`student_num`),
  CONSTRAINT `score_fk_course` FOREIGN KEY (`course_num`) REFERENCES `course` (`course_num`),
  CONSTRAINT `score_fk_student` FOREIGN KEY (`student_num`) REFERENCES `student` (`student_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `score` WRITE;
INSERT INTO `score` (`course_num`, `student_num`, `grade`) VALUES
('001', '202001001', '85'),
('002', '202001002', '76'),
('003', '202001003', '90'),
('004', '202001004', '67'),
('005', '202001005', '92');
UNLOCK TABLES;