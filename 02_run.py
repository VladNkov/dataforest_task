import sqlite3

DB_PATH = "data.db"

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

for script in sql_scripts:
    with open(script, "r", encoding="utf-8") as f:
        conn.executescript(f.read())
    print(f"executed: {script}")

conn.commit()
conn.close()
print("Done.")
