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

/*-------------------------------------------------------------------------*/
--2.1 Z tabeli HumanResources.Department wyœwietl nazwê. Zwróæ uwagê na nazwê pierwszego i ostatniego departamentu
use adventureworks 

select *
from HumanResources.Department
go

--2.2 Napisz skrypt, w którym:
	/*zadeklarujesz zmienn¹ napisow¹ ,UNICODE, o maksymalnej d³ugoœci 1000 znaków
	przypisz do niej pusty napis
	poleceniem SELECT pobierz do tej zmiennej nazwê departamentu z rekordu z DepartamentID=1
	Wyœwietl t¹ zmienn¹ 
	Wyœwietl d³ugoœæ napisu (w literkach) i iloœæ konsumowanej przez ni¹ pamiêci
	*/ 

	declare @text NVARCHAR(1000)
	set @text= ' '
	select @text=Name
	from HumanResources.Department
	where DepartmentID=1

	select @text
	,len(@text)
	,DATALENGTH(@text)
	go
--2.3 Skopiuj poprzednie polecenie i zmieñ je tak, ¿e polecenie SELECT nie bêdzie zawieraæ klauzuli WHERE. Nazwa którego departamentu jest teraz wartoœci¹ zmiennej?
declare @t NVARCHAR(1000)
	set @t= ' '
	select @t=Name
	from HumanResources.Department
	--where DepartmentID=1

	select @t
	,len(@t)
	,DATALENGTH(@t)
	go
	--TOOL DESIGN

--2.4 Aktualizuj¹c w SELECT zmienn¹ testow¹ zmieñ wyra¿enie na @s1+='/'+Name (SprawdŸ zawartoœæ zmiennej tekstowej wyœwietlaj¹c j¹)
declare @t NVARCHAR(1000)
	set @t= ' '
	select @t +='/'+ Name
	from HumanResources.Department
	--where DepartmentID=1

	select @t
	,len(@t)
	,DATALENGTH(@t)
	go

	--dodaje wszystkie rekordy rozdzielajac je /

--2.5 SprawdŸ jaki typ jest u¿ywany w poni¿szych polach tabel i oceñ jak d³ugi napis mo¿na umieœciæ w zmiennej i ile pamiêci on zajmuje:
	/*
	HumanResources.Department - kolumna Name 
	HumanResources.Employes - kolumna MartialStatus
	Production.Product -kolumna Color
	*/

--HumanResources.Department --Name - up to 50 chars up to 100B
--HumanResources.Employes --MartialStatus - 1 char, 2 B
--Production.Product --Color - up to 15 chars, up to 30 B