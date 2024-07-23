-- Verificare ogni giorno, per ogni cliente che effettua un accesso, che non abbia nessun pagamento scaduto

DROP TRIGGER IF EXISTS op9;
DELIMITER &&
CREATE TRIGGER op9
BEFORE INSERT ON Accesso 
FOR EACH ROW
BEGIN 
	IF EXISTS(	SELECT *
						FROM Rata R INNER JOIN Contratto C 
									ON C.Cod_Contratto = R.Contratto 
						WHERE	C.Cliente = NEW.Cliente
										AND R.Stato = 'Scaduto'
						) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ATTENZIONE: IL CLIENTE HA UNA RATA SCADUTA!';
	END IF;
END &&
DELIMITER ;