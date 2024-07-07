-- von uns

DROP DATABASE IF EXISTS Backpacker;
CREATE DATABASE BACKPACKER;

USE BACKPACKER;

-- gegeben

CREATE TABLE `tbl_benutzer` (
  `Benutzer_ID` int(11) NOT NULL auto_increment,
  `Benutzername` varchar(20) collate latin1_general_ci NOT NULL default '',
  `Password` text collate latin1_general_ci,
  `Vorname` varchar(20) collate latin1_general_ci default NULL,
  `Name` text collate latin1_general_ci,
  `Benutzergruppe` tinyint(4) default '1',
  `erfasst` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `deaktiviert` date default '1000-01-01',
  `aktiv` tinyint(4) default '1',
  PRIMARY KEY  (`Benutzer_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Mitarbeiter' AUTO_INCREMENT=28 ;

CREATE TABLE `tbl_buchung` (
  `Buchungs_ID` int(11) NOT NULL auto_increment,
  `Personen_FS` int(11) default NULL,
  `Ankunft` datetime default NULL,
  `Abreise` datetime default NULL,
  `Land_FS` int(11) default NULL,
  PRIMARY KEY  (`Buchungs_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Buchungszeilen' AUTO_INCREMENT=1087 ;

CREATE TABLE `tbl_land` (
  `Land_ID` int(11) NOT NULL default '0',
  `Land` text collate latin1_general_ci NOT NULL
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='enthält die Ländercodes';

CREATE TABLE `tbl_leistung` (
  `LeistungID` int(11) NOT NULL default '0',
  `Beschreibung` varchar(70) collate latin1_general_ci default NULL,
  PRIMARY KEY  (`LeistungID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

CREATE TABLE `tbl_personen` (
  `Personen_ID` int(11) NOT NULL auto_increment,
  `Titel` text collate latin1_general_ci,
  `Vorname` text collate latin1_general_ci,
  `Name` text collate latin1_general_ci,
  `Strasse` text collate latin1_general_ci,
  `PLZ` text collate latin1_general_ci,
  `Ort` text collate latin1_general_ci,
  `Anrede` text collate latin1_general_ci,
  `Telefon` text collate latin1_general_ci,
  `erfasst` datetime default NULL,
  `Sprache` text collate latin1_general_ci,
  PRIMARY KEY  (`Personen_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='enth�lt alle G�ste' AUTO_INCREMENT=2042 ;

CREATE TABLE `tbl_positionen` (
  `Positions_ID` int(11) NOT NULL auto_increment,
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
  FULLTEXT KEY `Leistung_Text` (`Leistung_Text`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='enthält einzelne Buchungspositionen' AUTO_INCREMENT=4055 ;

-- von uns

CREATE USER `MgmtUsr1`@`%` IDENTIFIED BY 'M141Projekt';
CREATE USER `Usr1`@`%` IDENTIFIED BY 'M141Projekt';
CREATE USER `Adm`@`%` IDENTIFIED BY `M141ProjektAdm`

CREATE ROLE `Benutzer`;
GRANT SELECT ON `backpacker`.`tbl_land` TO `Benutzer`;
GRANT SELECT ON `backpacker`.`tbl_leistung` TO `Benutzer`;
GRANT SELECT, UPDATE ON `backpacker`.`tbl_personen` TO `Benutzer`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_buchung` TO `Benutzer`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_positionen` TO `Benutzer`;

CREATE ROLE `Management`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_land` TO `Management`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_leistung` TO `Management`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_personen` TO `Management`;
GRANT SELECT ON `backpacker`.`tbl_positionen` TO `Management`;
GRANT SELECT ON `backpacker`.`tbl_buchung` TO `Management`;
GRANT ALL PRIVILEGES ON `backpacker`.`tbl_benutzer` TO `Management`;


GRANT `Management` TO `MgmtUsr1`@`%`;
GRANT `Benutzer` TO `Usr1`@`%`;
GRANT ALL PRIVILEGES ON *.* TO 'adm'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'M141ProjektRoot';

flush privileges;

LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_benutzer.csv'
INTO TABLE tbl_benutzer
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_buchung.csv'
INTO TABLE tbl_buchung
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_land.csv'
INTO TABLE tbl_land
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_leistung.csv'
INTO TABLE tbl_leistung
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_personen.csv'
INTO TABLE tbl_personen
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

LOAD DATA INFILE 'C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/data/backpacker_lb3_table_tbl_positionen.csv'
INTO TABLE tbl_positionen
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
