--3. Розрахуйте такі метрики:
--   - відсоток збігів: % компаній з Набору даних 1, що мають збіг у Наборі даних 2
--   - записи без збігів: % компаній, що не мають збігів у жодному з наборів даних
--   - збіги «один до багатьох»: % компаній із кількома записами збігів
--   - інші метрики, які ви вважаєте корисними

DROP TABLE IF EXISTS task3;

CREATE TABLE task3 AS
WITH base AS (
    SELECT
        custnmbr_ds1,
        name_clean_ds1,
        SUM (CASE WHEN name_ds2_cl IS NOT NULL THEN 1 ELSE 0 END) AS match_count
    FROM task1
    GROUP BY custnmbr_ds1, name_clean_ds1
),
count_m AS (
    SELECT
        COUNT(*) AS total_company,
        SUM (CASE WHEN match_count = 0 THEN 1 ELSE 0 END) AS unmatch_company,
        SUM (CASE WHEN match_count > 1 THEN 1 ELSE 0 END) AS one_to_many_company,
        SUM (CASE WHEN match_count > 0 THEN 1 ELSE 0 END) AS match_company
    FROM base
)
SELECT
    match_company,
    unmatch_company,
    total_company,
    one_to_many_company,
    ROUND(100.0 * match_company / total_company, 2) AS match_percent,
    ROUND(100.0 * unmatch_company / total_company, 2) AS unmatch_percent,
    ROUND(100.0 * one_to_many_company / total_company, 2) AS one_to_many_percent
FROM count_m;

