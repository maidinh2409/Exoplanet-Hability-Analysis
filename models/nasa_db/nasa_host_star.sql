select
    GENERATE_UUID() as star_id,
    hostname as `star_name`,
    st_spectype as `star_type`, 
    st_teff as `temperature`,
    st_rad as `radius`,
    st_mass as `mass`,
    st_met as `metality`,
    st_lum as `luminosity`
from `asteroid-db-456716.exoplanet_habitability_db.nasa_exoplanet_pl`

