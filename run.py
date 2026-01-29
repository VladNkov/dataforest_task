import sqlite3
import pandas as pd

DB_PATH = "data.db"

csv_files = {
    'dataset_1': 'data/company_dataset_1.csv',
    'dataset_2': 'data/company_dataset_2.csv'
}

sql_scripts = [
    "sql/ds1_clean_name.sql",
    "sql/ds2_clean_name.sql",
    "sql/ds1_clean_state.sql",
    "sql/ds2_clean_state.sql",
    "sql/ds1_clean_city.sql",
    "sql/ds2_clean_city.sql",
    "sql/ds1_clean_country.sql",
    "sql/ds2_clean_country.sql",
    "sql/ds1_clean_zip.sql",
    "sql/ds2_clean_zip.sql",
    "sql/ds1_clean_all.sql",
    "sql/ds2_clean_all.sql",
    "sql/matching.sql",
    "sql/metrics.sql",
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
conn.close()
print("Done.")
