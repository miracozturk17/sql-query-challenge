/*
SQL SSERVER UZERINDE VERI MANIPULASYONU UZERINE FARKLLI BIR YONTEM OLARAK CURSOR KULLANIMI MEVCUTTUR.
*/

SELECT * FROM PRODUCTSALES

--ID DEGERI 1000 ALTINDA BULUNAN URUNLERIN MIKTARINI DEGISTIRELIM.
--MEVCUT SQL SORGUSU;
DECLARE @SalesId INT
DECLARE @Quantity INT

SET @Quantity =100

DECLARE ProductSalesCursor CURSOR FOR
SELECT SalesId,Quantity FROM PRODUCTSALES WHERE SalesId <1000

OPEN ProductSalesCursor

FETCH NEXT FROM ProductSalesCursor INTO @SalesId,@Quantity

WHILE (@@FETCH_STATUS = 0)
BEGIN
		PRINT 'ID = ' + CAST(@SalesId AS NVARCHAR(10)) + ' QUANTITY = ' + CAST(@Quantity AS NVARCHAR(10))
		FETCH NEXT FROM ProductSalesCursor INTO @Quantity
END
CLOSE ProductSalesCursor
DEALLOCATE ProductSalesCursor