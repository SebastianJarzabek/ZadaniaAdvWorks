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

   --Expanding the SELECT command - Aggregate functions, GROUP BY, HAVING--
/*-------------------------------------------------------------------------*/

--2.1 Pracujemy na tabeli Person.Person
/*
-oblicz ilo�� rekord�w
-oblicz ile os�b poda�o swoje drugie imi� (kolumna MiddleName)
-oblicz ile os�b poda�o swoje pierwsze imi� (kolumna FirstName)
-oblicz ile os�b wyrazi�o zgod� na otrzymywanie maili (kolumna EmailPromotion ma by� r�wna 1)
*/


--2.2 Pracujemy na tabeli Sales.SalesOrderDetail
/*-wyznacz ca�kowit� wielko�� sprzeda�y bez uwzgl�dnienia rabat�w - suma UnitPrice * OrderQty
-wyznacz ca�kowit� wielko�� sprzeda�y z uwzgl�dnieniiem rabat�w - suma (UnitPrice-UnitPriceDiscount) * OrderQty
*/

--2.3 Pracujemy na tabeli Production.Product.
/* 
-dla rekord�w z podkategorii 14
-wylicz minimaln� cen�, maksymaln� cen�, �redni� cen� i odczylenie standardowe dla ceny
*/

--2.4 Pracujemy na tabeli Sales.SalesOrderHeader.
/*
-wyznacz ilo�� zam�wie� zrealizowanych przez poszczeg�lnych pracownik�w (kolumna SalesPersonId)
*/

--2.5 Wynik poprzedniego polecenia posortuj wg wyliczonej ilo�ci malej�co

--2.6 Wynik poprzedniego polecenia ogranicz do zam�wie� z 2012 roku

--2.7 Wynik poprzedniego polecenia ogranicz tak, aby prezentowani byli te rekordy, gdzie wyznaczona suma jest wi�ksza od 100000

--2.8 Pracujemy na tabeli Sales.SalesOrderHeader. 
/*
Policz ile zam�wie� by�o dostarczanych z wykorzystaniem r�nych metod dostawy (kolumna ShipMethod)
*/

--2.9 Pracujemy na tabeli Production.Product
/*
Napisz zapytanie, kt�re wy�wietla:
-ProductID
-Name 
-StandardCost
-ListPrice 
-r�nic� mi�dzy ListPrice a StandardCost. Zaaliasuj j� "Profit"
-w wyniku opu�� te produkty kt�re maj� ListPrice lub StandardCost <=0
*/

--2.10 Bazuj�c na poprzednim zapytaniu, spr�bujemy wyznaczy� jakie kategorie produkt�w s� najbardziej zyskowne.
/* 
Dla ka�dej podkategorii wyznacz �redni, minimalny i maksymalny profit. Uporz�dkuj wynik w kolejno�ci �redniego profitu malej�co
*/



   --Expanding the SELECT command - Aggregate functions, GROUP BY, HAVING--
/*-------------------------------------------------------------------------*/

