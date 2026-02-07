--3. Розрахуйте такі метрики:
--   - відсоток збігів: % компаній з Набору даних 1, що мають збіг у Наборі даних 2
--   - записи без збігів: % компаній, що не мають збігів у жодному з наборів даних
--   - збіги «один до багатьох»: % компаній із кількома записами збігів
--   - інші метрики, які ви вважаєте корисними
--      якість збігів:
--            1. % збігів по zip+city+state+country
--            2. % збігів по 3 локаціям
--            3. % збігів по 2 локаціям
--            4. % збігів по 1 локації
--            5. max збігів для компанії з ds1 в ds2
--            6. % збігів для компанії з ds1 2 та більше компаній в ds2
--            7. % збігів для компанії з ds1 3 та більше компаній в ds2

DROP TABLE IF EXISTS task3;

CREATE TABLE task3 AS
WITH base AS (
    SELECT
        custnmbr_ds1,
        name_clean_ds1,
        SUM (CASE WHEN name_ds2_cl IS NOT NULL THEN 1 ELSE 0 END) AS match_count, -- скільки матчів із ds2 у компанії

        MAX(location_match) AS best_loc_match
    FROM task1
    GROUP BY custnmbr_ds1, name_clean_ds1
),
count_m AS (
    SELECT
        COUNT(*) AS total_company,
        SUM (CASE WHEN match_count = 0 THEN 1 ELSE 0 END) AS unmatch_company,
        SUM (CASE WHEN match_count > 1 THEN 1 ELSE 0 END) AS one_to_many_company,
        SUM (CASE WHEN match_count > 0 THEN 1 ELSE 0 END) AS match_company,

        SUM(CASE WHEN best_loc_match = 4 THEN 1 ELSE 0 END) AS four_location_match,
        SUM(CASE WHEN best_loc_match = 3 THEN 1 ELSE 0 END) AS three_location_match,
        SUM(CASE WHEN best_loc_match = 2 THEN 1 ELSE 0 END) AS two_location_match,
        SUM(CASE WHEN best_loc_match = 1 THEN 1 ELSE 0 END) AS one_location_match,

        MAX(match_count) AS match_max_company_ds2,
        SUM(CASE WHEN match_count >= 2 THEN 1 ELSE 0 END) AS match_2plus_company_ds2,
        SUM(CASE WHEN match_count >= 3 THEN 1 ELSE 0 END) AS match_3plus_company_ds2
    FROM base
)
SELECT
    match_company,
    unmatch_company,
    total_company,
    one_to_many_company,
    match_max_company_ds2,
    match_2plus_company_ds2,
    match_3plus_company_ds2,
    ROUND(100.0 * match_company / total_company, 2) AS match_percent,
    ROUND(100.0 * unmatch_company / total_company, 2) AS unmatch_percent,
    ROUND(100.0 * one_to_many_company / total_company, 2) AS one_to_many_percent,

    ROUND(100.0 * four_location_match / total_company, 2) AS four_location_match_persent,
    ROUND(100.0 * three_location_match / total_company, 2) AS three_location_match_persent,
    ROUND(100.0 * two_location_match / total_company, 2) AS two_location_match_persent,
    ROUND(100.0 * one_location_match / total_company, 2) AS one_location_match_persent,

    ROUND(100.0 * match_2plus_company_ds2 / total_company, 2) AS match_2plus_company_ds2_persent,
    ROUND(100.0 * match_3plus_company_ds2 / total_company, 2) AS match_3plus_company_ds2_persent


FROM count_m;

