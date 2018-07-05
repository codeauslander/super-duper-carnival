-- Write only the SQL statement that solves the problem and nothing else.
 SELECT name
    FROM (SELECT [name]
            FROM [dogs]
          UNION ALL
          SELECT [name]
            FROM [cats] )
GROUP BY name


-- -------------------------------------------------------------------------

-- Write only the SQL statement that solves the problem and nothing else.
SELECT e1.name Employee_But_Not_A_Manager
  FROM employees e1
  left JOIN employees e2
    ON e1.id = e2.managerId
 WHERE e2.managerId IS NULL


-- -------------------------------------------------------------------------

 -- Write only the SQL statement that solves the problem and nothing else.
UPDATE enrollments
SET [year] = 2015
WHERE id BETWEEN 20 AND 100;


-- -------------------------------------------------------------------------

-- Write only the SQL statement that solves the problem and nothing else.
    
  SELECT M.NAME AS MOTHER, F.NAME as FATHER ,P1.AGE AS [AGE] 

  FROM PEOPLE M

 INNER JOIN 
 (
  SELECT MOTHERID ,FATHERID,MIN(AGE)AGE FROM PEOPLE WHERE MOTHERID IS NOT NULL AND FATHERID IS NOT NULL
  
 ) 
  P1 ON M.ID =P1.MOTHERID  
  INNER JOIN PEOPLE F ON F.ID=P1.FATHERID 
