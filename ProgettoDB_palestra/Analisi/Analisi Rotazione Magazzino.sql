

DROP PROCEDURE RotazioneMagazzino;
DELIMITER &&
CREATE PROCEDURE RotazioneMagazzino ()
BEGIN

	-- Per ogni centro, ordino i prodotti del magazzino per data di scadenza.
    -- A seconda della data di scadenza, mostro a video la percentuale con la quale il prodotto dovrebbe eseere scontato

	SELECT	D.Rank, D.Centro, D.Prodotto, D.Dosaggio, D.Scadenza,
					IF (	D.Scadenza BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL 2 MONTH,
							'40%',
                            IF (	D.Scadenza BETWEEN CURRENT_DATE + INTERVAL 2 MONTH AND CURRENT_DATE + INTERVAL 4 MONTH,
									'30%',
									'20%'
									)
						) AS ScontoConsigliato
	FROM (
					SELECT	IF (	@centro = M.Centro,
											IF(@datas = M.Scadenza,
												@rank := @rank,
												@rank := @rank + 1 + LEAST(0, @datas := M.Scadenza)),
											@rank := 1 + LEAST(0, @centro := M.Centro) + LEAST(0, @datas := M.Scadenza)
										) AS Rank, 
									M.Centro,
									M.Prodotto,
									M.Dosaggio,
									M.Scadenza
					FROM	Magazzino M,
								(SELECT (@rank := 0)) AS Cod,
								(SELECT (@centro:=0))AS CC
					ORDER BY M.Centro, M.Scadenza
					) AS D
	WHERE D.Scadenza < CURRENT_DATE + INTERVAL 6 MONTH;
    

END &&
DELIMITER ;

CALL RotazioneMagazzino();


