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

create schema [Office]
go 

create table Garage 
(
[GarageID] int identity not null,
[Description] nchar(100) not null,
[ModifiedDate] datetime2 default sysdatetime(),
primary key (GarageId)
);

alter schema office
transfer Garage



INSERT INTO [dbo].[Garage]
           ([Description]
           ,[ModifitedDate])
     VALUES
           ('lalala'
           ,default)
GO

select * from Garage
go
