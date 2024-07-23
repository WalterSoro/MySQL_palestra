-- Un contratto standard non può avere più comfort del suo modello

DROP TRIGGER IF EXISTS ContrattoPlatinum;
DELIMITER $$
CREATE TRIGGER ContrattoPlatinum
BEFORE INSERT ON CaratteristicheContratto
FOR EACH ROW
BEGIN

	IF (	( Tipo = 'Platinum' AND
			  Personalizzato = 'no' ) AND
            ( Ingressi_max <> NULL OR
              PiscineInt <> 12 OR
              PiscineEst <> 12 OR
			  Sale <> 'Platinum')
			)
	THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ERRORE: caratteristiche contratto non adeguate per il tipo Platinum';
	END IF;			

END $$
DELIMITER ;