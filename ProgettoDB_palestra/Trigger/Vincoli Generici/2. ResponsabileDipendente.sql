-- Ogni dipendente, escluso il direttore, deve avere un responsabile
-- che deve svolgere (nello stesso centro) lo stesso lavoro del dipendente*/

DROP TRIGGER IF EXISTS ResponsabileDipendente;
DELIMITER $$
CREATE TRIGGER ResponsabileDipendente
BEFORE INSERT ON RegistroDipendenti
FOR EACH ROW
BEGIN

	DECLARE lavoro VARCHAR(45);
	SET lavoro = ( SELECT RD.Lavoro
						FROM	RegistroDipendenti RD
						WHERE	RD.Dipendente = NEW.Responsabile AND
										RD.Centro = NEW.Centro
						);
                        
	IF (lavoro <> NEW.Lavoro AND lavoro <> 'Direttore') THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attenzione: il responsabile non può svolgere lo stesso lavoro del dipendente!';
	END IF;
    
    IF (NEW.Lavoro <> 'Direttore' AND NEW.Responsabile = NULL) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attenzione: ogni dipendente deve avere un responsabile!';
	END IF;


END $$
DELIMITER ;