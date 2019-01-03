use AdventureWorks
go
						--Expanding the SELECT command - case expressions--
/*-------------------------------------------------------------------------*/
--1.1 W tabeli Person.PhoneNumberType znajduj� si� opisy rodzaj�w telefon�w. Na potrzeby raportu nale�y:
/*
-wy�wietli�  'mobile phone' gdy nazwa to 'cell'
-wy�wietli� 'Stationary' gdy nazwa to 'Home' lub 'Work'
-w pozosta�ych przypadkach wy�wietli� 'Other'
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

--1.2 W poprzednim zadaniu wykorzysta�e� jedn� z dopuszczalnych sk�adni CASE. Napisz teraz zapytanie, kt�re wykorzysta drug� dopuszczaln� sk�adni�

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

--1.3 W tabeli Production.Product, niekt�re produkty maj� okre�lony rozmiar. Napisz zapytanie, kt�re wy�wietli:
/*
ProductID
Name
Size
oraz now� kolumn�, w kt�rej pojawi si�:
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