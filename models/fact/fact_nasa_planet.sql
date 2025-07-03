with

join_table_hwc as (
    select
        nasa.*,
        ifnull(hwc.P_HABITABLE, 0) as P_HABITABLE
    from {{ref("dim_nasa_planet")}} as nasa
    left join {{ref("raw_hwc")}} as hwc 
    on hwc.planet_id = nasa.planet_id
),

join_table_hz as (
    select
        nasa.*,
        ifnull(hz.isHabitable, 0) as isHabitable_hz
    from join_table_hwc as nasa
    left join {{ref("stg_hzgallery")}} as hz
    on hz.planet_id_without_star = nasa.planet_id_without_star
    order by nasa.P_HABITABLE desc
),

aggregate_cols as (
    select
        planet_id,
        planet_id_without_star,
        planet_name,
        age,
        star_id,
        detection_id,
        mass,
        radius,
        density,
        t_eq,
        flux,
        distance_to_star,
        period,
        esi,
        case
            when (P_HABITABLE + isHabitable_hz) = 0 then 0
            when (P_HABITABLE + isHabitable_hz) = 1 then 1
            when P_HABITABLE = 1 AND isHabitable_hz = 1 then 1
            when P_HABITABLE = 2 AND isHabitable_hz = 0 then 2
            when P_HABITABLE = 2 AND isHabitable_hz = 1 then 3
        end as isHabitable
    from join_table_hz
)

select 
    *
from aggregate_cols
order by isHabitable desc
