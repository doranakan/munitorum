CREATE OR REPLACE FUNCTION public.invalidate_armies_on_delete()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    UPDATE armies
    SET valid = FALSE
    WHERE id IN (
        SELECT DISTINCT ae.army
        FROM army_entries ae
        WHERE
            (TG_TABLE_NAME = 'units' AND ae.unit = OLD.id) OR
            (TG_TABLE_NAME = 'unit_tiers' AND ae.tier = OLD.id) OR
            (TG_TABLE_NAME = 'unit_upgrades' AND ae.upgrade = OLD.id) OR
            (TG_TABLE_NAME = 'detachment_enhancements' AND ae.enhancement = OLD.id)
    );

    RETURN OLD;
END;
$function$
;

CREATE TRIGGER invalidate_armies_on_units_delete BEFORE DELETE ON public.units FOR EACH ROW EXECUTE FUNCTION invalidate_armies_on_delete();
CREATE TRIGGER invalidate_armies_on_unit_tiers_delete BEFORE DELETE ON public.unit_tiers FOR EACH ROW EXECUTE FUNCTION invalidate_armies_on_delete();
CREATE TRIGGER invalidate_armies_on_unit_upgrades_delete BEFORE DELETE ON public.unit_upgrades FOR EACH ROW EXECUTE FUNCTION invalidate_armies_on_delete();
CREATE TRIGGER invalidate_armies_on_detachment_enhancements_delete BEFORE DELETE ON public.detachment_enhancements FOR EACH ROW EXECUTE FUNCTION invalidate_armies_on_delete();
