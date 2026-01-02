-- create_swimming_table.sql
-- Creates the table for the Olympic swimming CSV import

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
