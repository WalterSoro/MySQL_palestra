-- Per ogni centro deve esistere un solo direttore 

DROP TRIGGER IF EXISTS DirettoreCentro;
DELIMITER $$
CREATE TRIGGER DirettoreCentro
BEFORE INSERT ON RegistroDipendenti
FOR EACH ROW
BEGIN
	
    IF (NEW.Lavoro = 'Direttore' AND EXISTS
    
		(	SELECT *
			FROM	RegistroDipendenti RD
			WHERE	RD.Centro = NEW.Centro AND
							RD.Lavoro = 'Direttore' 
		)) THEN 
				SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'ERRORE: è gia presente un direttore per questo centro!';
	END IF;
																			
END $$
DELIMITER ;