-- 2. Створіть об'єднаний набір даних, який:
--    - містить усі компанії та місцезнаходження з Набору даних 1
--    - включає відповідні збіги з Набору даних 2, якщо вони існують
--    - **Важливо:** зберігайте збіги компаній, навіть якщо їхні місцезнаходження не збігаються

DROP TABLE IF EXISTS task2;

CREATE TABLE task2 AS

WITH match_ds2 AS(
    SELECT
       ds2.custnmbr,
       ds2.addrcode,
       ds2.custname,
       ds2.address1,
       ds2.address2,
       ds2.address3,
       ds2.ccode,
       ds2.city,
       ds2.country,
       ds2.state,
       ds2.zip,
       ds2.name_clean,
       ds2.country_clean,
       ds2.state_clean,
       ds2.city_clean,
       ds2.zip_clean
    FROM ds2_step3  AS ds2
    WHERE EXISTS (
        SELECT 1
        FROM ds1_step3 as ds1
        WHERE ds1.name_clean = ds2.name_clean )
        ),

ds2_dedup AS (
SELECT *
FROM(
    SELECT
        m.*,
        ROW_NUMBER() OVER(
            PARTITION BY m.custnmbr, m.name_clean
        )
        AS rn
    FROM match_ds2 AS m)
WHERE rn = 1),

ds1_dedup AS (
    SELECT *
    FROM (
        SELECT
            ds1.custnmbr,
            ds1.custname,
            ds1.sCity AS city,
            ds1.sProvState AS state,
            ds1.sCountry AS country,
            ds1.sPostalZip AS zip,
            ds1.addrcode,
            ds1.name_clean,
            ds1.country_clean,
            ds1.state_clean,
            ds1.city_clean,
            ds1.zip_clean,
            ROW_NUMBER() OVER (
                PARTITION BY ds1.custnmbr, name_clean
            ) AS rn
        FROM ds1_step3 AS ds1)
    WHERE rn = 1)

    SELECT
         dd1.custnmbr,
         dd1.custname,
         dd1.city,
         dd1.state,
         dd1.country,
         dd1.zip,
         dd1.addrcode,
         dd1.name_clean,
         dd1.country_clean,
         dd1.state_clean,
         dd1.city_clean,
         dd1.zip_clean,
         'ds1' AS source
    FROM ds1_dedup as dd1



    UNION ALL

    SELECT
         dd2.custnmbr,
         dd2.custname,
         dd2.city,
         dd2.state,
         dd2.country,
         dd2.zip,
         dd2.addrcode,
         dd2.name_clean,
         dd2.country_clean,
         dd2.state_clean,
         dd2.city_clean,
         dd2.zip_clean,
         'ds2' AS source
    FROM ds2_dedup AS dd2








