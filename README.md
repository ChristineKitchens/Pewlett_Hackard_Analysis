# Pewlett Hackard Analysis

## Overview of Pewlett Hackard Analysis
- Pewlett Hackard noticed that several employees are nearing retirement age. In anticipation of the number of openings that will accompany the wave of retiring employees, management requested two deliverables:
   - The number of retiring employees by title.
   - The number of employees eligible for a mentorship program.

- To conduct analyses, tables containing employee and departmental infomation were imported into pgAdmin and queried using SQL. See "Resources" at the bottom of this file for more information.
  - Queries used to execute analysis can be found [here](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/550eced8f34750c3aed6479a1ac49ebb3c2a437d/Queries/Employee_Database_challenge.sql).
## Pewlett Hackard Analysis Results
### Number of Retiring Employees by Title
- There are a total of <b>133,776</b> employees preparing to retire.
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

  - The csv file containing the same data can be found [here](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/retiring_titles.csv)
- The two titles with the highest number of soon to be retired employees are <b>Senior Engineer</b> and <b>Senior Staff</b>.
### Employees Eligible for the Mentorship Program
- There are <b>1,549</b> employees eligible for the mentorship program (detailed data on each employee can be found [here](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/mentorship_eligibility.csv))
- Based exclusively on total numbers, the number of new positions that need to be filled is <b>2 magnitudes greater</b> than the amount of employees eligible for the mentorship program.
## Pewlett Hackard Analysis Summary
- Analyses of information in the employee database yielded four insights:
    - The company will need to fill <b>133,776</b> positions in the wake of the retirement wave.
    - The two titles with the highest number of soon to retire employees are <b>Senior Engineer</b> and <b>Senior Staff</b>.
    - <b>1,549</b> employees are eligible for the mentorship program
    - Based exclusively on total numbers, the number of new positions that need to be filled is <b>2 magnitudes greater</b> than the amount of employees eligible for the mentorship program.
- While the requested analyses will aid management in understanding the scope of the upcoming wave of retirements, some further queries could be made of data to better strategize a response to employee turnover. See the following section for additional analyses.
### Additional Analyses
  - An additional query to make of the data could be to breakdown the number of retiring employees not just by title, but [by department](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/550eced8f34750c3aed6479a1ac49ebb3c2a437d/Data/mentorship_department.csv) as well. The following query was executed to this end:
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
  - Further, while the requested deliverables separately analyzed the number of employees retiring and the number eligible employees for the mentorship program, it's critical to compare these two numbers directly. Given the disparity between the magnitude of employees reaching retirement age versus eligible mentors, directly comparing the groups across a departmental and title level will help identify where shortfalls are greatest.
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

    - A cursory glance at the [resulting table](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/retiring_mentor_comparison.csv) reflects high level observations: the number of individuals eligible to act as mentors is dwarfed by the number of retiring individuals. While a mentorship program is a great idea for onboarding new employees, criteria and terms surrounding potential mentor positions should be modified, particularly for Staff and Engineer positions. For example, individuals eligible for mentor positions should be able to opt in for part-time or full-time positions. Further, eligibility should be expanded to employees who have demonstrated sufficient knowledge and proficiency in relevant positions. Acceptance should be accompanied by a salary increase to account for increased responsibilities. 


## Resources
- Data Source: 
  - [employees.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/employees.csv)
  - [titles.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/titles.csv)
  - [retirement_titles.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/retirement_titles.csv)
  - [unique_titles.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/unique_titles.csv)
  - [retiring_titles.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/retiring_titles.csv)
  - [dept_emp.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/dept_emp.csv)
  - [mentorship_eligibility.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/mentorship_eligibility.csv)
  - [mentorship_department](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/550eced8f34750c3aed6479a1ac49ebb3c2a437d/Data/mentorship_department.csv)
  - [retiring_mentor_comparison.csv](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/c73ac6ee0ae338977a8a58e1c548cc062a3ec253/Data/retiring_mentor_comparison.csv)
- Query Script:
  - [Employee_Database_challenge.sql](https://github.com/InRegards2Pluto/Pewlett_Hackard_Analysis/blob/550eced8f34750c3aed6479a1ac49ebb3c2a437d/Queries/Employee_Database_challenge.sql)
- Software:
  - pgAdmin 4