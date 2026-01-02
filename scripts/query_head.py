"""
Query the first N rows from the swimming table and print as CSV.
Usage: python scripts/query_head.py [N]
"""
import sqlite3
import csv
import sys
import os

n = int(sys.argv[1]) if len(sys.argv) > 1 else 10
script_dir = os.path.dirname(__file__)
db_path = os.path.abspath(os.path.join(script_dir, '..', 'data', 'example.db'))

if not os.path.exists(db_path):
    print(f"Database not found at {db_path}")
    sys.exit(1)

con = sqlite3.connect(db_path)
cur = con.cursor()
try:
    cur.execute('SELECT * FROM swimming LIMIT ?', (n,))
    rows = cur.fetchall()
    headers = [d[0] for d in cur.description] if cur.description else []
    writer = csv.writer(sys.stdout)
    if headers:
        writer.writerow(headers)
    for r in rows:
        writer.writerow(r)
finally:
    con.close()
