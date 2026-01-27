import sqlite3

conn = sqlite3.connect("data.db")
with open("sql/01_clean_name.sql", "r", encoding="utf-8") as f:
    conn.executescript(f.read())
conn.commit()
conn.close()