DROP TABLE IF EXISTS ds1_zip_clean;

CREATE TABLE ds1_zip_clean AS
SELECT custnmbr, addrcode, sPostalZip
FROM dataset_1;

ALTER TABLE ds1_zip_clean ADD COLUMN zip_1 TEXT;
UPDATE ds1_zip_clean
SET zip_1 = UPPER(TRIM(COALESCE(sPostalZip, '')));

ALTER TABLE ds1_zip_clean ADD COLUMN zip_clean TEXT;
UPDATE ds1_zip_clean
SET zip_clean = replace(replace(zip_1, ' ', ''), '-', '');