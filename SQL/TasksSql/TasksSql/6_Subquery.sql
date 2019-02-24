--Podzapytania skalarne - LAB
--Sekcja 7, wyk�ad 80
--1. Z tabeli HumanResources.Employee wy�wietl LoginId oraz SickLeaveHours
--2. W nowym zapytaniu wy�wietl �redni� ilo�� SickleaveHours
--3. Napisz zapytanie w kt�rym:
---wy�wietlone zostan� dane z pierwszego zapytania
---w dodatkowej kolumnie wy�wietl �redni� ilo�� SickleaveHours w postaci podzapytania
---zaaliasuj t� kolumn� jako AvgSickLeaveHours
--4. Skopiuj poprzednie zapytanie. W nowej kolumnie wylicz r�nic� mi�dzy SickLeaveHours pracownika a warto�ci� �redni� ca�ej tabeli. Kolumn� zaaliasuj jako SickLeaveDiff
--5. Skopiuj poprzednie zapytanie. Dodaj klauzul� where, kt�ra spowoduje wy�wietlenie tylko tych pracownik�w, kt�rzy maj� liczb� godzin SickLeaveHours wi�ksz� ni� warto�� �redni�. Uporz�dkuj dane wg kolumny SickLeaveDiff malej�co

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

--Podzapytania zwracaj�ce wiele warto�ci - LAB
--Sekcja 7, wyk�ad 83
--1. Napisz zapytanie zwracaj�ce BusinessEntityId dla jednego dowolnego pracownika (TOP(1)) z tabeli Sales.SalesPerson. Rekord powinien prezentowa� pracownika z TerritoryId=1

--2. Napisz zapytanie wy�wietlaj�ce zam�wienia z tabeli SalesOrderHeader dla tego pracownika

--3. Skopuj zapytanie z punktu (1) i usu� z niego TOP(1).  Ile rekord�w jest wy�wietlanych?

--4. Skopiuj zapytanie z punktu (2). Usu� z niego TOP(1). Czy zapytanie dzia�a?

--5. Popraw zapytanie aby zwraca�o poprawny wynik

--6. Wy�wietl BusinessEntityId z tabeli HumanResources.DepartmentHistory dla DepartmentId=1.

--7. Wy�wietl rekordy z HumanResources.Employee rekordy pracownik�w, kt�rzy kiedykolwiek pracowali w DepartamentId=1. Skorzystaj w tym celu z zapytania z pkt (6)

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
--Sekcja 7, wyk�ad 86
--1. W aplikacji cz�sto masz si� pos�ugiwa�  informacjami o nazwie produktu, podkategorii i kategorii. Napisz zapytanie, kt�re przy pomocy polecenia JOIN po�aczy ze sob� tabele:

--Production.Product, 
--Production.Subcategory i 
--Production.Category. 
--Wy�wietli� nale�y:

--ProductId
--ProductName
--SubcategoryName
--CategoryName
--Kolumny z nazwami powinny zosta� zaaliasowane.

--2.  Napisz zapytanie, kt�re z tabeli Sales.SalesOrderDetail wy�wietli LineTotal

--3. Do zapytania z pkt (2) do��cz zapytanie z pkt (1) tak aby do�aczane zapytanie by�o podzapytaniem. Wy�wietl:

--ProductId,
--ProductName,
--ProductSubcategory
--ProductCategory
--LineTotal
--4. Napisz zapytanie, kt�re z tabel:

--Sales.SpecialOfferProduct
--Sales.SpecialOffer
--wy�wietli:

--ProductId
--Description
--5. Do zapytania z pkt (4) do��cz zapytanie z pkt (1) tak aby do�aczane zapytanie by�o podzapytaniem. Wy�wietl:

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
--Sekcja 7, wyk�ad 89
--1. Napisz zapytanie, kt�re �aczy ze sob� tabele: HumanResources.Employee i Person.Person (kolumna ��cz�ca BusinessEntityId) i wy�wietla LastName i FirstName

--2. Bazuj�c na poprzednim zapytaniu dodaj w li�cie select podzapytanie, kt�re wyliczy ile razy dany pracownik zmienia� departament pracuj�c w firmie. W tym celu policz ilo�� rekord�w w tabeli HumanResources. EmployeeDepartamentHistory, kt�re maj� BusinessEntityId zgodne z numerem tego pracownika)

--3. Zmodyfikuj poprzednie polecenie tak, aby wy�wietli� tylko pracownik�w, kt�rzy pracowali co najmniej w dw�ch departamentach

--4. W oparciu o dane z tabel HumanResources.Employee i Person.Person wy�wietl imi� i nazwisko pracownika (FirstName i LastName) oraz rok z daty zatrudnienia pracownika

--5. Do poprzedniego zapytania dodaj w SELECT podzapytanie wy�wietlaj�ce informacj� o tym, ile os�b zatrudni�o si� w tym samym roku co dany pracownik

--6. Napisz zapytanie, kt�re wy�wietli w oparciu o tabele Sales.SalesPerson oraz Person.Person: LastName, FirstName, Bonus oraz SalesQuota

--7. Do poprzedniego zapytania dodaj dwa podzapytania w SELECT, kt�re:

---wyznacz� �redni� warto�� Bonus dla wszystkich pracownik�w z tego samego terytorium (r�wno�� warto�ci w kolumnie TerritoryID)

---wyznacz� �redni� warto�� SalesQuota dla wszystkich pracownik�w z tego samego terytorium (r�wno�� warto�ci w kolumnie TerritoryID)

--8. Napisz polecenie wy�wietlaj�ce WSZYSTKIE informacje z tabeli Sales.SalesPerson, dla tych sprzedawc�w, kt�rzy SalesQuota maj� mniejsze od �rednieigo SalesQuota

--9, Zmodyfikuj poprzednie polecenie tak, aby liczenie �redniego SalesQuota dotyczy�o tylko sprzedawc�w z tego samego terytorium (zgodna kolumna TerritoryID)

--10. Z tabeli Sales.SalesOrderHeader wy�wietl rok i miesi�c z OrderDate oraz ilo�� rekord�w (pami�taj o grupowaniu)

--11. Do poprzedniego polecenia dodaj do SELECT informacj� o ilo�ci zam�wie� w poprzednim roku w tym samym miesi�cu. Skorzystaj z podzapytania.

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
--Sekcja 7, wyk�ad 92
--1. Trzeba sprawdzi� czy w tabeli Production.UnitMeasure znajduj� si� jednostki miary, kt�re nie s� u�ywane przez �aden rekord w Production.Product. Korzystaj�c z jednego z przedstawionych w tej lekcji s��w napisz zapytanie, kt�re wy�wietli rekordy z Production.UnitMeasure nieu�ywane w tabeli Production.Product ani w kolumnie SizeUnitMeasureCode ani w WeightUnitMeasureCode.

--2. Zmodyfikuj polecenie z punktu (1), tak aby wy�wietli� te jednostki miary kt�re s� wykorzystywane w Production.Product

--3.Wy�wietl z tabeli Production.Product te rekordy, gdzie ListPrice jest wi�ksze ni� ListPrice ka�dego produktu z kategorii 1

--4. Wy�wietl z tabeli Production.Product te rekordy, gdzie ListPrice jest wi�ksze ni� ListPrice dla chocia� jednego produktu z kategorii 1

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

--Zast�powanie podzapyta� przez JOIN - LAB
--Sekcja 7, wyk�ad 95
--1. Poni�sze zapytania odpowiada na pytanie "Jakie produkty maj� taki sam kolor, co produkt 322". Zapisz to zapytanie nie korzytaj�c z podzapyta�

--SELECT p.* FROM Production.Product p
--WHERE
--p.Color = (SELECT Color FROM Production.Product WHERE ProductID=322)
--2. Poni�sze zapytanie odpowiada na pytanie "Jak nazywa si� pracownik". Zamie� je na posta� bez podzapyta�

--SELECT
-- e.LoginID
-- ,(SELECT p.LastName+' '+p.FirstName 
--   FROM Person.Person p WHERE p.BusinessEntityID = e.BusinessEntityID) AS Name
--FROM HumanResources.Employee e
--3. Poni�sze zapytanie odpowiada na pytanie "Jakie jednostki miary nie s� wykorzystywane przez produkty". Zapisz je nie wykorzystuj�c podzapyta�

--SELECT 
--*
--FROM Production.UnitMeasure um
--WHERE
-- NOT EXISTS(
-- SELECT * FROM Production.Product p 
-- WHERE um.UnitMeasureCode = p.SizeUnitMeasureCode 
--       OR um.UnitMeasureCode =p.WeightUnitMeasureCode
-- )
--4. Poni�sze zapytanie odpowiada na pytanie "Jakie jednostki miary s� wykorzystywane przez produkty". Zapisz je nie wykorzystuj�c podzapyta�

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