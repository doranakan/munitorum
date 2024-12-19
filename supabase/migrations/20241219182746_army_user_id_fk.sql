alter table "public"."armies" add constraint "armies_user_id_fkey" FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."armies" validate constraint "armies_user_id_fkey";


