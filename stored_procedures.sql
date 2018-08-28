-- S08-P02 Coding practice
USE sample_staff;

DROP PROCEDURE IF EXISTS `INS_USER_LOGIN_DATA_GENERATOR`;

DELIMITER //

CREATE PROCEDURE `INS_USER_LOGIN_DATA_GENERATOR`()
BEGIN
	DECLARE p_ip_address VARCHAR(20);
	DECLARE p_user_id INT;
	DECLARE p_loop_counter INT DEFAULT 10;
	WHILE p_loop_counter > 0 DO
		INSERT INTO `sample_staff`.`user_login`
		(`user_id`, `login_dt`, `ip_address`, `insert_dt`,
		`insert_process_code`)
		SELECT
			`user`.`id` AS user_id,
			NOW() AS login_dt,
			INET_ATON(`ip_address_varchar20`.`ip_address`) AS ip_address,
			NOW(),
			'INS_USER_LOGIN_DATA_GENERATOR' AS insert_process_code
		FROM `sample_staff`.`user`
		INNER JOIN `sample_ip`.`ip_address_varchar20` ON 1=1
			AND `sample_ip`.`ip_address_varchar20`.`id` < 100
		ORDER BY RAND()
		LIMIT 1000
		;
			SET p_loop_counter = p_loop_counter - 1;
	END WHILE;
END;
//

DELIMITER ;





DROP PROCEDURE IF EXISTS DEL_USER_LOGIN_OLDER_10MIN;

SHOW VARIABLES LIKE 'event_scheduler';

SET GLOBAL event_scheduler = 1;

DELIMITER //

CREATE PROCEDURE DEL_USER_LOGIN_OLDER_10MIN  ()
BEGIN
	DELETE user_login;
    FROM sample_staff;
    WHERE TIMESTAMPDIFF(NOW(), user_login.inser_dt) > 10;
END;

DELIMITER ;







DROP EVENT IF EXISTS EV_GEN_USER_DATA;
DELIMITER //

CREATE EVENT EV_GEN_USER_DATA
ON SCHEDULE EVERY 30 SECOND
STARTS NOW()
ENDS NOW() + INTERVAL 1 HOUR
	COMMENT 'Generate Data to sample_staff.user_login'
	DO
    CALL INS_USER_LOGIN_DATA_GENERATOR()
//

DELIMITER ;


SELECT * FROM sample_staff.user_login;

SHOW events;



-- S08-P01 Coding practice

USE sample_staff;

CREATE VIEW v_average_salary
AS
	SELECT
		department.id AS department_id,
        department.name AS department_name,
        AVG(salary.salary_amount) AS average_salary_amount,
        CONCAT(MONTH(invoice.invoiced_date), '/', YEAR(invoice.invoiced_date))
			AS month_year
	FROM sample_staff.department
    JOIN sample_staff.department
    ON 1=1
		AND sample_staff.department_employee_rel.department_id
			= department_id
	JOIN department_employee_rel
    ON 1=1
		AND employee_id = sample_staff.salary.employee_id
        AND invoice.invoiced_date BETWEEN salary.from_date
			AND salary.to_date
	JOIN salary
    ON 1=1
		AND employee_id = invoice.employee_id
        AND invoice.invoiced_date BETWEEN from_date AND to_date
GROUP BY
	department_id,
    department_name
;




-- S08-P03 Coding practice


USE sample_staff;



DELIMITER //

CREATE PROCEDURE INS_USER_STAT
(
	user_id INT
)
BEGIN
	INSERT INTO sample_staff.user_stat
    (user_id, login_date, login_hour, login_count)
		SELECT 
			user_id,
            CURDATE() AS login_date,
            HOUR(NOW()) AS login_hour,
            COUNT(login_count)+1 AS login_count
		FROM sample_staff.user_stat
        WHERE 1=1
			AND user_stat.login_date = login_date
            AND user_stat.login_hour = login_hour
		;
END;
//

DELIMITER ;









        
        
        
        


