drop trigger if exists "send_community_request" on "public"."communities_requests";

alter table "public"."communities_requests" drop constraint "community_requests_pkey";

drop index if exists "public"."community_requests_pkey";

alter table "public"."communities_requests" drop column "id";

CREATE UNIQUE INDEX communities_requests_pkey ON public.communities_requests USING btree ("user", community);

alter table "public"."communities_requests" add constraint "communities_requests_pkey" PRIMARY KEY using index "communities_requests_pkey";

CREATE TRIGGER send_community_request AFTER INSERT OR UPDATE ON public.communities_requests FOR EACH ROW EXECUTE FUNCTION supabase_functions.http_request('http://host.docker.internal:54321/functions/v1/notification-for-community-request-sent', 'POST', '{"Content-type":"application/json","Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"}', '{}', '1000');


