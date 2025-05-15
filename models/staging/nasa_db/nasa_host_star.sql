with 
/* Standardize column name */
source as (
    select
        star_id,
        hostname as star_name,
        st_spectype as star_type,
        st_teff as temperature,
        st_rad as radius,
        st_mass as mass,
        st_met as metalicity,
        st_lum as luminosity
    from {{ref("nasa")}}
),

/* Split star_type into 3 subcolumns */
define_star_type as (
    select
        *,
        substring(source.star_type, 1, 1) as spectral_type, 
        upper(REGEXP_SUBSTR(star_type, '[A-Z a-z]+', 2)) as luminosity_class,
        REGEXP_SUBSTR(star_type, '[0-9 .]+', 2) as subclass
    from source
),

/* Remove rows that have all nulls */
filter_null as (
    select
        *
    from define_star_type
    where star_type IS NOT NULL
      AND star_name IS NOT NULL
      OR temperature IS NOT NULL
      OR radius IS NOT NULL
      OR mass IS NOT NULL
      OR luminosity IS NOT NULL
      OR spectral_type IS NOT NULL
      OR luminosity_class IS NOT NULL
      OR subclass IS NOT NULL
),

/*Calculate mean value for float columns */
mean_val as (
    select 
        AVG(temperature) as avg_temp,
        AVG(radius) as avg_radius,
        AVG(mass) as avg_mass,
        AVG(metalicity) as avg_metalicity,
        AVG(luminosity) as avg_luminosity
    from filter_null
),


/*Fill null values with mean val for float columns or None with String columns */
fill_null as (
    select
        filter_null.star_id,
        ifnull(star_type, "None") as star_type,
        ifnull(temperature, m.avg_temp) as temperature,
        ifnull(radius, m.avg_radius) as radius,
        ifnull(mass, m.avg_mass) as mass,
        ifnull(luminosity, m.avg_luminosity) as luminosity,
        ifnull(spectral_type, "None") as spectral_type,
        ifnull(luminosity_class, "None") as luminosity_class,
        ifnull(SAFE_CAST(subclass AS FLOAT64), 0) as subclass
    from filter_null
    cross join mean_val as m
)

/* Final transformation */
select 
    *
from fill_null
