--Polecenie DELETE - wprowadzenie - LAB
--Sekcja 3, wyk³ad 37
--Przepisz do tempdb te same tabele co na lekcji video: Production.Product, Sales.SalesOrderHeader, Sales.SalesOrderDetail. Zachowaj ten skrypt, bo przyda siê w kolejnych zadaniach, kiedy polecenia bêd¹ dotyczy³y kasowania lub aktualizacji rekordów w tych tabelach. (Po wy³¹czeniu SQL Server zawartoœæ bazy danych tempdb sie zeruje)

--Usuñ z tabeli product produkt nr 500

--Usuñ z tabeli produkt produkty, które maj¹ styl ‘U’ i kolor ‘Multi’ i kosz standardowy maj¹ wiêkszy ni¿ 30

SELECT * INTO tempdb.dbo.Product FROM AdventureWorks.Production.Product
GO
SELECT * INTO tempdb.dbo.SalesOrderHeader FROM AdventureWorks.Sales.SalesOrderHeader
GO
SELECT * INTO tempdb.dbo.SalesOrderDetail FROM AdventureWorks.Sales.SalesOrderDetail
GO

USE tempdb
GO

DELETE FROM  Product WHERE ProductID = 500
GO

DELETE FROM Product WHERE Style = 'U' AND Color = 'Multi' AND StandardCost>30
GO

--Kasowanie czêœci rekordów - DELETE TOP - LAB
--Sekcja 3, wyk³ad 40
--Przekopuj zawartoœæ tabeli Sales.SalesOrderDetail do tempdb (mo¿esz skorzystaæ z czêœci skryptu z poprzedniego zadania)

--Usuñ 100 rekordów z przekopiowanej tabeli

--Usuñ kolejne 100 rekordów z tej tabeli, ale kasowanie maj¹ byæ rekordy  z najmniejszym SalesOrderDetailId

--Zachowaj polecenia do nastêpnego laboratorum

SELECT * INTO tempdb.dbo.SalesOrderDetail FROM AdventureWorks.Sales.SalesOrderDetail
GO

DELETE TOP(100) FROM tempdb..SalesOrderDetail
GO

DELETE FROM tempdb..SalesOrderDetail
WHERE SalesOrderDetailID IN
(
SELECT TOP(100) SalesOrderDetailID 
FROM SalesOrderDetail
ORDER BY SalesOrderDetailID 
)
GO

--DELETE - klauzula OUTPUT - LAB
--Sekcja 3, wyk³ad 43
--Zmdyfikuj polecenia kasuj¹ce rekordy z poprzedniego zadania tak aby podczas kasowania kolejnych 10 rekordów  podczas usuwania wyœwietlaæ zawartoœæ kasowanych rekordów.

--Zachowaj polecenie do nastêpnego laboratorum

Oto propozycja odpowiedzi:

DELETE TOP(10) FROM tempdb..SalesOrderDetail
OUTPUT deleted.*
GO

DELETE FROM tempdb..SalesOrderDetail
OUTPUT deleted.*
WHERE SalesOrderDetailID IN
(
SELECT TOP(100) SalesOrderDetailID 
FROM SalesOrderDetail
ORDER BY SalesOrderDetailID 
)
GO

--Scenariusz wykorzystania klauzuli OUTPUT - LAB
--Sekcja 3, wyk³ad 46
--Utwórz tabelê SalesOrderDetailArch o strukturze

--ActionId – liczba generowana automatycznie, Primary Key

--SalesOrderDetailId – liczba

--ProductID – liczba

--DeleteDate – data I czas

--Przygotuj zapytanie, które podczas kasowania rekordu przepisze wybrane informacje o kasowanym rekordzie w tabelce archiwalnej. Nastêpnie usuñ tym zapytaniem 10 rekordów i sprawdŸ czy rzeczywiœcie pojawi³y siê one w tabeli archiwalanej.

--Zachowaj polecenie do nastêpnego laboratorum

CREATE TABLE SalesOrderDetailArch
(
ActionId INT IDENTITY PRIMARY KEY,
SalesOrderDetailId INT,
ProductID INT,
DeleteDate DATETIME2
)
GO

INSERT INTO SalesOrderDetailArch(SalesOrderDetailId,ProductID,DeleteDate)
SELECT * FROM 
(
DELETE TOP(10) FROM dbo.SalesOrderDetail 
OUTPUT deleted.SalesOrderDetailID,deleted.ProductID,SYSDATETIME() AS DeleteDate
)  AS OutputFromDeleted
GO

SELECT * FROM dbo.SalesOrderDetailArch

--Usuwanie rekordów w oparciu o dane z innej tabeli - LAB
--Sekcja 3, wyk³ad 49
--Wskutek kasowania danych w tabeli OSalesrderDetail doprowadziliœmy do sytuacji, gdzie w tabeli SalesOrderHeader znajduj¹ siê rekordy „zamówieñ” bez pozycji zamówieñ. 

--Napisz polecenie, które z tabeli SalesOrderHeader usunie te rekordy, które nie maj¹ odpowiadaj¹cych jej rekordów w tabeli SalesOrderDetail. 

--najpierw napisz polecenie listuj¹ce te rekordy (SELECT)
--a potem polecenie kasuj¹ce te rekordy (DELETE)
--Staraj siê wykorzystaæ zaprezentowan¹ sk³adniê z JOIN

--first the select statement
SELECT * FROM SalesOrderHeader soh
LEFT JOIN SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
WHERE sod.SalesOrderDetailID IS NULL

--next delete
DELETE FROM soh
FROM SalesOrderHeader soh
LEFT JOIN SalesOrderDetail sod ON sod.SalesOrderID = soh.SalesOrderID
WHERE sod.SalesOrderDetailID IS NULL

--Kasowanie poleceniem TRUNCATE TABLE - LAB
--Sekcja 3, wyk³ad 52
--Usuñ wszystkie rekordy z tabeli SalesOrderDetail oraz SalesOrderHeader korzystaj¹c z polecenia truncate table

TRUNCATE TABLE SalesOrderDetail 
GO
TRUNCATE TABLE SalesOrderHeader
GO

