DROP TABLE IF EXISTS ds2_country_clean;

CREATE TABLE ds2_country_clean AS
SELECT
  custnmbr, addrcode, country
FROM dataset_2;

ALTER TABLE ds2_country_clean ADD COLUMN country_1 TEXT;
UPDATE ds2_country_clean
SET country_1 = UPPER(TRIM(COALESCE(country, '')));

-- привожу к кодам
ALTER TABLE ds2_country_clean ADD COLUMN country_clean TEXT;
UPDATE ds2_country_clean
SET country_clean = CASE
  WHEN country_1 IN ('CANADA', 'CA', 'CAN') THEN 'CA'
  WHEN country_1 IN ('USA', 'US', 'UNITED STATES', 'UNITED STATES OF AMERICA') THEN 'US'
  WHEN country_1 = '' THEN ''
  ELSE country_1
END;
