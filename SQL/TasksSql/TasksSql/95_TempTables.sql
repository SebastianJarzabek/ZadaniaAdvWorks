--Tabele tymczasowe - LAB
--Sekcja 8, wyk�ad 124
--Skopiuj z tabeli Production.Product wszystkie czarne produkty do tabeli tymczasowej prd. Kopiowane maj� by� tylko ProductName i Listprice

--Upewnij si�, �e inne sesje "nie widz�" tej tabeli

--Roz��cz si� od sesji i po��cz ponownie.

--Upewnij sie, �e tabela ju� nie istnieje

--Skopuj te same rekordy do globalnej tabeli prd

--W innej sesji rozpocznij transakcj� i usu� jeden rekord z tej tabeli. Nie wykonuj COMMIT

--Od�acz si� od oryginalnej (pierwszej) sesji

--W drugiej sesji:

--Sprawd�, czy  tabela ci�gle jest dost�pne
--Wykonaj COMMIT
--Sprawd� czy tabela nadal jest dost�pna

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
--Sekcja 8, wyk�ad 127
--Zadeklaruj zmienn� tabelaryczn� @Persons. Zmienna ma mie� 2 kolumny:

--FirstName - napis o maksymalnej d�ugo�ci 100 znak�w
--LastName - napis o maksymalnej d�ugo�ci 100 znak�w
--Przepisz do tej zmiennej rekordy os�b z tabeli Person.Person, kt�rych nazwisko zaczyna si� na liter� K

--Usu� z tabeli @Persons osoby z imieniem rozpoczynaj�cym si� na liter� R

--Wy�wietl zawarto�� tabeli


USE AdventureWorks
GO
 
DECLARE @Persons TABLE (FirstName NVARCHAR(100), LastName NVARCHAR(100))
 
INSERT @Persons
SELECT p.FirstName, p.LastName
FROM Person.Person p
WHERE p.LastName LIKE 'K%'
 
DELETE FROM @Persons WHERE FirstName LIKE 'R%'
 
SELECT * FROM @Persons


