--B��dy w SQL - wprowadzenie - LAB
--Sekcja 7, wyk�ad 94
--Popraw b��dy w nast�puj�cych zapytaniach



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

--B��dy w SQL Server, ustawienia j�zykowe, severity - LAB
--Sekcja 7, wyk�ad 97
--Przejrzyj b��dy z severity 16 

--Zobacz jakie j�zyki s� dost�pne w Twojej instalacji SQL. Zobacz jakie informacje s� zapami�tywane na temat ka�dego j�zyka

SELECT * FROM sys.messages WHERE severity = 16
 
SELECT * FROM syslanguages

--Czy b��d automatycznie wycofa transakcj� - LAB
--Sekcja 7, wyk�ad 100
--Utw�rz w bazie danych tempdb tabel�, kt�ra b�dzie przechowywa�a informacje o wynikach egzamin�w:

--CREATE TABLE ExamResults
--(ExamId INT NOT NULL,
--StudentID INT NOT NULL,
--Points INT NOT NULL)

--Napisz transakcj� zawieraj�c� 3 polecenia INSERT, kt�ra wpisz� do tabeli 3 rekordy:
--� Egzamin 100, student 1000, liczba punkt�w 30
--� Egzamin 100, student 1001, liczba punkt�w NULL (praca jeszcze nie sprawdzona)
--� Egzamin 100  student 1002, liczba punkt�w 50



--Uruchom polecenie zamykaj�c je w transakcji, po czym sprawd� ile rekord�w zosta�o wstawionych



--Usu� rekordy z tabeli



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
--Sekcja 7, wyk�ad 103
--Nadal pracujemy nad tabel� z poprzedniego zadania.

--Korzystaj�c ze zmiennej @@Error obs�u� b��d powstaj�cy podczas wstawiania rekordu do tabeli ExamResults, tak aby w przypadku b��du pojawi� si� wy�wietlony instukcj� PRINT numer b��du.

--Przetestuj dzia�anie twojego kodu na jednym poprawnym rekordzie i na jednym b��dnym

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

--Obs�uga b��d�w TRY/CATCH - LAB
--Sekcja 7, wyk�ad 106
--Zast�p w poprzednim zadaniu instrukcje wykorzystuj�ce zmienn� @@ERROR na intrukcj� TRY CATCH. P�ki co w instrukcji CATCH nie trzeba robi� nic wi�cej poza wy�wietleniem dodatkowego komunikatu

--Zachowaj przyk�ad do kolejnego laboratorium

BEGIN TRY
 INSERT INTO ExamResults VALUES(100, 1001,NULL)
END TRY
BEGIN CATCH
 PRINT 'There is an error: ' + CAST(@@Error AS VARCHAR(10))
END CATCH
GO

--Funkcje zwracaj�ce informacje o b��dzie - LAB
--Sekcja 7, wyk�ad 109
--W przyk�adzie z poprzedniego zadania dodaj w bloku catch instrukcje wy�wietlaj�ce informacje o b��dzie:

--numer b��du
--tekst b�edu
--severity b�edu
--nazw� procedury (tutaj nic nie b�dzie zwracane, wi�c mo�esz skorzysta� z ISNULL)
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


--Obs�uga b��du w TRY/CATCH z poprawnym wycofaniem transakcji - LAB
--Sekcja 7, wyk�ad 112
--Twoim zadaniem jest wykonanie nast�puj�cych polece� INSERT:

--Egzamin 100, student 1000, liczba punkt�w 30
--Egzamin 100, student 1001, liczba punkt�w NULL (praca jeszcze nie sprawdzona)
--Egzamin 100  student 1002, liczba punkt�w 50
--Przy tym:

--Te 3 polecenia insert maj� by� obj�te transakcj�
--Je�li podczas wstawiania rekord�w dojdzie do b��du to transakcja ma si� wycofa�
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

--Zg�aszanie b��d�w RAISERROR i dodawanie w�asnych b�ed�w sp_addmessage - LAB
--Sekcja 7, wyk�ad 115
--Korzystaj�c z funkcji RAISERROR zg�o� b��d "Netto cannot be greater than brutto"

--Zamie� w komunikacie o b�edzie s�owa netto i brutto na odpowiedni "placeholder", a nast�pnie korzystaj�c ze modyfikowanego komunikatu zg�o� b��dy:

--Netto cannot be greater than brutto
--Delivery date cannot be greater than order date
--Dodaj komunikat "... cannnot be greater than ..." do tabeli komunikat�w systemowych i nadaj mu numer 60001

--Zg�o� b�ad 60001 przekazuj�c jako parametry "Minimum price" i "Maximum price"

--Usu� b��d 60001 z tabeli systemowej

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

--Zg�aszanie b��d�w THROW - LAB
--Sekcja 7, wyk�ad 118
--Korzystaj�c z polecenia THROW zg�o� b�ad 60001 z komunikatem "Netto cannot be greater than brutto" i state = 1

--Zazwyczaj tego nie robi�, ale... poszukaj dokumntacji funkcji FORMATMESSAGE i:
--zadeklaruj zmienn� @v typu NVARCHAR(100) i przypisz jej wynik formatowania napisu "%s cannot be greater than %s" zamieniaj�c %s raz na 'Netto' a raz na 'brutto'. Do formatowania wykorzystaj oczywi�cie funkcj� FORMATMESSAGE
--Zg�o� b��d korzystaj�c z funkcji THROW, zmiennej @v i state = 1. 
--Wykonaj ponownie te same czynno�ci ale teraz zamie� parametry funkcji FORMATMESSAGE zamieniaj�c %s na "Delivery date" i "order date"
--Dodaj do systemowej tablicy messages b��d 60001 o tre�ci "%s cannot be greater than %s" a nast�pnie:
--zadeklaruj zmienn� @v NVARCHAR(100)
--korzystaj�c z funkcji FORMATMESSAGE zamie� tre�� komunikatu powi�zanego z b��dem 60001 na "Minimum price" i "maximum price"
--Zg�o� b��d korzystaj�c z funkcji THROW, zmiennej @v i state = 1
--Usu� komunkat 60001 z tablicy systemowej sys.messages

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

--Severity b��d�w, odczyt b��d�w - LAB
--Sekcja 7, wyk�ad 121
--Korzystaj�c z polecenia RAISERROR zg�o� b��d z severity 10

--Korzystaj�c z polecenia RAISERROR zg�o� b��d z severity 16

--Korzystaj�c z polecenia RAISERROR zg�o� b��d z severity 19 (uwaga - tu musisz doda� opj� WITH LOG)

--Zapisz b��d w dzienniku zdarze� jako INFO z numerem 54321

--Odczytaj w/w b��dy korzystaj�c z procedury sp_readerrorlog

RAISERROR ('A test message from the course',10,1)
RAISERROR ('A test message from the course',16,1)
RAISERROR ('A test message from the course',19,1) WITH LOG
 
EXEC xp_logevent 54321, 'a test message from the course', 'Informational'
 
EXEC sp_readerrorlog 0,1,'message from the'