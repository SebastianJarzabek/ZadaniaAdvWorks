--Wprowadzenie do SELECT - LAB
--Sekcja 2, wyk³ad 5
--1. PrzejdŸ do bazy danych AdventureWorks (lub innej jakiej u¿ywasz)
--2. Wyœwietl wszystko z tabeli Person.Person. Skorzystaj  ze wskazówek zawartych w lekcji, w tym: jak korzystaæ z aliasu tabeli, intelisense, notacji w osobnych linijkach itp.
--3. Napisz polecenie, które z tabeli Production.Product wyœwietli tylko informacje z kolumn: ProductID, Name, ListPrice, Color
--4. Skopiuj poprzednie zapytanie i zmieñ je tak, aby wyœwietliæ tylko produkty w kolorze niebieskim (Color = 'blue')
--5. Skopuj poprzednie zapytanie i zakomentuj w nim linijkê powoduj¹c¹ wyœwietlenie koloru
--6. PrzejdŸ do bazy danych tempdb
--7. Bêd¹c w bazie danych tempdb napisz polecenie, które wyœwietli wszystko z tabeli ScrapReason w schemacie Production z bazy danych AdventureWorks

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
--Sekcja 2, wyk³ad 8
--1. PrzejdŸ do bazy AdventureWorks
--2. Wyœwietl wszystko z tabeli HumanResources.Employee. Spróbuj zrozumieæ znaczenie poszczególnych kolumn
--3. Wyœwietl tylko rekordy pracowników urodzonych od 1980-01-01 w³¹cznie z t¹ dat¹
--4. Wyœwietl tylko rekordy osób urodzonych w 1980 roku
--5. Ogranicz wyniki z poprzedniego punktu wyœwietlaj¹c wy³¹cznie dane mê¿czyzn (Gender='M')
--6. Napisz zapytanie wyœwietlaj¹ce z tabeli HumanResources.Employee tylko kolumny: JobTitle, BirthDate, Gender, VacationHours. Wyœwietliæ nale¿y tylko rekordy tych mê¿czyzn, którzy maj¹ 90-99 godzin urlopu (VacationHours) oraz kobiet, które maj¹ tych godzin 80-89 (w³¹cznie)
--7. Do poprzedniego zadania dodaj warunek powoduj¹cy wyœwietlenie danych TYLKO dla osób urodzonych po 1 stycznia 1990 roku w³¹cznie
--8. Wyœwietl z tabeli wszystkie informacje o osobach pracuj¹cych na stanowisku (JobTitle): 'Control Specialist','Benefits Specialist','Accounts Receivable Specialist'

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
--Sekcja 2, wyk³ad 11
--1. Wyœwietl z tabeli HumanResources.Employee rekordy, które w kolumnie JobTitle zawieraj¹ tekst "Specialist"
--2. Wyœwietl tylko te rekordy, które jednoczeœnie zawieraj¹ "Specialist" i "Marketing"
--3. Wyœwietl te rekordy, które zawieraj¹ "Specialist" lub "Marketing"
--4. Z tabeli Production.Product wyœwietl tylko te rekordy, które zawieraj¹ w kolumnie Name chocia¿ jedna cyfrê
--5. Wyœwietl te rekordy, które w nazwie zawieraj¹ dwie cyfry ko³o siebie
--6. Wyœwietl te rekordy, które w nazwie zawieraj¹ dwie cyfry ko³o siebie ale nie koñcz¹ siê cyfr¹
--7. Wyœwietl te rekordy, w których nazwa sk³ada siê z 4 dowolnych znaków

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
--Sekcja 2, wyk³ad 14
--1. Tabela Sales.SalesOrderDetail zawiera szczegó³owe informacje o sprzeda¿y poszczególnych zamówieñ. Kolumna UnitPrice zawiera informacje o cenie, a OrderQty o iloœci sprzedanych produktów. Wylicz wartoœæ sprzeda¿y jako wynik mno¿enia tych dwóch pól
--2. Tabela zawiera równie¿ kolumnê UnitPriceDiscount oznaczaj¹c¹ rabat od podstawowej ceny. Wylicz wartoœæ sprzeda¿y produktu jeœli cena by³a obni¿ona o UnitPriceDiscount.
--3. Tabel Sales.CreditCard zawiera informacje o typie karty (CardType) i numerze karty kredytowej (CardNumber). Wyœwietl oba te pola po³¹czone znakiem ':'
--4. Tabela Sales.SalesOrderHeader zawiera informacje o numerze zamówienia (SalesOrderNumber) i numerze zakupu (PurchaseOrderNumber). Wyœwietl obie kolumny
--5. Dodaj kolumnê wyliczan¹ która oba te pola ³¹czy znakiem '-'. Zauwa¿ co jest wyœwietlane je¿eli PurchaseOrderNumber jest równe NULL
--6. Korzystaj¹c z funkcji CONCAT po³¹cz ze sob¹ oba pola znakiem '-'. Ponownie zobacz wyliczan¹ wartoœæ dla rekordów z PurchaseOrderNumber równym NULL

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

--Korzystanie z aliasów - LAB
--Sekcja 2, wyk³ad 17
--1. Do poni¿szych zapytañ dodaj aliasy dla kolumn wyliczanych:

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


--2. Skróæ nastêpuj¹ce zapytanie korzystaj¹c z aliasów tabel:

--SELECT 
-- SalesOrderNumber
-- ,ProductID
-- ,UnitPrice
-- ,TaxAmt
--FROM Sales.SalesOrderHeader 
--JOIN Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID


--3. Dodaj do klauzuli WHERE warunek pododuj¹cy wyœwietlenie tylko tych rekordów, które maj¹ wartoœæ Total wiêksz¹ od 10000

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

--Porz¹dkowanie rekordów klauzula ORDER BY - LAB
--Sekcja 2, wyk³ad 20
--1. Wyœwietl wszystkie informacje z tabeli HumanResources.Employee. Uporz¹dkuj dane w kolejnoœci wg daty urodzenia (BirthDay) rosn¹co

--2. Zmieñ kolejnoœæ na malej¹c¹

--3. Wylicz w zapytaniu wiek (od roku z daty dzisiejszej odejmij rok z daty urodzenia). Zaaliasuj kolumnê jako Age. Posortuj dane wg tej kolumny malej¹co

--4. Z tabeli Production.Product wyœwietl ProductId, Name, ListPrice, Class, Style i Color. Uporz¹dkuj dane wg class i style

--5. Zmieñ poprzednie polecenie tak, aby sortowanie odbywa³o siê w oparciu o numer kolumny, a nie nazwê (pamiêtaj - to jest niezalecane rozwi¹zanie, ale warto je znaæ!)

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