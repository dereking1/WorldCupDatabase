DROP TABLE IF EXISTS team;
DROP TABLE IF EXISTS tournaments;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS squad;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS match_goals;

CREATE TABLE tournaments (
    tournament_year YEAR NOT NULL PRIMARY KEY,
    host_country VARCHAR(30),
    first_place VARCHAR(30) NOT NULL,
    second_place VARCHAR(30),
    third_place VARCHAR(30),
    fourth_place VARCHAR(30),
    goals_scored INT
);

CREATE TABLE team (
    team_id INT PRIMARY KEY NOT NULL,
    country VARCHAR(30) NOT NULL
);

CREATE TABLE player (
    player_id VARCHAR(30) PRIMARY KEY NOT NULL,
    player_name VARCHAR(100) NOT NULL,
    player_position CHAR(1),
	dob VARCHAR(30)
);

CREATE TABLE squad (
    team_id INT NOT NULL,
    tournament_year YEAR NOT NULL,
    player_id VARCHAR(30),
    PRIMARY KEY (player_id, tournament_year)
);

CREATE TABLE matches (
    match_id VARCHAR(30) PRIMARY KEY NOT NULL,
    home_team VARCHAR(30) NOT NULL,
    away_team VARCHAR(30) NOT NULL,
    home_score INT NOT NULL,
    away_score INT NOT NULL,
    stadium VARCHAR(100),
	match_round VARCHAR(100),
    tournament_year YEAR
);

CREATE TABLE match_goals (
    match_id VARCHAR(30) NOT NULL,
    player_id VARCHAR(30) NOT NULL,
    event_time INT NOT NULL,
    PRIMARY KEY(match_id, player_id, event_time)
);

CREATE INDEX idx ON player(player_id, player_name);
