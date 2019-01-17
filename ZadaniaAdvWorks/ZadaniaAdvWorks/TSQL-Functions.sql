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

	select 
	*
	from HumanResources.Shift as hrs

	select 
	Concat ('The ', hrs.Name,' shift has start on',cast(hrs.StartTime as varchar(5)), ' and has finished on ',cast(hrs.EndTime as varchar(5)))
	from HumanResources.Shift as hrs

--4.2 Korzystaj�c z funkcji Convert napisz zapytanie do tabeli HumanResources.Employee, kt�re wy�wietli LoginId oraz dat� HireDate w postaci DD.MM.YYYY (najpierw dzie�, potem miesi�c i na ko�cu rok zapisany 4 cyframi, porozdzielany kropkami)

	select 
	e.LoginID
	,e.HireDate
	,CONVERT(varchar(20),e.HireDate,104)
	from HumanResources.Employee e
	go

--4.3 (* wymagana deklaracja zmiennej). Zapisz do zmiennej tekstowej typu VARCHAR(30) swoj� dat� urodzenia w formacie d�ugim np '18 sierpnia 1979'. Korzystaj�c z funkcji PARSE skonwertuj j� na dat�. Zapis daty jaki zostanie "zrozumiany" zale�y od wersji j�zykowej serwera i jego ustawie� regionalnych i j�zykowych.
	
	SET LANGUAGE  Polish

	declare @d varchar(30)
	set @d= '04 grudnia 1989'

	select 
	PARSE(@d as date) as result

	SET LANGUAGE us_english
	go

--4.4 W dacie pope�nij liter�wk� (np. wymy�l �mieszn� nazw� miesi�ca). Jak teraz ko�czy si� konwersja?

SET LANGUAGE  Polish

	declare @d varchar(30)
	set @d= '04 Grundzien 1989'

	select 
	PARSE(@d as date) as result

	SET LANGUAGE us_english
	/*
	--Wyst�puje b��d --Msg 9819, Level 16, State 1, Line 269
		B��d podczas konwertowania warto�ci ci�gu �04 Grundzien 1989� na typ danych date przy u�yciu kultury ��.
*/

go
--4.5 Zmie� polecenie z poprzedniego zadania tak, aby korzysta�o z funkcji TRY_PARSE. Jak teraz si� ko�czy konwersja?

SET LANGUAGE  Polish

	declare @d varchar(30)
	set @d= '04 Grundzien 1989'

	select 
	try_PARSE(@d as date) as result

	SET LANGUAGE us_english

	--Jako result jest null, nie wyst�pi� b��d

/*------------------------------------------------------------------------*/
--5.1 W firmie AdventureWorks wymy�lono, �e pracownikom b�d� nadawane "Rangi". Napisz zapytanie, kt�re wy�wietli rekordy z tabeli HumanResources.Employee i je�eli r�nica mi�dzy dat� zatrudnienia a dat� dzisiejsz� jest >10 lat, to wy�wietli napis 'Old stager'. W przeciwnym razie ma wy�wietla� 'Adept'

select * from HumanResources.Employee

select 
e.LoginID
,e.HireDate
,IIF(DATEDIFF(year, HireDate, GETDATE())>10,'Old stager','Adept')
from HumanResources.Employee as e
go

--5.2 Zmie� zapytanie z poprzedniego �wiczenia tak, �e:
/*
-pracownicy ze sta�em >10 lat maj� range 'Old stager'
-pracownicy ze sta�em >8 lat maj� rang� 'Veteran'
-pozostali maj� rang� 'Adept'
*/
select 
e.LoginID
,e.HireDate
,IIF(DATEDIFF(year, HireDate, GETDATE())>10,'Old stager','Adept')
from HumanResources.Employee as e
go

select 
e.LoginID
,e.HireDate
,iif(datediff(year, hiredate, getdate())>10,'Oldstager',iif(datediff(year,hiredate,getdate())>8,'Veteran','Adept'))

from HumanResources.Employee as e
go

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

select
ss.SalesOrderID
,ss.OrderDate
,datepart(Dw,ss.OrderDate)
,choose(
datepart(DW,ss.OrderDate)
,'poniedzia�ek - lunes'
,'wtorek - martes'
,'�roda - mi�rcoles'
,'czwartek - jueves '
,'pi�tek - viernes'
,'sobota - s�bado'
,'niedziela - domingo')
from Sales.SalesOrderHeader as ss

/*------------------------Funkcje agreguj�ce. GROUP BY, HAVING-----------------------------------------------*/

--6.1 Pracujemy na tabeli Person.Person
/*
-oblicz ilo�� rekord�w
-oblicz ile os�b poda�o swoje drugie imi� (kolumna MiddleName)
-oblicz ile os�b poda�o swoje pierwsze imi� (kolumna FirstName)
-oblicz ile os�b wyrazi�o zgod� na otrzymywanie maili (kolumna EmailPromotion ma by� r�wna 1)
*/

select * from Person.Person as pp
go

select COUNT(*) from Person.Person as pp
go

select COUNT(pp.MiddleName) from Person.Person as pp
go

select COUNT(pp.FirstName) from Person.Person as pp
go

select COUNT(pp.EmailPromotion) from Person.Person as pp
where EmailPromotion > 1
go

--6.2 Pracujemy na tabeli Sales.SalesOrderDetail
/*
-wyznacz ca�kowit� wielko�� sprzeda�y bez uwzgl�dnienia rabat�w - suma UnitPrice * OrderQty
-wyznacz ca�kowit� wielko�� sprzeda�y z uwzgl�dnieniiem rabat�w - suma (UnitPrice-UnitPriceDiscount) * OrderQty
*/
select * from Sales.SalesOrderDetail as ss
go

select SUM(UnitPrice * OrderQty) from Sales.SalesOrderDetail as ss
go

select SUM((UnitPrice-UnitPriceDiscount) * OrderQty) from Sales.SalesOrderDetail as ss
go

--6.3 Pracujemy na tabeli Production.Product.
/*
-dla rekord�w z podkategorii 14
-wylicz minimaln� cen�, maksymaln� cen�, �redni� cen� i odczylenie standardowe dla ceny
*/
 select * from Production.Product as pp
go

select 
min(pp.listprice)
,max(pp.listprice)
,AVG(pp.listprice)
,STDEV(pp.listprice)
from Production.Product as pp
go

--6.4 Pracujemy na tabeli Sales.SalesOrderHeader.
/*
-wyznacz ilo�� zam�wie� zrealizowanych przez poszczeg�lnych pracownik�w (kolumna SalesPersonId)
*/

select 
*
from Sales.SalesOrderHeader as ss

select 
*
from Sales.SalesOrderHeader as ss
group by SalesPersonId
go

--6.5 Wynik poprzedniego polecenia posortuj wg wyliczonej ilo�ci malej�co

select 
count(*)
from Sales.SalesOrderHeader as ss
group by SalesPersonId
order by SalesPersonId asc
go

--6.6 Wynik poprzedniego polecenia ogranicz do zam�wie� z 2012 roku

select 
SalesPersonId
,count(ss.SalesPersonId)
from Sales.SalesOrderHeader as ss
where OrderDate between '2012-01-01' and '2012-12-31'
group by SalesPersonId
order by SalesPersonId asc
go
--6.7 Wynik poprzedniego polecenia ogranicz tak, aby prezentowani byli te rekordy, gdzie wyznaczona suma jest wi�ksza od 100000

select 
SalesPersonId
,count(ss.SalesPersonId)
from Sales.SalesOrderHeader as ss
where  OrderDate between '2012-01-01' and '2012-12-31'
group by SalesPersonId
having sum(SubTotal)>100000
order by SalesPersonId asc
go

--6.8 Pracujemy na tabeli Sales.SalesOrderHeader. 
/*
Policz ile zam�wie� by�o dostarczanych z wykorzystaniem r�nych metod dostawy (kolumna ShipMethod)
*/

select *
from Sales.SalesOrderHeader as ss
go

select 
ss.ShipMethodID
,count(ss.ShipMethodID) as Quantity
from Sales.SalesOrderHeader as ss
group by ShipMethodID
go

--6.8 Pracujemy na tabeli Production.Product
/*
Napisz zapytanie, kt�re wy�wietla:
-ProductID
-Name 
-StandardCost
-ListPrice 
-r�nic� mi�dzy ListPrice a StandardCost. Zaaliasuj j� "Profit"
-w wyniku opu�� te produkty kt�re maj� ListPrice lub StandardCost <=0
*/

select 
*
from Production.Product
go

select
pp.ProductID 
,pp.Name
,pp.StandardCost
,pp.ListPrice
,pp.StandardCost - pp.ListPrice as Profit
from Production.Product as pp
where ListPrice > 0 and StandardCost > 0
go

--6.9 Bazuj�c na poprzednim zapytaniu, spr�bujemy wyznaczy� jakie kategorie produkt�w s� najbardziej zyskowne.

select
pp.ProductID 
,pp.Name
,pp.StandardCost
,pp.ListPrice
,pp.StandardCost - pp.ListPrice as Profit
from Production.Product as pp
where ListPrice > 0 and StandardCost > 0
group by ProductSubcategoryID
order by Profit
go

--6.10 Dla ka�dej podkategorii wyznacz �redni, minimalny i maksymalny profit. Uporz�dkuj wynik w kolejno�ci �redniego profitu malej�co

select
avg(pp.StandardCost - pp.ListPrice) as Avg_Profit
,min(pp.StandardCost - pp.ListPrice) as Min_Profit
,max(pp.StandardCost - pp.ListPrice) as Max_Profit
from Production.Product as pp
where ListPrice > 0 and StandardCost > 0
order by avg(pp.StandardCost - pp.ListPrice)
go

SELECT 
p.ProductSubcategoryID
,AVG(p.ListPrice -p.StandardCost) AS AvgProfit
,MIN(p.ListPrice -p.StandardCost) AS MinProfit
,MAX(p.ListPrice -p.StandardCost) AS MaxProfit
FROM Production.Product p
WHERE p.StandardCost > 0 AND p.ListPrice > 0
GROUP BY p.ProductSubcategoryID
ORDER BY AvgProfit DESC

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

set ansi_nulls on -- w��czenie porownania do null

--7.1 Wy�wietl rekordy z tabeli Person.Person, gdzie nie podano drugiego imienia (MiddleName)

select 
*
from Person.Person as pp
where MiddleName is null
go

--7.2 Wy�wietl rekordy z tabeli Person.Person, gdzie drugie imi� jest podane

select 
*
from Person.Person as pp
where MiddleName is not null
go

--7.3 Wy�wietl z tabeli Person.Person:
/*
-FirstName
-MiddleName
-LastName
-napis z po��czenia ze sob� FirstName ' ' MiddleName ' ' i  LastName
*/

select 
FirstName, MiddleName, LastName,
concat(pp.FirstName,' ',MiddleName,' ',LastName) as [Name]
from Person.Person as pp
go

--7.4 Je�li jeszcze tego nie zrobi�e� dodaj wyra�enie, kt�re obs�u�y sytuacj�, gdy MiddleName jest NULL. W takim przypadku chcemy prezentowa� tylko FirstName ' ' i LastName

--7.5 Je�li jeszcze tego nie zrobi�e� - wyeliminuj podw�j� spacj�, jaka mo�e si� pojawi� mi�dzy FirstName i LastNamr gdy MiddleName jest NULL.

--7.6 Firma podpisuje umow� z firm� kuriersk�. Cena us�ugi ma zale�e� od rozmiaru w drugiej kolejno�ci ci�aru, a gdy te nie s� znane od warto�ci wysy�anego przedmiotu.
/*
Napisz zapytanie, kt�re wy�wietli:
-productId
-Name
-size, weight i listprice
-i kolumn� wyliczan�, kt�ra poka�e size (je�li jest NOT NULL), lub weight (je�li jest NOT NULL) lub listprice w przeciwnym razie
*/

--7.7 Firma kurierska oczekuje aby informacja w ostatniej kolumnie by�a dodatkowo oznaczona:
/*
-je�li zawiera informacje o rozmiarze, to ma by� poprzedzona napisem S:
-je�li zawiera informacje o ci�arze, to ma by� poprzedzone napisem W:
-w przeciwnym razie ma si� pojawia� L:
*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/


/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj�ce z NULL-----------------------------------------------*/