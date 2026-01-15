-- ============================================================
-- Création de la base et du schéma PostgreSQL
-- ============================================================

CREATE DATABASE compagnie_aerienne;
\c compagnie_aerienne;

-- CREATE SCHEMA IF NOT EXISTS public;

-- =======================
-- Table AEROPORT
-- =======================
CREATE TABLE aeroport (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    ville VARCHAR(100) NOT NULL,
    CONSTRAINT aeroport_unique UNIQUE (nom, ville)
);

-- =======================
-- Table AVION
-- =======================
CREATE TABLE avion (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    modele VARCHAR(100) NOT NULL,
    capacite INTEGER NOT NULL CHECK (capacite > 0)
);

-- =======================
-- Table VOL
-- =======================
CREATE TABLE vol (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    aeroport_depart_id INTEGER NOT NULL,
    aeroport_arrivee_id INTEGER NOT NULL,

    CONSTRAINT fk_vol_aeroport_depart
        FOREIGN KEY (aeroport_depart_id)
        REFERENCES aeroport (id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_vol_aeroport_arrivee
        FOREIGN KEY (aeroport_arrivee_id)
        REFERENCES aeroport (id)
        ON DELETE RESTRICT,

    CONSTRAINT vol_aeroport_diff CHECK (aeroport_depart_id <> aeroport_arrivee_id)
);

-- =======================
-- Table AVION_VOL (vol programmé à date/heure)
-- =======================
CREATE TABLE avion_vol (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    avion_id INTEGER NOT NULL,
    vol_id INTEGER NOT NULL,
    date_heure TIMESTAMPTZ NOT NULL,

    CONSTRAINT fk_avionvol_avion
        FOREIGN KEY (avion_id)
        REFERENCES avion (id)
        ON DELETE CASCADE,

    CONSTRAINT fk_avionvol_vol
        FOREIGN KEY (vol_id)
        REFERENCES vol (id)
        ON DELETE CASCADE,

    CONSTRAINT avion_vol_unique UNIQUE (avion_id, vol_id, date_heure)
);

-- =======================
-- Table CLIENT
-- =======================
CREATE TABLE client (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom VARCHAR(150) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE
);

-- =======================
-- Table RESERVATION
-- =======================
CREATE TABLE reservation (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    avion_vol_id INTEGER NOT NULL,
    client_id INTEGER NOT NULL,
    nb_places INTEGER NOT NULL CHECK (nb_places > 0),

    CONSTRAINT fk_res_avionvol
        FOREIGN KEY (avion_vol_id)
        REFERENCES avion_vol (id)
        ON DELETE CASCADE,

    CONSTRAINT fk_res_client
        FOREIGN KEY (client_id)
        REFERENCES client (id)
        ON DELETE CASCADE
);
--table Place 
CREATE TABLE place (
    id_place INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    type VARCHAR(20) NOT NULL UNIQUE
);
--table avion-place
CREATE TABLE avion_place (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_avion INTEGER NOT NULL,
    id_place INTEGER NOT NULL,
    nombre INTEGER NOT NULL CHECK (nombre >= 0),

    CONSTRAINT fk_ap_avion
        FOREIGN KEY (id_avion)
        REFERENCES avion (id)
        ON DELETE CASCADE,

    CONSTRAINT fk_ap_place
        FOREIGN KEY (id_place)
        REFERENCES place (id_place)
        ON DELETE CASCADE,

    CONSTRAINT avion_place_unique UNIQUE (id_avion, id_place)
);
-- table prix-vol
CREATE TABLE prix_vol (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_avion_vol INTEGER NOT NULL,
    id_place INTEGER NOT NULL,
    prix NUMERIC(12,2) NOT NULL CHECK (prix > 0),

    CONSTRAINT fk_pv_avionvol
        FOREIGN KEY (id_avion_vol)
        REFERENCES avion_vol (id)
        ON DELETE CASCADE,

    CONSTRAINT fk_pv_place
        FOREIGN KEY (id_place)
        REFERENCES place (id_place)
        ON DELETE CASCADE,

    CONSTRAINT prix_vol_unique UNIQUE (id_avion_vol, id_place)
);

-- =======================
-- Index utiles (PostgreSQL)
-- =======================
CREATE INDEX idx_vol_aeroports ON vol(aeroport_depart_id, aeroport_arrivee_id);
CREATE INDEX idx_avionvol_date ON avion_vol(date_heure);
CREATE INDEX idx_reservation_client ON reservation(client_id);

ALTER TABLE vol ADD COLUMN prix DECIMAL(10,2) NOT NULL DEFAULT 0.00;

-- Ajouter une colonne prix_total à la table reservation
ALTER TABLE reservation ADD COLUMN prix_total DECIMAL(10,2) NOT NULL DEFAULT 0.00;

-- Mettre à jour les prix existants (exemple)
UPDATE vol SET prix = 250000.00 WHERE id = 1;
UPDATE vol SET prix = 300000.00 WHERE id = 2;
UPDATE vol SET prix = 200000.00 WHERE id = 3;