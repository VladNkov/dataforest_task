DROP TABLE IF EXISTS metrics;

CREATE TABLE metrics AS
SELECT
  -- процент совпадений: доля компаний DS1, имеющих совпадение в DS2
  COUNT(DISTINCT CASE WHEN is_matched = 1 THEN ds1_custnmbr END) AS matched_ds1,
  COUNT(DISTINCT ds1_custnmbr) AS total_ds1,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_matched = 1 THEN ds1_custnmbr END) / COUNT(DISTINCT ds1_custnmbr), 2) AS match_rate_pct,

  -- несовпадающие записи DS1: компании из DS1 без пары в DS2
  COUNT(DISTINCT CASE WHEN is_matched = 0 THEN ds1_custnmbr END) AS unmatched_ds1,
  ROUND(100.0 * COUNT(DISTINCT CASE WHEN is_matched = 0 THEN ds1_custnmbr END) / COUNT(DISTINCT ds1_custnmbr), 2) AS unmatched_ds1_pct,

  -- несовпадающие записи DS2: компании из DS2 без пары в DS1
  (SELECT COUNT(DISTINCT custnmbr) FROM ds2_clean_all) AS total_ds2,
  (SELECT COUNT(DISTINCT d2.custnmbr) FROM ds2_clean_all d2
   WHERE NOT EXISTS (SELECT 1 FROM matched_companies m WHERE m.ds2_custnmbr = d2.custnmbr)
  ) AS unmatched_ds2,
  ROUND(100.0 * (SELECT COUNT(DISTINCT d2.custnmbr) FROM ds2_clean_all d2
   WHERE NOT EXISTS (SELECT 1 FROM matched_companies m WHERE m.ds2_custnmbr = d2.custnmbr)
  ) / (SELECT COUNT(DISTINCT custnmbr) FROM ds2_clean_all), 2) AS unmatched_ds2_pct,

  -- общий процент несовпадений: доля компаний без пары из обоих датасетов вместе
  ROUND(100.0 * (
    COUNT(DISTINCT CASE WHEN is_matched = 0 THEN ds1_custnmbr END)
    + (SELECT COUNT(DISTINCT d2.custnmbr) FROM ds2_clean_all d2
       WHERE NOT EXISTS (SELECT 1 FROM matched_companies m WHERE m.ds2_custnmbr = d2.custnmbr))
  ) / (
    COUNT(DISTINCT ds1_custnmbr)
    + (SELECT COUNT(DISTINCT custnmbr) FROM ds2_clean_all)
  ), 2) AS unmatched_overall_pct,

  -- совпадения «один ко многим»: компании DS1, сопоставленные с несколькими компаниями DS2
  (SELECT COUNT(*) FROM (
    SELECT ds1_custnmbr FROM matched_companies WHERE is_matched = 1
    GROUP BY ds1_custnmbr HAVING COUNT(DISTINCT ds2_custnmbr) > 1
  )) AS one_to_many,
  ROUND(100.0 * (SELECT COUNT(*) FROM (
    SELECT ds1_custnmbr FROM matched_companies WHERE is_matched = 1
    GROUP BY ds1_custnmbr HAVING COUNT(DISTINCT ds2_custnmbr) > 1
  )) / COUNT(DISTINCT CASE WHEN is_matched = 1 THEN ds1_custnmbr END), 2) AS one_to_many_pct,

  -- совпадение по локации среди сопоставленных пар
  (SELECT SUM(city_match) FROM matched_companies WHERE is_matched = 1) AS city_matches,
  (SELECT SUM(state_match) FROM matched_companies WHERE is_matched = 1) AS state_matches,
  (SELECT SUM(zip_match) FROM matched_companies WHERE is_matched = 1) AS zip_matches,
  (SELECT COUNT(*) FROM matched_companies WHERE is_matched = 1) AS total_matched_pairs,
  ROUND(100.0 * (SELECT SUM(city_match) FROM matched_companies WHERE is_matched = 1) / (SELECT COUNT(*) FROM matched_companies WHERE is_matched = 1), 2) AS city_match_pct,
  ROUND(100.0 * (SELECT SUM(state_match) FROM matched_companies WHERE is_matched = 1) / (SELECT COUNT(*) FROM matched_companies WHERE is_matched = 1), 2) AS state_match_pct,
  ROUND(100.0 * (SELECT SUM(zip_match) FROM matched_companies WHERE is_matched = 1) / (SELECT COUNT(*) FROM matched_companies WHERE is_matched = 1), 2) AS zip_match_pct

FROM matched_companies;
