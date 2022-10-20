--MVP
--Q1

SELECT 
    *
FROM employees 
WHERE grade IS NULL AND salary IS NULL; 

-- Q2 

SELECT 
    department,
    concat(first_name, ' ', last_name) AS full_name 
FROM employees 
ORDER BY department, last_name;

--Q3 

SELECT 
    *
FROM employees 
WHERE last_name ~ '^A'
ORDER BY salary DESC NULLS LAST 
LIMIT 10;

-- Q4

SELECT 
    count(department)
FROM employees 
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31';

-- Q5
SELECT 
    department,
    count(id),
    fte_hours 
FROM employees 
GROUP BY department, fte_hours 
ORDER BY department;

-- Q6 

SELECT 
    count(pension_enrol),
    pension_enrol 
FROM employees 
GROUP BY pension_enrol; 

-- Q7
SELECT 
    *
FROM employees 
WHERE department = 'Accounting' AND pension_enrol IS FALSE 
ORDER BY salary DESC NULLS LAST 
LIMIT 1;

-- Q8
SELECT 
    country,
    count(id) AS num_employees,
    avg(salary) AS average_salary 
FROM employees 
GROUP BY country
HAVING count(id) > 30
ORDER BY average_salary DESC;

-- Q9
SELECT 
    first_name, 
    last_name, 
    fte_hours,
    salary,
    fte_hours * salary AS effective_yearly_salary
FROM employees 
WHERE fte_hours * salary > 30000;

-- Q10
SELECT 
    *
FROM employees AS e
INNER JOIN teams AS t 
ON e.team_id = t.id 
WHERE t."name" = 'Data Team 1' OR t."name" = 'Data Team 2';

--Q11
SELECT 
    first_name,
    last_name,
    pd.local_tax_code 
FROM employees AS e
FULL JOIN pay_details AS pd
ON e.pay_detail_id = pd.id 
WHERE pd.local_tax_code IS NULL;

--Q12
SELECT 
    e.*,
   (48 * 35 * CAST (t.charge_cost as integer) - e.salary) * e.fte_hours AS expected_profit
FROM employees AS e 
INNER JOIN teams AS t 
ON e.team_id = t.id;

--Q13 

WITH fte_grouped AS (
SELECT 
    count(id),
    fte_hours 
FROM employees 
GROUP BY fte_hours 
),
fte_min_count AS (
SELECT 
    min(count) AS min_count
FROM fte_grouped
),
fte_least_common AS (
SELECT
    fte_hours
FROM fte_grouped
WHERE count = (
    SELECT 
        min_count
    FROM fte_min_count)
    )
SELECT 
    first_name, 
    last_name,
    salary
FROM employees 
WHERE country = 'Japan' AND 
fte_hours IN (
SELECT
    fte_hours 
FROM fte_least_common)
ORDER BY salary ASC 
LIMIT 1;

-- Q14

SELECT 
    count(id) AS num_employees,
    department 
FROM employees 
WHERE first_name IS NULL
GROUP BY department
HAVING count(id) >  1
ORDER BY num_employees DESC, department ASC;

-- Q15

SELECT 
    first_name,
    count(first_name) AS occurences
FROM employees
WHERE first_name IS NOT NULL 
GROUP BY first_name 
HAVING count(first_name)  > 1
ORDER BY occurences DESC, first_name ASC;

--Q16
SELECT 
    department,
    sum(CAST (grade = 1 AS integer)) AS grade_1s,
    count(id) AS total,
    CAST (sum(CAST (grade = 1 AS integer)) AS REAL) / CAST (count(id) AS REAL) AS proportion
FROM employees 
GROUP BY department; 



--EXTENSION
--Q1

WITH grouped_dept AS (
    SELECT 
        department,
        count(id)
    FROM employees 
    GROUP BY department 
),
max_dept AS (
    SELECT 
    max(count) AS max_count
    FROM grouped_dept
),
largest_dept AS (
    SELECT 
    department 
    FROM grouped_dept
    WHERE count = (
    SELECT
    max_count
    FROM max_dept)
),
average_salary_calc AS ( 
    SELECT
    avg(salary) AS average_salary
    FROM employees 
    WHERE department = 'largest_dept'
)
SELECT 
    id,
    first_name,
    last_name,
    department,
    salary,
    fte_hours,
    (SELECT
    average_salary
    FROM average_salary_calc) AS average_salary,
    CAST (salary AS real) / CAST (average_salary AS REAL) AS ratio
FROM employees 
WHERE department IN (
    SELECT department 
    FROM largest_dept)
AND salary IS NOT NULL 
    









