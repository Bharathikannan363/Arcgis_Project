-- ===================================================
-- ONE-TIME SETUP
-- ============================================================

-- Allow delivery_route to store both POINT and LINESTRING
ALTER TABLE delivery_route
ALTER COLUMN route TYPE geometry(Geometry, 4326);

-- Add temporary result columns
ALTER TABLE delivery_route
ADD COLUMN IF NOT EXISTS volunteer_id INT,
ADD COLUMN IF NOT EXISTS result_type VARCHAR(50),
ADD COLUMN IF NOT EXISTS distance_km NUMERIC(10,2),
ADD COLUMN IF NOT EXISTS result_value NUMERIC;


-- ============================================================
-- QUERY 1
-- Show all donor locations
-- ============================================================

INSERT INTO delivery_route
(
    donor_id,
    route,
    result_type
)
SELECT
    donor_id,
    location,
    'DONOR_LOCATION'
FROM donor;

TRUNCATE TABLE delivery_route;


-- ============================================================
-- QUERY 2
-- Show all NGO locations
-- ============================================================

INSERT INTO delivery_route
(
    ngo_id,
    route,
    result_type
)
SELECT
    ngo_id,
    location,
    'NGO_LOCATION'
FROM ngo;

TRUNCATE TABLE delivery_route;


-- ============================================================
-- QUERY 3
-- Show all volunteer locations
-- ============================================================

INSERT INTO delivery_route
(
    volunteer_id,
    route,
    result_type
)
SELECT
    volunteer_id,
    location,
    'VOLUNTEER_LOCATION'
FROM volunteer;

TRUNCATE TABLE delivery_route;


-- ============================================================
-- QUERY 4
-- Calculate distance between Donor 1 and all NGOs
-- ============================================================

INSERT INTO delivery_route
(
    donor_id,
    ngo_id,
    route,
    result_type,
    distance_km
)
SELECT
    d.donor_id,
    n.ngo_id,

    ST_MakeLine(
        d.location,
        n.location
    ),

    'DONOR_TO_NGO_DISTANCE',

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                n.location
            ) / 1000
        )::numeric,
        2
    )

FROM donor d
CROSS JOIN ngo n

WHERE d.donor_id = 1;

-- Delete Query 4 result

TRUNCATE TABLE delivery_route;


-- ============================================================
-- QUERY 5
-- Find nearest NGO to Donor 1
-- ============================================================

INSERT INTO delivery_route
(
    donor_id,
    ngo_id,
    route,
    result_type,
    distance_km
)
SELECT
    d.donor_id,
    n.ngo_id,

    ST_MakeLine(
        d.location,
        n.location
    ),

    'NEAREST_NGO',

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                n.location
            ) / 1000
        )::numeric,
        2
    )

FROM donor d

CROSS JOIN LATERAL
(
    SELECT
        ngo_id,
        name,
        location
    FROM ngo

    ORDER BY
        d.location <-> ngo.location

    LIMIT 1
) n

WHERE d.donor_id = 1;


TRUNCATE TABLE delivery_route;


-- ============================================================
-- QUERY 6
-- Find NGOs within 5 KM of Donor 1
-- ============================================================

INSERT INTO delivery_route
(
    donor_id,
    ngo_id,
    route,
    result_type,
    distance_km
)
SELECT
    d.donor_id,
    n.ngo_id,

    ST_MakeLine(
        d.location,
        n.location
    ),

    'NGO_WITHIN_5KM',

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                n.location
            ) / 1000
        )::numeric,
        2
    )

FROM donor d

JOIN ngo n

ON ST_DWithin(
    d.location::geography,
    n.location::geography,
    5000
)

WHERE d.donor_id = 1;

-- Delete Query 6 result

TRUNCATE TABLE delivery_route;


-- ============================================================
-- QUERY 7
-- Find nearest volunteer to Donor 1
-- ============================================================

INSERT INTO delivery_route
(
    donor_id,
    volunteer_id,
    route,
    result_type,
    distance_km
)
SELECT
    d.donor_id,
    v.volunteer_id,

    ST_MakeLine(
        d.location,
        v.location
    ),

    'NEAREST_VOLUNTEER',

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                v.location
            ) / 1000
        )::numeric,
        2
    )

FROM donor d

CROSS JOIN LATERAL
(
    SELECT
        volunteer_id,
        name,
        location
    FROM volunteer

    ORDER BY
        d.location <-> volunteer.location

    LIMIT 1
) v

WHERE d.donor_id = 1;

-- Delete Query 7 result

TRUNCATE TABLE delivery_route;


-- ============================================================
-- QUERY 8
-- Find volunteers within 5 KM of Donor 1
-- ============================================================

INSERT INTO delivery_route
(
    donor_id,
    volunteer_id,
    route,
    result_type,
    distance_km
)
SELECT
    d.donor_id,
    v.volunteer_id,

    ST_MakeLine(
        d.location,
        v.location
    ),

    'VOLUNTEER_WITHIN_5KM',

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                v.location
            ) / 1000
        )::numeric,
        2
    )

FROM donor d

JOIN volunteer v

ON ST_DWithin(
    d.location::geography,
    v.location::geography,
    5000
)

WHERE d.donor_id = 1;

-- Delete Query 8 result

TRUNCATE TABLE delivery_route;


-- ============================================================
-- QUERY 9
-- Find nearest NGO for every donor
-- ============================================================

INSERT INTO delivery_route
(
    donor_id,
    ngo_id,
    route,
    result_type,
    distance_km
)
SELECT
    d.donor_id,
    n.ngo_id,

    ST_MakeLine(
        d.location,
        n.location
    ),

    'NEAREST_NGO_EVERY_DONOR',

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                n.location
            ) / 1000
        )::numeric,
        2
    )

FROM donor d

CROSS JOIN LATERAL
(
    SELECT
        ngo_id,
        name,
        location
    FROM ngo

    ORDER BY
        d.location <-> ngo.location

    LIMIT 1
) n;
-- Delete Query 9 result

TRUNCATE TABLE delivery_route;


-- ============================================================
-- QUERY 10
-- Count spatial objects
-- ============================================================

INSERT INTO delivery_route
(
    result_type,
    result_value
)
SELECT
    'TOTAL_DONORS',
    COUNT(*)
FROM donor;


INSERT INTO delivery_route
(
    result_type,
    result_value
)
SELECT
    'TOTAL_NGOS',
    COUNT(*)
FROM ngo;


INSERT INTO delivery_route
(
    result_type,
    result_value
)
SELECT
    'TOTAL_VOLUNTEERS',
    COUNT(*)
FROM volunteer;


INSERT INTO delivery_route
(
    result_type,
    result_value
)
SELECT
    'TOTAL_ADMINS',
    COUNT(*)
FROM admin;


-- View Query 10 result

SELECT
    result_type,
    result_value
FROM delivery_route;


TRUNCATE TABLE delivery_route;
