-- Replaced rank with medal column in swimming table so it's more understandable to humans
BEGIN;

ALTER TABLE swimming ADD COLUMN Medal TEXT;

DELETE FROM swimming WHERE Rank = 5;

UPDATE swimming
SET Medal =
  CASE
    WHEN Rank = 1 THEN 'GOLD'
    WHEN Rank = 2 THEN 'SILVER'
    WHEN Rank = 3 THEN 'BRONZE'
    WHEN Rank = 4 THEN 'No Medal'
    WHEN Results = 'Disqualified' THEN 'DQ'
    WHEN Results = 'Did not finish' THEN 'DNF'
    WHEN Results = 'Did not start' THEN 'DNS'
  END
WHERE Results IS NOT NULL;

ALTER TABLE swimming DROP COLUMN RANK;

COMMIT;
