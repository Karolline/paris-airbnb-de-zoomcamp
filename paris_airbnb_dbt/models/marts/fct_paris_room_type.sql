with int_paris_room as (
    select * from {{ ref("int_paris_room") }}
)

select 
    neighbourhood,
    room_type,
    count(room_id) as room_count
from int_paris_room
group by neighbourhood, room_type