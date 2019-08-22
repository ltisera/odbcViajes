-- MySQL Script generated by MySQL Workbench
-- Thu Aug 22 11:58:32 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema odbcViajes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema odbcViajes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `odbcViajes` DEFAULT CHARACTER SET utf8 ;
USE `odbcViajes` ;

-- -----------------------------------------------------
-- Table `odbcViajes`.`Pasajero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `odbcViajes`.`Pasajero` (
  `DNI` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `apellido` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `millas` FLOAT NULL,
  `clave` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `nacionalidad` VARCHAR(45) NULL,
  PRIMARY KEY (`DNI`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `odbcViajes`.`Ciudad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `odbcViajes`.`Ciudad` (
  `idDestinos` INT NOT NULL,
  `nombre` VARCHAR(45) NULL,
  `cordenada` VARCHAR(45) NULL,
  `baja` TINYINT NULL,
  PRIMARY KEY (`idDestinos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `odbcViajes`.`Pasaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `odbcViajes`.`Pasaje` (
  `codigo` VARCHAR(10) NOT NULL,
  `fecha` DATE NULL,
  `valor` FLOAT NULL,
  `pasajero` INT NOT NULL,
  `origen` INT NOT NULL,
  `destino` INT NOT NULL,
  `formaPago` ENUM('dinero', 'millas') NULL,
  PRIMARY KEY (`codigo`),
  INDEX `fk_Pasaje_Pasajero_idx` (`pasajero` ASC) VISIBLE,
  INDEX `fk_Pasaje_Destinos1_idx` (`origen` ASC) VISIBLE,
  INDEX `fk_Pasaje_Destinos2_idx` (`destino` ASC) VISIBLE,
  CONSTRAINT `fk_Pasaje_Pasajero`
    FOREIGN KEY (`pasajero`)
    REFERENCES `odbcViajes`.`Pasajero` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pasaje_Destinos1`
    FOREIGN KEY (`origen`)
    REFERENCES `odbcViajes`.`Ciudad` (`idDestinos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pasaje_Destinos2`
    FOREIGN KEY (`destino`)
    REFERENCES `odbcViajes`.`Ciudad` (`idDestinos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
