-- Impedire lo svolgimento di un corso in una sala o piscina
-- se queste sono occupate da altri corsi nella stessa fascia oraria

DROP TRIGGER IF EXISTS ControlloPiscine;
DELIMITER $$
CREATE TRIGGER ControlloPiscine
BEFORE INSERT ON PiscinaCorso
FOR EACH ROW
BEGIN

	DECLARE ora_fine INT;
    DECLARE test INT DEFAULT 0;
    
    SET ora_fine = (	SELECT HOUR(Orario_Fine)
								FROM Calendario
                                WHERE	Giorno = NEW.Giorno AND
												Orario_Inizio = NEW.Orario_Inizio AND
                                                Corso = NEW.Disciplina AND
                                                Livello = NEW.Livello AND
												DataInizio = NEW.Inizio
								);

	SELECT IF(ora_fine BETWEEN HOUR(Orario_inizio) AND HOUR(Orario_Fine),1, 0) INTO test
    FROM PiscinaCorso NATURAL JOIN Calendario
    WHERE	Piscina = NEW.Piscina AND
					Giorno = NEW.Giorno;
                    
	IF (test = 1) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: Piscina occupata in questa fascia oraria!';
	END IF;
	
END $$
DELIMITER ;