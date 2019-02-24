--Blokowanie rekord�w podczas transakcji - LAB
--Sekcja 6, wyk�ad 79
--Otw�rz dwa okna SQL Management Studio (mo�esz to zrobi� jak na wyk�adzie, obok siebie � dla wygody u�yj� sformu�owania okno LEWE i PRAWE) i podobnie b�dzie w kolejnych zadaniach

--W oknie lewym rozpocznij transakcj�, zmodyfikuj kolor produkt�w bia�ych na zielony. Nie commituj ani nie rollbackuj transakcji.

--W oknie prawym odczytaj lub pr�buj odczyta�:

--ilo�� rekord�w
--ilo�� rekord�w zielonych
--wy�wietl rekord z ID 707
--zaktualizuj rekord o identyfikatorze 707 zmieniaj�c koler na czarny
--Uwaga: je�eli twoja sesja jest zablokowana to przerywaj j� przyciskiem STOP (czerwony kwadracik na pasku narz�dziowym)

--Na zako�czenie wycofaj (ROLLBACK) transakcj� w lewym oknie.

--OKNO LEWE

USE AdventureWorks
GO
 
BEGIN TRAN
 UPDATE Production.Product
 SET Color = 'green'
 WHERE Color = 'white'
--now switch to the "right window"
--when everything done
--ROLLBACK

--OKNO PRAWE

USE AdventureWorks
GO
 
SELECT COUNT(*) FROM Production.Product
GO
 
SELECT COUNT(*) FROM Production.Product
WHERE Color = 'green'
GO
 
SELECT * FROM Production.Product
WHERE ProductID = 707
GO
 
UPDATE Production.Product
SET Color='Black'
WHERE ProductId = 707

--Kto, co i jak zablokowa�? Informacje o za�o�onych lockach - LAB
--Sekcja 6, wyk�ad 82
--Podobnie jak poprzednio otw�rz dwa okna

--W oknie lewym rozpocznij transakcj�, zmodyfikuj kolor produkt�w bia�ych na zielony. Nie commituj ani nie rollbackuj transakcji

--W oknie prawym wy�wietl informacje o za�o�onych lokach w bazie danych. Spr�buj zrozumie� za co mo�e odpowiada� ka�dy wy�wietlany rekord

--Na zako�czenie wycofaj (ROLLBACK) transakcj� w lewym oknie

--OKNO LEWE

USE AdventureWorks
GO
 
BEGIN TRAN
 UPDATE Production.Product
 SET Color = 'green'
 WHERE Color = 'white'
--now switch to the "right window"
--when everything done
--ROLLBACK
--OKNO PRAWE

 SELECT * FROM sys.dm_tran_locks 
 WHERE resource_database_id  =  DB_ID('AdventureWorks') and request_session_id <> @@SPID AND request_session_id > 50
lub w takiej postaci jak na wyk�adzie:

SELECT 
     TL.resource_type,
     TL.resource_database_id,
     TL.resource_associated_entity_id,
     TL.request_mode,
     TL.request_session_id,
     WT.blocking_session_id,
     O.name AS [object name],
     O.type_desc AS [object descr],
     P.partition_id AS [partition id],
     P.rows AS [partition/page rows],
     AU.type_desc AS [index descr],
     AU.container_id AS [index/page container_id]
FROM sys.dm_tran_locks AS TL
LEFT JOIN sys.dm_os_waiting_tasks AS WT 
 ON TL.lock_owner_address = WT.resource_address
LEFT OUTER JOIN sys.objects AS O 
 ON O.object_id = TL.resource_associated_entity_id
LEFT OUTER JOIN sys.partitions AS P 
 ON P.hobt_id = TL.resource_associated_entity_id
LEFT OUTER JOIN sys.allocation_units AS AU 
 ON AU.allocation_unit_id = TL.resource_associated_entity_id
 WHERE TL.resource_database_id  =  DB_ID('AdventureWorks') AND TL.request_session_id > 50
 AND request_session_id <> @@SPID
 ORDER BY TL.request_session_id 


-- Transaction Isolation Level READ UNCOMMITTED i READ COMMITTED - LAB
--Sekcja 6, wyk�ad 85
--Podobnie jak poprzednio otw�rz dwa okna

--W oknie lewym rozpocznij transakcj�, zmodyfikuj kolor produkt�w bia�ych na zielony. Nie commituj ani nie rollbackuj transakcji

--W oknie prawym zapytaj o ilo�� rekord�w bia�ych. Wykonaj to dla isolation level READ COMMITTED oraz p�niej dla READ UNCOMMITTED

--Na zako�czenie wycofaj (ROLLBACK) transakcj� w lewym oknie

--OKNO LEWE

USE AdventureWorks
GO
 
BEGIN TRAN
 UPDATE Production.Product
 SET Color = 'green'
 WHERE Color = 'white'
--now switch to the "right window"
--when everything done
--ROLLBACK

--OKNO PRAWE

--it is default
SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SELECT COUNT(*) FROM Production.Product WHERE Color = 'white'
 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT COUNT(*) FROM Production.Product WHERE Color = 'white'

--Transaction Isolation Level REPEATABLE READ - LAB
--Sekcja 6, wyk�ad 88
--Podobnie jak poprzednio otw�rz dwa okna

--W lewym rozpocznij transakcj� i przeczytaj ca�kowit� ilo�� rekord�w w Production.Product z podkategorii 10

--W prawym oknie zmie� podkategori� dla jednego produktu z 10 na 11 (zaktualizuj produkt�..)

--Odczytaj ponownie ilo�� rekord�w w oknie lewym. 

--Zmie� w odpowiedni spos�b transaction isolation level, aby odczyty w lewym oknie by�y powtarzalne i powt�rz test. (Pami�taj, �eby podczas modyfikacji podkategorii zmienia� inny rekord  lub wycofa� zmiany z poprzedniego testu)

--Na zako�czenie wycofaj (ROLLBACK) transakcj� w lewym oknie

--OKNO LEWE

USE AdventureWorks
GO
 
BEGIN TRAN
 SELECT * FROM Production.Product WHERE ProductSubcategoryID = 10
 --returned 3 rows
 --after modification in another session
 SELECT * FROM Production.Product WHERE ProductSubcategoryID = 10
 --returned 2 rows
ROLLBACK
 
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
 SELECT * FROM Production.Product WHERE ProductSubcategoryID = 10
 --returned 3 rows
 --after modification in another session
 SELECT * FROM Production.Product WHERE ProductSubcategoryID = 10
 --returned 2 rows
ROLLBACK

--OKNO PRAWE

USE AdventureWorks
GO
 
UPDATE Production.Product
 SET ProductSubcategoryID = 11
 WHERE ProductID = 802

-- Transaction Isolation Level SERIALIZABLE - LAB
--Sekcja 6, wyk�ad 91
--Podobnie jak poprzednio otw�rz dwa okna

--W lewym zmie� transaction isolation level na REPEATABLE READ i rozpocznij transakcj� i przeczytaj ca�kowit� ilo�� rekord�w w Production.Product z podkategorii 11.

--W prawym oknie zmie� podkategori� dla jednego produktu z 10 na 11 (tzn. zaktualizuj produkt, kt�ry do tej pory nie nale�a� do tej podkategorii)

--Odczytaj ponownie ilo�� rekord�w w oknie lewym.

--Zmie� w odpowiedni spos�b transaction isolation level aby odczyty w lewym oknie by�y powtarzalne.

--Za zako�czenie wycofaj transakcj� w oknie lewym.

--OKNO LEWE

USE AdventureWorks
GO
 
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
BEGIN TRAN
 SELECT * FROM Production.Product WHERE ProductSubcategoryID = 11
 --returned 3 rows
 --after modification in another session
 SELECT * FROM Production.Product WHERE ProductSubcategoryID = 11
 --returned 4 rows
ROLLBACK
 
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
BEGIN TRAN
 SELECT * FROM Production.Product WHERE ProductSubcategoryID = 11
 --returned 3 rows
 --after modification in another session
 SELECT * FROM Production.Product WHERE ProductSubcategoryID = 11
 --returned 3 rows
ROLLBACK

--OKNO PRAWE

USE AdventureWorks
GO
 
UPDATE Production.Product
 SET ProductSubcategoryID = 11
 WHERE ProductID = 802
