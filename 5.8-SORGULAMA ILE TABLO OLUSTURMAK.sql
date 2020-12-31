/*
SQL UZERINDE SORGULAMA YAPARAK, DONEN SONUCA YONELIK ILGILI SUTUNLAR ILE DOGRUDAN TABLO OLUSTURABILIRIZ.
*/

--PERSONEL MAASLARINI KONTROL EDELIM.
--MEVCUT SQL SORGUSU;
SELECT * FROM PRICE

--PERSONELLERIN MAASLARINA YONELIK BIR ARALIK BELIRLEYIP, EK TABLO UZERINDE BU VERILERI SAKLAYALIM.
--MEVCUT SQL SORGUSU;
SELECT Name AS NAME,
	   Department AS DEPARTMENT,
	   PR.Price,
	   CASE WHEN PR.Price<=2000 THEN 'LOW PRICE'
			WHEN PR.Price BETWEEN 2000 AND 5000 THEN 'MID. PRICE'
			WHEN PR.Price>=5000 THEN 'HIGH PRICE'
	   END AS 'PRICETYPE' 
INTO PERSON_PRICEEX
FROM PERSON PE
INNER JOIN PRICE PR ON PR.PersonId=PE.ID
INNER JOIN DEPARTMENT DE ON DE.DepartmentID=PE.DepartmentID

/*
SORGU SONUCUMUZA YONELIK DONEN SUTUNLAR ILE BIR ISIM BELIRLEYEREK (PERSON_PRICEEX) GEREKSINIMIMIZE YONELIK BIR TABLO OLUSTURABILIYORUZ.

DONEN SORGU SONUCUMUZA AIT TUM VERILERI "INTO PERSON_PRICEEX" KOMUTU ILE ILGILI TABLOYA GOMUYORUZ.
*/