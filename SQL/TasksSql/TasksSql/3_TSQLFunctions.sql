--Funkcje znakowe - LAB
--Sekcja 4, wyk³ad 32
--W tych zadaniach w ka¿dym punkcie nale¿y skonstruowaæ odpowiednie polecenie SELECT. Dla wygody wyœwietlaj z tabeli oryginaln¹ wartoœæ kolumny i wartoœæ przekszta³con¹ zgodnie z opisem. Pozwoli to na weryfikacjê, czy przekszta³cenia zosta³y napisane prawid³owo.

--1. Tabela Sales.CreditCard - z kolumny CardNumber wytnij tylko 3 pierwsze literki
--2. Tabela Person.Address - z kolumny AddressLine1 wytnij napis od pocz¹tku do pierwszej spacji
--3. Tabela Sales.SalesOrderHeader - wyœwietl datê zamówienia (OrderDate) w postaci Miesi¹c/Rok (z pominiêciem dnia)
--4. Tabela Sales.SalesOrderDetail - sformatuj wyra¿enie OrderQty*UnitPrice tak, aby wyœwietlany by³ tylko jeden znak po przecinku
--5. Tabela Production.Product - zamieñ w kolumnie ProductNumber znak '-'  na napis pusty
--6. Tabela Sales.SalesOrderHeader - zmieñ formatowanie kolumny TotalDue tak, aby:
---wynikowy napis zajmowa³ w sumie 17 znaków
---koñczy³ siê dwoma gwiazdkami **
---w œrodku zawiera³ wartoœæ TotalDue z tylko 2 miejscami po przecinku
---z przodu by³ uzupe³niony gwiazdkami (gwiazdek ma byæ tyle, ¿eby stworzony napis mia³ d³ugoœæ 17 znaków)
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
--Sekcja 4, wyk³ad 35
--1. Wyœwietl datê dzisiejsz¹

--2. Z tabeli Sales.SalesOrderHeader wyœwietl:
---SalesOrderId
---orderDate
---rok z daty OrderDate
---miesi¹c z daty OrderDate
---dzieñ z daty OrderDate
---numer dnia tygodnia
---numer tygodnia w roku

--3. Poprzednie polecenie zmieñ tak, aby miesi¹c i dzieñ tygodnia by³y wyœwietlane jako tekst a nie jako liczba

--4.  (* - wymaga deklarowania zmiennej) - wyœwietl w jaki dzieñ tygodnia siê urodzi³eœ/³aœ

--5.  Pracownicy, którzy w danym miesi¹cu maj¹ urodziny, w formie nagrody nie pracuj¹ na nocn¹ zmianê ;) . Trzeba przygotowaæ raport, w którym bêd¹ podane daty, kiedy pracownik nie mo¿e pracowaæ na nocce. Wyœwietl z tabeli HumanResources.Employee:
---LoginID
---BirthDate,
---datê pocz¹tku miesi¹ca w którym pracownik ma urodziny
---datê koñca miesi¹ca, w ktorym pracownik ma urodziny

--6. Zobacz ile czasu trwa realizowanie zamówieñ. Z tabeli Sales.SalesOrderHeader wyœwietl:
---SalesOrderID
---OrderDate
---DueDate
---ró¿nice w dniach miêdzy OrderDate a DueDate

--7. (* - wymaga deklarowania zmiennej) Wylicz swój wiek w latach i w dniach

--8.  W tabeli HumanResources.Employee odszukaj datê urodzenia pracownika z LoginID adventure-works\diane1. Napisz zapytanie, które wyœwietli rówieœników tego pracownika. Za³ó¿my, ¿e rówieœnik to osoba maksymalnie o rok starsza lub o rok m³odsza.

--9. (* - wymaga deklarowania zmiennej)  Zmieñ rozwi¹zanie poprzedniego zadania tak, aby datê urodzenia adventure-works\diane1 zapisaæ w zmiennej i skorzystaæ z niej w zapytaniu wyœwietlaj¹cym rówieœników

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
--Sekcja 4, wyk³ad 38
--1. Zamówienia nale¿y podzieliæ ze wzglêdu na wysokoœæ podatku, jaki jest do zap³acenia. Wyœwietl z tabeli Sales.SalesOrderHeader kolumny: SalesOrderId, TaxAmt oraz:
---liczbê 0 je¿eli podatek jest < 1000
---liczbe 1000 je¿eli podatek jest >= 1000 and < 2000
---itd.
--Wskazówka: Skorzystaj z funkcji FLOOR wyliczanej dla TaxAmt dzielonego przez 1000. Otrzymany wynik mnó¿ przez 1000.

--2. Napisz polecenie losuj¹ce liczbê z zakresu 1-49. Skorzystaj z funkcji RAND i CEILING. Wylosowane liczby mo¿esz wykorzystaæ w totolotku :)

--3. Zaokr¹glij kwoty podatku z tabeli Sales.SalesOrderHeader (kolumna TaxAmt) do pe³nych z³otych/dolarów :)

--4. Zaokr¹glij kwoty podatku z tabeli Sales.SalesOrderHeader (kolumna TaxAmt) do tysiêcy z³otych/dolarów :)

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

--Funkcje konwertuj¹ce - LAB
--Sekcja 4, wyk³ad 41
--1. Tabela HumanResources.Shift zawiera wykaz zmian w pracy i godzinê rozpoczêcia i zakoñczenia zmiany. Wyœwietl test powsta³y z po³¹czenia sta³ych napisów i danych w tabeli w postaci:
--Shift .......... starts at ..........
--np.
--Shift Day starts at 07:00
--2. Korzystaj¹c z funkcji Convert napisz zapytanie do tabeli HumanResources.Employee, które wyœwietli LoginId oraz datê HireDate w postaci DD.MM.YYYY (najpierw dzieñ, potem miesi¹c i na koñcu rok zapisany 4 cyframi, porozdzielany kropkami)
--3. (* wymagana deklaracja zmiennej). Zapisz do zmiennej tekstowej typu VARCHAR(30) swoj¹ datê urodzenia w formacie d³ugim np '18 sierpnia 1979'. Korzystaj¹c z funkcji PARSE skonwertuj j¹ na datê. Zapis daty jaki zostanie "zrozumiany" zale¿y od wersji jêzykowej serwera i jego ustawieñ regionalnych i jêzykowych.
--4. W dacie pope³nij literówkê (np. wymyœl œmieszn¹ nazwê miesi¹ca). Jak teraz koñczy siê konwersja?
--5. Zmieñ polecenie z poprzedniego zadania tak, aby korzysta³o z funkcji TRY_PARSE. Jak teraz siê koñczy konwersja?

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

DECLARE @MyBirthDate VARCHAR(30) = '18 œniegnia 1979'
SELECT PARSE(@MyBirthDate AS DATE USING 'pl-PL')
GO

DECLARE @MyBirthDate VARCHAR(30) = '18 œniegnia 1979'
SELECT TRY_PARSE(@MyBirthDate AS DATE USING 'pl-PL')
GO

--Funkcje logiczne - LAB
--Sekcja 4, wyk³ad 44
--1. W firmie AdventureWorks wymyœlono, ¿e pracownikom bêd¹ nadawane "Rangi". Napisz zapytanie, które wyœwietli rekordy z tabeli HumanResources.Employee i je¿eli ró¿nica miêdzy dat¹ zatrudnienia a dat¹ dzisiejsz¹ jest >10 lat, to wyœwietli napis 'Old stager'. W przeciwnym razie ma wyœwietlaæ 'Adept'
--2. Zmieñ zapytanie z poprzedniego æwiczenia tak, ¿e:
---pracownicy ze sta¿em >10 lat maj¹ range 'Old stager'
---pracownicy ze sta¿em >8 lat maj¹ rangê 'Veteran'
---pozostali maj¹ rangê 'Adept'
--3. Nale¿y przygotowaæ raport zamówieñ z tabeli Sales.SalesOrderHeader. Zestawienie ma zawieraæ:
--SalesOrderId,
--OrderDate,
--Nazwê dnia tygodnia po... hiszpañsku
--Skorzystaj z funkcji DATEPART i CHOOSE i napisz odpowiednie zapytanie
--Oto lista nazw dni tygodnia po hiszpañsku:

--poniedzia³ek - lunes
--wtorek - martes
--œroda - miércoles
--czwartek - jueves 
--pi¹tek - viernes
--sobota - sábado
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
poniedzia³ek - lunes
wtorek - martes
œroda - miércoles
czwartek - jueves 
pi¹tek - viernes
sobota - sábado
niedziela - domingo
*/

SELECT
SalesOrderID
, OrderDate
, CHOOSE(DATEPART(WEEKDAY,OrderDate),
    'lunes',
'martes',
'miércoles',
'jueves',
'viernes',
'sábado',
'domingo'
)
FROM Sales.SalesOrderHeader