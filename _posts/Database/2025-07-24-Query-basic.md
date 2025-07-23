---
title: "Database Query 기초"
categories:
 - Database
tags:
  - Database
  - Query
toc: true
toc_sticky: true
---


# 오라클 Query

> 간단 커서 사용

```sql
DECLARE
	CURSOR test_cur IS 
	SELECT * FROM EMPLOYEES;
	
BEGIN 
	FOR test_row IN test_cur LOOP
	  DBMS_OUTPUT.PUT_LINE(test_row.FIRST_NAME);
	END LOOP;
END;
```

> With 사용

```sql
WITH test_with AS 
(
	SELECT * FROM EMPLOYEES e 
	INNER JOIN JOBS j ON e.JOB_ID = j.JOB_ID
)

SELECT * FROM test_with;
```