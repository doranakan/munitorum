create type "public"."unit_type" as enum ('unit', 'leader', 'transport');

alter table "public"."armies" drop column "total_points";

alter table "public"."armies" add column "points" bigint not null;

alter table "public"."armies" add column "teams" jsonb not null;

alter table "public"."armies" add column "warlord" jsonb not null;

alter table "public"."game_armies" drop column "total_points";

alter table "public"."game_armies" add column "detachment" jsonb not null;

alter table "public"."game_armies" add column "points" bigint not null;

alter table "public"."game_armies" add column "teams" jsonb not null;

alter table "public"."game_armies" add column "warlord" jsonb not null;

alter table "public"."game_armies" alter column "units" set data type jsonb using "units"::jsonb;

alter table "public"."units" add column "type" unit_type not null default 'unit'::unit_type;

