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
 