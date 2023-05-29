DROP DATABASE IF EXISTS `university`;
CREATE DATABASE `university`;
USE `university`;

DROP TABLE IF EXISTS `class`;
CREATE TABLE `class` (
  `class_num` varchar(3) NOT NULL,
  `department_num` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`class_num`),
  KEY `class_fk_department` (`department_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `college`;
CREATE TABLE `college` (
  `college_num` varchar(3) NOT NULL,
  `college_name` varchar(50) NOT NULL,
  PRIMARY KEY (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `course`;
CREATE TABLE `course` (
  `course_num` varchar(3) NOT NULL,
  `course_name` varchar(50) NOT NULL,
  `teacher_num` varchar(5) NOT NULL DEFAULT '10001',
  PRIMARY KEY (`course_num`),
  KEY `course_fk_teacher` (`teacher_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `dormitory`;
CREATE TABLE `dormitory` (
  `dormitory_num` varchar(3) NOT NULL,
  `college_num` varchar(3) NOT NULL,
  PRIMARY KEY (`dormitory_num`),
  KEY `dormitory_fk_college` (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `laboratory`;
CREATE TABLE `laboratory` (
  `laboratory_num` varchar(3) NOT NULL,
  `laboratory_name` varchar(40) NOT NULL,
  `college_num` varchar(3) NOT NULL,
  PRIMARY KEY (`laboratory_num`),
  KEY `laboratory_fk_college` (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `score`;
CREATE TABLE `score` (
  `course_num` varchar(3) NOT NULL,
  `student_num` varchar(10) NOT NULL,
  `grade` varchar(3) DEFAULT '60',
  PRIMARY KEY (`course_num`,`student_num`),
  KEY `score_fk_student` (`student_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `student_num` varchar(10) NOT NULL,
  `student_name` varchar(20) NOT NULL,
  `class_num` varchar(3) NOT NULL DEFAULT '001',
  `age` varchar(3) DEFAULT '20',
  `gender` varchar(10) DEFAULT '男',
  PRIMARY KEY (`student_num`),
  KEY `student_fk_class` (`class_num`),
  KEY `student_name_index` (`student_name` DESC)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `department_num` varchar(3) NOT NULL,
  `department_name` varchar(40) NOT NULL,
  `college_num` varchar(3) NOT NULL,
  PRIMARY KEY (`department_num`),
  KEY `department_fk_college` (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

DROP TABLE IF EXISTS `teacher`;
CREATE TABLE `teacher` (
  `teacher_num` varchar(5) NOT NULL,
  `teacher_name` varchar(20) NOT NULL,
  `department_num` varchar(3) NOT NULL,
  PRIMARY KEY (`teacher_num`),
  KEY `teacher_fk_department` (`department_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



INSERT INTO `department` (`department_num`, `department_name`, `college_num`) VALUES
('001', '计算机科学与技术系', '001'),
('002', '化学工程系', '002'),
('003', '英语系', '003'),
('004', '美术系', '004'),
('005', '电子工程系', '005');

INSERT INTO `class` (`class_num`, `department_num`) VALUES
('001', '001'),
('002', '001'),
('003', '002'),
('004', '002'),
('005', '003');

INSERT INTO `college` (`college_num`, `college_name`) VALUES
('001', '计算机科学与技术学院'),
('002', '化学工程学院'),
('003', '外国语学院'),
('004', '艺术与设计学院'),
('005', '物理与电子工程学院');

INSERT INTO `course` (`course_num`, `course_name`, `teacher_num`) VALUES
('001', '数据库原理', '10001'),
('002', '数据结构', '10002'),
('003', '高等数学', '10003'),
('004', '大学英语', '10004'),
('005', '线性代数', '10005');

INSERT INTO `dormitory` (`dormitory_num`, `college_num`) VALUES
('A01', '001'),
('A02', '002'),
('A03', '003'),
('A04', '004'),
('A05', '005');

INSERT INTO `laboratory` (`laboratory_num`, `laboratory_name`, `college_num`) VALUES
('001', '计算机实验室', '001'),
('002', '化学实验室', '002'),
('003', '英语实验室', '003'),
('004', '美术实验室', '004'),
('005', '电子实验室', '005');

INSERT INTO `score` (`course_num`, `student_num`, `grade`) VALUES
('001', '2020001001', '85'),
('002', '2020001002', '76'),
('003', '2020001003', '90'),
('004', '2020001004', '67'),
('005', '2020001005', '92');

INSERT INTO `student` (`student_num`, `student_name`, `class_num`, `age`, `gender`) VALUES
('2020001001', '张三', '001', '19', '男'),
('2020001002', '李四', '001', '20', '男'),
('2020001003', '王五', '002', '18', '女'),
('2020001004', '赵六', '002', '21', '男'),
('2020001005', '钱七', '003', '20', '女');

INSERT INTO `teacher` (`teacher_num`, `teacher_name`, `department_num`) VALUES
('10001', '陈思宇', '001'),
('10002', '王磊', '001'),
('10003', '李婷婷', '002'),
('10004', '张伟', '003'),
('10005', '赵雪峰', '005');

ALTER TABLE `class` ADD CONSTRAINT `class_fk_department` FOREIGN KEY (`department_num`) REFERENCES `department` (`department_num`);
ALTER TABLE `course` ADD CONSTRAINT `course_fk_teacher` FOREIGN KEY (`teacher_num`) REFERENCES `teacher` (`teacher_num`);
ALTER TABLE `department` ADD CONSTRAINT `department_fk_college` FOREIGN KEY (`college_num`) REFERENCES `college` (`college_num`);
ALTER TABLE `dormitory` ADD CONSTRAINT `dormitory_fk_college` FOREIGN KEY (`college_num`) REFERENCES `college` (`college_num`);
ALTER TABLE `laboratory` ADD CONSTRAINT `laboratory_fk_college` FOREIGN KEY (`college_num`) REFERENCES `college` (`college_num`);
ALTER TABLE `score` ADD CONSTRAINT `score_fk_course` FOREIGN KEY (`course_num`) REFERENCES `course` (`course_num`);
ALTER TABLE `score` ADD CONSTRAINT `score_fk_student` FOREIGN KEY (`student_num`) REFERENCES `student` (`student_num`);
ALTER TABLE `student` ADD CONSTRAINT `student_fk_class` FOREIGN KEY (`class_num`) REFERENCES `class` (`class_num`);
ALTER TABLE `teacher` ADD CONSTRAINT `teacher_fk_department` FOREIGN KEY (`department_num`) REFERENCES `department` (`department_num`);