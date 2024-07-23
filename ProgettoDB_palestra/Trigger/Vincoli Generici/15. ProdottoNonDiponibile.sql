-- Impedire la vendita di prodotti per una quantità maggiore di quella presente in magazzino o di prodotti non presenti

DROP TRIGGER IF EXISTS ProdottoNonDisponibile;
DELIMITER &&

CREATE TRIGGER ProdottoNonDisponibile
BEFORE INSERT ON Vendite
FOR EACH ROW
BEGIN
	DECLARE NumProdotti INT DEFAULT 0;
	SET NumProdotti = (	SELECT M.Quantita
										FROM Magazzino M INNER JOIN Ordine O 
													ON M.Ordine = O.Codice
										WHERE	M.Prodotto = NEW.Prodotto AND
														M.Scadenza = NEW.Scadenza AND
														M.Dosaggio = NEW.Dosaggio AND
														M.Centro = NEW.Centro AND
														O.Stato = 'Consegnato'
									);
	IF(NumProdotti < NEW.Quantita OR NOT EXISTS(	SELECT *
																						FROM Magazzino M
																						WHERE	M.Prodotto = NEW.Prodotto AND
																										M.Scadenza = NEW.Scadenza AND
                                                                                                        M.Centro = NEW.Centro
																						)) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: Prodotto NON disponibile';
	END IF;
END &&
DELIMITER ;