with

distinct_val as (
    select distinct
        *
    from `asteroid-db-456716.exoplanet_habitability_db.hzgallery_db`

),

standardize_pl as (
    select
        UPPER(replace(replace(replace(PLANET, '+', ''), '-',''), ' ', '')) AS PLANET_ID_WITHOUT_STAR,
        *
    from distinct_val
)

select
    *
from standardize_pl