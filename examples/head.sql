-- head.sql: select the first 10 rows from the imported swimming table
SELECT location, COUNT(*) FROM swimming
group BY location
;

-- python .\scripts\run_sql_file.py .\examples\head.sql data\example.db

-- only places with 2 or more distinct years are angeles london tokyo