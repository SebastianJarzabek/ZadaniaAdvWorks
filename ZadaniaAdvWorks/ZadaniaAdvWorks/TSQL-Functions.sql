use AdventureWorks
go

/*
W tych zadaniach w ka¿dym punkcie nale¿y skonstruowaæ odpowiednie polecenie SELECT. Dla wygody wyœwietlaj z tabeli oryginaln¹ wartoœæ kolumny i wartoœæ przekszta³con¹ zgodnie z opisem. Pozwoli to na weryfikacjê, czy przekszta³cenia zosta³y napisane prawid³owo.
*/

--1.1 Tabela Sales.CreditCard - z kolumny CardNumber wytnij tylko 3 pierwsze literki
select 
substring(scd.CardNumber, 1,3)
from Sales.CreditCard as scd
go
--1.2 Tabela Person.Address - z kolumny AddressLine1 wytnij napis od pocz¹tku do pierwszej spacji

select
SUBSTRING(pa.AddressLine1, 1,CHARINDEX(' ',pa.AddressLine1))
from Person.[Address] as pa
go

--1.3 Tabela Sales.SalesOrderHeader - wyœwietl datê zamówienia (OrderDate) w postaci Miesi¹c/Rok (z pominiêciem dnia)

select
format(ssoh.OrderDate, 'MM/yyyy')
from Sales.SalesOrderHeader as ssoh
go

--1.4 Tabela Sales.SalesOrderDetail - sformatuj wyra¿enie OrderQty*UnitPrice tak, aby wyœwietlany by³ tylko jeden znak po przecinku

select
format(OrderQty*UnitPrice, '0.0')
from Sales.SalesOrderDetail
go

--1.5 Tabela Production.Product - zamieñ w kolumnie ProductNumber znak '-'  na napis pusty

select
replace(pp.ProductNumber, '-' , ' ')
from Production.Product as pp
go

--1.6 Tabela Sales.SalesOrderHeader - zmieñ formatowanie kolumny TotalDue tak, aby:
/*
	-wynikowy napis zajmowa³ w sumie 17 znaków
	-koñczy³ siê dwoma gwiazdkami **
	-w œrodku zawiera³ wartoœæ TotalDue z tylko 2 miejscami po przecinku
	-z przodu by³ uzupe³niony gwiazdkami (gwiazdek ma byæ tyle, ¿eby stworzony napis mia³ d³ugoœæ 17 znaków)
	np:
	23153.2339    >>>    *******23153.23**
 
	1457.3288     >>>    ********1457.33**
*/

select 
ss.TotalDue
,LEN(ss.TotalDue)
,LEN(ss.TotalDue)-17
,concat(space(abs(LEN(ss.TotalDue)-17)),ss.TotalDue)
,replace(concat(space(abs(LEN(ss.TotalDue)-15)),ss.TotalDue), ' ','*')+'**'
from Sales.SalesOrderHeader as ss
go

SELECT 
REPLICATE('*',15 - LEN(FORMAT(TotalDue,'0.00')))+FORMAT(TotalDue,'0.00')+'**'
,TotalDue
FROM Sales.SalesOrderHeader
go

/*------------------------------------------------------------------------*/
--2.1. Wyœwietl datê dzisiejsz¹

select 
GETDATE()
,SYSDATETIME() --wieksza precyzja
go

--2.2. Z tabeli Sales.SalesOrderHeader wyœwietl:
/*
-SalesOrderId
-orderDate
-rok z daty OrderDate
-miesi¹c z daty OrderDate
-dzieñ z daty OrderDate
-numer dnia tygodnia
-numer tygodnia w roku
*/

select 
ss.SalesOrderID
,ss.OrderDate
,YEAR(ss.OrderDate)
,MONTH(ss.OrderDate)
,DAY(ss.OrderDate)
,DATEPART(dw,ss.OrderDate)
,DATEPART(wk,ss.OrderDate)
from Sales.SalesOrderHeader as ss
go

--2.3. Poprzednie polecenie zmieñ tak, aby miesi¹c i dzieñ tygodnia by³y wyœwietlane jako tekst a nie jako liczba

select 
ss.SalesOrderID
,ss.OrderDate
,YEAR(ss.OrderDate)
,MONTH(ss.OrderDate)
,DAY(ss.OrderDate)
,DATEPART(dw,ss.OrderDate)
,DATENAME(dw,ss.OrderDate)
,DATEPART(wk,ss.OrderDate)
from Sales.SalesOrderHeader as ss
go


--2.4.  (* - wymaga deklarowania zmiennej) - wyœwietl w jaki dzieñ tygodnia siê urodzi³eœ/³aœ
declare @d date
set @d ='1989-12-04'
set DATEFIRST  1
select 
 DATEPART(dw,@d)
,DATENAME(dw,@d)
go

--2.5.  Pracownicy, którzy w danym miesi¹cu maj¹ urodziny, w formie nagrody nie pracuj¹ na nocn¹ zmianê ;) . Trzeba przygotowaæ raport, w którym bêd¹ podane daty, kiedy pracownik nie mo¿e pracowaæ na nocce. Wyœwietl z tabeli HumanResources.Employee:
/*
-LoginID
-BirthDate,
-datê pocz¹tku miesi¹ca w którym pracownik ma urodziny
-datê koñca miesi¹ca, w ktorym pracownik ma urodziny
*/

select 
hre.LoginID
,hre.BirthDate
,DATEFROMPARTS(YEAR(Getdate()), month(hre.BirthDate),1) as PoczatekMiesiaca
,EOMONTH(DATEFROMPARTS(YEAR(Getdate()), month(hre.BirthDate),1)) as KoniecMiesiaca
from HumanResources.Employee as hre
go
--2.6. Zobacz ile czasu trwa realizowanie zamówieñ. Z tabeli Sales.SalesOrderHeader wyœwietl:
/*
-SalesOrderID
-OrderDate
-DueDate
-ró¿nice w dniach miêdzy OrderDate a DueDate
*/

select 
ss.SalesOrderID
,ss.OrderDate
,ss.DueDate
,DATEDIFF(DAY, ss.OrderDate,ss.DueDate) as [days]
from Sales.SalesOrderHeader as ss
go
--2.7. (* - wymaga deklarowania zmiennej) Wylicz swój wiek w latach i w dniach
declare @d date
set @d = '1989-12-04'
declare @dt date
set @dt = GETDATE()
select
datediff(year,@d,@dt)
,datediff(day,@d,@dt)
go

--2.8.  W tabeli HumanResources.Employee odszukaj datê urodzenia pracownika z LoginID adventure-works\diane1. Napisz zapytanie, które wyœwietli rówieœników tego pracownika. Za³ó¿my, ¿e rówieœnik to osoba maksymalnie o rok starsza lub o rok m³odsza.

SELECT * FROM HumanResources.Employee WHERE LoginID='adventure-works\diane1'

SELECT 
*
FROM HumanResources.Employee e
WHERE BirthDate BETWEEN DATEADD(YEAR,-1,'1986-06-05') AND DATEADD(year,1,'1986-06-05')

--2.9. (* - wymaga deklarowania zmiennej)  Zmieñ rozwi¹zanie poprzedniego zadania tak, aby datê urodzenia adventure-works\diane1 zapisaæ w zmiennej i skorzystaæ z niej w zapytaniu wyœwietlaj¹cym rówieœników

declare @d date

select 
	@d=BirthDate
from 
	HumanResources.Employee 
where 
	LoginID='adventure-works\diane1' 

SELECT 
	*
FROM 
	HumanResources.Employee e
WHERE 
	BirthDate BETWEEN DATEADD(YEAR,-1,@d) AND DATEADD(year,1,@d)
