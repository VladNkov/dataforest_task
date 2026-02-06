
--1. Зіставте компанії між Набором даних 1 та Набором даних 2 на основі:
--   - назви компанії
--   - інформації про місцезнаходження

DROP TABLE IF EXISTS task1;

CREATE TABLE task1 AS
WITH united AS(
SELECT
       ds1.custnmbr AS custnmbr_ds1,
       ds2.custnmbr AS custnmbr_ds2,
       ds1.custname AS name_ds1,
       ds2.custname AS name_ds2,
	   ds2.addrcode AS ds2_addrcode,
	   ds1.sCountry AS country_ds1,
	   ds2.country AS country_ds2,
	   ds1.sCity AS city_ds1,
	   ds2.city  AS city_ds2,
	   ds1.sProvState AS state_ds1,
	   ds2.state AS state_ds2,
	   ds1.sPostalZip AS zip_ds1,
	   ds2.zip AS zip_ds2,
	   ds1.name_clean AS name_clean_ds1,
	   ds2.name_clean AS name_clean_ds2,

       CASE WHEN ds1.country_clean IS NOT NULL AND ds2.country_clean IS NOT NULL AND
            ds1.country_clean = ds2.country_clean THEN 1 ELSE 0 END AS match_country,
       CASE WHEN ds1.state_clean IS NOT NULL AND ds2.state_clean IS NOT NULL AND
	        ds1.state_clean = ds2.state_clean THEN 1 ELSE 0 END AS match_state,
	   CASE WHEN ds1.city_clean IS NOT NULL AND ds2.city_clean IS NOT NULL AND
	        ds1.city_clean = ds2.city_clean THEN 1 ELSE 0 END AS match_city,
	   CASE WHEN ds1.zip_clean IS NOT NULL AND ds2.zip_clean IS NOT NULL AND
	        ds1.zip_clean = ds2.zip_clean THEN 1 ELSE 0 END AS match_zip

from ds1_step3 AS ds1
left join ds2_step3 AS ds2  on ds1.name_clean = ds2.name_clean),

row_n AS (
SELECT *,
       ROW_NUMBER() OVER (
       PARTITION BY name_clean_ds1, custnmbr_ds1
       ORDER BY name_clean_ds1 DESC
       ) AS rn
FROM united)

SELECT
    custnmbr_ds1,
    custnmbr_ds2,
    name_ds1,
    trim(replace(replace(replace(replace(name_ds2,'  ',' '),'  ',' '),'  ',' '),'  ',' ')) AS name_ds2_cl,
    name_clean_ds1,
    (match_country+ match_country + match_state + match_city + match_zip) AS location_match,
    match_country,
    match_state,
    match_city,
    match_zip,
    country_ds1,
    trim(replace(replace(replace(replace(country_ds2,'  ',' '),'  ',' '),'  ',' '),'  ',' ')) AS country_ds2_cl,
    city_ds1,
    trim(replace(replace(replace(replace(city_ds2,'  ',' '),'  ',' '),'  ',' '),'  ',' ')) AS city_ds2_cl,
    zip_ds1,
    zip_ds2
FROM row_n
WHERE rn = 1
ORDER BY location_match DESC, name_clean_ds1

