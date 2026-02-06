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
1. Зіставте компанії між Набором даних 1 та Набором даних 2 на основі назви компанії та інформації про місцезнаходження
- `task1.csv` — об'єднаний датасет
- `metrics.csv` — розраховані метрики

## Запуск без Docker

```bash
pip install -r requirements.txt
python main.py
```
