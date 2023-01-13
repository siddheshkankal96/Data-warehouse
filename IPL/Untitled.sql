CREATE SCHEMA "IPL";

CREATE TABLE "IPL"."Players" (
  "Player_id" int PRIMARY KEY,
  "Player_name" varchar,
  "Dob" datetime,
  "Batting_hand" varchar,
  "Bowling_skills" varchar,
  "country" varchar
);

CREATE TABLE "IPL"."Teams" (
  "Team_id" int,
  "Team" varchar
);

CREATE TABLE "IPL"."deliveries" (
  "match_id" int,
  "Inning" Int,
  "Batting_team_id" int,
  "Batting_team" Varchar,
  "Bowling_team_id" int,
  "Bowling_team" Varchar,
  "Over" Int,
  "Ball" Int,
  "Player_id" int,
  "batsman" varchar,
  "Non_striker" Varchar,
  "Bowler" varchar,
  "Is_super_over" Int,
  "Wide_runs" Int,
  "Bye_runs" Int,
  "Legbye_runs" Int,
  "Noball_runs" Int,
  "Penalty_runs" Int,
  "Batsman_runs" Int,
  "Extra_runs" Int,
  "Player_dismissed" varchar,
  "fielder" varchar
);

CREATE TABLE "IPL"."matches" (
  "Id" int,
  "Season" varchar,
  "City" varchar,
  "Date" date,
  "Team1" varchar,
  "Team2" varchar,
  "Toss_winner" varchar,
  "Toss_decision" varchar,
  "Result" varchar,
  "Winner" varchar,
  "Win_by_runs" int,
  "Win_by__wickets" int,
  "Player_id" int,
  "Player_of_match" varchar,
  "Umpire1" varchar,
  "Umpire2" varchar,
  "Umpire3" varchar
);

CREATE TABLE "IPL"."most_runs average strikerate" (
  "Player_id" int,
  "batsman" Varchar,
  "total_runs" int,
  "out" int,
  "numberofballs" int,
  "average" float
);

ALTER TABLE "IPL"."Teams" ADD FOREIGN KEY ("Team_id") REFERENCES "IPL"."deliveries" ("Batting_team_id");

ALTER TABLE "IPL"."Teams" ADD FOREIGN KEY ("Team_id") REFERENCES "IPL"."deliveries" ("Bowling_team_id");

ALTER TABLE "IPL"."deliveries" ADD FOREIGN KEY ("Player_id") REFERENCES "IPL"."Players" ("Player_id");

ALTER TABLE "IPL"."matches" ADD FOREIGN KEY ("Id") REFERENCES "IPL"."deliveries" ("match_id");

ALTER TABLE "IPL"."deliveries" ADD FOREIGN KEY ("Player_id") REFERENCES "IPL"."matches" ("Player_id");

ALTER TABLE "IPL"."matches" ADD FOREIGN KEY ("Toss_winner") REFERENCES "IPL"."Teams" ("Team");

ALTER TABLE "IPL"."Teams" ADD FOREIGN KEY ("Team") REFERENCES "IPL"."matches" ("Team1");

ALTER TABLE "IPL"."Teams" ADD FOREIGN KEY ("Team") REFERENCES "IPL"."matches" ("Team2");

ALTER TABLE "IPL"."deliveries" ADD FOREIGN KEY ("batsman") REFERENCES "IPL"."Players" ("Player_name");

ALTER TABLE "IPL"."deliveries" ADD FOREIGN KEY ("Player_dismissed") REFERENCES "IPL"."Players" ("Player_name");

ALTER TABLE "IPL"."most_runs average strikerate" ADD FOREIGN KEY ("Player_id") REFERENCES "IPL"."deliveries" ("Player_id");

ALTER TABLE "IPL"."most_runs average strikerate" ADD FOREIGN KEY ("Player_id") REFERENCES "IPL"."Players" ("Player_id");
