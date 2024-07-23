-- Una Richiesta di amicizia deve essere inserita con lo stato “In Attesa”

DROP TRIGGER IF EXISTS NuovaRichiesta;
DELIMITER &&
CREATE TRIGGER NuovaRichiesta
BEFORE INSERT ON Richiesta
FOR EACH ROW
BEGIN

 IF(NEW.Stato <> 'In Attesa') THEN
  SIGNAL SQLSTATE '45000'
  SET MESSAGE_TEXT = 'ERRORE: La richiesta di amicizia deve essere inserita come In Attesa!!';
 END IF;
 
END &&
DELIMITER ;