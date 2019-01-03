use AdventureWorks
go
						--Expanding the SELECT command - case expressions--
/*-------------------------------------------------------------------------*/
--1.1 W tabeli Person.PhoneNumberType znajduj¹ siê opisy rodzajów telefonów. Na potrzeby raportu nale¿y:
/*
-wyœwietliæ  'mobile phone' gdy nazwa to 'cell'
-wyœwietliæ 'Stationary' gdy nazwa to 'Home' lub 'Work'
-w pozosta³ych przypadkach wyœwietliæ 'Other'
*/
select
*
from Person.PhoneNumberType as pp

SELECT
Name
, CASE Name
WHEN 'Cell' THEN 'Mobile phone'
WHEN 'Home' THEN 'Stationary'
WHEN 'Work' THEN 'Stationary'
ELSE 'OTHER'
END
FROM Person.PhoneNumberType

--1.2 W poprzednim zadaniu wykorzysta³eœ jedn¹ z dopuszczalnych sk³adni CASE. Napisz teraz zapytanie, które wykorzysta drug¹ dopuszczaln¹ sk³adniê

select
	pp.PhoneNumberTypeID
	,pp.ModifiedDate
	,pp.Name
	,case 
		when Name='cell' then 'mobile phone'
		when Name='Work' then 'Stationary'
		else 'other'
	end as [NewName]
from Person.PhoneNumberType as pp

--1.3 W tabeli Production.Product, niektóre produkty maj¹ okreœlony rozmiar. Napisz zapytanie, które wyœwietli:
/*
ProductID
Name
Size
oraz now¹ kolumnê, w której pojawi siê:
gdy size to 'S' to 'SMALL'
gdy size to 'M' to 'MEDIUM'
gdy size to  'L' to 'LARGE'
gdy size to  'XL' to 'EXTRA LARGE'
*/
select 
	p.ProductID
	,p.[Name]
	,p.Size
	,case
		when Size='S' then 'small'
		when Size='M' then 'medium'
		when Size='L' then 'large'
		when Size='XL' then 'extra large'
		else 'error'
	end
from Production.Product as p
order by size asc
go

						--Aggregate functions, GROUP BY, HAVING--
/*-------------------------------------------------------------------------*/