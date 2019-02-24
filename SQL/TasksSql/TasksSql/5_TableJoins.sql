----INNER JOIN - LAB
----Sekcja 6, wyk�ad 65
----1. Wy�wietl:
----z tabeli Person.Person: FirstName i LastName
----z tabeli Sales.SalesPerson: Bonus
----kolumn� ��cz�c� jest BusinessEntityId
----2. Wy�wietl:
----z tabeli Sales.SalesOrderHeader: SalesOrderId, OrderDate i SalesOrderNumber
----z tabeli SalesOrderDetail: ProductId, OrderQty, UnitPrice
----kolumn� ��cz�c� jest SalesOrderId
----3. Wy�wietl:
----z tabeli Production.Product: Name
----z tabeli Sales.SalesOrderDetails: warto�� zam�wienia z rabatem (UnitPrice - UnitPriceDiscount)*OrderQty
----kolumna ��cz�ca to ProductId
----4. Bazuj�c na poprzednim zapytaniu wyznacz jaka jest ca�kowita warto�� sprzeda�y okre�lonych produkt�w, tzn. w wyniku masz zobaczy�:
----nazw� produktu
----ca�kowit� warto�� sprzeda�y tego produktu
----wynik posortuj wg wysoko�ci sprzeda�y malej�co
----5. Wy�wietl
----z tabeli Production.Category: Name
----z tabeli Production.SubCategory: Name
----zaaliasuj kolumny, aby by�o wiadomo, co w nich si� znajduje
----6. Na podstawie poprzedniego zapytania przygotuj nast�pne, kt�re poka�e ile podkategorii ma ka�da kategoria. Wy�wietl:
----nazw� kategorii
----ilo�� podkategorii
----posortuj wg nazwy kategorii
----7. Wy�wietl:
----z tabeli Production.Product: name
----oraz ilo�� recencji produku (tabela Production.ProductReview)
----8. Ustal, kt�rzy pracownicy pracowali na wi�kszej ilo�ci zmian. W tym celu po��cz tabele:
----HumanResources.EmployeeDepartmentHistory z
----Person.Person
----wy�wietl:
----imi� i nazwisko (FirstName i LastName)
----oraz ilo�� dopasowanych rekord�w
----Wybierz tylko te wiersze, w kt�rych wyznaczona ilo�� COUNT(*) jest wi�ksza ni� 1

--SELECT
--p.FirstName
--,p.LastName
--,sp.Bonus
--FROM Person.Person p
--JOIN Sales.SalesPerson sp ON sp.BusinessEntityID = p.BusinessEntityID

--SELECT 
--h.SalesOrderID
--,h.OrderDate
--,h.SalesOrderNumber
--,d.ProductID
--,d.OrderQty
--,d.UnitPrice
--FROM Sales.SalesOrderHeader h
--JOIN sales.SalesOrderDetail d ON h.SalesOrderID = d.SalesOrderID

--SELECT 
--p.Name
--,(d.UnitPrice-d.UnitPriceDiscount)*OrderQty AS Value
--FROM Sales.SalesOrderDetail d
--JOIN Production.Product p ON d.ProductID = p.ProductID

--SELECT 
--p.Name
--,SUM((d.UnitPrice-d.UnitPriceDiscount)*OrderQty) AS TotalValue
--FROM Sales.SalesOrderDetail d
--JOIN Production.Product p ON d.ProductID = p.ProductID
--GROUP BY p.Name
--ORDER BY TotalValue DESC

--SELECT
--c.Name as "Category Name"
--,s.Name as "Subcategory Name"
--FROM Production.ProductCategory c
--JOIN Production.ProductSubcategory s oN c.ProductCategoryID = s.ProductCategoryID

--SELECT
--c.Name as "Category Name"
--,Count(*) AS NumberOfSubcategories
--FROM Production.ProductCategory c
--JOIN Production.ProductSubcategory s oN c.ProductCategoryID = s.ProductCategoryID
--GROUP BY c.Name
--ORDER BY c.Name

--SELECT 
--p.Name, count(*) as 'ReviewAmount'
--FROM Production.Product p 
--JOIN Production.ProductReview r on p.ProductID = r.ProductID
--GROUP BY p.name

--SELECT 
--p.LastName
--,p.FirstName
--,count(*)
--FROM HumanResources.EmployeeDepartmentHistory h
--JOIN Person.Person p on p.BusinessEntityID = h.BusinessEntityID
--GROUP BY p.LastName, p.FirstName
--HAVING count(*) >1

--OUTER JOIN - LAB
--Sekcja 6, wyk�ad 68
--1. Wy�wietl:
--z tabeli Person.Person: LastName i FirstName
--z tabeli Person.PhoneNumber: PhoneNumber
--wy�wietlaj r�wnie� te osoby, kt�re nie poda�y numeru telefonu (je�li takie s�)
--2. Zmodyfikuj poprzednie polecenie tak, aby wy�wietlone zosta�y tylko te osoby, kt�re nie poda�y numeru telefonu (je�li takie s�)
--3. Wy�wietl:
--z tabeli Production.Product: Name
--z tabeli Production.ProductDocument: DocumentNode
--uwzgl�dnij w tym r�wnie� te produkty, kt�re nie maj� "pasuj�cego rekordu"
--4. Zmodyfikuj poprzednie polecenie tak, aby wy�wietlone zosta�y tylko te produkty, kt�re nie maj� 'pasuj�cego' rekordu w tabeli dokument�w
--5. (*Wymagane dwukrotne do��czenie tej samej tabeli z r�nymi aliasami!)
--W tym zadaniu szukamy, czy s� takie jednostki miary, kt�re nie s� wykorzystywane w tabeli produkt�w, bo np. chcemy usun�� niepotrzebne jednostki miary z tabeli
--wy�wietl:
--z tabeli Production.UnitMeasure: Name, UnitMeasureCode

--napis "Is used as a size" je�eli uda�o si� znale�� "pasuj�cy" rekord w tabeli Production.Product ��cz�c tabele UnitMeasure z tabel� Product korzystaj�c z kolumny SizeUnitMeasureCode

--napis "Is used as a weight" je�eli uda�o si� znale�� "pasuj�cy" rekord w tabeli Production.Product ��cz�c tabele UnitMeasure z tabel� Product korzystaj�c z kolumny WeightUnitMeasureCode
--6. Zmodyfikuj poprzednie polecenie tak, aby wy�wietlone zosta�y tylko te jednostki miary, kt�re nie s� u�ywane ani do okre�lenia rozmiaru produktu, ani do okre�lnenia wagi

SELECT 
p.LastName
,p.FirstName
,ph.PhoneNumber
FROM Person.Person p
LEFT JOIN Person.PersonPhone ph ON p.BusinessEntityID = ph.BusinessEntityID

SELECT 
p.LastName
,p.FirstName
,ph.PhoneNumber
FROM Person.Person p
LEFT JOIN Person.PersonPhone ph ON p.BusinessEntityID = ph.BusinessEntityID
WHERE ph.PhoneNumber IS NULL

SELECT 
p.name
,pd.DocumentNode
FROM Production.Product p 
LEFT JOIN Production.ProductDocument pd ON p.ProductID = pd.ProductID

SELECT 
p.name
,pd.DocumentNode
FROM Production.Product p 
LEFT JOIN Production.ProductDocument pd ON p.ProductID = pd.ProductID
WHERE pd.ProductID IS NULL

SELECT
m.name
,m.UnitMeasureCode
,CASE
WHEN pSize.SizeUnitMeasureCode IS NOT NULL THEN 'Is used as size'
WHEN pWeight.WeightUnitMeasureCode IS NOT NULL THEN 'Is used as weight'
END as 'Used as'
FROM Production.UnitMeasure m
LEFT JOIN Production.Product pSize ON m.UnitMeasureCode = pSize.SizeUnitMeasureCode
LEFT JOIN Production.Product pWeight ON m.UnitMeasureCode = pWeight.WeightUnitMeasureCode

SELECT
m.name
,m.UnitMeasureCode
,CASE
WHEN pSize.SizeUnitMeasureCode IS NOT NULL THEN 'Is used as size'
WHEN pWeight.WeightUnitMeasureCode IS NOT NULL THEN 'Is used as weight'
END as 'Used as'
FROM Production.UnitMeasure m
LEFT JOIN Production.Product pSize ON m.UnitMeasureCode = pSize.SizeUnitMeasureCode
LEFT JOIN Production.Product pWeight ON m.UnitMeasureCode = pWeight.WeightUnitMeasureCode
WHERE pSize.SizeUnitMeasureCode IS NULL AND pWeight.WeightUnitMeasureCode IS NULL

--Z��czenia wielu tabel - LAB
--Sekcja 6, wyk�ad 71
--1. Po��cz tabele Production.Product z Sales.SalesOrderDetail (kolumna ProductId)  i z Sales.SalesOrderHeader (kolumna SalesOrderId). 
--Wy�wietl:
--nazw� produktu (Name)
--dat� zam�wienia (OrderDate)
--2. W oparciu o poprzednie zapytanie wy�wietl informacj�o ostatniej dacie sprzeda�y produktu. Wynik uporz�dkuj wg ostatniej daty zam�wienia malej�co
--3. Zmodyfikuj poprzednie zapytanie tak, aby uwzgl�dnione zosta�y r�wnie� produkty, kt�re nigdy nie by�y sprzedane
--4. Sprad� na jakich zmianach pracuj� pracownicy firmy
--Wy�wietl
--z tabeli Person.Person: LastName i FirstName
--z tabeli HumanResources.Shift: Name
--do z��czenia przyda si� jeszcze tabela HumanResources.EmployeeDepartmentHistory. Odgadnij nazwy kolumn ��cz�ce te tabele ze sob�
--5. Sprawd� w ramach jakich promocji s� sprzedawane produkty
--Wy�wietl
--z tabeli Production.Product: Name
--z tabeli Sales.SpecialOffer: Description
--do z�aczenia przyda si� tabela Sales.SpecialOfferProduct. Odgadnij nazwy kolumn ��cz�ce te tabele

SELECT
p.Name as 'product name'
, soh.OrderDate
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
JOIN sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID

SELECT
p.Name as 'product name'
, MAX(soh.OrderDate) as 'last ordered'
FROM Production.Product p
JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
JOIN sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY p.Name
ORDER BY 'last ordered' DESC

SELECT
p.Name as 'product name'
, MAX(soh.OrderDate) as 'last ordered'
FROM Production.Product p
LEFT JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
LEFT JOIN sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
GROUP BY p.Name
ORDER BY 'last ordered' DESC

SELECT 
p.LastName
, p.FirstName
, s.Name as 'shift name'
FROM Person.Person p
JOIN HumanResources.EmployeeDepartmentHistory h ON p.BusinessEntityID = h.BusinessEntityID
JOIN HumanResources.Shift s on h.ShiftID = s.ShiftID

SELECT 
so.Description 
, p.name as ProductName
FROM Production.Product p
JOIN sales.SpecialOfferProduct sop ON p.ProductID = sop.ProductID
JOIN sales.SpecialOffer so ON so.SpecialOfferID = sop.SpecialOfferID

--CROSS JOIN - LAB
--Sekcja 6, wyk�ad 74
--1. Kierownik zastanawia si�, jak przydzieli� pracownik�w do r�nych zmian. Postanawia rozpocz�� od wypisania wszystkich mo�liwych kombinacji z ka�dym pracownikiem na ka�dej zmianie. 
--Napisz polecenie, kt�re wy�wietli imi� i nazwisko pracownika (FirstName i LastName z tabeli HumanResources.Employee) i nazw� zmiany (name z tabeli HumanResources.Shift)

--2. Wy�wietl unikalne nazwy kolor�w z tabeli Production.Product

--3. Wy�wietl unikalne nazwy klas z tabeli Production.Product

--4. Dyrektor firmy zastanawia si� jakie klasy produkt�w i kolor�w nale�y produkowa�. Na pocz�tek chce otrzyma� kombinacj� wszystkich aktualnych klas i kolor�w. W oparciu o poprzednie zapytania utw�rz nowe, kt�re po�aczy ka�dy kolor z ka�d� klas�. 

--5. Budujemy tabel� kompetencji pracownik�w. Ka�dy pracownik ma mie� swojego zast�pc� (w parach). Zaczynamy od stworzenia listy na podstawie Sales.SalesPerson, kt�ra poka�e imi� i nazwisko pracownika i imi� i nazwisko jego potencjalnego zast�pcy. Wy�wietlaj�c wyniki do��cz do tabeli Sales.SalesPerson tabel� Person.Person, sk�d mo�na pobra� FirstName i LastName. Musisz to zrobi� 2 razy - raz aby uzyska� imi� i nazwisko pracownika i raz aby uzyska� imi� i nazwisko zast�pcy,

--6. Zmie� zapytanie z poprzedniego zadania tak, aby wy�wietlane pary by�y unikalne. Je�liX zast�puje Y, to nie pokazuj rekordu Y zast�puje X

SELECT 
p.LastName
,p.FirstName
,s.Name as 'shift name'
FROM HumanResources.Employee e
JOIN Person.Person p on e.BusinessEntityID = p.BusinessEntityID
CROSS JOIN HumanResources.Shift s

SELECT DISTINCT Color FROM Production.Product
SELECT DISTINCT Class FROM Production.Product

SELECT
DISTINCT
p1.Color
,p2.Class
FROM Production.Product p1
CROSS JOIN Production.Product p2

Select 
p1.LastName, p1.FirstName
,p2.LastName,p1.FirstName
FROM Sales.SalesPerson s1
JOIN Person.Person p1 on p1.BusinessEntityID = s1.BusinessEntityID
CROSS JOIN Sales.SalesPerson s2
JOIN Person.Person p2 on p2.BusinessEntityID = s2.BusinessEntityID

Select 
p1.LastName, p1.FirstName
,p2.LastName,p1.FirstName
FROM Sales.SalesPerson s1
JOIN Person.Person p1 on p1.BusinessEntityID = s1.BusinessEntityID
CROSS JOIN Sales.SalesPerson s2
JOIN Person.Person p2 on p2.BusinessEntityID = s2.BusinessEntityID
WHERE s1.BusinessEntityID < s2.BusinessEntityID

--FULL JOIN - LAB
--Sekcja 6, wyk�ad 77
--W tem LAB musimy najpierw co� zepsu�... Uruchom nast�puj�cy kod

--BEGIN TRAN
 
--ALTER TABLE Person.Person NOCHECK CONSTRAINT ALL
--ALTER TABLE Sales.SalesPerson NOCHECK CONSTRAINT ALL
--ALTER TABLE HumanResources.EmployeeDepartmentHistory NOCHECK CONSTRAINT ALL
--ALTER TABLE HumanResources.EmployeePayHistory NOCHECK CONSTRAINT ALL
--ALTER TABLE HumanResources.JobCandidate NOCHECK CONSTRAINT ALL
--ALTER TABLE HumanResources.Employee NOCHECK CONSTRAINT ALL
--UPDATE HumanResources.Employee set BusinessEntityID=1074 WHERE BusinessEntityID = 274
--�wiczenie wykonuj poni�ej w tym samym oknie skryptu. Nie zapomnij wycofa� wprowadzonej tu zmiany poleceniem ROLLBACK (opisane w ostatnim kroku)/

--W/w polecenia w ramach transakcji wy��czaj� na chwil� mechanizmy obronne bazy, kt�re zabezpieczaj� j� przed wprowadzaniem niepoprawnych danych. My chcieli�my celowo doprowadzi� do tego, �e sprzedawca 274 przestanie by� pracownikiem firmy.... pozostaj�c jej sprzedawc� (zatrudnienie na czarno ;) 

--1. Z tabeli HumanResources.Employee wy�wietl BusinessEntityId i LoginId. Ile jest rekord�w?
--2. Z tabeli Sales.SalesPerson wy�wietl BusinessEntityId i Bonus. Ile jest rekord�w?
--3. Szukamy pracownik�w, kt�rzy s� sprzedawcami. Po��cz obie tabele przez INNER JOIN - ile jest rekord�w? 
--4. O ka�dym pracowniku szukamy informacji o tym czy jest sprzedawc�. Oczywi�cie wielu pracownik�w nie jest sprzedawcami. 
--5. Po��cz tabel� HumanResources.Employee z tabel� Sales.SalesPerson przy pomocy LEFT JOIN. Ile rekord�w zostanie zwr�conych?
--6. O ka�dym sprzedawcy szukamy informacji, czy jest pracownikem. Wszyscy poza jednym s�...
--Po��cz tabbel� Sales.SalesPerson z tabel� HumanResources.Employee przy pomocy LEFT JOIN. Ile rekord�w zostanie zwr�conych?
--Po��cz obie tabele korzystaj�c z FULL JOIN - ile rekord�w zostanie zwr�conych?
--Aby wycofa� pocz�tkowe zmiany wykonaj:

--ROLLBACK 

BEGIN TRAN


ALTER TABLE Person.Person NOCHECK CONSTRAINT ALL
ALTER TABLE Sales.SalesPerson NOCHECK CONSTRAINT ALL
ALTER TABLE HumanResources.EmployeeDepartmentHistory NOCHECK CONSTRAINT ALL
ALTER TABLE HumanResources.EmployeePayHistory NOCHECK CONSTRAINT ALL
ALTER TABLE HumanResources.JobCandidate NOCHECK CONSTRAINT ALL
ALTER TABLE HumanResources.Employee NOCHECK CONSTRAINT ALL

UPDATE HumanResources.Employee set BusinessEntityID=1074 WHERE BusinessEntityID = 274

SELECT 
e.BusinessEntityID
,e.LoginID
FROM HumanResources.Employee e

SELECT
p.BusinessEntityID
,p.Bonus
FROM sales.SalesPerson p

SELECT 
e.BusinessEntityID
,e.LoginID
,p.BusinessEntityID
,p.Bonus
FROM HumanResources.Employee e
JOIN Sales.SalesPerson p ON e.BusinessEntityID = p.BusinessEntityID

SELECT 
e.BusinessEntityID
,e.LoginID
,p.BusinessEntityID
,p.Bonus
FROM HumanResources.Employee e
LEFT JOIN Sales.SalesPerson p ON e.BusinessEntityID = p.BusinessEntityID

SELECT 
e.BusinessEntityID
,e.LoginID
,p.BusinessEntityID
,p.Bonus
FROM HumanResources.Employee e
RIGHT JOIN Sales.SalesPerson p ON e.BusinessEntityID = p.BusinessEntityID

SELECT 
e.BusinessEntityID
,e.LoginID
,p.BusinessEntityID
,p.Bonus
FROM HumanResources.Employee e
FULL JOIN Sales.SalesPerson p ON e.BusinessEntityID = p.BusinessEntityID

ROLLBACK