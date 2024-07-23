-- La view IngressiPiscineInt conta, per ogni cliente, quanti accessi sono stati effettuati alle piscine interne nell'ultimo mese 

CREATE OR REPLACE VIEW IngressiPiscineInt AS
SELECT Cliente, COUNT(*) AS NumeroIngressi
FROM Accesso
WHERE YEAR(Data) = YEAR(CURRENT_DATE) AND
				MONTH(Data) = MONTH(CURRENT_DATE)
GROUP BY	Cliente, PiscinaInt
HAVING PiscinaInt = 1;


-- La view IngressiPiscineEst conta, per ogni cliente, quanti accessi sono stati effettuati alle piscine esterne nell'ultimo mese 

CREATE OR REPLACE VIEW IngressiPiscineEst AS
SELECT Cliente, COUNT(*) AS NumeroIngressi
FROM Accesso
WHERE YEAR(Data) = YEAR(CURRENT_DATE) AND
				MONTH(Data) = MONTH(CURRENT_DATE)
GROUP BY	Cliente, PiscinaEst
HAVING PiscinaEst= 1;

-- Per ogni cliente conta il numero di accessi ai centri nell'ultimo mese, affiancando poi i risultati ottenuti dalle view precedenti

CREATE OR REPLACE VIEW IngressiPerCliente AS
SELECT	A.Cliente, COUNT(*) AS IngressiSale,
				PI.NumeroIngressi AS IngressiPiscineInt, PE.NumeroIngressi AS IngressiPiscineEst
FROM Accesso A LEFT OUTER JOIN IngressiPiscineInt PI ON A.Cliente = PI.Cliente
			LEFT OUTER JOIN IngressiPiscineEst PE ON A.Cliente = PE.Cliente
WHERE YEAR(Data) = YEAR(CURRENT_DATE) AND
				MONTH(Data) = MONTH(CURRENT_DATE)
GROUP BY A.Cliente;


DROP PROCEDURE IF EXISTS CalcolaPromozione;
DELIMITER $$
CREATE PROCEDURE CalcolaPromozione ( IN _cliente VARCHAR(16) )

BEGIN

	DECLARE Interne INT;
    DECLARE Esterne INT;
    DECLARE Sale INT;

	-- Per ogni cliente verifico se sono stati effettuati più ingressi da quelli specificati dal proprio contratto, in modo da rendere possibile la creazione di pacchetti
	-- promozionali su misura per tale cliente

	SELECT	IF(IC.IngressiPiscineInt - CC.PiscineInt > 0, IC.IngressiPiscineInt - CC.PiscineInt, NULL) AS IngressiPiscineIntOltreSoglia,
					IF(IC.IngressiPiscineEst - CC.PiscineEst > 0, IC.IngressiPiscineEst - CC.PiscineEst, NULL) AS IngressiPiscineEstOltreSoglia,
					IF(IC.IngressiSale - (CC.Ingressi_max*4) > 0, IC.IngressiSale - (CC.Ingressi_max*4), NULL) AS IngressiSaleOltreSoglia
                    INTO Interne, Esterne, Sale
	FROM Contratto C INNER JOIN CaratteristicheContratto CC ON C.Cod_Contratto = CC.Contratto
				NATURAL JOIN IngressiPerCliente IC
	WHERE C.Cliente = _cliente;
    
    
    -- Confeziono pacchetti promozionali standard a seconda del numero di ingressi fatti oltre la soglia 
    -- massima dettata dai contratti
    
    DROP TABLE IF EXISTS Promozione;
    CREATE TEMPORARY TABLE Promozione (
		Luogo VARCHAR (45),
        Num_Ingressi INT, 
        Sconto VARCHAR(10),
        PRIMARY KEY (Luogo)
	);
    
    IF (Interne > 0 AND Interne <= 5) THEN
		INSERT INTO Promozione
        VALUES ('Piscine interne', 5, '10%');
	END IF;
	IF (Interne > 5 AND Interne <= 10) THEN
		INSERT INTO Promozione
        VALUES ('Piscine interne', 10, '15%');
	END IF;
	IF (Interne > 10) THEN
		INSERT INTO Promozione
        VALUES ('Piscine interne', 15, '20%');
	END IF;
    
    
    IF (Esterne > 0 AND Esterne <= 5) THEN
		INSERT INTO Promozione
        VALUES ('Piscine Esterne', 5, '10%');
	END IF;
	IF (Esterne> 5 AND Esterne <= 10) THEN
		INSERT INTO Promozione
        VALUES ('Piscine esterne', 10, '15%');
	END IF;
	IF (Esterne > 10) THEN
		INSERT INTO Promozione
        VALUES ('Piscine esterne', 15, '20%');
	END IF;
    
    
    IF (Sale > 0 AND Sale <= 5) THEN
		INSERT INTO Promozione
        VALUES ('Sale', 5, '10%');
	END IF;
	IF (Sale> 5 AND Sale <= 10) THEN
		INSERT INTO Promozione
        VALUES ('Sale', 10, '15%');
	END IF;
	IF (Sale > 10) THEN
		INSERT INTO Promozione
        VALUES ('Sale', 15, '20%');
	END IF;
    
    
    SELECT *
    FROM Promozione;

END $$
DELIMITER ;

CALL CalcolaPromozione ('aaa01');