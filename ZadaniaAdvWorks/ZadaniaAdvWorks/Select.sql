--1.1
USE AdventureWorks
GO
--1.2
select 
	pp.BusinessEntityID
	,pp.FirstName + ' ' + pp.LastName as 'Full name'
	,pp.EmailPromotion
	,pp.AdditionalContactInfo
from Person.Person as pp
go
--1.3
select 
pp.ProductID
,pp.[Name]
,pp.ListPrice
,pp.Color
from Production.Product as pp
go
--1.4
select 
pp.ProductID
,pp.[Name]
,pp.ListPrice
,pp.Color
from Production.Product as pp
where color ='Blue'
go
--1.5
select 
pp.ProductID
,pp.[Name]
,pp.ListPrice
--,pp.Color
from Production.Product as pp
where color ='Blue'
go
--1.6
use tempdb
go
--1.7
select *
from AdventureWorks.Production.ScrapReason
go
