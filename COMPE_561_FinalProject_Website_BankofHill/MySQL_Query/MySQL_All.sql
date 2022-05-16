DROP DATABASE IF EXISTS `bankofhill`;
CREATE DATABASE `bankofhill`;

CREATE TABLE `bankofhill`.`customers` ( 
    `Customer_ID` INT NOT NULL AUTO_INCREMENT, 
    `Name_First` VARCHAR(20) NOT NULL , 
    `Name_Middle` VARCHAR(20) NULL , 
    `Name_Last` VARCHAR(20) NOT NULL , 
    `Email` VARCHAR(50) NOT NULL , 
    `Telephone` VARCHAR(10) NOT NULL , 
    `Address` VARCHAR(50) NOT NULL , 
    `Address_2` VARCHAR(50) NULL , 
    `City` VARCHAR(25) NOT NULL , 
    `State` VARCHAR(25) NOT NULL , 
    `Zip_Code` VARCHAR(20) NOT NULL , 
    `Date_Joined` DATE NOT NULL , 
    `Credit_Score` INT NULL,
 	PRIMARY KEY (`Customer_ID`)
) ENGINE = InnoDB;

CREATE TABLE `bankofhill`.`users` ( 
 	`Customer_ID` INT NOT NULL AUTO_INCREMENT, 
 	`Username` VARCHAR(30) NOT NULL, 
 	`Password` VARCHAR(30) NOT NULL, 
 	PRIMARY KEY (`Customer_ID`),
    FOREIGN KEY (`Customer_ID`) REFERENCES customers(`Customer_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `bankofhill`.`accounts` ( 
    `Account_ID` INT NOT NULL AUTO_INCREMENT, 
    `Type` VARCHAR(15) NOT NULL , 
    `Customer_ID` INT NOT NULL , 
    `Amount` decimal(50,2) NOT NULL , 
    `Date_Created` DATE NOT NULL , 
    `APR` decimal(9,2) NULL , 
    `APY` decimal(9,2) NULL , 
    `Term` DATE NULL,
 	PRIMARY KEY (`Account_ID`),
    FOREIGN KEY (`Customer_ID`) REFERENCES customers(`Customer_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `bankofhill`.`transactions` ( 
    `Transac_ID` INT NOT NULL AUTO_INCREMENT, 
    `Account_A` INT NOT NULL , 
    `Account_B` INT NOT NULL , 
    `Amount` decimal(50,2) NOT NULL , 
    `Transac_Date` DATE NOT NULL,  
 	PRIMARY KEY (`Transac_ID`),
    FOREIGN KEY (`Account_A`) REFERENCES accounts(`Account_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Account_B`) REFERENCES accounts(`Account_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

INSERT INTO `bankofhill`.`customers` VALUES  (DEFAULT, 'Benita','Cyb','Jalbert','JalbertBenita87@outlook.com','2869027288','422 Indigo Bolton Avenue','','Kandahar','Connecticut',87631,'11-23-18',695);
INSERT INTO `bankofhill`.`customers` VALUES  (DEFAULT, 'Ruthe','Frieda','Cressida','CressidaRuthe58@gmail.com','3778325119','587 Orange Ember Street','','Kawasaki','Virginia',60306,'05-07-18',606);
INSERT INTO `bankofhill`.`customers` VALUES  (DEFAULT, 'Joane','Flory','Willie','WillieJoane81@yahoo.com','4473859995','312 Blue Royalty Lane','','Chaguanas','Arkansas',60651,'06-23-16',626);
INSERT INTO `bankofhill`.`customers` VALUES  (DEFAULT, 'Elmira','Lanae','Xerxes','XerxesElmira72@gmail.com','7242253073','754 Orange Prospect Way','','Quebec City','Alaska',82373,'03-08-18',505);

INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Checking',1,15000,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Checking',2,300,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Checking',3,26584,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Checking',4,654684,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Savings',1,68546351,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Savings',2,65876854,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Savings',3,4684,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Savings',4,68464,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Credit',1,684687,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Credit',2,6584,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Credit',3,178785,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Credit',4,7582,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Certificate',1,875,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Certificate',2,7852,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Certificate',3,7865,'2022-05-13',null,null,null);
INSERT INTO `bankofhill`.`accounts` VALUES (DEFAULT,'Certificate',4,7852,'2022-05-13',null,null,null);

INSERT INTO `bankofhill`.`users` VALUES (1,'usr1','ps1');
INSERT INTO `bankofhill`.`users` VALUES (2,'usr2','ps2');
INSERT INTO `bankofhill`.`users` VALUES (3,'usr3','ps3');
INSERT INTO `bankofhill`.`users` VALUES (4,'usr4','ps4');

INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT, 1,2,250,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,2,3,134,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,2,4,625,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,4,2,223,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,3,2,12,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,2,1,24,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,1,8,36,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,2,6,85,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,4,2,164,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,3,7,136,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,1,12,652,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,2,11,243,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,3,10,1,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,4,9,36,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,5,8,254,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,6,7,135,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,7,6,336,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,8,5,252,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,1,12,325,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,2,11,132,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,3,10,245,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,4,9,222,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,5,8,3,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,6,7,36,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,7,10,35,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,8,9,49,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,5,8,85,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,3,4,61,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,6,3,52,'2022-05-13');
INSERT INTO `bankofhill`.`transactions` VALUES (DEFAULT,2,2,72,'2022-05-13');