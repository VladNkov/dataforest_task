import sqlite3
import pandas as pd

DB_PATH = "data.db"

csv_files = {
    'dataset_1': 'data/input/company_dataset_1.csv',
    'dataset_2': 'data/input/company_dataset_2.csv'
}

sql_scripts = [
    "sql/clean/ds1_clean_name.sql",
    "sql/clean/ds2_clean_name.sql",
    "sql/clean/ds1_clean_state.sql",
    "sql/clean/ds2_clean_state.sql",
    "sql/clean/ds1_clean_city.sql",
    "sql/clean/ds2_clean_city.sql",
    "sql/clean/ds1_clean_country.sql",
    "sql/clean/ds2_clean_country.sql",
    "sql/clean/ds1_clean_zip.sql",
    "sql/clean/ds2_clean_zip.sql",
    "sql/clean/ds1_clean_all.sql",
    "sql/clean/ds2_clean_all.sql",
    "sql/analytics/matching.sql",
    "sql/analytics/metrics.sql",
]

conn = sqlite3.connect(DB_PATH)

for table, csv_path in csv_files.items():
    df = pd.read_csv(csv_path)
    df.to_sql(table, conn, if_exists="replace", index=False)
    print(f"Loaded {len(df)} rows into {table}")

for script in sql_scripts:
    with open(script, "r", encoding="utf-8") as f:
        conn.executescript(f.read())
    print(f"executed: {script}")

conn.commit()

pd.read_sql("SELECT * FROM matched_companies", conn).to_csv("data/output/merged_dataset.csv", index=False)
print("exported: merged_dataset.csv")

pd.read_sql("SELECT * FROM metrics", conn).to_csv("data/output/metrics.csv", index=False)
print("exported: metrics.csv")

conn.close()
print("Done.")
