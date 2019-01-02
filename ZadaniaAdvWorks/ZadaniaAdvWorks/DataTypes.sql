--1.1 Zadeklaruj zmienn¹ @t typu TINYINT
Declare @t tinyint
go
--1.2 Wylicz ile to jest 2*2*2*2*2*2*2*2. Wynik zapisz w zmiennej @t. Uda³o siê?
Declare @t tinyint
set @t= 2*2*2*2*2*2*2*2
go
/* ***************************************************************************** 
NIE UDA£O SIÊ- wartoœæ zmiennej przekracza mo¿liw¹ wartoœæ 256 
wystêpuje b³¹d: Msg 220, Level 16, State 2, Line 6
Arithmetic overflow error for data type tinyint, value = 256. 
***************************************************************************** */
--1.3 A co jeœli od iloczynu odejmiesz 1? Wyœwietl wynik
Declare @t tinyint
set @t= (2*2*2*2*2*2*2*2)-1
print @t
go
/* ***************************************************************************** 
UDA£O SIÊ- wartoœæ zmiennej nie przekracza mo¿liwej wartoœci 256 
zmienna @t ma wartoœæ : 255
***************************************************************************** */
--1.4 Zadeklaruj zmienna @s typu SMALLINT
Declare @s smallint
go
--1.5 Wylicz ile to jest 128*256. Wynik zapisz w zmiennej @s. Uda³o siê? Wyœwietl wynik
Declare @s smallint
set @s=128*256
print @s
go
/* ***************************************************************************** 
NIE UDA£O SIÊ- wartoœæ zmiennej przekracza mo¿liw¹ wartoœæ 32768 
wystêpuje b³¹d: Msg 220, Level 16, State 1, Line 27
Arithmetic overflow error for data type smallint, value = 32768.
***************************************************************************** */
--1.6 SprawdŸ definicjê tabeli HumanResources.Department. Ile rekordów mo¿na wstawiæ do tej tabeli (zobacz typ kolumy ID?
/*  do 32,767 */
--1.7 SprawdŸ definicjê tabeli HumanResources.Employee. Ile rekordów mo¿na wstawiæ do tej tabeli (zobacz typ kolumy ID?
/* do 2,147,483,647 */
--1.8 SprawdŸ definicjê tabeli HumanResources.Shift. Ile rekordów mo¿na wstawiæ do tej tabeli (zobacz typ kolumy ID?
/*do 255 */