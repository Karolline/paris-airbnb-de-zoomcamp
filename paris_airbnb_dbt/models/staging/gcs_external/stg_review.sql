-- Reviews staging model
-- This model processes raw review data from the 'Reviews.csv' file,
-- converting it into a clean and standardized format.

SELECT
    CAST(listing_id AS STRING) AS room_id,
    CAST(review_id AS STRING) AS review_id,
    CAST(reviewer_id AS STRING) AS reviewer_id,
    CAST(date AS DATE) AS review_date
FROM
    {{ source("datalake", "reviews") }}