alter table "public"."armies" drop column "detachment";

alter table "public"."armies" drop column "teams";

alter table "public"."armies" drop column "units";

alter table "public"."armies" drop column "warlord";

alter table "public"."armies" add column "composition" jsonb not null;

alter table "public"."game_armies" drop column "detachment";

alter table "public"."game_armies" drop column "teams";

alter table "public"."game_armies" drop column "units";

alter table "public"."game_armies" drop column "warlord";

alter table "public"."game_armies" add column "composition" jsonb not null;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.duplicate_army_into_games_armies_for_player_one()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$begin
    insert into
      game_armies (composition, name, points, codex, user_id)
    select
      composition,
      name,
      points,
      codex,
      user_id
    from
      armies
    where
      id = NEW.army_one
    returning id into NEW.army_one;

  return NEW;
end;$function$
;

CREATE OR REPLACE FUNCTION public.duplicate_army_into_games_armies_for_player_two()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$begin
  if NEW.status = 'turn1_p1' and NEW.player_two is null then
    insert into
      game_armies (composition, name, points, codex, user_id)
    select
      composition,
      name,
      points,
      codex,
      user_id
    from
      armies
    where
      id = NEW.army_two
    returning id into NEW.army_two;

    NEW.player_two = auth.uid();
  end if;

  return NEW;
end;$function$
;


