-- La view conta, per ogni corso di ogni centro, il numero di iscritti
-- e ne calcola la percentuale rispetto al numero masismo di partecipanti

CREATE OR REPLACE VIEW PartecipantiCorso AS
SELECT C.Centro, C.Disciplina, C.Livello, C.Inizio, COUNT(DISTINCT A.Cliente) AS Partecipanti,
				(COUNT(DISTINCT A.Cliente)*100)/C.Max_Iscritti AS PercentualePartecipanti
FROM Corso C INNER JOIN Attivita A
			ON (C.Disciplina = A.Corso AND C.Livello = A.Livello AND C.Inizio = A.DataInizio)
GROUP BY C.Centro, C.Disciplina, C.Livello, C.Inizio;



DROP PROCEDURE AnalisiCorsi;
DELIMITER $$
CREATE PROCEDURE AnalisiCorsi (IN _centro INT(11))
BEGIN

	-- Mostra i corsi scarsamente frequentati (cioè partecipazione inferiore al 60%) del centro a
    -- cui sono interessata

	SELECT P.Disciplina, P.Livello, P.PercentualePartecipanti
	FROM PartecipantiCorso P
	WHERE	P.PercentualePartecipanti < 60 AND
					P.Centro = _centro
	ORDER BY P.PercentualePartecipanti;

END $$
DELIMITER ;

CALL AnalisiCorsi (1);