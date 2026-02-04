DROP TABLE IF EXISTS ds1_step2;

CREATE TABLE ds1_step2 AS
SELECT *,

-- меняю французские буквы
  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(name_step1,
    'É','E'),'È','E'),'Ê','E'),'Ë','E'),'À','A'),'Â','A'),'Ô','O'),'Î','I'),'Ù','U'),'Û','U'),'Ç','C'),'Ï','I'
  ) AS name_step2,


  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(city_step1,
    'É','E'),'È','E'),'Ê','E'),'Ë','E'),'À','A'),'Â','A'),'Ô','O'),'Î','I'),'Ù','U'),'Û','U'),'Ç','C'),'Ï','I'
  ) AS city_step2,


  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(state_step1,
    'É','E'),'È','E'),'Ê','E'),'Ë','E'),'À','A'),'Â','A'),'Ô','O'),'Î','I'),'Ù','U'),'Û','U'),'Ç','C'),'Ï','I'
  ) AS state_step2
FROM ds1_step1;
