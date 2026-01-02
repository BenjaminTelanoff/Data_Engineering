# run_examples.ps1
# Runs every .sql file in the examples directory against data\example.db using sqlite3 (if available).

$sqlite = Get-Command sqlite3 -ErrorAction SilentlyContinue
if (-not $sqlite) {
    Write-Host "sqlite3 not found. Install SQLite and ensure 'sqlite3' is on your PATH, or run 'sqlite3.exe' with the path to the DB." -ForegroundColor Yellow
    exit 1
}

$db = Join-Path -Path $PSScriptRoot -ChildPath "..\data\example.db" | Resolve-Path -Relative
if (-not (Test-Path $db)) {
    Write-Host "Database not found. Creating using scripts\create_example_db.sql" -ForegroundColor Cyan
    sqlite3 $db < (Join-Path $PSScriptRoot 'create_example_db.sql')
}

Get-ChildItem -Path (Join-Path $PSScriptRoot '..\examples') -Filter '*.sql' | ForEach-Object {
    Write-Host "Running example: $($_.Name)" -ForegroundColor Green
    sqlite3 $db < $_.FullName
}
