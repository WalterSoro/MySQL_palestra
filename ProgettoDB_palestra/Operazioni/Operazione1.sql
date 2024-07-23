-- Elencare, per ogni impiegato avente meno di 35 anni compiuti, i suoi dati e le informazioni dei centri in cui lavora

DROP PROCEDURE IF EXISTS op1;
DELIMITER &&

CREATE PROCEDURE op1()
BEGIN
	SELECT D.CodFiscale AS Dipendente, D.Nome, D.Cognome, D.Sesso, D.DataNascita, C.Codice, C.Indirizzo, C.Citta
	FROM RegistroDipendenti RD INNER JOIN Dipendente D
				ON RD.Dipendente = D.CodFiscale
				INNER JOIN Centro C ON RD.Centro = C.Codice
	GROUP BY D.CodFiscale, RD.Centro
	HAVING D.DataNascita + INTERVAL 35 YEAR > CURRENT_DATE();
END &&
DELIMITER ;


CALL op1();