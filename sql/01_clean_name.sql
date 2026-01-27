DROP TABLE IF EXISTS ds1_name_clean;
CREATE TABLE ds1_name_clean AS
SELECT
  custnmbr,
  addrcode,
  custname
FROM dataset_1;

ALTER TABLE ds1_name_clean ADD COLUMN name_1 TEXT;
UPDATE ds1_name_clean
SET name_1 = upper(trim(coalesce(custname, '')));

-- убираю мусорные символы и заменяю на пробелы
ALTER TABLE ds1_name_clean ADD COLUMN name_2 TEXT;
UPDATE ds1_name_clean
SET name_2 =
  replace(replace(replace(replace(replace(replace(replace(replace(
    name_1,
    '"',''
  ), char(39), ''), '*',''), '#',''), '+',' '), '-',' '), ',',' '), '.',' ');

-- обрезаю C/O если есть
  ALTER TABLE ds1_name_clean ADD COLUMN name_3 TEXT;
UPDATE ds1_name_clean
SET name_3 = CASE
  WHEN instr(name_2, ' C/O') > 0 THEN substr(name_2, 1, instr(name_2, ' C/O') - 1)
  ELSE name_2
END;