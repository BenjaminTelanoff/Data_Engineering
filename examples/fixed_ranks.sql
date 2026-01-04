BEGIN;
-- Add a column to store corrected ranks
ALTER TABLE swimming
ADD COLUMN CorrectRank INTEGER;

-- Populate CorrectRank using proper Olympic ranking rules
WITH ranked AS (
    SELECT
        rowid AS rid,
        CASE
            -- No valid time → 0
            WHEN Results NOT LIKE '%:%' THEN 0
            ELSE
                CASE
                    -- Dense ranking per event
                    WHEN DENSE_RANK() OVER (
                        PARTITION BY Location, Year, Distance, Stroke, Relay, Gender
                        ORDER BY Results
                    ) >= 4 THEN 4
                    ELSE DENSE_RANK() OVER (
                        PARTITION BY Location, Year, Distance, Stroke, Relay, Gender
                        ORDER BY Results
                    )
                END
        END AS correct_rank
    FROM swimming
)
UPDATE swimming
SET CorrectRank = (
    SELECT correct_rank
    FROM ranked
    WHERE ranked.rid = swimming.rowid
);
COMMIT;