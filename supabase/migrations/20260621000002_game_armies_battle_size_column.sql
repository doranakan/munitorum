alter table "public"."game_armies" add column if not exists "battle_size" battle_size not null default 'free'::battle_size;
