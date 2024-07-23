-- Elencare per ogni tipo di attrezzatura le relative regolazioni possedute e gli esercizi che le utilizzano

DROP PROCEDURE IF EXISTS op3;
DELIMITER &&

CREATE PROCEDURE op3()
BEGIN

	SELECT A.Nome AS Attrezzatura, R.Nome AS Regolazione, E.Nome AS Esercizio
	FROM Attrezzatura A LEFT OUTER JOIN Regolazione R 
				ON A.Nome = R.Attrezzatura 
				INNER JOIN Esercizio E ON A.Nome = E.Attrezzatura
	GROUP BY A.Nome, E.Nome, R.Nome;
    
END &&
DELIMITER ;

CALL op3();