ALTER TABLE tbl_land ADD PRIMARY KEY (Land_ID);
ALTER TABLE tbl_leistung ENGINE = InnoDB;
ALTER TABLE tbl_personen ENGINE = InnoDB;
ALTER TABLE tbl_land ENGINE = InnoDB;
ALTER TABLE tbl_positionen ENGINE = InnoDB;
ALTER TABLE tbl_benutzer ENGINE = InnoDB;
ALTER TABLE tbl_buchung ENGINE = InnoDB;

ALTER TABLE tbl_buchung ADD CONSTRAINT FK_Personen_ID FOREIGN KEY (Personen_FS) REFERENCES tbl_personen(Personen_ID);
ALTER TABLE tbl_buchung ADD CONSTRAINT FK_Land_ID FOREIGN KEY (Land_FS) REFERENCES tbl_land(Land_ID);
ALTER TABLE tbl_positionen ADD CONSTRAINT FK_Leistung_ID FOREIGN KEY (Leistung_FS) REFERENCES tbl_leistung(LeistungID);
ALTER TABLE tbl_positionen ADD CONSTRAINT FK_Buchungs_ID FOREIGN KEY (Buchungs_FS) REFERENCES tbl_buchung(Buchungs_ID);
ALTER TABLE tbl_positionen ADD CONSTRAINT FK_Benutzer_ID FOREIGN KEY (Benutzer_FS) REFERENCES tbl_benutzer(Benutzer_ID);