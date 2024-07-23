-- Appena un cliente esce da un centro, liberare l’armadietto che gli era stato assegnato

DROP TRIGGER IF EXISTS LiberaArmadietto;
DELIMITER &&;
CREATE TRIGGER LiberaArmadietto
AFTER UPDATE ON Accesso 
FOR EACH ROW
BEGIN
	IF(NEW.Uscita IS NOT NULL) THEN
     UPDATE Armadietto
     SET Libero = 1
     WHERE  Numero = NEW.Armadietto AND
					Spogliatoio = NEW.Spogliatoio
	END IF;
END &&
DELIMITER ;