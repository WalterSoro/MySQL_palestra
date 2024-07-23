-- Impedire l’ordine di prodotti già scaduti

DROP TRIGGER IF EXISTS ProdottiScaduti;
DELIMITER &&
CREATE TRIGGER ProdottiScaduti
BEFORE INSERT ON Prodotti
FOR EACH ROW
BEGIN 

	IF ( NEW.Scadenza <= CURRENT_DATE ) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'ERRORE: Ordine di prodotti già scaduti!';
	END IF;
 
END &&
DELIMITER ;