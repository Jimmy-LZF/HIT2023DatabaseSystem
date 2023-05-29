DROP TABLE IF EXISTS `laboratory`;
CREATE TABLE `laboratory` (
  `laboratory_num` varchar(3) NOT NULL,
  `laboratory_name` varchar(40) NOT NULL,
  `college_num` varchar(3) NOT NULL,
  PRIMARY KEY (`laboratory_num`),
  KEY `laboratory_fk_college` (`college_num`),
  CONSTRAINT `laboratory_fk_college` FOREIGN KEY (`college_num`) REFERENCES `college` (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `laboratory` WRITE;
INSERT INTO `laboratory` (`laboratory_num`, `laboratory_name`, `college_num`) VALUES
('001', '计算机实验室', '001'),
('002', '化学实验室', '002'),
('003', '英语实验室', '003'),
('004', '美术实验室', '004'),
('005', '电子实验室', '005');
UNLOCK TABLES;