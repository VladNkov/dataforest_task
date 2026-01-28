DROP TABLE IF EXISTS ds2_name_clean;
CREATE TABLE ds2_name_clean AS
SELECT
  custnmbr, addrcode, custname
FROM dataset_1;

ALTER TABLE ds2_name_clean ADD COLUMN name_1 TEXT;
UPDATE ds2_name_clean
SET name_1 = upper(trim(coalesce(custname, '')));

-- обрезаю C/O если есть
ALTER TABLE ds2_name_clean ADD COLUMN name_2 TEXT;
UPDATE ds2_name_clean
SET name_2 = CASE
  WHEN instr(name_1, ' C/O') > 0 THEN substr(name_1, 1, instr(name_1, ' C/O') - 1)
  ELSE name_1
END;

-- убираю мусорные символы и заменяю на пробелы
ALTER TABLE ds2_name_clean ADD COLUMN name_3 TEXT;
UPDATE ds2_name_clean
SET name_3 =
  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  name_2,
    '"',''), char(39), ''), '*',''), '#',''), '+',''), '-',''), ',',''), '.',''), '_', ''), '%', ''), '/', ' ');

-- скобки заменяю на пробелы
ALTER TABLE ds2_name_clean ADD COLUMN name_4 TEXT;
UPDATE ds2_name_clean
SET name_4 =
  replace(replace(replace(replace(name_3,'(', ' '), ')',' '), '[',' '), ']',' ');

-- обрезаю CORPORATION, INC, LTD и тд.
ALTER TABLE ds2_name_clean ADD COLUMN name_5 TEXT;
UPDATE ds2_name_clean
SET name_5 =
  trim(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  ' ' || name_4 || ' ',' INC ', ' '), ' LTD ', ' '),' LIMITED ', ' '),' LP ', ' '),' LLC ', ' '),
  ' CORPORATION ', ' '),' CORP ', ' '),' CO ', ' '),' COMPANY ', ' '));

-- меняю французские буквы
ALTER TABLE ds2_name_clean ADD COLUMN name_6 TEXT;
UPDATE ds1_name_clean
SET name_6 =
  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  replace(replace(replace(replace(replace(replace(replace(replace(replace(
  name_5,
  'É', 'E'), 'È', 'E'), 'Ê', 'E'), 'Ë', 'E'),'À', 'A'), 'Â', 'A'), 'Ô', 'O'), 'Î', 'I'), 'é', 'E'), 'è', 'E'),
  'ê', 'E'), 'ë', 'E'), 'à', 'A'), 'â', 'A'), 'ô', 'O'), 'î', 'I'), 'ù', 'U'), 'û', 'U'), 'ç', 'C');

ALTER TABLE ds2_name_clean ADD COLUMN name_clean_ds2 TEXT;
UPDATE ds2_name_clean
SET name_clean_ds2 =
  trim(
    replace(replace(replace(replace(name_6, '  ', ' '), '  ', ' '), '  ', ' '), '  ', ' ')
  );

