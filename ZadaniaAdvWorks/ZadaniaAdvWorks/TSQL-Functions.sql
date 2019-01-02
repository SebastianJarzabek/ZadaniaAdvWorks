use AdventureWorks
go

/*
W tych zadaniach w ka�dym punkcie nale�y skonstruowa� odpowiednie polecenie SELECT. Dla wygody wy�wietlaj z tabeli oryginaln� warto�� kolumny i warto�� przekszta�con� zgodnie z opisem. Pozwoli to na weryfikacj�, czy przekszta�cenia zosta�y napisane prawid�owo.
*/

--1.1 Tabela Sales.CreditCard - z kolumny CardNumber wytnij tylko 3 pierwsze literki
select 
substring(scd.CardNumber, 1,3)
from Sales.CreditCard as scd
go
--1.2 Tabela Person.Address - z kolumny AddressLine1 wytnij napis od pocz�tku do pierwszej spacji

select
SUBSTRING(pa.AddressLine1, 1,CHARINDEX(' ',pa.AddressLine1))
from Person.[Address] as pa
go

--1.3 Tabela Sales.SalesOrderHeader - wy�wietl dat� zam�wienia (OrderDate) w postaci Miesi�c/Rok (z pomini�ciem dnia)

select
format(ssoh.OrderDate, 'MM/yyyy')
from Sales.SalesOrderHeader as ssoh
go

--1.4 Tabela Sales.SalesOrderDetail - sformatuj wyra�enie OrderQty*UnitPrice tak, aby wy�wietlany by� tylko jeden znak po przecinku

select
format(OrderQty*UnitPrice, '0.0')
from Sales.SalesOrderDetail
go

--1.5 Tabela Production.Product - zamie� w kolumnie ProductNumber znak '-'  na napis pusty

select
replace(pp.ProductNumber, '-' , ' ')
from Production.Product as pp
go

--1.6 Tabela Sales.SalesOrderHeader - zmie� formatowanie kolumny TotalDue tak, aby:
/*
	-wynikowy napis zajmowa� w sumie 17 znak�w
	-ko�czy� si� dwoma gwiazdkami **
	-w �rodku zawiera� warto�� TotalDue z tylko 2 miejscami po przecinku
	-z przodu by� uzupe�niony gwiazdkami (gwiazdek ma by� tyle, �eby stworzony napis mia� d�ugo�� 17 znak�w)
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
--2.1. Wy�wietl dat� dzisiejsz�

select 
GETDATE()
,SYSDATETIME() --wieksza precyzja
go

--2.2. Z tabeli Sales.SalesOrderHeader wy�wietl:
/*
-SalesOrderId
-orderDate
-rok z daty OrderDate
-miesi�c z daty OrderDate
-dzie� z daty OrderDate
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

--2.3. Poprzednie polecenie zmie� tak, aby miesi�c i dzie� tygodnia by�y wy�wietlane jako tekst a nie jako liczba

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


--2.4.  (* - wymaga deklarowania zmiennej) - wy�wietl w jaki dzie� tygodnia si� urodzi�e�/�a�
declare @d date
set @d ='1989-12-04'
set DATEFIRST  1
select 
 DATEPART(dw,@d)
,DATENAME(dw,@d)
go

--2.5.  Pracownicy, kt�rzy w danym miesi�cu maj� urodziny, w formie nagrody nie pracuj� na nocn� zmian� ;) . Trzeba przygotowa� raport, w kt�rym b�d� podane daty, kiedy pracownik nie mo�e pracowa� na nocce. Wy�wietl z tabeli HumanResources.Employee:
/*
-LoginID
-BirthDate,
-dat� pocz�tku miesi�ca w kt�rym pracownik ma urodziny
-dat� ko�ca miesi�ca, w ktorym pracownik ma urodziny
*/

select 
hre.LoginID
,hre.BirthDate
,DATEFROMPARTS(YEAR(Getdate()), month(hre.BirthDate),1) as PoczatekMiesiaca
,EOMONTH(DATEFROMPARTS(YEAR(Getdate()), month(hre.BirthDate),1)) as KoniecMiesiaca
from HumanResources.Employee as hre
go
--2.6. Zobacz ile czasu trwa realizowanie zam�wie�. Z tabeli Sales.SalesOrderHeader wy�wietl:
/*
-SalesOrderID
-OrderDate
-DueDate
-r�nice w dniach mi�dzy OrderDate a DueDate
*/

select 
ss.SalesOrderID
,ss.OrderDate
,ss.DueDate
,DATEDIFF(DAY, ss.OrderDate,ss.DueDate) as [days]
from Sales.SalesOrderHeader as ss
go
--2.7. (* - wymaga deklarowania zmiennej) Wylicz sw�j wiek w latach i w dniach
declare @d date
set @d = '1989-12-04'
declare @dt date
set @dt = GETDATE()
select
datediff(year,@d,@dt)
,datediff(day,@d,@dt)
go

--2.8.  W tabeli HumanResources.Employee odszukaj dat� urodzenia pracownika z LoginID adventure-works\diane1. Napisz zapytanie, kt�re wy�wietli r�wie�nik�w tego pracownika. Za��my, �e r�wie�nik to osoba maksymalnie o rok starsza lub o rok m�odsza.

SELECT * FROM HumanResources.Employee WHERE LoginID='adventure-works\diane1'

SELECT 
*
FROM HumanResources.Employee e
WHERE BirthDate BETWEEN DATEADD(YEAR,-1,'1986-06-05') AND DATEADD(year,1,'1986-06-05')

--2.9. (* - wymaga deklarowania zmiennej)  Zmie� rozwi�zanie poprzedniego zadania tak, aby dat� urodzenia adventure-works\diane1 zapisa� w zmiennej i skorzysta� z niej w zapytaniu wy�wietlaj�cym r�wie�nik�w

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

/*------------------------------------------------------------------------*/
--3.1. Zam�wienia nale�y podzieli� ze wzgl�du na wysoko�� podatku, jaki jest do zap�acenia. Wy�wietl z tabeli Sales.SalesOrderHeader kolumny: SalesOrderId, TaxAmt oraz:
/*
-liczb� 0 je�eli podatek jest < 1000
-liczbe 1000 je�eli podatek jest >= 1000 and < 2000
-itd.
Wskaz�wka: Skorzystaj z funkcji FLOOR wyliczanej dla TaxAmt dzielonego przez 1000. Otrzymany wynik mn� przez 1000.
*/
select 
ss.SalesOrderID
,ss.TaxAmt
,floor(ss.TaxAmt/1000)*1000
from 
Sales.SalesOrderHeader as ss
go

--3.2. Napisz polecenie losuj�ce liczb� z zakresu 1-49. Skorzystaj z funkcji RAND i CEILING. Wylosowane liczby mo�esz wykorzysta� w totolotku :)

select 
ceiling(rand()*49)
go

--3.3. Zaokr�glij kwoty podatku z tabeli Sales.SalesOrderHeader (kolumna TaxAmt) do pe�nych z�otych/dolar�w :)

select
ceiling(s.TaxAmt)
from Sales.SalesOrderHeader s
go
--3.4. Zaokr�glij kwoty podatku z tabeli Sales.SalesOrderHeader (kolumna TaxAmt) do tysi�cy z�otych/dolar�w :)


select
ceiling(s.TaxAmt/1000)
from Sales.SalesOrderHeader s
go

/*------------------------------------------------------------------------*/
--4.1 Tabela HumanResources.Shift zawiera wykaz zmian w pracy i godzin� rozpocz�cia i zako�czenia zmiany. Wy�wietl test powsta�y z po��czenia sta�ych napis�w i danych w tabeli w postaci:
	/*
	Shift .......... starts at ..........
	np.
	Shift Day starts at 07:00
	*/


--4.2 Korzystaj�c z funkcji Convert napisz zapytanie do tabeli HumanResources.Employee, kt�re wy�wietli LoginId oraz dat� HireDate w postaci DD.MM.YYYY (najpierw dzie�, potem miesi�c i na ko�cu rok zapisany 4 cyframi, porozdzielany kropkami)

--4.3 (* wymagana deklaracja zmiennej). Zapisz do zmiennej tekstowej typu VARCHAR(30) swoj� dat� urodzenia w formacie d�ugim np '18 sierpnia 1979'. Korzystaj�c z funkcji PARSE skonwertuj j� na dat�. Zapis daty jaki zostanie "zrozumiany" zale�y od wersji j�zykowej serwera i jego ustawie� regionalnych i j�zykowych.

--4.4 W dacie pope�nij liter�wk� (np. wymy�l �mieszn� nazw� miesi�ca). Jak teraz ko�czy si� konwersja?

--4.5 Zmie� polecenie z poprzedniego zadania tak, aby korzysta�o z funkcji TRY_PARSE. Jak teraz si� ko�czy konwersja?


/*------------------------------------------------------------------------*/
--5.1 W firmie AdventureWorks wymy�lono, �e pracownikom b�d� nadawane "Rangi". Napisz zapytanie, kt�re wy�wietli rekordy z tabeli HumanResources.Employee i je�eli r�nica mi�dzy dat� zatrudnienia a dat� dzisiejsz� jest >10 lat, to wy�wietli napis 'Old stager'. W przeciwnym razie ma wy�wietla� 'Adept'


--5.2 Zmie� zapytanie z poprzedniego �wiczenia tak, �e:
/*
-pracownicy ze sta�em >10 lat maj� range 'Old stager'
-pracownicy ze sta�em >8 lat maj� rang� 'Veteran'
-pozostali maj� rang� 'Adept'
*/

--5.3 Nale�y przygotowa� raport zam�wie� z tabeli Sales.SalesOrderHeader. Zestawienie ma zawiera�:
/*
SalesOrderId,
OrderDate,
Nazw� dnia tygodnia po... hiszpa�sku
Skorzystaj z funkcji DATEPART i CHOOSE i napisz odpowiednie zapytanie
*/
/* 
Oto lista nazw dni tygodnia po hiszpa�sku:

poniedzia�ek - lunes
wtorek - martes
�roda - mi�rcoles
czwartek - jueves 
pi�tek - viernes
sobota - s�bado
niedziela - domingo
*/