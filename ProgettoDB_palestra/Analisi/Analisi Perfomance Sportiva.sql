

DROP TRIGGER IF EXISTS InserisciPerformance;
DELIMITER $$
CREATE TRIGGER InserisciPerformance
AFTER INSERT ON MonitoraggioEsercizio
FOR EACH ROW
BEGIN

	DECLARE _esercizio FLOAT;
    DECLARE _monitoraggio FLOAT;
    DECLARE percentuale INT;
    
    
    -- calcolo una media tra i parametri dell'esercizio svolto tenendo conto della loro importanza, cioè si sommano i valori di ogni parametro moltiplicati
    -- per la relativa importanza e si divide il tutto per la somma delle importanze
    
    SELECT ( (Ripetizioni*10) + (Serie*10) + (Durata*6) + (IF(Recupero <> NULL, Recupero * 7, 0)) + (IF(Regolazione <> NULL, Intensita * 7, 0)) )/
					(10 + 10 + 6 + (IF(Recupero <> NULL, 7, 0)) + (IF(Regolazione <> NULL, 7, 0)) ) INTO _monitoraggio
    FROM MonitoraggioEsercizio
    WHERE	Istante_Inizio = NEW.Istante_Inizio AND
					GiornoAllenamento = NEW.GiornoAllenamento AND
					SchedaAssociata = NEW.SchedaAssociata AND
                    Esercizio = NEW.Esercizio;


    -- calcolo una media tra i parametri dell'esercizio che avrebbe dovuto svolgere tenendo conto della loro importanza,
    -- cioè si sommano i valori di ogni parametro moltiplicati per la relativa importanza e si divide il tutto per la somma delle importanze

	SELECT ( (Ripetizioni*10) + (Serie*10) + (Durata*6) + (IF(Recupero <> NULL, Recupero * 7, 0)) + (IF(Regolazione <> NULL, Intensita * 7, 0)) )/
					(10 + 10 + 6 + (IF(Recupero <> NULL, 7, 0)) + (IF(Regolazione <> NULL, 7, 0)) ) INTO _esercizio
    FROM Esercizio
    WHERE	GiornoAllenamento = NEW.GiornoAllenamento AND
					SchedaAssociata = NEW.SchedaAssociata AND
                    Nome = NEW.Esercizio;
                    
                    
                    
    -- calcolo la percentuale di fedeltà dell'esercizio rapportando la media dell'esercizio svolto con la media dell'esercizio
    -- indicato dalla scheda di allenamento
    
	SET percentuale = (_monitoraggio*100)/_esercizio;
    
    
    -- Inserisco nella tabella "Performance" i dati relativi all'esercizio e la percentuale di fedeltà
    
    INSERT INTO Performance
    VALUES (NEW.Istante_Inizio, NEW.Esercizio, NEW.GiornoAllenamento, NEW.SchedaAssociata, percentuale);
    
END $$
DELIMITER ;


DROP PROCEDURE IF EXISTS PerformanceSportiva;
DELIMITER $$
CREATE PROCEDURE PerformanceSportiva ( IN _scheda INT)
BEGIN


	-- mostro, per ogni esercizio della scheda di allenamento, se deve essere potenziato (fedeltà media maggiore del 100%) o 
    -- alleggerito (fedeltà media minore del 100%) e anche la percentuale di modifica dello stesso (differenza, in modulo, tra 100 e la fedeltà dell’esercizio).

	SELECT 	SchedaAssociata, Esercizio, GiornoAllenamento, 
					IF(AVG(Fedelta)-100 >=0, 'Potenziamento','Allegerimento') AS Cambiamento, ABS(AVG(Fedelta)-100) AS PercentualeCambiamento
    FROM Performance
    WHERE SchedaAssociata = _scheda
    GROUP BY GiornoAllenamento, SchedaAssociata, Esercizio;
    

END $$
DELIMITER ;

CALL PerformanceSportiva('301');