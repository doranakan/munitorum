alter type "public"."unit_type" add value if not exists 'support';

create table "public"."unit_attachments" (
  "attacher" bigint not null references "public"."units"("id") on update cascade on delete cascade,
  "target"   bigint not null references "public"."units"("id") on update cascade on delete cascade,
  primary key ("attacher", "target")
);

alter table "public"."unit_attachments" enable row level security;

create policy "all" on "public"."unit_attachments" to "authenticated" using (true) with check (true);
