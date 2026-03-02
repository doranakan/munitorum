-- Seed tournament scenarios
-- Requires: populate_db.sql, populate_test_users.sql, populate_tournament_armies.sql
--
-- Creates 8 tournaments covering every status × format combination:
--
--   #1  Open    + Swiss              (test1–test2,   2 registrations)
--   #2  Open    + Single Elimination (test3–test4,   2 registrations)
--   #3  Ready   + Swiss              (test5–test8,   4 players)
--   #4  Ready   + Single Elimination (test9–test12,  4 players)
--   #5  Started + Swiss              (test13–test16, 4 players — R1 done, R2 in progress)
--   #6  Started + Single Elimination (test17–test20, 4 players — R1 done, Final pending)
--   #7  Ended   + Swiss              (test21–test24, 4 players — 3 rounds, champion: test23)
--   #8  Ended   + Single Elimination (test25–test28, 4 players — 2 rounds, champion: test25)
--
-- No users overlap across tournaments.

-- Temp lookup: user IDs and their tournament army (secret = false, from army seed)
CREATE TEMP TABLE _tseed AS
SELECT
  u.name,
  u.id AS uid,
  (SELECT a.id FROM public.armies a WHERE a.user_id = u.id AND a.secret = false LIMIT 1) AS army_id
FROM public.users u
WHERE u.name = ANY(ARRAY[
  'test1','test2','test3','test4','test5','test6','test7',
  'test8','test9','test10','test11','test12','test13','test14',
  'test15','test16','test17','test18','test19','test20',
  'test21','test22','test23','test24','test25','test26','test27','test28'
]);

DO $$
DECLARE
  -- user IDs
  u1  uuid; u2  uuid; u3  uuid; u4  uuid;
  u5  uuid; u6  uuid; u7  uuid; u8  uuid;
  u9  uuid; u10 uuid; u11 uuid; u12 uuid;
  u13 uuid; u14 uuid; u15 uuid; u16 uuid;
  u17 uuid; u18 uuid; u19 uuid; u20 uuid;
  u21 uuid; u22 uuid; u23 uuid; u24 uuid;
  u25 uuid; u26 uuid; u27 uuid; u28 uuid;

  -- army IDs
  a1  bigint; a2  bigint; a3  bigint; a4  bigint;
  a5  bigint; a6  bigint; a7  bigint; a8  bigint;
  a9  bigint; a10 bigint; a11 bigint; a12 bigint;
  a13 bigint; a14 bigint; a15 bigint; a16 bigint;
  a17 bigint; a18 bigint; a19 bigint; a20 bigint;
  a21 bigint; a22 bigint; a23 bigint; a24 bigint;
  a25 bigint; a26 bigint; a27 bigint; a28 bigint;

  -- tournament IDs
  t1 bigint; t2 bigint; t3 bigint; t4 bigint;
  t5 bigint; t6 bigint; t7 bigint; t8 bigint;

  -- round IDs
  r5_1 bigint; r5_2 bigint;
  r6_1 bigint; r6_2 bigint;
  r7_1 bigint; r7_2 bigint; r7_3 bigint;
  r8_1 bigint; r8_2 bigint;

BEGIN
  -- Load user IDs
  SELECT uid INTO u1  FROM _tseed WHERE name = 'test1';
  SELECT uid INTO u2  FROM _tseed WHERE name = 'test2';
  SELECT uid INTO u3  FROM _tseed WHERE name = 'test3';
  SELECT uid INTO u4  FROM _tseed WHERE name = 'test4';
  SELECT uid INTO u5  FROM _tseed WHERE name = 'test5';
  SELECT uid INTO u6  FROM _tseed WHERE name = 'test6';
  SELECT uid INTO u7  FROM _tseed WHERE name = 'test7';
  SELECT uid INTO u8  FROM _tseed WHERE name = 'test8';
  SELECT uid INTO u9  FROM _tseed WHERE name = 'test9';
  SELECT uid INTO u10 FROM _tseed WHERE name = 'test10';
  SELECT uid INTO u11 FROM _tseed WHERE name = 'test11';
  SELECT uid INTO u12 FROM _tseed WHERE name = 'test12';
  SELECT uid INTO u13 FROM _tseed WHERE name = 'test13';
  SELECT uid INTO u14 FROM _tseed WHERE name = 'test14';
  SELECT uid INTO u15 FROM _tseed WHERE name = 'test15';
  SELECT uid INTO u16 FROM _tseed WHERE name = 'test16';
  SELECT uid INTO u17 FROM _tseed WHERE name = 'test17';
  SELECT uid INTO u18 FROM _tseed WHERE name = 'test18';
  SELECT uid INTO u19 FROM _tseed WHERE name = 'test19';
  SELECT uid INTO u20 FROM _tseed WHERE name = 'test20';
  SELECT uid INTO u21 FROM _tseed WHERE name = 'test21';
  SELECT uid INTO u22 FROM _tseed WHERE name = 'test22';
  SELECT uid INTO u23 FROM _tseed WHERE name = 'test23';
  SELECT uid INTO u24 FROM _tseed WHERE name = 'test24';
  SELECT uid INTO u25 FROM _tseed WHERE name = 'test25';
  SELECT uid INTO u26 FROM _tseed WHERE name = 'test26';
  SELECT uid INTO u27 FROM _tseed WHERE name = 'test27';
  SELECT uid INTO u28 FROM _tseed WHERE name = 'test28';

  -- Load army IDs
  SELECT army_id INTO a1  FROM _tseed WHERE name = 'test1';
  SELECT army_id INTO a2  FROM _tseed WHERE name = 'test2';
  SELECT army_id INTO a3  FROM _tseed WHERE name = 'test3';
  SELECT army_id INTO a4  FROM _tseed WHERE name = 'test4';
  SELECT army_id INTO a5  FROM _tseed WHERE name = 'test5';
  SELECT army_id INTO a6  FROM _tseed WHERE name = 'test6';
  SELECT army_id INTO a7  FROM _tseed WHERE name = 'test7';
  SELECT army_id INTO a8  FROM _tseed WHERE name = 'test8';
  SELECT army_id INTO a9  FROM _tseed WHERE name = 'test9';
  SELECT army_id INTO a10 FROM _tseed WHERE name = 'test10';
  SELECT army_id INTO a11 FROM _tseed WHERE name = 'test11';
  SELECT army_id INTO a12 FROM _tseed WHERE name = 'test12';
  SELECT army_id INTO a13 FROM _tseed WHERE name = 'test13';
  SELECT army_id INTO a14 FROM _tseed WHERE name = 'test14';
  SELECT army_id INTO a15 FROM _tseed WHERE name = 'test15';
  SELECT army_id INTO a16 FROM _tseed WHERE name = 'test16';
  SELECT army_id INTO a17 FROM _tseed WHERE name = 'test17';
  SELECT army_id INTO a18 FROM _tseed WHERE name = 'test18';
  SELECT army_id INTO a19 FROM _tseed WHERE name = 'test19';
  SELECT army_id INTO a20 FROM _tseed WHERE name = 'test20';
  SELECT army_id INTO a21 FROM _tseed WHERE name = 'test21';
  SELECT army_id INTO a22 FROM _tseed WHERE name = 'test22';
  SELECT army_id INTO a23 FROM _tseed WHERE name = 'test23';
  SELECT army_id INTO a24 FROM _tseed WHERE name = 'test24';
  SELECT army_id INTO a25 FROM _tseed WHERE name = 'test25';
  SELECT army_id INTO a26 FROM _tseed WHERE name = 'test26';
  SELECT army_id INTO a27 FROM _tseed WHERE name = 'test27';
  SELECT army_id INTO a28 FROM _tseed WHERE name = 'test28';

    -- ============================================================
  -- #1  Open + Swiss
  --     Players have signed up but not yet selected armies
  -- ============================================================
  INSERT INTO public.tournaments
    (name, address, date, format, status, points_limit, organizer)
  VALUES
    ('Open Swiss GT', 'The Bunker, London',
     now() + interval '14 days', 'swiss', 'open', 500, u1)
  RETURNING id INTO t1;

  INSERT INTO public.tournament_registrations (tournament, "user") VALUES
    (t1, u1),
    (t1, u2);

  -- ============================================================
  -- #2  Open + Single Elimination
  --     Players have signed up but not yet selected armies
  -- ============================================================
  INSERT INTO public.tournaments
    (name, address, date, format, status, points_limit, organizer)
  VALUES
    ('Open Elimination Cup', 'Warhammer World, Nottingham',
     now() + interval '10 days', 'single_elimination', 'open', 500, u3)
  RETURNING id INTO t2;

  INSERT INTO public.tournament_registrations (tournament, "user") VALUES
    (t2, u3),
    (t2, u4);

  -- ============================================================
  -- #3  Ready + Swiss
  --     2 players have selected armies, 2 still pending
  -- ============================================================
  INSERT INTO public.tournaments
    (name, address, date, format, status, points_limit, organizer)
  VALUES
    ('Ready Swiss Championship', 'Dark Sphere, London',
     now() + interval '5 days', 'swiss', 'ready', 500, u5)
  RETURNING id INTO t3;

  INSERT INTO public.tournament_registrations (tournament, "user", army) VALUES
    (t3, u5, a5),
    (t3, u6, a6);

  INSERT INTO public.tournament_registrations (tournament, "user") VALUES
    (t3, u7),
    (t3, u8);

  -- ============================================================
  -- #4  Ready + Single Elimination
  --     All players have selected armies (ready to start)
  -- ============================================================
  INSERT INTO public.tournaments
    (name, address, date, format, status, points_limit, organizer)
  VALUES
    ('Ready Elimination Tournament', 'Warhammer World, Nottingham',
     now() + interval '7 days', 'single_elimination', 'ready', 500, u9)
  RETURNING id INTO t4;

  INSERT INTO public.tournament_registrations (tournament, "user", army) VALUES
    (t4, u9,  a9),
    (t4, u10, a10),
    (t4, u11, a11),
    (t4, u12, a12);

  -- ============================================================
  -- #5  Started + Swiss
  --     R1 complete, R2 in progress
  --     R1: test13 85–40 test14 ✓  |  test15 50–60 test16 ✓
  --     R2: test13 70–50 test16 (reported, pending confirmation)
  --         test14 vs test15 (pending, not yet played)
  -- ============================================================
  INSERT INTO public.tournaments
    (name, address, date, format, status, points_limit, organizer)
  VALUES
    ('Battle for the Warp – Swiss', 'The Overlords, Manchester',
     now() - interval '1 day', 'swiss', 'started', 500, u13)
  RETURNING id INTO t5;

  INSERT INTO public.tournament_registrations (tournament, "user", army) VALUES
    (t5, u13, a13),
    (t5, u14, a14),
    (t5, u15, a15),
    (t5, u16, a16);

  INSERT INTO public.tournament_rounds (tournament, round_number, status)
  VALUES (t5, 1, 'completed')
  RETURNING id INTO r5_1;

  INSERT INTO public.tournament_matches
    (round, player_one, player_two, player_one_score, player_two_score, winner, mode, status)
  VALUES
    (r5_1, u13, u14, 85, 40, u13, 'light', 'confirmed'),
    (r5_1, u15, u16, 50, 60, u16, 'light', 'confirmed');

  INSERT INTO public.tournament_rounds (tournament, round_number, status)
  VALUES (t5, 2, 'active')
  RETURNING id INTO r5_2;

  INSERT INTO public.tournament_matches
    (round, player_one, player_two, player_one_score, player_two_score, mode, status)
  VALUES
    (r5_2, u13, u16, 70, 50, 'light', 'reported'),
    (r5_2, u14, u15, null, null, null, 'pending');

  -- ============================================================
  -- #6  Started + Single Elimination
  --     R1 complete, Final pending
  --     R1: test17 90–30 test18 ✓  |  test19 75–45 test20 ✓
  --     Final: test17 vs test19 (pending)
  -- ============================================================
  INSERT INTO public.tournaments
    (name, address, date, format, status, points_limit, organizer)
  VALUES
    ('Battle for the Warp – Elimination', 'The Overlords, Manchester',
     now() - interval '1 day', 'single_elimination', 'started', 500, u17)
  RETURNING id INTO t6;

  INSERT INTO public.tournament_registrations (tournament, "user", army) VALUES
    (t6, u17, a17),
    (t6, u18, a18),
    (t6, u19, a19),
    (t6, u20, a20);

  INSERT INTO public.tournament_rounds (tournament, round_number, status)
  VALUES (t6, 1, 'completed')
  RETURNING id INTO r6_1;

  INSERT INTO public.tournament_matches
    (round, player_one, player_two, player_one_score, player_two_score, winner, mode, status)
  VALUES
    (r6_1, u17, u18, 90, 30, u17, 'light', 'confirmed'),
    (r6_1, u19, u20, 75, 45, u19, 'light', 'confirmed');

  INSERT INTO public.tournament_rounds (tournament, round_number, status)
  VALUES (t6, 2, 'active')
  RETURNING id INTO r6_2;

  INSERT INTO public.tournament_matches (round, player_one, player_two, status)
  VALUES (r6_2, u17, u19, 'pending');

  -- ============================================================
  -- #7  Ended + Swiss
  --     3 rounds, champion: test23 (3W-0L, 195pts)
  --
  --     R1: test21 85–40 test22 ✓  |  test23 70–35 test24 ✓
  --     R2: test23 60–50 test21 ✓  |  test22 80–25 test24 ✓
  --     R3: test23 65–50 test22 ✓  |  test21 55–40 test24 ✓
  --
  --     Final standings:
  --       1st test23  3W-0L  195pts (70+60+65)
  --       2nd test21  2W-1L  190pts (85+50+55)
  --       3rd test22  1W-2L  170pts (40+80+50)
  --       4th test24  0W-3L  100pts (35+25+40)
  -- ============================================================
  INSERT INTO public.tournaments
    (name, address, date, format, status, points_limit, organizer)
  VALUES
    ('Siege of Terra – Swiss', 'Warhammer World, Nottingham',
     now() - interval '7 days', 'swiss', 'ended', 500, u21)
  RETURNING id INTO t7;

  INSERT INTO public.tournament_registrations (tournament, "user", army) VALUES
    (t7, u21, a21),
    (t7, u22, a22),
    (t7, u23, a23),
    (t7, u24, a24);

  INSERT INTO public.tournament_rounds (tournament, round_number, status)
  VALUES (t7, 1, 'completed')
  RETURNING id INTO r7_1;

  INSERT INTO public.tournament_matches
    (round, player_one, player_two, player_one_score, player_two_score, winner, mode, status)
  VALUES
    (r7_1, u21, u22, 85, 40, u21, 'light', 'confirmed'),
    (r7_1, u23, u24, 70, 35, u23, 'light', 'confirmed');

  INSERT INTO public.tournament_rounds (tournament, round_number, status)
  VALUES (t7, 2, 'completed')
  RETURNING id INTO r7_2;

  INSERT INTO public.tournament_matches
    (round, player_one, player_two, player_one_score, player_two_score, winner, mode, status)
  VALUES
    (r7_2, u23, u21, 60, 50, u23, 'light', 'confirmed'),
    (r7_2, u22, u24, 80, 25, u22, 'light', 'confirmed');

  INSERT INTO public.tournament_rounds (tournament, round_number, status)
  VALUES (t7, 3, 'completed')
  RETURNING id INTO r7_3;

  INSERT INTO public.tournament_matches
    (round, player_one, player_two, player_one_score, player_two_score, winner, mode, status)
  VALUES
    (r7_3, u23, u22, 65, 50, u23, 'light', 'confirmed'),
    (r7_3, u21, u24, 55, 40, u21, 'light', 'confirmed');

  -- ============================================================
  -- #8  Ended + Single Elimination
  --     2 rounds, champion: test25
  --
  --     R1: test25 85–30 test26 ✓  |  test27 70–45 test28 ✓
  --     Final: test25 60–55 test27 ✓
  -- ============================================================
  INSERT INTO public.tournaments
    (name, address, date, format, status, points_limit, organizer)
  VALUES
    ('Siege of Terra – Elimination', 'Warhammer World, Nottingham',
     now() - interval '7 days', 'single_elimination', 'ended', 500, u25)
  RETURNING id INTO t8;

  INSERT INTO public.tournament_registrations (tournament, "user", army) VALUES
    (t8, u25, a25),
    (t8, u26, a26),
    (t8, u27, a27),
    (t8, u28, a28);

  INSERT INTO public.tournament_rounds (tournament, round_number, status)
  VALUES (t8, 1, 'completed')
  RETURNING id INTO r8_1;

  INSERT INTO public.tournament_matches
    (round, player_one, player_two, player_one_score, player_two_score, winner, mode, status)
  VALUES
    (r8_1, u25, u26, 85, 30, u25, 'light', 'confirmed'),
    (r8_1, u27, u28, 70, 45, u27, 'light', 'confirmed');

  INSERT INTO public.tournament_rounds (tournament, round_number, status)
  VALUES (t8, 2, 'completed')
  RETURNING id INTO r8_2;

  INSERT INTO public.tournament_matches
    (round, player_one, player_two, player_one_score, player_two_score, winner, mode, status)
  VALUES
    (r8_2, u25, u27, 60, 55, u25, 'light', 'confirmed');

END $$;

DROP TABLE _tseed;
