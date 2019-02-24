----INNER JOIN - LAB
----Sekcja 6, wyk³ad 65
----1. Wyœwietl:
----z tabeli Person.Person: FirstName i LastName
----z tabeli Sales.SalesPerson: Bonus
----kolumn¹ ³¹cz¹c¹ jest BusinessEntityId
----2. Wyœwietl:
----z tabeli Sales.SalesOrderHeader: SalesOrderId, OrderDate i SalesOrderNumber
----z tabeli SalesOrderDetail: ProductId, OrderQty, UnitPrice
----kolumn¹ ³¹cz¹c¹ jest SalesOrderId
----3. Wyœwietl:
----z tabeli Production.Product: Name
----z tabeli Sales.SalesOrderDetails: wartoœæ zamówienia z rabatem (UnitPrice - UnitPriceDiscount)*OrderQty
----kolumna ³¹cz¹ca to ProductId
----4. Bazuj¹c na poprzednim zapytaniu wyznacz jaka jest ca³kowita wartoœæ sprzeda¿y okreœlonych produktów, tzn. w wyniku masz zobaczyæ:
----nazwê produktu
----ca³kowit¹ wartoœæ sprzeda¿y tego produktu
----wynik posortuj wg wysokoœci sprzeda¿y malej¹co
----5. Wyœwietl
----z tabeli Production.Category: Name
----z tabeli Production.SubCategory: Name
----zaaliasuj kolumny, aby by³o wiadomo, co w nich siê znajduje
----6. Na podstawie poprzedniego zapytania przygotuj nastêpne, które poka¿e ile podkategorii ma ka¿da kategoria. Wyœwietl:
----nazwê kategorii
----iloœæ podkategorii
----posortuj wg nazwy kategorii
----7. Wyœwietl:
----z tabeli Production.Product: name
----oraz iloœæ recencji produku (tabela Production.ProductReview)
----8. Ustal, którzy pracownicy pracowali na wiêkszej iloœci zmian. W tym celu po³¹cz tabele:
----HumanResources.EmployeeDepartmentHistory z
----Person.Person
----wyœwietl:
----imiê i nazwisko (FirstName i LastName)
----oraz iloœæ dopasowanych rekordów
----Wybierz tylko te wiersze, w których wyznaczona iloœæ COUNT(*) jest wiêksza ni¿ 1

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
--Sekcja 6, wyk³ad 68
--1. Wyœwietl:
--z tabeli Person.Person: LastName i FirstName
--z tabeli Person.PhoneNumber: PhoneNumber
--wyœwietlaj równie¿ te osoby, które nie poda³y numeru telefonu (jeœli takie s¹)
--2. Zmodyfikuj poprzednie polecenie tak, aby wyœwietlone zosta³y tylko te osoby, które nie poda³y numeru telefonu (jeœli takie s¹)
--3. Wyœwietl:
--z tabeli Production.Product: Name
--z tabeli Production.ProductDocument: DocumentNode
--uwzglêdnij w tym równie¿ te produkty, które nie maj¹ "pasuj¹cego rekordu"
--4. Zmodyfikuj poprzednie polecenie tak, aby wyœwietlone zosta³y tylko te produkty, które nie maj¹ 'pasuj¹cego' rekordu w tabeli dokumentów
--5. (*Wymagane dwukrotne do³¹czenie tej samej tabeli z ró¿nymi aliasami!)
--W tym zadaniu szukamy, czy s¹ takie jednostki miary, które nie s¹ wykorzystywane w tabeli produktów, bo np. chcemy usun¹æ niepotrzebne jednostki miary z tabeli
--wyœwietl:
--z tabeli Production.UnitMeasure: Name, UnitMeasureCode

--napis "Is used as a size" je¿eli uda³o siê znaleŸæ "pasuj¹cy" rekord w tabeli Production.Product ³¹cz¹c tabele UnitMeasure z tabel¹ Product korzystaj¹c z kolumny SizeUnitMeasureCode

--napis "Is used as a weight" je¿eli uda³o siê znaleŸæ "pasuj¹cy" rekord w tabeli Production.Product ³¹cz¹c tabele UnitMeasure z tabel¹ Product korzystaj¹c z kolumny WeightUnitMeasureCode
--6. Zmodyfikuj poprzednie polecenie tak, aby wyœwietlone zosta³y tylko te jednostki miary, które nie s¹ u¿ywane ani do okreœlenia rozmiaru produktu, ani do okreœlnenia wagi

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

--Z³¹czenia wielu tabel - LAB
--Sekcja 6, wyk³ad 71
--1. Po³¹cz tabele Production.Product z Sales.SalesOrderDetail (kolumna ProductId)  i z Sales.SalesOrderHeader (kolumna SalesOrderId). 
--Wyœwietl:
--nazwê produktu (Name)
--datê zamówienia (OrderDate)
--2. W oparciu o poprzednie zapytanie wyœwietl informacjêo ostatniej dacie sprzeda¿y produktu. Wynik uporz¹dkuj wg ostatniej daty zamówienia malej¹co
--3. Zmodyfikuj poprzednie zapytanie tak, aby uwzglêdnione zosta³y równie¿ produkty, które nigdy nie by³y sprzedane
--4. SpradŸ na jakich zmianach pracuj¹ pracownicy firmy
--Wyœwietl
--z tabeli Person.Person: LastName i FirstName
--z tabeli HumanResources.Shift: Name
--do z³¹czenia przyda siê jeszcze tabela HumanResources.EmployeeDepartmentHistory. Odgadnij nazwy kolumn ³¹cz¹ce te tabele ze sob¹
--5. SprawdŸ w ramach jakich promocji s¹ sprzedawane produkty
--Wyœwietl
--z tabeli Production.Product: Name
--z tabeli Sales.SpecialOffer: Description
--do z³aczenia przyda siê tabela Sales.SpecialOfferProduct. Odgadnij nazwy kolumn ³¹cz¹ce te tabele

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
--Sekcja 6, wyk³ad 74
--1. Kierownik zastanawia siê, jak przydzieliæ pracowników do ró¿nych zmian. Postanawia rozpocz¹æ od wypisania wszystkich mo¿liwych kombinacji z ka¿dym pracownikiem na ka¿dej zmianie. 
--Napisz polecenie, które wyœwietli imiê i nazwisko pracownika (FirstName i LastName z tabeli HumanResources.Employee) i nazwê zmiany (name z tabeli HumanResources.Shift)

--2. Wyœwietl unikalne nazwy kolorów z tabeli Production.Product

--3. Wyœwietl unikalne nazwy klas z tabeli Production.Product

--4. Dyrektor firmy zastanawia siê jakie klasy produktów i kolorów nale¿y produkowaæ. Na pocz¹tek chce otrzymaæ kombinacjê wszystkich aktualnych klas i kolorów. W oparciu o poprzednie zapytania utwórz nowe, które po³aczy ka¿dy kolor z ka¿d¹ klas¹. 

--5. Budujemy tabelê kompetencji pracowników. Ka¿dy pracownik ma mieæ swojego zastêpcê (w parach). Zaczynamy od stworzenia listy na podstawie Sales.SalesPerson, która poka¿e imiê i nazwisko pracownika i imiê i nazwisko jego potencjalnego zastêpcy. Wyœwietlaj¹c wyniki do³¹cz do tabeli Sales.SalesPerson tabelê Person.Person, sk¹d mo¿na pobraæ FirstName i LastName. Musisz to zrobiæ 2 razy - raz aby uzyskaæ imiê i nazwisko pracownika i raz aby uzyskaæ imiê i nazwisko zastêpcy,

--6. Zmieñ zapytanie z poprzedniego zadania tak, aby wyœwietlane pary by³y unikalne. JeœliX zastêpuje Y, to nie pokazuj rekordu Y zastêpuje X

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
--Sekcja 6, wyk³ad 77
--W tem LAB musimy najpierw coœ zepsuæ... Uruchom nastêpuj¹cy kod

--BEGIN TRAN
 
--ALTER TABLE Person.Person NOCHECK CONSTRAINT ALL
--ALTER TABLE Sales.SalesPerson NOCHECK CONSTRAINT ALL
--ALTER TABLE HumanResources.EmployeeDepartmentHistory NOCHECK CONSTRAINT ALL
--ALTER TABLE HumanResources.EmployeePayHistory NOCHECK CONSTRAINT ALL
--ALTER TABLE HumanResources.JobCandidate NOCHECK CONSTRAINT ALL
--ALTER TABLE HumanResources.Employee NOCHECK CONSTRAINT ALL
--UPDATE HumanResources.Employee set BusinessEntityID=1074 WHERE BusinessEntityID = 274
--Æwiczenie wykonuj poni¿ej w tym samym oknie skryptu. Nie zapomnij wycofaæ wprowadzonej tu zmiany poleceniem ROLLBACK (opisane w ostatnim kroku)/

--W/w polecenia w ramach transakcji wy³¹czaj¹ na chwilê mechanizmy obronne bazy, które zabezpieczaj¹ j¹ przed wprowadzaniem niepoprawnych danych. My chcieliœmy celowo doprowadziæ do tego, ¿e sprzedawca 274 przestanie byæ pracownikiem firmy.... pozostaj¹c jej sprzedawc¹ (zatrudnienie na czarno ;) 

--1. Z tabeli HumanResources.Employee wyœwietl BusinessEntityId i LoginId. Ile jest rekordów?
--2. Z tabeli Sales.SalesPerson wyœwietl BusinessEntityId i Bonus. Ile jest rekordów?
--3. Szukamy pracowników, którzy s¹ sprzedawcami. Po³¹cz obie tabele przez INNER JOIN - ile jest rekordów? 
--4. O ka¿dym pracowniku szukamy informacji o tym czy jest sprzedawc¹. Oczywiœcie wielu pracowników nie jest sprzedawcami. 
--5. Po³¹cz tabelê HumanResources.Employee z tabel¹ Sales.SalesPerson przy pomocy LEFT JOIN. Ile rekordów zostanie zwróconych?
--6. O ka¿dym sprzedawcy szukamy informacji, czy jest pracownikem. Wszyscy poza jednym s¹...
--Po³¹cz tabbelê Sales.SalesPerson z tabel¹ HumanResources.Employee przy pomocy LEFT JOIN. Ile rekordów zostanie zwróconych?
--Po³¹cz obie tabele korzystaj¹c z FULL JOIN - ile rekordów zostanie zwróconych?
--Aby wycofaæ pocz¹tkowe zmiany wykonaj:

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