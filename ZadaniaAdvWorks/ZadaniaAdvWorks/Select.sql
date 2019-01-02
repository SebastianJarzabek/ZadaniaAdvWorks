--1.1 PrzejdŸ do bazy danych AdventureWorks (lub innej jakiej u¿ywasz)
USE AdventureWorks
GO
--1.2 Wyœwietl wszystko z tabeli Person.Person. Skorzystaj  ze wskazówek zawartych w lekcji, w tym: jak korzystaæ z aliasu tabeli, intelisense, notacji w osobnych linijkach itp.
select
	pp.BusinessEntityID
	,pp.FirstName + ' ' + pp.LastName as 'Full name'
	,pp.EmailPromotion
	,pp.AdditionalContactInfo
from Person.Person as pp
go
--1.3 Napisz polecenie, które z tabeli Production.Product wyœwietli tylko informacje z kolumn: ProductID, Name, ListPrice, ColorNapisz polecenie, które z tabeli Production.Product wyœwietli tylko informacje z kolumn: ProductID, Name, ListPrice, Color
select 
pp.ProductID
,pp.[Name]
,pp.ListPrice
,pp.Color
from Production.Product as pp
go
--1.4 Skopiuj poprzednie zapytanie i zmieñ je tak, aby wyœwietliæ tylko produkty w kolorze niebieskim (Color = 'blue')
select 
pp.ProductID
,pp.[Name]
,pp.ListPrice
,pp.Color
from Production.Product as pp
where color ='Blue'
go
--1.5 Skopuj poprzednie zapytanie i zakomentuj w nim linijkê powoduj¹c¹ wyœwietlenie koloru
select 
pp.ProductID
,pp.[Name]
,pp.ListPrice
--,pp.Color
from Production.Product as pp
where color ='Blue'
go
--1.6 PrzejdŸ do bazy danych tempdb
use tempdb
go
--1.7 Bêd¹c w bazie danych tempdb napisz polecenie, które wyœwietli wszystko z tabeli ScrapReason w schemacie Production z bazy danych AdventureWorks

select *
from AdventureWorks.Production.ScrapReason
go
--2.1 PrzejdŸ do bazy AdventureWorks
 USE AdventureWorks
GO
--2.2 Wyœwietl wszystko z tabeli HumanResources.Employee. Spróbuj zrozumieæ znaczenie poszczególnych kolumn
select *
from HumanResources.Employee
go 
--2.3 Wyœwietl tylko rekordy pracowników urodzonych od 1980-01-01 w³¹cznie z t¹ dat¹
select *
from HumanResources.Employee
where BirthDate >= '1980-01-01'
go
--2.4 Wyœwietl tylko rekordy osób urodzonych w 1980 roku
select *
from HumanResources.Employee
where BirthDate between '1980-01-01' and '1980-12-31'
go
--2.5 Ogranicz wyniki z poprzedniego punktu wyœwietlaj¹c wy³¹cznie dane mê¿czyzn (Gender='M')
select *
from HumanResources.Employee
where BirthDate between '1980-01-01' and '1980-12-31' and Gender='M'
go
--2.6 Napisz zapytanie wyœwietlaj¹ce z tabeli HumanResources.Employee tylko kolumny: JobTitle, BirthDate, Gender, VacationHours. Wyœwietliæ nale¿y tylko rekordy tych mê¿czyzn, którzy maj¹ 90-99 godzin urlopu (VacationHours) oraz kobiet, które maj¹ tych godzin 80-89 (w³¹cznie)
select 
hre.JobTitle
,hre.BirthDate
,hre.Gender
,hre.VacationHours
from HumanResources.Employee as hre
where 
Gender = 'M' and VacationHours between 90 and 99
or
Gender = 'F'and VacationHours between 80 and 89 
go
--2.7 Do poprzedniego zadania dodaj warunek powoduj¹cy wyœwietlenie danych TYLKO dla osób urodzonych po 1 stycznia 1990 roku w³¹cznie
select 
hre.JobTitle
,hre.BirthDate
,hre.Gender
,hre.VacationHours
from HumanResources.Employee as hre
where 
BirthDate >= '1990-01-01' 
and
Gender = 'M' and VacationHours between 90 and 99
or
Gender = 'F'and VacationHours between 80 and 89 
go
--2.8 Wyœwietl z tabeli wszystkie informacje o osobach pracuj¹cych na stanowisku (JobTitle): 'Control Specialist','Benefits Specialist','Accounts Receivable Specialist'
select 
hre.JobTitle
,hre.BirthDate
,hre.Gender
,hre.VacationHours
from HumanResources.Employee as hre
where 
JobTitle in ('Control Specialist','Benefits Specialist','Accounts Receivable Specialist') 
go
--2.1 Wyœwietl z tabeli HumanResources.Employee rekordy, które w kolumnie JobTitle zawieraj¹ tekst "Specialist"
Select 
hre.JobTitle
from HumanResources.Employee as hre
where JobTitle like '%Specialist%'
go
--2.2 Wyœwietl tylko te rekordy, które jednoczeœnie zawieraj¹ "Specialist" i "Marketing"
Select 
	hre.JobTitle
from HumanResources.Employee as hre
where 
	JobTitle like '%Specialist%' 
	and 
	JobTitle like  '%Marketing%'
go
--2.3 Wyœwietl te rekordy, które zawieraj¹ "Specialist" lub "Marketing"
Select 
	hre.JobTitle
from HumanResources.Employee as hre
where 
	JobTitle like '%Specialist%' 
	or 
	JobTitle like  '%Marketing%'
go
--2.4 Z tabeli Production.Product wyœwietl tylko te rekordy, które zawieraj¹ w kolumnie Name chocia¿ jedna cyfrê
Select 
	pp.[Name]
from Production.Product as pp
where 
	Name like '%[0-9]%'
go
--2.5 Wyœwietl te rekordy, które w nazwie zawieraj¹ dwie cyfry ko³o siebie
Select 
	pp.[Name]
from Production.Product as pp
where 
	Name like '%[0-9][0-9]%'
go
--2.6 Wyœwietl te rekordy, które w nazwie zawieraj¹ dwie cyfry ko³o siebie ale nie koñcz¹ siê cyfr¹
Select 
	pp.[Name]
from Production.Product as pp
where 
	Name like '%[0-9][0-9]%[^0-9]'
go
--2.7 Wyœwietl te rekordy, w których nazwa sk³ada siê z 4 dowolnych znaków
Select 
	pp.[Name]
from Production.Product as pp
where 
	Name like '____'
go
--3.1 Tabela Sales.SalesOrderDetail zawiera szczegó³owe informacje o sprzeda¿y poszczególnych zamówieñ. Kolumna UnitPrice zawiera informacje o cenie, a OrderQty o iloœci sprzedanych produktów. Wylicz wartoœæ sprzeda¿y jako wynik mno¿enia tych dwóch pól
select 
ssod.UnitPrice*ssod.OrderQty as Sell
from Sales.SalesOrderDetail as ssod
go
--3.2 Tabela zawiera równie¿ kolumnê UnitPriceDiscount oznaczaj¹c¹ rabat od podstawowej ceny. Wylicz wartoœæ sprzeda¿y produktu jeœli cena by³a obni¿ona o UnitPriceDiscount.
select
(ssod.UnitPrice-ssod.UnitPriceDiscount)*ssod.OrderQty as Sell
from Sales.SalesOrderDetail as ssod
go
--3.3 Tabel Sales.CreditCard zawiera informacje o typie karty (CardType) i numerze karty kredytowej (CardNumber). Wyœwietl oba te pola po³¹czone znakiem ':'
select 
scd.CardType+' : '+scd.CardNumber as 'Full Card'
from Sales.CreditCard as scd
go
--3.4 Tabela Sales.SalesOrderHeader zawiera informacje o numerze zamówienia (SalesOrderNumber) i numerze zakupu (PurchaseOrderNumber). Wyœwietl obie kolumny
select
ssoh.SalesOrderNumber
,ssoh.PurchaseOrderNumber
from Sales.SalesOrderHeader as ssoh
go
--3.5 Dodaj kolumnê wyliczan¹ która oba te pola ³¹czy znakiem '-'. Zauwa¿ co jest wyœwietlane je¿eli PurchaseOrderNumber jest równe NULL
select
ssoh.SalesOrderNumber
,ssoh.SalesOrderID+'-'+ssoh.PurchaseOrderNumber
from Sales.SalesOrderHeader as ssoh
go
--3.6 Korzystaj¹c z funkcji CONCAT po³¹cz ze sob¹ oba pola znakiem '-'. Ponownie zobacz wyliczan¹ wartoœæ dla rekordów z PurchaseOrderNumber równym NULL
select
ssoh.SalesOrderNumber
,CONCAT(ssoh.SalesOrderID,'-',ssoh.PurchaseOrderNumber)
from Sales.SalesOrderHeader as ssoh
go
--4.1 Do poni¿szych zapytañ dodaj aliasy dla kolumn wyliczanych:

--alias Total

SELECT UnitPrice*OrderQty as Total 
FROM Sales.SalesOrderDetail 

--alias TotalWithDiscount

SELECT 
(UnitPrice-UnitPriceDiscount)*OrderQty TotalWithDiscount
FROM Sales.SalesOrderDetail 

--alias CardType and CardNumber

SELECT Cardtype+':'+CardNumber as 'CardType and CardNumber'
FROM Sales.CreditCard 

--alias Sales And Purchase Order Number

SELECT 
 SalesOrderNumber
 ,PurchaseOrderNumber 
 ,SalesOrderNumber+'-'+PurchaseOrderNumber as 'Sales And Purchase Order Number'
FROM Sales.SalesOrderHeader


--4.2 Skróæ nastêpuj¹ce zapytanie korzystaj¹c z aliasów tabel:

SELECT 
 SalesOrderNumber
 ,ProductID
 ,UnitPrice
 ,TaxAmt
FROM Sales.SalesOrderHeader as ssoh
JOIN Sales.SalesOrderDetail as ssod 
ON ssoh.SalesOrderID = ssod.SalesOrderID


--4.3 Dodaj do klauzuli WHERE warunek pododuj¹cy wyœwietlenie tylko tych rekordów, które maj¹ wartoœæ Total wiêksz¹ od 10000

SELECT 
 sod.ProductID
 ,sod.SalesOrderID
 ,sod.OrderQty * sod.UnitPrice AS Total
FROM Sales.SalesOrderDetail sod
where (sod.OrderQty * sod.UnitPrice)>10000

--5.1 Wyœwietl wszystkie informacje z tabeli HumanResources.Employee. Uporz¹dkuj dane w kolejnoœci wg daty urodzenia (BirthDay) rosn¹co
select 
hre.BirthDate 
from HumanResources.Employee as hre
order by hre.BirthDate asc
go
--5.2 Zmieñ kolejnoœæ na malej¹c¹
select 
hre.BirthDate 
from HumanResources.Employee as hre
order by hre.BirthDate desc
go
--5.3 Wylicz w zapytaniu wiek (od roku z daty dzisiejszej odejmij rok z daty urodzenia). Zaaliasuj kolumnê jako Age. Posortuj dane wg tej kolumny malej¹co
select 
YEAR(GETDATE()) - YEAR(hre.BirthDate) as Age
from HumanResources.Employee as hre
order by Age asc
go
--5.4 Z tabeli Production.Product wyœwietl ProductId, Name, ListPrice, Class, Style i Color. Uporz¹dkuj dane wg class i style
select
pp.ProductID
,pp.[Name]
,pp.ListPrice
,pp.Class
,pp.Style
,pp.Color
from Production.Product as pp
order by pp.Class asc, pp.Style asc
go
--5.5 Zmieñ poprzednie polecenie tak, aby sortowanie odbywa³o siê w oparciu o numer kolumny, a nie nazwê (pamiêtaj - to jest niezalecane rozwi¹zanie, ale warto je znaæ!)
select
pp.ProductID
,pp.[Name]
,pp.ListPrice
,pp.Class
,pp.Style
,pp.Color
from Production.Product as pp
order by 4,5
go

