DROP TABLE IF EXISTS ds2_step2;

CREATE TABLE ds2_step2 AS
SELECT *,

-- меняю французские буквы (uppercase + lowercase)
  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(name_step1,
    'É','E'),'È','E'),'Ê','E'),'Ë','E'),'À','A'),'Â','A'),'Ô','O'),'Î','I'),'Ù','U'),'Û','U'),'Ç','C'),'Ï','I'),
    'é','E'),'è','E'),'ê','E'),'ë','E'),'à','A'),'â','A'),'ô','O'),'î','I'),'ù','U'),'û','U'),'ç','C'),'ï','I'
  ) AS name_step2,


  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(city_step1,
    'É','E'),'È','E'),'Ê','E'),'Ë','E'),'À','A'),'Â','A'),'Ô','O'),'Î','I'),'Ù','U'),'Û','U'),'Ç','C'),'Ï','I'),
    'é','E'),'è','E'),'ê','E'),'ë','E'),'à','A'),'â','A'),'ô','O'),'î','I'),'ù','U'),'û','U'),'ç','C'),'ï','I'
  ) AS city_step2,


  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(
  replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(state_step1,
    'É','E'),'È','E'),'Ê','E'),'Ë','E'),'À','A'),'Â','A'),'Ô','O'),'Î','I'),'Ù','U'),'Û','U'),'Ç','C'),'Ï','I'),
    'é','E'),'è','E'),'ê','E'),'ë','E'),'à','A'),'â','A'),'ô','O'),'î','I'),'ù','U'),'û','U'),'ç','C'),'ï','I'
  ) AS state_step2
FROM ds2_step1;
