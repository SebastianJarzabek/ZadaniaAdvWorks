--Wyra�enie CASE - LAB
--Sekcja 5, wyk�ad 47
--1. W tabeli Person.PhoneNumberType znajduj� si� opisy rodzaj�w telefon�w. Na potrzeby raportu nale�y:
---wy�wietli�  'mobile phone' gdy nazwa to 'cell'
---wy�wietli� 'Stationary' gdy nazwa to 'Home' lub 'Work'
---w pozosta�ych przypadkach wy�wietli� 'Other'
--2. W poprzednim zadaniu wykorzysta�e� jedn� z dopuszczalnych sk�adni CASE. Napisz teraz zapytanie, kt�re wykorzysta drug� dopuszczaln� sk�adni�
--3. W tabeli Production.Product, niekt�re produkty maj� okre�lony rozmiar. Napisz zapytanie, kt�re wy�wietli:

--ProductID
--Name
--Size
--oraz now� kolumn�, w kt�rej pojawi si�:
--gdy size to 'S' to 'SMALL'
--gdy size to 'M' to 'MEDIUM'
--gdy size to  'L' to 'LARGE'
--gdy size to  'XL' to 'EXTRA LARGE'

SELECT
Name
, CASE Name
WHEN 'Cell' THEN 'Mobile phone'
WHEN 'Home' THEN 'Stationary'
WHEN 'Work' THEN 'Stationary'
ELSE 'OTHER'
END
FROM Person.PhoneNumberType

SELECT
Name
, CASE 
WHEN Name = 'Cell' THEN 'Mobile phone'
WHEN Name = 'Home' OR Name= 'Work' THEN 'Stationary'
ELSE 'OTHER'
END
FROM Person.PhoneNumberType

SELECT 
ProductID
,Name
,Size
,CASE
WHEN Size = 'S' THEN 'SMALL'
WHEN Size = 'M' THEN 'MEDIUM'
WHEN Size = 'L' THEN 'LARGE'
WHEN Size = 'XL' THEN 'EXTRA LARGE'
ELSE Size
END
FROM Production.Product

--Funkcje agreguj�ce. GROUP BY, HAVING - LAB
--Sekcja 5, wyk�ad 50
--1. Pracujemy na tabeli Person.Person
---oblicz ilo�� rekord�w
---oblicz ile os�b poda�o swoje drugie imi� (kolumna MiddleName)
---oblicz ile os�b poda�o swoje pierwsze imi� (kolumna FirstName)
---oblicz ile os�b wyrazi�o zgod� na otrzymywanie maili (kolumna EmailPromotion ma by� r�wna 1)
--2. Pracujemy na tabeli Sales.SalesOrderDetail
---wyznacz ca�kowit� wielko�� sprzeda�y bez uwzgl�dnienia rabat�w - suma UnitPrice * OrderQty
---wyznacz ca�kowit� wielko�� sprzeda�y z uwzgl�dnieniiem rabat�w - suma (UnitPrice-UnitPriceDiscount) * OrderQty
--3. Pracujemy na tabeli Production.Product.
---dla rekord�w z podkategorii 14
---wylicz minimaln� cen�, maksymaln� cen�, �redni� cen� i odczylenie standardowe dla ceny
--4. Pracujemy na tabeli Sales.SalesOrderHeader.
---wyznacz ilo�� zam�wie� zrealizowanych przez poszczeg�lnych pracownik�w (kolumna SalesPersonId)
--5. Wynik poprzedniego polecenia posortuj wg wyliczonej ilo�ci malej�co
--6. Wynik poprzedniego polecenia ogranicz do zam�wie� z 2012 roku
--7. Wynik poprzedniego polecenia ogranicz tak, aby prezentowani byli te rekordy, gdzie wyznaczona suma jest wi�ksza od 100000
--8. Pracujemy na tabeli Sales.SalesOrderHeader. 
--9. Policz ile zam�wie� by�o dostarczanych z wykorzystaniem r�nych metod dostawy (kolumna ShipMethod)
--Pracujemy na tabeli Production.Product
--Napisz zapytanie, kt�re wy�wietla:
---ProductID
---Name 
---StandardCost
---ListPrice 
---r�nic� mi�dzy ListPrice a StandardCost. Zaaliasuj j� "Profit"
---w wyniku opu�� te produkty kt�re maj� ListPrice lub StandardCost <=0
--10. Bazuj�c na poprzednim zapytaniu, spr�bujemy wyznaczy� jakie kategorie produkt�w s� najbardziej zyskowne.
--Dla ka�dej podkategorii wyznacz �redni, minimalny i maksymalny profit. Uporz�dkuj wynik w kolejno�ci �redniego profitu malej�co

SELECT COUNT(*) FROM Person.Person
SELECT COUNT(middleName) FROM Person.Person
SELECT COUNT(FirstName) FROM Person.Person
SELECT COUNT(*) FROM Person.Person WHERE EmailPromotion=1

SELECT SUM(UnitPrice*OrderQty) FROM Sales.SalesOrderDetail
SELECT SUM((UnitPrice-unitPriceDiscount)*OrderQty) FROM Sales.SalesOrderDetail

SELECT 
MIN(ListPrice) as minimum
,MAX(listPrice) as maximum
,STDEV(listPrice) as [standard deviation]
,AVG(ListPrice) as average
FROM Production.Product WHERE ProductSubcategoryID = 14

SELECT 
SalesPersonID
, COUNT(*) AS AmountOfOrders
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID

SELECT 
SalesPersonID
, COUNT(*) AS AmountOfOrders
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
ORDER BY AmountOfOrders DESC

SELECT 
SalesPersonID
, COUNT(*) AS AmountOfOrders
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2012-01-01' AND '2012-12-31'
GROUP BY SalesPersonID
ORDER BY AmountOfOrders DESC

SELECT 
SalesPersonID
, SUM(SubTotal) AS TotalSales
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2012-01-01' AND '2012-12-31'
GROUP BY SalesPersonID
HAVING SUM(SubTotal) > 100000
ORDER BY TotalSales DESC

SELECT 
ShipMethodID
, COUNT(*) AS AmountOfOrders
FROM Sales.SalesOrderHeader
GROUP BY ShipMethodID

SELECT 
p.ProductID
,p.Name
,p.StandardCost
,p.ListPrice
,p.ListPrice -p.StandardCost AS Profit
FROM Production.Product p
WHERE p.StandardCost > 0 AND p.ListPrice > 0

SELECT 
p.ProductSubcategoryID
,AVG(p.ListPrice -p.StandardCost) AS AvgProfit
,MIN(p.ListPrice -p.StandardCost) AS MinProfit
,MAX(p.ListPrice -p.StandardCost) AS MaxProfit
FROM Production.Product p
WHERE p.StandardCost > 0 AND p.ListPrice > 0
GROUP BY p.ProductSubcategoryID
ORDER BY AvgProfit DESC

--Null i funkcje pracuj�ce z NULL -LAB
--Sekcja 5, wyk�ad 53
--1. Wy�wietl rekordy z tabeli Person.Person, gdzie nie podano drugiego imienia (MiddleName)
--2. Wy�wietl rekordy z tabeli Person.Person, gdzie drugie imi� jest podane
--3. Wy�wietl z tabeli Person.Person:
---FirstName
---MiddleName
---LastName
---napis z po��czenia ze sob� FirstName ' ' MiddleName ' ' i  LastName
--4. Je�li jeszcze tego nie zrobi�e� dodaj wyra�enie, kt�re obs�u�y sytuacj�, gdy MiddleName jest NULL. W takim przypadku chcemy prezentowa� tylko FirstName ' ' i LastName
--5. Je�li jeszcze tego nie zrobi�e� - wyeliminuj podw�j� spacj�, jaka mo�e si� pojawi� mi�dzy FirstName i LastNamr gdy MiddleName jest NULL.
--6. Firma podpisuje umow� z firm� kuriersk�. Cena us�ugi ma zale�e� od rozmiaru w drugiej kolejno�ci ci�aru, a gdy te nie s� znane od warto�ci wysy�anego przedmiotu.
--Napisz zapytanie, kt�re wy�wietli:
---productId
---Name
---size, weight i listprice
---i kolumn� wyliczan�, kt�ra poka�e size (je�li jest NOT NULL), lub weight (je�li jest NOT NULL) lub listprice w przeciwnym razie
--7. Firma kurierska oczekuje aby informacja w ostatniej kolumnie by�a dodatkowo oznaczona:
---je�li zawiera informacje o rozmiarze, to ma by� poprzedzona napisem S:
---je�li zawiera informacje o ci�arze, to ma by� poprzedzone napisem W:
---w przeciwnym razie ma si� pojawia� L:

SELECT * FROM Person.Person WHERE MiddleName IS NULL

SELECT * FROM Person.Person WHERE MiddleName IS NOT NULL

SELECT 
p.FirstName
,p.MiddleName
,p.LastName
,p.FirstName+' '+p.MiddleName+' '+p.LastName
FROM Person.Person p 

SELECT 
p.FirstName
,p.MiddleName
,p.LastName
,p.FirstName+' '+ISNULL(p.MiddleName,'')+' '+p.LastName
FROM Person.Person p 

SELECT 
p.FirstName
,p.MiddleName
,p.LastName
,p.FirstName+' '+ISNULL(p.MiddleName+' ','')+p.LastName
FROM Person.Person p 

SELECT 
p.productid
,p.name
,p.size
,p.weight
,p.listprice
,COALESCE(Size, CAST(weight AS VARCHAR(10)), CAST(listprice AS VARCHAR(10)))
FROM Production.Product p

SELECT 
p.productid
,p.name
,p.size
,p.weight
,p.listprice
,COALESCE('S:'+Size, 'W:'+CAST(weight AS VARCHAR(10)), 'P:'+CAST(listprice AS VARCHAR(10)))
FROM Production.Product p

--SELECT DISTINCT i SELECT TOP - LAB
--Sekcja 5, wyk�ad 56
--1. Z tabeli Person.Address wy�wietl unikalne miasta  (City)
--2. Z tej samej tabeli wy�wietl unikalne kody pocztowe (PostalCode)
--3. Z tej samej tabeli wy�wietl unikalne kombinacje miast i kod�w pocztowych
--4. Z tabeli Sales.SalesPerson wy�wietl BusinessEntityId i Bonus dla 4 pracownik�w z najwi�kszym bonusem
--5. Je�eli s� jeszcze inne rekordy o takiej warto�ci jak ostatnia zwr�cona w poprzednim zadaniu, to maj� si� one te� wy�wietli�
--6. Wy�wietl 20% rekord�w z najwy�szymi Bonusami
--7. Je�eli warto�ci si� powtarzaj� to r�wnie� nale�y je pokaza�

SELECT DISTINCT City
  FROM Person.Address
  ORDER BY City

SELECT DISTINCT PostalCode
  FROM Person.Address
  ORDER BY PostalCode

SELECT DISTINCT City,PostalCode
  FROM Person.Address
  ORDER BY City,PostalCode

Select TOP(4)
sp.BusinessEntityID
,sp.bonus
FROM Sales.SalesPerson sp
ORDER BY Bonus DESC

Select TOP(4) WITH TIES
sp.BusinessEntityID
,sp.bonus
FROM Sales.SalesPerson sp
ORDER BY Bonus DESC

Select TOP(20) PERCENT
sp.BusinessEntityID
,sp.bonus
FROM Sales.SalesPerson sp
ORDER BY Bonus DESC

Select TOP(20) PERCENT WITH TIES
sp.BusinessEntityID
,sp.bonus
FROM Sales.SalesPerson sp
ORDER BY Bonus DESC

--GROUP BY, ROLLUP, CUBE i GROUPING SET - LAB
--Sekcja 5, wyk�ad 59
--1. Napisz zapytanie do tabeli Sales.SalesOrderHeader. Wyfiltruj rekordy, kt�re:
---Dat� zam�wienia (OrderDate) maj� mi�dzy 2012-01-01 a 2012-03-31
---SalesPersonId ma mie� warto�� (czyli nie jest null)
---TerritoryID  ma mie� warto�� (czyli nie jest null)

--W wyniku ma by� wy�wietlony:
---Miesi�c z daty zam�wienia
---SalesPersonId
---TerritoryID
---Suma z kolumny SubTotal
--2. Zmie� zapytanie tak, aby wy�wietlane by�y tak�e podsumowania dla:
---Miesi�c i SalesPersonId
---Miesi�c
---Og�em
--3. Zmie� zapytanie tak aby widoczne by�y tak�e sumy dla:
---Miesi�c i TerritoryId
---SalesPersonId i TerritoryId
---SalesPersonId
---TerritoryId
--4. Zmie� zapytanie tak, aby wy�wietli�y si� tylko sumy:
---miesi�ca 
---miesi�ca, SalesPersonId, TerritoryId
--ZACHOWAJ ROZWI�ZANIA DO NAST�PNEGO LABORATORIUM!

SELECT

MONTH(OrderDate) AS Month
,SalesPersonId
,TerritoryID
,SUM(SubTotal) AS SumOfTotal
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2012-01-01' AND '2012-03-31' AND SalesPersonId IS NOT NULL AND TerritoryID IS NOT NULL
GROUP BY MONTH(OrderDate),SalesPersonID,TerritoryID

SELECT
MONTH(OrderDate) AS Month
,SalesPersonId
,TerritoryID
,SUM(SubTotal) AS SumOfTotal
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2012-01-01' AND '2012-03-31' AND SalesPersonIdIS NOT NULL AND TerritoryID IS NOT NULL
GROUP BY ROLLUP (MONTH(OrderDate),SalesPersonID,TerritoryID)

SELECT
MONTH(OrderDate) AS Month
,SalesPersonId
,TerritoryID
,SUM(SubTotal) AS SumOfTotal
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2012-01-01' AND '2012-03-31' AND SalesPersonId IS NOT NULL AND TerritoryID IS NOT NULL
GROUP BY CUBE (MONTH(OrderDate),SalesPersonID,TerritoryID)

SELECT
MONTH(OrderDate) AS Month
,SalesPersonId
,TerritoryID
,SUM(SubTotal) AS SumOfTotal
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '2012-01-01' AND '2012-03-31' AND SalesPersonIdIS NOT NULL AND TerritoryID IS NOT NULL
GROUP BY GROUPING SETS ((MONTH(OrderDate)),(MONTH(OrderDate),SalesPersonID,TerritoryId))

--Funkcja GROUPING_ID - LAB
--Sekcja 5, wyk�ad 62
--W przyk�adach z poprzedniej lekcji, usu� klauzul� WHERE  dodaj wywo�ania GROUPPING_ID w taki spos�b, �e:

--po ka�dej kolumnie (opr�cz podsumowywanej warto�ci) ma si�  pojawi� liczba wskazuj�ca na to czy warto�� jest warto�ci� pochodz�c� z tabeli czy jest dodana przez agregacj�
--w ostatniej kolumnie ma si� nale�� liczba, kt�ra zinterpretowana jako suma pot�g dw�jki pozwoli rozpozna�, kt�re warto�ci s� dodane do zbioru poprzez agregacj�

SELECT
MONTH(OrderDate) AS Month, GROUPING_ID(MONTH(OrderDate)) AS AggregateByMonth
,SalesPersonId, GROUPING_ID(SalesPersonId) AS AggregateBySalesPersonId
,TerritoryID, GROUPING_ID(TerritoryID) AS AggregateByTerritoryID
,SUM(SubTotal) AS SumOfTotal
,GROUPING_ID(MONTH(OrderDate),SalesPersonID,TerritoryID)
FROM Sales.SalesOrderHeader
GROUP BY ROLLUP (MONTH(OrderDate),SalesPersonID,TerritoryID)

SELECT
MONTH(OrderDate) AS Month  , GROUPING_ID(MONTH(OrderDate)) AS AggregateByMonth
,SalesPersonId, GROUPING_ID(SalesPersonId) AS AggregateBySalesPersonId
,TerritoryID, GROUPING_ID(TerritoryID) AS AggregateByTerritoryID
,SUM(SubTotal) AS SumOfTotal
,GROUPING_ID(MONTH(OrderDate),SalesPersonID,TerritoryID)
FROM Sales.SalesOrderHeader
GROUP BY CUBE (MONTH(OrderDate),SalesPersonID,TerritoryID)

SELECT
MONTH(OrderDate) AS Month , GROUPING_ID(MONTH(OrderDate)) AS AggregateByMonth
,SalesPersonId, GROUPING_ID(SalesPersonId) AS AggregateBySalesPersonId
,TerritoryID, GROUPING_ID(TerritoryID) AS AggregateByTerritoryID
,SUM(SubTotal) AS SumOfTotal
,GROUPING_ID(MONTH(OrderDate),SalesPersonID,TerritoryID)
FROM Sales.SalesOrderHeader
GROUP BY GROUPING SETS ((MONTH(OrderDate)),(MONTH(OrderDate),SalesPersonID,TerritoryId))


