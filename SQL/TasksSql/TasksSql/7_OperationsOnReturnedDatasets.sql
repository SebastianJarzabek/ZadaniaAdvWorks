--Operator UNION - LAB
--Sekcja 8, wyk�ad 98
--1. Napisz zapytanie, kt�re z tabeli Sales.SalesPerson oraz Person.Person wy�wietli: LastName, FirstName i sta�y napis Seller

--Napisz zapytanie, kt�re z tabeli HumanResources.Employee oraz Person.Person wy�wietli LastName, FIrstName oraz JobTitle

--Po��cz wyniki tych dw�ch zapyta�. Postaraj si� aby:

---alias ostatniej kolumny by� "job"
--wyniki by�y posortowane wg ostatniej kolumny
--2. Z tabeli HumanResources.Department  pobierz nazw� departamentu (Name) oraz sta�y napis "Department"

--Z tabeli Sales.Store pobierz nazw� sklepu (Name) oraz sta�y napis 'Store'

--Po�acz wyniki tych dw�ch polece�. Zadbaj aby:

--Kolumna prezentuj�ca sta�e warto�ci by�a zaaliasowana jako "Location"
--Sortowanie odbywa�o si� w oparciu o Name

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
--Sekcja 8, wyk�ad 101
--1. Napisz zapytanie, kt�re z tabeli Person.Person wybierze LastName i FirstName. 

--Napisz zapytanie, kt�re z tabeli HumanResources.Employee i Person.Person wybierze LastName i FirstName pracownik�w

--Po��cz oba w/w zapytania tak, aby je�li dana osoba jest pracownikiem, pojawi�a sie w wyniku 2 razy

--2. A teraz poka� te osoby z pierwszego zapytania, kt�re NIE s� pracownikami

--3. A teraz wy�wietl te osoby, kt�re s� pracownikami

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
