-- =======================
-- Données pour AEROPORT
-- =======================
INSERT INTO aeroport (nom, ville) VALUES
('Aéroport International Ivato', 'Antananarivo'),
('Aéroport Fascene', 'Nosy Be'),
('Aéroport de Tulear', 'Toliara'),
('Aéroport de Toamasina', 'Toamasina'),
('Aéroport Sainte-Marie', 'Sainte-Marie'),
('Aéroport de Mahajanga', 'Mahajanga');

-- =======================
-- Données pour AVION
-- =======================
INSERT INTO avion (nom, modele, capacite) VALUES
('Ankoay 1', 'ATR 72-600', 72),
('Ankoay 2', 'ATR 42-500', 48),
('Ravinala Express', 'Boeing 737-800', 160),
('Mada Sky', 'Embraer 190', 100);

-- =======================
-- Données pour VOL (routes)
-- =======================
-- Antananarivo -> Nosy Be
INSERT INTO vol (aeroport_depart_id, aeroport_arrivee_id)
SELECT a1.id, a2.id
FROM aeroport a1, aeroport a2
WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Nosy Be';

-- Antananarivo -> Toliara
INSERT INTO vol (aeroport_depart_id, aeroport_arrivee_id)
SELECT a1.id, a2.id
FROM aeroport a1, aeroport a2
WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Toliara';

-- Antananarivo -> Toamasina
INSERT INTO vol (aeroport_depart_id, aeroport_arrivee_id)
SELECT a1.id, a2.id
FROM aeroport a1, aeroport a2
WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Toamasina';

-- Antananarivo -> Mahajanga
INSERT INTO vol (aeroport_depart_id, aeroport_arrivee_id)
SELECT a1.id, a2.id
FROM aeroport a1, aeroport a2
WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Mahajanga';

-- =======================
-- Données pour AVION_VOL (programmations réelles)
-- =======================
-- Remarque : timestamptz = date + heure + fuseau
-- Exemple : 2026-01-12 à 12h00

-- TNR -> Nosy Be assuré par ATR 72 le 12 janvier à 12h
INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    1,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Nosy Be'),
    '2026-01-12 12:00:00+03'
);

-- TNR -> Nosy Be autre rotation à 18h avec Boeing 737
INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    3,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Nosy Be'),
    '2026-01-12 18:00:00+03'
);

-- TNR -> Toamasina à 09h avec Embraer 190
INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    4,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Toamasina'),
    '2026-01-13 09:00:00+03'
);

-- TNR -> Toliara à 07h avec ATR 42
INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    2,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Toliara'),
    '2026-01-14 07:00:00+03'
);
