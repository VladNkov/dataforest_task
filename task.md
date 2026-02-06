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

## Мета

Зіставити компанії у двох наборах даних на основі назв компаній та їхнього місцезнаходження й отримати об'єднаний результат.

## Набори даних

Вам надано два набори даних, обидва містять інформацію про компанії, зокрема:

- назва компанії
- місцезнаходження (вулиця, місто, провінція/штат, країна, поштовий індекс)

## Вимоги

~~1. Зіставте компанії між Набором даних 1 та Набором даних 2 на основі:
   - назви компанії
   - інформації про місцезнаходження~~
2. Створіть об'єднаний набір даних, який:
   - містить усі компанії та місцезнаходження з Набору даних 1
   - включає відповідні збіги з Набору даних 2, якщо вони існують
   - **Важливо:** зберігайте збіги компаній, навіть якщо їхні місцезнаходження не збігаються
3. Розрахуйте такі метрики:
   - відсоток збігів: % компаній з Набору даних 1, що мають збіг у Наборі даних 2
   - записи без збігів: % компаній, що не мають збігів у жодному з наборів даних
   - збіги «один до багатьох»: % компаній із кількома записами збігів
   - інші метрики, які ви вважаєте корисними

## Обмеження

- Обмеження за часом: 3 години
- Інструменти: використовуйте будь-яку мову програмування або інструмент на ваш вибір

## Результати роботи

1. Об'єднаний набір даних (CSV)
2. Скрипти коду
3. Документація:
   - підхід до зіставлення
   - виявлені проблеми з якістю даних
   - застосована нормалізація/перетворення
   - розраховані метрики
