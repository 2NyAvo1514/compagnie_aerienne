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
    '2026-01-17 12:00:00+03'
);

-- TNR -> Nosy Be autre rotation à 18h avec Boeing 737
INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    3,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Nosy Be'),
    '2026-01-17 18:00:00+03'
);

-- TNR -> Toamasina à 09h avec Embraer 190
INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    4,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Toamasina'),
    '2026-01-18 09:00:00+03'
);

-- TNR -> Toliara à 07h avec ATR 42
INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    2,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Toliara'),
    '2026-01-19 07:00:00+03'
);

INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    1,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Nosy Be'),
    '2026-01-17 12:00:00+03'
);

-- TNR -> Nosy Be autre rotation à 18h avec Boeing 737
INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    3,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Nosy Be'),
    '2026-01-17 18:00:00+03'
);

-- TNR -> Toamasina à 09h avec Embraer 190
INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    4,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Toamasina'),
    '2026-01-18 09:00:00+03'
);

-- TNR -> Toliara à 07h avec ATR 42
INSERT INTO avion_vol (avion_id, vol_id, date_heure)
VALUES (
    2,
    (SELECT v.id FROM vol v
     JOIN aeroport a1 ON v.aeroport_depart_id = a1.id
     JOIN aeroport a2 ON v.aeroport_arrivee_id = a2.id
     WHERE a1.ville = 'Antananarivo' AND a2.ville = 'Toliara'),
    '2026-01-19 07:00:00+03'
);
--insertion place 
INSERT INTO place (type) VALUES
('premiere'),
('premium'),
('economique')
ON CONFLICT DO NOTHING;

update place set type = 'premium'   where type = 'business';
--Avion-place 
-- Première classe
INSERT INTO avion_place (id_avion, id_place, nombre)
SELECT 
    a.id,
    p.id_place,
    12
FROM avion a, place p
WHERE a.modele = 'ATR 72-600'
AND p.type = 'premiere';

update avion_place set nombre = 30 where nombre=12;
update avion_place set nombre = 50 where nombre=60;
-- Économique
INSERT INTO avion_place (id_avion, id_place, nombre)
SELECT 
    a.id,
    p.id_place,
    60
FROM avion a, place p
WHERE a.modele = 'ATR 72-600'
AND p.type = 'economique';

-- Business = 0
INSERT INTO avion_place (id_avion, id_place, nombre)
SELECT 
    a.id,
    p.id_place,
    40
FROM avion a, place p
WHERE a.modele = 'ATR 72-600'
AND p.type = 'premium';

update avion_place set nombre = 40 where nombre=0;

--prix vol
-- Première classe
INSERT INTO prix_vol (id_avion_vol, id_place, prix)
SELECT 
    av.id,
    p.id_place,
    1200000
FROM avion_vol av
JOIN vol v ON av.vol_id = v.id
JOIN aeroport ad ON v.aeroport_depart_id = ad.id
JOIN aeroport aa ON v.aeroport_arrivee_id = aa.id
JOIN place p ON p.type = 'premiere'
WHERE ad.ville = 'Antananarivo'
AND aa.ville = 'Nosy Be';

-- Classe économique
INSERT INTO prix_vol (id_avion_vol, id_place, prix)
SELECT 
    av.id,
    p.id_place,
    450000
FROM avion_vol av
JOIN vol v ON av.vol_id = v.id
JOIN aeroport ad ON v.aeroport_depart_id = ad.id
JOIN aeroport aa ON v.aeroport_arrivee_id = aa.id
JOIN place p ON p.type = 'economique'
WHERE ad.ville = 'Antananarivo'
AND aa.ville = 'Nosy Be';

update prix_vol set prix = 700000 where prix=450000;

INSERT INTO prix_vol (id_avion_vol, id_place, prix)
SELECT 
    av.id,
    p.id_place,
    1000000
FROM avion_vol av
JOIN vol v ON av.vol_id = v.id
JOIN aeroport ad ON v.aeroport_depart_id = ad.id
JOIN aeroport aa ON v.aeroport_arrivee_id = aa.id
JOIN place p ON p.type = 'premium'
WHERE ad.ville = 'Antananarivo'
AND aa.ville = 'Nosy Be';


--test 
SELECT 
    av.id,
    av.date_heure,
    p.type,
    pv.prix
FROM prix_vol pv
JOIN place p ON pv.id_place = p.id_place
JOIN avion_vol av ON pv.id_avion_vol = av.id
ORDER BY av.date_heure, p.type;


--insertion categoriepassager 
INSERT INTO categoriepassager (type) VALUES
('adulte'),
('enfant')
ON CONFLICT DO NOTHING;
-- Insertion des données de test

-- -- Aéroports
-- INSERT INTO aeroport (nom, ville) VALUES 
-- ('Aéroport d''Ivato', 'Antananarivo'),
-- ('Aéroport de Fascène', 'Nosy Be')
-- ON CONFLICT DO NOTHING;

-- -- Avions
-- INSERT INTO avion (nom, modele, capacite) VALUES 
-- ('Airbus A320-200', 'A320', 180),
-- ('Boeing 737-800', 'B737', 189),
-- ('ATR 72-600', 'ATR72', 78)
-- ON CONFLICT DO NOTHING;

-- -- Vol entre TNR et Nosy Be
-- INSERT INTO vol (aeroport_depart_id, aeroport_arrivee_id)
-- SELECT 
--     (SELECT id FROM aeroport WHERE nom = 'Aéroport d''Ivato'),
--     (SELECT id FROM aeroport WHERE nom = 'Aéroport de Fascène')
-- WHERE NOT EXISTS (
--     SELECT 1 FROM vol WHERE 
--     aeroport_depart_id = (SELECT id FROM aeroport WHERE nom = 'Aéroport d''Ivato') AND
--     aeroport_arrivee_id = (SELECT id FROM aeroport WHERE nom = 'Aéroport de Fascène')
-- );

-- -- Programmation des vols pour le 12 janvier 2024
-- INSERT INTO avion_vol (avion_id, vol_id, date_heure)
-- SELECT 
--     a.id,
--     v.id,
--     '2024-01-12 12:00:00+03'
-- FROM avion a, vol v
-- WHERE a.nom = 'Boeing 737-800' 
-- AND v.id = (SELECT id FROM vol WHERE aeroport_depart_id = 
--     (SELECT id FROM aeroport WHERE nom = 'Aéroport d''Ivato'))
-- ON CONFLICT DO NOTHING;

-- -- Ajouter d'autres vols autour de 12h
-- INSERT INTO avion_vol (avion_id, vol_id, date_heure)
-- SELECT 
--     a.id,
--     v.id,
--     '2024-01-12 11:30:00+03'
-- FROM avion a, vol v
-- WHERE a.nom = 'Airbus A320-200' 
-- AND v.id = (SELECT id FROM vol WHERE aeroport_depart_id = 
--     (SELECT id FROM aeroport WHERE nom = 'Aéroport d''Ivato'))
-- ON CONFLICT DO NOTHING;

-- INSERT INTO avion_vol (avion_id, vol_id, date_heure)
-- SELECT 
--     a.id,
--     v.id,
--     '2024-01-12 13:15:00+03'
-- FROM avion a, vol v
-- WHERE a.nom = 'ATR 72-600' 
-- AND v.id = (SELECT id FROM vol WHERE aeroport_depart_id = 
--     (SELECT id FROM aeroport WHERE nom = 'Aéroport d''Ivato'))
-- ON CONFLICT DO NOTHING;

-- -- Insérer des vols programmés avec différentes dates
-- INSERT INTO avion_vol (avion_id, vol_id, date_heure)
-- SELECT 
--     a.id,
--     v.id,
--     CASE 
--         WHEN a.modele = 'A320' THEN NOW() + INTERVAL '1 day'
--         WHEN a.modele = 'B737' THEN NOW() + INTERVAL '2 days'
--         WHEN a.modele = 'ATR72' THEN NOW() + INTERVAL '3 days'
--         WHEN a.modele = 'A330' THEN NOW() + INTERVAL '4 days'
--         ELSE NOW() + INTERVAL '5 days'
--     END
-- FROM avion a
-- CROSS JOIN vol v
-- WHERE NOT EXISTS (
--     SELECT 1 FROM avion_vol av2 
--     WHERE av2.avion_id = a.id 
--     AND av2.vol_id = v.id
--     AND av2.date_heure = CASE 
--         WHEN a.modele = 'A320' THEN NOW() + INTERVAL '1 day'
--         WHEN a.modele = 'B737' THEN NOW() + INTERVAL '2 days'
--         WHEN a.modele = 'ATR72' THEN NOW() + INTERVAL '3 days'
--         WHEN a.modele = 'A330' THEN NOW() + INTERVAL '4 days'
--         ELSE NOW() + INTERVAL '5 days'
--     END
-- )
-- LIMIT 10;

-- Vérifier les vols insérés
-- SELECT 
--     av.id,
--     av.date_heure,
--     a.nom as avion,
--     a.modele,
--     ad.nom as depart,
--     aa.nom as arrivee
-- FROM avion_vol av
-- JOIN avion a ON av.avion_id = a.id
-- JOIN vol v ON av.vol_id = v.id
-- JOIN aeroport ad ON v.aeroport_depart_id = ad.id
-- JOIN aeroport aa ON v.aeroport_arrivee_id = aa.id
-- WHERE av.date_heure >= NOW()
-- ORDER BY av.date_heure;