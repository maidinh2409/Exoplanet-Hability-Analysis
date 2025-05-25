with 

source as (
    select distinct
        CONCAT(
            UPPER(REPLACE(s.disc_facility, ' ', '')), 
            UPPER(REPLACE(s.disc_locale, ' ', ''))
        ) as facility_id,
        s.disc_facility as facility_name,
        s.disc_locale as location
    from {{ref("nasa")}} as s

)

select
    *
from source