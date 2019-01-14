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

   --Expanding the SELECT command - Aggregate functions, GROUP BY, HAVING--
/*-------------------------------------------------------------------------*/

--2.1 Pracujemy na tabeli Person.Person
/*
-oblicz iloœæ rekordów
-oblicz ile osób poda³o swoje drugie imiê (kolumna MiddleName)
-oblicz ile osób poda³o swoje pierwsze imiê (kolumna FirstName)
-oblicz ile osób wyrazi³o zgodê na otrzymywanie maili (kolumna EmailPromotion ma byæ równa 1)
*/


--2.2 Pracujemy na tabeli Sales.SalesOrderDetail
/*-wyznacz ca³kowit¹ wielkoœæ sprzeda¿y bez uwzglêdnienia rabatów - suma UnitPrice * OrderQty
-wyznacz ca³kowit¹ wielkoœæ sprzeda¿y z uwzglêdnieniiem rabatów - suma (UnitPrice-UnitPriceDiscount) * OrderQty
*/

--2.3 Pracujemy na tabeli Production.Product.
/* 
-dla rekordów z podkategorii 14
-wylicz minimaln¹ cenê, maksymaln¹ cenê, œredni¹ cenê i odczylenie standardowe dla ceny
*/

--2.4 Pracujemy na tabeli Sales.SalesOrderHeader.
/*
-wyznacz iloœæ zamówieñ zrealizowanych przez poszczególnych pracowników (kolumna SalesPersonId)
*/

--2.5 Wynik poprzedniego polecenia posortuj wg wyliczonej iloœci malej¹co

--2.6 Wynik poprzedniego polecenia ogranicz do zamówieñ z 2012 roku

--2.7 Wynik poprzedniego polecenia ogranicz tak, aby prezentowani byli te rekordy, gdzie wyznaczona suma jest wiêksza od 100000

--2.8 Pracujemy na tabeli Sales.SalesOrderHeader. 
/*
Policz ile zamówieñ by³o dostarczanych z wykorzystaniem ró¿nych metod dostawy (kolumna ShipMethod)
*/

--2.9 Pracujemy na tabeli Production.Product
/*
Napisz zapytanie, które wyœwietla:
-ProductID
-Name 
-StandardCost
-ListPrice 
-ró¿nicê miêdzy ListPrice a StandardCost. Zaaliasuj j¹ "Profit"
-w wyniku opuœæ te produkty które maj¹ ListPrice lub StandardCost <=0
*/

--2.10 Bazuj¹c na poprzednim zapytaniu, spróbujemy wyznaczyæ jakie kategorie produktów s¹ najbardziej zyskowne.
/* 
Dla ka¿dej podkategorii wyznacz œredni, minimalny i maksymalny profit. Uporz¹dkuj wynik w kolejnoœci œredniego profitu malej¹co
*/



   --Expanding the SELECT command - Aggregate functions, GROUP BY, HAVING--
/*-------------------------------------------------------------------------*/

