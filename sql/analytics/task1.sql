
--1. Зіставте компанії між Набором даних 1 та Набором даних 2 на основі:
--   - назви компанії
--   - інформації про місцезнаходження

DROP TABLE IF EXISTS task1;

CREATE TABLE task1 AS
with united as(
SELECT
       ds1.custnmbr as custnmbr_ds1,
       ds2.custnmbr as custnmbr_ds2,
       ds1.custname as name_ds1,
       ds2.custname as name_ds2,
	   ds1.custnmbr as custnmbr_ds1,
	   ds2.custnmbr as custnmbr_ds2,
	   ds2.addrcode AS ds2_addrcode,
	   ds1.sCountry as country_ds1,
	   ds2.country as country_ds2,
	   ds1.sCity as city_ds1,
	   ds2.city  as city_ds2,
	   ds1.sProvState as state_ds1,
	   ds2.state as state_ds2,
	   ds1.sPostalZip as zip_ds1,
	   ds2.zip as zip_ds2,
	   ds1.name_clean as name_clean_ds1,
	   ds2.name_clean as name_clean_ds2,

       CASE WHEN ds1.country_clean IS NOT NULL AND ds2.country_clean IS NOT NULL AND
            ds1.country_clean = ds2.country_clean THEN 1 ELSE 0 END AS match_country,
       CASE WHEN ds1.state_clean IS NOT NULL AND ds2.state_clean IS NOT NULL AND
	        ds1.state_clean = ds2.state_clean then 1 else 0 end as match_state,
	   CASE WHEN ds1.city_clean IS NOT NULL AND ds2.city_clean IS NOT NULL AND
	        ds1.city_clean = ds2.city_clean then 1 else 0 end as match_city,
	   CASE WHEN ds1.zip_clean IS NOT NULL AND ds2.zip_clean IS NOT NULL AND
	        ds1.zip_clean = ds2.zip_clean then 1 else 0 end as match_zip

from ds1_step3 as ds1
left join ds2_step3 as ds2  on ds1.name_clean = ds2.name_clean),

row_n as (
SELECT *,
       ROW_NUMBER() OVER (
       PARTITION BY custnmbr_ds1, name_clean_ds1
       ) AS rn
FROM united)

SELECT
    custnmbr_ds1,
    custnmbr_ds2,
    name_ds1,
    trim(replace(replace(replace(replace(name_ds2,'  ',' '),'  ',' '),'  ',' '),'  ',' ')) AS name_ds2_cl,
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

