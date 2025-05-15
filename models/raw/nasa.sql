with distinct_val as (
    select distinct
        *
    from `asteroid-db-456716.exoplanet_habitability_db.nasa_exoplanet_pl`
)
select 
    GENERATE_UUID() as planet_id,
    GENERATE_UUID() as feature_id,
    GENERATE_UUID() as star_id,
    GENERATE_UUID() as detection_id,
    GENERATE_UUID() as facility_id,
    *
from distinct_val