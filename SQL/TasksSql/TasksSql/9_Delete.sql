--Polecenie DELETE - wprowadzenie - LAB
--Sekcja 3, wyk�ad 37
--Przepisz do tempdb te same tabele co na lekcji video: Production.Product, Sales.SalesOrderHeader, Sales.SalesOrderDetail. Zachowaj ten skrypt, bo przyda si� w kolejnych zadaniach, kiedy polecenia b�d� dotyczy�y kasowania lub aktualizacji rekord�w w tych tabelach. (Po wy��czeniu SQL Server zawarto�� bazy danych tempdb sie zeruje)

--Usu� z tabeli product produkt nr 500

--Usu� z tabeli produkt produkty, kt�re maj� styl �U� i kolor �Multi� i kosz standardowy maj� wi�kszy ni� 30

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

--Kasowanie cz�ci rekord�w - DELETE TOP - LAB
--Sekcja 3, wyk�ad 40
--Przekopuj zawarto�� tabeli Sales.SalesOrderDetail do tempdb (mo�esz skorzysta� z cz�ci skryptu z poprzedniego zadania)

--Usu� 100 rekord�w z przekopiowanej tabeli

--Usu� kolejne 100 rekord�w z tej tabeli, ale kasowanie maj� by� rekordy  z najmniejszym SalesOrderDetailId

--Zachowaj polecenia do nast�pnego laboratorum

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
--Sekcja 3, wyk�ad 43
--Zmdyfikuj polecenia kasuj�ce rekordy z poprzedniego zadania tak aby podczas kasowania kolejnych 10 rekord�w  podczas usuwania wy�wietla� zawarto�� kasowanych rekord�w.

--Zachowaj polecenie do nast�pnego laboratorum

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
--Sekcja 3, wyk�ad 46
--Utw�rz tabel� SalesOrderDetailArch o strukturze

--ActionId � liczba generowana automatycznie, Primary Key

--SalesOrderDetailId � liczba

--ProductID � liczba

--DeleteDate � data I czas

--Przygotuj zapytanie, kt�re podczas kasowania rekordu przepisze wybrane informacje o kasowanym rekordzie w tabelce archiwalnej. Nast�pnie usu� tym zapytaniem 10 rekord�w i sprawd� czy rzeczywi�cie pojawi�y si� one w tabeli archiwalanej.

--Zachowaj polecenie do nast�pnego laboratorum

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

--Usuwanie rekord�w w oparciu o dane z innej tabeli - LAB
--Sekcja 3, wyk�ad 49
--Wskutek kasowania danych w tabeli OSalesrderDetail doprowadzili�my do sytuacji, gdzie w tabeli SalesOrderHeader znajduj� si� rekordy �zam�wie� bez pozycji zam�wie�. 

--Napisz polecenie, kt�re z tabeli SalesOrderHeader usunie te rekordy, kt�re nie maj� odpowiadaj�cych jej rekord�w w tabeli SalesOrderDetail. 

--najpierw napisz polecenie listuj�ce te rekordy (SELECT)
--a potem polecenie kasuj�ce te rekordy (DELETE)
--Staraj si� wykorzysta� zaprezentowan� sk�adni� z JOIN

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
--Sekcja 3, wyk�ad 52
--Usu� wszystkie rekordy z tabeli SalesOrderDetail oraz SalesOrderHeader korzystaj�c z polecenia truncate table

TRUNCATE TABLE SalesOrderDetail 
GO
TRUNCATE TABLE SalesOrderHeader
GO

