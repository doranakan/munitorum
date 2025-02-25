ALTER TABLE public.communities DISABLE TRIGGER after_community_insert;

DO $$
DECLARE
    community_id INT;
    user_id UUID;
    user_counter INT := 0;
    community_counter INT;
    users_list UUID[];
BEGIN
    -- Collect all user IDs into an array
    SELECT array_agg(id) INTO users_list FROM public.users;

    -- Ensure there are enough users (at least 10 per community)
    IF array_length(users_list, 1) IS NULL OR array_length(users_list, 1) < 50 THEN
        RAISE EXCEPTION 'Not enough users in public.users (need at least 50)';
    END IF;

    -- Create 5 communities
    FOR community_counter IN 0..4 LOOP
        INSERT INTO public.communities (name)
        VALUES ('test community ' || community_counter)
        RETURNING id INTO community_id;

        -- Assign 10 users per community
        FOR user_counter IN 1..10 LOOP
            -- Calculate the correct user for this community and user_counter
            user_id := users_list[(community_counter * 10) + user_counter];

            -- Insert the user with the appropriate role
            INSERT INTO public.communities_users (community, "user", role)
            VALUES (community_id, user_id, 
                CASE WHEN user_counter = 1 THEN 'admin'::community_role ELSE 'member'::community_role END);
        END LOOP;
    END LOOP;
END $$;

ALTER TABLE public.communities ENABLE TRIGGER after_community_insert;