alter table "public"."games" drop constraint "games_army_one_fkey";
alter table "public"."games" drop constraint "games_army_two_fkey";
alter table "public"."games" add constraint "games_army_one_fkey" FOREIGN KEY (army_one) REFERENCES game_armies(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;
alter table "public"."games" validate constraint "games_army_one_fkey";
alter table "public"."games" add constraint "games_army_two_fkey" FOREIGN KEY (army_two) REFERENCES game_armies(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;
alter table "public"."games" validate constraint "games_army_two_fkey";
