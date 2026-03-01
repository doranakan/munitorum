-- Seed armies
-- Self-contained: embeds all army data inline, no dependency on existing army IDs.
-- Requires: populate_db.sql (codexes, units, tiers, detachments) and populate_test_users.sql to have run first.
--
-- Assignment pattern:
--   Army 1  (Adepta Sororitas)   → test1,  test11, test21
--   Army 2  (Drukhari)           → test2,  test12, test22
--   Army 3  (World Eaters)       → test3,  test13, test23
--   Army 4  (Chaos Space Marines)→ test4,  test14, test24
--   Army 5  (Genestealer Cults)  → test5,  test15, test25
--   Army 6  (Necrons)            → test6,  test16, test26
--   Army 7  (T''au Empire)       → test7,  test17, test27
--   Army 8  (Space Marines)      → test8,  test18, test28
--   Army 9  (Astra Militarum)    → test9,  test19, test29
--   Army 10 (Imperial Agents)    → test10, test20, test30

WITH army_templates (army_num, name, points, codex, detachment, roster) AS (
  VALUES
    (
      1,
      'Army 1',
      485,
      161,
      '{"id": 90, "name": "Army of Faith", "enhancements": [{"id": 403, "name": "Triptych of the Macharian Crusade", "points": 20}]}'::jsonb,
      '[{"id": 1485, "hero": false, "name": "Canoness", "tier": {"id": 1920, "models": 1, "points": 60}, "type": "leader", "warlord": true, "upgrades": [], "enhancement": {"id": 403, "name": "Triptych of the Macharian Crusade", "points": 20}, "selectionId": "00add158-f704-4fdf-a412-d1fe63dd2854"}, {"id": 1484, "name": "Battle Sisters Squad", "tier": {"id": 1919, "models": 10, "points": 105}, "type": "squad", "upgrades": [], "selectionId": "21d04c99-39fd-46be-ab59-d706d4925ce9"}, {"id": 1484, "name": "Battle Sisters Squad", "tier": {"id": 1919, "models": 10, "points": 105}, "type": "squad", "upgrades": [], "selectionId": "55c39f54-d390-48f1-8bb9-c64f7ee04254"}, {"id": 1496, "name": "Immolator", "tier": {"id": 1932, "models": 1, "points": 115}, "type": "transport", "upgrades": [], "selectionId": "7c94b4ae-4945-4f2c-9667-457d60aa8cd9"}, {"id": 1507, "name": "Seraphim Squad", "tier": {"id": 1946, "models": 5, "points": 80}, "type": "squad", "upgrades": [], "selectionId": "b4c94ae1-942c-47be-a8e6-a5327dfb28a0"}]'::jsonb
    ),
    (
      2,
      'Army 2',
      490,
      174,
      '{"id": 266, "name": "Kabalite Cartel", "enhancements": [{"id": 1108, "name": "Leechbite Plate", "points": 5}]}'::jsonb,
      '[{"id": 1873, "hero": false, "name": "Archon", "tier": {"id": 2422, "models": 1, "points": 80}, "type": "leader", "warlord": true, "upgrades": [], "enhancement": {"id": 1108, "name": "Leechbite Plate", "points": 5}, "selectionId": "91e24e22-6b84-434e-a3e5-c3b2e46f6968"}, {"id": 1882, "name": "Kabalite Warriors", "tier": {"id": 2435, "models": 10, "points": 115}, "type": "squad", "upgrades": [], "selectionId": "4c973d2b-92be-4e13-992c-18b8f4db6487"}, {"id": 1882, "name": "Kabalite Warriors", "tier": {"id": 2435, "models": 10, "points": 115}, "type": "squad", "upgrades": [], "selectionId": "adc9d58d-54e8-442c-9087-0e20ac5fdb73"}, {"id": 1886, "name": "Ravager", "tier": {"id": 2440, "models": 1, "points": 110}, "type": "vehicle", "upgrades": [], "selectionId": "4441e43a-507a-476c-b39e-fb7cbbb4b314"}, {"id": 1895, "name": "Wracks", "tier": {"id": 2452, "models": 5, "points": 65}, "type": "squad", "upgrades": [], "selectionId": "ba4a9870-d10e-4fea-a50a-cd7d6e5f6ecc"}]'::jsonb
    ),
    (
      3,
      'Army 3',
      500,
      187,
      '{"id": 226, "name": "Khorne Daemonkin", "enhancements": [{"id": 943, "name": "Blood-forged Armour", "points": 20}]}'::jsonb,
      '[{"id": 2359, "name": "Chaos Terminators", "tier": {"id": 3052, "models": 5, "points": 175}, "type": "squad", "upgrades": [], "selectionId": "c0eb1d0a-316d-43ff-975d-08f465058145"}, {"id": 2341, "name": "Khorne Berzerkers", "tier": {"id": 3034, "models": 10, "points": 180}, "type": "squad", "upgrades": [], "selectionId": "9ce8dcc5-8177-4a5d-8acd-f87b112e9cc1"}, {"id": 2354, "hero": false, "name": "Master of Executions", "tier": {"id": 3047, "models": 1, "points": 60}, "type": "leader", "warlord": true, "upgrades": [], "enhancement": {"id": 943, "name": "Blood-forged Armour", "points": 20}, "selectionId": "068d3c7a-b2cd-4a67-9c35-837cf81bd6f7"}, {"id": 2340, "name": "Jakhals", "tier": {"id": 3031, "models": 10, "points": 65}, "type": "squad", "upgrades": [], "selectionId": "b36988d3-4f6a-4e7e-8e46-eaceff222e6e"}]'::jsonb
    ),
    (
      4,
      'Army 4',
      495,
      170,
      '{"id": 191, "name": "Creations of Bile", "enhancements": [{"id": 803, "name": "Living Carapace", "points": 15}]}'::jsonb,
      '[{"id": 1779, "hero": false, "name": "Chaos Lord", "tier": {"id": 2309, "models": 1, "points": 90}, "type": "leader", "warlord": true, "upgrades": [], "enhancement": {"id": 803, "name": "Living Carapace", "points": 15}, "selectionId": "c9c4974b-6f50-4fac-ac3c-d6c143d1f802"}, {"id": 1790, "name": "Cultist Mob", "tier": {"id": 2323, "models": 20, "points": 100}, "type": "squad", "upgrades": [], "selectionId": "90a82944-553a-4e47-a7d4-87d178f02bfc"}, {"id": 1806, "name": "Legionaries", "tier": {"id": 2339, "models": 5, "points": 90}, "type": "squad", "upgrades": [], "selectionId": "7d967bca-0e00-4ee0-a0bf-b8dc3dd970de"}, {"id": 1810, "name": "Maulerfiend", "tier": {"id": 2344, "models": 1, "points": 130}, "type": "vehicle", "upgrades": [], "selectionId": "d285f094-e240-499f-a2a9-a542ce9d3dfb"}, {"id": 1818, "name": "Traitor Guardsmen Squad", "tier": {"id": 2354, "models": 10, "points": 70}, "type": "squad", "upgrades": [], "selectionId": "71bd0384-74af-4613-9fd0-3af692068d93"}]'::jsonb
    ),
    (
      5,
      'Army 5',
      490,
      175,
      '{"id": 127, "name": "Host of Ascension", "enhancements": [{"id": 551, "name": "Prowling Agitant", "points": 15}]}'::jsonb,
      '[{"id": 1900, "name": "Acolyte Hybrids with Autopistols", "tier": {"id": 2460, "models": 5, "points": 65}, "type": "squad", "upgrades": [], "selectionId": "1a1937b8-9682-4d2c-8692-6f779dd2c68a"}, {"id": 1901, "name": "Acolyte Hybrids with Hand Flamers", "tier": {"id": 2462, "models": 5, "points": 70}, "type": "squad", "upgrades": [], "selectionId": "c39adcf2-f1ae-4d31-88c6-471838380777"}, {"id": 1897, "name": "Aberrants", "tier": {"id": 2455, "models": 5, "points": 135}, "type": "squad", "upgrades": [], "selectionId": "f9f505fb-fd05-4b33-ba6c-bd733efa7d3c"}, {"id": 1908, "name": "Goliath Truck", "tier": {"id": 2471, "models": 1, "points": 85}, "type": "transport", "upgrades": [], "selectionId": "7b6deb5a-1bae-4b6b-81d9-bdf17f7c858f"}, {"id": 1902, "name": "Acolyte Iconward", "tier": {"id": 2464, "models": 1, "points": 50}, "type": "squad", "upgrades": [], "selectionId": "461a118e-19cd-4d91-ba68-a65c478d9eee"}, {"id": 1917, "hero": false, "name": "Primus", "tier": {"id": 2482, "models": 1, "points": 70}, "type": "leader", "warlord": true, "upgrades": [], "enhancement": {"id": 551, "name": "Prowling Agitant", "points": 15}, "selectionId": "b688be28-a499-4939-8302-50c9ce07e020"}]'::jsonb
    ),
    (
      6,
      'Army 6',
      500,
      180,
      '{"id": 139, "name": "Canoptek Court", "enhancements": [{"id": 600, "name": "Metalodermal Tesla Weave", "points": 10}]}'::jsonb,
      '[{"id": 2009, "hero": false, "name": "Chronomancer", "tier": {"id": 2590, "models": 1, "points": 65}, "type": "leader", "warlord": true, "upgrades": [], "enhancement": {"id": 600, "name": "Metalodermal Tesla Weave", "points": 10}, "selectionId": "4cca4e0f-5802-4d10-89a4-524e5c2ef910"}, {"id": 2006, "name": "Canoptek Spyders", "tier": {"id": 2586, "models": 2, "points": 150}, "type": "squad", "upgrades": [], "selectionId": "2c6e04f0-087e-49bd-9476-035245ca533a"}, {"id": 2469, "name": "Canoptek Tomb Crawlers", "tier": {"id": 3236, "models": 2, "points": 50}, "type": "squad", "upgrades": [], "selectionId": "22e244f6-f404-4843-a615-710ca835e8bb"}, {"id": 2007, "name": "Canoptek Wraiths", "tier": {"id": 2587, "models": 3, "points": 110}, "type": "squad", "upgrades": [], "selectionId": "401f37dc-0ff5-4328-8537-075527febe7b"}, {"id": 2005, "name": "Canoptek Scarab Swarms", "tier": {"id": 2583, "models": 3, "points": 40}, "type": "squad", "upgrades": [], "selectionId": "bffd863c-dab2-4257-a6b5-62ea5915160d"}, {"id": 2004, "name": "Canoptek Reanimator", "tier": {"id": 2582, "models": 1, "points": 75}, "type": "vehicle", "upgrades": [], "selectionId": "7b0e2820-2278-4548-bf6d-0d87064e6a09"}]'::jsonb
    ),
    (
      7,
      'Army 7',
      495,
      184,
      '{"id": 179, "name": "Auxiliary Cadre", "enhancements": []}'::jsonb,
      '[{"id": 2228, "hero": false, "name": "Commander in Coldstar Battlesuit", "tier": {"id": 2880, "models": 1, "points": 95}, "type": "leader", "warlord": true, "upgrades": [], "selectionId": "2685e63b-ce3c-4a05-970e-7a5beacd7fe3"}, {"id": 2225, "name": "Broadside Battlesuits", "tier": {"id": 2875, "models": 1, "points": 80}, "type": "squad", "upgrades": [], "selectionId": "96a113a7-e3ee-493a-8948-e2ffdabab97a"}, {"id": 2233, "name": "Crisis Sunforge Battlesuits", "tier": {"id": 2885, "models": 3, "points": 140}, "type": "squad", "upgrades": [], "selectionId": "414c6611-b773-4b9c-b88b-3365bbf334a0"}, {"id": 2249, "name": "Pathfinder Team", "tier": {"id": 2906, "models": 10, "points": 90}, "type": "squad", "upgrades": [], "selectionId": "c0d340b7-d180-4409-aca6-d2ce3f949458"}, {"id": 2259, "name": "Tidewall Gunrig", "tier": {"id": 2919, "models": 1, "points": 90}, "type": "vehicle", "upgrades": [], "selectionId": "716973f6-fdf9-4af3-a92e-728563723044"}]'::jsonb
    ),
    (
      8,
      'Army 8',
      490,
      182,
      '{"id": 262, "name": "Emperor''s Shield", "enhancements": [{"id": 1091, "name": "Champion of the Feast", "points": 25}]}'::jsonb,
      '[{"id": 2124, "name": "Devastator Squad", "tier": {"id": 2745, "models": 5, "points": 120}, "type": "squad", "upgrades": [], "selectionId": "4b6dd30f-6f2f-42f0-924b-6d2fe8350582"}, {"id": 2128, "name": "Eradicator Squad", "tier": {"id": 2750, "models": 3, "points": 90}, "type": "squad", "upgrades": [], "selectionId": "7799a3e8-9bdc-4dcd-b2dc-8307832f2c21"}, {"id": 2141, "name": "Intercessor Squad", "tier": {"id": 2771, "models": 5, "points": 80}, "type": "squad", "upgrades": [], "selectionId": "58b3c7c1-229d-495a-bc44-de332b8e60e6"}, {"id": 2136, "name": "Impulsor", "tier": {"id": 2762, "models": 1, "points": 80}, "type": "transport", "upgrades": [], "selectionId": "65ad897b-2145-471c-8aa6-c0b9e090ce53"}, {"id": 2111, "hero": false, "name": "Captain in Terminator Armour", "tier": {"id": 2730, "models": 1, "points": 95}, "type": "leader", "warlord": true, "upgrades": [], "enhancement": {"id": 1091, "name": "Champion of the Feast", "points": 25}, "selectionId": "3234e7cc-6ae4-4856-98b9-8d988d168b8e"}]'::jsonb
    ),
    (
      9,
      'Army 9',
      500,
      165,
      '{"id": 201, "name": "Recon Element", "enhancements": []}'::jsonb,
      '[{"id": 1665, "hero": false, "name": "Krieg Command Squad", "tier": {"id": 2169, "models": 6, "points": 65}, "type": "leader", "warlord": true, "upgrades": [], "selectionId": "dc34e13a-eb53-4c50-9e2d-9357c160dcaa"}, {"id": 1634, "name": "Death Korps of Krieg", "tier": {"id": 2135, "models": 10, "points": 65}, "type": "squad", "upgrades": [], "selectionId": "e17b3f4a-fee2-49f6-96e7-cb07814cee14"}, {"id": 1634, "name": "Death Korps of Krieg", "tier": {"id": 2135, "models": 10, "points": 65}, "type": "squad", "upgrades": [], "selectionId": "d463c64f-eb47-45eb-aa74-352076f85b72"}, {"id": 1643, "name": "Death Riders", "tier": {"id": 2145, "models": 5, "points": 60}, "type": "squad", "upgrades": [], "selectionId": "693945de-a636-4d6b-aa5d-faa0a43ce860"}, {"id": 1632, "name": "Chimera", "tier": {"id": 2133, "models": 1, "points": 85}, "type": "transport", "upgrades": [], "selectionId": "cb484c62-a347-419c-bc26-ec407353b0fa"}, {"id": 1632, "name": "Chimera", "tier": {"id": 2133, "models": 1, "points": 85}, "type": "transport", "upgrades": [], "selectionId": "5dec6e20-f2c7-4217-9619-b94b066921ce"}, {"id": 1668, "name": "Krieg Heavy Weapons Squad", "tier": {"id": 2174, "models": 4, "points": 75}, "type": "squad", "upgrades": [], "selectionId": "18ec6467-ebcd-4b7d-b239-ba6c079a124e"}]'::jsonb
    ),
    (
      10,
      'Army 10',
      500,
      177,
      '{"id": 133, "name": "Purgation Force", "enhancements": [{"id": 573, "name": "Liber Heresius", "points": 10}]}'::jsonb,
      '[{"id": 1958, "hero": false, "name": "Inquisitor", "tier": {"id": 2531, "models": 1, "points": 55}, "type": "leader", "warlord": true, "upgrades": [], "enhancement": {"id": 573, "name": "Liber Heresius", "points": 10}, "selectionId": "d67b4dc1-1f87-4eeb-b889-9c941e678101"}, {"id": 1954, "name": "Exaction Squad", "tier": {"id": 2527, "models": 11, "points": 90}, "type": "squad", "upgrades": [], "selectionId": "e5ae2942-63c8-46c2-b806-aea78265b167"}, {"id": 1954, "name": "Exaction Squad", "tier": {"id": 2527, "models": 11, "points": 90}, "type": "squad", "upgrades": [], "selectionId": "54f7c010-1832-4515-a1a7-2d7cdec4d32b"}, {"id": 1952, "name": "Deathwatch Kill Team", "tier": {"id": 2524, "models": 5, "points": 100}, "type": "squad", "upgrades": [], "selectionId": "a349d40c-c72a-43e8-b2b5-7d231c4d51c8"}, {"id": 1970, "name": "Vigilant Squad", "tier": {"id": 2544, "models": 11, "points": 85}, "type": "squad", "upgrades": [], "selectionId": "2a3b9c46-73de-46e9-9f55-35b7444816a1"}, {"id": 1963, "name": "Inquisitorial Chimera", "tier": {"id": 2537, "models": 1, "points": 70}, "type": "transport", "upgrades": [], "selectionId": "5bc9b241-6636-4fd2-9073-10d456da130e"}]'::jsonb
    )
),
user_assignments (army_num, username) AS (
  VALUES
    (1, 'test1'),  (1, 'test11'), (1, 'test21'),
    (2, 'test2'),  (2, 'test12'), (2, 'test22'),
    (3, 'test3'),  (3, 'test13'), (3, 'test23'),
    (4, 'test4'),  (4, 'test14'), (4, 'test24'),
    (5, 'test5'),  (5, 'test15'), (5, 'test25'),
    (6, 'test6'),  (6, 'test16'), (6, 'test26'),
    (7, 'test7'),  (7, 'test17'), (7, 'test27'),
    (8, 'test8'),  (8, 'test18'), (8, 'test28'),
    (9, 'test9'),  (9, 'test19'), (9, 'test29'),
    (10,'test10'), (10,'test20'), (10,'test30')
)
INSERT INTO public.armies (user_id, codex, name, points, detachment, roster, secret, valid)
SELECT
  u.id,
  t.codex,
  t.name,
  t.points,
  t.detachment,
  t.roster,
  false,
  true
FROM army_templates t
JOIN user_assignments a ON t.army_num = a.army_num
JOIN public.users u ON u.name = a.username;
