# Pewlett Hackard Analysis

## Overview of Pewlett Hackard Analysis
- Pewlett Hackard noticed that several current employees are nearly at retirement age. In anticipation of the number of openings that will accompany the wave of retiring employees, management requested two deliverables:
 1) The number of retiring employees by title
 2) The number of employees eligible for a mentorship program.
## Pewlett Hackard Analysis Results
There is a bulleted list with four major points from the two analysis deliverables.

### Number of Retiring Employees by Title
- There are a total of 133,776 employees preparing to retire.
- The number of retiring employees by title is as follows:

| Title  | Count |
| ------------- | ------------- |
| Senior Engineer | 25,916 |
| Senior Staff | 24,926 |
| Engineer | 9,285 |
| Staff | 7,636 |
| Technique Leader | 3,603 |
| Assistant Engineer | 1,090 |
| Manager | 2 |

  - The table containing the same data can be found [here](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/retiring_titles.csv)
- The two titles with the highest number of soon to be retired employees are Senior Engineer and Senior Staff.
### Employees Eligible for the Mentorship Program
- There are 1549 employees eligible for the mentorship program (detailed data on each employee can be found [here](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/mentorship_eligibility.csv))
- Grouping by eligible mentors by title yields the following breadkdown:

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
- An additional query to make of the data could be to breakdown the number of retiring employees not just by title, but [by department]() as well. The following query was executed to this end:
```
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
```
- Further, while the requested deliverables separately analyzed the number of employees retiring and the number eligible employees for the mentorship program, it's critical to compare these two numbers directly. Given the magnitude of employees reaching retirement age, it needs to be determined if the number of eligible mentors is high enough to manage the training of new hires.
```
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
```

- A cursory glance at the [resulting table](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/retiring_mentor_comparison.csv) shows a pitfall in the mentorship program: the number of individuals eligible to act as mentors is dwarfed by the number of retiring individuals. While a mentorship program is a great idea for onboarding new employees, criteria and terms surrounding potential mentor positions should be modified. For example, individuals eligible for mentor positions should be able to opt in for part-time or full-time positions. Further, eligibility should be expanded to employees who have demonstrated sufficient knowledge and proficiency in relevant positions. Acceptance should be accompanied by a salary increase to account for increased responsibilities. 


## Resources
- Data Source: 
  - [employees.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/employees.csv)
  - [titles.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/titles.csv)
  - [retirement_titles.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/retirement_titles.csv)
  - [unique_titles.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/unique_titles.csv)
  - [retiring_titles.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/retiring_titles.csv)
  - [dept_emp.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/dept_emp.csv)
  - [mentorship_eligibility.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/mentorship_eligibility.csv)
  - []()
  - [retiring_mentor_comparison.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/retiring_mentor_comparison.csv)
- Software: pgAdmin 4