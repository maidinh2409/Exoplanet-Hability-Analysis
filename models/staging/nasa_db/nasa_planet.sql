with

/* Join host_star with planet table */
source as (
    select
        nasa.planet_id,
        nasa.pl_name as planet_name,
        nasa.st_age as age,
        nasa.star_id,
        nasa.detection_id, 
        cast(null as boolean) as isHabitable
    from {{ref("nasa")}} as nasa
    full outer join {{ref("nasa_host_star")}} as hoststar on hoststar.star_id = nasa.star_id
),

/*Compute mean value for age column to fill null values */
mean_val as (
    select
        avg(age) as mean_age
    from source
),

/*Fill null values of age column with mean */
fill_null_age as (
    select
        s.planet_id, 
        s.planet_name,
        ifnull(s.age, m.mean_age) as age,
        s.star_id,
        s.detection_id,
        s.isHabitable
    from source as s
    cross join mean_val as m
)

/*Final transformation */
select 
    *
from fill_null_age