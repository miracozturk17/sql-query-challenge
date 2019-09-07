/*
BAZI DURUMLARDA YILLAR-DONEMLER-AYLAR YADA HAFTALAR OLARAK MEVCUT VERILERIMIZI RAPORLAMAMIZ GEREKEBILIR.

ORNEGIN AY BAZINDA YATIRILMIS OLAN PERSONEL GIDERLERI.

EXCEL UZERINDE GERCEKLESTIRILEN "PIVOT TABLE" MANTIGI EK OLARAK MSSQL UZERINDEDE GERCEKLESTIRILIBILMEKTEDIR.
*/

--MEVCUT PERSONLLERIMIZIN VERILERINI KONTROL EDELIM.
--MEVCUT SQL SORGUSU;
SELECT Name,Price,Periot FROM PERSON
INNER JOIN SENDPRICE ON PERSON.ID=SENDPRICE.PersonId

--BU YAPIYI AY BAZINDA DINAMIK OLMAYAN ANLIK VERI KUMESINDE ALMAYA CALISALIM.
--MEVCUT SQL SORGUSU;
SELECT * FROM 
	(
		SELECT Name AS [AD],Periot AS [DONEM],SUM(Price) AS [ODENMISTUTAR] 
		FROM PERSON 
		INNER JOIN SENDPRICE ON PERSON.ID=SENDPRICE.PersonId
		GROUP BY Name,Periot
	) AS TTMain
PIVOT
(SUM([ODENMISTUTAR]) FOR [DONEM] IN (TTMain.Periot)) AS PIVOTTABLE


--PEKI HER AY ILERLEYEN BIR MANTIKTA ANLIK OLARAK BU PIVOT YAPISINI NASIL GERCEKLESTIREBILIRIZ?
--BIR PROSEDUR UZERINDE BUNU GERCEKLESTIREBILIRIZ.
--MEVCUT SQL SORGUSU;
CREATE PROCEDURE sp_AyBaz�ndaPivotTable
AS
DECLARE     @TSQL       NVARCHAR(MAX)
DECLARE     @COLUMNS    NVARCHAR(MAX)
DECLARE     @ID         INT
DECLARE     @MAXId      INT
BEGIN
SELECT     DISTINCT Periot
INTO       #tmpColumns
FROM       SENDPRICE
 
SET         @ID         = 1
SET         @MAXID     = (SELECT COUNT(*) FROM #tmpColumns)
SET         @COLUMNS    = ''
SET         @TSQL       = ''
 
SELECT     ROW_NUMBER() OVER(ORDER BY Periot) AS SHORTING,*
INTO       #tmpColumnsOrder
FROM       #tmpColumns

WHILE (@ID <= @MAXId)
BEGIN
      SET @COLUMNS = @COLUMNS +
                        (    SELECT      '['+Periot+']'
                             FROM        #tmpColumnsOrder
                             WHERE       SHORTING = @ID
                        )

      SET  @ID     = @ID + 1
END
SET   @COLUMNS = REPLACE(@COLUMNS,'][','],[')
SET   @TSQL = '
      SELECT     *
      FROM       SENDPRICE
      PIVOT
      (
            SUM(Price) FOR Periot IN (' + @COLUMNS + ' )
      ) AS p
'
EXECUTE (@TSQL)

DROP TABLE #tmpColumns
DROP TABLE #tmpColumnsOrder
END

--OLUSTURDUGUMUZ YAPIYI TEST EDERSEK;
EXECUTE sp_AyBaz�ndaPivotTable