use sample_ip;
SELECT INET_ATON('145.168.50.1');


-- Transform IPs into integer values
TRUNCATE ip_address_int;

INSERT INTO ip_address_int (id, ip_address)
SELECT
	ip_address_varchar20.id,
    INET_ATON(ip_address_varchar20.ip_address)
FROM ip_address_varchar20;


ANALYZE TABLE ip_address_varchar20;
ANALYZE TABLE ip_address_int;

-- Number of rows check
select count(*) from ip_address_varchar20;
select count(*) from ip_address_int;

-- Table size comparison
SELECT
	table_name,
    (data_length + index_length) / power (1024, 2) AS tablesize_mb
FROM information_schema.tables
WHERE 1=1
	AND table_name IN('ip_address_varchar20', 'ip_address_int');
    
    

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
		ORDER BY user_login.login_dt DESC;
    

    

    





