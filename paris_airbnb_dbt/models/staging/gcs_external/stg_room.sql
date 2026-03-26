-- Properties staging model
-- This model processes raw room data from the 'Listings.csv' file,
-- converting it INT64o a clean and standardized format.

SELECT
    -- 1. Identifiers
    CAST(listing_id AS INT64) AS room_id,
    CAST(host_id AS INT64) AS host_id,

    -- 2. Location
    CAST(city AS STRING) AS city,
    CAST(district AS STRING) AS district,
    CAST(neighbourhood AS STRING) AS neighbourhood,
    CAST(latitude AS NUMERIC) AS latitude,
    CAST(longitude AS NUMERIC) AS longitude,
    
    -- 3. Room Info
    REGEXP_REPLACE(name, r"[^a-zA-Z0-9.,!\- ]", "") AS room_name,
    CAST(property_type AS STRING) AS property_type,
    CAST(room_type AS STRING) AS room_type,
    CAST(amenities AS STRING) AS amenities,
    CAST(accommodates AS INT64) AS accommodates,
    CAST(bedrooms AS INT64) AS bedrooms,
    CAST(price AS NUMERIC) AS price,

    -- 4.Host Info
    CAST(host_location AS STRING) AS host_location,
    CAST(host_since AS DATE) AS host_since,
    CASE WHEN host_is_superhost = 't' THEN TRUE ELSE FALSE END AS host_is_superhost,
    CASE WHEN host_has_profile_pic = 't' THEN TRUE ELSE FALSE END AS host_has_profile_pic,
    CASE WHEN host_identity_verified = 't' THEN TRUE ELSE FALSE END AS host_identity_verified,
    CAST(host_response_time AS STRING) AS host_response_time,
    CAST(host_response_rate AS FLOAT64) AS host_response_rate,
    CAST(host_acceptance_rate AS FLOAT64) AS host_acceptance_rate,
    CAST(host_total_listings_count AS INT64) AS host_total_listings_count,

    -- 5.Policies
    CAST(minimum_nights AS INT64) AS minimum_nights,
    CAST(maximum_nights AS INT64) AS maximum_nights,
    CASE WHEN instant_bookable = 't' THEN TRUE ELSE FALSE END AS instant_bookable,
    
    -- 6. Reviews
    CAST(review_scores_rating AS FLOAT64) AS review_scores_rating,
    CAST(review_scores_accuracy AS FLOAT64) AS review_scores_accuracy,
    CAST(review_scores_cleanliness AS FLOAT64) AS review_scores_cleanliness,
    CAST(review_scores_checkin AS FLOAT64) AS review_scores_checkin,
    CAST(review_scores_communication AS FLOAT64) AS review_scores_communication,
    CAST(review_scores_location AS FLOAT64) AS review_scores_location,
    CAST(review_scores_value AS FLOAT64) AS review_scores_value
    
FROM
    {{ source("datalake", "listings") }}