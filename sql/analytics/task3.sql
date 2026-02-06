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
        MAX(CASE WHEN name_ds2_cl IS NOT NULL THEN 1 ELSE 0 END) AS has_match
    FROM task1
    GROUP BY custnmbr_ds1, name_clean_ds1
),
count_m AS (
    SELECT
        SUM(has_match) AS count_match,
        COUNT(*) AS total_company
    FROM base
)
SELECT
    count_match,
    ROUND(100.0 * count_match / total_company, 2) AS match_percent
FROM count_m;

