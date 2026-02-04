import sqlite3
import pandas as pd
import glob


DB_PATH = 'data.db'
csv_files = {'dataset_1': 'data/input/company_dataset_1.csv',
             'dataset_2': 'data/input/company_dataset_2.csv'}
clean = 'sql/clean/*.sql'
analytics = 'sql/analytics/*.sql'


def load_csv(conn: sqlite3.Connection, csv_files: dict):
    for table, csv_path in csv_files.items():
        df = pd.read_csv(csv_path)
        df.to_sql(table, conn, if_exists="replace", index=False)
        print(f'loaded {len(df)} rows into {table}')


def run_sql_file(conn: sqlite3.Connection, file_path: str):
    with open(file_path, 'r', encoding='utf-8') as f:
        sql = f.read()
    conn.executescript(sql)


def run_folder(conn: sqlite3.Connection, pattern: str):
    files = sorted(glob.glob(pattern))
    # print('SQL files:', files)
    for fp in files:
        run_sql_file(conn, fp)
        print('running file:', fp)


def export_table(conn: sqlite3.Connection, table: str, output_path: str):
    df = pd.read_sql(f"SELECT * FROM {table}", conn)
    df.to_csv(output_path, index=False)
    print(f'exported {len(df)} rows to {output_path}')


def main():
    with sqlite3.connect(DB_PATH) as conn:
        load_csv(conn, csv_files)
        run_folder(conn, clean)
        run_folder(conn, analytics)
        export_table(conn, 'task1', 'data/output/task1.csv')


if __name__ == "__main__":
    main()


