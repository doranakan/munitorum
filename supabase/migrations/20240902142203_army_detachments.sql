alter table "public"."armies" add column "detachment" jsonb not null;
alter table "public"."armies" alter column "units" set data type jsonb using "units"::jsonb;
