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

## Sample Query

```sql
-- Top 10 In-Demand Job Titles
SELECT job_title, COUNT(*) AS num_jobs
FROM job_postings_fact
GROUP BY job_title
ORDER BY num_jobs DESC
LIMIT 10;
```
## Results Preview

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

## Inspiration

This project is based on Luke Barousse’s “Share on GitHub” learning approach, reimagined for practical job market analysis and for building a data analyst’s portfolio.

---

## Connect

If you enjoyed this analysis or have suggestions for new insights, feel free to reach out via [LinkedIn](https://linkedin.com/in/praffulthejagadadasu).

---

## License

This repository is licensed under the MIT License.

