--Typ ca�kowity - LAB
--Sekcja 3, wyk�ad 23
--1. Zadeklaruj zmienn� @t typu TINYINT
--2. Wylicz ile to jest 2*2*2*2*2*2*2*2. Wynik zapisz w zmiennej @t. Uda�o si�?
--3. A co je�li od iloczynu odejmiesz 1? Wy�wietl wynik
--4. Zadeklaruj zmienna @s typu SMALLINT
--5. Wylicz ile to jest 128*256. Wynik zapisz w zmiennej @s. Uda�o si�? Wy�wietl wynik
--6. Sprawd� definicj� tabeli HumanResources.Department. Ile rekord�w mo�na wstawi� do tej tabeli (zobacz typ kolumy ID?
--7. Sprawd� definicj� tabeli HumanResources.Employee. Ile rekord�w mo�na wstawi� do tej tabeli (zobacz typ kolumy ID?
--8. Sprawd� definicj� tabeli HumanResources.Shift. Ile rekord�w mo�na wstawi� do tej tabeli (zobacz typ kolumy ID?

DECLARE @t TINYINT
SET @t = 2*2*2*2*2*2*2*2
PRINT @t
GO

DECLARE @t TINYINT
SET @t = 2*2*2*2*2*2*2*2-1
PRINT @t

DECLARE @s SMALLINT
SET @s=128*256
PRINT @s
GO

DECLARE @s SMALLINT
SET @s=128*256-1
PRINT @s
GO

--HumanResources.Department -- smallint over 32 000
--HumanResources.Employee  -- int over 1 000 000 000
--HumanResources.Shift  -- tinyint - 255 (or 256 including 0)

--Typ tekstowy - LAB
--Sekcja 3, wyk�ad 26
--1. Z tabeli HumanResources.Department wy�wietl nazw�. Zwr�� uwag� na nazw� pierwszego i ostatniego departamentu

--2.Napisz skrypt, w kt�rym:

--zadeklarujesz zmienn� napisow� ,UNICODE, o maksymalnej d�ugo�ci 1000 znak�w
--przypisz do niej pusty napis
--poleceniem SELECT pobierz do tej zmiennej nazw� departamentu z rekordu z DepartamentID=1
--Wy�wietl t� zmienn�
--Wy�wietl d�ugo�� napisu (w literkach) i ilo�� konsumowanej przez ni� pami�ci
--3. Skopiuj poprzednie polecenie i zmie� je tak, �e polecenie SELECT nie b�dzie zawiera� klauzuli WHERE. Nazwa kt�rego departamentu jest teraz warto�ci� zmiennej?

--4. Aktualizuj�c w SELECT zmienn� testow� zmie� wyra�enie na @s1+='/'+Name
--Sprawd� zawarto�� zmiennej tekstowej wy�wietlaj�c j�

--5. Sprawd� jaki typ jest u�ywany w poni�szych polach tabel i oce� jak d�ugi napis mo�na umie�ci� w zmiennej i ile pami�ci on zajmuje:

--HumanResources.Department - kolumna Name 
--HumanResources.Employes - kolumna MartialStatus
--Production.Product -kolumna Color

SELECT Name FROM HumanResources.Department
GO

DECLARE @s1 NVARCHAR(1000)
SET @s1 = ''
SELECT @s1=Name FROM HumanResources.Department WHERE DepartmentID=1
PRINT @s1
SELECT LEN(@s1),DATALENGTH(@s1)
GO

DECLARE @s1 NVARCHAR(1000)
SET @s1 = ''
SELECT @s1=Name FROM HumanResources.Department
PRINT @s1
GO

DECLARE @s1 NVARCHAR(1000)
SET @s1 = ''
SELECT @s1+='/'+Name FROM HumanResources.Department
PRINT @s1
GO

--HumanResources.Department --Name - up to 50 chars up to 100B
--HumanResources.Employes --MartialStatus - 1 char, 2 B
--Production.Product --Color - up to 15 chars, up to 30 B

--Typy danych - data, liczba zmiennoprzecinkowa, prawda/fa�sz - LAB
--Sekcja 3, wyk�ad 29
--1. Popatrz na poni�szy fragment kodu:

--DECLARE @f DECIMAL =1.1
--SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
--GO
--Uruchom go i zobacz jakie warto�ci s� zwracane przy wy�wietlaniu wyliczanych warto�ci.

--2. Wykonaj podobne obliczenia dla zmiennych typu REAL, FLOAT i MONEY

--3. Zadeklaruj zmienn� @f  FLOAT i zainicjuj j� warto�ci� -1. Wylicz ile to jest:

--@f +1
--@f + 0.5 +0.5
--@f+0.5+0.25+0.25
--@f+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1
--4. Zadeklaruj zmienn� @d odpowiedniego typu i wy�wietl

--dat� dzisiejsz� (bez cz�ci godzinowej)
--czas bez daty
--dat� i czas
--5. Wy�wietl zawarto�� tabeli Sales.SalesOrderHeader i zastan�w si�, czy typ wybrany w tej tabeli dla kolumn zwi�zanych z dat� jest poprawny

DECLARE @f DECIMAL =1.1

SELECT
@f/2
,@f/4
,@f/8
,@f/16
,@f/32
,@f/64
,@f/128
,@f/256
,@f/512
,@f/1024
,@f/2048
,@f/4096
,@f/8192
,@f/16384
,@f/32768
GO

DECLARE @f REAL =1.1

SELECT
@f/2
,@f/4
,@f/8
,@f/16
,@f/32
,@f/64
,@f/128
,@f/256
,@f/512
,@f/1024
,@f/2048
,@f/4096
,@f/8192
,@f/16384
,@f/32768
GO

DECLARE @f FLOAT =1.1

SELECT
@f/2
,@f/4
,@f/8
,@f/16
,@f/32
,@f/64
,@f/128
,@f/256
,@f/512
,@f/1024
,@f/2048
,@f/4096
,@f/8192
,@f/16384
,@f/32768
GO

DECLARE @f MONEY =1.1

SELECT
@f/2
,@f/4
,@f/8
,@f/16
,@f/32
,@f/64
,@f/128
,@f/256
,@f/512
,@f/1024
,@f/2048
,@f/4096
,@f/8192
,@f/16384
,@f/32768
GO

DECLARE @f float;
SET @f = -1;
SELECT @f+1
SELECT @f+0.5+0.5
SELECT @f+0.5+0.25+0.25
SELECT @f+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1
GO

DECLARE @d DATE =GetDate()
SELECT @d

DECLARE @t TIME = SYSDATETIME()
SELECT @t

DECLARE @dt DATETIME = SYSDATETIME()
SELECT @dt

SELECT * FROM Sales.SalesOrderHeader
--invoice date is always at midnight, probably type date would be better