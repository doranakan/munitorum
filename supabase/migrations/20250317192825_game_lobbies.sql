create type "public"."game_player" as enum ('one', 'two');

alter table "public"."games" alter column "status" drop default;

alter type "public"."game_status" rename to "game_status__old_version_to_be_dropped";

create type "public"."game_status" as enum ('new', 'in_lobby', 'active', 'turn1_p1', 'turn1_p2', 'turn2_p1', 'turn2_p2', 'turn3_p1', 'turn3_p2', 'turn4_p1', 'turn4_p2', 'turn5_p1', 'turn5_p2', 'ended');

alter table "public"."games" alter column status type "public"."game_status" using status::text::"public"."game_status";

alter table "public"."games" alter column "status" set default 'new'::game_status;

drop type "public"."game_status__old_version_to_be_dropped";

alter table "public"."games" add column "active_player" game_player not null default 'one'::game_player;

alter table "public"."games" add column "ready_one" boolean not null default false;

alter table "public"."games" add column "ready_two" boolean not null default false;

alter table "public"."games" add column "round" smallint not null default '1'::smallint;

alter table "public"."games" add column "turn" smallint not null default '1'::smallint;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.create_user(name text, password text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
  declare
  user_id uuid;
  encrypted_pw text;
  email text;
BEGIN
  -- Concatenate the name with the domain to form the email
  email := name || '@appdeptus.com';
  
  user_id := gen_random_uuid();
  encrypted_pw := crypt(password, gen_salt('bf'));
  
  -- Insert user with the display_name set to the provided name
  INSERT INTO auth.users
    (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, recovery_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, email_change, email_change_token_new, recovery_token)
  VALUES
    ('00000000-0000-0000-0000-000000000000', user_id, 'authenticated', 'authenticated', email, encrypted_pw, '2023-05-03 19:41:43.585805+00', '2023-04-22 13:10:03.275387+00', '2023-04-22 13:10:31.458239+00', '{"provider":"email","providers":["email"]}', jsonb_build_object('display_name', name), '2023-05-03 19:41:43.580424+00', '2023-05-03 19:41:43.585948+00', '', '', '', '');
  
  -- Insert identity with the provider_id and other details
  INSERT INTO auth.identities (id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, provider_id)
  VALUES
    (gen_random_uuid(), user_id, format('{"sub":"%s","email":"%s"}', user_id::text, email)::jsonb, 'email', '2023-05-03 19:41:43.582456+00', '2023-05-03 19:41:43.582497+00', '2023-05-03 19:41:43.582497+00', gen_random_uuid());
END;
$function$
;

CREATE OR REPLACE FUNCTION public.start_game()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$begin
  -- If both players are ready, update the status based on first_turn_player
  if new.ready_one = true and new.ready_two = true and new.status = 'in_lobby'::game_status then
    update games
    set status = 'active'::game_status
    where id = new.id;
  end if;

  return new;
end;$function$
;

CREATE TRIGGER start_game AFTER UPDATE ON public.games FOR EACH ROW WHEN (((new.ready_one = true) AND (new.ready_two = true) AND (new.status = 'in_lobby'::game_status))) EXECUTE FUNCTION start_game();


