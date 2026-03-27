with rooms as (
    select * from {{ ref("stg_room") }}
)

select 
    *
from rooms
where city = 'Paris' 