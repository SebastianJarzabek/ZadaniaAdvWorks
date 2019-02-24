--Podzapytania skalarne - LAB
--Sekcja 7, wyk³ad 80
--1. Z tabeli HumanResources.Employee wyœwietl LoginId oraz SickLeaveHours
--2. W nowym zapytaniu wyœwietl œredni¹ iloœæ SickleaveHours
--3. Napisz zapytanie w którym:
---wyœwietlone zostan¹ dane z pierwszego zapytania
---w dodatkowej kolumnie wyœwietl œredni¹ iloœæ SickleaveHours w postaci podzapytania
---zaaliasuj t¹ kolumnê jako AvgSickLeaveHours
--4. Skopiuj poprzednie zapytanie. W nowej kolumnie wylicz ró¿nicê miêdzy SickLeaveHours pracownika a wartoœci¹ œredni¹ ca³ej tabeli. Kolumnê zaaliasuj jako SickLeaveDiff
--5. Skopiuj poprzednie zapytanie. Dodaj klauzulê where, która spowoduje wyœwietlenie tylko tych pracowników, którzy maj¹ liczbê godzin SickLeaveHours wiêksz¹ ni¿ wartoœæ œredni¹. Uporz¹dkuj dane wg kolumny SickLeaveDiff malej¹co

SELECT

e.LoginID
,e.SickLeaveHours
FROM HumanResources.Employee e

SELECT AVG(SickLeaveHours) FROM HumanResources.Employee

SELECT
e.LoginID
,e.SickLeaveHours
    ,(SELECT AVG(SickLeaveHours) FROM HumanResources.Employee) AS AvgSickLeaveHours
FROM HumanResources.Employee e

SELECT
e.LoginID
,e.SickLeaveHours
    ,(SELECT AVG(SickLeaveHours) FROM HumanResources.Employee) AS AvgSickLeaveHours
    ,e.SickLeaveHours - (SELECT AVG(SickLeaveHours) FROM HumanResources.Employee) AS AvgSickLeaveHours
FROM HumanResources.Employee e

SELECT
e.LoginID
,e.SickLeaveHours
    ,(SELECT AVG(SickLeaveHours) FROM HumanResources.Employee) AS AvgSickLeaveHours
    ,e.SickLeaveHours - (SELECT AVG(SickLeaveHours) FROM HumanResources.Employee) AS SickLeaveDiff
FROM HumanResources.Employee e
WHERE e.SickLeaveHours > (SELECT AVG(SickLeaveHours) FROM HumanResources.Employee)
ORDER  BY SickLeaveDiff 

--Podzapytania zwracaj¹ce wiele wartoœci - LAB
--Sekcja 7, wyk³ad 83
--1. Napisz zapytanie zwracaj¹ce BusinessEntityId dla jednego dowolnego pracownika (TOP(1)) z tabeli Sales.SalesPerson. Rekord powinien prezentowaæ pracownika z TerritoryId=1

--2. Napisz zapytanie wyœwietlaj¹ce zamówienia z tabeli SalesOrderHeader dla tego pracownika

--3. Skopuj zapytanie z punktu (1) i usuñ z niego TOP(1).  Ile rekordów jest wyœwietlanych?

--4. Skopiuj zapytanie z punktu (2). Usuñ z niego TOP(1). Czy zapytanie dzia³a?

--5. Popraw zapytanie aby zwraca³o poprawny wynik

--6. Wyœwietl BusinessEntityId z tabeli HumanResources.DepartmentHistory dla DepartmentId=1.

--7. Wyœwietl rekordy z HumanResources.Employee rekordy pracowników, którzy kiedykolwiek pracowali w DepartamentId=1. Skorzystaj w tym celu z zapytania z pkt (6)

SELECT
TOP(1) BusinessEntityID
FROM Sales.SalesPerson WHERE TerritoryID = 1

SELECT * FROM sales.SalesOrderHeader 
WHERE SalesPersonID = 
(
SELECT TOP(1)
BusinessEntityID
FROM Sales.SalesPerson WHERE TerritoryID = 1
)

SELECT
BusinessEntityID
FROM Sales.SalesPerson WHERE TerritoryID = 1

-- error!
SELECT * FROM sales.SalesOrderHeader 
WHERE SalesPersonID = 
(
SELECT 
BusinessEntityID
FROM Sales.SalesPerson WHERE TerritoryID = 1
)

SELECT * FROM sales.SalesOrderHeader 
WHERE SalesPersonID IN
(
SELECT 
BusinessEntityID
FROM Sales.SalesPerson WHERE TerritoryID = 1
)

  SELECT BusinessEntityID
  FROM HumanResources.EmployeeDepartmentHistory 
  WHERE DepartmentID = 1

  SELECT * FROM HumanResources.Employee
  WHERE
  BusinessEntityID IN (
  SELECT BusinessEntityID
  FROM HumanResources.EmployeeDepartmentHistory 
  WHERE DepartmentID = 1
  )

--  Podzapytania wykorzystywane jako wirtualne tabele - LAB
--Sekcja 7, wyk³ad 86
--1. W aplikacji czêsto masz siê pos³ugiwaæ  informacjami o nazwie produktu, podkategorii i kategorii. Napisz zapytanie, które przy pomocy polecenia JOIN po³aczy ze sob¹ tabele:

--Production.Product, 
--Production.Subcategory i 
--Production.Category. 
--Wyœwietliæ nale¿y:

--ProductId
--ProductName
--SubcategoryName
--CategoryName
--Kolumny z nazwami powinny zostaæ zaaliasowane.

--2.  Napisz zapytanie, które z tabeli Sales.SalesOrderDetail wyœwietli LineTotal

--3. Do zapytania z pkt (2) do³¹cz zapytanie z pkt (1) tak aby do³aczane zapytanie by³o podzapytaniem. Wyœwietl:

--ProductId,
--ProductName,
--ProductSubcategory
--ProductCategory
--LineTotal
--4. Napisz zapytanie, które z tabel:

--Sales.SpecialOfferProduct
--Sales.SpecialOffer
--wyœwietli:

--ProductId
--Description
--5. Do zapytania z pkt (4) do³¹cz zapytanie z pkt (1) tak aby do³aczane zapytanie by³o podzapytaniem. Wyœwietl:

--ProductId,
--Description
--ProductName,
--ProductSubcategory
--ProductCategory

SELECT 

p.ProductID
,p.Name as ProductName
,sc.Name as SubcategoryName
,c.Name as CategoryName
FROM Production.Product p
JOIN Production.ProductSubcategory sc ON p.ProductSubcategoryID = sc.ProductSubcategoryID
JOIN Production.ProductCategory c ON c.ProductCategoryID = sc.ProductCategoryID

SELECT 
sod.LineTotal
,nnn.CategoryName
,nnn.SubcategoryName
,nnn.ProductName
FROM Sales.SalesOrderDetail sod 
JOIN
(
SELECT 
p.ProductID
,p.Name as ProductName
,sc.Name as SubcategoryName
,c.Name as CategoryName
FROM Production.Product p
JOIN Production.ProductSubcategory sc ON p.ProductSubcategoryID = sc.ProductSubcategoryID
JOIN Production.ProductCategory c ON c.ProductCategoryID = sc.ProductCategoryID
) nnn ON sod.ProductID = nnn.ProductID

SELECT
spo.ProductID
,o.Description
FROM Sales.SpecialOfferProduct spo
JOIN sales.SpecialOffer o ON spo.SpecialOfferID = o.SpecialOfferID

SELECT
spo.ProductID
,o.Description
,nnn.ProductName
,nnn.SubcategoryName
,nnn.CategoryName
FROM Sales.SpecialOfferProduct spo
JOIN sales.SpecialOffer o ON spo.SpecialOfferID = o.SpecialOfferID
JOIN
(
SELECT 
p.ProductID
,p.Name as ProductName
,sc.Name as SubcategoryName
,c.Name as CategoryName
FROM Production.Product p
JOIN Production.ProductSubcategory sc ON p.ProductSubcategoryID = sc.ProductSubcategoryID
JOIN Production.ProductCategory c ON c.ProductCategoryID = sc.ProductCategoryID
) nnn ON spo.ProductID = nnn.ProductID

--Podzapytania skorelowane - LAB
--Sekcja 7, wyk³ad 89
--1. Napisz zapytanie, które ³aczy ze sob¹ tabele: HumanResources.Employee i Person.Person (kolumna ³¹cz¹ca BusinessEntityId) i wyœwietla LastName i FirstName

--2. Bazuj¹c na poprzednim zapytaniu dodaj w liœcie select podzapytanie, które wyliczy ile razy dany pracownik zmienia³ departament pracuj¹c w firmie. W tym celu policz iloœæ rekordów w tabeli HumanResources. EmployeeDepartamentHistory, które maj¹ BusinessEntityId zgodne z numerem tego pracownika)

--3. Zmodyfikuj poprzednie polecenie tak, aby wyœwietliæ tylko pracowników, którzy pracowali co najmniej w dwóch departamentach

--4. W oparciu o dane z tabel HumanResources.Employee i Person.Person wyœwietl imiê i nazwisko pracownika (FirstName i LastName) oraz rok z daty zatrudnienia pracownika

--5. Do poprzedniego zapytania dodaj w SELECT podzapytanie wyœwietlaj¹ce informacjê o tym, ile osób zatrudni³o siê w tym samym roku co dany pracownik

--6. Napisz zapytanie, które wyœwietli w oparciu o tabele Sales.SalesPerson oraz Person.Person: LastName, FirstName, Bonus oraz SalesQuota

--7. Do poprzedniego zapytania dodaj dwa podzapytania w SELECT, które:

---wyznacz¹ œredni¹ wartoœæ Bonus dla wszystkich pracowników z tego samego terytorium (równoœæ wartoœci w kolumnie TerritoryID)

---wyznacz¹ œredni¹ wartoœæ SalesQuota dla wszystkich pracowników z tego samego terytorium (równoœæ wartoœci w kolumnie TerritoryID)

--8. Napisz polecenie wyœwietlaj¹ce WSZYSTKIE informacje z tabeli Sales.SalesPerson, dla tych sprzedawców, którzy SalesQuota maj¹ mniejsze od œrednieigo SalesQuota

--9, Zmodyfikuj poprzednie polecenie tak, aby liczenie œredniego SalesQuota dotyczy³o tylko sprzedawców z tego samego terytorium (zgodna kolumna TerritoryID)

--10. Z tabeli Sales.SalesOrderHeader wyœwietl rok i miesi¹c z OrderDate oraz iloœæ rekordów (pamiêtaj o grupowaniu)

--11. Do poprzedniego polecenia dodaj do SELECT informacjê o iloœci zamówieñ w poprzednim roku w tym samym miesi¹cu. Skorzystaj z podzapytania.

SELECT
p.LastName,p.FirstName
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID=p.BusinessEntityID

SELECT
p.LastName,p.FirstName
,(SELECT COUNT(*) FROM HumanResources.EmployeeDepartmentHistory h where h.BusinessEntityID=e.BusinessEntityID) AS 'Amount of departments'
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID=p.BusinessEntityID

SELECT
p.LastName,p.FirstName
,(SELECT COUNT(*) FROM HumanResources.EmployeeDepartmentHistory h where h.BusinessEntityID=e.BusinessEntityID) AS 'Amount of departments'
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID=p.BusinessEntityID
WHERE (SELECT COUNT(*) FROM HumanResources.EmployeeDepartmentHistory h where h.BusinessEntityID=e.BusinessEntityID) >1

SELECT
 YEAR(e.hiredate),p.LastName,p.FirstName
FROM HumanResources.Employee e
JOIN Person.person p ON e.BusinessEntityID=p.BusinessEntityID

SELECT
 YEAR(e.hiredate),p.LastName,p.FirstName
 ,(SELECT COUNT(*) FROM HumanResources.Employee e1 WHERE YEAR(e1.HireDate) = YEAR(e.hiredate)) AS 'How many employees hired this year'
FROM HumanResources.Employee e
JOIN Person.person p ON e.BusinessEntityID=p.BusinessEntityID

SELECT
p.LastName,p.FirstName
,sp.Bonus,sp.SalesQuota
FROM Sales.SalesPerson sp 
JOIN Person.Person  p  ON p.BusinessEntityID = sp.BusinessEntityID

SELECT
p.LastName,p.FirstName
,sp.Bonus,sp.SalesQuota
,(SELECT AVG(sp1.Bonus) FROM Sales.SalesPerson sp1 WHERE sp1.TerritoryID = sp.TerritoryID) AS AvgBonusInTerritory
,(SELECT AVG(sp1.SalesQuota) FROM Sales.SalesPerson sp1 WHERE sp1.TerritoryID = sp.TerritoryID) AS AvgQuotaInTerritory
FROM Sales.SalesPerson sp 
JOIN Person.Person  p  ON p.BusinessEntityID = sp.BusinessEntityID

SELECT 
*
FROM Sales.SalesPerson sp
WHERE sp.SalesQuota < (SELECT AVG(sp1.SalesQuota) FROM Sales.SalesPerson sp1)

SELECT 
*
FROM Sales.SalesPerson sp
WHERE sp.SalesQuota < (SELECT AVG(sp1.SalesQuota) FROM Sales.SalesPerson sp1 WHERE sp1.TerritoryID = sp.TerritoryID)

SELECT
YEAR(soh.OrderDate) as Year, MONTH(soh.orderdate) AS Month,
COUNT(*) AS SalesThisYear
FROM Sales.salesorderHeader soh
GROUP BY YEAR(soh.OrderDate), MONTH(soh.orderdate)
ORDER BY Year,Month

SELECT
YEAR(soh.OrderDate) as Year, MONTH(soh.orderdate) AS Month,
COUNT(*) AS SalesThisYear,
(
SELECT COUNT(*) 
FROM Sales.SalesOrderHeader soh1 
WHERE 
YEAR(soh1.OrderDate)=YEAR(soh.OrderDate)-1 AND MONTH(soh1.OrderDate)=MONTH(soh.OrderDate)
) AS SalesLastYear
FROM Sales.salesorderHeader soh
GROUP BY YEAR(soh.OrderDate), MONTH(soh.orderdate)
ORDER BY Year,Month

--Podzapytania EXISTS, ALL, SOME, ANY - LAB
--Sekcja 7, wyk³ad 92
--1. Trzeba sprawdziæ czy w tabeli Production.UnitMeasure znajduj¹ siê jednostki miary, które nie s¹ u¿ywane przez ¿aden rekord w Production.Product. Korzystaj¹c z jednego z przedstawionych w tej lekcji s³ów napisz zapytanie, które wyœwietli rekordy z Production.UnitMeasure nieu¿ywane w tabeli Production.Product ani w kolumnie SizeUnitMeasureCode ani w WeightUnitMeasureCode.

--2. Zmodyfikuj polecenie z punktu (1), tak aby wyœwietliæ te jednostki miary które s¹ wykorzystywane w Production.Product

--3.Wyœwietl z tabeli Production.Product te rekordy, gdzie ListPrice jest wiêksze ni¿ ListPrice ka¿dego produktu z kategorii 1

--4. Wyœwietl z tabeli Production.Product te rekordy, gdzie ListPrice jest wiêksze ni¿ ListPrice dla chocia¿ jednego produktu z kategorii 1

SELECT 

*
FROM Production.UnitMeasure um
WHERE
NOT EXISTS( SELECT * FROM Production.Product p WHERE um.UnitMeasureCode = p.SizeUnitMeasureCode OR um.UnitMeasureCode =p.WeightUnitMeasureCode)

SELECT 
*
FROM Production.UnitMeasure um
WHERE
EXISTS( SELECT * FROM Production.Product p WHERE um.UnitMeasureCode = p.SizeUnitMeasureCode OR um.UnitMeasureCode =p.WeightUnitMeasureCode)

SELECT * FROM Production.Product p WHERE p.ListPrice > ALL (select ListPrice FROM Production.Product p1 WHERE p1.ProductSubcategoryID =1)

SELECT * FROM Production.Product p WHERE p.ListPrice > SOME (select ListPrice FROM Production.Product p1 WHERE p1.ProductSubcategoryID =1)

--Zastêpowanie podzapytañ przez JOIN - LAB
--Sekcja 7, wyk³ad 95
--1. Poni¿sze zapytania odpowiada na pytanie "Jakie produkty maj¹ taki sam kolor, co produkt 322". Zapisz to zapytanie nie korzytaj¹c z podzapytañ

--SELECT p.* FROM Production.Product p
--WHERE
--p.Color = (SELECT Color FROM Production.Product WHERE ProductID=322)
--2. Poni¿sze zapytanie odpowiada na pytanie "Jak nazywa siê pracownik". Zamieñ je na postaæ bez podzapytañ

--SELECT
-- e.LoginID
-- ,(SELECT p.LastName+' '+p.FirstName 
--   FROM Person.Person p WHERE p.BusinessEntityID = e.BusinessEntityID) AS Name
--FROM HumanResources.Employee e
--3. Poni¿sze zapytanie odpowiada na pytanie "Jakie jednostki miary nie s¹ wykorzystywane przez produkty". Zapisz je nie wykorzystuj¹c podzapytañ

--SELECT 
--*
--FROM Production.UnitMeasure um
--WHERE
-- NOT EXISTS(
-- SELECT * FROM Production.Product p 
-- WHERE um.UnitMeasureCode = p.SizeUnitMeasureCode 
--       OR um.UnitMeasureCode =p.WeightUnitMeasureCode
-- )
--4. Poni¿sze zapytanie odpowiada na pytanie "Jakie jednostki miary s¹ wykorzystywane przez produkty". Zapisz je nie wykorzystuj¹c podzapytañ

--SELECT 
--um.*
--FROM Production.UnitMeasure um
--WHERE
-- EXISTS( 
-- SELECT * FROM Production.Product p 
-- WHERE um.UnitMeasureCode = p.SizeUnitMeasureCode 
--   OR um.UnitMeasureCode =p.WeightUnitMeasureCode
-- )

SELECT p.* FROM Production.Product p

WHERE
p.Color = (SELECT Color FROM Production.Product WHERE ProductID=322)

SELECT p.* 
FROM Production.Product p
JOIN Production.Product p2 ON p2.color=p.color 
WHERE p2.ProductID=322

SELECT
e.LoginID
,(SELECT p.LastName+' '+p.FirstName FROM Person.Person p WHERE p.BusinessEntityID = e.BusinessEntityID) AS Name
FROM HumanResources.Employee e

SELECT
e.LoginID
,p.LastName+' '+p.FirstName
FROM HumanResources.Employee e
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID

SELECT 
*
FROM Production.UnitMeasure um
WHERE
NOT EXISTS(
SELECT * FROM Production.Product p 
WHERE um.UnitMeasureCode = p.SizeUnitMeasureCode OR um.UnitMeasureCode =p.WeightUnitMeasureCode
)

SELECT
*
FROM Production.UnitMeasure um
LEFT JOIN Production.Product pSize ON um.UnitMeasureCode = pSize.SizeUnitMeasureCode
LEFT JOIN Production.Product pWeight ON um.UnitMeasureCode = pWeight.WeightUnitMeasureCode
WHERE 
pSize.ProductID IS NULL AND pWeight.ProductID IS NULL

SELECT 
um.*
FROM Production.UnitMeasure um
WHERE
EXISTS( 
SELECT * FROM Production.Product p 
WHERE um.UnitMeasureCode = p.SizeUnitMeasureCode OR um.UnitMeasureCode =p.WeightUnitMeasureCode
)

SELECT
DISTINCT um.*
FROM Production.UnitMeasure um
LEFT JOIN Production.Product pSize ON um.UnitMeasureCode = pSize.SizeUnitMeasureCode
LEFT JOIN Production.Product pWeight ON um.UnitMeasureCode = pWeight.WeightUnitMeasureCode
WHERE 
pSize.ProductID IS NOT NULL OR pWeight.ProductID IS NOT  NULL