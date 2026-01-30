DROP TABLE IF EXISTS ds2_zip_clean;

CREATE TABLE ds2_zip_clean AS
SELECT custnmbr, addrcode, zip
FROM dataset_2;

ALTER TABLE ds2_zip_clean ADD COLUMN zip_1 TEXT;
UPDATE ds2_zip_clean
SET zip_1 = UPPER(TRIM(COALESCE(zip, '')));

ALTER TABLE ds2_zip_clean ADD COLUMN zip_clean TEXT;
UPDATE ds2_zip_clean
SET zip_clean = replace(replace(zip_1, ' ', ''), '-', '');