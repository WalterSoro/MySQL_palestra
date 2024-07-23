DROP TRIGGER IF EXISTS SuggerimentiCerchia;
DELIMITER $$
CREATE TRIGGER SuggerimentiCerchia
AFTER UPDATE ON Richiesta
FOR EACH ROW
BEGIN


	DECLARE _cerchia VARCHAR(45) DEFAULT NULL;
	DECLARE _amico VARCHAR(45) DEFAULT NULL;
    DECLARE finito INT DEFAULT 0;

    DECLARE cursore1 CURSOR FOR
    SELECT	C.Nome, NEW.Ricevente
	FROM	Cerchia C INNER JOIN Preferenze P ON C.Nome = P.Interesse
	WHERE	C.Account = NEW.Richiedente AND P.Account = NEW.Ricevente;
    
    DECLARE cursore2 CURSOR FOR
    SELECT	C.Nome, NEW.Richiedente
	FROM	Cerchia C INNER JOIN Preferenze P ON C.Nome = P.Interesse
	WHERE	C.Account = NEW.Ricevente AND P.Account = NEW.Richiedente;
    
    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET finito = 1;

    
	IF (NEW.Stato = 'Accettata') THEN
    
	BEGIN
    
		OPEN cursore1;
        
        loop1: LOOP
        
			FETCH cursore1 INTO _cerchia, _amico;
            
            IF finito = 1 THEN
				LEAVE loop1;
			END IF;
    
			INSERT INTO AmiciCerchia
			VALUES (_cerchia, NEW.Richiedente, _amico, 'Suggerito');
					
        END LOOP;
        
        CLOSE cursore1;
    
		SET _cerchia = NULL;
		SET _amico = NULL;
		SET finito = 0;
    
		OPEN cursore2;
        
        loop2: LOOP
        
			FETCH cursore2 INTO _cerchia, _amico;
            
            IF finito = 1 THEN
				LEAVE loop2;
			END IF;
    
			INSERT INTO AmiciCerchia
			VALUES (_cerchia, NEW.Ricevente, _amico, 'Suggerito');
        
        END LOOP;
        
	END;
        
	
    END IF;
    

END $$
DELIMITER ;