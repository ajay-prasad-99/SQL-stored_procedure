select * from employees, jobs ;

select * from dbo.employees, production.stocks;

select * from production.brands,production.categories;

select * from employees, jobs,locations

select
		employees.employee_id ID ,employees.first_name NAme_, 
		jobs.max_salary salary_max ,jobs.min_salary salary_min 
		from employees, jobs ;


SELECT 45 max_id, 20 min_id , 'hello' calls ;

SELECT employee_id * 2 id, first_name, email FROM employees;
select * from employees

-- Mysql version
SELECT concat(first_name,' - ','(',email,')') AS name_and_email FROM employees ;


select employee_id stid from employees
union 
select job_id ndid from jobs

select employee_id  from employees
select job_id  from jobs

select employee_id stid from employees
except --which shows all the rows contained in employee_id not in Job_id
select job_id ndid from jobs
;
--NESTED 
select * from (select employee_id , first_name from employees
union 
select job_id, job_title from jobs) where first_name = 'Jennifer'

--SAME table union
select employee_id , first_name from employees
union 
select employee_id stid from employees

select * from employees;
select * from jobs;

-- intersect
select employee_id stid from employees
intersect -- common values only
select job_id ndid from jobs


--CARTESIAN PRODUCT 

select jobs.job_id, employees.first_name,employees.employee_id, jobs.job_title from employees, jobs where jobs.job_id = employees.employee_id;

--brands.brand_id,categories.category_name

select * from [production].[brands];
select * from [production].[categories];

select *from production.brands,production.categories
where brands.brand_id = categories.category_id;

--select jobs.job_id, jobs.job_title from jobs

--select employees.first_name,employees.employee_id from employees

select *from production.brands b , production.categories c
where b.brand_id = c.category_id;

--implementing joins

select *from production.brands b join  production.categories c
on b.brand_id = c.category_id;

-- two conditions
select *from production.brands b , production.categories c
where b.brand_id = c.category_id and c.category_name='Children Bicycles';


--SELECT
--    i.id as intermediary_id,
--    i.name as intermediary_name,
--    e.id as entity_id,
--    e.name as entity_name,
--    e.status as entity_status
--FROM 
--    intermediary i,
--    assoc_inter_entity a,
--    entity e
--WHERE
--    a.entity = e.id
--    AND a.inter = i.id
--    AND e.name = 'Big Data Crunchers Ltd.' ;



select  * from employees;

select job_id, count(*) group_count from employees group by job_id;

select hire_date from employees group by hire_date order by count(hire_date) desc ;

select max(job_id), min(job_id), job_id, employee_id,count(*) 
						from employees group by job_id,employee_id;

--SELECT
--    i.id as intermediary_id, 
--    i.name as intermediary_name,
--    e.jurisdiction, 
--    count(*) 
--FROM 
--    intermediary i,
--    assoc_inter_entity a, 
--    entity e 
--WHERE 
--    a.entity = e.id 
--    AND a.inter = i.id 
--    AND (i.id = 5000 OR i.id = 5001) 
--GROUP BY 
--    i.id, i.name, e.jurisdiction;


--ABS is an scalar function , not an aggregate.

select abs(job_id) abs_id, employee_id  from employees

-- abs returns each value for every row, this not returning single row


--orderby desc asc

select * from employees order by phone_number asc;
