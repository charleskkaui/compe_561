drop DATABASE if exists `bankofhill`;
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
    `Type` INT NOT NULL , 
    `Account_A` INT NOT NULL , 
    `Account_B` INT NOT NULL , 
    `Amount` decimal(50,2) NOT NULL , 
    `Transac_Date` DATETIME NOT NULL,  
 	PRIMARY KEY (`Transac_ID`),
    FOREIGN KEY (`Account_A`) REFERENCES accounts(`Account_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (`Account_B`) REFERENCES accounts(`Account_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;