DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `teacher_num` varchar(10) NOT NULL,
  `teacher_name` varchar(20) NOT NULL,
  `department_num` varchar(3) NOT NULL,
  PRIMARY KEY (`teacher_num`),
  KEY `teacher_fk_department` (`department_num`),
  CONSTRAINT `teacher_fk_department` FOREIGN KEY (`department_num`) REFERENCES `department` (`department_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `teacher` WRITE;
INSERT INTO `teacher` (`teacher_num`, `teacher_name`, `department_num`) VALUES
('10001', '陈思宇', '001'),
('10002', '王磊', '001'),
('10003', '李婷婷', '002'),
('10004', '张伟', '003'),
('10005', '赵雪峰', '005');
UNLOCK TABLES;