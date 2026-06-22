create type "public"."battle_size" as enum ('incursion', 'strike-force', 'free');

alter table "public"."armies" add column "battle_size" battle_size not null default 'free'::battle_size;
