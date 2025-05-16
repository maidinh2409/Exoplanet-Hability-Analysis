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
        replace(pl_name, ' ', ''), 
        replace(hostname, ' ', '')
    ) as planet_id,

    concat(
        'FET', 
        replace(pl_name, ' ', ''), 
        replace(hostname, ' ', '')
    ) as feature_id,

    concat(
        replace(hostname, ' ', ''), 
        spectype
    ) as star_id,

    concat(
        replace(pl_name, ' ', ''), 
        replace(disc_facility, ' ', '')
    ) as detection_id,

    *
from spectype_cleaned
