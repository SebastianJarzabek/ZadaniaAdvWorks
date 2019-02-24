--Polecenie INSERT - wprowadzenie - LAB
--Sekcja 2, wyk�ad 4
--W �wiczeniowej bazie danych (np. AdventureWorks) utw�rz nowy schemat Vacation.

--W schemacie Vacation utw�rz tabel� TripOffers z nast�puj�cymi kolumnami:

---Id � kolumna numeryczna, a autonumerowaniem, definiuj�ca klucz podstawowy

---Name � napis unicode do 50 znak�w, nie mo�e by� pusta

---Pilot � liczba int odwo�uj�ca si� do kolumny BusinessEntityId w tabeli Person.Person, dopuszczalne NULL (je�eli jeszcze nie ustalono kto b�dzie pilotem)

---Description � napis � do 100 znak�w, unicode

---Price � typ DECIMAL, nie mo�e by� pusta

---IsSigned � typ logiczny

---CreateDate � data, z warto�ci� domy�ln� daty dzisiejszej.

--Wstaw do tabeli rekord opisuj�cy ofert� na Twoje wymarzone wakacje

USE AdventureWorks;
GO

CREATE SCHEMA Vacation;
GO

CREATE TABLE Vacation.TripOffers
(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50) NOT NULL,
Pilot INT REFERENCES Person.Person(BusinessEntityId) NULL,
Description NVARCHAR(100),
Price DECIMAL NOT NULL,
IsSigned BIT,
CreateDate DATE DEFAULT GetDate()
)
GO

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES ('Africa Safari', NULL,'Comfortable 3-month trip to Africa',300.99,1,GetDate())
GO

--Polecenie INSERT - szczeg�y sk�adniowe - LAB
--Sekcja 2, wyk�ad 7
--Utw�rz polecenia INSERT, kt�re (ka�dy podpunkt to osobne polecenie INSERT):

--Wype�ni ka�d� kolumn� w tabeli TripOffers
--Opu�ci te kolumny, gdzie nazwa mo�e by� pusta lub jest wyliczana warto�ci� domy�ln�
--Opu�ci list� nazw kolumn za nazw� tabeli
--Wstawi 3 rekordy na raz
--Oraz takie, kt�re sprowokuj� b��dy:

--Opu�� nazwy kolumn i nie podaj wszystkich warto�ci
--Nie podaj warto�ci dla kolumny, kt�ra wymaga jakie� warto�ci
--W kolumnie Pilot odwo�a si� do niestniej�cego BusinessEntityId z tabeli Person.Person

USE AdventureWorks;
GO

CREATE SCHEMA Vacation;
GO

CREATE TABLE Vacation.TripOffers
(
Id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(50) NOT NULL,
Pilot INT REFERENCES Person.Person(BusinessEntityId) NULL,
Description NVARCHAR(100),
Price DECIMAL NOT NULL,
IsSigned BIT,
CreateDate DATE DEFAULT GetDate()
)
GO

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES ('Africa Safari', NULL,'Comfortable 3-month trip to Africa',300.99,1,DEFAULT)
GO

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES ('Alaska Snow', 4,'Amazing week in Alaska',300.99,1,GetDate())
GO

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES ('Alaska Snow', 4,'Amazing week in Alaska',300.99,1,GetDate())
GO

INSERT INTO Vacation.TripOffers(Name,Price)
VALUES ('Gaudi in Barcelona',299.99)
GO

INSERT INTO Vacation.TripOffers
VALUES ('Volcanic Island', 4,'Car trip',300.99,1,GetDate())
GO

INSERT INTO Vacation.TripOffers(Name,Price)
VALUES ('Rome and Vatican',299.99),
   ('Live in Pompei',299.99),
   ('Venice for Lovers',1000)
GO

--with error
INSERT INTO Vacation.TripOffers
VALUES ('Volcanic Island', 'Car trip',300.99,1,GetDate())
GO

--with error
INSERT INTO Vacation.TripOffers
VALUES (NULL, 4,'Car trip',300.99,1,GetDate())
GO

--with error
INSERT INTO Vacation.TripOffers
VALUES ('Volcanic Island', 55555,'Car trip',300.99,1,GetDate())
GO

--IDENTITY i IDENTITY_INSERT - LAB
--Sekcja 2, wyk�ad 10
--Do tabeli TripOffers dodaj nowy rekord. 

--Wy�wietlaj�c zawarto�� tabeli zobacz czy w numeracji w kolumnie Id masz teraz luki.

--Zmie� odpowiedni� opcj� tak, aby m�c jawnie poda� warto�� dla kolumny ID w poleceniu INSERT

--Wstaw co najmniej jeden rekord, kt�ry wykorzysta jedn� z luk

--Otw�rz now� sesj� do Twojej bazy danych i sprawd� czy wstawiaj�c nowe rekordy  mo�esz okre�la� IDENTITY podczas wstawiania nowych rekord�w

--Wr�c do poprzedniej sesji. Zmie� opcje, tak aby wstawiaj�c rekordy nie trzeba ju� by�o jawnie podawa� warto�ci dla kolumny zdefiniowanej jako IDENTITY

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES ('Tram in Lisboa', NULL,'Visiting Lisboa with a tram',300.99,1,DEFAULT)
GO

SELECT * FROM Vacation.TripOffers
GO

SET IDENTITY_INSERT Vacation.TripOffers ON
GO

INSERT INTO Vacation.TripOffers(Id,Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES (8,'Tram in Lisboa', NULL,'Visiting Lisboa with a tram',300.99,1,DEFAULT)
GO

--in new session - this should be an error:
INSERT INTO Vacation.TripOffers(Id, Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES (9,'Tram in Lisboa', NULL,'Visiting Lisboa with a tram',300.99,1,DEFAULT)
GO

--back in the first session:
SET IDENTITY_INSERT Vacation.TripOffers OFF
GO

--Naprawa IDENTITY - DBCC CHECKIDENT - LAB
--Sekcja 2, wyk�ad 13
--Poleceniem DELETE wykasuj wszystkie rekordy z tabeli TripOffers

--�Napraw� kolumn� identity tak, aby numeracja nowych rekord�w rozpocz�a si� od 1

--Wstaw nowy rekord i upewnij si�, �e nowo wygenerowane IDENTITY to 1

DELETE FROM Vacation.TripOffers
GO

DBCC CHECKIDENT ('Vacation.TripOffers', RESEED, 0)
GO

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES ('Tram in Lisboa', NULL,'Visiting Lisboa with a tram',300.99,1,DEFAULT)
GO

SELECT * FROM Vacation.TripOffers
GO

--IDENTITY a unikalno�� warto�ci w kolumnie - LAB
--Sekcja 2, wyk�ad 16
--Ustaw opcj� pozwalaj�c� na wpisywanie do tabeli okre�lonej w poleceniu INSERT warto�ci IDENTITY

--Spr�buj wstawi� do tabeli 2 rekordy z identyfikatorem 100. Poniewa� tabela ma klucz podstawowy na kolumnie ID, za drugim razem powinien zosta� wygenerowany b��d

--Wy��cz opcj� pozwalaj�c� r�cznie podawa� warto�� dla kolumny Id korzystaj�cej z IDENTITY

SET IDENTITY_INSERT Vacation.TripOffers ON
GO

INSERT INTO Vacation.TripOffers(Id,Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES (100,'Italy daily', NULL,'Meet Italians just on a gray day!',300.99,1,DEFAULT)
GO

--error should be thrown
INSERT INTO Vacation.TripOffers(Id,Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES (100,'Italy daily', NULL,'Meet Italians just on a gray day!',300.99,1,DEFAULT)
GO

SET IDENTITY_INSERT Vacation.TripOffers OFF
GO

--@@IDENTITY i funkcja SCOPE_IDENTITY - LAB
--Sekcja 2, wyk�ad 19
--Wstaw do tabeli TripOffers nowy rekord. Natychmiast po wstawieniu rekordu wy�wietl go. Skorzystaj raz z funkcji @@IDENTITY a raz ze SCOPE_IDENTITY()

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES ('Diving with sharks', NULL,'Trip with diving course in Thailand',300.99,1,DEFAULT)
GO

SELECT * FROM Vacation.TripOffers WHERE Id=@@IDENTITY
GO

SELECT * FROM Vacation.TripOffers WHERE Id=SCOPE_IDENTITY()
GO

--INSERT - klauzula OUTPUT - LAB
--Sekcja 2, wyk�ad 22
--Wstaw do tabeli TripOffers 2 rekordy korzystaj�c z jednego polecenia INSERT. Ca�� zawarto�� rekordu wy�wietl korzystaj�c z klauzuli OUTPUT.

--Zmodyfikuj polecenie tak, aby wy�wietla�o tylko identyfikator i nazw� nowej oferty

--Zmodyfikuj polecenie tak, aby wy�wietla�o tylko identyfikator nowo tworzonych rekord�w

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
OUTPUT inserted.*
VALUES ('Meet the Queen - England', NULL,'Visit Royal Palace',300.99,1,DEFAULT),
   ('Meet the King - Spain', NULL,'Visit Royal Palace',300.99,1,DEFAULT)
GO

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
OUTPUT inserted.id,inserted.name
VALUES ('Meet the Queen - England', NULL,'Visit Royal Palace',300.99,1,DEFAULT),
   ('Meet the King - Spain', NULL,'Visit Royal Palace',300.99,1,DEFAULT)
GO

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
OUTPUT inserted.id
VALUES ('Meet the Queen - England', NULL,'Visit Royal Palace',300.99,1,DEFAULT),
   ('Meet the King - Spain', NULL,'Visit Royal Palace',300.99,1,DEFAULT)
GO

--Kopiowanie rekord�w mi�dzy tabelami - INSERT SELECT - LAB
--Sekcja 2, wyk�ad 25
--Utw�rz tabel� Vacation.Catalog z tylko 2 kolumnami: Name (napis 50 znak�w) i Price (decimal)

--Przepisz z tabeli TripOffers rekordy do tabeli Catalog. Przepisywane maj� by� tylko Name i Price

CREATE TABLE Vacation.Catalog
(
Name NVARCHAR(50),
Price DECIMAL
)
GO

INSERT INTO Vacation.Catalog
SELECT Name, Price 
FROM Vacation.TripOffers

--Kopiowanie rekord�w mi�dzy tabelami - SELECT INTO - LAB
--Sekcja 2, wyk�ad 28
--Przepisz wszystkie rekordy z tabeli TripOffers do nowej tabeli tymczasowej #trips.

--Po wykonaniu polecenia sprawd� zawarto�� tabeli #trips

--Roz��cz swoj� sesj� do SQL Servera i otw�rz j� ponownie

--Sprawd� czy tabela #trips nadal istnieje. Nie powinno ju� jej by�, dlatego uda si� wykona� kolejne polecenie

--Przepisz wszystkie rekordy z tabeli TripOffers to tabeli #trips raz jeszcze, ale tym razem wybierz tylko kolumn� Id i Name

SELECT * INTO #trips FROM Vacation.TripOffers
GO

SELECT * FROM #trips
GO

--reconnect your session

--error will be thrown
SELECT * FROM #trips
GO

SELECT Id,Name INTO #trips FROM Vacation.TripOffers
GO

--Polecenie INSERT EXEC - LAB
--Sekcja 2, wyk�ad 31
--Utw�rz w bazie danych AdventureWorks tabel� Vacation.Destination o strukturze

--Id kolumna autonumerowana, klucz podstawowy tabeli, liczba ca�kowita
--Name � napis Unicode maksymalnie 100 znak�w
--CountryRegionCode � napis unicode maksymalnie 10 znak�w
--Przetestuj dzia�anie polecenia:

--SELECT DISTINCT t.name, t.CountryRegionCode
--  FROM Sales.SalesTerritory t
 

--Utw�rz procedur� Vacation.GetDestinations, kt�ra b�dzie po prostu wykonywa� w/w zapytanie

-- Przetestuj dzia�anie procedury wywo�uj�c j� poleceniem EXEC

--Przepisz rekordzy zwracane przez w/w procedur� do tabeli Vacation.Destinations

CREATE TABLE Vacation.Destination
(
Id INT IDENTITY,
Name NVARCHAR(100),
CountryRegionCod NVARCHAR(10)
)
GO

SELECT DISTINCT t.name, t.CountryRegionCode
  FROM Sales.SalesTerritory t
GO

CREATE PROCEDURE Vacation.GetDestinations
AS
SELECT DISTINCT t.name, t.CountryRegionCode
  FROM Sales.SalesTerritory t
GO

EXEC Vacation.GetDestinations
GO

INSERT INTO Vacation.Destination
EXEC Vacation.GetDestinations
GO

--Generowanie warto�ci SEQUENCE - LAB
--Sekcja 2, wyk�ad 34
--Utw�rz obiekt sequence o nazwie Vacation.OrderNumbers. Numeracja ma si� zaczyna� od 1 i by� powi�kszona o 1. Nie ma by� wykorzystywany cache ani rozpoczynanie numeracji od nowa

--Utworz tabele Vacation.TripOrder o strukturze

--Id liczba ca�kowita, automatyczne numerowanie
--OrderNumber unikalna liczba ca�kowita
--Description napis do 300 znak�w
--Przygotuj polecenie, kt�re wstawia do tabeli rekord  o kolejnym numerze OrderNumber pobranym z sequence OrderNumbers i dowolnej zawarto�ci w polu Description

CREATE SEQUENCE Vacation.OrderNumbers
START WITH 1
INCREMENT BY 1
NO CACHE
NO CYCLE
GO

CREATE TABLE Vacation.TripOrders
( 
Id INT IDENTITY PRIMARY KEY,
OrderNumber INT UNIQUE,
Description NVARCHAR(300)
)
GO

DECLARE @OrderNumber INT
DECLARE @Desc NVARCHAR(1000) = 'Tanzania trip-confirmed'

SELECT @OrderNumber = NEXT VALUE FOR Vacation.OrderNumbers

INSERT INTO Vacation.TripOrders(OrderNumber, Description)
VALUES (@OrderNumber,@Desc)

SELECT * FROM Vacation.TripOrders 

