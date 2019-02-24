--Transakcje - wprowadzenie - LAB
--Sekcja 5, wyk�ad 64
--Skopiuj do tempdb zawarto�� tabeli Production.Product z bazy danych AdventureWorks

-- Otw�rz transakcj�

--W ramach transakcji usu� ca�� zawarto�� tabeli Product,

--Sprawd� czy po usuni�ciu rekord�w tabela jest pusta

--Wycofaj transakcj� poleceniem ROLLBACK

--Sprawd� czy rekordy wr�ci�y do tabeli

use tempdb
GO
 
SELECT * INTO dbo.Product FROM AdventureWorks.Production.Product
GO
 
BEGIN TRAN
 DELETE FROM dbo.Product
 SELECT * FROM dbo.Product
ROLLBACK
 
SELECT * FROM dbo.Product

--Zagnie�d�anie transakcji - LAB
--Sekcja 5, wyk�ad 67
--Do bazy danych tempdb skopiuj tabele Production.Product z bazy danych AdventureWorks

--Otw�rz transakcj�

--Zmie� cene wszystkich produkt�w na 0

--Sprawd� efekty swojego polecenia. Wy�wietl @@trancount

--Otw�rz drug� transakcj�

--Zmie� kolor wszystkich produkt�w na silver

--Sprawd� efekty swojego polecenia. Wy�wietl @@trancount

--Wykonaj COMMIT dla wewn�trzej transakcji

--Sprawd� ceny i kolor produkt�w. Wy�wietl @@trancount

--Wykonaj ROLLBACK

--Sprawd� ceny i kolor produkt�w. Wy�wietl @@trancount

use tempdb
GO
 
SELECT * INTO dbo.Product FROM AdventureWorks.Production.Product
GO
 
BEGIN TRAN
 UPDATE dbo.Product SET ListPrice = 0 
 SELECT @@TRANCOUNT
 BEGIN TRAN
 UPDATE dbo.Product SET Color = 'Silver'
 SELECT @@TRANCOUNT
 COMMIT
 SELECT ListPrice,Color FROM dbo.Product
 SELECT @@TRANCOUNT
ROLLBACK
SELECT ListPrice,Color FROM dbo.Product
SELECT @@TRANCOUNT

--Transakcja w praktyce - przyk�ad - LAB
--Sekcja 5, wyk�ad 70
--W bazie danych tempdb utw�rz tabele applications

--ApplicationId � liczba autonumerowanie
--ApplicationName � napis do 50 znak�w
--Install date � data instalcji progamu na komputerze
--Zadeklaruj zmienne @ApplicationName, @InstallDate o odpwiednich typach

--W tamach transakcji wpisz rekord do tabeli, nie ko�cz transakcji.

--Dokonaj kontroli � je�eli data instalacji jest wi�ksza ni� data dzisiejsza, wycofaj transakcj�, w przeciwnym razie zatwierd� j�.

--Przetestuj dzia�anie sktyptu dla poprawnej daty (np. dzi� - 1 dzie�) i niepoprawnej daty (np dzi� + 1 dzie�)

--Sprawd� zawarto�� tabeli po wykonaniu zadania

--Zachowaj przyk�ad do kolejnego zadania

USE tempdb
GO
 
CREATE TABLE dbo.Applications
(
 ApplicationId INT IDENTITY,
 ApplicationName NVARCHAR(50),
 InstallDate DATE
)
GO
 
DECLARE @ApplicationName NVARCHAR(50) = 'Limit na komputer'
 
--uncomment to have commit - correct date
DECLARE @InstallDate DATE = DATEADD(DAY,-1,GetDate())
 
--uncomment to have rollback - incorrect date
--DECLARE @InstallDate DATE = DATEADD(DAY,1,GetDate())
 
BEGIN TRAN
 INSERT INTO Applications(ApplicationName,InstallDate)
 VALUES (@ApplicationName,@InstallDate)
 IF(@InstallDate>GetDate())
  BEGIN
   PRINT 'Rollback!'
   ROLLBACK
  END
 ELSE
  BEGIN
   PRINT 'COMMIT'
   COMMIT
  END
 
SELECT * FROM dbo.Applications


--Dobre praktyki w pracy z transakcjami i nie tylko - LAB
--Sekcja 5, wyk�ad 73
--Pracujemy z poprzednim przyk�adem:

--Sprawdzenie czy data jest poprawna przenie� przed kod wykonuj�cy transakcj�:

--Je�eli data jest z przysz�o�ci wy�wietl komunikat i nie wykonuj �adnej transakcji
--Je�eli data jest poprawna wy�wietl komunikat i zapisz rekord w transakcji
--(Poniewa� tu wpisujemy tylko jeden rekord, a pojedynczy INSERT jest transakcj� sam� w sobie, to nie trzeba by by�o pisa� BEGIN TRAN / COMMIT TRAN, ale mo�na....)
--Na koniec wy�wietl zawarto�� tabeli Applications

DECLARE @ApplicationName NVARCHAR(50) = 'Limit na komputer'
 
--uncomment to have commit - correct date
--DECLARE @InstallDate DATE = DATEADD(DAY,-1,GetDate())
--uncomment to have rollback - incorrect date
 
DECLARE @InstallDate DATE = DATEADD(DAY,1,GetDate())
 
IF(@InstallDate>GetDate())
BEGIN
 PRINT 'Incorrect date, change the date and try again!'
END
ELSE
BEGIN
 PRINT 'Date is correct, inserting the row:'
 BEGIN TRAN
 INSERT INTO Applications(ApplicationName,InstallDate)
 VALUES (@ApplicationName,@InstallDate)
 COMMIT
END
 
SELECT * FROM dbo.Applications

--Implicit transactions - LAB
--Sekcja 5, wyk�ad 76
--Skopuj tabel� Production.Products z bazy danych AdventureWorks do tempdb

--Zmie� tryb pracy na implicit transactions.

--Zmie� kolor wszystkich produkt�w na yellow

--Wy�wietl @@trancount

--Zamknij okno skryptu odpowiadaj�c na pytania o zapisanie transakcji NO

--W nowej sesji sprawd� jakie kolory  maj� produkty w tabeli products w bazie danych tempdb

use tempdb
GO
 
SELECT * INTO dbo.Product FROM AdventureWorks.Production.Product
GO
 
SET IMPLICIT_TRANSACTIONS ON
UPDATE dbo.Product SET Color = 'yellow'
 
SELECT @@TRANCOUNT
 
SELECT Color FROM dbo.Product
 
--close script pane answering "No" and open a new one:
use tempdb 
GO
 
SELECT Color FROM dbo.Product
