with 

source as (
    select
        *
    from {{ref("raw_hzgallery")}}
),

habit_column as (
    select
        *,
        cast(null as boolean) as isHabitable_null
    from source
),

fill_null as(
    select
        *,
        ifnull(isHabitable_null, true) AS isHabitable
    from habit_column
)

select
    *
from fill_null