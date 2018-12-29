USE AdventureWorks
GO

select top 50
pp.[Name]
,pp.ListPrice
,pp.Color
from Production.Product as pp
where color='Black'
order by pp.ListPrice desc	
go

select * from Production.UnitMeasure
go

insert into Production.UnitMeasure 
values ('B','BUNDLE',GETDATE())
go 

update Production.UnitMeasure 
set Name='buble'
where Name='BUNDLE'
go

select * 
from Production.UnitMeasure
where Name='buble'
go

delete Production.UnitMeasure 
where Name='buble'
go
