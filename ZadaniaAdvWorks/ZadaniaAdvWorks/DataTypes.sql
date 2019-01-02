--1.1 Zadeklaruj zmienn� @t typu TINYINT
Declare @t tinyint
go
--1.2 Wylicz ile to jest 2*2*2*2*2*2*2*2. Wynik zapisz w zmiennej @t. Uda�o si�?
Declare @t tinyint
set @t= 2*2*2*2*2*2*2*2
go
/* ***************************************************************************** 
NIE UDA�O SI�- warto�� zmiennej przekracza mo�liw� warto�� 256 
wyst�puje b��d: Msg 220, Level 16, State 2, Line 6
Arithmetic overflow error for data type tinyint, value = 256. 
***************************************************************************** */
--1.3 A co je�li od iloczynu odejmiesz 1? Wy�wietl wynik
Declare @t tinyint
set @t= (2*2*2*2*2*2*2*2)-1
print @t
go
/* ***************************************************************************** 
UDA�O SI�- warto�� zmiennej nie przekracza mo�liwej warto�ci 256 
zmienna @t ma warto�� : 255
***************************************************************************** */
--1.4 Zadeklaruj zmienna @s typu SMALLINT
Declare @s smallint
go
--1.5 Wylicz ile to jest 128*256. Wynik zapisz w zmiennej @s. Uda�o si�? Wy�wietl wynik
Declare @s smallint
set @s=128*256
print @s
go
/* ***************************************************************************** 
NIE UDA�O SI�- warto�� zmiennej przekracza mo�liw� warto�� 32768 
wyst�puje b��d: Msg 220, Level 16, State 1, Line 27
Arithmetic overflow error for data type smallint, value = 32768.
***************************************************************************** */
--1.6 Sprawd� definicj� tabeli HumanResources.Department. Ile rekord�w mo�na wstawi� do tej tabeli (zobacz typ kolumy ID?
/*  do 32,767 */
--1.7 Sprawd� definicj� tabeli HumanResources.Employee. Ile rekord�w mo�na wstawi� do tej tabeli (zobacz typ kolumy ID?
/* do 2,147,483,647 */
--1.8 Sprawd� definicj� tabeli HumanResources.Shift. Ile rekord�w mo�na wstawi� do tej tabeli (zobacz typ kolumy ID?
/*do 255 */