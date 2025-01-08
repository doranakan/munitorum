set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.set_ghost_user_before_delete()
 RETURNS trigger
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$BEGIN
  -- Update the name field to 'ghost_user' before deletion
  UPDATE public.users
  SET name = 'ghost_user'
  WHERE id = OLD.id;
  
  -- Return the OLD record to allow the deletion to proceed
  RETURN OLD;
END;$function$
;


