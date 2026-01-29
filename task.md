# DATAFOREST — DE TEST TASK

## Objective

Match companies between two datasets based on company names and locations, and produce a merged output.

## Datasets

You are provided with two datasets, both contain company information including:

- company name
- location (street, city, province / state, country, postal code)

## Requirements

1. Match companies between Dataset 1 and Dataset 2 based on:
   - company name
   - location information
2. Create a merged dataset that:
   - contains all companies and locations from Dataset 1
   - includes corresponding matches from Dataset 2 where they exist
   - **Important:** Keep matching companies even if their locations don't overlap
3. Calculate following metrics:
   - match rate: % of Dataset 1 companies that have a match in Dataset 2
   - unmatched records: % of companies with no match in either dataset
   - one-to-many matches: % of companies with multiple matched entries
   - other metrics you consider useful

## Constraints

- Time limit: 3 hours
- Tools: Use any programming language or tool you prefer

## Deliverables

1. Merged dataset (CSV)
2. Code scripts
3. Documentation:
   - matching approach
   - data quality issues found
   - normalization / transformations applied
   - calculated metrics

---

## Цель

Сопоставить компании в двух наборах данных на основе названий компаний и их местоположений и получить объединённый результат.

## Наборы данных

Вам предоставлены два набора данных, оба содержат информацию о компаниях, включая:

- название компании
- местоположение (улица, город, провинция/штат, страна, почтовый индекс)

## Требования

1. Сопоставьте компании между Набором данных 1 и Набором данных 2 на основе:
   - названия компании
   - информации о местоположении
2. Создайте объединённый набор данных, который:
   - содержит все компании и местоположения из Набора данных 1
   - включает соответствующие совпадения из Набора данных 2, если они существуют
   - **Важно:** сохраняйте совпадения компаний, даже если их местоположения не совпадают
3. Рассчитайте следующие метрики:
   - процент совпадений: % компаний из Набора данных 1, имеющих совпадение в Наборе данных 2
   - несовпадающие записи: % компаний, не имеющих совпадений ни в одном из наборов данных
   - совпадения «один ко многим»: % компаний с несколькими совпадающими записями
   - другие метрики, которые вы считаете полезными

## Ограничения

- Ограничение по времени: 3 часа
- Инструменты: используйте любой язык программирования или инструмент по вашему выбору

## Результаты работы

1. Объединённый набор данных (CSV)
2. Скрипты кода
3. Документация:
   - подход к сопоставлению
   - обнаруженные проблемы с качеством данных
   - применённая нормализация/преобразования
   - рассчитанные метрики
