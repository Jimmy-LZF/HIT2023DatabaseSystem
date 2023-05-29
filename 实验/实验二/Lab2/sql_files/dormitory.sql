DROP TABLE IF EXISTS `dormitory`;
CREATE TABLE `dormitory` (
  `dormitory_num` varchar(3) NOT NULL,
  `college_num` varchar(3) NOT NULL,
  PRIMARY KEY (`dormitory_num`),
  KEY `dormitory_fk_college` (`college_num`),
  CONSTRAINT `dormitory_fk_college` FOREIGN KEY (`college_num`) REFERENCES `college` (`college_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

LOCK TABLES `dormitory` WRITE;
INSERT INTO `dormitory` (`dormitory_num`, `college_num`) VALUES
('A01', '001'),
('A02', '002'),
('A03', '003'),
('A04', '004'),
('A05', '005');
UNLOCK TABLES;