SHOW GLOBAL VARIABLES;


SHOW VARIABLES;

SET @whatever = 'Kamil';
SELECT @whatever;

-- S05-P01 Coding practice

SET @date = '2000-01-01'
;

SET @company_average_salary =
(
	SELECT
		AVG(salary_amount)
	FROM sample_staff.salary
    WHERE 1=1
		AND @date BETWEEN from_date AND to_date
);

SELECT @company_average_salary;


-- SELECT
-- 	CONCAT(MONTH(@date), '/',YEAR(@date)) AS year_month,
--     sample_staff.department.id AS department_id,
--     @department_average_salary :=
-- 		(
--         SELECT
-- 			AVG(salary_amount)
-- 		FROM sample_staff.salary
--         JOIN sample_staff.employee
--         AS 1=1
-- 			AND department_employee_rel.id = salary.employee_id
--             AND department_employee_rel.department_id = department.id
-- 	AS department_average_salary,
--     )
--     @company_average_salary AS company_average_salary,
-- 	CASE
-- 		WHEN @company_average_salary > @department_average_salary
--         THEN 'lower'
--         ELSE
-- 			WHEN @company_average_salary < @department_average_salary
--             THEN 'higher'
-- 			ELSE 'same'
-- 	END AS department_vs_company
-- FROM sample_staff.department
-- ;



SET @focus_date = '2000-01-01';
SET @company_average_salary := (
SELECT
ROUND(AVG(`salary`.`salary_amount`), 2) AS company_average_salary
FROM `sample_staff`.`salary`
WHERE 1=1
AND @focus_date BETWEEN `salary`.`from_date` AND
IFNULL(`salary`.`to_date`, '2002-08-01')
);





SELECT
`department_id` AS department_id,
`department_name` AS department_name,
`department_average_salary` AS department_average_salary,
@company_average_salary AS company_average_salary,
CASE
WHEN `department_average_salary` > @company_average_salary
THEN "higher"
WHEN `department_average_salary` = @company_average_salary
THEN "same"
ELSE "lower"
END AS department_vs_company
FROM (
SELECT
`department`.`id` AS department_id,
`department`.`name` AS department_name,
AVG(`salary`.`salary_amount`) AS department_average_salary
FROM `sample_staff`.`salary`
INNER JOIN `sample_staff`.`department_employee_rel` ON 1=1
AND `department_employee_rel`.`employee_id` = `salary`.`employee_id`
AND @focus_date BETWEEN `department_employee_rel`.`from_date` AND
IFNULL(`department_employee_rel`.`to_date`, '2002-08-01')
INNER JOIN `sample_staff`.`department` ON 1=1
AND `department`.`id` = `department_employee_rel`.`department_id`
WHERE 1=1
AND @focus_date BETWEEN `salary`.`from_date` AND
IFNULL(`salary`.`to_date`, '2002-08-01')
GROUP BY
`department`.`id`,
`department`.`name`
) xTMP





	



