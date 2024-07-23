-- Un dipendente non può lavorare più di 8 ore al giorno

DROP TRIGGER IF EXISTS ControlloLavoro;
DELIMITER $$
CREATE TRIGGER ControlloLavoro
BEFORE INSERT ON TurnazionePersonale
FOR EACH ROW
BEGIN
	
    DECLARE ore TIME DEFAULT '00:00:00';
    DECLARE ore_tot INT DEFAULT 0;
    DECLARE finito INT DEFAULT 0;
    
    DECLARE cursore CURSOR FOR
    SELECT TIMEDIFF(Fine, Inizio)
    FROM TurnazionePersonale
    WHERE	Dipendente = NEW.Dipendente AND
					Data = NEW.Data;
   
   DECLARE CONTINUE HANDLER
   FOR NOT FOUND SET finito = 1;
   
   OPEN cursore;
   
	copia: LOOP
   
		FETCH cursore INTO ore;
    
		IF Finito = 1 THEN
			LEAVE copia;
		END IF;
		
		SET ore_tot = ore_tot + HOUR(ore);
    
	END LOOP;

	IF (ore_tot + HOUR((TIMEDIFF(NEW.Fine, NEW.Inizio) ) ) > 8) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attenzione: un dipendente non può lavorare più di 8 ore al giorno';
	END IF;


END $$
DELIMITER ;