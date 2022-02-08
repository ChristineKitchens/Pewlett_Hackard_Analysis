# Pewlett Hackard Analysis
Use pgAdmin and PostgreSQL to determine analyze upcoming employee retirements.

## Overview of Pewlett Hackard Analysis

## Pewlett Hackard Analysis Results
There is a bulleted list with four major points from the two analysis deliverables.

### Number of Retiring Employees by Title
- The number of retiring employees by title is as follows:
| Title  | Count |
| ------------- | ------------- |
| Senior Engineer | 25916 |
| Senior Staff | 24926 |
| Engineer | 9285 |
| Staff | 7636 |
| Technique Leader | 3603 |
| Assistant Engineer | 1090 |
| Manager | 2 |

### Employees Eligible for the Mentorship Program
- There are 1549 employees eligible for the mentorship program
- Grouping by elibible mentors by title yields the following breadkdown:
| Title  | Count |
| ------------- | ------------- |
| Senior Staff | 569 |
| Engineer | 501 |
| Senior Engineer | 169 |
| Staff | 155 |
| Assistant Engineer | 78 |
| Technique Leader | 77 |
## Pewlett Hackard Analysis Summary
The summary addresses the two questions and contains two additional queries or tables that may provide more insight.
- Determine the number of retiring employees per title
- Identify employees who are eligible to participate in a mentorship program.
- An additional query to make of the data could be to breakdown the number of retiring employees not just by title, but by department as well. The following query was executed to this end:
```
SELECT d.dept_name, ut.title, COUNT(ut.title)
FROM dept_emp AS de
	INNER JOIN departments AS d
	ON de.dept_no = d.dept_no
	INNER JOIN unique_titles as ut
	ON de.emp_no = ut.emp_no
GROUP BY d.dept_name, ut.title
ORDER BY d.dept_name, COUNT(ut.title) DESC;
```
- Further, while the requested deliverables separately analyzed the number of employees retiring and the number eligible employees for the mentorship program, it's critical to compare these two numbers directly. Given the magnitude of employees reaching retirement age, it needs to be determined if the number of eligible mentors is high enough to manage the training of new hires.
```
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
```
    - A cursory glance at the resulting [table]() shows a pitfall in the mentorship program: the amount of individuals eligible to act as a mentor is dwarfed by the number of retiring individuals. While a mentorship program is a great idea for onboarding new employees, criteria and terms surrounding potential mentor positions should be modified. For example, individuals eligible for mentor positions should be able to opt in for part-time or full-time positions. Further, eligibility should be expanded to employees who have demonstrated sufficient knowledge and proficiency in relevant positions. Acceptance should be accompanied by a salary increase to account for increased responsibilities. 


## Resources
- Data Source: 
  - [employees.csv]()
  - [titles.csv]()
  - [retirement_titles.csv]()
  - [unique_titles.csv]()
  - [retiring_titles.csv]()
  - [dept_emp.csv]()
  - [mentorship_eligibility.csv]()
- Software: pgAdmin 4