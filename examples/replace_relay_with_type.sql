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
