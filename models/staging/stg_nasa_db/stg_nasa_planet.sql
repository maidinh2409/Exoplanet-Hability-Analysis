with

/* Join host_star with planet table */
source as (
    select
        nasa.planet_id,
        nasa.planet_id_without_star,
        nasa.pl_name as planet_name,
        nasa.st_age as age,
        hoststar.star_id,
        detection.detection_id, 
        nasa.pl_masse as mass,
        nasa.pl_rade as radius,
        nasa.pl_dens as density,
        nasa.pl_eqt as t_eq,
        nasa.pl_insol as flux,
        nasa.pl_orbsmax as distance_to_star,
        nasa.pl_orbper as period,
        cast(null as INTEGER) as isHabitable
    from {{ref("raw_nasa_db")}} as nasa
    left join {{ref("stg_nasa_host_star")}} as hoststar on hoststar.star_id = nasa.star_id
    left join {{ref("stg_nasa_detection_fact")}} as detection on detection.detection_id = nasa.detection_id
),

/*Compute mean value for age column to fill null values */
mean_val as (
    select
        avg(age) as mean_age,
        avg(mass) as mean_mass,
        avg(radius) as mean_radius,
        avg(density) as mean_density,
        avg(t_eq) as mean_t_eq,
        avg(flux) as mean_flux,
        avg(distance_to_star) as mean_distance,
        avg(period) as mean_period
    from source
),



/*Fill null values of age column with mean */
fill_null_age as (
    select
        s.planet_id, 
        s.planet_id_without_star,
        s.planet_name,
        ifnull(s.age, m.mean_age) as age,
        ifnull(s.star_id, 'NOT FOUND') as star_id,
        s.detection_id,
        ifnull(s.mass, m.mean_mass) as mass,
        ifnull(s.radius, m.mean_radius) as radius,
        ifnull(s.density, m.mean_density) as density,
        ifnull(s.t_eq, m.mean_t_eq) as t_eq,
        ifnull(s.flux, m.mean_flux) as flux,
        ifnull(s.distance_to_star, m.mean_distance) as distance_to_star,
        ifnull(s.period, m.mean_period) as period,
        ifnull(s.isHabitable, 0) AS isHabitable
    from source as s
    cross join mean_val as m
)

/*Final transformation */
select 
    *
from fill_null_age