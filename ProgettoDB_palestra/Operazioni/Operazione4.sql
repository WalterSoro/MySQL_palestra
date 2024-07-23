-- Indicare, per ogni integratore presente nel database, il centro che ne ha gestito il maggior numero di ordini


DROP PROCEDURE IF EXISTS op4;
DELIMITER $$
CREATE PROCEDURE op4()

BEGIN

	SELECT I.Nome, I.Dosaggio, O.Centro
	FROM Integratore I LEFT OUTER JOIN Prodotti P ON (I.Nome = P.Integratore AND I.Dosaggio = P.Dosaggio)
				INNER JOIN Ordine O ON P.Ordine = O.Codice
	GROUP BY I.Nome, I.Dosaggio, O.Centro
	HAVING SUM(P.Quantita) > ALL (	SELECT SUM(P2.Quantita)
															FROM	Prodotti P2 INNER JOIN Ordine O2 ON P2.Ordine = O2.Codice
															WHERE	P2.Integratore = I.Nome AND
																			P2.Dosaggio = I.Dosaggio AND
																			O2.Centro <> O.Centro
															GROUP BY O2.Centro
															);
                                                            
END $$
DELIMITER ;

CALL op4();
													
