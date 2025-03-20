drop trigger if exists "send_community_request" on "public"."communities_requests";

alter table "public"."users_push_tokens" drop constraint "users_push_tokens_push_token_key";

alter table "public"."users_push_tokens" drop constraint "users_push_tokens_pkey";

drop index if exists "public"."users_push_tokens_push_token_key";

drop index if exists "public"."users_push_tokens_pkey";

create table "public"."user_notifications" (
    "user" uuid not null,
    "notifications" jsonb not null
);


alter table "public"."user_notifications" enable row level security;

alter table "public"."users_push_tokens" drop column "id";

CREATE UNIQUE INDEX user_notifications_pkey ON public.user_notifications USING btree ("user");

CREATE UNIQUE INDEX users_push_tokens_pkey ON public.users_push_tokens USING btree (push_token);

alter table "public"."user_notifications" add constraint "user_notifications_pkey" PRIMARY KEY using index "user_notifications_pkey";

alter table "public"."users_push_tokens" add constraint "users_push_tokens_pkey" PRIMARY KEY using index "users_push_tokens_pkey";

alter table "public"."user_notifications" add constraint "user_notifications_user_fkey" FOREIGN KEY ("user") REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."user_notifications" validate constraint "user_notifications_user_fkey";

grant delete on table "public"."user_notifications" to "anon";

grant insert on table "public"."user_notifications" to "anon";

grant references on table "public"."user_notifications" to "anon";

grant select on table "public"."user_notifications" to "anon";

grant trigger on table "public"."user_notifications" to "anon";

grant truncate on table "public"."user_notifications" to "anon";

grant update on table "public"."user_notifications" to "anon";

grant delete on table "public"."user_notifications" to "authenticated";

grant insert on table "public"."user_notifications" to "authenticated";

grant references on table "public"."user_notifications" to "authenticated";

grant select on table "public"."user_notifications" to "authenticated";

grant trigger on table "public"."user_notifications" to "authenticated";

grant truncate on table "public"."user_notifications" to "authenticated";

grant update on table "public"."user_notifications" to "authenticated";

grant delete on table "public"."user_notifications" to "service_role";

grant insert on table "public"."user_notifications" to "service_role";

grant references on table "public"."user_notifications" to "service_role";

grant select on table "public"."user_notifications" to "service_role";

grant trigger on table "public"."user_notifications" to "service_role";

grant truncate on table "public"."user_notifications" to "service_role";

grant update on table "public"."user_notifications" to "service_role";

create policy "all"
on "public"."user_notifications"
as permissive
for all
to authenticated
using (true)
with check (true);


create policy "edge_functions"
on "public"."user_notifications"
as permissive
for all
to anon
using (true)
with check (true);


CREATE TRIGGER handle_community_request AFTER UPDATE ON public.communities_requests FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('http://host.docker.internal:54321/functions/v1/notification-for-community-request-handled', 'POST', '{"Content-type":"application/json","Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"}', '{}', '1000');

CREATE TRIGGER send_community_request AFTER INSERT ON public.communities_requests FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('http://host.docker.internal:54321/functions/v1/notification-for-community-request-sent', 'POST', '{"Content-type":"application/json","Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"}', '{}', '1000');


