-- Replaced relay column with type column in swimming table so it's more understandable to humans
BEGIN;

ALTER TABLE swimming ADD COLUMN Type TEXT;

UPDATE swimming
SET Type =
  CASE
    WHEN Relay = 0 THEN 'Individual'
    WHEN Relay = 1 THEN 'Relay'
  END
WHERE Results IS NOT NULL;

ALTER TABLE swimming DROP COLUMN Relay;

COMMIT;
-- //python .\scripts\run_sql_file.py .\examples\replace_relay_with_type.sql