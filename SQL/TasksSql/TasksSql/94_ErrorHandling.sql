--B³êdy w SQL - wprowadzenie - LAB
--Sekcja 7, wyk³ad 94
--Popraw b³êdy w nastêpuj¹cych zapytaniach



--SELECT * FROM Production.Products



--SELECT ProductName FROM Production.Product



--SELECT FirstName
--FROM Person.Person
--ORDER BY FirstName
--WHERE LastName LIKE 'K%'



--SELECT p.Name + ' ' + p.ListPrice
--FROM Production.Product p



--SELECT p.Name, COUNT(*)
--FROM Production.Product p



--SELECT p.FirstName + ' ' + p.LastName AS FullName, COUNT(*)
--FROM Person.Person p
--GROUP BY FullName



--SELECT Name INTO #PRD FROM Production.Product
--SELECT Name INTO #PRD FROM Production.Product

USE AdventureWorks
GO
 
SELECT * FROM Production.Products
SELECT * FROM Production.Product
GO
 
SELECT ProductName FROM Production.Product
SELECT Name FROM Production.Product
GO
 
SELECT FirstName
FROM Person.Person
ORDER BY FirstName
WHERE LastName LIKE 'K%'
SELECT FirstName
FROM Person.Person
WHERE LastName LIKE 'K%'
ORDER BY FirstName
GO
 
SELECT p.Name + ' ' + p.ListPrice
FROM Production.Product p
SELECT p.Name + ' ' + CAST(p.ListPrice AS NVARCHAR(10))
FROM Production.Product p
GO
 
SELECT p.Name, COUNT(*)
FROM Production.Product p
SELECT p.Name, COUNT(*)
FROM Production.Product p
GROUP BY p.Name
GO
 
SELECT p.FirstName + ' ' + p.LastName AS FullName, COUNT(*)
FROM Person.Person p
GROUP BY FullName
SELECT p.FirstName + ' ' + p.LastName AS FullName, COUNT(*)
FROM Person.Person p
GROUP BY p.FirstName + ' ' + p.LastName
GO
 
SELECT Name INTO #PRD FROM Production.Product
SELECT Name INTO #PRD FROM Production.Product
SELECT Name INTO #PRD2 FROM Production.Product
INSERT INTO #PRD2 SELECT Name FROM Production.Product

--B³êdy w SQL Server, ustawienia jêzykowe, severity - LAB
--Sekcja 7, wyk³ad 97
--Przejrzyj b³êdy z severity 16 

--Zobacz jakie jêzyki s¹ dostêpne w Twojej instalacji SQL. Zobacz jakie informacje s¹ zapamiêtywane na temat ka¿dego jêzyka

SELECT * FROM sys.messages WHERE severity = 16
 
SELECT * FROM syslanguages

--Czy b³¹d automatycznie wycofa transakcjê - LAB
--Sekcja 7, wyk³ad 100
--Utwórz w bazie danych tempdb tabelê, która bêdzie przechowywa³a informacje o wynikach egzaminów:

--CREATE TABLE ExamResults
--(ExamId INT NOT NULL,
--StudentID INT NOT NULL,
--Points INT NOT NULL)

--Napisz transakcjê zawieraj¹c¹ 3 polecenia INSERT, która wpisz¹ do tabeli 3 rekordy:
--• Egzamin 100, student 1000, liczba punktów 30
--• Egzamin 100, student 1001, liczba punktów NULL (praca jeszcze nie sprawdzona)
--• Egzamin 100  student 1002, liczba punktów 50



--Uruchom polecenie zamykaj¹c je w transakcji, po czym sprawdŸ ile rekordów zosta³o wstawionych



--Usuñ rekordy z tabeli



--Zachowaj skrypt do kolejnego laboratorium

USE tempdb
GO
 
CREATE TABLE ExamResults
(ExamId INT NOT NULL,
StudentID INT NOT NULL,
Points INT NOT NULL)
GO
 
BEGIN TRAN
 INSERT INTO ExamResults VALUES(100, 1000,30)
 INSERT INTO ExamResults VALUES(100, 1001,NULL)
 INSERT INTO ExamResults VALUES(100, 1002,50)
COMMIT
GO
 
SELECT * FROM ExamResults
GO
 
DELETE FROM ExamResults
GO

--Zmienna @@Error - LAB
--Sekcja 7, wyk³ad 103
--Nadal pracujemy nad tabel¹ z poprzedniego zadania.

--Korzystaj¹c ze zmiennej @@Error obs³u¿ b³¹d powstaj¹cy podczas wstawiania rekordu do tabeli ExamResults, tak aby w przypadku b³êdu pojawi³ siê wyœwietlony instukcj¹ PRINT numer b³êdu.

--Przetestuj dzia³anie twojego kodu na jednym poprawnym rekordzie i na jednym b³êdnym

DECLARE @LastError INT = 0
 
INSERT INTO ExamResults VALUES(100, 1001,NULL)
SET @LastError = @@ERROR
IF @LastError > 0 
BEGIN
 PRINT 'There is an error: ' + CAST(@LastError AS VARCHAR(10))
END
GO
 
DECLARE @LastError INT = 0
 
INSERT INTO ExamResults VALUES(100, 1001,30)
SET @LastError = @@ERROR
IF @LastError > 0 
BEGIN
 PRINT 'There is an error: ' + CAST(@LastError AS VARCHAR(10))
END

--Obs³uga b³êdów TRY/CATCH - LAB
--Sekcja 7, wyk³ad 106
--Zast¹p w poprzednim zadaniu instrukcje wykorzystuj¹ce zmienn¹ @@ERROR na intrukcjê TRY CATCH. Póki co w instrukcji CATCH nie trzeba robiæ nic wiêcej poza wyœwietleniem dodatkowego komunikatu

--Zachowaj przyk³ad do kolejnego laboratorium

BEGIN TRY
 INSERT INTO ExamResults VALUES(100, 1001,NULL)
END TRY
BEGIN CATCH
 PRINT 'There is an error: ' + CAST(@@Error AS VARCHAR(10))
END CATCH
GO

--Funkcje zwracaj¹ce informacje o b³êdzie - LAB
--Sekcja 7, wyk³ad 109
--W przyk³adzie z poprzedniego zadania dodaj w bloku catch instrukcje wyœwietlaj¹ce informacje o b³êdzie:

--numer b³êdu
--tekst b³edu
--severity b³edu
--nazwê procedury (tutaj nic nie bêdzie zwracane, wiêc mo¿esz skorzystaæ z ISNULL)
--numer linii

BEGIN TRY
 INSERT INTO ExamResults VALUES(100, 1001,NULL)
END TRY
BEGIN CATCH
 PRINT 'Error number  : ' + CAST(ERROR_NUMBER() AS VARCHAR(10))
 PRINT 'Error message : ' + ERROR_MESSAGE()
 PRINT 'Error severity: ' + CAST(ERROR_SEVERITY() AS VARCHAR(10))
 PRINT 'Procedure name: ' + ISNULL(ERROR_PROCEDURE(),'-not a procedure-')
 PRINT 'Line number   : ' + CAST(ERROR_LINE() AS VARCHAR(10))
END CATCH
GO


--Obs³uga b³êdu w TRY/CATCH z poprawnym wycofaniem transakcji - LAB
--Sekcja 7, wyk³ad 112
--Twoim zadaniem jest wykonanie nastêpuj¹cych poleceñ INSERT:

--Egzamin 100, student 1000, liczba punktów 30
--Egzamin 100, student 1001, liczba punktów NULL (praca jeszcze nie sprawdzona)
--Egzamin 100  student 1002, liczba punktów 50
--Przy tym:

--Te 3 polecenia insert maj¹ byæ objête transakcj¹
--Jeœli podczas wstawiania rekordów dojdzie do b³êdu to transakcja ma siê wycofaæ
--Skorzystaj z funkcji XACT_STATE() oraz ustawienia XACT_ABORT

SET XACT_ABORT ON
BEGIN TRY
 BEGIN TRAN
 INSERT INTO ExamResults VALUES(100, 1000,30)
 INSERT INTO ExamResults VALUES(100, 1001,NULL)
 INSERT INTO ExamResults VALUES(100, 1002,50)
 COMMIT
END TRY
BEGIN CATCH
 IF (XACT_STATE()) = -1
    BEGIN
        PRINT 'Rolling back transaction.'
        ROLLBACK TRANSACTION;
    END;
    IF (XACT_STATE()) = 1
    BEGIN
        PRINT 'Committing transaction.'
        COMMIT TRANSACTION;   
    END;
END CATCH

--Zg³aszanie b³êdów RAISERROR i dodawanie w³asnych b³edów sp_addmessage - LAB
--Sekcja 7, wyk³ad 115
--Korzystaj¹c z funkcji RAISERROR zg³oœ b³¹d "Netto cannot be greater than brutto"

--Zamieñ w komunikacie o b³edzie s³owa netto i brutto na odpowiedni "placeholder", a nastêpnie korzystaj¹c ze modyfikowanego komunikatu zg³oœ b³êdy:

--Netto cannot be greater than brutto
--Delivery date cannot be greater than order date
--Dodaj komunikat "... cannnot be greater than ..." do tabeli komunikatów systemowych i nadaj mu numer 60001

--Zg³oœ b³ad 60001 przekazuj¹c jako parametry "Minimum price" i "Maximum price"

--Usuñ b³¹d 60001 z tabeli systemowej

RAISERROR('Netto cannot be greater than brutto',16,1)
GO
 
RAISERROR('%s cannot be greater than %s',16,1,'NETTO','BRUTTO')
RAISERROR('%s cannot be greater than %s',16,1,'Delivery date','Order date')
GO
 
exec sp_addmessage 60001,16,'%s cannot be greater than %s'
GO
 
RAISERROR(60001,16,1,'Minimum price','Maximum price')
GO
 
exec sp_dropmessage 60001
GO

--Zg³aszanie b³êdów THROW - LAB
--Sekcja 7, wyk³ad 118
--Korzystaj¹c z polecenia THROW zg³oœ b³ad 60001 z komunikatem "Netto cannot be greater than brutto" i state = 1

--Zazwyczaj tego nie robiê, ale... poszukaj dokumntacji funkcji FORMATMESSAGE i:
--zadeklaruj zmienn¹ @v typu NVARCHAR(100) i przypisz jej wynik formatowania napisu "%s cannot be greater than %s" zamieniaj¹c %s raz na 'Netto' a raz na 'brutto'. Do formatowania wykorzystaj oczywiœcie funkcjê FORMATMESSAGE
--Zg³oœ b³¹d korzystaj¹c z funkcji THROW, zmiennej @v i state = 1. 
--Wykonaj ponownie te same czynnoœci ale teraz zamieñ parametry funkcji FORMATMESSAGE zamieniaj¹c %s na "Delivery date" i "order date"
--Dodaj do systemowej tablicy messages b³¹d 60001 o treœci "%s cannot be greater than %s" a nastêpnie:
--zadeklaruj zmienn¹ @v NVARCHAR(100)
--korzystaj¹c z funkcji FORMATMESSAGE zamieñ treœæ komunikatu powi¹zanego z b³êdem 60001 na "Minimum price" i "maximum price"
--Zg³oœ b³¹d korzystaj¹c z funkcji THROW, zmiennej @v i state = 1
--Usuñ komunkat 60001 z tablicy systemowej sys.messages

;THROW 60001, 'Netto cannot be greater than brutto',1
GO
 
DECLARE  @v NVARCHAR(100) = FORMATMESSAGE('%s cannot be greater than %s','Netto','brutto')
;THROW 60001, @v,1;
GO
 
DECLARE  @v NVARCHAR(100) = FORMATMESSAGE('%s cannot be greater than %s','Delivery date','order date')
;THROW 60001, @v,1;
exec sp_addmessage 60001,16,'%s cannot be greater than %s'
GO
 
DECLARE  @v NVARCHAR(100)
SET @v = FORMATMESSAGE(60001, 'Minimum price','Maximum price')
 
;THROW 60001, @v, 1
exec sp_dropmessage 60001
GO

--Severity b³êdów, odczyt b³êdów - LAB
--Sekcja 7, wyk³ad 121
--Korzystaj¹c z polecenia RAISERROR zg³oœ b³¹d z severity 10

--Korzystaj¹c z polecenia RAISERROR zg³oœ b³¹d z severity 16

--Korzystaj¹c z polecenia RAISERROR zg³oœ b³¹d z severity 19 (uwaga - tu musisz dodaæ opjê WITH LOG)

--Zapisz b³¹d w dzienniku zdarzeñ jako INFO z numerem 54321

--Odczytaj w/w b³êdy korzystaj¹c z procedury sp_readerrorlog

RAISERROR ('A test message from the course',10,1)
RAISERROR ('A test message from the course',16,1)
RAISERROR ('A test message from the course',19,1) WITH LOG
 
EXEC xp_logevent 54321, 'a test message from the course', 'Informational'
 
EXEC sp_readerrorlog 0,1,'message from the'