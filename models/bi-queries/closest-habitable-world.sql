with

join_table as (
    select
        r.*,
        host.star_id,
        host.star_name,
        round(3.26 * host.earth_to_system, 2) as light_year_distance
    from {{ref('rank-planet')}} as r
    left join {{ref('fact_nasa_planet')}} as pl
    on r.planet_id = pl.planet_id
    left join {{ref('stg_nasa_host_star')}} as host
    on pl.star_id = host.star_id
),

rank_distance as (
    select
        planet_name,
        light_year_distance,
        DENSE_RANK() over (order by light_year_distance asc, habitability_ranking asc) as distance_rank
    from join_table
)

select 
    planet_name,
    light_year_distance
from rank_distance
where distance_rank = 1