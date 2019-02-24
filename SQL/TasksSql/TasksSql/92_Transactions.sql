--Transakcje - wprowadzenie - LAB
--Sekcja 5, wyk³ad 64
--Skopiuj do tempdb zawartoœæ tabeli Production.Product z bazy danych AdventureWorks

-- Otwórz transakcjê

--W ramach transakcji usuñ ca³¹ zawartoœæ tabeli Product,

--SprawdŸ czy po usuniêciu rekordów tabela jest pusta

--Wycofaj transakcjê poleceniem ROLLBACK

--SprawdŸ czy rekordy wróci³y do tabeli

use tempdb
GO
 
SELECT * INTO dbo.Product FROM AdventureWorks.Production.Product
GO
 
BEGIN TRAN
 DELETE FROM dbo.Product
 SELECT * FROM dbo.Product
ROLLBACK
 
SELECT * FROM dbo.Product

--Zagnie¿d¿anie transakcji - LAB
--Sekcja 5, wyk³ad 67
--Do bazy danych tempdb skopiuj tabele Production.Product z bazy danych AdventureWorks

--Otwórz transakcjê

--Zmieñ cene wszystkich produktów na 0

--SprawdŸ efekty swojego polecenia. Wyœwietl @@trancount

--Otwórz drug¹ transakcjê

--Zmieñ kolor wszystkich produktów na silver

--SprawdŸ efekty swojego polecenia. Wyœwietl @@trancount

--Wykonaj COMMIT dla wewnêtrzej transakcji

--SprawdŸ ceny i kolor produktów. Wyœwietl @@trancount

--Wykonaj ROLLBACK

--SprawdŸ ceny i kolor produktów. Wyœwietl @@trancount

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

--Transakcja w praktyce - przyk³ad - LAB
--Sekcja 5, wyk³ad 70
--W bazie danych tempdb utwórz tabele applications

--ApplicationId – liczba autonumerowanie
--ApplicationName – napis do 50 znaków
--Install date – data instalcji progamu na komputerze
--Zadeklaruj zmienne @ApplicationName, @InstallDate o odpwiednich typach

--W tamach transakcji wpisz rekord do tabeli, nie koñcz transakcji.

--Dokonaj kontroli – je¿eli data instalacji jest wiêksza ni¿ data dzisiejsza, wycofaj transakcjê, w przeciwnym razie zatwierdŸ j¹.

--Przetestuj dzia³anie sktyptu dla poprawnej daty (np. dziœ - 1 dzieñ) i niepoprawnej daty (np dziœ + 1 dzieñ)

--SprawdŸ zawartoœæ tabeli po wykonaniu zadania

--Zachowaj przyk³ad do kolejnego zadania

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
--Sekcja 5, wyk³ad 73
--Pracujemy z poprzednim przyk³adem:

--Sprawdzenie czy data jest poprawna przenieœ przed kod wykonuj¹cy transakcjê:

--Je¿eli data jest z przysz³oœci wyœwietl komunikat i nie wykonuj ¿adnej transakcji
--Je¿eli data jest poprawna wyœwietl komunikat i zapisz rekord w transakcji
--(Poniewa¿ tu wpisujemy tylko jeden rekord, a pojedynczy INSERT jest transakcj¹ sam¹ w sobie, to nie trzeba by by³o pisaæ BEGIN TRAN / COMMIT TRAN, ale mo¿na....)
--Na koniec wyœwietl zawartoœæ tabeli Applications

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
--Sekcja 5, wyk³ad 76
--Skopuj tabelê Production.Products z bazy danych AdventureWorks do tempdb

--Zmieñ tryb pracy na implicit transactions.

--Zmieñ kolor wszystkich produktów na yellow

--Wyœwietl @@trancount

--Zamknij okno skryptu odpowiadaj¹c na pytania o zapisanie transakcji NO

--W nowej sesji sprawdŸ jakie kolory  maj¹ produkty w tabeli products w bazie danych tempdb

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
