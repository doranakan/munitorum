alter table "public"."units" alter column "type" drop default;
alter type "public"."unit_type" rename to "unit_type__old_version_to_be_dropped";
create type "public"."unit_type" as enum ('character', 'squad', 'leader', 'transport', 'vehicle');
alter table "public"."units" alter column type type "public"."unit_type" using type::text::"public"."unit_type";
drop type "public"."unit_type__old_version_to_be_dropped";
alter table "public"."units" alter column "type" set default 'squad'::unit_type;
alter table "public"."units" alter column "type" drop not null;
