--MVP
--Q1

SELECT
    e.first_name,
    e.last_name,
    t.name AS team_name
FROM employees AS e 
INNER JOIN teams AS t 
ON e.team_id = t.id; 

