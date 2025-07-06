with 
/* Standardize column name */
source as (
    select
        star_id,
        hostname as star_name,
        sy_dist as earth_to_system,
        st_spectype as star_type,
        st_teff as temperature,
        st_rad as radius,
        st_mass as mass,
        st_met as metalicity,
        st_lum as luminosity
    from {{ref("raw_nasa_db")}}
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
        AVG(luminosity) as avg_luminosity,
        AVG(earth_to_system) as avg_earth_to_system
    from filter_null
),


/*Fill null values with mean val for float columns or None with String columns */
fill_null as (
    select
        filter_null.star_id,
        filter_null.star_name,
        ifnull(earth_to_system, m.avg_earth_to_system) as earth_to_system,
        ifnull(temperature, m.avg_temp) as temperature,
        ifnull(radius, m.avg_radius) as radius,
        ifnull(mass, m.avg_mass) as mass,
        ifnull(metalicity, m.avg_metalicity) as metalicity,
        ifnull(luminosity, m.avg_luminosity) as luminosity,
        ifnull(spectral_type, "None") as spectral_type,
        ifnull(luminosity_class, "None") as luminosity_class,
        ifnull(SAFE_CAST(subclass AS FLOAT64), 0) as subclass
    from filter_null
    cross join mean_val as m
),

row_number_table as (
    select
        *,
        row_number() over (partition by star_id order by radius) as row_number
    from fill_null
)

select 
    star_id,
    star_name,
    earth_to_system,
    temperature,
    radius,
    mass,
    metalicity,
    luminosity,
    spectral_type,
    luminosity_class, 
    subclass
from row_number_table
where row_number = 1
