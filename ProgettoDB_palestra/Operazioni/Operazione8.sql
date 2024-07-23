-- Verificare se le attrezzatture sono agibili e, in caso negativo, renderle agibili

DROP EVENT IF EXISTS op8;
CREATE EVENT op8
ON SCHEDULE EVERY 12 HOUR
STARTS '2018-04-12 08:00:00'
DO

	UPDATE Attrezzatura
    SET Liv_Usura = 0
    WHERE Liv_Usura = 100;