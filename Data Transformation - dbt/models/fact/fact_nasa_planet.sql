with

join_table_hwc as (
    select
        nasa.*,
        2 * ifnull(hwc.P_HABITABLE, 0) as P_HABITABLE
    from {{ref("dim_nasa_planet")}} as nasa
    left join {{ref("raw_hwc")}} as hwc 
    on hwc.planet_id = nasa.planet_id
),

join_table_hz as (
    select
        nasa.*,
        ifnull(hz.isHabitable, 0) as isHabitable_hz
    from join_table_hwc as nasa
    left join {{ref("dim_hzgallery")}} as hz
    on hz.planet_id_without_star = nasa.planet_id_without_star
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
        isHabitable_hz as hzgallery_habitable_score,
        P_HABITABLE as hwc_habitable_score,
        round((isHabitable_hz + P_HABITABLE)/3, 3) as habitable_score
    from join_table_hz
)

select 
    *
from aggregate_cols
order by habitable_score desc
