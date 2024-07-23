-- Elencare i dati dei clienti che, nella settimana corrente, hanno eseguito almeno 4 accessi

DROP PROCEDURE IF EXISTS op2;
DELIMITER &&

CREATE PROCEDURE op2()
BEGIN
	SELECT C.CodFiscale, C.Nome, C.Cognome, C.Datanascita
	FROM Accesso A INNER JOIN Cliente C
			ON A.Cliente = C.CodFiscale
	WHERE A.Data BETWEEN (CURRENT_DATE() - INTERVAL 6 DAY) AND CURRENT_DATE()
	GROUP BY C.CodFiscale, C.Nome, C.Cognome, C.DataNascita
    HAVING COUNT(*) >= 4;
END&&
DELIMITER ;

CALL op2();