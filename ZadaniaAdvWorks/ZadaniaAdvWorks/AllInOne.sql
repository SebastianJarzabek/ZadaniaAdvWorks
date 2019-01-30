use AdventureWorks
go

select 
month(ss.OrderDate) as 'month'
,ss.SalesPersonID
,ss.TerritoryID
from Sales.SalesOrderHeader as ss
where ss.OrderDate between '2012-01-01' and ' 2012-03-31'
and ss.SalesPersonID is not null and ss.TerritoryID is not null
group by rollup (ss.OrderDate,ss.SalesPersonID,ss.TerritoryID)



