# Запуск проєкту в Docker-контейнері

## Вимоги

- Docker

## Збірка образу

```bash
docker build -t dataforest .
```

## Запуск

```bash
docker run --rm -v $(pwd)/data:/app/data dataforest
```

Результати зберігаються у папці `data/output`:

| Файл | Опис |
|------|------|
| `task1.csv` | Зіставлення компаній DS1 з DS2 (LEFT JOIN за назвою) |
| `task2.csv` | Об'єднаний набір даних (всі DS1 + збіги з DS2) |
| `task3.csv` | Розраховані метрики |

## Запуск без Docker

```bash
pip install -r requirements.txt
python main.py
```
