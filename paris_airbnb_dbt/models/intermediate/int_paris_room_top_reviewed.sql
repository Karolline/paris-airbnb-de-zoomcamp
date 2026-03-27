WITH
  room_review_counts AS (
    SELECT
      rr.room_id,
      COUNT(rr.review_id) AS review_count
    FROM
      {{ ref('stg_review') }} AS rr
      INNER JOIN {{ ref('int_paris_room') }} AS rp ON rr.room_id = rp.room_id
    GROUP BY
      rr.room_id
  )
SELECT
  room_id,
  review_count
FROM
  room_review_counts
ORDER BY
  review_count DESC, room_id ASC
LIMIT 20
