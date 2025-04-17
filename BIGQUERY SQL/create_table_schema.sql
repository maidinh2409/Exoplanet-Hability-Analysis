/* PLANET */
create table `exoplanet_habitability_db.planet` (
  planet_id INT64 NOT NULL,
  planet_name STRING NOT NULL,
  age FLOAT64,
  star_id INT64,
  detection_id INT64,
  isHabitable BOOL DEFAULT FALSE,
);

/* PLANET_FEATURES */
create table `exoplanet_habitability_db.planet_features` (
  feature_id INT64 NOT NULL,
  planet_id INT64,
  mass FLOAT64,
  radius FLOAT64,
  density FLOAT64,
  T_eq FLOAT64,
  T_surf FLOAT64,
  flux FLOAT64,
  distance_to_star FLOAT64,
  period FLOAT64,
  ESI FLOAT64 DEFAULT 0,
  composition STRING DEFAULT "unknown"
);

/* HOST_STAR */
create table `exoplanet_habitability_db.host_star` (
  star_id INT64 NOT NULL,
  star_name STRING,
  star_type STRING DEFAULT "unknown",
  temperature FLOAT64,
  radius FLOAT64,
  mass FLOAT64,
  metalicity FLOAT64,
  luminosity FLOAT64,
);

/* DETECTION_EVENT */
create table `exoplanet_habitability_db.detection_event` (
  detection_id INT64 NOT NULL,
  method_id INT64,
  facility_id INT64,
  detect_date DATE
);

/* DETECTION_METHOD */
create table `exoplanet_habitability_db.detection_method` (
  method_id INT64 NOT NULL,
  method_type STRING,
  facility_id INT64
);

/* FACILITY */
create table `exoplanet_habitability_db.facility` (
  facility_id INT64 NOT NULL,
  facility_name STRING,
  location STRING
);




