with

distinct_val as (
    select distinct
        *
    from `asteroid-db-456716.exoplanet_habitability_db.hwc_data`

),

id_tb as (
    select 
        *,
        concat(
            UPPER(replace(replace(replace(P_NAME, '+', ''), '-',''), ' ', '')), 
            UPPER(replace(replace(replace(S_NAME, '+', ''), '-',''), ' ', ''))
    ) as planet_id
    from distinct_val
)

select
    *
from id_tb