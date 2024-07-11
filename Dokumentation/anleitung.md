# Schritt für Schritt Anleitung

## Local Setup - XAMPP

### DDL-Skript ausführen (inkl. CREATE DB)

    SOURCE C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/ddl.sql

---

        -- phpMyAdmin SQL Dump
        -- version 2.9.1.1
        -- http://www.phpmyadmin.net
        --
        -- Host: localhost
        -- Erstellungszeit: 09. März 2008 um 21:56
        -- Server Version: 5.0.27
        -- PHP-Version: 5.2.0
        --
        -- Datenbank: `backpacker_lb3`
        --

        -- --------------------------------------------------------

        --
        -- Tabellenstruktur für Tabelle `tbl_benutzer`
        --
        DROP DATABASE IF EXISTS backpacker_lb3;
        CREATE DATABASE backpacker_lb3;
        USE backpacker_lb3;

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



        --
        -- Tabellenstruktur für Tabelle `tbl_buchung`
        --

        CREATE TABLE `tbl_buchung` (
        `Buchungs_ID` int(11) NOT NULL auto_increment,
        `Personen_FS` int(11) default NULL,
        `Ankunft` datetime default NULL,
        `Abreise` datetime default NULL,
        `Land_FS` int(11) default NULL,
        PRIMARY KEY  (`Buchungs_ID`)
        ) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='Buchungszeilen' AUTO_INCREMENT=1087 ;



        --
        -- Tabellenstruktur für Tabelle `tbl_land`
        --

        CREATE TABLE `tbl_land` (
        `Land_ID` int(11) NOT NULL default '0',
        `Land` text collate latin1_general_ci NOT NULL
        ) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci COMMENT='enthält die Ländercodes';


        --
        -- Tabellenstruktur für Tabelle `tbl_leistung`
        --

        CREATE TABLE `tbl_leistung` (
        `LeistungID` int(11) NOT NULL default '0',
        `Beschreibung` varchar(70) collate latin1_general_ci default NULL,
        PRIMARY KEY  (`LeistungID`)
        ) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;



        --
        -- Tabellenstruktur für Tabelle `tbl_personen`
        --

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

        --
        -- Tabellenstruktur für Tabelle `tbl_positionen`
        --

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

### Tables anpassen/Foreign Key Constraints erstellen

    SOURCE C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/tablechanges.sql

---

        ALTER TABLE tbl_land ADD PRIMARY KEY (Land_ID);
        ALTER TABLE tbl_leistung ENGINE = InnoDB;
        ALTER TABLE tbl_personen ENGINE = InnoDB;
        ALTER TABLE tbl_land ENGINE = InnoDB;
        ALTER TABLE tbl_positionen ENGINE = InnoDB;
        ALTER TABLE tbl_benutzer ENGINE = InnoDB;
        ALTER TABLE tbl_buchung ENGINE = InnoDB;

        ALTER TABLE tbl_buchung
        ADD CONSTRAINT FK_Personen_ID FOREIGN KEY (Personen_FS) REFERENCES tbl_personen(Personen_ID);

        ALTER TABLE tbl_buchung
        ADD CONSTRAINT FK_Land_ID FOREIGN KEY (Land_FS) REFERENCES tbl_land(Land_ID);

        ALTER TABLE tbl_positionen
        ADD CONSTRAINT FK_Leistung_ID FOREIGN KEY (Leistung_FS) REFERENCES tbl_leistung(LeistungID);

        ALTER TABLE tbl_positionen
        ADD CONSTRAINT FK_Buchungs_ID FOREIGN KEY (Buchungs_FS) REFERENCES tbl_buchung(Buchungs_ID);

        ALTER TABLE tbl_positionen
        ADD CONSTRAINT FK_Benutzer_ID FOREIGN KEY (Benutzer_FS) REFERENCES tbl_benutzer(Benutzer_ID);

## Daten importieren

    SOURCE C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/import.sql

---

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

## Daten aufräumen

    SOURCE C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/datafix.sql

---

        SET SQL_MODE = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION,NO_AUTO_VALUE_ON_ZERO';
        INSERT INTO tbl_land (Land_ID, Land) VALUES (0, 'unspecified');
        INSERT INTO tbl_land (Land_ID, Land) VALUES (176, 'unspecified');
        DELETE FROM tbl_land WHERE Land_id = 212;
        INSERT INTO tbl_land 212,"Russische Foederation, Russland"
        DELETE FROM tbl_land WHERE Land_id = 220;
        SET SQL_MODE = 'NO_ZERO_IN_DATE,NO_ZERO_DATE,NO_ENGINE_SUBSTITUTION';

## Duplikate Listen

    SELECT Benutzer_ID, COUNT(*) AS duplicate_count
    FROM tbl_benutzer
    GROUP BY Benutzer_ID
    HAVING COUNT(*) > 1;

    SELECT Buchungs_ID, COUNT(*) AS duplicate_count
    FROM tbl_buchung
    GROUP BY Buchungs_ID
    HAVING COUNT(*) > 1;

    SELECT Land_ID, COUNT(*) AS duplicate_count
    FROM tbl_land
    GROUP BY Land_ID
    HAVING COUNT(*) > 1;

    SELECT LeistungID, COUNT(*) AS duplicate_count
    FROM tbl_leistung
    GROUP BY LeistungID
    HAVING COUNT(*) > 1;

    SELECT Positions_ID, COUNT(*) AS duplicate_count
    FROM tbl_positionen
    GROUP BY Positions_ID
    HAVING COUNT(*) > 1;

## Dump von lokaler Datenbank erstellen

    mysqldump -u root -p backpacker_lb3 > "C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/dump.sql"

# AWS

## Dump in die AWS-Datenbank importieren

    SOURCE C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/dump.sql

## Zugriff regeln

SOURCE C:/Daten/TBZ/Module/m141/unser_repo/M141-/scripts/access.sql

---

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
    GRANT SELECT ON `backpacker_lb3`.`tbl_land` TO `role_benutzer`;
    GRANT SELECT ON `backpacker_lb3`.`tbl_leistung` TO `role_benutzer`;
    GRANT SELECT, UPDATE ON `backpacker_lb3`.`tbl_personen` TO `role_benutzer`;
    GRANT ALL PRIVILEGES ON `backpacker_lb3`.`tbl_buchung` TO `role_benutzer`;
    GRANT ALL PRIVILEGES ON `backpacker_lb3`.`tbl_positionen` TO `role_benutzer`;
    grant select on view_tbl_benutzer_deaktiviert to `role_benutzer`;
    grant select, insert, update on view_tbl_benutzer_restliche_attribute to `role_benutzer`;


    drop role if exists `Management`;
    CREATE ROLE `Management`;
    GRANT ALL PRIVILEGES ON `backpacker_lb3`.`tbl_land` TO `Management`;
    GRANT ALL PRIVILEGES ON `backpacker_lb3`.`tbl_leistung` TO `Management`;
    GRANT ALL PRIVILEGES ON `backpacker_lb3`.`tbl_personen` TO `Management`;
    GRANT SELECT ON `backpacker_lb3`.`tbl_positionen` TO `Management`;
    GRANT SELECT ON `backpacker_lb3`.`tbl_buchung` TO `Management`;
    GRANT ALL PRIVILEGES ON `backpacker_lb3`.`tbl_benutzer` TO `Management`;


    GRANT `Management` TO `MgmtUsr1`@`%`;
    GRANT `role_benutzer` TO `Usr1`@`%`;
    GRANT ALL PRIVILEGES ON *.* TO 'adm'@'%';

    flush privileges;
