-- Write only the SQL statement that solves the problem and nothing else.
 SELECT name
    FROM (SELECT [name]
            FROM [dogs]
          UNION ALL
          SELECT [name]
            FROM [cats] )
GROUP BY name