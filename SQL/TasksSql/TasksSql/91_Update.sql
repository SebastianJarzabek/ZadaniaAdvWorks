--Polecenie UPDATE - Wprowadzenie - LAB
--Sekcja 4, wyk³ad 55
--Skopiuj (tak jak to mamy w zwyczaju na tym kursie) tabelê Sales.SalesPerson z bazy danych AdventureWorks do bazy tempdb.

--Poleceniem SELECT, korzystaj¹c z funkcji AVG wyznacz œredni¹ wartoœæ sprzeda¿y w ca³ej tabeli (kolumna SalesYTD)

--Tym pracownikom, którzy maj¹ SalesYTD wiêksze od œredniej dodaj bonus wysokoœci 500

--Czy da³oby siê zrobiæ dwa poprzednie kroki jednym zapytaniem? Napisz je!

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
--Sekcja 4, wyk³ad 58
--Skopiuj (tak jak to mamy w zwyczaju na tym kursie) tabelê Sales.SalesPerson z bazy danych AdventureWorks do bazy tempdb - mo¿esz wykorzystaæ rozwi¹zanie z poprzedniego zadania

--Poleceniem SELECT, korzystaj¹c z funkcji AVG wyznacz œredni¹ wartoœæ sprzeda¿y w tabeli (kolumna SalesYTD)

--Tym pracownikom, którzy maj¹ SalesYTD mniejsze od œredniej wyzeruj  bonus .Uwzgkêdnij w instukcji UPDATE klauzulê output, która wyœwietli informacje pozwalaj¹ce zidentyfikowaæ srzedawcê i jego poprzedni i obecny bonus.

--Czy da³oby siê zrobiæ dwa poprzednie kroki jednym zapytaniem? Napisz je!

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

-- Aktualizacja rekordów w oparciu o inne tabele - LAB
--Sekcja 4, wyk³ad 61
--Skopiuj do tempdb zawartoœæ tabeli SalesOrderHeader i SalesTerritory

--Napisz zapytanie, które wyœwietli informacje o zamówieniach ( SalesOrderIf, TerritoryId i TaxAmt) po³¹czone klauzul¹ JOIN z tabel¹ Sales.Terrirtory (wyœwietl CountryRegionCode). Kolumna ³¹cz¹ca te dwie tabele to TerritoryId

--W ramach nowej umowy o sprzeda¿y produktów do Kanady nale¿y wyzerowaæ w tabeli SalesOrderHeader kolumnê TaxAmt dla zamówieñ realizowanych do terytorium z CountryRegionCode = CA

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