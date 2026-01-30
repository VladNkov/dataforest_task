DROP TABLE IF EXISTS ds1_state_clean;

CREATE TABLE ds1_state_clean AS
SELECT
  custnmbr, addrcode, sProvState
FROM dataset_1;

ALTER TABLE ds1_state_clean ADD COLUMN state_1 TEXT;
UPDATE ds1_state_clean
SET state_1 = UPPER(TRIM(COALESCE(sProvState, '')));

-- меняю французские буквы
ALTER TABLE ds1_state_clean ADD COLUMN state_2 TEXT;
UPDATE ds1_state_clean
SET state_2 =
  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  replace(replace(replace(replace(replace(replace(replace(replace(replace(
  state_1,
  'É', 'E'), 'È', 'E'), 'Ê', 'E'), 'Ë', 'E'),'À', 'A'), 'Â', 'A'), 'Ô', 'O'), 'Î', 'I'), 'é', 'E'), 'è', 'E'),
  'ê', 'E'), 'ë', 'E'), 'à', 'A'), 'â', 'A'), 'ô', 'O'), 'î', 'I'), 'ù', 'U'), 'û', 'U'), 'ç', 'C');

-- привожу к 2-буквенным кодам
ALTER TABLE ds1_state_clean ADD COLUMN state_clean TEXT;
UPDATE ds1_state_clean
SET state_clean = CASE
  WHEN state_2 IN ('ONTARIO', 'ON', 'TORONTO', 'TORONTO, ON') THEN 'ON'
  WHEN state_2 LIKE 'ON%' THEN 'ON'
  WHEN state_2 IN ('QUEBEC', 'QC', 'MONTREAL') THEN 'QC'
  WHEN state_2 IN ('BRITISH COLUMBIA', 'BC') THEN 'BC'
  WHEN state_2 IN ('ALBERTA', 'AB') THEN 'AB'
  WHEN state_2 IN ('MANITOBA', 'MB') THEN 'MB'
  WHEN state_2 IN ('SASKATCHEWAN', 'SK', 'KRONAU') THEN 'SK'
  WHEN state_2 IN ('NOVA SCOTIA', 'NS') THEN 'NS'
  WHEN state_2 IN ('NEW BRUNSWICK', 'NB') THEN 'NB'
  WHEN state_2 IN ('PRINCE EDWARD ISLAND', 'PEI', 'PE') THEN 'PE'
  WHEN state_2 IN ('NEWFOUNDLAND AND LABRADOR', 'NEWFOUNDLAND', 'NL') THEN 'NL'
  WHEN state_2 IN ('NORTHWEST TERRITORIES', 'NT') THEN 'NT'
  WHEN state_2 IN ('YUKON', 'YT') THEN 'YT'
  WHEN state_2 IN ('NUNAVUT', 'NU') THEN 'NU'
  WHEN state_2 IN ('TEXAS') THEN 'TE'
  ELSE state_2
END;
