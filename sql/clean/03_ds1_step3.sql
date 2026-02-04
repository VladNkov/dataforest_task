DROP TABLE IF EXISTS ds1_step3;

CREATE TABLE ds1_step3 AS
WITH a AS (
  SELECT custnmbr, addrcode, custname, sStreet1, sStreet2, sCity, sProvState, sCountry, sPostalZip,
    -- обрезаю C/O в имени
    CASE
      WHEN instr(name_step2, ' C/O') > 0 THEN substr(name_step2, 1, instr(name_step2, ' C/O') - 1)
      ELSE name_step2
    END AS name_whithout_co,

    city_step2, state_step2, country_step1, zip_step1
  FROM ds1_step2),

b AS (
  SELECT
    *,
     -- обрезаю CORPORATION, INC, LTD и тд.
    trim(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  ' ' || name_whithout_co || ' ',' INC ', ' '), ' LTD ', ' '),' LIMITED ', ' '),' LP ', ' '),' LLC ', ' '),
  ' CORPORATION ', ' '),' CORP ', ' '),' CO ', ' '),' COMPANY ', ' ')
    ) AS name_whithout_inc,

       -- унифицирую ST-SAINT
    CASE
      WHEN city_step2 LIKE 'ST %'  THEN 'SAINT'  || substr(city_step2, 3)
      WHEN city_step2 LIKE 'STE %' THEN 'SAINTE' || substr(city_step2, 4)
      ELSE city_step2
    END AS city_un,

-- привожу к 2-буквенным кодам
    CASE
      WHEN state_step2 IN ('ONTARIO','ON','TORONTO','TORONTO, ON') OR state_step2 LIKE 'ON%' THEN 'ON'
      WHEN state_step2 IN ('QUEBEC','QC','MONTREAL') THEN 'QC'
      WHEN state_step2 IN ('BRITISH COLUMBIA','BC') THEN 'BC'
      WHEN state_step2 IN ('ALBERTA','AB') THEN 'AB'
      WHEN state_step2 IN ('MANITOBA','MB') THEN 'MB'
      WHEN state_step2 IN ('SASKATCHEWAN','SK','KRONAU') THEN 'SK'
      WHEN state_step2 IN ('NOVA SCOTIA','NS') THEN 'NS'
      WHEN state_step2 IN ('NEW BRUNSWICK','NB') THEN 'NB'
      WHEN state_step2 IN ('PRINCE EDWARD ISLAND','PEI','PE') THEN 'PE'
      WHEN state_step2 IN ('NEWFOUNDLAND AND LABRADOR','NEWFOUNDLAND','NL') THEN 'NL'
      WHEN state_step2 IN ('NORTHWEST TERRITORIES','NT') THEN 'NT'
      WHEN state_step2 IN ('YUKON','YT') THEN 'YT'
      WHEN state_step2 IN ('NUNAVUT','NU') THEN 'NU'
      ELSE state_step2
    END AS state_clean,

-- привожу к кодам
    CASE
      WHEN country_step1 IN ('CANADA','CA','CAN') THEN 'CA'
      WHEN country_step1 IN ('USA','US','UNITED STATES','UNITED STATES OF AMERICA') THEN 'US'
      WHEN country_step1 LIKE 'CONTRACT%' THEN ''
      ELSE country_step1
    END AS country_clean

  FROM a
)
SELECT
  custnmbr, addrcode, custname, sStreet1, sStreet2, sCity, sProvState, sCountry, sPostalZip,

  -- финальная очистка
  trim(replace(replace(replace(replace(name_whithout_inc,'  ',' '),'  ',' '),'  ',' '),'  ',' ')) AS name_clean,
  trim(replace(replace(replace(replace(city_un,'  ',' '),'  ',' '),'  ',' '),'  ',' ')) AS city_clean,

  state_clean, country_clean, zip_step1
  AS zip_clean

FROM b;
