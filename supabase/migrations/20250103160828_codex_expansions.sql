alter table "public"."codexes" add column "expansion_of" bigint;

alter table "public"."codexes" add constraint "codexes_expansion_of_fkey" FOREIGN KEY (expansion_of) REFERENCES codexes(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."codexes" validate constraint "codexes_expansion_of_fkey";


