with room as (
    select * from {{ ref("stg_room") }}
)

select 
    *
from room
where city = 'Paris' 