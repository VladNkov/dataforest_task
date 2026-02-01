import sqlite3
import pandas as pd
import glob


DB_PATH = 'data.db'
csv_files = {'dataset_1': 'data/input/company_dataset_1.csv', 'dataset_2': 'data/input/company_dataset_2.csv'}
clean = 'sql/clean/*.sql'
analytics = 'sql/analytics/*.sql'


def load_csv(conn: sqlite3.Connection, csv_files: dict) -> None:
    for table, csv_path in csv_files.items():
        df = pd.read_csv(csv_path)
        df.to_sql(table, conn, if_exists="replace", index=False)


def run_sql_file(conn: sqlite3.Connection, file_path: str) -> None:
    with open(file_path, 'r', encoding='utf-8') as f:
        sql = f.read()
    conn.executescript(sql)


def run_folder(conn: sqlite3.Connection, pattern: str) -> None:
    files = sorted(glob.glob(pattern))
    print('SQL files:', files)
    for fp in files:
        run_sql_file(conn, fp)
        print('running file:', fp)


def main() -> None:
    with sqlite3.connect(DB_PATH) as conn:
        load_csv(conn, csv_files)
        run_folder(conn, clean)


if __name__ == "__main__":
    main()


