-- Considerando il monitoraggio degli esercizi svolti nel mese corrente, raggruppo per giorno, centro e attrezzatura e,
-- per ogni giorno, conto quante volte è stata utilizzata ogni attrezzatura

CREATE OR REPLACE VIEW UtilizziMese AS
SELECT M.Centro, DAY(M.Istante_Inizio), M.Attrezzatura, COUNT(*) AS NumeroUtilizzi
FROM MonitoraggioEsercizio M
WHERE	MONTH(M.Istante_Inizio) = MONTH(CURRENT_DATE) AND
				YEAR(M.Istante_Inizio) = YEAR(CURRENT_DATE) AND
				M.Attrezzatura IS NOT NULL
GROUP BY DAY(M.Istante_Inizio), M.Centro, M.Attrezzatura;



DROP PROCEDURE IF EXISTS AnalisiAttrezzature;
DELIMITER $$
CREATE PROCEDURE AnalisiAttrezzature (IN _centro INT)
BEGIN

	-- Considerando il centro a cui sono interessata, proietto il numero medio di utilizzi di ogni attrezzatura nel mese corrente e 
    -- il numero di esemplari di tale attrezzatura in quel centro. 
    -- Si ipotizza che se un'attrezzatura viene utilizzata più di 10 volte in un giorno possa essere necessario l'acquisto di nuovi esemplari.

	SELECT	D.Centro, D.Attrezzatura, D.UtilizziMedi, D2.AttrezzaturePresenti,
					IF (D.UtilizziMedi > AttrezzaturePresenti * 10, 'Necessario acquisto di nuovi macchinari',
						'Dimensionamento macchinario adeguato agli utilizzi') AS Messaggio
	FROM	(	SELECT U.Centro, U.Attrezzatura, AVG(U.NumeroUtilizzi) AS UtilizziMedi
					FROM UtilizziMese U
					GROUP BY U.Centro, U.Attrezzatura
				) AS D
				
					NATURAL JOIN
                
				(	SELECT S.Centro, A.Nome AS Attrezzatura, COUNT(*) AS AttrezzaturePresenti
					FROM Attrezzatura A INNER JOIN SalaFitness S ON A.Sala = S.Nome
					GROUP BY S.Centro, A.Nome
				) AS D2
	WHERE D.Centro = _centro;

END $$
DELIMITER ;

CALL AnalisiAttrezzature ('1');