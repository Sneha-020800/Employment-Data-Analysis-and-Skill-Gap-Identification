use finalproject;
show tables;

select * from 6thweek;


-- 1. Show all hired applicants
SELECT company, jobtitle, Location, salary
FROM 6thweek
WHERE hired = 'Yes';


-- 2. Count of applicants by company
SELECT company, COUNT(*) AS total_applicants
FROM 6thweek
GROUP BY company
ORDER BY total_applicants DESC;


-- 3. Average salary by industry
SELECT Industry, AVG(salary) AS avg_salary
FROM 6thweek
WHERE salary IS NOT NULL
GROUP BY Industry;


-- 4. Platforms with most applications
SELECT appliedplatform, COUNT(*) AS total_applications
FROM 6thweek
GROUP BY appliedplatform
ORDER BY total_applications DESC;


-- 5. Average years of experience by hiring status
SELECT HiringStatus, AVG(YearsofExperience) AS avg_experience
FROM 6thweek
GROUP BY HiringStatus;


-- 6. Find the top 5 job titles with the highest average salary
SELECT jobtitle, ROUND(AVG(salary), 2) AS avg_salary
FROM 6thweek
WHERE salary IS NOT NULL
GROUP BY jobtitle
ORDER BY avg_salary DESC
LIMIT 5;


-- 7. Hiring rate (%) by company
SELECT 
    company,
    COUNT(*) AS total_applicants,
    SUM(CASE WHEN hired = 'Yes' THEN 1 ELSE 0 END) AS total_hired,
    ROUND(SUM(CASE WHEN hired = 'Yes' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS hiring_rate_percentage
FROM 6thweek
GROUP BY company
HAVING total_applicants > 5
ORDER BY hiring_rate_percentage DESC;


-- 8. Top 3 industries with the most experienced hires
SELECT 
    Industry,
    ROUND(AVG(YearsofExperience), 2) AS avg_experience,
    COUNT(*) AS total_hired
FROM 6thweek
WHERE hired = 'Yes'
GROUP BY Industry
HAVING COUNT(*) > 2
ORDER BY avg_experience DESC
LIMIT 3;


-- 9. Rank companies by average monthly salary using a window function
SELECT 
company,
ROUND(AVG(MonthlySalary), 2) AS avg_monthly_salary,
RANK() OVER (ORDER BY AVG(MonthlySalary) DESC) AS salary_rank
FROM 6thweek
WHERE MonthlySalary IS NOT NULL
GROUP BY company;


-- 10. Find the company whose average salary is above the overall average
SELECT company, ROUND(AVG(salary), 2) AS avg_salary
FROM 6thweek
GROUP BY company
HAVING AVG(salary) > (
    SELECT AVG(salary) FROM 6thweek WHERE salary IS NOT NULL
)
ORDER BY avg_salary DESC;


-- 11. Monthly trend of job applications
SELECT 
    YEAR(STR_TO_DATE(applicationdate, '%d-%m-%Y')) AS year,
    MONTH(STR_TO_DATE(applicationdate, '%d-%m-%Y')) AS month,
    COUNT(*) AS total_applications
FROM 6thweek
GROUP BY year, month having year and month is not null
order by year,month;

