--Tabele tymczasowe - LAB
--Sekcja 8, wyk³ad 124
--Skopiuj z tabeli Production.Product wszystkie czarne produkty do tabeli tymczasowej prd. Kopiowane maj¹ byæ tylko ProductName i Listprice

--Upewnij siê, ¿e inne sesje "nie widz¹" tej tabeli

--Roz³¹cz siê od sesji i po³¹cz ponownie.

--Upewnij sie, ¿e tabela ju¿ nie istnieje

--Skopuj te same rekordy do globalnej tabeli prd

--W innej sesji rozpocznij transakcjê i usuñ jeden rekord z tej tabeli. Nie wykonuj COMMIT

--Od³acz siê od oryginalnej (pierwszej) sesji

--W drugiej sesji:

--SprawdŸ, czy  tabela ci¹gle jest dostêpne
--Wykonaj COMMIT
--SprawdŸ czy tabela nadal jest dostêpna

USE AdventureWorks
GO
 
--1st session
SELECT p.Name,p.ListPrice INTO #prd
FROM Production.Product p
GO
 
--start in 2nd session
SELECT * FROM #prd
 
--1st session
SELECT p.Name,p.ListPrice INTO ##prd
FROM Production.Product p
GO
 
USE AdventureWorks
GO
 
--start in 2nd session
SELECT * FROM ##prd
 
BEGIN TRAN
 DELETE TOP(1) FROM ##prd
GO
 
SELECT * FROM ##prd
GO
 
COMMIT
GO
 
SELECT * FROM ##prd
GO

--Zmienne tabelaryczne - LAB
--Sekcja 8, wyk³ad 127
--Zadeklaruj zmienn¹ tabelaryczn¹ @Persons. Zmienna ma mieæ 2 kolumny:

--FirstName - napis o maksymalnej d³ugoœci 100 znaków
--LastName - napis o maksymalnej d³ugoœci 100 znaków
--Przepisz do tej zmiennej rekordy osób z tabeli Person.Person, których nazwisko zaczyna siê na literê K

--Usuñ z tabeli @Persons osoby z imieniem rozpoczynaj¹cym siê na literê R

--Wyœwietl zawartoœæ tabeli


USE AdventureWorks
GO
 
DECLARE @Persons TABLE (FirstName NVARCHAR(100), LastName NVARCHAR(100))
 
INSERT @Persons
SELECT p.FirstName, p.LastName
FROM Person.Person p
WHERE p.LastName LIKE 'K%'
 
DELETE FROM @Persons WHERE FirstName LIKE 'R%'
 
SELECT * FROM @Persons


