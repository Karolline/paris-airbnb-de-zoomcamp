-- Reviews staging model
-- This model processes raw review data from the 'Reviews.csv' file,
-- converting it into a clean and standardized format.

SELECT
    CAST(listing_id AS INT) AS room_id,
    CAST(review_id AS INT) AS review_id,
    CAST(date AS DATE) AS review_date,
    CAST(reviewer_id AS INT) AS reviewer_id
FROM
    {{ source("datalake", "reviews") }}