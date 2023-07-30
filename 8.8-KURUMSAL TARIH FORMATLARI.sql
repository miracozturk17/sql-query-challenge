/*
KIMI DURUMLARDA MEVCUT/ELIMIZDEKI TARIH BILGISINI/FROMATINI KURUMLARDA KULLANILAN RESMI TARIH FORMATLARINA DONUSTURMEMIZ GEREKEBILIR.

BUNUN ICIN ALT KISIMDA YER ALAN SORGULARDAN FAYDALANABILIRIZ;
*/


SELECT CONCAT(YEAR(GETDATE()),MONTH(GETDATE()),DAY(GETDATE()))
--202325 
--YIL + AY + GUN

SELECT CAST(CAST(YEAR(GETDATE()) AS CHAR(4)) + RIGHT('00' + LTRIM(MONTH(GETDATE())),2) + RIGHT('00' + LTRIM(DAY(GETDATE())),2) AS DATETIME)
--2023-02-05 00:00:00.000 
--YIL + AY + GUN + SAAT

SELECT FORMAT(CAST(GETDATE() AS DATE),'yyyyMMdd')
--20230205
--YIL + AY + GUN

SELECT FORMAT(CAST(GETDATE() AS DATE),'ddMMyyyy')
--05022023
--GUN + AY + YIL

SELECT CONCAT(FORMAT(CAST(GETDATE() AS DATE),'yyyy'),'_',FORMAT(CAST(GETDATE() AS DATE),'MM'))
--2023_02
--YIL + '_' + AY