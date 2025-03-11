CREATE TABLE Produkty (
    Identyfikator_produktu INT PRIMARY KEY,
    Produkt VARCHAR(255) NOT NULL,
    Cena_jednostkowa INT NOT NULL,
    Liczba_na_stanie INT NOT NULL,
    Liczba_zakupionych_sztuk INT NOT NULL,
    Identyfikator_paragonu INT,
    Kwota INT NOT NULL
);


INSERT INTO Produkty (Identyfikator_produktu, Produkt, Cena_jednostkowa, Liczba_na_stanie, Liczba_zakupionych_sztuk, Identyfikator_paragonu, Kwota)
VALUES
    (1, 'Długopis Niebieski', 5, 100, 10, 567891, 50),
    (2, 'Zeszyt A5 60 kartek', 3, 200, 15, 7712345, 45);



CREATE TABLE SzczegolyParagonu (
    Identyfikator_paragonu INT PRIMARY KEY,
    NIP_wydawcy INT NOT NULL,
    Nazwa_wydawcy VARCHAR(255) NOT NULL,
    Adres_wydawcy VARCHAR(255) NOT NULL,
    Data_godzina_sprzedazy DATETIME NOT NULL,
    Kwota_sprzedazy INT NOT NULL
);


INSERT INTO SzczegolyParagonu (Identyfikator_paragonu, NIP_wydawcy, Nazwa_wydawcy, Adres_wydawcy, Data_godzina_sprzedazy, Kwota_sprzedazy)
VALUES 
    (101, 1234567, 'Sklep Papierniczy w Krakowie', 'ul. Krupnicza 3, Kraków', '2024-10-28 14:30:00', 150),
    (102, 9876543, 'Sklep Papierniczy w Krakowie', 'ul. Krupnicza 3, Kraków', '2024-10-28 15:00:00', 250);



CREATE TABLE SzczegolyFaktury (
    Identyfikator_faktury INT PRIMARY KEY NOT NULL,
    NIP_wydawcy INT NOT NULL,
    Nazwa_wydawcy VARCHAR(255) NOT NULL,
    Adres_wydawcy VARCHAR(255) NOT NULL,
    Data_godzina DATETIME NOT NULL,
    Kwota_netto INT NOT NULL,
    Vat INT NOT NULL,
    Kwota_brutto INT NOT NULL,
    Forma_platnosci VARCHAR(50) NOT NULL,
    NIP_nabywcy INT
);


INSERT INTO SzczegolyFaktury (Identyfikator_faktury, NIP_wydawcy, Nazwa_wydawcy, Adres_wydawcy, Data_godzina, Kwota_netto, Vat, Kwota_brutto, Forma_platnosci, NIP_nabywcy)
VALUES 
    (1001, 12345, 'Sklep Papierniczy w Krakowie', 'ul. Krupnicza 3, Kraków', '2024-10-28 10:30:00', 1000, 230, 1230, 'Gotówka', 11111),
    (1002, 987654, 'Sklep Papierniczy w Krakowie', 'ul. Krupnicza 3, Kraków', '2024-10-28 11:00:00', 2000, 460, 2460, 'Przelew', 22222);



CREATE TABLE Dostawcy (
    Nazwa_dostawcy VARCHAR(255) NOT NULL PRIMARY KEY,
    Numer_telefonu INT NOT NULL,
    Adres_email VARCHAR(255) NOT NULL,
    Adres_dostawcy VARCHAR(255) NOT NULL,
    Dostarczany_produkt VARCHAR(255) NOT NULL,
    Liczba_dostarczanego_towaru INT NOT NULL,
    Kwota INT NOT NULL
);

INSERT INTO Dostawcy (Nazwa_dostawcy, Numer_telefonu, Adres_email, Adres_dostawcy, Dostarczany_produkt, Liczba_dostarczanego_towaru, Kwota)
VALUES 
    ('Przykładowy_dostawca_1', 1234567, 'kontakt@dostawca.pl', 'ul. Długa 12, Kraków', 'Zeszyty szkolne', 500, 1500),
    ('Inny_dostawca', 987651, 'biuro@długopisy.com', 'ul. Karmelicka 7, Kraków', 'Długopisy', 100, 800);



CREATE TABLE SzczegolyProduktu (
    Identyfikator_produktu INT PRIMARY KEY,
    Nazwa_produktu VARCHAR(255) NOT NULL,
    Opis_produktu VARCHAR(500),
    Kategoria_produktu VARCHAR(100)
);

INSERT INTO SzczegolyProduktu (Identyfikator_produktu, Nazwa_produktu, Opis_produktu, Kategoria_produktu)
VALUES 
    (500, 'Papier do drukarki', 'Papier A4, 80 g/m², biały', 'Papier'),
    (255, 'Długopis żelowy', 'Długopis żelowy, czarny, cienkopis', 'Artykuły piśmiennicze');




CREATE TABLE Pracownicy (
    PESEL INT PRIMARY KEY,
    Imie VARCHAR(50) NOT NULL,
    Nazwisko VARCHAR(50) NOT NULL,
    Stanowisko VARCHAR(100) NOT NULL,
    Numer_telefonu INT,
    Czas_trwania_umowy DATE,
    Zarobki FLOAT NOT NULL,
    Data_zatrudnienia DATE NOT NULL,
    Adres_email VARCHAR(255),
    Adres VARCHAR(255)
);

INSERT INTO Pracownicy (PESEL, Imie, Nazwisko, Stanowisko, Numer_telefonu, Czas_trwania_umowy, Zarobki, Data_zatrudnienia, Adres_email, Adres)
VALUES 
    (9901025, 'Jan', 'Kowalski', 'Kierownik', 123456789, '2025-12-31', 7000.00, '2023-01-15', 'jan.kowalski@gmail.com', 'ul. Dietla 80, Kraków'),
    (9802021, 'Anna', 'Nowak', 'Asystentka', 987654321, '2024-06-30', 5500.50, '2022-07-01', 'anna.nowak@gmail.com', 'ul. Krakowska 70, Kraków');



