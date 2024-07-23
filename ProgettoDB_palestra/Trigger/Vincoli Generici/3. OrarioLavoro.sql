-- Gli orari di lavoro dei dipendenti devono sempre iniziare e finire
-- al cambio dell’ora (cioè devono essere nel formato hh:00:00)

DROP TRIGGER IF EXISTS OrarioLavoro;
DELIMITER $$
CREATE TRIGGER OrarioLavoro
BEFORE INSERT ON TurnazionePersonale
FOR EACH ROW
BEGIN

	IF (	(MINUTE(NEW.Inizio) <> 0 ) OR
			(SECOND(NEW.Inizio) <> 0 ) OR
            (MINUTE(NEW.Fine) <> 0 ) OR
			(SECOND(NEW.Fine) <> 0)
		)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: Formato orario non adeguato';
	END IF;
    
END $$
DELIMITER ;