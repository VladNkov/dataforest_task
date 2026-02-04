DROP TABLE IF EXISTS ds2_step1;

CREATE TABLE ds2_step1 AS
SELECT custnmbr, addrcode, custname, address1, address2, address3, ccode, city, country, state, zip,

-- убираю мусорные символы и заменяю на пробелы
  trim(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
    upper(trim(coalesce(custname,''))),
    '"',''), char(39), ''), '*',''), '#',''), '+',' '), '-',' '), ',',' '), '.',' '), '_',' '), '%',' ')
  ) AS name_step1,

  trim(replace(replace(replace(replace(
    upper(trim(coalesce(city,''))),
    ',', ' '), '.', ' '), '"', ''), char(39), '')) AS city_step1,

  trim(upper(trim(coalesce(state,'')))) AS state_step1,

  trim(upper(trim(coalesce(country,'')))) AS country_step1,

  replace(replace(upper(trim(coalesce(zip,''))), ' ', ''), '-', '') AS zip_step1
FROM dataset_2;