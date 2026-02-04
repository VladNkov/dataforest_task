DROP TABLE IF EXISTS ds1_step1;

CREATE TABLE ds1_step1 AS
SELECT custnmbr, addrcode, custname, sStreet1, sStreet2, sCity, sProvState, sCountry, sPostalZip,

-- убираю мусорные символы и заменяю на пробелы
  trim(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
    upper(trim(coalesce(custname,''))),
    '"',''), char(39), ''), '*',''), '#',''), '+',' '), '-',' '), ',',' '), '.',' '), '_',' '), '%',' ')
  ) AS name_step1,

  trim(replace(replace(replace(replace(
    upper(trim(coalesce(sCity,''))),
    ',', ' '), '.', ' '), '"', ''), char(39), '')) AS city_step1,

  trim(upper(trim(coalesce(sProvState,'')))) AS state_step1,

  trim(upper(trim(coalesce(sCountry,'')))) AS country_step1,

  replace(replace(upper(trim(coalesce(sPostalZip,''))), ' ', ''), '-', '') AS zip_step1
FROM dataset_1;
