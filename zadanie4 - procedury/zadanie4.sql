CREATE TABLE Samoloty (
    IdSamolotu INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Model VARCHAR(50) NOT NULL,
    Rodzaj VARCHAR(50) NOT NULL,
    Zasieg INT NOT NULL,
    Spalanie INT NOT NULL,
    LiczbaMiejsc_Ekonomiczna INT,
    LiczbaMiejsc_Biznes INT,
    LiczbaMiejsc_Pierwsza INT
);

CREATE TABLE Trasy (
    IdTrasy INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    LotniskoStart VARCHAR(50) NOT NULL,
    LotniskoCel VARCHAR(50) NOT NULL,
    OdlegloscKm INT NOT NULL
);


CREATE TABLE Loty (
    IdLotu INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    IdSamolotu INT NOT NULL,
    IdTrasy INT NOT NULL,
    DataStartu DATE NOT NULL,
    GodzinaStartu TIME NOT NULL,
    GodzinaMety TIME NOT NULL,

    FOREIGN KEY (IdSamolotu) REFERENCES Samoloty(IdSamolotu),
    FOREIGN KEY (IdTrasy) REFERENCES Trasy(IdTrasy)
);



CREATE TABLE Bilety (
    IdBiletu INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    IdLotu INT,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    NumerTelefonu VARCHAR(15) NOT NULL,
    NumerPaszportu VARCHAR(20) NOT NULL,
    Rzad INT NOT NULL,
    Miejsce VARCHAR(1) NOT NULL,
    Klasa VARCHAR(30),


    FOREIGN KEY (IdLotu) REFERENCES Loty(IdLotu)
);


CREATE TABLE Personel (
    IdPersonelu INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    NumerTelefonu VARCHAR(15) NOT NULL,
    Funkcja VARCHAR(30) NOT NULL
);


CREATE TABLE PersonelLotu (
    Id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    IdPersonelu INT NOT NULL,
    IdLotu INT NOT NULL,

    FOREIGN KEY (IdPersonelu) REFERENCES Personel(IdPersonelu),
    FOREIGN KEY (IdLotu) REFERENCES Loty(IdLotu)
);


-- procedury z zadania 3

DELIMITER //
CREATE PROCEDURE DodajPersonel(
    IN ImieProc VARCHAR(50),
    IN NazwiskoProc VARCHAR(50),
    IN NumerTelefonuProc VARCHAR(15),
    IN FunkcjaProc VARCHAR(30)
)
BEGIN
    INSERT INTO Personel (Imie, Nazwisko, NumerTelefonu, Funkcja)
    VALUES (ImieProc, NazwiskoProc, NumerTelefonuProc, FunkcjaProc);
END//

DELIMITER ;



DELIMITER //
CREATE PROCEDURE LotniskaTrasa()
BEGIN
    SELECT LotniskoStart, LotniskoCel From Trasy;
END//

DELIMITER ;



DELIMITER //

CREATE PROCEDURE Zmien(
    IN IdPersoneluProc INT,
    IN NowyNumerTelefonuProc VARCHAR(15)
)
BEGIN
    UPDATE Personel
    SET NumerTelefonu = NowyNumerTelefonuProc
    WHERE IdPersonelu = IdPersoneluProc;
END//

DELIMITER ;


-- procedury zadanie 4 

-- Do bazy danych z zadania 5 proszę dodać przy pomocy procedur przynajmniej 3 samoloty, 15 pasażerów, wybranych członków załogi oraz 3 loty.

DELIMITER //

CREATE PROCEDURE DodajSamolot(
    IN p_Model VARCHAR(50),
    IN p_Rodzaj VARCHAR(50),
    IN p_Zasieg INT,
    IN p_Spalanie INT,
    IN p_LiczbaMiejsc_Ekonomiczna INT,
    IN p_LiczbaMiejsc_Biznes INT,
    IN p_LiczbaMiejsc_Pierwsza INT
)
BEGIN
    INSERT INTO Samoloty (Model, Rodzaj, Zasieg, Spalanie, LiczbaMiejsc_Ekonomiczna, LiczbaMiejsc_Biznes, LiczbaMiejsc_Pierwsza)
    VALUES (p_Model, p_Rodzaj, p_Zasieg, p_Spalanie, p_LiczbaMiejsc_Ekonomiczna, p_LiczbaMiejsc_Biznes, p_LiczbaMiejsc_Pierwsza);
END //

DELIMITER ;


CALL DodajSamolot('Boeing 737', 'Szerokokadlubowy', 7000, 2400, 150, 0, 0);
CALL DodajSamolot('Airbus A320', 'Szerokokadlubowy', 8000, 2600, 180, 25, 15);
CALL DodajSamolot('Boeing 777', 'Szerokokadlubowy', 9000, 1800, 100, 10, 5);

DELIMITER //


CREATE PROCEDURE DodajPasazera(
    IN p_Imie VARCHAR(50),
    IN p_Nazwisko VARCHAR(50),
    IN p_NumerTelefonu VARCHAR(15),
    IN p_NumerPaszportu VARCHAR(20),
    IN p_Rzad INT,
    IN p_Miejsce CHAR(1),
    IN p_Klasa VARCHAR(30)
)
BEGIN
    INSERT INTO Bilety (IdLotu, Imie, Nazwisko, NumerTelefonu, NumerPaszportu, Rzad, Miejsce, Klasa)
    VALUES (NULL, p_Imie, p_Nazwisko, p_NumerTelefonu, p_NumerPaszportu, p_Rzad, p_Miejsce, p_Klasa);
END //

DELIMITER ;

CALL DodajPasazera('Jan', 'Kowalski', '123456789', 'AB1234567', 1, 'A', 'Ekonomiczna');
CALL DodajPasazera('Anna', 'Nowak', '987654321', 'BC2345678', 1, 'B', 'Ekonomiczna');
CALL DodajPasazera('Piotr', 'Wiśniewski', '123123123', 'CD3456789', 1, 'C', 'Ekonomiczna');
CALL DodajPasazera('Katarzyna', 'Mazur', '234234234', 'DE4567890', 1, 'D', 'Ekonomiczna');
CALL DodajPasazera('Tomasz', 'Kaczmarek', '345345345', 'EF5678901', 2, 'A', 'Ekonomiczna');
CALL DodajPasazera('Ewa', 'Lewandowska', '456456456', 'FG6789012', 2, 'B', 'Ekonomiczna');
CALL DodajPasazera('Andrzej', 'Kowalczyk', '567567567', 'GH7890123', 2, 'C', 'Ekonomiczna');
CALL DodajPasazera('Barbara', 'Zielińska', '678678678', 'IJ8901234', 2, 'D', 'Ekonomiczna');
CALL DodajPasazera('Marek', 'Szymański', '789789789', 'KL9012345', 3, 'A', 'Ekonomiczna');
CALL DodajPasazera('Magdalena', 'Zając', '890890890', 'MN0123456', 3, 'B', 'Ekonomiczna');
CALL DodajPasazera('Rafał', 'Wójcik', '901901901', 'OP1234567', 3, 'C', 'Ekonomiczna');
CALL DodajPasazera('Agata', 'Kamińska', '112112112', 'QR2345678', 3, 'D', 'Ekonomiczna');
CALL DodajPasazera('Grzegorz', 'Jankowski', '223223223', 'ST3456789', 4, 'A', 'Ekonomiczna');
CALL DodajPasazera('Joanna', 'Piotrowska', '334334334', 'UV4567890', 4, 'B', 'Ekonomiczna');
CALL DodajPasazera('Karol', 'Nowicki', '445445445', 'WX5678901', 4, 'C', 'Ekonomiczna');



CALL DodajPersonel('Anna', 'Nowak', '987654321', 'Pilot');
CALL DodajPersonel('Michał', 'Wiśniewski', '770200300', 'Pilot');
CALL DodajPersonel('Magda', 'Lipa', '888300400', 'Stewardessa');



DELIMITER //

CREATE PROCEDURE DodajLot(
    IN p_IdSamolotu INT,
    IN p_IdTrasy INT,
    IN p_DataStartu DATE,
    IN p_GodzinaStartu TIME,
    IN p_GodzinaMety TIME
)
BEGIN
    INSERT INTO Loty (IdSamolotu, IdTrasy, DataStartu, GodzinaStartu, GodzinaMety)
    VALUES (p_IdSamolotu, p_IdTrasy, p_DataStartu, p_GodzinaStartu, p_GodzinaMety);
END //

DELIMITER ;

CALL DodajLot(1, 1, '2024-11-25', '08:00:00', '12:00:00');
CALL DodajLot( 2, 2, '2024-11-26', '09:00:00', '14:00:00');
CALL DodajLot(3, 3, '2024-12-27', '07:30:00', '09:30:00');




-- a) przydzielającą samoloty do lotów (należy pamiętać, aby nie przydzielić samolotu do trasy dłuższej niż jego zasięg o ile baza nie przywiduje międzylądowania na trasie),

DELIMITER //

CREATE PROCEDURE PrzydzielSamolotDoLotu(IN p_IdSamolotu INT, IN p_IdTrasy INT)
BEGIN
    DECLARE zasiegSamolotu INT;
    DECLARE odlegloscTrasy INT;

    SELECT Zasieg INTO zasiegSamolotu FROM Samoloty WHERE IdSamolotu = p_IdSamolotu;
    SELECT OdlegloscKm INTO odlegloscTrasy FROM Trasy WHERE IdTrasy = p_IdTrasy;

    IF zasiegSamolotu >= odlegloscTrasy THEN
        UPDATE Loty SET IdSamolotu = p_IdSamolotu WHERE IdTrasy = p_IdTrasy;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Zasięg samolotu jest zbyt mały dla tej trasy.';
    END IF;
END //
DELIMITER ;



-- b)dodającą do załogi obsługującej loty dłuższe niż 5000 km jednego członka załogi na każde 1000 km powyżej 5000 km,
DELIMITER //

CREATE PROCEDURE DodajCzlonkaZalogiDoDlugichLotow()
BEGIN
    DECLARE koniec INT DEFAULT 0;
    DECLARE idLotu INT;
    DECLARE odleglosc INT;
    DECLARE dodatkowi INT;
    DECLARE v_count INT DEFAULT 0;

    -- liczba lotów gdzie OdlegloscKm > 5000
    SELECT COUNT(*) INTO v_count
    FROM Loty
    JOIN Trasy ON Loty.IdTrasy = Trasy.IdTrasy
    WHERE OdlegloscKm > 5000;


    WHILE v_count > 0 DO
        -- pobieranie jdnego lotu
        SELECT Loty.IdLotu, Trasy.OdlegloscKm 
        INTO idLotu, odleglosc
        FROM Loty
        JOIN Trasy ON Loty.IdTrasy = Trasy.IdTrasy
        WHERE Trasy.OdlegloscKm > 5000
        LIMIT 1;

        
        SET dodatkowi = FLOOR((odleglosc - 5000) / 1000);

        -- dodawanie członków załogi
        WHILE dodatkowi > 0 DO
            INSERT INTO PersonelLotu (IdPersonelu, IdLotu)
            VALUES ((SELECT IdPersonelu FROM Personel WHERE Funkcja = 'Steward' LIMIT 1), idLotu);
            SET dodatkowi = dodatkowi - 1;
        END WHILE;


        SET v_count = v_count - 1;
    END WHILE;

END //
DELIMITER ;


-- c) dodającą jednego pilota do załóg obsługujących loty dłuższe niż 7000 km,

DELIMITER //

CREATE PROCEDURE DodajPilotaDoDlugichLotow()
BEGIN
    DECLARE koniec INT DEFAULT 0;
    DECLARE idLotu INT;
    DECLARE odleglosc INT;
    DECLARE v_count INT DEFAULT 0;

    -- liczba lotów (gdzie OdlegloscKm > 7000)
    SELECT COUNT(*) INTO v_count
    FROM Loty
    JOIN Trasy ON Loty.IdTrasy = Trasy.IdTrasy
    WHERE OdlegloscKm > 7000;

   
    WHILE v_count > 0 DO
        SELECT Loty.IdLotu, Trasy.OdlegloscKm 
        INTO idLotu, odleglosc
        FROM Loty
        JOIN Trasy ON Loty.IdTrasy = Trasy.IdTrasy
        WHERE Trasy.OdlegloscKm > 7000
        LIMIT 1;

        -- dodanie pilota
        INSERT INTO PersonelLotu (IdPersonelu, IdLotu)
        VALUES ((SELECT IdPersonelu FROM Personel WHERE Funkcja = 'Pilot' LIMIT 1), idLotu);

        SET v_count = v_count - 1;
    END WHILE;

END //
DELIMITER ;



-- d) przydzielającą bilety na poszczególne loty dla wszystkich pasażerów (pasażerów proszę przydzielać w kolejności alfabetycznej)

DELIMITER //

CREATE PROCEDURE PrzydzielBiletyPasażerom()
BEGIN
    DECLARE rzad INT DEFAULT 1;
    DECLARE miejsce CHAR(1) DEFAULT 'A';
    DECLARE idLotu INT;
    DECLARE v_count INT;



    SELECT COUNT(*) INTO v_count FROM Loty;


    WHILE v_count > 0 DO
        SELECT IdLotu INTO idLotu
        FROM Loty
        LIMIT 1;

 
        -- rekordy tabeli Bilety, w której nie ma przypisanego lotu
        UPDATE Bilety
        SET IdLotu = idLotu,
            Rzad = rzad,
            Miejsce = miejsce
        WHERE IdLotu IS NULL
        ORDER BY Imie, Nazwisko
        LIMIT 1;



        SET miejsce = CHAR(ASCII(miejsce) + 1);  

        IF ASCII(miejsce) > 70 THEN  
            SET rzad = rzad + 1;
            SET miejsce = 'A';  
        END IF;


        SET v_count = v_count - 1;
    END WHILE;
END //

DELIMITER ;



