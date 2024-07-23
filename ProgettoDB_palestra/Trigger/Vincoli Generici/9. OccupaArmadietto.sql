-- Impedire l’assegnamento di armadietti occupati e, dopo un accesso, rendere occupato quello assegnato

DROP TRIGGER IF EXISTS OccupaArmadietto;
DELIMITER &&
CREATE TRIGGER OccupaArmadietto
AFTER INSERT ON Accesso
FOR EACH ROW
BEGIN 

	UPDATE Armadietto
    SET Libero = 0
    WHERE	Numero = NEW.Armadietto AND
					Spogliatoio = NEW.Spogliatoio;
END &&
DELIMITER ;