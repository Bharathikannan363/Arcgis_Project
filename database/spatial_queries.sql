-- ============================================
-- FOOD RESCUE SPATIAL QUERIES
-- PostgreSQL + PostGIS
-- ============================================


-- ============================================
-- QUERY 1
-- Show all donor locations
-- ============================================

SELECT
    donor_id,
    name,
    ST_AsText(location) AS location
FROM donor;


-- ============================================
-- QUERY 2
-- Show all NGO locations
-- ============================================

SELECT
    ngo_id,
    name,
    ST_AsText(location) AS location
FROM ngo;


-- ============================================
-- QUERY 3
-- Show all volunteer locations
-- ============================================

SELECT
    volunteer_id,
    name,
    ST_AsText(location) AS location
FROM volunteer;


-- ============================================
-- QUERY 4
-- Calculate distance between Donor 1
-- and all NGOs
-- ============================================

SELECT
    d.name AS donor,
    n.name AS ngo,

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                n.location
            ) / 1000
        )::numeric,
        2
    ) AS distance_km

FROM donor d
CROSS JOIN ngo n

WHERE d.donor_id = 1

ORDER BY distance_km;


-- ============================================
-- QUERY 5
-- Find nearest NGO to Donor 1
-- ============================================

SELECT
    d.name AS donor,
    n.name AS nearest_ngo,

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                n.location
            ) / 1000
        )::numeric,
        2
    ) AS distance_km

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


-- ============================================
-- QUERY 6
-- Find NGOs within 5 KM of Donor 1
-- ============================================

SELECT
    d.name AS donor,
    n.name AS ngo,

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                n.location
            ) / 1000
        )::numeric,
        2
    ) AS distance_km

FROM donor d
JOIN ngo n
ON ST_DWithin(
    d.location::geography,
    n.location::geography,
    5000
)

WHERE d.donor_id = 1

ORDER BY distance_km;


-- ============================================
-- QUERY 7
-- Find nearest volunteer to Donor 1
-- ============================================

SELECT
    d.name AS donor,
    v.name AS nearest_volunteer,

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                v.location
            ) / 1000
        )::numeric,
        2
    ) AS distance_km

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


-- ============================================
-- QUERY 8
-- Find volunteers within 5 KM of Donor 1
-- ============================================

SELECT
    d.name AS donor,
    v.name AS volunteer,

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                v.location
            ) / 1000
        )::numeric,
        2
    ) AS distance_km

FROM donor d
JOIN volunteer v

ON ST_DWithin(
    d.location::geography,
    v.location::geography,
    5000
)

WHERE d.donor_id = 1

ORDER BY distance_km;


-- ============================================
-- QUERY 9
-- Find the nearest NGO for every donor
-- ============================================

SELECT
    d.name AS donor,
    n.name AS nearest_ngo,

    ROUND(
        (
            ST_DistanceSphere(
                d.location,
                n.location
            ) / 1000
        )::numeric,
        2
    ) AS distance_km

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


-- ============================================
-- QUERY 10
-- Count spatial objects
-- ============================================

SELECT
    (SELECT COUNT(*) FROM donor) AS total_donors,
    (SELECT COUNT(*) FROM ngo) AS total_ngos,
    (SELECT COUNT(*) FROM volunteer) AS total_volunteers,
    (SELECT COUNT(*) FROM admin) AS total_admins;