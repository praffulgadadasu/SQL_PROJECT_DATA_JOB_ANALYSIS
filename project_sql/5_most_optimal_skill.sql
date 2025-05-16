WITH skills_demand AS(
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
    -- Filters job titles for 'Data Analyst' roles
        job_postings_fact.job_title_short = 'Data Analyst'
        AND job_work_from_home = True -- optional to filter for remote jobs
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
),

salary_average AS(
    SELECT
        skills_dim.skill_id,
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
	-- AND job_work_from_home = True  -- optional to filter for remote jobs
    GROUP BY
        skills_dim.skill_id
)


SELECT
    skills_demand.skills,
    skills_demand.demand_count,
    ROUND(salary_average.avg_salary, 2) AS avg_salary --ROUND to 2 decimals 
FROM
    skills_demand
	INNER JOIN
	salary_average ON skills_demand.skill_id = salary_average.skill_id
-- WHERE demand_count > 10
ORDER BY
    demand_count DESC, 
	salary_average DESC
LIMIT 10