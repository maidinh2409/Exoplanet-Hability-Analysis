select 
    GENERATE_UUID() as `planet_id`,
    pl_name,
    st_age
from `asteroid-db-456716.exoplanet_habitability_db.nasa_exoplanet_pl`
