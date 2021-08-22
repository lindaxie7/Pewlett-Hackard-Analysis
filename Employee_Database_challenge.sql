-- Retrieve the emp_no, first_name, and last_name columns from the Employees table.
select emp_no,first_name,last_name from employees;

-- Retrieve the title, from_date, and to_date columns from the Titles table.
select title,from_date,to_date from titles;

-- Create new table for retiring employees
select employees.emp_no, first_name, last_name, title, from_date, to_date 
INTO retirement_info
from employees
JOIN titles
on employees.emp_no = titles.emp_no
WHERE birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY emp_no ASC;

-- Check the retirement_info table
SELECT * FROM retirement_info;


--Use the DISTINCT ON statement
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title 
INTO unique_titles
FROM retirement_info
ORDER BY emp_no ASC, to_date DESC;

-- Check the unique_titles table
SELECT * FROM unique_titles;

-- Order By title count 
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT(title) DESC;


-- Check the retiring_titles table
SELECT * FROM retiring_titles;
SELECT SUM(Count) AS "Total" FROM retiring_titles;

-- Deliverable 2
SELECT DISTINCT ON (employees.emp_no) employees.emp_no, first_name, last_name, birth_date, dept_emp.from_date, dept_emp.to_date, title
INTO mentorship_eligibilty
FROM employees
INNER JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
INNER JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
and dept_emp.to_date = '9999-01-01'
ORDER BY emp_no ASC


-- Check the mentorship_eligibilty table
SELECT * FROM mentorship_eligibilty;

SELECT COUNT(title), title
INTO mentorship_titles
FROM mentorship_eligibilty
GROUP BY title
ORDER BY COUNT(title) DESC;

select * from mentorship_titles;
SELECT SUM(Count) AS "Total" FROM mentorship_titles;




--two additional queries or tables

-- Create retirement_departments table
SELECT DISTINCT ON (unique_titles.emp_no) unique_titles.emp_no, first_name, last_name,  dept_emp.from_date, dept_emp.to_date, departments.dept_name
INTO retiremnet_departments
FROM unique_titles
INNER JOIN dept_emp
ON unique_titles.emp_no = dept_emp.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments. dept_no

-- Check the retirement_departments table
select * from retiremnet_departments

---- Order By dept_name count
SELECT COUNT(retiremnet_departments.emp_no), retiremnet_departments.dept_name
FROM retiremnet_departments
GROUP BY retiremnet_departments.dept_name
ORDER BY COUNT(retiremnet_departments.emp_no) DESC;

-- Create mentorship_departments table
SELECT DISTINCT ON (mentorship_eligibilty.emp_no) mentorship_eligibilty.emp_no, first_name, last_name, birth_date, dept_emp.from_date, dept_emp.to_date, departments.dept_name
INTO mentorship_departments
FROM mentorship_eligibilty
INNER JOIN dept_emp
ON mentorship_eligibilty.emp_no = dept_emp.emp_no
INNER JOIN departments
ON dept_emp.dept_no = departments. dept_no

-- Check the mentorship_departments table
select * from mentorship_departments

---- Order By dept_name count
SELECT COUNT(mentorship_departments.emp_no), mentorship_departments.dept_name
FROM mentorship_departments
GROUP BY mentorship_departments.dept_name
ORDER BY COUNT(mentorship_departments.emp_no) DESC;

SELECT SUM(Count) AS "Total" FROM mentorship_titles;