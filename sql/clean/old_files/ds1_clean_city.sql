DROP TABLE IF EXISTS ds1_city_clean;

CREATE TABLE ds1_city_clean AS
SELECT
  custnmbr, addrcode,sCity
FROM dataset_1;

-- UPPER + TRIM
ALTER TABLE ds1_city_clean ADD COLUMN city_1 TEXT;
UPDATE ds1_city_clean
SET city_1 = UPPER(TRIM(COALESCE(sCity, '')));

-- убираю запятые, точки, кавычки
ALTER TABLE ds1_city_clean ADD COLUMN city_2 TEXT;
UPDATE ds1_city_clean
SET city_2 = replace(replace(replace(replace(city_1, ',', ''), '.', ''), '"', ''), char(39), '');

-- меняю тире на пробел
ALTER TABLE ds1_city_clean ADD COLUMN city_3 TEXT;
UPDATE ds1_city_clean
SET city_3 = replace(city_2, '-', ' ');

-- унифицирую ST-SAINT
ALTER TABLE ds1_city_clean ADD COLUMN city_4 TEXT;
UPDATE ds1_city_clean
SET city_4 = CASE
  WHEN city_3 LIKE 'ST %' THEN 'SAINT' || SUBSTR(city_3, 3)
  WHEN city_3 LIKE 'STE %' THEN 'SAINTE' || SUBSTR(city_3, 4)
  ELSE city_3
END;

-- меняю французские буквы
ALTER TABLE ds1_city_clean ADD COLUMN city_5 TEXT;
UPDATE ds1_city_clean
SET city_5 =
  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  replace(replace(replace(replace(replace(replace(replace(replace(replace(
  city_4,
  'É', 'E'), 'È', 'E'), 'Ê', 'E'), 'Ë', 'E'),'À', 'A'), 'Â', 'A'), 'Ô', 'O'), 'Î', 'I'), 'é', 'E'), 'è', 'E'),
  'ê', 'E'), 'ë', 'E'), 'à', 'A'), 'â', 'A'), 'ô', 'O'), 'î', 'I'), 'ù', 'U'), 'û', 'U'), 'ç', 'C');

-- убираю пробелы
ALTER TABLE ds1_city_clean ADD COLUMN city_clean TEXT;
UPDATE ds1_city_clean
SET city_clean = trim(
    replace(replace(replace(replace(city_5, '  ', ' '), '  ', ' '), '  ', ' '), '  ', ' '));
