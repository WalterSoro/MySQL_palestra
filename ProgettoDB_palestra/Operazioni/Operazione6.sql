-- Aggiornare un contratto scaduto e spostarlo nella sezione relativa ai contratti passati

DROP TRIGGER IF EXISTS op6;
DELIMITER &&
CREATE TRIGGER op6
BEFORE INSERT ON Contratto
FOR EACH ROW 
BEGIN

	DECLARE contratto int(11) DEFAULt 0;
    DECLARE consulente varchar(16);
    DECLARE pagamento varchar(45);
    DECLARE inizio DATE;
    DECLARE fine DATE;
    DECLARE scopo_ varchar(45);
    DECLARE intensita_ VARCHAR(45);
    
    SELECT	C.Cod_Contratto, C.CodConsulente, C.ModPagamento, C.Data_Inizio, C.Data_Fine, C.Scopo, C.Intensita
					INTO contratto, consulente, pagamento, inizio, fine, scopo_, intensita_
    FROM Contratto C
    WHERE C.Cliente = NEW.Cliente;
    
	INSERT INTO ContrattiPassati
    VALUES(  contratto, NEW.Cliente, consulente, pagamento, inizio, fine, scopo_, intensita_ );
    
    DELETE FROM contratto
    WHERE Cliente = NEW.Cliente;
    
END &&
DELIMITER ;    