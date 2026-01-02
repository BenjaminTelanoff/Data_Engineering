"""
import_swimming.py

Import an Olympic swimming CSV into a SQLite database.
Usage: python scripts/import_swimming.py path/to/Olympic_Swimming_Results.csv data/example.db
If db path omitted, defaults to data/example.db.
"""
import csv
import sqlite3
import sys
from pathlib import Path

CSV_HEADERS = [
    "Location",
    "Year",
    "Distance (in meters)",
    "Stroke",
    "Relay?",
    "Gender",
    "Team",
    "Athlete",
    "Results",
    "Rank",
]


def create_table(conn):
    conn.execute('''
    CREATE TABLE IF NOT EXISTS swimming (
      Location TEXT,
      Year INTEGER,
      Distance TEXT,
      Stroke TEXT,
      Relay INTEGER,
      Gender TEXT,
      Team TEXT,
      Athlete TEXT,
      Results TEXT,
      Rank INTEGER
    );
    ''')


def parse_int(value):
    try:
        return int(value)
    except Exception:
        return None


def import_csv(csv_path, db_path):
    csv_path = Path(csv_path)
    db_path = Path(db_path)
    if not csv_path.exists():
        print(f"CSV not found: {csv_path}")
        return 1

    conn = sqlite3.connect(str(db_path))
    create_table(conn)
    cur = conn.cursor()

    with csv_path.open(encoding='utf-8-sig', newline='') as fh:
        reader = csv.DictReader(fh)
        rows = []
        for r in reader:
            loc = r.get('Location')
            year = parse_int(r.get('Year'))
            distance = r.get('Distance (in meters)') or r.get('Distance')
            stroke = r.get('Stroke')
            relay = parse_int(r.get('Relay?') or r.get('Relay'))
            gender = r.get('Gender')
            team = r.get('Team')
            athlete = r.get('Athlete')
            results = r.get('Results')
            rank = parse_int(r.get('Rank'))
            rows.append((loc, year, distance, stroke, relay, gender, team, athlete, results, rank))

    cur.executemany(
        'INSERT INTO swimming (Location, Year, Distance, Stroke, Relay, Gender, Team, Athlete, Results, Rank) VALUES (?,?,?,?,?,?,?,?,?,?)',
        rows
    )
    conn.commit()
    conn.close()
    print(f"Imported {len(rows)} rows into {db_path}")
    return 0


if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Usage: python scripts/import_swimming.py <csv-path> [<db-path>]")
        sys.exit(2)
    csv_path = sys.argv[1]
    db_path = sys.argv[2] if len(sys.argv) > 2 else 'data/example.db'
    sys.exit(import_csv(csv_path, db_path))
