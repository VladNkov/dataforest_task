DROP TABLE IF EXISTS ds1_clean_name;

CREATE TABLE ds1_clean_name AS
WITH r AS(
SELECT custnmbr, addrcode, custname
FROM dataset_1),

n1 AS(
  SELECT *, upper(trim(coalesce(custname, ''))) as name_1
  FROM r),

-- обрезаю C/O если есть
n2 AS(
SELECT *, CASE
  WHEN instr(name_1, ' C/O') > 0 THEN substr(name_1, 1, instr(name_1, ' C/O') - 1)
  ELSE name_1
  END AS name_2
FROM n1),

-- убираю мусорные символы и заменяю на пробелы
n3 AS (
SELECT *, replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  name_2,
  '"',''), char(39), ''), '*',''), '#',''), '+',''), '-',''), ',',''), '.',''), '_', ''), '%', ''), '/', ' '), '&', ' ')
  AS name_3
FROM n2),

-- скобки заменяю на пробелы
n4 AS (
SELECT *, replace(replace(replace(replace(name_3, '(', ' '), ')', ' '), '[', ' '), ']', ' ')
  AS name_4
FROM n3),

-- обрезаю CORPORATION, INC, LTD и тд.
n5 AS (
SELECT *,
    trim(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  ' ' || name_4 || ' ',' INC ', ' '), ' LTD ', ' '),' LIMITED ', ' '),' LP ', ' '),' LLC ', ' '),
  ' CORPORATION ', ' '),' CORP ', ' '),' CO ', ' '),' COMPANY ', ' '))
  AS name_5
FROM n4),

-- меняю французские буквы
n6 AS (
SELECT *,
  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  replace(replace(replace(replace(replace(replace(replace(replace(replace(name_5,
  'É', 'E'), 'È', 'E'), 'Ê', 'E'), 'Ë', 'E'),'À', 'A'), 'Â', 'A'), 'Ô', 'O'), 'Î', 'I'), 'é', 'E'), 'è', 'E'),
  'ê', 'E'), 'ë', 'E'), 'à', 'A'), 'â', 'A'), 'ô', 'O'), 'î', 'I'), 'ù', 'U'), 'û', 'U'), 'ç', 'C')
  AS name_6
FROM n5),

-- убираю пробелы
cn1 AS (
SELECT *, trim(replace(replace(replace(replace(name_6, '  ', ' '), '  ', ' '), '  ', ' '), '  ', ' ')
  )AS name_clean_ds1
FROM n6)

SELECT custnmbr, addrcode, custname, name_1, name_2, name_3, name_4, name_5, name_6, name_clean_ds1
FROM cn1



