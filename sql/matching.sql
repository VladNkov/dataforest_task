DROP TABLE IF EXISTS matched_companies;

CREATE TABLE matched_companies AS
SELECT
  d1.custnmbr  AS ds1_custnmbr,
  d1.addrcode  AS ds1_addrcode,
  d1.custname  AS ds1_custname,
  d1.name_clean_ds1,
  d1.city_clean   AS ds1_city,
  d1.state_clean  AS ds1_state,
  d1.country_clean AS ds1_country,
  d1.zip_clean    AS ds1_zip,
  d2.custnmbr  AS ds2_custnmbr,
  d2.addrcode  AS ds2_addrcode,
  d2.custname  AS ds2_custname,
  d2.name_clean_ds2,
  d2.city_clean   AS ds2_city,
  d2.state_clean  AS ds2_state,
  d2.country_clean AS ds2_country,
  d2.zip_clean    AS ds2_zip,

  CASE WHEN d2.custnmbr IS NOT NULL THEN 1 ELSE 0 END AS is_matched,
  CASE WHEN d1.city_clean = d2.city_clean AND d1.city_clean != '' THEN 1 ELSE 0 END AS city_match,
  CASE WHEN d1.state_clean = d2.state_clean AND d1.state_clean != '' THEN 1 ELSE 0 END AS state_match,
  CASE WHEN d1.zip_clean = d2.zip_clean AND d1.zip_clean != '' THEN 1 ELSE 0 END AS zip_match
FROM ds1_clean_all d1
LEFT JOIN ds2_clean_all d2 ON d1.name_clean_ds1 = d2.name_clean_ds2;
