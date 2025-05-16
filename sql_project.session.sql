SELECT
    job_postings_q1.job_id,
    job_postings_q1.job_title_short,
    job_postings_q1.salary_year_avg
FROM(
    SELECT *
    FROM jan_jobs
    UNION ALL
    SELECT *
    FROM feb_jobs
    UNION ALL
    SELECT *
    FROM mar_jobs
) AS job_postings_q1
WHERE
    job_postings_q1.salary_year_avg > 70000
