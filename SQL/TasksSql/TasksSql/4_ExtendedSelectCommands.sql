--Wyra¿enie CASE - LAB
--Sekcja 5, wyk³ad 47
--1. W tabeli Person.PhoneNumberType znajduj¹ siê opisy rodzajów telefonów. Na potrzeby raportu nale¿y:
---wyœwietliæ  'mobile phone' gdy nazwa to 'cell'
---wyœwietliæ 'Stationary' gdy nazwa to 'Home' lub 'Work'
---w pozosta³ych przypadkach wyœwietliæ 'Other'
--2. W poprzednim zadaniu wykorzysta³eœ jedn¹ z dopuszczalnych sk³adni CASE. Napisz teraz zapytanie, które wykorzysta drug¹ dopuszczaln¹ sk³adniê
--3. W tabeli Production.Product, niektóre produkty maj¹ okreœlony rozmiar. Napisz zapytanie, które wyœwietli:

--ProductID
--Name
--Size
--oraz now¹ kolumnê, w której pojawi siê:
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

--Funkcje agreguj¹ce. GROUP BY, HAVING - LAB
--Sekcja 5, wyk³ad 50
--1. Pracujemy na tabeli Person.Person
---oblicz iloœæ rekordów
---oblicz ile osób poda³o swoje drugie imiê (kolumna MiddleName)
---oblicz ile osób poda³o swoje pierwsze imiê (kolumna FirstName)
---oblicz ile osób wyrazi³o zgodê na otrzymywanie maili (kolumna EmailPromotion ma byæ równa 1)
--2. Pracujemy na tabeli Sales.SalesOrderDetail
---wyznacz ca³kowit¹ wielkoœæ sprzeda¿y bez uwzglêdnienia rabatów - suma UnitPrice * OrderQty
---wyznacz ca³kowit¹ wielkoœæ sprzeda¿y z uwzglêdnieniiem rabatów - suma (UnitPrice-UnitPriceDiscount) * OrderQty
--3. Pracujemy na tabeli Production.Product.
---dla rekordów z podkategorii 14
---wylicz minimaln¹ cenê, maksymaln¹ cenê, œredni¹ cenê i odczylenie standardowe dla ceny
--4. Pracujemy na tabeli Sales.SalesOrderHeader.
---wyznacz iloœæ zamówieñ zrealizowanych przez poszczególnych pracowników (kolumna SalesPersonId)
--5. Wynik poprzedniego polecenia posortuj wg wyliczonej iloœci malej¹co
--6. Wynik poprzedniego polecenia ogranicz do zamówieñ z 2012 roku
--7. Wynik poprzedniego polecenia ogranicz tak, aby prezentowani byli te rekordy, gdzie wyznaczona suma jest wiêksza od 100000
--8. Pracujemy na tabeli Sales.SalesOrderHeader. 
--9. Policz ile zamówieñ by³o dostarczanych z wykorzystaniem ró¿nych metod dostawy (kolumna ShipMethod)
--Pracujemy na tabeli Production.Product
--Napisz zapytanie, które wyœwietla:
---ProductID
---Name 
---StandardCost
---ListPrice 
---ró¿nicê miêdzy ListPrice a StandardCost. Zaaliasuj j¹ "Profit"
---w wyniku opuœæ te produkty które maj¹ ListPrice lub StandardCost <=0
--10. Bazuj¹c na poprzednim zapytaniu, spróbujemy wyznaczyæ jakie kategorie produktów s¹ najbardziej zyskowne.
--Dla ka¿dej podkategorii wyznacz œredni, minimalny i maksymalny profit. Uporz¹dkuj wynik w kolejnoœci œredniego profitu malej¹co

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

--Null i funkcje pracuj¹ce z NULL -LAB
--Sekcja 5, wyk³ad 53
--1. Wyœwietl rekordy z tabeli Person.Person, gdzie nie podano drugiego imienia (MiddleName)
--2. Wyœwietl rekordy z tabeli Person.Person, gdzie drugie imiê jest podane
--3. Wyœwietl z tabeli Person.Person:
---FirstName
---MiddleName
---LastName
---napis z po³¹czenia ze sob¹ FirstName ' ' MiddleName ' ' i  LastName
--4. Jeœli jeszcze tego nie zrobi³eœ dodaj wyra¿enie, które obs³u¿y sytuacjê, gdy MiddleName jest NULL. W takim przypadku chcemy prezentowaæ tylko FirstName ' ' i LastName
--5. Jeœli jeszcze tego nie zrobi³eœ - wyeliminuj podwój¹ spacjê, jaka mo¿e siê pojawiæ miêdzy FirstName i LastNamr gdy MiddleName jest NULL.
--6. Firma podpisuje umowê z firm¹ kuriersk¹. Cena us³ugi ma zale¿eñ od rozmiaru w drugiej kolejnoœci ciê¿aru, a gdy te nie s¹ znane od wartoœci wysy³anego przedmiotu.
--Napisz zapytanie, które wyœwietli:
---productId
---Name
---size, weight i listprice
---i kolumnê wyliczan¹, która poka¿e size (jeœli jest NOT NULL), lub weight (jeœli jest NOT NULL) lub listprice w przeciwnym razie
--7. Firma kurierska oczekuje aby informacja w ostatniej kolumnie by³a dodatkowo oznaczona:
---jeœli zawiera informacje o rozmiarze, to ma byæ poprzedzona napisem S:
---jeœli zawiera informacje o ciê¿arze, to ma byæ poprzedzone napisem W:
---w przeciwnym razie ma siê pojawiaæ L:

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
--Sekcja 5, wyk³ad 56
--1. Z tabeli Person.Address wyœwietl unikalne miasta  (City)
--2. Z tej samej tabeli wyœwietl unikalne kody pocztowe (PostalCode)
--3. Z tej samej tabeli wyœwietl unikalne kombinacje miast i kodów pocztowych
--4. Z tabeli Sales.SalesPerson wyœwietl BusinessEntityId i Bonus dla 4 pracowników z najwiêkszym bonusem
--5. Je¿eli s¹ jeszcze inne rekordy o takiej wartoœci jak ostatnia zwrócona w poprzednim zadaniu, to maj¹ siê one te¿ wyœwietliæ
--6. Wyœwietl 20% rekordów z najwy¿szymi Bonusami
--7. Je¿eli wartoœci siê powtarzaj¹ to równie¿ nale¿y je pokazaæ

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
--Sekcja 5, wyk³ad 59
--1. Napisz zapytanie do tabeli Sales.SalesOrderHeader. Wyfiltruj rekordy, które:
---Datê zamówienia (OrderDate) maj¹ miêdzy 2012-01-01 a 2012-03-31
---SalesPersonId ma mieæ wartoœæ (czyli nie jest null)
---TerritoryID  ma mieæ wartoœæ (czyli nie jest null)

--W wyniku ma byæ wyœwietlony:
---Miesi¹c z daty zamówienia
---SalesPersonId
---TerritoryID
---Suma z kolumny SubTotal
--2. Zmieñ zapytanie tak, aby wyœwietlane by³y tak¿e podsumowania dla:
---Miesi¹c i SalesPersonId
---Miesi¹c
---Ogó³em
--3. Zmieñ zapytanie tak aby widoczne by³y tak¿e sumy dla:
---Miesi¹c i TerritoryId
---SalesPersonId i TerritoryId
---SalesPersonId
---TerritoryId
--4. Zmieñ zapytanie tak, aby wyœwietli³y siê tylko sumy:
---miesi¹ca 
---miesi¹ca, SalesPersonId, TerritoryId
--ZACHOWAJ ROZWI¥ZANIA DO NASTÊPNEGO LABORATORIUM!

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
--Sekcja 5, wyk³ad 62
--W przyk³adach z poprzedniej lekcji, usuñ klauzulê WHERE  dodaj wywo³ania GROUPPING_ID w taki sposób, ¿e:

--po ka¿dej kolumnie (oprócz podsumowywanej wartoœci) ma siê  pojawiæ liczba wskazuj¹ca na to czy wartoœæ jest wartoœci¹ pochodz¹c¹ z tabeli czy jest dodana przez agregacjê
--w ostatniej kolumnie ma siê naleŸæ liczba, która zinterpretowana jako suma potêg dwójki pozwoli rozpoznaæ, które wartoœci s¹ dodane do zbioru poprzez agregacjê

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


