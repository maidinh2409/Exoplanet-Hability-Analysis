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
)

select
    *
from join_table_hz