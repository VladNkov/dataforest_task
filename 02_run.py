import sqlite3

conn = sqlite3.connect("data.db")
# with open("sql/ds2_name_clean.sql", "r", encoding="utf-8") as f:
# with open("sql/ds1_clean_location.sql", "r", encoding="utf-8") as f:
with open("sql/ds2_clean_city.sql", "r", encoding="utf-8") as f:
    conn.executescript(f.read())
conn.commit()
conn.close()