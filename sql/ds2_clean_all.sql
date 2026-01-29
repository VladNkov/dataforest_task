DROP TABLE IF EXISTS ds2_clean_all;

CREATE TABLE ds2_clean_all AS
SELECT
  a.custnmbr,
  a.addrcode,
  a.custname,
  a.name_clean_ds2,
  c.city_clean,
  s.state_clean,
  co.country_clean,
  z.zip_clean
FROM ds2_name_clean a
LEFT JOIN ds2_city_clean c ON a.custnmbr = c.custnmbr AND a.addrcode = c.addrcode
LEFT JOIN ds2_state_clean s ON a.custnmbr = s.custnmbr AND a.addrcode = s.addrcode
LEFT JOIN ds2_country_clean co ON a.custnmbr = co.custnmbr AND a.addrcode = co.addrcode
LEFT JOIN ds2_zip_clean z ON a.custnmbr = z.custnmbr AND a.addrcode = z.addrcode;
