with

source as (
    select
        s.detection_id,
        f.facility_id,
        s.discoverymethod,
        s.disc_year
    from {{ref("raw_nasa_db")}} as s
    full outer join {{ref("stg_nasa_facility")}} as f
    on f.facility_id = s.facility_id
)

select 
    *
from source