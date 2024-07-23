-- Elencare, per ogni impiegato avente meno di 35 anni compiuti, i suoi dati e le informazioni dei centri in cui lavora

DROP PROCEDURE IF EXISTS op1;
DELIMITER &&

CREATE PROCEDURE op1()
BEGIN
	SELECT D.CodFiscale AS Dipendente, D.Nome, D.Cognome, D.Sesso, D.DataNascita, C.Codice, C.Indirizzo, C.Citta
	FROM RegistroDipendenti RD INNER JOIN Dipendente D
				ON RD.Dipendente = D.CodFiscale
				INNER JOIN Centro C ON RD.Centro = C.Codice
	GROUP BY D.CodFiscale, RD.Centro
	HAVING D.DataNascita + INTERVAL 35 YEAR > CURRENT_DATE();
END &&
DELIMITER ;


-- Elencare i dati dei clienti che, nella settimana corrente, hanno eseguito almeno 4 accessi

DROP PROCEDURE IF EXISTS op2;
DELIMITER &&

CREATE PROCEDURE op2()
BEGIN
	SELECT C.CodFiscale, C.Nome, C.Cognome, C.Datanascita
	FROM Accesso A INNER JOIN Cliente C
			ON A.Cliente = C.CodFiscale
	WHERE A.Data BETWEEN (CURRENT_DATE() - INTERVAL 6 DAY) AND CURRENT_DATE()
	GROUP BY C.CodFiscale, C.Nome, C.Cognome, C.DataNascita
    HAVING COUNT(*) >= 4;
END&&
DELIMITER ;

CALL op2();


-- Elencare per ogni tipo di attrezzatura le relative regolazioni possedute e gli esercizi che le utilizzano

DROP PROCEDURE IF EXISTS op3;
DELIMITER &&

CREATE PROCEDURE op3()
BEGIN

	SELECT A.Nome AS Attrezzatura, R.Nome AS Regolazione, E.Nome AS Esercizio
	FROM Attrezzatura A LEFT OUTER JOIN Regolazione R 
				ON A.Nome = R.Attrezzatura 
				INNER JOIN Esercizio E ON A.Nome = E.Attrezzatura
	GROUP BY A.Nome, E.Nome, R.Nome;
    
END &&
DELIMITER ;

CALL op3();


-- Indicare, per ogni integratore presente nel database, il centro che ne ha gestito il maggior numero di ordini

DROP PROCEDURE IF EXISTS op4;
DELIMITER $$
CREATE PROCEDURE op4()

BEGIN

	SELECT I.Nome, I.Dosaggio, O.Centro
	FROM Integratore I LEFT OUTER JOIN Prodotti P ON (I.Nome = P.Integratore AND I.Dosaggio = P.Dosaggio)
				INNER JOIN Ordine O ON P.Ordine = O.Codice
	GROUP BY I.Nome, I.Dosaggio, O.Centro
	HAVING SUM(P.Quantita) > ALL (	SELECT SUM(P2.Quantita)
															FROM	Prodotti P2 INNER JOIN Ordine O2 ON P2.Ordine = O2.Codice
															WHERE	P2.Integratore = I.Nome AND
																			P2.Dosaggio = I.Dosaggio AND
																			O2.Centro <> O.Centro
															GROUP BY O2.Centro
															);
                                                            
END $$
DELIMITER ;

CALL op4();
													

-- Elencare le sfide lanciate negli ultimi 7 giorni, dagli account con credibilità massima e il
-- numero di clienti che ha accettato tale sfida

DROP PROCEDURE IF EXISTS op5;
DELIMITER &&

CREATE PROCEDURE op5()
BEGIN

	SELECT S.Proponente, S.Scopo
	FROM Account A INNER JOIN Sfida S 
				ON S.Proponente = A.Username
	WHERE	A.Credibilita = 5 AND
					S.Data_Lancio BETWEEN (CURRENT_DATE() - INTERVAL 6 DAY) AND CURRENT_DATE() ;
                    
END &&
DELIMITER ;


 CALL op5();
 
 
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
    
    SELECT	C.Cod_Contratto, C.CodConsulente, C.ModPagamento, C.Datainizio, C.DataFine, C.Scopo, C.Intensita
					INTO contratto, consulente, pagamento, inizio, fine, scopo_, intensita_
    FROM Contratto C
    WHERE C.Cliente = NEW.Cliente;
    
	INSERT INTO ContrattiPassati
    VALUES(  contratto, NEW.Cliente, consulente, pagamento, inizio, fine, scopo_, intensita_ );
    
    DELETE FROM contratto
    WHERE Cliente = NEW.Cliente;
    
END &&
DELIMITER ;    


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

-- Verificare se le attrezzatture sono agibili e, in caso negativo, renderle agibili

DROP EVENT IF EXISTS op8;
CREATE EVENT op8
ON SCHEDULE EVERY 12 HOUR
STARTS '2018-04-12 08:00:00'
DO

	UPDATE Attrezzatura
    SET Liv_Usura = 0
    WHERE Liv_Usura = 100;
    
    
-- Verificare ogni giorno, per ogni cliente che effettua un accesso, che non abbia nessun pagamento scaduto

DROP TRIGGER IF EXISTS op9;
DELIMITER &&;

CREATE TRIGGER op9
BEFORE INSERT ON Accesso 
FOR EACH ROW
BEGIN 
	IF EXISTS(	SELECT *
						FROM Rata R INNER JOIN Contratto C 
									ON C.Cod_Contratto = R.Contratto 
						WHERE	C.Cliente = NEW.Cliente
										AND R.Stato = 'Scaduto'
						) THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'ATTENZIONE: IL CLIENTE HA UNA RATA SCADUTA!';
	END IF;
END &&
DELIMITER ;