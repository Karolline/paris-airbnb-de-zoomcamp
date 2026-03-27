with int_room_paris as (
    select * from {{ ref("int_room_paris") }}
)

select 
    neighbourhood,
    room_type,
    count(room_id) as room_count
from int_room_paris
group by neighbourhood, room_type