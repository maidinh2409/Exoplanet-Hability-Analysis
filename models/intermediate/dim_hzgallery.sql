with

source as (
    select 
        *
    from {{ref('raw_hzgallery')}} as hz
),

filter_thzo as (
    select
        *,
        case 
            when THZO = 100 then 2
            when THZO < 100 and THZO > 0 then 1
            when THZO = 0 then 0
        end as isHabitable
    from source
)

select
    *
from filter_thzo