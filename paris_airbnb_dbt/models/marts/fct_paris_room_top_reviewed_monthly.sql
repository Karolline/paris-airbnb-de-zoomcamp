WITH
  top_reviewed_rooms AS (
    SELECT
      room_id
    FROM
      {{ ref("int_paris_room_top_reviewed") }}
  ),
  room_details AS (
    SELECT
      t.room_id,
      r.room_name
    FROM
      top_reviewed_rooms AS t
      INNER JOIN {{ ref("int_paris_room") }} AS r ON t.room_id = r.room_id
  ),
  monthly_reviews AS (
    SELECT
      t.room_id,
      dr.review_year,
      dr.review_month,
      dr.monthly_review_count
    FROM
      top_reviewed_rooms AS t
      INNER JOIN {{ ref("int_review_monthly") }} AS dr ON t.room_id = dr.room_id
  )
SELECT
  rd.room_id,
  rd.room_name,
  mr.review_year,
  mr.review_month,
  mr.monthly_review_count
FROM
  room_details AS rd
  INNER JOIN monthly_reviews AS mr ON rd.room_id = mr.room_id
WHERE
  mr.review_year IN (2018, 2019, 2020)
ORDER BY
  rd.room_id,
  mr.review_year,
  mr.review_month
  