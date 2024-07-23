-- Un cliente non può effettuare un accesso senza prima essere uscito dal precedente

DROP TRIGGER IF EXISTS ControlloAccessi;
DELIMITER $$
CREATE TRIGGER ControlloAccessi
BEFORE INSERT ON Accesso
FOR EACH ROW
BEGIN
	
	IF EXISTS (
						SELECT *
						FROM Accesso A
						WHERE	A.Cliente = NEW.Cliente AND
										A.Data = (	SELECT MAX(Data)
															FROM Accesso
															WHERE Cliente = NEW.Cliente
														) 
										AND A.OrarioIngresso = (	SELECT MAX(OrarioIngresso)
																					FROM Accesso
																					WHERE	Cliente = NEW.Cliente AND
																									Data = A.Data
																				)
										AND A.Uscita = NULL
                            )
	THEN 
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attenzione: ingresso non consentito!';
	END IF;
							

END $$
DELIMITER ;