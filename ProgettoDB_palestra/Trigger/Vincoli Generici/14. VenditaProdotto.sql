-- Dopo ogni vendita la quantità di prodotti in magazzino deve essere aggiornata

DROP TRIGGER IF EXISTS VenditaProdotto;
DELIMITER &&

CREATE TRIGGER VenditaProdotto
AFTER INSERT ON Vendite
FOR EACH ROW
BEGIN
	UPDATE Magazzino
    SET Quantita = Quantita - NEW.Quantita
    WHERE	Prodotto = NEW.Prodotto AND
					Scadenza = NEW.Scadenza AND
					Centro = NEW.Centro AND
					Dosaggio = NEW.Dosaggio;
END &&
DELIMITER ;
