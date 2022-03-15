-- Select top goal scorers from all World Cups.
SELECT player_name, COUNT(*) AS total_goals FROM 
    match_goals NATURAL JOIN player
    GROUP BY player_name ORDER BY total_goals DESC;

-- Select the average home score and the average away score for each World Cup.
SELECT tournament_year, 
       AVG(home_score) AS avg_home_score, 
       AVG(away_score) AS avg_away_score
FROM matches GROUP BY tournament_year
ORDER BY tournament_year DESC;

-- Find the frequency that a goal is scored in any minute in a game across
-- all World Cups.
WITH total_goals AS 
         (SELECT SUM(goals_scored) AS sum_goals FROM tournaments),
     goals_per_min AS
         (SELECT event_time, COUNT(*) AS goals FROM match_goals GROUP BY event_time)
SELECT event_time AS minute_of_game, goals/sum_goals AS frequency FROM
goals_per_min NATURAL JOIN total_goals ORDER BY event_time ASC;

SELECT * FROM tournaments;