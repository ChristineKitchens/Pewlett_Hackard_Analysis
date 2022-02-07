-- Join data from 'employees' and 'titles' tables, filter data to retrieve 
-- employees born between 1952 and 1955, and copy into a new table 
-- called 'retirement_titles'. 
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	titles.title,
	titles.from_date,
	titles.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles
ON e.emp_no = titles.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no

-- Use Dictinct with Orderby to remove duplicate rows.
SELECT DISTINCT ON (emp_no) emp_no,
	first_name,
	last_name,
	title
INTO unique_titles
FROM retirement_titles
WHERE (to_date = '9999-01-01')
ORDER BY emp_no, to_date DESC;

-- Retrieve the number of employees by their most recent
-- job title who are about to retire.
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC; 