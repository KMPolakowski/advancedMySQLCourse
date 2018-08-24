-- S04-P01 Coding practice

CREATE TABLE sample_staff.invoice_partitioned
AS
	SELECT * FROM sample_staff.invoice
;
    
ALTER TABLE sample_staff.invoice_partitioned
ADD COLUMN department_code VARCHAR(35)
;

SET SQL_SAFE_UPDATES = 0;

UPDATE sample_staff.invoice_partitioned
JOIN sample_staff.department_employee_rel
	ON 1=1
		AND department_employee_rel.employee_id
        =
        invoice_partitioned.employee_id
JOIN sample_staff.department
	ON 1=1
		AND department.id
        =
        department_employee_rel.department_id
SET invoice_partitioned.department_code = department.code
    WHERE 1=1
		AND invoice_partitioned.invoiced_date 
        BETWEEN
			department_employee_rel.from_date
            AND
            department_employee_rel.to_date    
;

ALTER TABLE sample_staff.invoice_partitioned
PARTITION BY LIST COLUMNS (department_code)
 	(
	PARTITION pCS VALUES IN ('CS'),
    PARTITION pDEV VALUES IN ('DEV'),
    PARTITION pFIN VALUES IN ('FIN'),
    PARTITION pHR VALUES IN ('HR'),
    PARTITION pMKT VALUES IN ('MKT'),
    PARTITION pPROD VALUES IN ('PROD'),
    PARTITION pRES VALUES IN ('RES'),
    PARTITION pCS VALUES IN ('CS'),
    PARTITION pSAL VALUES IN ('SAL')
 	)
;


SELECT * FROM department LIMIT 100;

-- little test
SELECT department_id
FROM department_employee_rel
WHERE 1=1
	AND '1985-12-01' BETWEEN from_date AND to_date
    AND employee_id = 10064;



