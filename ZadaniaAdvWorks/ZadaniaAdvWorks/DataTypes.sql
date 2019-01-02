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

/*-------------------------------------------------------------------------*/
--2.1 Z tabeli HumanResources.Department wy�wietl nazw�. Zwr�� uwag� na nazw� pierwszego i ostatniego departamentu
use adventureworks 

select *
from HumanResources.Department
go

--2.2 Napisz skrypt, w kt�rym:
	/*zadeklarujesz zmienn� napisow� ,UNICODE, o maksymalnej d�ugo�ci 1000 znak�w
	przypisz do niej pusty napis
	poleceniem SELECT pobierz do tej zmiennej nazw� departamentu z rekordu z DepartamentID=1
	Wy�wietl t� zmienn� 
	Wy�wietl d�ugo�� napisu (w literkach) i ilo�� konsumowanej przez ni� pami�ci
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
--2.3 Skopiuj poprzednie polecenie i zmie� je tak, �e polecenie SELECT nie b�dzie zawiera� klauzuli WHERE. Nazwa kt�rego departamentu jest teraz warto�ci� zmiennej?
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

--2.4 Aktualizuj�c w SELECT zmienn� testow� zmie� wyra�enie na @s1+='/'+Name (Sprawd� zawarto�� zmiennej tekstowej wy�wietlaj�c j�)
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

--2.5 Sprawd� jaki typ jest u�ywany w poni�szych polach tabel i oce� jak d�ugi napis mo�na umie�ci� w zmiennej i ile pami�ci on zajmuje:
	/*
	HumanResources.Department - kolumna Name 
	HumanResources.Employes - kolumna MartialStatus
	Production.Product -kolumna Color
	*/

--HumanResources.Department --Name - up to 50 chars up to 100B
--HumanResources.Employes --MartialStatus - 1 char, 2 B
--Production.Product --Color - up to 15 chars, up to 30 B

/*-------------------------------------------------------------------------*/
--3.1 Popatrz na poni�szy fragment kodu:
	/*
	DECLARE @f DECIMAL =1.1
	SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
	GO
	Uruchom go i zobacz jakie warto�ci s� zwracane przy wy�wietlaniu wyliczanych warto�ci.
	*/

		DECLARE @f DECIMAL =1.1
	SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
	GO




--3.2. Wykonaj podobne obliczenia dla zmiennych typu REAL, FLOAT i MONEY

		DECLARE @f REAL =1.1
	SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
	GO
	
		DECLARE @f FLOAT =1.1
	SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
	GO
	
		DECLARE @f MONEY =1.1
	SELECT @f/2 ,@f/4 ,@f/8 ,@f/16 ,@f/32 ,@f/64 ,@f/128 ,@f/256 ,@f/512 ,@f/1024 ,@f/2048 ,@f/4096 ,@f/8192 ,@f/16384 ,@f/32768 
	GO


--3.3. Zadeklaruj zmienn� @f  FLOAT i zainicjuj j� warto�ci� -1. Wylicz ile to jest:
/*
@f +1
@f + 0.5 +0.5
@f+0.5+0.25+0.25
@f+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1
*/


	DECLARE @f FLOAT
	SELECT
	@f = -1
	,@f =@f + 0.5 +0.5
	,@f =@f+0.5+0.25+0.25
	,@f =@f+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1+0.1
	GO

--3.4. Zadeklaruj zmienn� @d odpowiedniego typu i wy�wietl
/*
dat� dzisiejsz� (bez cz�ci godzinowej)
czas bez daty
dat� i czas
*/

declare @d Date
select @d=GETDATE()
print @d
go

declare @d time
select @d=GETDATE()
print @d
go

declare @d datetime
select @d=GETDATE()
print @d
go

--3.5. Wy�wietl zawarto�� tabeli Sales.SalesOrderHeader i zastan�w si�, czy typ wybrany w tej tabeli dla kolumn zwi�zanych z dat� jest poprawny

Select * 
from Sales.SalesOrderHeader
go