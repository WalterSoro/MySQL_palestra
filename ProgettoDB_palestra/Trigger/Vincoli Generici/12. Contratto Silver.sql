-- Un contratto standard non può avere più comfort del suo modello

DROP TRIGGER IF EXISTS ContrattoSilver;
DELIMITER $$
CREATE TRIGGER ContrattoSilver
BEFORE INSERT ON CaratteristicheContratto
FOR EACH ROW
BEGIN

	IF (	( Tipo = 'Silver' AND
			  Personalizzato = 'no' ) AND
            ( Ingressi_max <> 2 OR
              PiscineInt <> 0 OR
              PiscineEst <> 0 OR
              Sale <> 'Silver')
			)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: caratteristiche contratto non adeguate per il tipo Silver';
	END IF;			

END $$
DELIMITER ;