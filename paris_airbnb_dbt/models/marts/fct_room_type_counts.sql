with int_room_st_laurent as (
    select * from {{ ref("int_room_st_laurent") }}
)

select 
    room_type,
    count(room_id) as room_count
from int_room_st_laurent
group by room_type