--Polecenie INSERT - wprowadzenie - LAB
--Sekcja 2, wyk³ad 4
--W æwiczeniowej bazie danych (np. AdventureWorks) utwórz nowy schemat Vacation.

--W schemacie Vacation utwórz tabelê TripOffers z nastêpuj¹cymi kolumnami:

---Id – kolumna numeryczna, a autonumerowaniem, definiuj¹ca klucz podstawowy

---Name – napis unicode do 50 znaków, nie mo¿e byæ pusta

---Pilot – liczba int odwo³uj¹ca siê do kolumny BusinessEntityId w tabeli Person.Person, dopuszczalne NULL (je¿eli jeszcze nie ustalono kto bêdzie pilotem)

---Description – napis – do 100 znaków, unicode

---Price – typ DECIMAL, nie mo¿e byæ pusta

---IsSigned – typ logiczny

---CreateDate – data, z wartoœci¹ domyœln¹ daty dzisiejszej.

--Wstaw do tabeli rekord opisuj¹cy ofertê na Twoje wymarzone wakacje

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

--Polecenie INSERT - szczegó³y sk³adniowe - LAB
--Sekcja 2, wyk³ad 7
--Utwórz polecenia INSERT, które (ka¿dy podpunkt to osobne polecenie INSERT):

--Wype³ni ka¿d¹ kolumnê w tabeli TripOffers
--Opuœci te kolumny, gdzie nazwa mo¿e byæ pusta lub jest wyliczana wartoœci¹ domyœln¹
--Opuœci listê nazw kolumn za nazw¹ tabeli
--Wstawi 3 rekordy na raz
--Oraz takie, które sprowokuj¹ b³êdy:

--Opuœæ nazwy kolumn i nie podaj wszystkich wartoœci
--Nie podaj wartoœci dla kolumny, która wymaga jakieœ wartoœci
--W kolumnie Pilot odwo³a siê do niestniej¹cego BusinessEntityId z tabeli Person.Person

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
--Sekcja 2, wyk³ad 10
--Do tabeli TripOffers dodaj nowy rekord. 

--Wyœwietlaj¹c zawartoœæ tabeli zobacz czy w numeracji w kolumnie Id masz teraz luki.

--Zmieñ odpowiedni¹ opcjê tak, aby móc jawnie podaæ wartoœæ dla kolumny ID w poleceniu INSERT

--Wstaw co najmniej jeden rekord, który wykorzysta jedn¹ z luk

--Otwórz now¹ sesjê do Twojej bazy danych i sprawdŸ czy wstawiaj¹c nowe rekordy  mo¿esz okreœlaæ IDENTITY podczas wstawiania nowych rekordów

--Wróc do poprzedniej sesji. Zmieñ opcje, tak aby wstawiaj¹c rekordy nie trzeba ju¿ by³o jawnie podawaæ wartoœci dla kolumny zdefiniowanej jako IDENTITY

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
--Sekcja 2, wyk³ad 13
--Poleceniem DELETE wykasuj wszystkie rekordy z tabeli TripOffers

--„Napraw” kolumnê identity tak, aby numeracja nowych rekordów rozpoczê³a siê od 1

--Wstaw nowy rekord i upewnij siê, ¿e nowo wygenerowane IDENTITY to 1

DELETE FROM Vacation.TripOffers
GO

DBCC CHECKIDENT ('Vacation.TripOffers', RESEED, 0)
GO

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES ('Tram in Lisboa', NULL,'Visiting Lisboa with a tram',300.99,1,DEFAULT)
GO

SELECT * FROM Vacation.TripOffers
GO

--IDENTITY a unikalnoœæ wartoœci w kolumnie - LAB
--Sekcja 2, wyk³ad 16
--Ustaw opcjê pozwalaj¹c¹ na wpisywanie do tabeli okreœlonej w poleceniu INSERT wartoœci IDENTITY

--Spróbuj wstawiæ do tabeli 2 rekordy z identyfikatorem 100. Poniewaæ tabela ma klucz podstawowy na kolumnie ID, za drugim razem powinien zostaæ wygenerowany b³¹d

--Wy³¹cz opcjê pozwalaj¹c¹ rêcznie podawaæ wartoœæ dla kolumny Id korzystaj¹cej z IDENTITY

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
--Sekcja 2, wyk³ad 19
--Wstaw do tabeli TripOffers nowy rekord. Natychmiast po wstawieniu rekordu wyœwietl go. Skorzystaj raz z funkcji @@IDENTITY a raz ze SCOPE_IDENTITY()

INSERT INTO Vacation.TripOffers(Name,Pilot,Description,Price,IsSigned,CreateDate)
VALUES ('Diving with sharks', NULL,'Trip with diving course in Thailand',300.99,1,DEFAULT)
GO

SELECT * FROM Vacation.TripOffers WHERE Id=@@IDENTITY
GO

SELECT * FROM Vacation.TripOffers WHERE Id=SCOPE_IDENTITY()
GO

--INSERT - klauzula OUTPUT - LAB
--Sekcja 2, wyk³ad 22
--Wstaw do tabeli TripOffers 2 rekordy korzystaj¹c z jednego polecenia INSERT. Ca³¹ zawartoœæ rekordu wyœwietl korzystaj¹c z klauzuli OUTPUT.

--Zmodyfikuj polecenie tak, aby wyœwietla³o tylko identyfikator i nazwê nowej oferty

--Zmodyfikuj polecenie tak, aby wyœwietla³o tylko identyfikator nowo tworzonych rekordów

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

--Kopiowanie rekordów miêdzy tabelami - INSERT SELECT - LAB
--Sekcja 2, wyk³ad 25
--Utwórz tabelê Vacation.Catalog z tylko 2 kolumnami: Name (napis 50 znaków) i Price (decimal)

--Przepisz z tabeli TripOffers rekordy do tabeli Catalog. Przepisywane maj¹ byæ tylko Name i Price

CREATE TABLE Vacation.Catalog
(
Name NVARCHAR(50),
Price DECIMAL
)
GO

INSERT INTO Vacation.Catalog
SELECT Name, Price 
FROM Vacation.TripOffers

--Kopiowanie rekordów miêdzy tabelami - SELECT INTO - LAB
--Sekcja 2, wyk³ad 28
--Przepisz wszystkie rekordy z tabeli TripOffers do nowej tabeli tymczasowej #trips.

--Po wykonaniu polecenia sprawdŸ zawartoœæ tabeli #trips

--Roz³¹cz swoj¹ sesjê do SQL Servera i otwórz j¹ ponownie

--SprawdŸ czy tabela #trips nadal istnieje. Nie powinno ju¿ jej byæ, dlatego uda siê wykonaæ kolejne polecenie

--Przepisz wszystkie rekordy z tabeli TripOffers to tabeli #trips raz jeszcze, ale tym razem wybierz tylko kolumnê Id i Name

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
--Sekcja 2, wyk³ad 31
--Utwórz w bazie danych AdventureWorks tabelê Vacation.Destination o strukturze

--Id kolumna autonumerowana, klucz podstawowy tabeli, liczba ca³kowita
--Name – napis Unicode maksymalnie 100 znaków
--CountryRegionCode – napis unicode maksymalnie 10 znaków
--Przetestuj dzia³anie polecenia:

--SELECT DISTINCT t.name, t.CountryRegionCode
--  FROM Sales.SalesTerritory t
 

--Utwórz procedurê Vacation.GetDestinations, która bêdzie po prostu wykonywaæ w/w zapytanie

-- Przetestuj dzia³anie procedury wywo³uj¹c j¹ poleceniem EXEC

--Przepisz rekordzy zwracane przez w/w procedurê do tabeli Vacation.Destinations

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

--Generowanie wartoœci SEQUENCE - LAB
--Sekcja 2, wyk³ad 34
--Utwórz obiekt sequence o nazwie Vacation.OrderNumbers. Numeracja ma siê zaczynaæ od 1 i byæ powiêkszona o 1. Nie ma byæ wykorzystywany cache ani rozpoczynanie numeracji od nowa

--Utworz tabele Vacation.TripOrder o strukturze

--Id liczba ca³kowita, automatyczne numerowanie
--OrderNumber unikalna liczba ca³kowita
--Description napis do 300 znaków
--Przygotuj polecenie, które wstawia do tabeli rekord  o kolejnym numerze OrderNumber pobranym z sequence OrderNumbers i dowolnej zawartoœci w polu Description

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

