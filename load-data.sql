-- CS 121 Winter 2022 Final

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'Users/Daniel/Desktop/caltech/soph/q2/cs121/final/data/tournaments.csv' INTO TABLE tournaments
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Users/Daniel/Desktop/caltech/soph/q2/cs121/final/data/team.csv' INTO TABLE team
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Users/Daniel/Desktop/caltech/soph/q2/cs121/final/data/player.csv' INTO TABLE player
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Users/Daniel/Desktop/caltech/soph/q2/cs121/final/data/squads.csv' INTO TABLE squad
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Users/Daniel/Desktop/caltech/soph/q2/cs121/final/data/matches.csv' INTO TABLE matches
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'Users/Daniel/Desktop/caltech/soph/q2/cs121/final/data/match_goals.csv' INTO TABLE match_goals
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;