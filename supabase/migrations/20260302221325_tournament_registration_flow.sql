-- ============================================================
-- Tournament registration flow update
-- ============================================================
-- 1. army is now selected separately when tournament moves to
--    Ready — not at sign-up time. Make the column nullable.
-- 2. points_limit is now mandatory on every tournament.
-- ============================================================

-- 1. Make army nullable in tournament_registrations
ALTER TABLE tournament_registrations
  ALTER COLUMN army DROP NOT NULL;

-- 2. Make points_limit NOT NULL in tournaments
--    Back-fill any existing rows that have no value.
UPDATE tournaments
  SET points_limit = 500
  WHERE points_limit IS NULL;

ALTER TABLE tournaments
  ALTER COLUMN points_limit SET NOT NULL;
