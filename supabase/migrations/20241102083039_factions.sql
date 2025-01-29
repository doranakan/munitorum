create type "public"."faction" as enum ('imperium', 'chaos', 'xenos');
alter table "public"."codexes" add column "faction" faction not null default 'imperium'::faction;
