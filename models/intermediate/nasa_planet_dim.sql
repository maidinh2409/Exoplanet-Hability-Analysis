with

nasa_staging as (
    select
        *
    from {{ref("nasa_planet")}}

),

nasa_esi as (
    select
        *,
        1-sqrt(0.5 * (pow((flux - 1)/(flux + 1), 2)+ pow((radius - 1)/(radius + 1), 2)))  as `esi`
    from nasa_staging
)

select
    *
from nasa_esi
