-- von uns

DROP DATABASE IF EXISTS Backpacker;
CREATE DATABASE BACKPACKER;

USE BACKPACKER;

-- gegeben

DROP TABLE IF EXISTS `tbl_positionen`, `tbl_buchung`, `tbl_personen`, `tbl_leistung`, `tbl_land`, `tbl_benutzer`;


CREATE TABLE `tbl_land` (
  `Land_ID` int(11) AUTO_INCREMENT,
  `Land` text collate latin1_general_ci NOT NULL,
  PRIMARY KEY (`Land_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='enthält die Ländercodes';

CREATE TABLE `tbl_personen` (
  `Personen_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Titel` text collate latin1_general_ci,
  `Vorname` VARCHAR(70) collate latin1_general_ci,
  `Name` VARCHAR(70) collate latin1_general_ci,
  `Strasse` VARCHAR(70) collate latin1_general_ci,
  `PLZ` VARCHAR(10) collate latin1_general_ci,
  `Ort` VARCHAR(70) collate latin1_general_ci,
  `Anrede` VARCHAR(40) collate latin1_general_ci,
  `Telefon` VARCHAR(40) collate latin1_general_ci,
  `erfasst` datetime default NULL,
  `Sprache` VARCHAR(50) collate latin1_general_ci,
  PRIMARY KEY  (`Personen_ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='enthaelt alle Gaeste' AUTO_INCREMENT=2042 ;


CREATE TABLE `tbl_buchung` (
  `Buchungs_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Personen_FS` int(11),
  `Ankunft` datetime ,
  `Abreise` datetime ,
  `Land_FS` int(11) ,
  PRIMARY KEY  (`Buchungs_ID`),
  INDEX `idx_personen_fs` (`Personen_FS`),
  INDEX `idx_land_fs` (`Land_FS`),
  FOREIGN KEY (`Personen_FS`) REFERENCES `tbl_personen`(`Personen_ID`) ON DELETE SET NULL,
  FOREIGN KEY (`Land_FS`) REFERENCES `tbl_land`(`Land_ID`) ON DELETE SET NULL
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Buchungszeilen' AUTO_INCREMENT=1087 ;



CREATE TABLE `tbl_leistung` (
  `LeistungID` int(11) NOT NULL,
  `Beschreibung` varchar(70) collate latin1_general_ci default NULL,
  PRIMARY KEY  (`LeistungID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;



CREATE TABLE `tbl_benutzer` (
  `Benutzer_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Benutzername` varchar(20) collate latin1_general_ci NOT NULL default '',
  `Password` VARCHAR(255) collate latin1_general_ci,
  `Vorname` varchar(20) collate latin1_general_ci default NULL,
  `Name` text collate latin1_general_ci,
  `Benutzergruppe` tinyint(4) default '1',
  `erfasst` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `deaktiviert` date default '1000-01-01',
  `aktiv` tinyint(4) default '1',
  PRIMARY KEY  (`Benutzer_ID`),
  UNIQUE INDEX `idx_benutzername` (`Benutzername`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Mitarbeiter' AUTO_INCREMENT=28 ;



CREATE TABLE `tbl_positionen` (
  `Positions_ID` int(11) NOT NULL AUTO_INCREMENT,
  `Buchungs_FS` int(11) default NULL,
  `Konto` int(11) NOT NULL default '0',
  `Anzahl` int(11) NOT NULL default '0',
  `Preis` decimal(10,2) NOT NULL default '0.00',
  `Rabatt` decimal(4,2) NOT NULL default '0.00',
  `Benutzer_FS` int(11) NOT NULL default '0',
  `erfasst` datetime NOT NULL default '1000-01-01 00:00:00',
  `Leistung_Text` text collate latin1_general_ci NOT NULL,
  `Leistung_FS` INT (11),  
  PRIMARY KEY  (`Positions_ID`),
  FULLTEXT KEY `Leistung_Text` (`Leistung_Text`),
  INDEX `idx_buchungs_fs` (`Buchungs_FS`),
  INDEX `idx_benutzer_fs` (`Benutzer_FS`),
  INDEX `idx_leistung_fs` (`Leistung_FS`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='enthält einzelne Buchungspositionen' AUTO_INCREMENT=4055 ;

ALTER TABLE `tbl_positionen` ADD CONSTRAINT `fk_buchungs_fs` FOREIGN KEY (`Buchungs_FS`) REFERENCES `tbl_buchung`(`Buchungs_ID`) ON DELETE CASCADE;
ALTER TABLE `tbl_positionen` ADD CONSTRAINT `fk_leistung_fs` FOREIGN KEY (`Leistung_FS`) REFERENCES `tbl_leistung`(`LeistungID`) ON DELETE SET NULL;


-- von uns
drop view if exists view_tbl_benutzer_Password;
drop view if exists view_tbl_benutzer_deaktiviert;
drop view if exists view_tbl_benutzer_restliche_attribute;

create view view_tbl_benutzer_Password as select Password from tbl_benutzer;
create view view_tbl_benutzer_deaktiviert as select deaktiviert from tbl_benutzer;
create view view_tbl_benutzer_restliche_attribute as select Benutzer_ID, Benutzername, Vorname, Name, Benutzergruppe, erfasst, aktiv from tbl_benutzer;

DROP USER IF EXISTS `MgmtUsr1`@`%`;
DROP USER IF EXISTS `Usr1`@`%`;
DROP USER IF EXISTS `Adm`@`%`;

CREATE USER `MgmtUsr1`@`%` IDENTIFIED BY 'M141Projekt';
CREATE USER `Usr1`@`%` IDENTIFIED BY 'M141Projekt';
CREATE USER `Adm`@`%` IDENTIFIED BY 'M141ProjektAdm';

DROP ROLE IF EXISTS `role_benutzer`;
CREATE ROLE `role_benutzer`;
GRANT SELECT ON `backpacker`.`tbl_land` TO `role_benutzer`;
GRANT SELECT ON `backpacker`.`tbl_leistung` TO `role_benutzer`;
GRANT SELECT, UPDATE ON `backpacker`.`tbl_personen` TO `role_benutzer`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_buchung` TO `role_benutzer`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_positionen` TO `role_benutzer`;
grant select on view_tbl_benutzer_deaktiviert to `role_benutzer`;
grant select, insert, update on view_tbl_benutzer_restliche_attribute to `role_benutzer`;


drop role if exists `Management`;
CREATE ROLE `Management`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_land` TO `Management`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_leistung` TO `Management`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_personen` TO `Management`;
GRANT SELECT ON `backpacker`.`tbl_positionen` TO `Management`;
GRANT SELECT ON `backpacker`.`tbl_buchung` TO `Management`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_benutzer` TO `Management`;


GRANT `Management` TO `MgmtUsr1`@`%`;
GRANT `benutzer` TO `Usr1`@`%`;
GRANT ALL PRIVILEGES ON *.* TO 'adm'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'M141ProjektRoot';

flush privileges;



LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_benutzer.csv'
INTO TABLE tbl_benutzer
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_personen.csv'
INTO TABLE tbl_personen
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_land.csv'
INTO TABLE tbl_land
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

SET SQL_MODE = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION,NO_AUTO_VALUE_ON_ZERO';
INSERT INTO tbl_land (Land_ID, Land) VALUES (0, 'unspecified');
INSERT INTO tbl_land (Land_ID, Land) VALUES (176, 'unspecified');
SET SQL_MODE = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';

LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_buchung.csv'
INTO TABLE tbl_buchung
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_leistung.csv'
INTO TABLE tbl_leistung
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;


LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_positionen.csv'
INTO TABLE tbl_positionen
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
