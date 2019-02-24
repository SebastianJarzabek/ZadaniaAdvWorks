--Wprowadzenie do SELECT - LAB
--Sekcja 2, wyk�ad 5
--1. Przejd� do bazy danych AdventureWorks (lub innej jakiej u�ywasz)
--2. Wy�wietl wszystko z tabeli Person.Person. Skorzystaj  ze wskaz�wek zawartych w lekcji, w tym: jak korzysta� z aliasu tabeli, intelisense, notacji w osobnych linijkach itp.
--3. Napisz polecenie, kt�re z tabeli Production.Product wy�wietli tylko informacje z kolumn: ProductID, Name, ListPrice, Color
--4. Skopiuj poprzednie zapytanie i zmie� je tak, aby wy�wietli� tylko produkty w kolorze niebieskim (Color = 'blue')
--5. Skopuj poprzednie zapytanie i zakomentuj w nim linijk� powoduj�c� wy�wietlenie koloru
--6. Przejd� do bazy danych tempdb
--7. B�d�c w bazie danych tempdb napisz polecenie, kt�re wy�wietli wszystko z tabeli ScrapReason w schemacie Production z bazy danych AdventureWorks

USE AdventureWorks

GO

SELECT * FROM Production.Product
GO

SELECT
p.ProductID
,p.Name
,p.ListPrice
,p.Color
FROM Production.Product p
GO

SELECT
p.ProductID
,p.Name
,p.ListPrice
,p.Color
FROM Production.Product p
WHERE p.Color = 'BLUE'
GO

SELECT
p.ProductID
,p.Name
,p.ListPrice
-- ,p.Color
FROM Production.Product p
WHERE p.Color = 'BLUE'
GO

use tempdb
GO

SELECT * FROM AdventureWorks.Production.ScrapReason

--Klauzula WHERE cz. 1 - LAB
--Sekcja 2, wyk�ad 8
--1. Przejd� do bazy AdventureWorks
--2. Wy�wietl wszystko z tabeli HumanResources.Employee. Spr�buj zrozumie� znaczenie poszczeg�lnych kolumn
--3. Wy�wietl tylko rekordy pracownik�w urodzonych od 1980-01-01 w��cznie z t� dat�
--4. Wy�wietl tylko rekordy os�b urodzonych w 1980 roku
--5. Ogranicz wyniki z poprzedniego punktu wy�wietlaj�c wy��cznie dane m�czyzn (Gender='M')
--6. Napisz zapytanie wy�wietlaj�ce z tabeli HumanResources.Employee tylko kolumny: JobTitle, BirthDate, Gender, VacationHours. Wy�wietli� nale�y tylko rekordy tych m�czyzn, kt�rzy maj� 90-99 godzin urlopu (VacationHours) oraz kobiet, kt�re maj� tych godzin 80-89 (w��cznie)
--7. Do poprzedniego zadania dodaj warunek powoduj�cy wy�wietlenie danych TYLKO dla os�b urodzonych po 1 stycznia 1990 roku w��cznie
--8. Wy�wietl z tabeli wszystkie informacje o osobach pracuj�cych na stanowisku (JobTitle): 'Control Specialist','Benefits Specialist','Accounts Receivable Specialist'

USE AdventureWorks
GO

SELECT * FROM HumanResources.Employee
GO

SELECT * FROM HumanResources.Employee
WHERE BirthDate >= '1980-01-01'
GO

SELECT * FROM HumanResources.Employee
WHERE BirthDate >= '1980-01-01' AND BirthDate < '1981-01-01'
GO

SELECT * FROM HumanResources.Employee
WHERE BirthDate >= '1980-01-01' AND BirthDate < '1981-01-01'
AND Gender='M'
GO

SELECT 
JobTitle 
,BirthDate
,Gender
,VacationHours
FROM HumanResources.Employee
WHERE 
 Gender='M' AND VacationHours BETWEEN 90 AND 99
 OR
 Gender='F' AND VacationHours BETWEEN 80 AND 89
GO

SELECT 
JobTitle 
,BirthDate
,Gender
,VacationHours
FROM HumanResources.Employee
WHERE 
 (Gender='M' AND VacationHours BETWEEN 90 AND 99
 OR
 Gender='F' AND VacationHours BETWEEN 80 AND 89)
 AND
 BirthDate >= '1990-01-01'
GO

SELECT * 
FROM HumanResources.Employee
WHERE 
JobTitle IN ('Marketing Specialist','Control Specialist','Benefits Specialist','Accounts Receivable Specialist')

--Klauzula WHERE cz. 2 - LAB
--Sekcja 2, wyk�ad 11
--1. Wy�wietl z tabeli HumanResources.Employee rekordy, kt�re w kolumnie JobTitle zawieraj� tekst "Specialist"
--2. Wy�wietl tylko te rekordy, kt�re jednocze�nie zawieraj� "Specialist" i "Marketing"
--3. Wy�wietl te rekordy, kt�re zawieraj� "Specialist" lub "Marketing"
--4. Z tabeli Production.Product wy�wietl tylko te rekordy, kt�re zawieraj� w kolumnie Name chocia� jedna cyfr�
--5. Wy�wietl te rekordy, kt�re w nazwie zawieraj� dwie cyfry ko�o siebie
--6. Wy�wietl te rekordy, kt�re w nazwie zawieraj� dwie cyfry ko�o siebie ale nie ko�cz� si� cyfr�
--7. Wy�wietl te rekordy, w kt�rych nazwa sk�ada si� z 4 dowolnych znak�w

SELECT JobTitle 
FROM HumanResources.Employee
WHERE
JobTitle LIKE '%Specialist%'

SELECT JobTitle 
FROM HumanResources.Employee
WHERE
JobTitle LIKE '%Specialist%'
AND
JobTitle LIKE '%Marketing%'

SELECT JobTitle 
FROM HumanResources.Employee
WHERE
JobTitle LIKE '%Specialist%'
OR
JobTitle LIKE '%Marketing%'

SELECT Name 
FROM Production.Product
WHERE
Name LIKE '%[0-9]%'

SELECT Name 
FROM Production.Product
WHERE
Name LIKE '%[0-9][0-9]%'

SELECT Name 
FROM Production.Product
WHERE
Name LIKE '%[0-9][0-9]%[^0-9]'

SELECT Name 
FROM Production.Product
WHERE
Name LIKE '____'

--Kolumny wyliczane - LAB
--Sekcja 2, wyk�ad 14
--1. Tabela Sales.SalesOrderDetail zawiera szczeg�owe informacje o sprzeda�y poszczeg�lnych zam�wie�. Kolumna UnitPrice zawiera informacje o cenie, a OrderQty o ilo�ci sprzedanych produkt�w. Wylicz warto�� sprzeda�y jako wynik mno�enia tych dw�ch p�l
--2. Tabela zawiera r�wnie� kolumn� UnitPriceDiscount oznaczaj�c� rabat od podstawowej ceny. Wylicz warto�� sprzeda�y produktu je�li cena by�a obni�ona o UnitPriceDiscount.
--3. Tabel Sales.CreditCard zawiera informacje o typie karty (CardType) i numerze karty kredytowej (CardNumber). Wy�wietl oba te pola po��czone znakiem ':'
--4. Tabela Sales.SalesOrderHeader zawiera informacje o numerze zam�wienia (SalesOrderNumber) i numerze zakupu (PurchaseOrderNumber). Wy�wietl obie kolumny
--5. Dodaj kolumn� wyliczan� kt�ra oba te pola ��czy znakiem '-'. Zauwa� co jest wy�wietlane je�eli PurchaseOrderNumber jest r�wne NULL
--6. Korzystaj�c z funkcji CONCAT po��cz ze sob� oba pola znakiem '-'. Ponownie zobacz wyliczan� warto�� dla rekord�w z PurchaseOrderNumber r�wnym NULL

SELECT UnitPrice*OrderQty FROM Sales.SalesOrderDetail

SELECT (UnitPrice-UnitPriceDiscount)*OrderQty FROM Sales.SalesOrderDetail

SELECT Cardtype+':'+CardNumber FROM Sales.CreditCard

SELECT SalesOrderNumber, PurchaseOrderNumber FROM Sales.SalesOrderHeader

SELECT 
SalesOrderNumber
,PurchaseOrderNumber 
,SalesOrderNumber+'-'+PurchaseOrderNumber 
FROM Sales.SalesOrderHeader

SELECT 
SalesOrderNumber
,PurchaseOrderNumber 
,CONCAT(SalesOrderNumber,'-',PurchaseOrderNumber)
FROM Sales.SalesOrderHeader

--Korzystanie z alias�w - LAB
--Sekcja 2, wyk�ad 17
--1. Do poni�szych zapyta� dodaj aliasy dla kolumn wyliczanych:

--alias Total

--SELECT UnitPrice*OrderQty FROM Sales.SalesOrderDetail 

--alias TotalWithDiscount

--SELECT (UnitPrice-UnitPriceDiscount)*OrderQty FROM Sales.SalesOrderDetail 
--alias CardType and CardNumber

--SELECT Cardtype+':'+CardNumber FROM Sales.CreditCard 

--alias Sales And Purchase Order Number

--SELECT 
-- SalesOrderNumber
-- ,PurchaseOrderNumber 
-- ,SalesOrderNumber+'-'+PurchaseOrderNumber 
--FROM Sales.SalesOrderHeader


--2. Skr�� nast�puj�ce zapytanie korzystaj�c z alias�w tabel:

--SELECT 
-- SalesOrderNumber
-- ,ProductID
-- ,UnitPrice
-- ,TaxAmt
--FROM Sales.SalesOrderHeader 
--JOIN Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID


--3. Dodaj do klauzuli WHERE warunek pododuj�cy wy�wietlenie tylko tych rekord�w, kt�re maj� warto�� Total wi�ksz� od 10000

--SELECT 
-- sod.ProductID
-- ,sod.SalesOrderID
-- ,sod.OrderQty * sod.UnitPrice AS Total
--FROM Sales.SalesOrderDetail sod

SELECT UnitPrice*OrderQty AS Total FROM Sales.SalesOrderDetail

SELECT (UnitPrice-UnitPriceDiscount)*OrderQty AS TotalWithDiscount FROM Sales.SalesOrderDetail

SELECT Cardtype+':'+CardNumber AS [CarType and CardNumber] FROM Sales.CreditCard

SELECT 

SalesOrderNumber
,PurchaseOrderNumber 
,SalesOrderNumber+'-'+PurchaseOrderNumber AS 'Sales And Purchase Order Number'
FROM Sales.SalesOrderHeader

/*
SELECT 
SalesOrderNumber
,ProductID
,UnitPrice
,TaxAmt
FROM Sales.SalesOrderHeader 
JOIN Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
*/

SELECT 
soh.SalesOrderNumber
,sod.ProductID
,sod.UnitPrice
,soh.TaxAmt
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID

SELECT 
sod.ProductID
,sod.SalesOrderID
,sod.OrderQty * sod.UnitPrice AS Total
FROM Sales.SalesOrderDetail sod

SELECT 
sod.ProductID
,sod.SalesOrderID
,sod.OrderQty * sod.UnitPrice AS Total
FROM Sales.SalesOrderDetail sod
WHERE sod.OrderQty * sod.UnitPrice >10000

--Porz�dkowanie rekord�w klauzula ORDER BY - LAB
--Sekcja 2, wyk�ad 20
--1. Wy�wietl wszystkie informacje z tabeli HumanResources.Employee. Uporz�dkuj dane w kolejno�ci wg daty urodzenia (BirthDay) rosn�co

--2. Zmie� kolejno�� na malej�c�

--3. Wylicz w zapytaniu wiek (od roku z daty dzisiejszej odejmij rok z daty urodzenia). Zaaliasuj kolumn� jako Age. Posortuj dane wg tej kolumny malej�co

--4. Z tabeli Production.Product wy�wietl ProductId, Name, ListPrice, Class, Style i Color. Uporz�dkuj dane wg class i style

--5. Zmie� poprzednie polecenie tak, aby sortowanie odbywa�o si� w oparciu o numer kolumny, a nie nazw� (pami�taj - to jest niezalecane rozwi�zanie, ale warto je zna�!)

SELECT 
*
FROM HumanResources.Employee e
ORDER BY BirthDate 

SELECT 
*
FROM HumanResources.Employee e
ORDER BY BirthDate DESC

SELECT 
* , YEAR(GetDate()) - YEAR(e.BirthDate) AS Age
FROM HumanResources.Employee e
ORDER BY Age DESC

SELECT 
p.ProductID
,p.Name
,p.ListPrice
,p.Class
,p.Style
,p.Color
FROM Production.Product p
ORDER BY Class,Style

SELECT 
p.ProductID
,p.Name
,p.ListPrice
,p.Class
,p.Style
,p.Color
FROM Production.Product p
ORDER BY 4,5