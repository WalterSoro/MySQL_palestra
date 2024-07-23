-- Un istruttore non può tenere due corsi nella stessa fascia oraria del medesimo giorno

DROP TRIGGER IF EXISTS ControlloCorsi;
DELIMITER $$
CREATE TRIGGER ControlloCorsi
BEFORE INSERT ON Calendario
FOR EACH ROW
BEGIN
	
    DECLARE _istruttore VARCHAR (16);
    DECLARE Finito INT DEFAULT 0;
    DECLARE _inizio INT;
    DECLARE _fine INT;
    
    DECLARE cursore CURSOR FOR
   	SELECT Orario_inizio, Orario_Fine
    FROM Calendario NATURAL JOIN Corso
    WHERE	Istruttore = _istruttore AND 
					Giorno = NEW.Giorno;
                    
	DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET Finito = 1;
    
    SET _istruttore = (	SELECT	Istruttore
									FROM Corso
									WHERE	Disciplina = NEW.Corso AND
													Livello = NEW.Livello AND
													Inizio = NEW.Orario_Inizio
								);
                                
	OPEN cursore;
    
    copia: LOOP
    
		FETCH cursore INTO _inizio, _fine;
		
        IF ( (HOUR(NEW.Orario_Inizio) BETWEEN _inizio AND _fine) OR
			   (HOUR(NEW.Orario_Fine) BETWEEN _inizio AND _fine)
			) THEN
				SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'ERRORE: l''istruttore segue un altro corso in questa fascia oraria!';
		END IF;
	END LOOP;
    
    CLOSE cursore;
	
							
END $$
DELIMITER ;