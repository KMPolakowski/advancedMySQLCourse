-- S02-P01 Coding practice

SELECT employee.id AS 'employee_id',
       Concat(employee.first_name, ' ', employee.last_name) AS 'employee_full_name',
       department.id AS 'department_id',
       department.name AS 'last_department_name'
FROM employee
INNER JOIN
		(
        SELECT
			department_employee_rel.employee_id AS 'employee_id',
			Max(department_employee_rel.id) AS 'max_id'
		FROM department_employee_rel
		WHERE 1=1
			AND department_employee_rel.deleted_flag = 0
			GROUP BY department_employee_rel.employee_id
		)
		ON department_employee_rel.employee_id = employee.id
			INNER JOIN department_employee_rel
			ON 1=1
				AND department_employee_rel.id = department_employee_rel.max_id
				AND department_employee_rel.deleted_flag = 0
					INNER JOIN department
					ON 1=1
						AND deparment.id = department_employee_rel.department_id
						AND deparment.deleted_flag = 0
					WHERE 1=1
						AND employee.id IN ( 10010, 10040, 10050, 91050, 205357)
						AND employee.deleted_flag = 0
LIMIT  100;  




-- S02-P02 Coding practice

CREATE VIEW v_user_login
AS
	SELECT
		user_login.id AS 'user_login_id',
		user_login.user_id AS 'user_id',
		user.name AS 'user_name',
		user_login.ip_address AS 'user_ip_numberVal',
		inet_ntoa(user_login.ip_address) AS 'user_ip_adress',
		user_login.login_dt
	FROM sample_staff.user_login
	JOIN sample_staff.user ON 1=1
		AND user.id = user_login.user_id
	WHERE 1=1
		AND user_login.deleted_flag = 0
		ORDER BY user_login.login_dt DESC;
        
        


-- S02-P03 Coding practice  


INSERT INTO bi_data.valid_offers
    (offer_id,
    hotel_id,
    price_usd,
    original_price,
    original_currency_code,
    checkin_date,
    checkout_date,
    breakfast_included_flag,
    valid_from_date,
    valid_to_date)
	SELECT
        offer_cleanse_date_fix.id AS 'offer_id',
        offer_cleanse_date_fix.hotel_id AS 'hotel_id',
        offer_cleanse_date_fix.sellings_price AS 'selling_price',
        lst_currency.code AS 'original_currency_code',
        offer_cleanse_date_fix.checkin_date AS 'check_in date',
        offer_cleanse_date_fix.checkout_date AS 'check_out data',
        offer_cleanse_date_fix.breakfast_included_flag AS 'breakfast_included',
        offer_cleanse_date_fix.offer_valid_from AS 'offer_valid_from',
        offer_cleanse_date_fix.offer_valid_to AS 'offer_valid_to'
	FROM enterprise_data.offer_cleanse_date_fix,
		primary_data.lst_currency
		WHERE 1=1
			AND offer_cleanse_date_fix.currency_id = 1
			AND lst_currency.id = 1;  