drop trigger if exists "set_up_army_one_for_game" on "public"."games";

drop trigger if exists "set_up_army_two_for_game" on "public"."games";

drop function if exists "public"."duplicate_army_into_games_armies_for_player_one"();

drop function if exists "public"."duplicate_army_into_games_armies_for_player_two"();

alter table "public"."armies" drop column "composition";

alter table "public"."armies" add column "detachment" jsonb not null;

alter table "public"."armies" add column "roster" jsonb not null;

alter table "public"."game_armies" drop column "composition";

alter table "public"."game_armies" add column "detachment" jsonb not null;

alter table "public"."game_armies" add column "roster" jsonb not null;

alter table "public"."game_armies" alter column "user_id" set default auth.uid();

alter table "public"."units" add column "hero" boolean not null default false;


