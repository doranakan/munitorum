insert into storage.buckets (id, name, public)
values 
    ('profile_images', 'profile_images', true),
    ('community_images', 'community_images', true)
on conflict (id) do nothing;

-- Allow everyone to SELECT from profile_images
create policy "Public select on profile_images"
on storage.objects
for select
using (bucket_id = 'profile_images');

-- Allow everyone to SELECT from community_images
create policy "Public select on community_images"
on storage.objects
for select
using (bucket_id = 'community_images');


-- Allow only authenticated users to INSERT into profile_images
create policy "Authenticated insert on profile_images"
on storage.objects
for insert
with check (auth.role() = 'authenticated' and bucket_id = 'profile_images');

-- Allow only authenticated users to INSERT into community_images
create policy "Authenticated insert on community_images"
on storage.objects
for insert
with check (auth.role() = 'authenticated' and bucket_id = 'community_images');

-- Allow only authenticated users to UPDATE in profile_images
create policy "Authenticated update on profile_images"
on storage.objects
for update
using (auth.role() = 'authenticated' and bucket_id = 'profile_images');

-- Allow only authenticated users to UPDATE in community_images
create policy "Authenticated update on community_images"
on storage.objects
for update
using (auth.role() = 'authenticated' and bucket_id = 'community_images');

-- Allow only authenticated users to DELETE in profile_images
create policy "Authenticated delete on profile_images"
on storage.objects
for delete
using (auth.role() = 'authenticated' and bucket_id = 'profile_images');

-- Allow only authenticated users to DELETE in community_images
create policy "Authenticated delete on community_images"
on storage.objects
for delete
using (auth.role() = 'authenticated' and bucket_id = 'community_images');