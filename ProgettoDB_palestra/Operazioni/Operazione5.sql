-- Elencare le sfide lanciate negli ultimi 7 giorni, dagli account con credibilità massima e il
-- numero di clienti che ha accettato tale sfida

DROP PROCEDURE IF EXISTS op5;
DELIMITER &&

CREATE PROCEDURE op5()
BEGIN

	SELECT S.Proponente, S.Scopo
	FROM Account A INNER JOIN Sfida S 
				ON S.Proponente = A.Username
	WHERE	A.Credibilita = 5 AND
					S.Data_Lancio BETWEEN (CURRENT_DATE() - INTERVAL 6 DAY) AND CURRENT_DATE() ;
                    
END &&
DELIMITER ;


 CALL op5();