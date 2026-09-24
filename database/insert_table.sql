-- ============================================
-- FOOD RESCUE SPATIAL DATABASE
-- DEMO DATA
-- ============================================


-- ============================================
-- 1 ADMIN
-- ============================================

INSERT INTO admin
(name, username, email, location)
VALUES
(
    'Food Rescue Admin',
    'admin01',
    'admin@foodrescue.com',
    ST_SetSRID(
        ST_MakePoint(80.2707, 13.0827),
        4326
    )
);


-- ============================================
-- 4 DONORS
-- ============================================

INSERT INTO donor
(name, donor_type, phone, address, location)
VALUES

(
    'Green Leaf Restaurant',
    'Restaurant',
    '9000000001',
    'Anna Nagar, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2090, 13.0850),
        4326
    )
),

(
    'City Star Hotel',
    'Hotel',
    '9000000002',
    'T Nagar, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2340, 13.0418),
        4326
    )
),

(
    'CEG College Canteen',
    'College Canteen',
    '9000000003',
    'Guindy, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2350, 13.0108),
        4326
    )
),

(
    'Royal Marriage Hall',
    'Event Hall',
    '9000000004',
    'Velachery, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2209, 12.9815),
        4326
    )
);


-- ============================================
-- 6 NGOs
-- ============================================

INSERT INTO ngo
(name, phone, address, location)
VALUES

(
    'Hope Food Foundation',
    '9100000001',
    'Nungambakkam, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2420, 13.0569),
        4326
    )
),

(
    'Helping Hands NGO',
    '9100000002',
    'Egmore, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2600, 13.0732),
        4326
    )
),

(
    'Food Care Trust',
    '9100000003',
    'Adyar, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2570, 13.0012),
        4326
    )
),

(
    'Aalam Care Foundation',
    '9100000004',
    'Saidapet, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2230, 13.0210),
        4326
    )
),

(
    'No Hunger Foundation',
    '9100000005',
    'Mylapore, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2676, 13.0339),
        4326
    )
),

(
    'Care & Share NGO',
    '9100000006',
    'Tambaram, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.1270, 12.9249),
        4326
    )
);


-- ============================================
-- 10 VOLUNTEERS
-- ============================================

INSERT INTO volunteer
(name, phone, address, location)
VALUES

(
    'Volunteer 01',
    '9200000001',
    'Anna Nagar, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2150, 13.0870),
        4326
    )
),

(
    'Volunteer 02',
    '9200000002',
    'Kilpauk, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2250, 13.0780),
        4326
    )
),

(
    'Volunteer 03',
    '9200000003',
    'Egmore, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2550, 13.0700),
        4326
    )
),

(
    'Volunteer 04',
    '9200000004',
    'Teynampet, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2500, 13.0400),
        4326
    )
),

(
    'Volunteer 05',
    '9200000005',
    'Guindy, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2200, 13.0100),
        4326
    )
),

(
    'Volunteer 06',
    '9200000006',
    'Adyar, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2550, 13.0050),
        4326
    )
),

(
    'Volunteer 07',
    '9200000007',
    'Velachery, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2150, 12.9800),
        4326
    )
),

(
    'Volunteer 08',
    '9200000008',
    'Saidapet, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2250, 13.0250),
        4326
    )
),

(
    'Volunteer 09',
    '9200000009',
    'Mylapore, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.2700, 13.0350),
        4326
    )
),

(
    'Volunteer 10',
    '9200000010',
    'Tambaram, Chennai',
    ST_SetSRID(
        ST_MakePoint(80.1250, 12.9250),
        4326
    )
);


-- ============================================
-- DONATIONS
-- ============================================

INSERT INTO donation
(donor_id, food_type, quantity_kg, status)
VALUES
(1, 'Cooked Rice and Curry', 30, 'Available'),
(2, 'Vegetable Rice', 40, 'Available'),
(3, 'Meals', 25, 'Available'),
(4, 'Biryani', 50, 'Available');


-- ============================================
-- CHECK DATA
-- ============================================

SELECT * FROM admin;

SELECT * FROM donor;

SELECT * FROM ngo;

SELECT * FROM volunteer;

SELECT * FROM donation;