-- Aggiornare le informazioni fisiche di un cliente e spostare le precedenti nella sezione relativa alle informazioni passate

DROP PROCEDURE IF EXISTS op7;
DELIMITER $$
CREATE PROCEDURE op7 (
													IN _codice VARCHAR(10),
													IN _scheda VARCHAR(10),
													IN _altezza INT(10),
													IN _massa_magra FLOAT,
													IN _massa_grassa FLOAT,
													IN _peso FLOAT,
													IN _acqua_tot INT,
													IN _stato VARCHAR(15),
													IN _entita VARCHAR(15),
													IN _data DATE,
													IN _cliente VARCHAR(16)
												)
    
BEGIN
    
    DECLARE cursore CURSOR FOR
		SELECT I.Codice, C.Cliente, I.SchedaAssociata, I.Altezza, I.MassaMagra, I.MassaGrassa, I.Peso, I.AcquaTot, I.Stato, I.Entita, I.Data
		FROM Contratto C INNER JOIN SchedaAllenamento S ON C.Cod_Contratto = S.Contratto
		INNER JOIN InformazioniFisiche I ON S.Codice = I.SchedaAssociata
		WHERE C.Cliente = _cliente;
        
	DECLARE finito INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER
    FOR NOT FOUND SET finito = 1;
    
    DECLARE cliente VARCHAR(16);
    DECLARE codice VARCHAR(10);
	DECLARE scheda VARCHAR(10);
	DECLARE altezza INT(10);
	DECLARE massa_magra FLOAT;
	DECLARE massa_grassa FLOAT;
	DECLARE peso FLOAT;
	DECLARE acqua_tot INT;
	DECLARE stato VARCHAR(15);
	DECLARE entita VARCHAR(15);
	DECLARE data DATE;
    
	OPEN cursore;
    
    FETCH cursore INTO codice, cliente, scheda, altezza, massa_magra, massa_grassa, peso, acqua_tot, stato, entita, data;
    
    INSERT INTO InformazioniFisichePassate
    VALUES (codice, cliente, scheda, altezza, massa_magra, massa_grassa, peso, acqua_tot, stato, entita, data);
    
    CLOSE cursore;
    
    DELETE FROM InformazioniFisiche
    WHERE Codice = codice;
    
    INSERT INTO InformazioniFisiche
    VALUES (_codice, _cliente, _scheda, _altezza, _massa_magra, _massa_grassa, _peso, _acqua_tot, _stato, _entita, _data);
    
    
END $$
DELIMITER ; 