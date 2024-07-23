DROP TRIGGER IF EXISTS AggiornaCredibilita;
DELIMITER $$
CREATE TRIGGER AggiornaCredibilita
AFTER INSERT ON Risposta
FOR EACH ROW
BEGIN

	DECLARE NumeroPost INT DEFAULT 0;
    DECLARE Valutazione INT DEFAULT 0;
    
    SELECT SUM(Voto), COUNT(*) INTO Valutazione, NumeroPost
    FROM Risposta
	WHERE AutorePost = NEW.AutorePost;

	UPDATE Account
    SET	Credibilita = Valutazione/NumeroPost
    WHERE	Username = NEW.AutorePost;

END $$
DELIMITER ;