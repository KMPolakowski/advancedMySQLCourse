-- S06-P01 Coding practice

SET @row_number = 0;
SET @dummy_id = 0;

SELECT
	date,
    hour,
    user_id,
    login_count,
    @row_number := IF(user_id = @dummy_id, @row_number + 1, 1) AS row_number,
    @dummy_id := user_id AS dummy_id
FROM sample_staff.user_stat
WHERE 1=1
	AND row_number < 4
ORDER BY
    login_count DESC

;






