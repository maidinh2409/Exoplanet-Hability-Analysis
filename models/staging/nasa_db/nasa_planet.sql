with

source as (
    select
        nasa.planet_id,
        nasa.pl_name as planet_name,
        nasa.st_age as age,
        hoststar.star_id,
        nasa.detection_id, 
        cast(null as boolean) as isHabitable
    from {{ref("nasa")}} as nasa
    full outer join {{ref("nasa_host_star")}} as hoststar on hoststar.star_id = nasa.star_id
)

select 
    *
from source