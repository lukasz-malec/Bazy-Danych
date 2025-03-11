CREATE TABLE Klient (
    PESEL CHAR(11) PRIMARY KEY NOT NULL,
    Imie VARCHAR(255) NOT NULL,
    Nazwisko VARCHAR(255) NOT NULL,
    Adres VARCHAR(255) NOT NULL,
    Telefon VARCHAR(9) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Data_rozpoczecia DATE NOT NULL
);


CREATE TABLE Konto_zwykle (
    Nr_konta_zw CHAR(26) PRIMARY KEY NOT NULL, 
    Stan DECIMAL(15, 2) NOT NULL 
);



CREATE TABLE Konto_walutowe (
    Nr_konta_wal CHAR(26) PRIMARY KEY NOT NULL,
    Stan DECIMAL(15, 2) NOT NULL,
    Waluta CHAR(3) NOT NULL
);



CREATE TABLE Konto_oszczednosciowe (
    Nr_konta_oszcz CHAR(26) PRIMARY KEY NOT NULL,
    Stan DECIMAL(15, 2) NOT NULL,
    Procent DECIMAL(5, 2) NOT NULL 
);



CREATE TABLE Relacje (
    osoba CHAR(11) NOT NULL,
    nr_konta CHAR(26) NOT NULL, 
    typ_konta ENUM('zwykle', 'walutowe', 'oszczednosciowe') NOT NULL,

    PRIMARY KEY (osoba, nr_konta),
    FOREIGN KEY (osoba) REFERENCES Klient(PESEL)
);



CREATE TABLE Kredyty (
    ID_kredytu INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Nr_konta CHAR(26) NOT NULL, 
    Kwota DECIMAL(15, 2) NOT NULL, 
    Oprocentowanie DECIMAL(5, 2) NOT NULL,
    Okres_splaty INT NOT NULL,
    Data_zaciagniecia DATE NOT NULL,
    Aktywny BOOLEAN DEFAULT 1,
    FOREIGN KEY (Nr_konta) REFERENCES Konto_zwykle(Nr_konta_zw) 
);



CREATE TABLE Lokaty (
    ID_lokaty INT AUTO_INCREMENT PRIMARY KEY,
    Nr_konta CHAR(26) NOT NULL, 
    Kwota DECIMAL(15, 2) NOT NULL, 
    Oprocentowanie DECIMAL(5, 2) NOT NULL,
    Data_rozpoczecia DATE NOT NULL,
    Data_zakonczenia DATE NOT NULL,

    FOREIGN KEY (Nr_konta) REFERENCES Konto_zwykle(Nr_konta_zw)
);




-- wyzwalacze 


DELIMITER //
CREATE TRIGGER splacony_kredyt
AFTER UPDATE ON Kredyty
FOR EACH ROW 
BEGIN
    DECLARE Bilans DECIMAL(15,2);

    SELECT Kwota INTO Bilans
    FROM Kredyty
    WHERE ID_kredytu = NEW.ID_kredytu;

    IF Bilans = 0.0 THEN
        UPDATE Kredyty
        SET Aktywny = 0
        WHERE ID_kredytu = NEW.ID_kredytu;
    END IF;
END;
//
DELIMITER ;



DELIMITER //
CREATE TRIGGER data_dodania
BEFORE INSERT ON Klient
FOR EACH ROW 
BEGIN
    SET NEW.Data_rozpoczecia = NOW();
END;
//
DELIMITER ;



DELIMITER //
CREATE TRIGGER modyfikuj
AFTER UPDATE ON Konto_zwykle
FOR EACH ROW 
BEGIN
    DECLARE Osoba_pesel CHAR(11);
    
    SELECT osoba INTO Osoba_pesel
    FROM Relacje 
    WHERE Relacje.nr_konta = OLD.Nr_konta_zw;

    UPDATE Relacje 
    SET nr_konta = NEW.Nr_konta_zw
    WHERE osoba = Osoba_pesel;
END;
//
DELIMITER ;


