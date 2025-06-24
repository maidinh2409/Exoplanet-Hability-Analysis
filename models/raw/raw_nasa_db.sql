with distinct_val as (
    select distinct *
    from `asteroid-db-456716.exoplanet_habitability_db.nasa_exoplanet_pl`
),

spectype_cleaned as (
    select 
        *,
        case 
            when st_spectype like '% %' then replace(st_spectype, ' ', '')
            when st_spectype is null then ''
            else st_spectype
        end as spectype
    from distinct_val
)

select
    concat(
        UPPER(replace(replace(replace(pl_name, '+', ''), '-',''), ' ', '')), 
        UPPER(replace(replace(replace(hostname, '+', ''), '-',''), ' ', ''))
    ) as planet_id,

    UPPER(replace(replace(replace(pl_name, '+', ''), '-',''), ' ', '')) as planet_id_without_star,

    CONCAT(
            UPPER(REPLACE(disc_facility, ' ', '')), 
            UPPER(REPLACE(disc_locale, ' ', ''))
        ) as facility_id,

    concat(
        UPPER(replace(hostname, ' ', '')), 
        UPPER(spectype)
    ) as star_id,

    UPPER(concat(
        replace(pl_name, ' ', ''), 
        replace(disc_facility, ' ', ''),
        disc_year
    )) as detection_id,

    *
from spectype_cleaned
