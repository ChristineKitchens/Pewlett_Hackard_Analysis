-- Deliverable 1

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

-- Use Distinct with Orderby to remove duplicate rows.
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

-- Deliverable 2

-- Create a mentorship eligibility table for current
-- employees who were born between January 1, 1965 and
-- December 31, 1965
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM employees AS e
    INNER JOIN dept_emp AS de
    ON e.emp_no = de.emp_no
    INNER JOIN titles AS t
    ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	 AND (de.to_date = '9999-01-01')
ORDER BY e.emp_no ASC;

-- Additional Queries

-- Use information in mentorship_eligibility table to create
-- a new table where eligible mentors are split up by
-- department and title
SELECT d.dept_name, me.title, COUNT(me.title)
INTO mentorship_department
FROM mentorship_eligibility AS me
	INNER JOIN dept_emp AS de
	ON me.emp_no = de.emp_no
	INNER JOIN departments AS d
	ON de.dept_no = d.dept_no
GROUP BY d.dept_name, me.title
ORDER BY d.dept_name, COUNT(me.title) DESC;

-- Merge mentorship_department table with unique_titles table
-- of retiring employees to match up the number of potential mentors
-- with the number of retiring employees.
SELECT d.dept_name,
	ut.title AS retiring_title,
	COUNT(ut.title) AS retiring_count,
	md.count AS mentor_count
INTO retiring_mentor_comparison
FROM dept_emp AS de
	INNER JOIN departments AS d
	ON de.dept_no = d.dept_no
	INNER JOIN unique_titles as ut
	ON de.emp_no = ut.emp_no
	FULL OUTER JOIN mentorship_department AS md
	ON ut.title = md.title
		AND d.dept_name = md.dept_name
GROUP BY d.dept_name, ut.title, md.count
ORDER BY d.dept_name, COUNT(ut.title) DESC;