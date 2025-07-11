with 

join_table as (
    select
        pl.planet_id,
        pl.planet_name,
        pl.mass,
        pl.radius,
        pl.density,
        pl.t_eq,
        pl.flux,
        pl.distance_to_star,
        pl.period,
        pl.esi,
        pl.habitable_score,
        star.star_name,
        star.temperature,
        star.radius as st_rad,
        star.mass as st_mass,
        star.metalicity as st_metalicity,
        star.luminosity as st_lum,
        star.spectral_type as st_spectral_type,
        star.subclass as st_subclass
    from {{ref('fact_nasa_planet')}} as pl
    left join {{ref('stg_nasa_host_star')}} as star
    on star.star_id = pl.star_id
)

select
    *
from join_table