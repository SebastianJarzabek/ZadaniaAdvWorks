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

/*------------------------------------------------------------------------*/
--3.1. Zamówienia nale¿y podzieliæ ze wzglêdu na wysokoœæ podatku, jaki jest do zap³acenia. Wyœwietl z tabeli Sales.SalesOrderHeader kolumny: SalesOrderId, TaxAmt oraz:
/*
-liczbê 0 je¿eli podatek jest < 1000
-liczbe 1000 je¿eli podatek jest >= 1000 and < 2000
-itd.
Wskazówka: Skorzystaj z funkcji FLOOR wyliczanej dla TaxAmt dzielonego przez 1000. Otrzymany wynik mnó¿ przez 1000.
*/
select 
ss.SalesOrderID
,ss.TaxAmt
,floor(ss.TaxAmt/1000)*1000
from 
Sales.SalesOrderHeader as ss
go

--3.2. Napisz polecenie losuj¹ce liczbê z zakresu 1-49. Skorzystaj z funkcji RAND i CEILING. Wylosowane liczby mo¿esz wykorzystaæ w totolotku :)

select 
ceiling(rand()*49)
go

--3.3. Zaokr¹glij kwoty podatku z tabeli Sales.SalesOrderHeader (kolumna TaxAmt) do pe³nych z³otych/dolarów :)

select
ceiling(s.TaxAmt)
from Sales.SalesOrderHeader s
go
--3.4. Zaokr¹glij kwoty podatku z tabeli Sales.SalesOrderHeader (kolumna TaxAmt) do tysiêcy z³otych/dolarów :)

select
ceiling(s.TaxAmt/1000)
from Sales.SalesOrderHeader s
go

/*------------------------------------------------------------------------*/
--4.1 Tabela HumanResources.Shift zawiera wykaz zmian w pracy i godzinê rozpoczêcia i zakoñczenia zmiany. Wyœwietl test powsta³y z po³¹czenia sta³ych napisów i danych w tabeli w postaci:
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

--4.2 Korzystaj¹c z funkcji Convert napisz zapytanie do tabeli HumanResources.Employee, które wyœwietli LoginId oraz datê HireDate w postaci DD.MM.YYYY (najpierw dzieñ, potem miesi¹c i na koñcu rok zapisany 4 cyframi, porozdzielany kropkami)

	select 
	e.LoginID
	,e.HireDate
	,CONVERT(varchar(20),e.HireDate,104)
	from HumanResources.Employee e
	go

--4.3 (* wymagana deklaracja zmiennej). Zapisz do zmiennej tekstowej typu VARCHAR(30) swoj¹ datê urodzenia w formacie d³ugim np '18 sierpnia 1979'. Korzystaj¹c z funkcji PARSE skonwertuj j¹ na datê. Zapis daty jaki zostanie "zrozumiany" zale¿y od wersji jêzykowej serwera i jego ustawieñ regionalnych i jêzykowych.
	
	SET LANGUAGE  Polish

	declare @d varchar(30)
	set @d= '04 grudnia 1989'

	select 
	PARSE(@d as date) as result

	SET LANGUAGE us_english
	go

--4.4 W dacie pope³nij literówkê (np. wymyœl œmieszn¹ nazwê miesi¹ca). Jak teraz koñczy siê konwersja?

SET LANGUAGE  Polish

	declare @d varchar(30)
	set @d= '04 Grundzien 1989'

	select 
	PARSE(@d as date) as result

	SET LANGUAGE us_english
	/*
	--Wystêpuje b³¹d --Msg 9819, Level 16, State 1, Line 269
		B³¹d podczas konwertowania wartoœci ci¹gu „04 Grundzien 1989” na typ danych date przy u¿yciu kultury „”.
*/

go
--4.5 Zmieñ polecenie z poprzedniego zadania tak, aby korzysta³o z funkcji TRY_PARSE. Jak teraz siê koñczy konwersja?

SET LANGUAGE  Polish

	declare @d varchar(30)
	set @d= '04 Grundzien 1989'

	select 
	try_PARSE(@d as date) as result

	SET LANGUAGE us_english

	--Jako result jest null, nie wyst¹pi³ b³¹d

/*------------------------------------------------------------------------*/
--5.1 W firmie AdventureWorks wymyœlono, ¿e pracownikom bêd¹ nadawane "Rangi". Napisz zapytanie, które wyœwietli rekordy z tabeli HumanResources.Employee i je¿eli ró¿nica miêdzy dat¹ zatrudnienia a dat¹ dzisiejsz¹ jest >10 lat, to wyœwietli napis 'Old stager'. W przeciwnym razie ma wyœwietlaæ 'Adept'

select * from HumanResources.Employee

select 
e.LoginID
,e.HireDate
,IIF(DATEDIFF(year, HireDate, GETDATE())>10,'Old stager','Adept')
from HumanResources.Employee as e
go

--5.2 Zmieñ zapytanie z poprzedniego æwiczenia tak, ¿e:
/*
-pracownicy ze sta¿em >10 lat maj¹ range 'Old stager'
-pracownicy ze sta¿em >8 lat maj¹ rangê 'Veteran'
-pozostali maj¹ rangê 'Adept'
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

--5.3 Nale¿y przygotowaæ raport zamówieñ z tabeli Sales.SalesOrderHeader. Zestawienie ma zawieraæ:
/*
SalesOrderId,
OrderDate,
Nazwê dnia tygodnia po... hiszpañsku
Skorzystaj z funkcji DATEPART i CHOOSE i napisz odpowiednie zapytanie
*/
/* 
Oto lista nazw dni tygodnia po hiszpañsku:

poniedzia³ek - lunes
wtorek - martes
œroda - miércoles
czwartek - jueves 
pi¹tek - viernes
sobota - sábado
niedziela - domingo
*/

select
ss.SalesOrderID
,ss.OrderDate
,datepart(Dw,ss.OrderDate)
,choose(
datepart(DW,ss.OrderDate)
,'poniedzia³ek - lunes'
,'wtorek - martes'
,'œroda - miércoles'
,'czwartek - jueves '
,'pi¹tek - viernes'
,'sobota - sábado'
,'niedziela - domingo')
from Sales.SalesOrderHeader as ss

/*------------------------Funkcje agreguj¹ce. GROUP BY, HAVING-----------------------------------------------*/

--6.1 Pracujemy na tabeli Person.Person
/*
-oblicz iloœæ rekordów
-oblicz ile osób poda³o swoje drugie imiê (kolumna MiddleName)
-oblicz ile osób poda³o swoje pierwsze imiê (kolumna FirstName)
-oblicz ile osób wyrazi³o zgodê na otrzymywanie maili (kolumna EmailPromotion ma byæ równa 1)
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
-wyznacz ca³kowit¹ wielkoœæ sprzeda¿y bez uwzglêdnienia rabatów - suma UnitPrice * OrderQty
-wyznacz ca³kowit¹ wielkoœæ sprzeda¿y z uwzglêdnieniiem rabatów - suma (UnitPrice-UnitPriceDiscount) * OrderQty
*/
select * from Sales.SalesOrderDetail as ss
go

select SUM(UnitPrice * OrderQty) from Sales.SalesOrderDetail as ss
go

select SUM((UnitPrice-UnitPriceDiscount) * OrderQty) from Sales.SalesOrderDetail as ss
go

--6.3 Pracujemy na tabeli Production.Product.
/*
-dla rekordów z podkategorii 14
-wylicz minimaln¹ cenê, maksymaln¹ cenê, œredni¹ cenê i odczylenie standardowe dla ceny
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
-wyznacz iloœæ zamówieñ zrealizowanych przez poszczególnych pracowników (kolumna SalesPersonId)
*/

select 
*
from Sales.SalesOrderHeader as ss

select 
*
from Sales.SalesOrderHeader as ss
group by SalesPersonId
go

--6.5 Wynik poprzedniego polecenia posortuj wg wyliczonej iloœci malej¹co

select 
count(*)
from Sales.SalesOrderHeader as ss
group by SalesPersonId
order by SalesPersonId asc
go

--6.6 Wynik poprzedniego polecenia ogranicz do zamówieñ z 2012 roku

select 
SalesPersonId
,count(ss.SalesPersonId)
from Sales.SalesOrderHeader as ss
where OrderDate between '2012-01-01' and '2012-12-31'
group by SalesPersonId
order by SalesPersonId asc
go
--6.7 Wynik poprzedniego polecenia ogranicz tak, aby prezentowani byli te rekordy, gdzie wyznaczona suma jest wiêksza od 100000

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
Policz ile zamówieñ by³o dostarczanych z wykorzystaniem ró¿nych metod dostawy (kolumna ShipMethod)
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
Napisz zapytanie, które wyœwietla:
-ProductID
-Name 
-StandardCost
-ListPrice 
-ró¿nicê miêdzy ListPrice a StandardCost. Zaaliasuj j¹ "Profit"
-w wyniku opuœæ te produkty które maj¹ ListPrice lub StandardCost <=0
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

--6.9 Bazuj¹c na poprzednim zapytaniu, spróbujemy wyznaczyæ jakie kategorie produktów s¹ najbardziej zyskowne.

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

--6.10 Dla ka¿dej podkategorii wyznacz œredni, minimalny i maksymalny profit. Uporz¹dkuj wynik w kolejnoœci œredniego profitu malej¹co

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

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

set ansi_nulls on -- w³¹czenie porownania do null

--7.1 Wyœwietl rekordy z tabeli Person.Person, gdzie nie podano drugiego imienia (MiddleName)

select 
*
from Person.Person as pp
where MiddleName is null
go

--7.2 Wyœwietl rekordy z tabeli Person.Person, gdzie drugie imiê jest podane

select 
*
from Person.Person as pp
where MiddleName is not null
go

--7.3 Wyœwietl z tabeli Person.Person:
/*
-FirstName
-MiddleName
-LastName
-napis z po³¹czenia ze sob¹ FirstName ' ' MiddleName ' ' i  LastName
*/

select 
FirstName, MiddleName, LastName,
concat(pp.FirstName,' ',MiddleName,' ',LastName) as [Name]
from Person.Person as pp
go

--7.4 Jeœli jeszcze tego nie zrobi³eœ dodaj wyra¿enie, które obs³u¿y sytuacjê, gdy MiddleName jest NULL. W takim przypadku chcemy prezentowaæ tylko FirstName ' ' i LastName

--7.5 Jeœli jeszcze tego nie zrobi³eœ - wyeliminuj podwój¹ spacjê, jaka mo¿e siê pojawiæ miêdzy FirstName i LastNamr gdy MiddleName jest NULL.

--7.6 Firma podpisuje umowê z firm¹ kuriersk¹. Cena us³ugi ma zale¿eñ od rozmiaru w drugiej kolejnoœci ciê¿aru, a gdy te nie s¹ znane od wartoœci wysy³anego przedmiotu.
/*
Napisz zapytanie, które wyœwietli:
-productId
-Name
-size, weight i listprice
-i kolumnê wyliczan¹, która poka¿e size (jeœli jest NOT NULL), lub weight (jeœli jest NOT NULL) lub listprice w przeciwnym razie
*/

--7.7 Firma kurierska oczekuje aby informacja w ostatniej kolumnie by³a dodatkowo oznaczona:
/*
-jeœli zawiera informacje o rozmiarze, to ma byæ poprzedzona napisem S:
-jeœli zawiera informacje o ciê¿arze, to ma byæ poprzedzone napisem W:
-w przeciwnym razie ma siê pojawiaæ L:
*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/


/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/

/*------------------------Null i funkcje pracuj¹ce z NULL-----------------------------------------------*/