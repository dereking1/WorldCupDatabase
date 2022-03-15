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

SELECT goals_scored("Ronaldo") AS goals;

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

CALL calculate_age('2001-12-27');




-- Procedure and trigger for adding new tournaments to database.
DELIMITER !

CREATE PROCEDURE fifa_new_tournament(
    new_tournament_year YEAR,
    new_host_country VARCHAR(30),
    new_first_place VARCHAR(30),
    new_second_place VARCHAR(30),
    new_third_place VARCHAR(30),
    new_fourth_place VARCHAR(30),
    new_goals_scored INT
)
BEGIN 
    INSERT INTO tournaments 
        -- branch not already in view; add row
        VALUES (new_tournament_year, new_host_country, 
                new_first_place, new_second_place,
                new_third_place, new_fourth_place, 
                new_goals_scored)
    ON DUPLICATE KEY UPDATE 
		tournament_year = new_tournament_year,
		host_country = new_host_country,
		first_place = new_first_place,
		second_place = new_second_place,
		third_place = new_third_place,
		fourth_place = new_fourth_place,
		goals_scored = new_goals_scored;
END !

-- Handles new rows added to account table, updates stats accordingly
CREATE TRIGGER trg_tournament_add AFTER INSERT
       ON tournaments FOR EACH ROW
BEGIN
    CALL fifa_new_tournament(
        NEW.tournament_year, NEW.host_country,
        NEW.first_place, NEW.second_place, NEW.third_place, NEW.fourth_place,
        NEW.goals_scored
	);
END !
DELIMITER ;

