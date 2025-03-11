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
    IdLotu INT NOT NULL,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    NumerTelefonu VARCHAR(15) NOT NULL,
    NumerPaszportu VARCHAR(20) NOT NULL,
    Rzad INT NOT NULL,
    Miejsce VARCHAR(1) NOT NULL,
    Klasa VARCHAR(30) NOT NULL,


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


-- procedury 

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


