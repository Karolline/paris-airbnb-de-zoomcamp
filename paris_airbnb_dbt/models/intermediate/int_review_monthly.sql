WITH
  daily_reviews AS (
    SELECT
      room_id,
      EXTRACT(YEAR FROM review_date) AS review_year,
      EXTRACT(MONTH FROM review_date) AS review_month,
      COUNT(review_id) AS monthly_review_count
    FROM
      {{ ref("stg_review") }}
    GROUP BY
      room_id,
      EXTRACT(YEAR FROM review_date),
      EXTRACT(MONTH FROM review_date)
  )
SELECT
  room_id,
  review_year,
  review_month,
  monthly_review_count
FROM
  daily_reviews
ORDER BY
  room_id,
  review_year,
  review_month
