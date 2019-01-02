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