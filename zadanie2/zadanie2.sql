CREATE TABLE Produkt(
    Id_produktu INT NOT NULL PRIMARY  KEY AUTO_INCREMENT,
    Produkt VARCHAR(255) NOT NULL,
    Cena_jednostkowa INT NOT NULL
);


CREATE TABLE Faktura_zakupu (
    Identyfikator_faktury INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Numer_faktury VARCHAR(50) NOT NULL,
    Nazwa_firmy VARCHAR(255) NOT NULL,
    Wlasciciel VARCHAR(255),
    Adres_firmy VARCHAR(255) NOT NULL,
    NIP INT NOT NULL,
    Laczna_kwota INT NOT NULL,
    Data_faktury DATE
);


CREATE TABLE Faktura_sprzedazy (
    Identyfikator_faktury INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Numer_faktury VARCHAR(50) NOT NULL,
    Nazwa_firmy VARCHAR(255) NOT NULL,
    Wlasciciel VARCHAR(255),
    Adres_firmy VARCHAR(255) NOT NULL,
    NIP INT NOT NULL,
    Laczna_kwota INT NOT NULL,
    Data_faktury DATE
);



CREATE TABLE Szczegoly_faktury_zakupu (
    Pozycja INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Identyfikator_faktury INT NOT NULL,
    Produkt VARCHAR(255) NOT NULL,
    Ilosc INT NOT NULL,
    Jednostka_miary VARCHAR(10) NOT NULL,
    Cena_jednostkowa INT NOT NULL,
    Kwota INT NOT NULL,

    FOREIGN KEY (Identyfikator_faktury) REFERENCES Faktura_zakupu(Identyfikator_faktury)
);


CREATE TABLE Szczegoly_faktury_sprzedazy (
    Pozycja INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Identyfikator_faktury INT NOT NULL,
    Produkt VARCHAR(255) NOT NULL,
    Ilosc INT NOT NULL,
    Jednostka_miary VARCHAR(10) NOT NULL,
    Cena_jednostkowa INT NOT NULL,
    Kwota INT NOT NULL,

    FOREIGN KEY (Identyfikator_faktury) REFERENCES Faktura_sprzedazy(Identyfikator_faktury)
);



CREATE TABLE Paragon (
    Identyfikator_paragonu INT NOT NULL PRIMARY KEY,
    Numer_paragonu VARCHAR(50) NOT NULL,
    Nazwa_sklepu VARCHAR(255),
    Adres_sklepu VARCHAR(255),
    Data_sprzedazy DATE,
    Laczna_kwota INT NOT NULL
);


CREATE TABLE Szczegoly_paragonu (
    Pozycja INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Identyfikator_paragonu INT NOT NULL,
    Produkt VARCHAR(255) NOT NULL,
    Ilosc INT NOT NULL,
    Jednostka_miary VARCHAR(10) NOT NULL,
    Cena_jednostkowa INT NOT NULL,
    Kwota INT NOT NULL,

    FOREIGN KEY (Identyfikator_paragonu) REFERENCES Paragon(Identyfikator_paragonu)
);


CREATE TABLE Magazyn(
    Id_produktu INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Produkt  VARCHAR(255) NOT NULL,
    Cena_jednostkowa INT NOT NULL,
    Liczba_na_stanie INT NOT NULL,
    Jednostka_miary VARCHAR(10) NOT NULL
);


CREATE TABLE Pracownicy (
    PESEL INT NOT NULL PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Stanowisko VARCHAR(100) NOT NULL,
    Numer_telefonu INT,
    Czas_trwania_umowy DATE,
    Zarobki FLOAT NOT NULL,
    Data_zatrudnienia DATE NOT NULL,
    Adres_email VARCHAR(255),
    Adres VARCHAR(255),
    Numer_konta VARCHAR(255)
);


--- wstawienie 2 przykładowych rekordów do kazdej tabeli

INSERT INTO Produkt (Id_produktu,Produkt, Cena_jednostkowa) 
VALUES 
    (1,'Długopis Niebieski', 5),
    (2,'Zeszyt A5 60 kartek', 3);


INSERT INTO Faktura_zakupu (Identyfikator_faktury, Numer_faktury, Nazwa_firmy, Wlasciciel, Adres_firmy, NIP, Laczna_kwota, Data_faktury)
VALUES 
    (1, '3', 'Abc', 'Jan Kowalski', 'ul. Jakas 23, Grudziądz', 123, 5000, '2024-1-23'),
    (2, '23434', 'Alfabet', 'Piotr Nowak', 'ul. Inna 37, Kraków', 987, 500, '2024-06-13');



INSERT INTO Szczegoly_faktury_zakupu (Pozycja, Identyfikator_faktury, Produkt, Ilosc, Jednostka_miary, Cena_jednostkowa, Kwota)
VALUES
    (1, 1, 'pióro wieczne "pisz"', 30, 'szt.', 100, 3000),
    (2, 1, 'zeszyt 60 kartek', 10, 'szt.', 200, 2000),

    (3, 2, 'ołówek cmp 23', 40, 'szt.', 10, 400),
    (4, 2, 'długopis wl 67', 5, 'szt.', 20, 100);


    
INSERT INTO Faktura_sprzedazy (Identyfikator_faktury, Numer_faktury, Nazwa_firmy, Wlasciciel, Adres_firmy, NIP, Laczna_kwota, Data_faktury)
VALUES
    (1,'344', 'Firma ABC',"Anna Bocian",'ul. Warszawska 5, Warszawa', 123456, 2500, '2024-11-01'),
    (2,'898', 'Firma XYZ', "Julia Duda",'ul. Krakowska 10, Kraków', 987654, 1500, '2024-11-02');


INSERT INTO Szczegoly_faktury_sprzedazy (Pozycja, Identyfikator_faktury, Produkt, Ilosc, Jednostka_miary, Cena_jednostkowa, Kwota)
VALUES
    (1, 1, 'Długopis czarny', 250, 'szt.', 10, 2500),
    (2, 2, 'Zeszyt A5', 100, 'szt.', 15, 1500);



INSERT INTO Paragon (Identyfikator_paragonu, Numer_paragonu, Nazwa_sklepu, Adres_sklepu, Data_sprzedazy, Laczna_kwota)
VALUES
    (1, '777WW', 'Sklep Papierniczy Notatnik', 'ul. Papiernicza 2, Krakow', '2024-11-01', 20),
    (2, '10AA', 'Sklep Papierniczy Notatnik', 'ul. Papiernicza 2, Krakow', '2024-11-02', 30);


INSERT INTO Szczegoly_paragonu (Pozycja, Identyfikator_paragonu, Produkt, Ilosc, Jednostka_miary, Cena_jednostkowa, Kwota)
VALUES
    (1, 1, 'Długopis żelowy', 2, 'szt.', 5, 10),
    (2, 1, 'Zeszyt A5', 1, 'szt.', 10, 10),
    (3, 2, 'Ołówek HB', 3, 'szt.', 2, 6),
    (4, 2, 'Klej w sztyfcie', 2, 'szt.', 12, 24);


INSERT INTO Magazyn (Id_produktu, Produkt, Cena_jednostkowa, Liczba_na_stanie, Jednostka_miary)
VALUES
    (1,'Długopis niebieski', 5, 100, "sztuki"),       
    (2,'Zeszyt A4 60 kartek', 3, 250, "sztuki"),      
    (3,'Pióro wieczne', 20, 50, "sztuki"),            
    (4,'Karteczki samoprzylepne', 2, 300, "sztuki"),  
    (5,'Tusze do długopisów', 10, 150, "sztuki");     


INSERT INTO Pracownicy (PESEL, Imie, Nazwisko, Stanowisko, Numer_telefonu, Czas_trwania_umowy, Zarobki, Data_zatrudnienia, Adres_email, Adres, Numer_konta) 
VALUES 
    (1234567, 'Jan', 'Kowalski', 'Kierownik', 123489, '2024-12-31', 5500.00, '2022-01-15', 'jan.kowalski@gmail.com', 'ul. Dietla 70, Krakow', '1233333'),
    (234012, 'Anna', 'Nowak', 'Kasjerka', 9876321, '2025-06-30', 4500.00, '2021-03-20', 'anna.nowak@gmail.com', 'ul. Czarnowiejska 50, Kraków', '026666');




-- zadanie 4
 
-- 2.1 Wszystkie dane ze wszystkich tabel 
SELECT * FROM Produkt;
SELECT * FROM Faktura_zakupu;
SELECT * FROM Faktura_sprzedazy;
SELECT * FROM Szczegoly_faktury_zakupu;
SELECT * FROM Szczegoly_faktury_sprzedazy;
SELECT * FROM Paragon;
SELECT * FROM Szczegoly_paragonu;
SELECT * FROM Magazyn;
SELECT * FROM Pracownicy;

-- 2.2 Wszystkie firmy, których nazwa to 'ABC"
SELECT * FROM Faktura_zakupu WHERE Nazwa_firmy = 'Abc';
SELECT * FROM Faktura_sprzedazy WHERE Nazwa_firmy = 'Abc';

-- 2.3 Nazwy wszystkich firm w kolejności alfabetycznej
SELECT * FROM Faktura_zakupu ORDER  BY Nazwa_firmy;
SELECT * FROM Faktura_sprzedazy ORDER  BY Nazwa_firmy;

-- 2.4 Trzy produkty, których liczba w magazynie przekracza 30 sztuk
SELECT * FROM Magazyn where Liczba_na_stanie > 30 AND Jednostka_miary = 'sztuki' LIMIT 3;

-- 2.5 Faktura zakupu na najwyższaą kwotę
SELECT * FROM Faktura_zakupu ORDER BY Laczna_kwota DESC LIMIT 1;

-- 2.6 Wszystkie zakupione produkty bez dwóch najdroższych
SELECT Produkt, Cena_jednostkowa FROM Szczegoly_faktury_zakupu ORDER BY Cena_jednostkowa DESC LIMIT 1000 OFFSET 2;

-- 2.7 Nazwę produktu, liczbę sztuk, cenę oraz numer faktury, na której sie znajduje

-- dla faktur zakupu
SELECT 
    Szczegoly_faktury_zakupu.Produkt, 
    Szczegoly_faktury_zakupu.Ilosc, 
    Szczegoly_faktury_zakupu.Jednostka_miary, 
    Szczegoly_faktury_zakupu.Cena_jednostkowa, 
    Faktura_zakupu.Numer_faktury
FROM 
    Szczegoly_faktury_zakupu
JOIN 
    Faktura_zakupu ON Szczegoly_faktury_zakupu.Identyfikator_faktury = Faktura_zakupu.Identyfikator_faktury;


-- dla faktur sprzedazy 
SELECT 
    Szczegoly_faktury_sprzedazy.Produkt, 
    Szczegoly_faktury_sprzedazy.Ilosc, 
    Szczegoly_faktury_sprzedazy.Jednostka_miary, 
    Szczegoly_faktury_sprzedazy.Cena_jednostkowa, 
    Faktura_sprzedazy.Numer_faktury
FROM 
    Szczegoly_faktury_sprzedazy
JOIN 
    Faktura_sprzedazy ON Szczegoly_faktury_sprzedazy.Identyfikator_faktury = Faktura_sprzedazy.Identyfikator_faktury;
