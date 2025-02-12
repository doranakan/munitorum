create table "public"."detachment_enhancements" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "points" bigint not null,
    "detachment" bigint not null
);
alter table "public"."detachment_enhancements" enable row level security;
create table "public"."detachments" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "codex" bigint not null
);
alter table "public"."detachments" enable row level security;
create table "public"."unit_upgrades" (
    "id" bigint generated by default as identity not null,
    "name" text not null,
    "points" bigint not null,
    "unit" bigint not null
);
alter table "public"."unit_upgrades" enable row level security;
CREATE UNIQUE INDEX detachments_pkey ON public.detachments USING btree (id);
CREATE UNIQUE INDEX enhancements_pkey ON public.detachment_enhancements USING btree (id);
CREATE UNIQUE INDEX unit_upgrades_pkey ON public.unit_upgrades USING btree (id);
alter table "public"."detachment_enhancements" add constraint "enhancements_pkey" PRIMARY KEY using index "enhancements_pkey";
alter table "public"."detachments" add constraint "detachments_pkey" PRIMARY KEY using index "detachments_pkey";
alter table "public"."unit_upgrades" add constraint "unit_upgrades_pkey" PRIMARY KEY using index "unit_upgrades_pkey";
alter table "public"."detachment_enhancements" add constraint "enhancements_detachment_fkey" FOREIGN KEY (detachment) REFERENCES detachments(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;
alter table "public"."detachment_enhancements" validate constraint "enhancements_detachment_fkey";
alter table "public"."detachments" add constraint "detachments_codex_fkey" FOREIGN KEY (codex) REFERENCES codexes(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;
alter table "public"."detachments" validate constraint "detachments_codex_fkey";
alter table "public"."unit_upgrades" add constraint "unit_upgrades_unit_fkey" FOREIGN KEY (unit) REFERENCES units(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;
alter table "public"."unit_upgrades" validate constraint "unit_upgrades_unit_fkey";
grant delete on table "public"."detachment_enhancements" to "anon";
grant insert on table "public"."detachment_enhancements" to "anon";
grant references on table "public"."detachment_enhancements" to "anon";
grant select on table "public"."detachment_enhancements" to "anon";
grant trigger on table "public"."detachment_enhancements" to "anon";
grant truncate on table "public"."detachment_enhancements" to "anon";
grant update on table "public"."detachment_enhancements" to "anon";
grant delete on table "public"."detachment_enhancements" to "authenticated";
grant insert on table "public"."detachment_enhancements" to "authenticated";
grant references on table "public"."detachment_enhancements" to "authenticated";
grant select on table "public"."detachment_enhancements" to "authenticated";
grant trigger on table "public"."detachment_enhancements" to "authenticated";
grant truncate on table "public"."detachment_enhancements" to "authenticated";
grant update on table "public"."detachment_enhancements" to "authenticated";
grant delete on table "public"."detachment_enhancements" to "service_role";
grant insert on table "public"."detachment_enhancements" to "service_role";
grant references on table "public"."detachment_enhancements" to "service_role";
grant select on table "public"."detachment_enhancements" to "service_role";
grant trigger on table "public"."detachment_enhancements" to "service_role";
grant truncate on table "public"."detachment_enhancements" to "service_role";
grant update on table "public"."detachment_enhancements" to "service_role";
grant delete on table "public"."detachments" to "anon";
grant insert on table "public"."detachments" to "anon";
grant references on table "public"."detachments" to "anon";
grant select on table "public"."detachments" to "anon";
grant trigger on table "public"."detachments" to "anon";
grant truncate on table "public"."detachments" to "anon";
grant update on table "public"."detachments" to "anon";
grant delete on table "public"."detachments" to "authenticated";
grant insert on table "public"."detachments" to "authenticated";
grant references on table "public"."detachments" to "authenticated";
grant select on table "public"."detachments" to "authenticated";
grant trigger on table "public"."detachments" to "authenticated";
grant truncate on table "public"."detachments" to "authenticated";
grant update on table "public"."detachments" to "authenticated";
grant delete on table "public"."detachments" to "service_role";
grant insert on table "public"."detachments" to "service_role";
grant references on table "public"."detachments" to "service_role";
grant select on table "public"."detachments" to "service_role";
grant trigger on table "public"."detachments" to "service_role";
grant truncate on table "public"."detachments" to "service_role";
grant update on table "public"."detachments" to "service_role";
grant delete on table "public"."unit_upgrades" to "anon";
grant insert on table "public"."unit_upgrades" to "anon";
grant references on table "public"."unit_upgrades" to "anon";
grant select on table "public"."unit_upgrades" to "anon";
grant trigger on table "public"."unit_upgrades" to "anon";
grant truncate on table "public"."unit_upgrades" to "anon";
grant update on table "public"."unit_upgrades" to "anon";
grant delete on table "public"."unit_upgrades" to "authenticated";
grant insert on table "public"."unit_upgrades" to "authenticated";
grant references on table "public"."unit_upgrades" to "authenticated";
grant select on table "public"."unit_upgrades" to "authenticated";
grant trigger on table "public"."unit_upgrades" to "authenticated";
grant truncate on table "public"."unit_upgrades" to "authenticated";
grant update on table "public"."unit_upgrades" to "authenticated";
grant delete on table "public"."unit_upgrades" to "service_role";
grant insert on table "public"."unit_upgrades" to "service_role";
grant references on table "public"."unit_upgrades" to "service_role";
grant select on table "public"."unit_upgrades" to "service_role";
grant trigger on table "public"."unit_upgrades" to "service_role";
grant truncate on table "public"."unit_upgrades" to "service_role";
grant update on table "public"."unit_upgrades" to "service_role";
create policy "all"
on "public"."detachment_enhancements"
as permissive
for all
to authenticated
using (true)
with check (true);
create policy "all"
on "public"."detachments"
as permissive
for all
to authenticated
using (true)
with check (true);
create policy "Enable update for users based on email"
on "public"."unit_upgrades"
as permissive
for all
to authenticated
using (true)
with check (true);
