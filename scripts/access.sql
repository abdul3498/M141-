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