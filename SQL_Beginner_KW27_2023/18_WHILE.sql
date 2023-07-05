--WHILE Statement leitet Schleifen/Loops ein


WHILE 1=1 --WHILE Bedingung wird vor jedem Durchlauf geprüft; Wird solange wiederholt bis Bedingung FALSE ist
BEGIN --leitet Loop Statement ein

SELECT 'Stuck in a Loop'

END --schließt Loop Statement


DECLARE @Counter int = 0

WHILE @Counter < 5
BEGIN

SELECT @Counter
SET @Counter += 1
END


