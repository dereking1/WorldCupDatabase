-- UDF for Fifa Database
DROP FUNCTION IF EXISTS goals_scored;
DELIMITER !
CREATE FUNCTION goals_scored (player VARCHAR(30)) RETURNS INT DETERMINISTIC
BEGIN
DECLARE goals INT;
SET goals = (SELECT COUNT(*) AS total_goals FROM match_goals NATURAL JOIN player 
    WHERE player_name = player);
RETURN goals;
END !
DELIMITER ;


-- Procedure for calculating player age
DROP PROCEDURE IF EXISTS calculate_age;
DELIMITER !
CREATE PROCEDURE calculate_age(d DATE)
BEGIN
	DECLARE age INT;
	SET age = FLOOR(DATEDIFF(CURDATE(), d) / 365);
	SELECT age;
END !
DELIMITER ;


-- View, procedure, and trigger for viewing how many wins a country has.
DROP TABLE IF EXISTS mv_country_wins;
DROP PROCEDURE IF EXISTS sp_country_win_add;
DROP TRIGGER IF EXISTS trg_tournament_add;
DROP VIEW IF EXISTS country_wins;
DELIMITER !

CREATE TABLE mv_country_wins (
    country VARCHAR(30) NOT NULL,
    world_cup_wins INT,
    PRIMARY KEY (country)
);

INSERT INTO mv_country_wins (
    SELECT first_place AS country,
           COUNT(*) AS world_cup_wins
	FROM tournaments GROUP BY country
    ORDER BY world_cup_wins DESC);

CREATE VIEW country_wins AS 
    SELECT country,
           world_cup_wins
    FROM mv_country_wins ORDER BY world_cup_wins DESC;
    
CREATE PROCEDURE sp_country_win_add(
    country VARCHAR(30)
)
BEGIN 
    INSERT INTO mv_country_wins
        VALUES (country, 1)
    ON DUPLICATE KEY UPDATE 
        world_cup_wins = world_cup_wins + 1;
END !

CREATE TRIGGER trg_tournament_add AFTER INSERT
    ON tournaments FOR EACH ROW
BEGIN
    CALL sp_country_win_add(
        NEW.first_place
	);
END !
DELIMITER ;

-- Procedure and trigger for adding new tournaments to database.
-- DROP PROCEDURE IF EXISTS fifa_new_tournament;
-- DROP TRIGGER IF EXISTS trg_tournament_add;
-- DELIMITER !

-- CREATE PROCEDURE fifa_new_tournament(
--     new_tournament_year YEAR,
--     new_host_country VARCHAR(30),
--     new_first_place VARCHAR(30),
--     new_second_place VARCHAR(30),
--     new_third_place VARCHAR(30),
--     new_fourth_place VARCHAR(30),
--     new_goals_scored INT
-- )
-- BEGIN 
--     INSERT INTO tournaments 
--         -- branch not already in view; add row
--         VALUES (new_tournament_year, new_host_country, 
--                 new_first_place, new_second_place,
--                 new_third_place, new_fourth_place, 
--                 new_goals_scored)
--     ON DUPLICATE KEY UPDATE 
-- 		tournament_year = new_tournament_year,
-- 		host_country = new_host_country,
-- 		first_place = new_first_place,
-- 		second_place = new_second_place,
-- 		third_place = new_third_place,
-- 		fourth_place = new_fourth_place,
-- 		goals_scored = new_goals_scored;
-- END !


-- CREATE TRIGGER trg_tournament_add AFTER INSERT
--        ON tournaments FOR EACH ROW
-- BEGIN
--     CALL fifa_new_tournament(
--         NEW.tournament_year, NEW.host_country,
--         NEW.first_place, NEW.second_place, NEW.third_place, NEW.fourth_place,
--         NEW.goals_scored
-- 	);
-- END !
-- DELIMITER ;
