DROP TABLE IF EXISTS ds2_city_clean;

CREATE TABLE ds2_city_clean AS
SELECT
  custnmbr,
  addrcode,
  city
FROM dataset_2;

-- Шаг 1: UPPER + TRIM
ALTER TABLE ds2_city_clean ADD COLUMN city_1 TEXT;
UPDATE ds2_city_clean
SET city_1 = UPPER(TRIM(COALESCE(city, '')));

-- Шаг 2: убираю запятые, точки, кавычки
ALTER TABLE ds2_city_clean ADD COLUMN city_2 TEXT;
UPDATE ds2_city_clean
SET city_2 = REPLACE(REPLACE(REPLACE(REPLACE(city_1, ',', ''), '.', ''), '"', ''), char(39), '');

-- Шаг 3: заменяю тире на пробел для унификации
ALTER TABLE ds2_city_clean ADD COLUMN city_3 TEXT;
UPDATE ds2_city_clean
SET city_3 = REPLACE(city_2, '-', ' ');

-- Шаг 4: унифицирую ST / SAINT
ALTER TABLE ds2_city_clean ADD COLUMN city_4 TEXT;
UPDATE ds2_city_clean
SET city_4 = CASE
  WHEN city_3 LIKE 'ST %' THEN 'SAINT' || SUBSTR(city_3, 3)
  WHEN city_3 LIKE 'STE %' THEN 'SAINTE' || SUBSTR(city_3, 4)
  ELSE city_3
END;

-- Шаг 5: убираю акценты (основные французские)
ALTER TABLE ds2_city_clean ADD COLUMN city_5 TEXT;
UPDATE ds2_city_clean
SET city_5 =
  REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
    city_4,
    'É', 'E'), 'È', 'E'), 'Ê', 'E'), 'Ë', 'E'),
    'À', 'A'), 'Â', 'A'), 'Ô', 'O'), 'Î', 'I');

-- Шаг 6: убираю множественные пробелы
ALTER TABLE ds2_city_clean ADD COLUMN city_clean TEXT;
UPDATE ds2_city_clean
SET city_clean = TRIM(REPLACE(REPLACE(REPLACE(city_5, '  ', ' '), '  ', ' '), '  ', ' '));
