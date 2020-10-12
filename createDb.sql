SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`User`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`User` ;

CREATE TABLE IF NOT EXISTS `mydb`.`User` (
  `idUser` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `email` VARCHAR(100) NULL,
  `number` VARCHAR(10) NULL,
  `createAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Scooter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Scooter` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Scooter` (
  `idScooter` INT NOT NULL AUTO_INCREMENT,
  `needCharge` TINYINT NULL,
  `needRepair` TINYINT NULL,
  PRIMARY KEY (`idScooter`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Location` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Location` (
  `idLocation` INT NOT NULL AUTO_INCREMENT,
  `lat` FLOAT NULL,
  `lng` FLOAT NULL,
  `idUserLocation` INT NULL,
  `idScooterLocation` INT NULL,
  PRIMARY KEY (`idLocation`),
  INDEX `idUser_idx` (`idUserLocation` ASC),
  INDEX `idScooter_idx` (`idScooterLocation` ASC),
  CONSTRAINT `idUserLocation`
    FOREIGN KEY (`idUserLocation`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idScooterLocation`
    FOREIGN KEY (`idScooterLocation`)
    REFERENCES `mydb`.`Scooter` (`idScooter`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rental`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Rental` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Rental` (
  `idRental` INT NOT NULL AUTO_INCREMENT,
  `startAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endAt` TIMESTAMP NULL,
  `price` DECIMAL NOT NULL,
  `idUserRental` INT NOT NULL,
  `idScooterRental` INT NOT NULL,
  PRIMARY KEY (`idRental`),
  INDEX `idUser_idx` (`idUserRental` ASC),
  INDEX `idScooter_idx` (`idScooterRental` ASC),
  CONSTRAINT `idUserRental`
    FOREIGN KEY (`idUserRental`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idScooterRental`
    FOREIGN KEY (`idScooterRental`)
    REFERENCES `mydb`.`Scooter` (`idScooter`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Worker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Worker` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Worker` (
  `idWorker` INT NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `email` VARCHAR(100) NULL,
  `number` VARCHAR(10) NULL,
  `createAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idWorker`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Repair`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Repair` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Repair` (
  `idRepair` INT NOT NULL AUTO_INCREMENT,
  `dateRepair` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `startAt` TIMESTAMP NULL,
  `endAt` TIMESTAMP NULL,
  `idScooterRepair` INT NOT NULL,
  `idWorkerRepair` INT NOT NULL,
  PRIMARY KEY (`idRepair`),
  INDEX `idScooter_idx` (`idScooterRepair` ASC),
  INDEX `idWorker_idx` (`idWorkerRepair` ASC),
  CONSTRAINT `idScooterRepair`
    FOREIGN KEY (`idScooterRepair`)
    REFERENCES `mydb`.`Scooter` (`idScooter`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idWorkerRepair`
    FOREIGN KEY (`idWorkerRepair`)
    REFERENCES `mydb`.`Worker` (`idWorker`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Subcription`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Subcription` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Subcription` (
  `idSubcription` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NULL,
  `description` VARCHAR(250) NULL,
  `price` DECIMAL NULL,
  `createAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idSubcription`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`UserSubscribtion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`UserSubscribtion` ;

CREATE TABLE IF NOT EXISTS `mydb`.`UserSubscribtion` (
  `idUserSubscribtion` INT NOT NULL AUTO_INCREMENT,
  `startAt` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `expiresAt` TIMESTAMP NULL,
  `createAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updateAt` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `idSub` INT NOT NULL,
  `idUserSub` INT NOT NULL,
  PRIMARY KEY (`idUserSubscribtion`),
  INDEX `idSub_idx` (`idSub` ASC),
  INDEX `idUserSub_idx` (`idUserSub` ASC),
  CONSTRAINT `idSub`
    FOREIGN KEY (`idSub`)
    REFERENCES `mydb`.`Subcription` (`idSubcription`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idUserSub`
    FOREIGN KEY (`idUserSub`)
    REFERENCES `mydb`.`User` (`idUser`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
