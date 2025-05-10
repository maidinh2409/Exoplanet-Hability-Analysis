select
    GENERATE_UUID() as `feature_id`,
    pl_masse as `mass`,
    pl_rade as `radius`,
    pl_dens as `density`,
    pl_eqt as `T_eq`,
    pl_insol as `flux`,
    pl_orbsmax as `distance_to_star`,
    pl_orbper as `period`,
    1 - SQRT(0.5 * (
	POW((pl_insol - 1)/(pl_insol + 1), 2) + 
	POW((pl_rade - 1)/(pl_rade + 1), 2)
		)
	) as`ESI`
from `asteroid-db-456716.exoplanet_habitability_db.nasa_exoplanet_pl`