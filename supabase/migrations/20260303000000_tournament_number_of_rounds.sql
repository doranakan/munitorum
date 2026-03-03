-- Add number_of_rounds to tournaments (Swiss format only)
ALTER TABLE tournaments
  ADD COLUMN number_of_rounds smallint;
