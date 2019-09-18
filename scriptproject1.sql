-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Impiegato`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Impiegato` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Impiegato` (
  `id` INT NOT NULL,
  `dataAssunzione` DATE NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `dataNascita` DATE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `index2` (`cognome` ASC, `nome` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `email` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NULL,
  `cognome` VARCHAR(45) NULL,
  PRIMARY KEY (`email`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prenotazione`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Prenotazione` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Prenotazione` (
  `numero` VARCHAR(45) NOT NULL,
  `data` DATE NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `idImpiegato` INT NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_Prenotazione_Cliente1_idx` (`email` ASC),
  INDEX `fk_Prenotazione_Impiegato1_idx` (`idImpiegato` ASC),
  CONSTRAINT `fk_Prenotazione_Cliente1`
    FOREIGN KEY (`email`)
    REFERENCES `mydb`.`Cliente` (`email`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Prenotazione_Impiegato1`
    FOREIGN KEY (`idImpiegato`)
    REFERENCES `mydb`.`Impiegato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornitore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Fornitore` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Fornitore` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RisorsaAlimentare`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`RisorsaAlimentare` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RisorsaAlimentare` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `prezzo` INT(11) NOT NULL,
  `dataScadenza` DATE NOT NULL,
  `idFornitore` INT NULL,
  PRIMARY KEY (`id`, `nome`),
  INDEX `fk_RisorsaAlimentare_Fornitore1_idx` (`idFornitore` ASC),
  CONSTRAINT `fk_RisorsaAlimentare_Fornitore1`
    FOREIGN KEY (`idFornitore`)
    REFERENCES `mydb`.`Fornitore` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Specie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Specie` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Specie` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `idRisorsa` INT NULL,
  PRIMARY KEY (`id`, `nome`),
  INDEX `fk_Specie_RisorsaAlimentare1_idx` (`idRisorsa` ASC),
  CONSTRAINT `fk_Specie_RisorsaAlimentare1`
    FOREIGN KEY (`idRisorsa`)
    REFERENCES `mydb`.`RisorsaAlimentare` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Volpe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Volpe` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Volpe` (
  `id` VARCHAR(45) NOT NULL,
  `dataNascita` DATE NOT NULL,
  `idSpecie` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Volpe_Specie1_idx` (`idSpecie` ASC),
  CONSTRAINT `fk_Volpe_Specie1`
    FOREIGN KEY (`idSpecie`)
    REFERENCES `mydb`.`Specie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RisorsaMedica`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`RisorsaMedica` ;

CREATE TABLE IF NOT EXISTS `mydb`.`RisorsaMedica` (
  `id` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `prezzo` SMALLINT(6) NOT NULL,
  `idFornitore` INT NULL,
  PRIMARY KEY (`id`, `nome`),
  INDEX `fk_RisorsaMedica_Fornitore1_idx` (`idFornitore` ASC),
  CONSTRAINT `fk_RisorsaMedica_Fornitore1`
    FOREIGN KEY (`idFornitore`)
    REFERENCES `mydb`.`Fornitore` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Visita`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Visita` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Visita` (
  `dataVisita` DATE NOT NULL,
  `idVolpe` VARCHAR(45) NOT NULL,
  `idImpiegato` INT NOT NULL,
  `medica` INT NULL,
  INDEX `fk_Visita_Impiegato1_idx` (`idImpiegato` ASC),
  INDEX `fk_Visita_Volpe1_idx` (`idVolpe` ASC),
  UNIQUE INDEX `index4` (`idVolpe` ASC, `dataVisita` ASC),
  INDEX `fk_Visita_RisorsaMedica1_idx` (`medica` ASC),
  PRIMARY KEY (`dataVisita`, `idVolpe`),
  CONSTRAINT `fk_Visita_Impiegato1`
    FOREIGN KEY (`idImpiegato`)
    REFERENCES `mydb`.`Impiegato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Visita_Volpe1`
    FOREIGN KEY (`idVolpe`)
    REFERENCES `mydb`.`Volpe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Visita_RisorsaMedica1`
    FOREIGN KEY (`medica`)
    REFERENCES `mydb`.`RisorsaMedica` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Settore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Settore` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Settore` (
  `nome` CHAR(1) NOT NULL,
  `specie` INT NULL,
  PRIMARY KEY (`nome`),
  INDEX `fk_Settore_Specie1_idx` (`specie` ASC),
  CONSTRAINT `fk_Settore_Specie1`
    FOREIGN KEY (`specie`)
    REFERENCES `mydb`.`Specie` (`id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Guardia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Guardia` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Guardia` (
  `idImpiegato` INT NOT NULL,
  `settore` CHAR(1) NULL,
  PRIMARY KEY (`idImpiegato`),
  INDEX `fk_Guardia_2_idx` (`settore` ASC),
  CONSTRAINT `fk_Guardia_1`
    FOREIGN KEY (`idImpiegato`)
    REFERENCES `mydb`.`Impiegato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Guardia_2`
    FOREIGN KEY (`settore`)
    REFERENCES `mydb`.`Settore` (`nome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `mydb`;

DELIMITER $$

USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`RisorsaAlimentare_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`RisorsaAlimentare_BEFORE_INSERT` BEFORE INSERT ON `RisorsaAlimentare` FOR EACH ROW
BEGIN
IF new.idFornitore NOT IN (
SELECT F.id
From Fornitore F )
THEN
insert into Fornitore (id) values(new.idFornitore);
END IF;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`RisorsaAlimentare_AFTER_UPDATE` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`RisorsaAlimentare_AFTER_UPDATE` AFTER UPDATE ON `RisorsaAlimentare` FOR EACH ROW
BEGIN
if ( new.dataScadenza > curdate())
then 
update RisorsaAlimentare
set dataScadenza = new.dataScadenza
where dataScadenza = old.dataScadenza;
end if;
END$$


USE `mydb`$$
DROP TRIGGER IF EXISTS `mydb`.`RisorsaMedica_BEFORE_INSERT` $$
USE `mydb`$$
CREATE DEFINER = CURRENT_USER TRIGGER `mydb`.`RisorsaMedica_BEFORE_INSERT` BEFORE INSERT ON `RisorsaMedica` FOR EACH ROW
BEGIN
IF new.idFornitore NOT IN (
SELECT F.id
From Fornitore F )
THEN
insert into Fornitore (id) values(new.idFornitore);
END IF;
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `mydb`.`Impiegato`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (46, '2011-07-01', 'Berni', 'Tommaso', '1983-03-06');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (1, '2009-09-07', 'Handanovic', 'Samir', '1984-07-14');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (27, '2015-10-08', 'Padelli', 'Daniele', '1985-10-25');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (33, '2008-03-14', 'D\'Ambrosio', 'Danilo', '1988-09-09');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (29, '2011-06-06', 'Dalbert', 'Henrique', '1993-09-08');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (23, '2010-01-11', 'Miranda', 'Joao', '1984-09-07');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (13, '2010-01-11', 'Ranocchia', 'Andrea', '1988-02-16');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (37, '2014-05-20', 'Skriniar ', 'Milan', '1995-02-11');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (2, '2009-04-11', 'Vrsaljko', 'Sime', '1992-01-10');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (18, '2015-12-12', 'Asamoah', 'Kwadwo', '1988-12-09');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (77, '2015-12-12', 'Brozovic', 'Marcelo', '1992-11-24');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (87, '2017-02-14', 'Candreva', 'Antonio', '1987-02-19');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (5, '2017-07-30', 'Gagliardini', 'Roberto', '1994-04-07');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (15, '2017-08-06', 'Joao', 'Mario', '1993-01-19');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (44, '2018-01-15', 'Perisic', 'Ivan', '1989-02-02');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (9, '2018-02-19', 'Icardi ', 'Mauro', '1993-02-19');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (11, '2018-03-23', 'Keita', 'Balde', '1995-03-08');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (16, '2018-03-09', 'Politano', 'Matteo', '1993-08-03');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (14, '2019-01-15', 'Nainggolan', 'Radja', '1998-05-04');
INSERT INTO `mydb`.`Impiegato` (`id`, `dataAssunzione`, `cognome`, `nome`, `dataNascita`) VALUES (8, '2019-01-15', 'Vecino', 'Matias', '1991-08-24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Cliente`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('cristianoronaldo.email', 'Cristiano', 'Ronaldo');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('paulodyballa.email', 'Paulo', 'Dyballa');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('douglascosta.email', 'Douglas', 'Costa');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('juancuadrado.email', 'Juan', 'Cuadrado');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('mariomandzukic.email', 'Mario', 'Mandzukic');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('moisekean.email', 'Moise', 'Kean');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('federicobernardeschi.email', 'Federico', 'Bernardeschi');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('miralempjanic.email', 'Miralem', 'Pjanic');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('samikhedira.email', 'Sami', 'Khedira');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('blaisematuidi.email', 'Blaise', 'Matuidi');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('emrecan.email', 'Emre', 'Can');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('rodrigobentancur.email', 'Rodrigo', 'Bentancur');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('leonardobonucci.email', 'Leonardo', 'Bonucci');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('joaocancelo.email', 'Joao', 'Cancelo');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('danielerugani.email', 'Daniele', 'Rugani');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('leonardospinazzola.email', 'Leonardo', 'Spinazzola');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('mattiadesciglio.email', 'Mattia', 'De Sciglio');
INSERT INTO `mydb`.`Cliente` (`email`, `nome`, `cognome`) VALUES ('giorgiochiellini.email', 'Giorgio', 'Chiellini');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Prenotazione`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P1', '2019-01-01', 'cristianoronaldo.email', 27);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P2', '2019-01-01', 'paulodyballa.email', 37);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P3', '2019-01-01', 'douglascosta.email', 23);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P4', '2019-01-01', 'juancuadrado.email', 18);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P5', '2019-01-01', 'mariomandzukic.email', 13);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P6', '2019-01-01', 'moisekean.email', 77);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P7', '2019-01-03', 'federicobernardeschi.email', 15);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P8', '2019-01-03', 'miralempjanic.email', 5);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P9', '2019-01-04', 'samikhedira.email', 13);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P10', '2019-01-05', 'blaisematuidi.email', 27);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P11', '2019-01-05', 'emrecan.email', 27);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P12', '2019-01-08', 'rodrigobentancur.email', 18);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P13', '2019-01-09', 'mattiadesciglio.email', 77);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P14', '2019-01-10', 'giorgiochiellini.email', 15);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P15', '2019-01-10', 'leonardobonucci.email', 5);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P16', '2019-01-11', 'joaocancelo.email', 15);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P17', '2019-01-12', 'danielerugani.email', 13);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P18', '2019-01-13', 'leonardospinazzola.email', 5);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P19', '2019-01-14', 'cristianoronaldo.email', 15);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P20', '2019-01-15', 'douglascosta.email', 77);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P21', '2019-01-16', 'federicobernardeschi.email', 13);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P22', '2019-01-17', 'juancuadrado.email', 18);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P23', '2019-01-18', 'blaisematuidi.email', 23);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P24', '2019-01-20', 'paulodyballa.email', 37);
INSERT INTO `mydb`.`Prenotazione` (`numero`, `data`, `email`, `idImpiegato`) VALUES ('P25', '2019-01-20', 'leonardobonucci.email', 27);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Fornitore`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Fornitore` (`id`, `nome`) VALUES (901, 'farmaci.Srl');
INSERT INTO `mydb`.`Fornitore` (`id`, `nome`) VALUES (902, 'cocacola.Srl');
INSERT INTO `mydb`.`Fornitore` (`id`, `nome`) VALUES (903, 'pepsi.Co');
INSERT INTO `mydb`.`Fornitore` (`id`, `nome`) VALUES (904, 'stanco.Co');

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`RisorsaAlimentare`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`RisorsaAlimentare` (`id`, `nome`, `prezzo`, `dataScadenza`, `idFornitore`) VALUES (101, 'gallina', 15, '2019-05-24', 903);
INSERT INTO `mydb`.`RisorsaAlimentare` (`id`, `nome`, `prezzo`, `dataScadenza`, `idFornitore`) VALUES (102, 'topi campagnoli', 18, '2019-03-22', 902);
INSERT INTO `mydb`.`RisorsaAlimentare` (`id`, `nome`, `prezzo`, `dataScadenza`, `idFornitore`) VALUES (103, 'bucce di banane', 12, '2019-02-19', 904);
INSERT INTO `mydb`.`RisorsaAlimentare` (`id`, `nome`, `prezzo`, `dataScadenza`, `idFornitore`) VALUES (104, 'semi', 12, '2019-04-19', 904);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Specie`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Specie` (`id`, `nome`, `idRisorsa`) VALUES (01, 'rossa nordica', 104);
INSERT INTO `mydb`.`Specie` (`id`, `nome`, `idRisorsa`) VALUES (02, 'platino', 101);
INSERT INTO `mydb`.`Specie` (`id`, `nome`, `idRisorsa`) VALUES (03, 'blue', 103);
INSERT INTO `mydb`.`Specie` (`id`, `nome`, `idRisorsa`) VALUES (04, 'crociata', 101);
INSERT INTO `mydb`.`Specie` (`id`, `nome`, `idRisorsa`) VALUES (05, 'ombrata', 102);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Volpe`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0101', '2017-11-24', 01);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0102', '2015-01-02', 01);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0103', '2015-06-08', 01);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0104', '2016-08-06', 01);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0201', '2015-12-11', 02);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0202', '2016-09-30', 02);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0203', '2014-07-20', 02);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0204', '2016-01-25', 02);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0205', '2018-11-30', 02);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0301', '2016-09-17', 03);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0302', '2016-01-15', 03);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0303', '2017-04-01', 03);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0401', '2018-02-03', 04);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0402', '2016-08-06', 04);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0403', '2015-01-25', 04);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0404', '2015-10-10', 04);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0501', '2018-06-01', 05);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0502', '2015-12-25', 05);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0503', '2016-04-30', 05);
INSERT INTO `mydb`.`Volpe` (`id`, `dataNascita`, `idSpecie`) VALUES ('V0504', '2016-12-15', 05);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`RisorsaMedica`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`RisorsaMedica` (`id`, `nome`, `prezzo`, `idFornitore`) VALUES (01, 'siringa', 50, 901);
INSERT INTO `mydb`.`RisorsaMedica` (`id`, `nome`, `prezzo`, `idFornitore`) VALUES (02, 'medicine', 70, 902);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Visita`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-03', 'V0101', 9, 02);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-03', 'V0102', 11, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-03', 'V0103', 16, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-03', 'V0104', 87, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-03', 'V0201', 14, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-03', 'V0202', 44, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-03', 'V0203', 8, 01);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-03', 'V0204', 9, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-03', 'V0205', 11, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-03', 'V0301', 16, 01);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-04', 'V0302', 87, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-04', 'V0303', 14, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-04', 'V0401', 44, 01);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-04', 'V0402', 8, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-04', 'V0403', 9, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-04', 'V0404', 11, 02);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-04', 'V0501', 16, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-04', 'V0502', 87, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-04', 'V0503', 14, 02);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2018-12-04', 'V0504', 44, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-07', 'V0101', 8, 01);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-07', 'V0102', 9, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-07', 'V0103', 11, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-07', 'V0104', 16, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-07', 'V0201', 87, 01);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-07', 'V0202', 14, 02);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-07', 'V0203', 44, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-07', 'V0204', 8, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-07', 'V0205', 9, 02);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-07', 'V0301', 11, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-08', 'V0302', 16, 01);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-08', 'V0303', 87, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-08', 'V0401', 14, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-08', 'V0402', 44, 02);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-08', 'V0403', 8, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-08', 'V0404', 9, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-08', 'V0501', 11, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-08', 'V0502', 16, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-08', 'V0503', 87, NULL);
INSERT INTO `mydb`.`Visita` (`dataVisita`, `idVolpe`, `idImpiegato`, `medica`) VALUES ('2019-01-08', 'V0504', 14, 01);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Settore`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Settore` (`nome`, `specie`) VALUES ('A', 01);
INSERT INTO `mydb`.`Settore` (`nome`, `specie`) VALUES ('B', 02);
INSERT INTO `mydb`.`Settore` (`nome`, `specie`) VALUES ('C', 03);
INSERT INTO `mydb`.`Settore` (`nome`, `specie`) VALUES ('D', 04);
INSERT INTO `mydb`.`Settore` (`nome`, `specie`) VALUES ('E', 05);

COMMIT;


-- -----------------------------------------------------
-- Data for table `mydb`.`Guardia`
-- -----------------------------------------------------
START TRANSACTION;
USE `mydb`;
INSERT INTO `mydb`.`Guardia` (`idImpiegato`, `settore`) VALUES (1, 'A');
INSERT INTO `mydb`.`Guardia` (`idImpiegato`, `settore`) VALUES (27, 'B');
INSERT INTO `mydb`.`Guardia` (`idImpiegato`, `settore`) VALUES (46, 'C');
INSERT INTO `mydb`.`Guardia` (`idImpiegato`, `settore`) VALUES (33, 'D');
INSERT INTO `mydb`.`Guardia` (`idImpiegato`, `settore`) VALUES (2, 'E');

COMMIT;

