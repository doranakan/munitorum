CREATE OR REPLACE FUNCTION public.create_user(
    name text,
    password text
) RETURNS void AS $$
  declare
  user_id uuid;
  encrypted_pw text;
  email text;
BEGIN
  -- Concatenate the name with the domain to form the email
  email := name || '@appdeptus.com';
  
  user_id := gen_random_uuid();
  encrypted_pw := crypt(password, gen_salt('bf'));
  
  -- Insert user with the display_name set to the provided name
  INSERT INTO auth.users
    (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, recovery_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, email_change, email_change_token_new, recovery_token)
  VALUES
    ('00000000-0000-0000-0000-000000000000', user_id, 'authenticated', 'authenticated', email, encrypted_pw, '2023-05-03 19:41:43.585805+00', '2023-04-22 13:10:03.275387+00', '2023-04-22 13:10:31.458239+00', '{"provider":"email","providers":["email"]}', jsonb_build_object('display_name', name), '2023-05-03 19:41:43.580424+00', '2023-05-03 19:41:43.585948+00', '', '', '', '');
  
  -- Insert identity with the provider_id and other details
  INSERT INTO auth.identities (id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, provider_id)
  VALUES
    (gen_random_uuid(), user_id, format('{"sub":"%s","email":"%s"}', user_id::text, email)::jsonb, 'email', '2023-05-03 19:41:43.582456+00', '2023-05-03 19:41:43.582497+00', '2023-05-03 19:41:43.582497+00', gen_random_uuid());
END;
$$ LANGUAGE plpgsql;

DO $$
DECLARE
    i INT;
    email TEXT;
BEGIN
    FOR i IN 0..49 LOOP
        email := 'test' || i;
        PERFORM public.create_user(email, 'qwerty');
    END LOOP;
END $$;


INSERT INTO public.users (id, name)
SELECT id, raw_user_meta_data->>'display_name'
FROM auth.users
WHERE email LIKE 'test%@appdeptus.com';

