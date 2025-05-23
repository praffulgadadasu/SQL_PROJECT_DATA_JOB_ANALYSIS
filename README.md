# 📈 Job Market Data Analysis with SQL

Unlocking Insights From Job Market Data — One Query at a Time

---

## Overview

This project showcases an end-to-end analysis of the job market using real-world datasets and **SQL**. Inspired by Luke Barousse's workflow, I recreated the project from scratch to sharpen my data analysis and SQL skills, with my own perspective and presentation.

Whether you are an aspiring analyst or a seasoned data enthusiast, this project demonstrates how to extract actionable insights from raw job market data using just SQL, and how to share your results effectively on GitHub.

---

## Project Highlights

- **Data Exploration**: Connect to job listings data and understand the structure.
- **SQL Analysis**: Perform queries to answer real job market questions (top job titles, trending skills, salary ranges, most active locations, and more).
- **Reproducibility**: Every SQL script and output is available for reference and learning.
- **Visualization (Optional)**: Quick visuals using SQL-friendly tools to summarize results (e.g., DB Browser, DataGrip).
- **Sharing**: Results are clearly organized for others to review and reuse.

---

## Key Questions Answered

- What are the most in-demand job titles?
- Which skills are most frequently requested by employers?
- How do salary ranges vary by job role or location?
- Which cities have the most job openings?
- What companies are hiring the most?

---
## Files & Structure
```
csv_files-20250515T132634Z-1-001/
    campany_dim.csv
    job_postings_fact.csv
    skills_dm.csv
    skills_job_dim.csv
project_sql/
    01_top_paying_jobs.sql
    02_top_paying_jobs_skills.sql
    03_in_demand_skills.sql
    04_top_skills_based_salary.sql
    05_most_optimal_skills.sql
sql_load-20250515T132304Z-1-001/
    01_create_database.sql
    02_create_tables.sql
    03_modify_tables.sql
README.md
```
---

## How to Use

1. **Clone the Repository**
    ```bash
    git clone https://github.com/praffulgadadasu/SQL_PROJECT_DATA_JOB_ANALYSIS.git
    cd job-market-sql-analysis
    ```

2. **Load the Data**
    - Use your preferred SQL client (SQLite, PostgreSQL, MySQL, etc.)
    - Import the provided CSV files to your database.

3. **Run the Analysis**
    - Open each `.sql` script in the `/sql` folder in order.
    - Review and export results as needed.

4. **Explore the Insights**
    - Check the `/results` folder for exported summaries.

---

## Query 1
### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on remote jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
WHERE
    job_title = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```
![Top Paying Roles](assets/top10_data_analyst_jobs.jpg)
*This chart shows the top 10 highest-paying remote Data Analyst jobs by average yearly salary, grouped by job type. Full-time and contract roles offer the highest pay, up to $650,000 per year.*

## Query 2
### 2. Skills for Top Paying Jobs

To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
-- Gets the top 10 paying Data Analyst jobs
WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg
    FROM
        job_postings_fact
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    top_paying_jobs.job_id,
    top_paying_jobs.job_title,
    top_paying_jobs.salary_year_avg,
    skills_dim.skills
FROM
    top_paying_jobs
    INNER JOIN
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    top_paying_jobs.salary_year_avg DESC;

```
![Top Analysts Skills](assets/top10_analyst_skills.jpg)
*This chart shows the top 10 highest-paying remote Data Analyst jobs, highlighting the required skills for each role. Most high-paying positions demand strong SQL abilities, often paired with Python, Power BI, and other specialized tools.*

## Query 3
### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT
  skills_dim.skills,
  COUNT(skills_job_dim.job_id) AS demand_count
FROM
  job_postings_fact
  INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
  skills_dim.skills
ORDER BY
  demand_count DESC
LIMIT 5;
```
![Top 5 Skills for DA](assets/top5_data_analyst_skills.jpg)
*This chart illustrates the five most sought-after skills for Data Analyst positions. SQL is the most in-demand skill, followed by Excel, Python, Power BI, and Tableau.*

## Query 4
### 4. Skills Based on Salary

Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
SELECT
  skills_dim.skills AS skill,
  ROUND(AVG(job_postings_fact.salary_year_avg),2) AS avg_salary
FROM
  job_postings_fact
INNER JOIN
  skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN
  skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
  job_postings_fact.job_title_short = 'Data Analyst'
  AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY
  skills_dim.skills
ORDER BY
  avg_salary DESC;

```
![Top 5 Highest Paying skills](assets/top5_highest_paying_skills.jpg)
*This chart shows which technical skills are linked to the highest average salaries for Data Analyst roles. Specialized skills like Solidity and SVN are associated with premium pay, while Power BI, Python, and Tableau also offer strong earning potential.*

## Query 5
### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
WITH skills_demand AS (
  SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
  FROM
    job_postings_fact
    INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
  WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_location = 'Anywhere'
  GROUP BY
    skills_dim.skill_id
),
average_salary AS (
  SELECT
    skills_job_dim.skill_id,
    AVG(job_postings_fact.salary_year_avg) AS avg_salary
  FROM
    job_postings_fact
    INNER JOIN
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
  WHERE
    job_postings_fact.job_title_short = 'Data Analyst'
    AND job_postings_fact.salary_year_avg IS NOT NULL
    AND job_postings_fact.job_location = 'Anywhere'
  GROUP BY
    skills_job_dim.skill_id
)
SELECT
  skills_demand.skills,
  skills_demand.demand_count,
  ROUND(average_salary.avg_salary, 2) AS avg_salary
FROM
  skills_demand
  INNER JOIN
  average_salary ON skills_demand.skill_id = average_salary.skill_id
ORDER BY
  demand_count DESC,
  avg_salary DESC
LIMIT 10;
```
![Top Optimal Skills With Remote](assets/top10_skills_remote_analyst.jpg)
*This chart highlights the 10 most sought-after skills for remote Data Analyst roles, showing both the number of job postings and the average salary for each skill. SQL and Python lead in demand, while niche skills like Solidity and SVN command higher average salaries.*

## Sample Results Preview

| Job Title           | Listings |
|---------------------|----------|
| Data Analyst        | 1242     |
| Software Engineer   | 987      |
| Business Analyst    | 876      |
| Data Scientist      | 654      |

---

## Why SQL?

SQL remains the backbone of data analysis in the job market.  
This project is a demonstration of how powerful simple queries can be when combined with real datasets and a problem-solving mindset.

---
### **What I Learned**

Throughout this project, I significantly deepened my SQL expertise, including:

- **Complex Query Construction**  
  - Mastered advanced `JOIN` operations (INNER, LEFT, RIGHT, FULL OUTER) across multiple tables for richer data relationships.
  - Developed complex filtering using nested subqueries and window functions.

- **CTEs and Window Functions**  
  - Utilized **Common Table Expressions (CTEs)** with the `WITH` clause to modularize and structure complicated queries for better readability and maintainability.
  - Applied **window functions** like `ROW_NUMBER()`, `RANK()`, `DENSE_RANK()`, and `OVER(PARTITION BY ...)` to create running totals, rankings, and group-wise calculations.

- **Data Aggregation & Analysis**  
  - Used aggregation functions (`SUM()`, `AVG()`, `COUNT()`, `MIN()`, `MAX()`) combined with `GROUP BY` and `HAVING` to extract deep insights and spot trends in large datasets.
  - Built queries to analyze salary distributions, skill frequencies, and job market trends by various categories.

- **Advanced Filtering and Case Logic**  
  - Leveraged complex `CASE WHEN` statements for conditional logic and custom grouping within queries.
  - Employed date functions and string manipulation to preprocess and clean raw data.

- **Performance Optimization**  
  - Improved query performance by optimizing joins, using indexes, and avoiding unnecessary subqueries.
  - Applied query profiling techniques to troubleshoot and streamline slow SQL queries.

- **Data Transformation & Preparation**  
  - Transformed and pivoted data using SQL (including `PIVOT`/`UNPIVOT` in some DBMS) to facilitate reporting and visualization.
  - Designed queries that output clean, analysis-ready tables for downstream BI tools.

- **Real-World Problem Solving**  
  - Translated business and analytical questions into actionable SQL queries.
  - Developed end-to-end analytical workflows, from raw data ingestion to actionable dashboards.
---

### **Insights**

From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest salaries for remote data analyst roles span a wide range, with the top offers reaching up to $650,000.
2. **Skills for Top-Paying Jobs**: The most lucrative data analyst positions consistently require advanced SQL skills, making SQL expertise a key factor in landing top-paying roles.
3. **Most In-Demand Skills**: SQL stands out as the most frequently requested skill across data analyst job listings, making it indispensable for candidates in this field.
4. **Skills with Higher Salaries**: Specialized technologies like SVN and Solidity are associated with the highest average pay, indicating that niche skills can significantly boost earning potential.
5. **Optimal Skills for Job Market Value**: SQL not only dominates in demand but also commands strong average salaries, positioning it as a highly valuable skill for maximizing opportunities in the job market.


## **Connect**

If you enjoyed this analysis or have suggestions for new insights, feel free to reach out via [LinkedIn](https://linkedin.com/in/praffulthejagadadasu).

## **License**

This repository is licensed under the MIT License.

