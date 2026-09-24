-- ============================================
-- FOOD RESCUE SPATIAL DATABASE
-- PostgreSQL + PostGIS
-- ============================================

-- Enable PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;


-- ============================================
-- ADMIN TABLE
-- ============================================

CREATE TABLE admin (
    admin_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100),
    location GEOMETRY(Point, 4326)
);


-- ============================================
-- DONOR TABLE
-- ============================================

CREATE TABLE donor (
    donor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    donor_type VARCHAR(50),
    phone VARCHAR(20),
    address VARCHAR(200),
    location GEOMETRY(Point, 4326)
);


-- ============================================
-- NGO TABLE
-- ============================================

CREATE TABLE ngo (
    ngo_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200),
    location GEOMETRY(Point, 4326)
);


-- ============================================
-- VOLUNTEER TABLE
-- ============================================

CREATE TABLE volunteer (
    volunteer_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(200),
    location GEOMETRY(Point, 4326)
);


-- ============================================
-- DONATION TABLE
-- ============================================

CREATE TABLE donation (
    donation_id SERIAL PRIMARY KEY,

    donor_id INTEGER REFERENCES donor(donor_id),

    food_type VARCHAR(100),
    quantity_kg NUMERIC(10,2),

    status VARCHAR(30) DEFAULT 'Available',

    donation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================
-- ASSIGNMENT TABLE
-- ============================================

CREATE TABLE assignment (
    assignment_id SERIAL PRIMARY KEY,

    donation_id INTEGER REFERENCES donation(donation_id),

    ngo_id INTEGER REFERENCES ngo(ngo_id),

    volunteer_id INTEGER REFERENCES volunteer(volunteer_id),

    status VARCHAR(30) DEFAULT 'Pending',

    assigned_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================
-- SPATIAL INDEXES
-- ============================================

CREATE INDEX idx_admin_location
ON admin USING GIST(location);

CREATE INDEX idx_donor_location
ON donor USING GIST(location);

CREATE INDEX idx_ngo_location
ON ngo USING GIST(location);

CREATE INDEX idx_volunteer_location
ON volunteer USING GIST(location);


-- ============================================
-- CHECK TABLES
-- ============================================

\dt