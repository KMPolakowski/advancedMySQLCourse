-- S03-P01 Coding practice

CREATE INDEX idx_personal_code_2chars
	ON sample_staff.employee(personal_code(2));
    
CREATE INDEX idx_personal_code_allchars
	ON sample_staff.employee(personal_code)
;
    
EXPLAIN SELECT sample_staff.employee.id 
FROM sample_staff.employee USE INDEX (idx_personal_code_allchars)
WHERE 1=1
	AND employee.personal_code = "AA-751492"
;


EXPLAIN SELECT sample_staff.employee.id 
FROM sample_staff.employee USE INDEX (idx_personal_code_2chars)
WHERE 1=1
	AND employee.personal_code = "AA-751492"
;


-- It's good to run ANALYZE TABLE before checking index or table size
ANALYZE TABLE `sample_staff`.`employee`;

SELECT /* Select all indexes from table 'employee' and their size */
sum(`stat_value`) AS pages,
`index_name` AS index_name,
sum(`stat_value`) * @@innodb_page_size / 1024 / 1024 AS size_mb
FROM `mysql`.`innodb_index_stats`
WHERE 1=1
	AND `table_name` = 'employee'
	AND `database_name` = 'sample_staff'
	AND `stat_description` = 'Number of pages in the index'
GROUP BY
	`index_name`
	;

-- S03-P02 Coding practice 


EXPLAIN SELECT `contract`.`archive_code`
FROM `contract` 
WHERE 1=1
 AND `contract`.`archive_code` = 'DA970'
 AND `contract`.`deleted_flag` = 0
 AND `contract`.`sign_date` >= '1990-01-01'
;

ALTER TABLE contract ADD INDEX idx_archive_code_sign_date ( archive_code ,
sign_date );

EXPLAIN SELECT `contract`.`archive_code`
FROM `contract`
WHERE 1=1
AND `contract`.`archive_code` = 'DA970'
AND `contract`.`deleted_flag` = 0
;






    
    
    