set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.handle_user_registration()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$begin
    -- You can add your logic here, for example, inserting a record into a profiles table
    insert into public.users (id, name, created_at)
    values (new.id, new.raw_user_meta_data->>'email', now());
    
    return new;
end;$function$
;


