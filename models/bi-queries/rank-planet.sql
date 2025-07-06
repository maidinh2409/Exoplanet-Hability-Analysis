with 

earth_sim as (
    select
        planet_id,
        planet_name,
        round(t_eq - 273.15, 2) AS t_eq,
        round(density,2) as density,
        cast(period as integer) as period,
        habitable_score,
        round(esi * 100, 1) as earth_similarity_score
    from {{ref('fact_nasa_planet')}}
    
),

rank_table as (
    select
        *,
        DENSE_RANK() OVER(ORDER BY habitable_score desc, earth_similarity_score desc) as habitability_ranking
    from earth_sim
)

select
    *
from rank_table
where habitability_ranking <= 10
order by habitability_ranking