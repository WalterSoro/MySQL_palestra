-- Un dipendente non può lavorare in due centri diversi nello stesso giorno

DROP TRIGGER LuogoLavoro;
DELIMITER $$
CREATE TRIGGER LuogoLavoro
BEFORE INSERT ON TurnazionePersonale
FOR EACH ROW
BEGIN

	IF EXISTS (	SELECT *
						FROM TurnazionePersonale T
						WHERE	T.Dipendente = NEW.Dipendente AND
										T.Data = NEW.Data AND
                                        T.Centro <> NEW.Centro
						) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Attenzione: il dipendente non può lavorare in due diversi centri lo stesso giorno';
	END IF;					

END $$
DELIMITER ;