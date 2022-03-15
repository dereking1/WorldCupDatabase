DROP TABLE IF EXISTS match_goals;
DROP TABLE IF EXISTS matches;
DROP TABLE IF EXISTS squad;
DROP TABLE IF EXISTS player;
DROP TABLE IF EXISTS tournaments;
DROP TABLE IF EXISTS team;

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
    player_id BIGINT PRIMARY KEY NOT NULL,
    player_name VARCHAR(100) NOT NULL,
    player_position CHAR(1),
	dob DATE
);

CREATE TABLE squad (
    team_id INT NOT NULL,
    tournament_year YEAR NOT NULL,
    player_id BIGINT NOT NULL,
    PRIMARY KEY (player_id, tournament_year),
    FOREIGN KEY (team_id) REFERENCES team(team_id) 
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (tournament_year) REFERENCES tournaments(tournament_year)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE matches (
    match_id BIGINT PRIMARY KEY NOT NULL,
    home_team BIGINT NOT NULL,
    away_team BIGINT NOT NULL,
    home_score INT NOT NULL,
    away_score INT NOT NULL,
    stadium VARCHAR(100),
	match_round VARCHAR(100),
    tournament_year YEAR,
    FOREIGN KEY (tournament_year) REFERENCES tournaments(tournament_year)
        ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE match_goals (
    match_id BIGINT NOT NULL,
    player_id BIGINT NOT NULL,
    event_time INT NOT NULL,
    PRIMARY KEY(match_id, player_id, event_time),
    FOREIGN KEY (match_id) REFERENCES matches(match_id) 
	    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX idx ON matches(home_score, away_score);