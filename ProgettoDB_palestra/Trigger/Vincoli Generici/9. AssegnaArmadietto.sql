-- Impedire l’assegnamento di armadietti occupati e, dopo un accesso,
-- rendere occupato quello assegnato

DROP TRIGGER IF EXISTS AssegnaArmadietto;
DELIMITER &&
CREATE TRIGGER AssegnaArmadietto
BEFORE INSERT ON Accesso
FOR EACH ROW
BEGIN 

	IF( 0 = ( 	SELECT Libero
					FROM Armadietto 
					WHERE	Spogliatoio = NEW.Spogliatoio AND
									Numero = NEW.Armadietto
				)
	) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: Armadietto occupato';
	END IF;
    
END &&
DELIMITER ;
