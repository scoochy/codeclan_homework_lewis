/* MVP */
/* Q1 */

SELECT *
FROM employees 
WHERE department = 'Human Resources';


-- Q2 

SELECT first_name, last_name, country
FROM employees 
WHERE department = 'Legal';

-- Q3

SELECT count(*)
FROM employees 
WHERE country = 'Portugal';

-- Q4

SELECT count(*)
FROM employees 
WHERE country = 'Portugal' OR country = 'Spain';


-- Q5

SELECT count(*)
FROM pay_details
WHERE local_account_no IS NULL;

--Q6

SELECT count(*)
FROM pay_details
WHERE local_account_no IS NULL AND iban IS NULL;

-- Q7

SELECT first_name, last_name
FROM employees 
ORDER BY last_name NULLS LAST;

-- Q8

SELECT first_name, last_name, country 
FROM employees 
ORDER BY country NULLS LAST , 
        last_name NULLS LAST;

    
-- Q9

SELECT *
FROM employees 
ORDER BY salary DESC NULLS LAST
LIMIT 10;

-- Q10

SELECT first_name, last_name, salary
FROM employees 
WHERE country = 'Hungary'
ORDER BY salary NULLS LAST 
LIMIT 1;


-- Q11

SELECT count(*)
FROM employees 
WHERE first_name LIKE 'F%';

-- Q12

SELECT *
FROM employees 
WHERE email  ~ '.+@yahoo';

-- Q13

SELECT  count(*)
FROM employees 
WHERE pension_enrol = TRUE AND country NOT IN ('France', 'Germany');


-- Q14

SELECT *
FROM employees 
WHERE fte_hours = 1 AND department = 'Engineering'
LIMIT 1;

-- Q15

SELECT first_name, last_name, fte_hours, salary, 
        concat(salary * fte_hours) AS effective_yearly_salary
FROM employees;


/* Ext  */
/* Q16 */

SELECT first_name, last_name, department,
        concat(first_name,' ', last_name, '-', department) AS badge_label
FROM employees 
WHERE first_name IS NOT NULL AND last_name IS NOT NULL AND department IS NOT NULL;

-- Q17

SELECT *
FROM employees 

SELECT first_name, last_name, department,
        concat(first_name,' ', last_name, '-', department, 
        '(joined ', to_char(start_date, 'Month' ), 
        EXTRACT(YEAR FROM start_date), ')') AS badge_label
FROM employees 
WHERE first_name IS NOT NULL AND last_name IS NOT NULL AND department IS NOT NULL AND start_date IS NOT NULL;


-- Q18

SELECT first_name, last_name, salary,
    CASE
    WHEN salary < 40000 THEN 'low'
    WHEN salary >= 40000 THEN 'high'
    ELSE 'unknown'
END AS salary_class
FROM employees; 

        
