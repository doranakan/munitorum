-- Add optional army points limit to tournaments.
-- When set, players must register with an army at or below this point value.
-- NULL means no limit is enforced.
ALTER TABLE tournaments
  ADD COLUMN points_limit integer;
