"""
Run a SQL file against the example SQLite DB and print results (pretty table for SELECTs when rich is available).
Usage: python scripts/run_sql_file.py path/to/file.sql [path/to/db]
"""
import sqlite3
import sys
import csv
from pathlib import Path

try:
    from rich.table import Table
    from rich.console import Console
    _HAS_RICH = True
    _CONSOLE = Console()
except Exception:
    _HAS_RICH = False
    _CONSOLE = None

if len(sys.argv) < 2:
    print("Usage: python scripts/run_sql_file.py <sql-file> [<db-path>]")
    sys.exit(2)

sql_path = Path(sys.argv[1])
db_path = Path(sys.argv[2]) if len(sys.argv) > 2 else Path('data') / 'example.db'

if not sql_path.exists():
    print(f"SQL file not found: {sql_path}")
    sys.exit(1)

if not db_path.exists():
    print(f"Database not found: {db_path}")
    sys.exit(1)

sql = sql_path.read_text(encoding='utf-8')

con = sqlite3.connect(str(db_path))
cur = con.cursor()
try:
    try:
        # Try executing a single statement (works for SELECTs)
        cur.execute(sql)
        rows = cur.fetchall()
        if cur.description:
            headers = [d[0] for d in cur.description]
            if _HAS_RICH:
                table = Table(show_header=True, header_style="bold magenta")
                for h in headers:
                    table.add_column(h)
                for row in rows:
                    # Convert all values to str for display
                    table.add_row(*["" if v is None else str(v) for v in row])
                _CONSOLE.print(table)
            else:
                writer = csv.writer(sys.stdout)
                writer.writerow(headers)
                writer.writerows(rows)
    except (sqlite3.ProgrammingError, sqlite3.OperationalError):
        # Multiple statements or other operational error — execute as a script
        con.executescript(sql)
        print("Executed script (no SELECT results to show).")
finally:
    con.close()
