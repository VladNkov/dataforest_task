import sqlite3

DB_PATH = "data.db"


sql_scripts = ["sql/clean/ds1_step3.sql"]


conn = sqlite3.connect(DB_PATH)

for script in sql_scripts:
    with open(script, "r", encoding="utf-8") as f:
        conn.executescript(f.read())
conn.commit()
conn.close()