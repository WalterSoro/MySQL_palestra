DROP TRIGGER IF EXISTS InserisciPerformance;
DELIMITER $$
CREATE TRIGGER InserisciPerformance
AFTER INSERT ON MonitoraggioEsercizio
FOR EACH ROW
BEGIN

	DECLARE _esercizio FLOAT;
    DECLARE _monitoraggio FLOAT;
    DECLARE percentuale INT;
    
    SELECT ( (Ripetizioni*10) + (Serie*10) + (Durata*6) + (IF(Recupero <> NULL, Recupero * 7, 0)) + (IF(Regolazione <> NULL, Intensita * 7, 0)) )/
					(10 + 10 + 6 + (IF(Recupero <> NULL, 7, 0)) + (IF(Regolazione <> NULL, 7, 0)) ) INTO _monitoraggio
    FROM MonitoraggioEsercizio
    WHERE	Istante_Inizio = NEW.Istante_Inizio AND
					GiornoAllenamento = NEW.GiornoAllenamento AND
					SchedaAssociata = NEW.SchedaAssociata AND
                    Esercizio = NEW.Esercizio;


	SELECT ( (Ripetizioni*10) + (Serie*10) + (Durata*6) + (IF(Recupero <> NULL, Recupero * 7, 0)) + (IF(Regolazione <> NULL, Intensita * 7, 0)) )/
					(10 + 10 + 6 + (IF(Recupero <> NULL, 7, 0)) + (IF(Regolazione <> NULL, 7, 0)) ) INTO _esercizio
    FROM Esercizio
    WHERE	GiornoAllenamento = NEW.GiornoAllenamento AND
					SchedaAssociata = NEW.SchedaAssociata AND
                    Nome = NEW.Esercizio;
                    
                    
	SET percentuale = (_monitoraggio*100)/_esercizio;
    
    INSERT INTO Performance
    VALUES (NEW.Istante_Inizio, NEW.Esercizio, NEW.GiornoAllenamento, NEW.SchedaAssociata, percentuale);
    
END $$
DELIMITER ;