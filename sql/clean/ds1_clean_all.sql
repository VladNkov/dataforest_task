DROP TABLE IF EXISTS ds1_clean_all;

CREATE TABLE ds1_clean_all AS
SELECT
  a.custnmbr,
  a.addrcode,
  a.custname,
  a.name_clean_ds1,
  c.city_clean,
  s.state_clean,
  co.country_clean,
  z.zip_clean
FROM ds1_name_clean AS a
LEFT JOIN ds1_city_clean c ON a.custnmbr = c.custnmbr AND a.addrcode = c.addrcode
LEFT JOIN ds1_state_clean s ON a.custnmbr = s.custnmbr AND a.addrcode = s.addrcode
LEFT JOIN ds1_country_clean co ON a.custnmbr = co.custnmbr AND a.addrcode = co.addrcode
LEFT JOIN ds1_zip_clean z ON a.custnmbr = z.custnmbr AND a.addrcode = z.addrcode;
