--Polecenie UPDATE - Wprowadzenie - LAB
--Sekcja 4, wyk�ad 55
--Skopiuj (tak jak to mamy w zwyczaju na tym kursie) tabel� Sales.SalesPerson z bazy danych AdventureWorks do bazy tempdb.

--Poleceniem SELECT, korzystaj�c z funkcji AVG wyznacz �redni� warto�� sprzeda�y w ca�ej tabeli (kolumna SalesYTD)

--Tym pracownikom, kt�rzy maj� SalesYTD wi�ksze od �redniej dodaj bonus wysoko�ci 500

--Czy da�oby si� zrobi� dwa poprzednie kroki jednym zapytaniem? Napisz je!

USE tempdb
GO
 
SELECT * INTO dbo.SalesPerson FROM AdventureWorks.Sales.SalesPerson
GO
 
DECLARE @averageSalesYTD DECIMAL
SELECT @averageSalesYTD = AVG(SalesYTD) FROM SalesPerson
UPDATE SalesPerson
 SET Bonus += 500
 WHERE SalesYTD > @averageSalesYTD
GO
 
UPDATE SalesPerson
 SET Bonus += 500
 WHERE SalesYTD > (SELECT AVG(SalesYTD) FROM SalesPerson)


-- UPDATE - klauzula OUTPUT - LAB
--Sekcja 4, wyk�ad 58
--Skopiuj (tak jak to mamy w zwyczaju na tym kursie) tabel� Sales.SalesPerson z bazy danych AdventureWorks do bazy tempdb - mo�esz wykorzysta� rozwi�zanie z poprzedniego zadania

--Poleceniem SELECT, korzystaj�c z funkcji AVG wyznacz �redni� warto�� sprzeda�y w tabeli (kolumna SalesYTD)

--Tym pracownikom, kt�rzy maj� SalesYTD mniejsze od �redniej wyzeruj  bonus .Uwzgk�dnij w instukcji UPDATE klauzul� output, kt�ra wy�wietli informacje pozwalaj�ce zidentyfikowa� srzedawc� i jego poprzedni i obecny bonus.

--Czy da�oby si� zrobi� dwa poprzednie kroki jednym zapytaniem? Napisz je!

USE tempdb
GO
 
SELECT * INTO dbo.SalesPerson FROM AdventureWorks.Sales.SalesPerson
GO
 
DECLARE @averageSalesYTD DECIMAL
 
SELECT @averageSalesYTD = AVG(SalesYTD) FROM SalesPerson
 
UPDATE SalesPerson
 SET Bonus =0
 OUTPUT deleted.BusinessEntityID, deleted.Bonus,inserted.Bonus
 WHERE SalesYTD < @averageSalesYTD
GO
 
UPDATE SalesPerson
 SET Bonus =0
 OUTPUT deleted.BusinessEntityID, deleted.Bonus,inserted.Bonus
 WHERE SalesYTD < (SELECT AVG(SalesYTD) FROM SalesPerson)

-- Aktualizacja rekord�w w oparciu o inne tabele - LAB
--Sekcja 4, wyk�ad 61
--Skopiuj do tempdb zawarto�� tabeli SalesOrderHeader i SalesTerritory

--Napisz zapytanie, kt�re wy�wietli informacje o zam�wieniach ( SalesOrderIf, TerritoryId i TaxAmt) po��czone klauzul� JOIN z tabel� Sales.Terrirtory (wy�wietl CountryRegionCode). Kolumna ��cz�ca te dwie tabele to TerritoryId

--W ramach nowej umowy o sprzeda�y produkt�w do Kanady nale�y wyzerowa� w tabeli SalesOrderHeader kolumn� TaxAmt dla zam�wie� realizowanych do terytorium z CountryRegionCode = CA

USE tempdb
GO
 
SELECT * INTO SalesOrderHeader FROM AdventureWorks.Sales.SalesOrderHeader
GO
 
SELECT * INTO SalesTerritory FROM AdventureWorks.Sales.SalesTerritory
GO
 
SELECT 
 soh.SalesOrderID, soh.TerritoryID,soh.TaxAmt
 ,t.CountryRegionCode
FROM  SalesOrderHeader AS soh
JOIN SalesTerritory AS t on soh.TerritoryID = t.TerritoryID
GO
 
UPDATE soh
 SET TaxAmt = 0
FROM SalesOrderHeader AS soh
JOIN SalesTerritory t ON soh.TerritoryID = t.TerritoryID
WHERE t.CountryRegionCode = 'CA'
GO