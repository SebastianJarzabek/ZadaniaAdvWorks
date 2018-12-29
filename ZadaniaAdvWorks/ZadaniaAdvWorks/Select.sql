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
 