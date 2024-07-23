-- Un contratto standard non può avere più comfort del suo modello

DROP TRIGGER IF EXISTS ContrattoGold;
DELIMITER $$
CREATE TRIGGER ContrattoGold
BEFORE INSERT ON CaratteristicheContratto
FOR EACH ROW
BEGIN

	IF (	( Tipo = 'Gold' AND
			  Personalizzato = 'no' ) AND
            ( Ingressi_max <> 4 OR
              PiscineInt <> 4 OR
              PiscineEst <> 4 OR
              Sale <> 'Gold')
			)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: caratteristiche contratto non adeguate per il tipo Gold';
	END IF;			

END $$
DELIMITER ;