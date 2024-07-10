
SELECT Benutzername, COUNT(*) as count
FROM tbl_benutzer
GROUP BY Benutzername
HAVING count > 1;

SELECT Personen_FS, Ankunft, Abreise, COUNT(*) as count
FROM tbl_buchung
GROUP BY Personen_FS, Ankunft, Abreise
HAVING count > 1;

SELECT Land, COUNT(*) as count
FROM tbl_land
GROUP BY Land
HAVING count > 1;

SELECT Beschreibung, COUNT(*) as count
FROM tbl_leistung
GROUP BY Beschreibung
HAVING count > 1;

SELECT Vorname, Name, Strasse, COUNT(*) as count
FROM tbl_personen
GROUP BY Vorname, Name, Strasse
HAVING count > 1;

SELECT Buchungs_FS, Konto, Leistung_Text, COUNT(*) as count
FROM tbl_positionen
GROUP BY Buchungs_FS, Konto, Leistung_Text
HAVING count > 1;
