--Operator UNION - LAB
--Sekcja 8, wyk³ad 98
--1. Napisz zapytanie, które z tabeli Sales.SalesPerson oraz Person.Person wyœwietli: LastName, FirstName i sta³y napis Seller

--Napisz zapytanie, które z tabeli HumanResources.Employee oraz Person.Person wyœwietli LastName, FIrstName oraz JobTitle

--Po³¹cz wyniki tych dwóch zapytañ. Postaraj siê aby:

---alias ostatniej kolumny by³ "job"
--wyniki by³y posortowane wg ostatniej kolumny
--2. Z tabeli HumanResources.Department  pobierz nazwê departamentu (Name) oraz sta³y napis "Department"

--Z tabeli Sales.Store pobierz nazwê sklepu (Name) oraz sta³y napis 'Store'

--Po³acz wyniki tych dwóch poleceñ. Zadbaj aby:

--Kolumna prezentuj¹ca sta³e wartoœci by³a zaaliasowana jako "Location"
--Sortowanie odbywa³o siê w oparciu o Name

SELECT 
p.LastName, p.FirstName, 'Seller' AS Job
FROM Sales.SalesPerson sp
JOIN Person.Person p ON sp.BusinessEntityID = p.BusinessEntityID
UNION
SELECT 
p.LastName,p.FirstName, e.JobTitle
FROM HumanResources.Employee e 
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY Job

SELECT 
d.Name, 'Department' AS Location
FROM HumanResources.Department d
UNION
SELECT
s.Name, 'Store'
FROM Sales.Store s
ORDER By Name

--Operator UNION ALL, INTERSECT, EXCEPT - LAB
--Sekcja 8, wyk³ad 101
--1. Napisz zapytanie, które z tabeli Person.Person wybierze LastName i FirstName. 

--Napisz zapytanie, które z tabeli HumanResources.Employee i Person.Person wybierze LastName i FirstName pracowników

--Po³¹cz oba w/w zapytania tak, aby jeœli dana osoba jest pracownikiem, pojawi³a sie w wyniku 2 razy

--2. A teraz poka¿ te osoby z pierwszego zapytania, które NIE s¹ pracownikami

--3. A teraz wyœwietl te osoby, które s¹ pracownikami

SELECT 

p.LastName, p.FirstName
FROM Person.Person p 
UNION ALL
SELECT 
p.LastName,p.FirstName
FROM HumanResources.Employee e 
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID

SELECT 
p.LastName, p.FirstName
FROM Person.Person p 
EXCEPT
SELECT 
p.LastName,p.FirstName
FROM HumanResources.Employee e 
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID

SELECT 
p.LastName, p.FirstName
FROM Person.Person p 
INTERSECT
SELECT 
p.LastName,p.FirstName
FROM HumanResources.Employee e 
JOIN Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
