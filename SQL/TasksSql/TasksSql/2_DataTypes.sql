--Typ ca³kowity - LAB
--Sekcja 3, wyk³ad 23
--1. Zadeklaruj zmienn¹ @t typu TINYINT
--2. Wylicz ile to jest 2*2*2*2*2*2*2*2. Wynik zapisz w zmiennej @t. Uda³o siê?
--3. A co jeœli od iloczynu odejmiesz 1? Wyœwietl wynik
--4. Zadeklaruj zmienna @s typu SMALLINT
--5. Wylicz ile to jest 128*256. Wynik zapisz w zmiennej @s. Uda³o siê? Wyœwietl wynik
--6. SprawdŸ definicjê tabeli HumanResources.Department. Ile rekordów mo¿na wstawiæ do tej tabeli (zobacz typ kolumy ID?
--7. SprawdŸ definicjê tabeli HumanResources.Employee. Ile rekordów mo¿na wstawiæ do tej tabeli (zobacz typ kolumy ID?
--8. SprawdŸ definicjê tabeli HumanResources.Shift. Ile rekordów mo¿na wstawiæ do tej tabeli (zobacz typ kolumy ID?

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
--Sekcja 3, wyk³ad 26
--1. Z tabeli HumanResources.Department wyœwietl nazwê. Zwróæ uwagê na nazwê pierwszego i ostatniego departamentu

--2.Napisz skrypt, w którym:

--zadeklarujesz zmienn¹ napisow¹ ,UNICODE, o maksymalnej d³ugoœci 1000 znaków
--przypisz do niej pusty napis
--poleceniem SELECT pobierz do tej zmiennej nazwê departamentu z rekordu z DepartamentID=1
--Wyœwietl t¹ zmienn¹
--Wyœwietl d³ugoœæ napisu (w literkach) i iloœæ konsumowanej przez ni¹ pamiêci
--3. Skopiuj poprzednie polecenie i zmieñ je tak, ¿e polecenie SELECT nie bêdzie zawieraæ klauzuli WHERE. Nazwa którego departamentu jest teraz wartoœci¹ zmiennej?

--4. Aktualizuj¹c w SELECT zmienn¹ testow¹ zmieñ wyra¿enie na @s1+='/'+Name
--SprawdŸ zawartoœæ zmiennej tekstowej wyœwietlaj¹c j¹

--5. SprawdŸ jaki typ jest u¿ywany w poni¿szych polach tabel i oceñ jak d³ugi napis mo¿na umieœciæ w zmiennej i ile pamiêci on zajmuje:

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

--Typy danych - data, liczba zmiennoprzecinkowa, prawda/fa³sz - LAB
--Sekcja 3, wyk³ad 29
--1. Popatrz na poni¿szy fragment kodu:

--DECLARE @f DECIMAL =1.1
--SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
--GO
--Uruchom go i zobacz jakie wartoœci s¹ zwracane przy wyœwietlaniu wyliczanych wartoœci.

--2. Wykonaj podobne obliczenia dla zmiennych typu REAL, FLOAT i MONEY

--3. Zadeklaruj zmienn¹ @f  FLOAT i zainicjuj j¹ wartoœci¹ -1. Wylicz ile to jest:

--@f +1
--@f + 0.5 +0.5
--@f+0.5+0.25+0.25
--@f+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1
--4. Zadeklaruj zmienn¹ @d odpowiedniego typu i wyœwietl

--datê dzisiejsz¹ (bez czêœci godzinowej)
--czas bez daty
--datê i czas
--5. Wyœwietl zawartoœæ tabeli Sales.SalesOrderHeader i zastanów siê, czy typ wybrany w tej tabeli dla kolumn zwi¹zanych z dat¹ jest poprawny

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