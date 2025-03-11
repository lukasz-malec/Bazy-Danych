CREATE TABLE Klient (
    PESEL CHAR(11) PRIMARY KEY NOT NULL,
    Imie VARCHAR(255) NOT NULL,
    Nazwisko VARCHAR(255) NOT NULL,
    Adres VARCHAR(255) NOT NULL,
    Telefon CHAR(9) NOT NULL,
    Email VARCHAR(255) NOT NULL,
    Data_rozpoczecia DATE NOT NULL
);


CREATE TABLE Konto_zwykle (
    Nr_konta_zw CHAR(26) PRIMARY KEY NOT NULL, 
    Stan DECIMAL(15, 2) NOT NULL DEFAULT 0.00 
);



CREATE TABLE Konto_walutowe (
    Nr_konta_wal CHAR(26) PRIMARY KEY NOT NULL,
    Stan DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
    Waluta CHAR(3) NOT NULL
);



CREATE TABLE Konto_oszczednosciowe (
    Nr_konta_oszcz CHAR(26) PRIMARY KEY NOT NULL,
    Stan DECIMAL(15, 2) NOT NULL DEFAULT 0.00,
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




-- pzykladowe dane

INSERT INTO Klient (PESEL, Imie, Nazwisko, Adres, Telefon, Email, Data_rozpoczecia)
VALUES
('12345678901', 'Jan', 'Kowalski', 'ul. Warszawska 1, Warszawa', '123456789', 'jan.kowalski@gmail.com', '2023-01-01'),
('98765432109', 'Anna', 'Nowak', 'ul. Krakowska 2, Kraków', '987654321', 'anna.nowak@gmail.com', '2023-02-01');


INSERT INTO Konto_zwykle (Nr_konta_zw, Stan)
VALUES
('12345678901234567890123456', 5000.00),
('98765432109876543210987654', 2000.00);


INSERT INTO Konto_walutowe (Nr_konta_wal, Stan, Waluta)
VALUES
('12345678901234567890123457', 300.00, 'USD'),
('98765432109876543210987655', 500.00, 'EUR');


INSERT INTO Konto_oszczednosciowe (Nr_konta_oszcz, Stan, Procent)
VALUES
('12345678901234567890123458', 10000.00, 2.50),
('98765432109876543210987656', 8000.00, 3.00);



INSERT INTO Relacje (osoba, nr_konta, typ_konta)
VALUES
('12345678901', '12345678901234567890123456', 'zwykle'),
('12345678901', '12345678901234567890123457', 'walutowe'),
('12345678901', '12345678901234567890123458', 'oszczednosciowe'),
('98765432109', '98765432109876543210987654', 'zwykle'),
('98765432109', '98765432109876543210987655', 'walutowe'),
('98765432109', '98765432109876543210987656', 'oszczednosciowe');



INSERT INTO Kredyty (Nr_konta, Kwota, Oprocentowanie, Okres_splaty, Data_zaciagniecia)
VALUES
('12345678901234567890123456', 1500.00, 5.00, 12, '2024-01-01'),
('98765432109876543210987654', 3000.00, 4.00, 24, '2024-01-01');


INSERT INTO Lokaty (Nr_konta, Kwota, Oprocentowanie, Data_rozpoczecia, Data_zakonczenia)
VALUES
('12345678901234567890123456', 2000.00, 2.50, '2024-01-01', '2024-12-31'),
('98765432109876543210987654', 1000.00, 3.00, '2024-01-01', '2024-06-30');



-- przelew z jednego konta do drugiego
START TRANSACTION;


UPDATE Konto_zwykle
SET Stan = Stan - 500.00
WHERE Nr_konta_zw = '12345678901234567890123456';

UPDATE Konto_zwykle
SET Stan = Stan + 500.00
WHERE Nr_konta_zw = '98765432109876543210987654';

COMMIT;



-- dodanie lokaty
START TRANSACTION;

INSERT INTO Lokaty (Nr_konta, Kwota, Oprocentowanie, Data_rozpoczecia, Data_zakonczenia)
VALUES ('98765432109876543210987654', 3000.00, 3.50, '2024-01-01', '2024-12-31');

COMMIT;



-- przyznanie kredytu
START TRANSACTION;

INSERT INTO Kredyty (Nr_konta, Kwota, Oprocentowanie, Okres_splaty, Data_zaciagniecia)
VALUES ('12345678901234567890123456', 5000.00, 6.00, 36, '2024-01-01');

COMMIT;


