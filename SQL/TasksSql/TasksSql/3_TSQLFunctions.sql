--Funkcje znakowe - LAB
--Sekcja 4, wyk�ad 32
--W tych zadaniach w ka�dym punkcie nale�y skonstruowa� odpowiednie polecenie SELECT. Dla wygody wy�wietlaj z tabeli oryginaln� warto�� kolumny i warto�� przekszta�con� zgodnie z opisem. Pozwoli to na weryfikacj�, czy przekszta�cenia zosta�y napisane prawid�owo.

--1. Tabela Sales.CreditCard - z kolumny CardNumber wytnij tylko 3 pierwsze literki
--2. Tabela Person.Address - z kolumny AddressLine1 wytnij napis od pocz�tku do pierwszej spacji
--3. Tabela Sales.SalesOrderHeader - wy�wietl dat� zam�wienia (OrderDate) w postaci Miesi�c/Rok (z pomini�ciem dnia)
--4. Tabela Sales.SalesOrderDetail - sformatuj wyra�enie OrderQty*UnitPrice tak, aby wy�wietlany by� tylko jeden znak po przecinku
--5. Tabela Production.Product - zamie� w kolumnie ProductNumber znak '-'  na napis pusty
--6. Tabela Sales.SalesOrderHeader - zmie� formatowanie kolumny TotalDue tak, aby:
---wynikowy napis zajmowa� w sumie 17 znak�w
---ko�czy� si� dwoma gwiazdkami **
---w �rodku zawiera� warto�� TotalDue z tylko 2 miejscami po przecinku
---z przodu by� uzupe�niony gwiazdkami (gwiazdek ma by� tyle, �eby stworzony napis mia� d�ugo�� 17 znak�w)
--np:
--23153.2339    >>>    *******23153.23**
 
--1457.3288     >>>    ********1457.33**

SELECT 
LEFT(CardNumber,3)
,CardNumber
FROM [Sales].[CreditCard]

SELECT 
SUBSTRING(AddressLine1,1,CHARINDEX(' ',AddressLine1)) 
,AddressLine1
FROM Person.Address

SELECT 
FORMAT(OrderDate,'MM/yyyy')
,OrderDate
FROM Sales.SalesOrderHeader

SELECT 
FORMAT(OrderQty*UnitPrice,'0.0')
,OrderQty*UnitPrice
FROM Sales.SalesOrderDetail

SELECT 
REPLACE(ProductNumber,'-','')
,ProductNumber
FROM Production.Product

SELECT 
REPLICATE('*',15 - LEN(FORMAT(TotalDue,'0.00')))+FORMAT(TotalDue,'0.00')+'**'
,TotalDue
FROM Sales.SalesOrderHeader

--Funkcje daty i czasu - LAB
--Sekcja 4, wyk�ad 35
--1. Wy�wietl dat� dzisiejsz�

--2. Z tabeli Sales.SalesOrderHeader wy�wietl:
---SalesOrderId
---orderDate
---rok z daty OrderDate
---miesi�c z daty OrderDate
---dzie� z daty OrderDate
---numer dnia tygodnia
---numer tygodnia w roku

--3. Poprzednie polecenie zmie� tak, aby miesi�c i dzie� tygodnia by�y wy�wietlane jako tekst a nie jako liczba

--4.  (* - wymaga deklarowania zmiennej) - wy�wietl w jaki dzie� tygodnia si� urodzi�e�/�a�

--5.  Pracownicy, kt�rzy w danym miesi�cu maj� urodziny, w formie nagrody nie pracuj� na nocn� zmian� ;) . Trzeba przygotowa� raport, w kt�rym b�d� podane daty, kiedy pracownik nie mo�e pracowa� na nocce. Wy�wietl z tabeli HumanResources.Employee:
---LoginID
---BirthDate,
---dat� pocz�tku miesi�ca w kt�rym pracownik ma urodziny
---dat� ko�ca miesi�ca, w ktorym pracownik ma urodziny

--6. Zobacz ile czasu trwa realizowanie zam�wie�. Z tabeli Sales.SalesOrderHeader wy�wietl:
---SalesOrderID
---OrderDate
---DueDate
---r�nice w dniach mi�dzy OrderDate a DueDate

--7. (* - wymaga deklarowania zmiennej) Wylicz sw�j wiek w latach i w dniach

--8.  W tabeli HumanResources.Employee odszukaj dat� urodzenia pracownika z LoginID adventure-works\diane1. Napisz zapytanie, kt�re wy�wietli r�wie�nik�w tego pracownika. Za��my, �e r�wie�nik to osoba maksymalnie o rok starsza lub o rok m�odsza.

--9. (* - wymaga deklarowania zmiennej)  Zmie� rozwi�zanie poprzedniego zadania tak, aby dat� urodzenia adventure-works\diane1 zapisa� w zmiennej i skorzysta� z niej w zapytaniu wy�wietlaj�cym r�wie�nik�w

SELECT GETDATE()
GO

SELECT 
SalesOrderID
,orderdate
,YEAR(OrderDate) AS Year
,MONTH(OrderDate) AS Month
,DAY(OrderDate) AS Day
,DATEPART(dw,OrderDate) AS WeekDay
,DATEPART(wk,OrderDate) AS WeekNumber
FROM Sales.SalesOrderHeader
GO

SELECT 
SalesOrderID
,orderdate
,YEAR(OrderDate) AS Year
,DATENAME(m, OrderDate) AS Month
,DAY(OrderDate) AS Day
,DATENAME(dw,OrderDate) AS WeekDay
,DATEPART(wk,OrderDate) AS WeekNumber
FROM Sales.SalesOrderHeader
GO

DECLARE @MyBirthDate DATE = '1979-08-12'
SELECT DATENAME(dw,@MyBirthDate)
GO

SELECT 
e.LoginID
,e.BirthDate
,DATEFROMPARTS( YEAR( GetDate()), MONTH( BirthDate ), 1) AS BeginingOfTheMonth
,EOMONTH(DATEFROMPARTS( YEAR( GetDate()), MONTH( BirthDate ), 1)) AS EndOfTheMonth
FROM HumanResources.Employee e
GO

SELECT 
SalesOrderID
, OrderDate
, DueDate
, DATEDIFF(d,OrderDate,DueDate) as differenceInDays
FROM Sales.SalesOrderHeader 
GO

DECLARE @MyBirthDate DATE = '1979-08-12'
DECLARE @Today DATE = GetDate()
SELECT DATEDIFF(year, @myBirthDate, @today) as AgeInYears, DATEDIFF(day, @myBirthDate, @today) as AgeInDays
GO

SELECT * FROM HumanResources.Employee WHERE LoginID='adventure-works\diane1'

SELECT 
*
FROM HumanResources.Employee e
WHERE BirthDate BETWEEN DATEADD(YEAR,-1,'1986-06-05') AND DATEADD(year,1,'1986-06-05')
GO

DECLARE @BirthDate DATE
SELECT @BirthDate=BirthDate FROM HumanResources.Employee WHERE LoginID='adventure-works\diane1'

SELECT 
*
FROM HumanResources.Employee e
WHERE BirthDate BETWEEN DATEADD(YEAR,-1,@BirthDate) AND DATEADD(year,1,@BirthDate)

--Funkcje matematyczne - LAB
--Sekcja 4, wyk�ad 38
--1. Zam�wienia nale�y podzieli� ze wzgl�du na wysoko�� podatku, jaki jest do zap�acenia. Wy�wietl z tabeli Sales.SalesOrderHeader kolumny: SalesOrderId, TaxAmt oraz:
---liczb� 0 je�eli podatek jest < 1000
---liczbe 1000 je�eli podatek jest >= 1000 and < 2000
---itd.
--Wskaz�wka: Skorzystaj z funkcji FLOOR wyliczanej dla TaxAmt dzielonego przez 1000. Otrzymany wynik mn� przez 1000.

--2. Napisz polecenie losuj�ce liczb� z zakresu 1-49. Skorzystaj z funkcji RAND i CEILING. Wylosowane liczby mo�esz wykorzysta� w totolotku :)

--3. Zaokr�glij kwoty podatku z tabeli Sales.SalesOrderHeader (kolumna TaxAmt) do pe�nych z�otych/dolar�w :)

--4. Zaokr�glij kwoty podatku z tabeli Sales.SalesOrderHeader (kolumna TaxAmt) do tysi�cy z�otych/dolar�w :)

SELECT 
h.SalesOrderID
,TaxAmt
,FLOOR(h.TaxAmt/1000)*1000
FROM Sales.SalesOrderHeader h

SELECT CEILING(rand()*49)

SELECT
SalesOrderID
, TaxAmt
, ROUND(taxamt,0)
FROM Sales.SalesOrderHeader 

SELECT
SalesOrderID
, TaxAmt
, ROUND(taxamt,-3)
FROM Sales.SalesOrderHeader 

--Funkcje konwertuj�ce - LAB
--Sekcja 4, wyk�ad 41
--1. Tabela HumanResources.Shift zawiera wykaz zmian w pracy i godzin� rozpocz�cia i zako�czenia zmiany. Wy�wietl test powsta�y z po��czenia sta�ych napis�w i danych w tabeli w postaci:
--Shift .......... starts at ..........
--np.
--Shift Day starts at 07:00
--2. Korzystaj�c z funkcji Convert napisz zapytanie do tabeli HumanResources.Employee, kt�re wy�wietli LoginId oraz dat� HireDate w postaci DD.MM.YYYY (najpierw dzie�, potem miesi�c i na ko�cu rok zapisany 4 cyframi, porozdzielany kropkami)
--3. (* wymagana deklaracja zmiennej). Zapisz do zmiennej tekstowej typu VARCHAR(30) swoj� dat� urodzenia w formacie d�ugim np '18 sierpnia 1979'. Korzystaj�c z funkcji PARSE skonwertuj j� na dat�. Zapis daty jaki zostanie "zrozumiany" zale�y od wersji j�zykowej serwera i jego ustawie� regionalnych i j�zykowych.
--4. W dacie pope�nij liter�wk� (np. wymy�l �mieszn� nazw� miesi�ca). Jak teraz ko�czy si� konwersja?
--5. Zmie� polecenie z poprzedniego zadania tak, aby korzysta�o z funkcji TRY_PARSE. Jak teraz si� ko�czy konwersja?

SELECT

'Shift ' + Name + ' starts at ' + CAST(StartTime AS VARCHAR(5))
FROM HumanResources.Shift
GO

SELECT 
LoginID, CONVERT(varchar(20), BirthDate, 104)
FROM HumanResources.Employee
GO

DECLARE @MyBirthDate VARCHAR(30) = '18 sierpnia 1979'
SELECT PARSE(@MyBirthDate AS DATE USING 'pl-PL')
GO

DECLARE @MyBirthDate VARCHAR(30) = '18 �niegnia 1979'
SELECT PARSE(@MyBirthDate AS DATE USING 'pl-PL')
GO

DECLARE @MyBirthDate VARCHAR(30) = '18 �niegnia 1979'
SELECT TRY_PARSE(@MyBirthDate AS DATE USING 'pl-PL')
GO

--Funkcje logiczne - LAB
--Sekcja 4, wyk�ad 44
--1. W firmie AdventureWorks wymy�lono, �e pracownikom b�d� nadawane "Rangi". Napisz zapytanie, kt�re wy�wietli rekordy z tabeli HumanResources.Employee i je�eli r�nica mi�dzy dat� zatrudnienia a dat� dzisiejsz� jest >10 lat, to wy�wietli napis 'Old stager'. W przeciwnym razie ma wy�wietla� 'Adept'
--2. Zmie� zapytanie z poprzedniego �wiczenia tak, �e:
---pracownicy ze sta�em >10 lat maj� range 'Old stager'
---pracownicy ze sta�em >8 lat maj� rang� 'Veteran'
---pozostali maj� rang� 'Adept'
--3. Nale�y przygotowa� raport zam�wie� z tabeli Sales.SalesOrderHeader. Zestawienie ma zawiera�:
--SalesOrderId,
--OrderDate,
--Nazw� dnia tygodnia po... hiszpa�sku
--Skorzystaj z funkcji DATEPART i CHOOSE i napisz odpowiednie zapytanie
--Oto lista nazw dni tygodnia po hiszpa�sku:

--poniedzia�ek - lunes
--wtorek - martes
--�roda - mi�rcoles
--czwartek - jueves 
--pi�tek - viernes
--sobota - s�bado
--niedziela - domingo

SELECT
LoginID,hiredate, 
IIF(DATEDIFF(year, HireDate, GETDATE())>10,'Old stager','Adept')
FROM HumanResources.Employee
GO

SELECT
LoginID,hiredate, 
IIF(DATEDIFF(year, HireDate, GETDATE())>10,'Old stager',IIF(DATEDIFF(year, HireDate, GETDATE())>8,'Veteran','Adept'))
FROM HumanResources.Employee

/*
poniedzia�ek - lunes
wtorek - martes
�roda - mi�rcoles
czwartek - jueves 
pi�tek - viernes
sobota - s�bado
niedziela - domingo
*/

SELECT
SalesOrderID
, OrderDate
, CHOOSE(DATEPART(WEEKDAY,OrderDate),
    'lunes',
'martes',
'mi�rcoles',
'jueves',
'viernes',
's�bado',
'domingo'
)
FROM Sales.SalesOrderHeader