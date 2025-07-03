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
        UPPER(replace(replace(replace(ifnull(pl_name, ''), '+', ''), '-',''), ' ', '')), 
        UPPER(replace(replace(replace(ifnull(hostname, ''), '+', ''), '-',''), ' ', ''))
    ) as planet_id,

    UPPER(replace(replace(replace(ifnull(pl_name, ''), '+', ''), '-',''), ' ', '')) as planet_id_without_star,

    CONCAT(
            UPPER(REPLACE(ifnull(disc_facility, ''), ' ', '')), 
            UPPER(REPLACE(ifnull(disc_locale, ''), ' ', ''))
        ) as facility_id,

    concat(
        UPPER(replace(ifnull(hostname, ''), ' ', '')), 
        UPPER(ifnull(spectype, ''))
    ) as star_id,

    UPPER(concat(
        replace(ifnull(pl_name, ''), ' ', ''), 
        replace(ifnull(disc_facility, ''), ' ', ''),
        ifnull(disc_year, 0)
    )) as detection_id,

    *
from spectype_cleaned
