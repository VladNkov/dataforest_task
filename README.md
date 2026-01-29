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

Результати зберігаються у папці `data/`:
- `merged_dataset.csv` — об'єднаний датасет
- `metrics.csv` — розраховані метрики

## Запуск без Docker

```bash
pip install -r requirements.txt
python run.py
```
