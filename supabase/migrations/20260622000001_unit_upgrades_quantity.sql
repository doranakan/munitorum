create type "public"."upgrade_quantity_mode" as enum ('fixed', 'per-model');

alter table "public"."unit_upgrades"
  add column "max_quantity" smallint null,
  add column "quantity_mode" upgrade_quantity_mode not null default 'fixed';
