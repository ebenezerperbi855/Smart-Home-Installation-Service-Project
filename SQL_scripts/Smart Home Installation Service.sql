-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema SHIS
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `SHIS` ;

-- -----------------------------------------------------
-- Schema SHIS
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `SHIS` DEFAULT CHARACTER SET utf8 ;
USE `SHIS` ;

-- -----------------------------------------------------
-- Table `SHIS`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SHIS`.`Customer` ;

CREATE TABLE IF NOT EXISTS `SHIS`.`Customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL COMMENT 'Customer full name ',
  `email` VARCHAR(100) NULL,
  `phone` VARCHAR(20) NULL,
  `address` VARCHAR(45) NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SHIS`.`Technician`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SHIS`.`Technician` ;

CREATE TABLE IF NOT EXISTS `SHIS`.`Technician` (
  `technician_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL COMMENT 'Technician full name ',
  `specialization` VARCHAR(100) NULL COMMENT 'Area of expertise ',
  `availability` VARCHAR(50) NULL COMMENT 'e.g., Available ,On Job ,On Leave',
  PRIMARY KEY (`technician_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SHIS`.`Installation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SHIS`.`Installation` ;

CREATE TABLE IF NOT EXISTS `SHIS`.`Installation` (
  `installation_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NULL,
  `technician_id` INT NULL,
  `date` DATE NULL COMMENT 'Installation date ',
  `status` VARCHAR(50) NULL COMMENT 'e.g., Scheduled ,Completed,Pending',
  `Customer_customer_id` INT NOT NULL,
  `Technician_technician_id` INT NOT NULL,
  PRIMARY KEY (`installation_id`),
  INDEX `fk_Installation_Customer_idx` (`Customer_customer_id` ASC) VISIBLE,
  INDEX `fk_Installation_Technician1_idx` (`Technician_technician_id` ASC) VISIBLE,
  CONSTRAINT `fk_Installation_Customer`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `SHIS`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Installation_Technician1`
    FOREIGN KEY (`Technician_technician_id`)
    REFERENCES `SHIS`.`Technician` (`technician_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SHIS`.`Device`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SHIS`.`Device` ;

CREATE TABLE IF NOT EXISTS `SHIS`.`Device` (
  `device_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NULL COMMENT 'Device name ',
  `brand` VARCHAR(100) NULL COMMENT 'Manufacturer brand ',
  `type` VARCHAR(100) NULL COMMENT 'Category (camera, sensor ,speaker)',
  `Installation_installation_id` INT NOT NULL,
  PRIMARY KEY (`device_id`),
  INDEX `fk_Device_Installation1_idx` (`Installation_installation_id` ASC) VISIBLE,
  CONSTRAINT `fk_Device_Installation1`
    FOREIGN KEY (`Installation_installation_id`)
    REFERENCES `SHIS`.`Installation` (`installation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SHIS`.`Maintenance Request`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SHIS`.`Maintenance Request` ;

CREATE TABLE IF NOT EXISTS `SHIS`.`Maintenance Request` (
  `request_id` INT NOT NULL AUTO_INCREMENT,
  `installation_id` INT NULL,
  `device_id` INT NULL,
  `request_date` DATE NULL,
  `description` VARCHAR(200) NULL,
  `status` VARCHAR(50) NULL,
  `Customer_customer_id` INT NOT NULL,
  `Technician_technician_id` INT NOT NULL,
  PRIMARY KEY (`request_id`),
  INDEX `fk_Maintenance Request_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  INDEX `fk_Maintenance Request_Technician1_idx` (`Technician_technician_id` ASC) VISIBLE,
  CONSTRAINT `fk_Maintenance Request_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `SHIS`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Maintenance Request_Technician1`
    FOREIGN KEY (`Technician_technician_id`)
    REFERENCES `SHIS`.`Technician` (`technician_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SHIS`.`Payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `SHIS`.`Payment` ;

CREATE TABLE IF NOT EXISTS `SHIS`.`Payment` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `installation` INT NULL,
  `amount` DECIMAL(10,2) NULL,
  `Payment_ date` DATE NULL,
  `method` VARCHAR(50) NULL,
  `Customer_customer_id` INT NOT NULL,
  `Installation_installation_id` INT NOT NULL,
  PRIMARY KEY (`payment_id`),
  INDEX `fk_Payment_Customer1_idx` (`Customer_customer_id` ASC) VISIBLE,
  INDEX `fk_Payment_Installation1_idx` (`Installation_installation_id` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Customer1`
    FOREIGN KEY (`Customer_customer_id`)
    REFERENCES `SHIS`.`Customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_Installation1`
    FOREIGN KEY (`Installation_installation_id`)
    REFERENCES `SHIS`.`Installation` (`installation_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
