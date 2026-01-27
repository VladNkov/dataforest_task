import sqlite3
import pandas as pd

DB_PATH = "data.db"

files = {
    'dataset_1': 'company_dataset_1.csv',
    'dataset_2': 'company_dataset_2.csv'
}


conn = sqlite3.connect(DB_PATH)

for table, csv_path in files.items():
    df = pd.read_csv(csv_path)
    df.to_sql(table, conn, if_exists="replace", index=False)
    print(f"Loaded {len(df)} rows into {table}")

conn.close()
print("Done.")

