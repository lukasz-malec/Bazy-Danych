CREATE TABLE hodowca (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    imie VARCHAR(50) NOT NULL,
    nazwisko VARCHAR(50) NOT NULL,
    adres VARCHAR(100) NOT NULL,
    telefon VARCHAR(15),
    email VARCHAR(50)
);

CREATE TABLE zwierzeta (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    gatunek VARCHAR(50) NOT NULL,
    liczba_zwierzat INT DEFAULT 0
);


CREATE TABLE relacje (
    hodowca_id INT NOT NULL,
    zwierze_id INT NOT NULL,


    PRIMARY KEY (hodowca_id, zwierze_id),

    FOREIGN KEY (hodowca_id) REFERENCES hodowca(id),
    FOREIGN KEY (zwierze_id) REFERENCES zwierzeta(id)
);



INSERT INTO hodowca (imie, nazwisko, adres, telefon, email) VALUES
('Jan', 'Kowalski', 'ul. Słoneczna 12, Warszawa', '123456789', 'jan.kowalski@gmail.com'),
('Anna', 'Nowak', 'ul. Kwiatowa 5, Kraków', '987654321', 'anna.nowak@gmail.com'),
('Piotr', 'Wiśniewski', 'ul. Leśna 8, Gdańsk', '456789123', 'piotr.wisniewski@gmail.com');

INSERT INTO zwierzeta (gatunek, liczba_zwierzat) VALUES
('Pies', 10),
('Kon', 25),
('Kot', 50);



-- Każdy z hodowców zajmuje się hodowlą każdego z wprowadzonych gatunków.
INSERT INTO relacje (hodowca_id, zwierze_id) VALUES
(1, 1), (1, 2), (1, 3), 
(2, 1), (2, 2), (2, 3), 
(3, 1), (3, 2), (3, 3);



-- test - wypisanie danych 
-- SELECT 
--     hodowca.imie AS Imie,
--     hodowca.nazwisko AS Nazwisko,
--     hodowca.adres AS Adres,
--     hodowca.telefon AS Telefon,
--     hodowca.email AS Email,
--     zwierzeta.gatunek AS Gatunek,
--     zwierzeta.liczba_zwierzat AS Liczba_Zwierzat
-- FROM 
--     hodowca
-- JOIN 
--     relacje ON hodowca.id = relacje.hodowca_id
-- JOIN 
--     zwierzeta ON zwierzeta.id = relacje.zwierze_id
