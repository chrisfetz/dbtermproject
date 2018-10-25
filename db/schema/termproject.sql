-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema termproject
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema termproject
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `termproject` DEFAULT CHARACTER SET utf8 ;
USE `termproject` ;

-- -----------------------------------------------------
-- Table `termproject`.`TaxData`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `termproject`.`TaxData` ;

CREATE TABLE IF NOT EXISTS `termproject`.`TaxData` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `state` CHAR(2) NOT NULL,
  `zipcode` INT NOT NULL,
  `county` VARCHAR(100) NOT NULL,
  `incomeBracket` INT NOT NULL,
  `numReturns` INT NOT NULL,
  `totalIncome` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idxState` (`state` ASC) INVISIBLE,
  INDEX `idxZipcode` (`zipcode` ASC) INVISIBLE,
  INDEX `idxCounty` (`county` ASC) INVISIBLE,
  INDEX `idxIncomeBracket` (`incomeBracket` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `termproject`.`Restaurants`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `termproject`.`Restaurants` ;

CREATE TABLE IF NOT EXISTS `termproject`.`Restaurants` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `latitude` FLOAT NOT NULL,
  `longitude` FLOAT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `zipcode` INT NOT NULL,
  `county` VARCHAR(100) NOT NULL,
  `state` CHAR(2) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `idxZipcodeRestaurant` (`zipcode` ASC) INVISIBLE,
  INDEX `idxNameRestaurant` (`name` ASC) VISIBLE,
  INDEX `idxCountyRestaurant` (`county` ASC) VISIBLE,
  INDEX `idxStateRestaurant` (`state` ASC) VISIBLE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
