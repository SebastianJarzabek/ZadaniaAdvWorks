--1.1 Przejd� do bazy danych AdventureWorks (lub innej jakiej u�ywasz)
USE AdventureWorks
GO
--1.2 Wy�wietl wszystko z tabeli Person.Person. Skorzystaj  ze wskaz�wek zawartych w lekcji, w tym: jak korzysta� z aliasu tabeli, intelisense, notacji w osobnych linijkach itp.
select
	pp.BusinessEntityID
	,pp.FirstName + ' ' + pp.LastName as 'Full name'
	,pp.EmailPromotion
	,pp.AdditionalContactInfo
from Person.Person as pp
go
--1.3 Napisz polecenie, kt�re z tabeli Production.Product wy�wietli tylko informacje z kolumn: ProductID, Name, ListPrice, ColorNapisz polecenie, kt�re z tabeli Production.Product wy�wietli tylko informacje z kolumn: ProductID, Name, ListPrice, Color
select 
pp.ProductID
,pp.[Name]
,pp.ListPrice
,pp.Color
from Production.Product as pp
go
--1.4 Skopiuj poprzednie zapytanie i zmie� je tak, aby wy�wietli� tylko produkty w kolorze niebieskim (Color = 'blue')
select 
pp.ProductID
,pp.[Name]
,pp.ListPrice
,pp.Color
from Production.Product as pp
where color ='Blue'
go
--1.5 Skopuj poprzednie zapytanie i zakomentuj w nim linijk� powoduj�c� wy�wietlenie koloru
select 
pp.ProductID
,pp.[Name]
,pp.ListPrice
--,pp.Color
from Production.Product as pp
where color ='Blue'
go
--1.6 Przejd� do bazy danych tempdb
use tempdb
go
--1.7 B�d�c w bazie danych tempdb napisz polecenie, kt�re wy�wietli wszystko z tabeli ScrapReason w schemacie Production z bazy danych AdventureWorks

select *
from AdventureWorks.Production.ScrapReason
go
--2.1 Przejd� do bazy AdventureWorks
 USE AdventureWorks
GO
--2.2 Wy�wietl wszystko z tabeli HumanResources.Employee. Spr�buj zrozumie� znaczenie poszczeg�lnych kolumn
select *
from HumanResources.Employee
go 
--2.3 Wy�wietl tylko rekordy pracownik�w urodzonych od 1980-01-01 w��cznie z t� dat�
select *
from HumanResources.Employee
where BirthDate >= '1980-01-01'
go
--2.4 Wy�wietl tylko rekordy os�b urodzonych w 1980 roku
select *
from HumanResources.Employee
where BirthDate between '1980-01-01' and '1980-12-31'
go
--2.5 Ogranicz wyniki z poprzedniego punktu wy�wietlaj�c wy��cznie dane m�czyzn (Gender='M')
select *
from HumanResources.Employee
where BirthDate between '1980-01-01' and '1980-12-31' and Gender='M'
go
--2.6 Napisz zapytanie wy�wietlaj�ce z tabeli HumanResources.Employee tylko kolumny: JobTitle, BirthDate, Gender, VacationHours. Wy�wietli� nale�y tylko rekordy tych m�czyzn, kt�rzy maj� 90-99 godzin urlopu (VacationHours) oraz kobiet, kt�re maj� tych godzin 80-89 (w��cznie)
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
--2.7 Do poprzedniego zadania dodaj warunek powoduj�cy wy�wietlenie danych TYLKO dla os�b urodzonych po 1 stycznia 1990 roku w��cznie
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
--2.8 Wy�wietl z tabeli wszystkie informacje o osobach pracuj�cych na stanowisku (JobTitle): 'Control Specialist','Benefits Specialist','Accounts Receivable Specialist'
select 
hre.JobTitle
,hre.BirthDate
,hre.Gender
,hre.VacationHours
from HumanResources.Employee as hre
where 
JobTitle in ('Control Specialist','Benefits Specialist','Accounts Receivable Specialist') 
go
--2.1 Wy�wietl z tabeli HumanResources.Employee rekordy, kt�re w kolumnie JobTitle zawieraj� tekst "Specialist"
Select 
hre.JobTitle
from HumanResources.Employee as hre
where JobTitle like '%Specialist%'
go
--2.2 Wy�wietl tylko te rekordy, kt�re jednocze�nie zawieraj� "Specialist" i "Marketing"
Select 
	hre.JobTitle
from HumanResources.Employee as hre
where 
	JobTitle like '%Specialist%' 
	and 
	JobTitle like  '%Marketing%'
go
--2.3 Wy�wietl te rekordy, kt�re zawieraj� "Specialist" lub "Marketing"
Select 
	hre.JobTitle
from HumanResources.Employee as hre
where 
	JobTitle like '%Specialist%' 
	or 
	JobTitle like  '%Marketing%'
go
--2.4 Z tabeli Production.Product wy�wietl tylko te rekordy, kt�re zawieraj� w kolumnie Name chocia� jedna cyfr�
Select 
	pp.[Name]
from Production.Product as pp
where 
	Name like '%[0-9]%'
go
--2.5 Wy�wietl te rekordy, kt�re w nazwie zawieraj� dwie cyfry ko�o siebie
Select 
	pp.[Name]
from Production.Product as pp
where 
	Name like '%[0-9][0-9]%'
go
--2.6 Wy�wietl te rekordy, kt�re w nazwie zawieraj� dwie cyfry ko�o siebie ale nie ko�cz� si� cyfr�
Select 
	pp.[Name]
from Production.Product as pp
where 
	Name like '%[0-9][0-9]%[^0-9]'
go
--2.7 Wy�wietl te rekordy, w kt�rych nazwa sk�ada si� z 4 dowolnych znak�w
Select 
	pp.[Name]
from Production.Product as pp
where 
	Name like '____'
go
--3.1 Tabela Sales.SalesOrderDetail zawiera szczeg�owe informacje o sprzeda�y poszczeg�lnych zam�wie�. Kolumna UnitPrice zawiera informacje o cenie, a OrderQty o ilo�ci sprzedanych produkt�w. Wylicz warto�� sprzeda�y jako wynik mno�enia tych dw�ch p�l
select 
ssod.UnitPrice*ssod.OrderQty as Sell
from Sales.SalesOrderDetail as ssod
go
--3.2 Tabela zawiera r�wnie� kolumn� UnitPriceDiscount oznaczaj�c� rabat od podstawowej ceny. Wylicz warto�� sprzeda�y produktu je�li cena by�a obni�ona o UnitPriceDiscount.
select
(ssod.UnitPrice-ssod.UnitPriceDiscount)*ssod.OrderQty as Sell
from Sales.SalesOrderDetail as ssod
go
--3.3 Tabel Sales.CreditCard zawiera informacje o typie karty (CardType) i numerze karty kredytowej (CardNumber). Wy�wietl oba te pola po��czone znakiem ':'
select 
scd.CardType+' : '+scd.CardNumber as 'Full Card'
from Sales.CreditCard as scd
go
--3.4 Tabela Sales.SalesOrderHeader zawiera informacje o numerze zam�wienia (SalesOrderNumber) i numerze zakupu (PurchaseOrderNumber). Wy�wietl obie kolumny
select
ssoh.SalesOrderNumber
,ssoh.PurchaseOrderNumber
from Sales.SalesOrderHeader as ssoh
go
--3.5 Dodaj kolumn� wyliczan� kt�ra oba te pola ��czy znakiem '-'. Zauwa� co jest wy�wietlane je�eli PurchaseOrderNumber jest r�wne NULL
select
ssoh.SalesOrderNumber
,ssoh.SalesOrderID+'-'+ssoh.PurchaseOrderNumber
from Sales.SalesOrderHeader as ssoh
go
--3.6 Korzystaj�c z funkcji CONCAT po��cz ze sob� oba pola znakiem '-'. Ponownie zobacz wyliczan� warto�� dla rekord�w z PurchaseOrderNumber r�wnym NULL
select
ssoh.SalesOrderNumber
,CONCAT(ssoh.SalesOrderID,'-',ssoh.PurchaseOrderNumber)
from Sales.SalesOrderHeader as ssoh
go
--4.1 Do poni�szych zapyta� dodaj aliasy dla kolumn wyliczanych:

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


--4.2 Skr�� nast�puj�ce zapytanie korzystaj�c z alias�w tabel:

SELECT 
 SalesOrderNumber
 ,ProductID
 ,UnitPrice
 ,TaxAmt
FROM Sales.SalesOrderHeader as ssoh
JOIN Sales.SalesOrderDetail as ssod 
ON ssoh.SalesOrderID = ssod.SalesOrderID


--4.3 Dodaj do klauzuli WHERE warunek pododuj�cy wy�wietlenie tylko tych rekord�w, kt�re maj� warto�� Total wi�ksz� od 10000

SELECT 
 sod.ProductID
 ,sod.SalesOrderID
 ,sod.OrderQty * sod.UnitPrice AS Total
FROM Sales.SalesOrderDetail sod
where (sod.OrderQty * sod.UnitPrice)>10000

--5.1 Wy�wietl wszystkie informacje z tabeli HumanResources.Employee. Uporz�dkuj dane w kolejno�ci wg daty urodzenia (BirthDay) rosn�co
select 
hre.BirthDate 
from HumanResources.Employee as hre
order by hre.BirthDate asc
go
--5.2 Zmie� kolejno�� na malej�c�
select 
hre.BirthDate 
from HumanResources.Employee as hre
order by hre.BirthDate desc
go
--5.3 Wylicz w zapytaniu wiek (od roku z daty dzisiejszej odejmij rok z daty urodzenia). Zaaliasuj kolumn� jako Age. Posortuj dane wg tej kolumny malej�co
select 
YEAR(GETDATE()) - YEAR(hre.BirthDate) as Age
from HumanResources.Employee as hre
order by Age asc
go
--5.4 Z tabeli Production.Product wy�wietl ProductId, Name, ListPrice, Class, Style i Color. Uporz�dkuj dane wg class i style
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
--5.5 Zmie� poprzednie polecenie tak, aby sortowanie odbywa�o si� w oparciu o numer kolumny, a nie nazw� (pami�taj - to jest niezalecane rozwi�zanie, ale warto je zna�!)
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

