use labor_sql;

go

/*HOMEWORK3
1.
WITH COMP AS (  
  SELECT price, 'pc' type,model
  FROM pc
  UNION ALL 
  SELECT price, 'laptop' type,model
  FROM laptop
  UNION ALL 
  SELECT price, 'printer' type,model
  FROM printer
  ) 
SELECT price AS max_sum, type, model 
FROM COMP WHERE price>= ALL ( SELECT price FROM COMP);
2.

;WITH Letters AS(
SELECT ASCII('A') code, CHAR(ASCII('A')) letter
UNION ALL
SELECT code+1, CHAR(code+1) FROM Letters
WHERE code+1 <= ASCII('Z')
)
SELECT letter FROM Letters

3.
;WITH Recursive_region (region_id,place_id,name,PlaceLevel)
AS
(
    SELECT region_id,id,name,Placelevel=1
    FROM geography
    WHERE region_id=1
    UNION ALL
    SELECT e.region_id, e.id,e.name,r.Placelevel+1
    FROM  geography e INNER JOIN Recursive_region r 
	ON e.id= r.region_id
      )
SELECT *FROM Recursive_region
WHERE PlaceLevel=1
option (maxrecursion 30)

4.
;WITH Recursive_region (region_id,place_id,name,PlaceLevel)
AS
(
    SELECT region_id,id,name,PlaceLevel=-1
    FROM geography
    WHERE name='Ivano-Frankivsk'
    UNION ALL
    SELECT e.region_id, e.id,e.name,r.PlaceLevel +1
    FROM  geography e INNER JOIN Recursive_region r 
	ON e.region_id= r.place_id
      )
SELECT region_id,place_id,name,PlaceLevel FROM Recursive_region

5.
;WITH CTE_10000(num) AS ( SELECT num=1  UNION ALL SELECT num+1 FROM CTE_10000 WHERE num<10000)
SELECT num FROM CTE_10000
ORDER BY num
option (maxrecursion 0) 

6.
;WITH CTE_100000(num) AS ( SELECT num=1  UNION ALL SELECT num+1 FROM CTE_100000 WHERE num<100000)
SELECT num FROM CTE_100000
ORDER BY num
option (maxrecursion 0)

7.
SET LANGUAGE English
;WITH Data (A,name)AS
(SELECT CAST ('20190101' as date) AS A, DATENAME(WEEKDAY,'20190101')
UNION ALL
SELECT DATEADD(DAY,1,A),DATENAME (WEEKDAY,DATEADD(DAY,1,A)) FROM Data
WHERE A <'20191231'
 ),
  Data_1 AS
  (SELECT A,name FROM Data
  WHERE name IN ('Saturday','Sunday'))

  SELECT COUNT(*) FROM Data_1
  option (maxrecursion 0)

8.
SELECT DISTINCT maker
FROM product
WHERE type IN('pc') 
AND maker NOT IN ( SELECT maker FROM product WHERE type ='laptop') 

9.
SELECT  DISTINCT maker 
FROM Product
WHERE type = 'pc'
AND maker !=ALL(SELECT maker FROM Product  WHERE type='laptop')

10.
SELECT  DISTINCT maker 
FROM Product
WHERE type = 'pc'
AND NOT maker = ANY(SELECT maker FROM Product  WHERE type='laptop')

11.
SELECT DISTINCT maker
 FROM Product
WHERE type IN ('pc')
AND maker IN (SELECT maker FROM product WHERE type = 'laptop')

12. 
SELECT DISTINCT maker 
FROM Product
WHERE type = 'pc'
AND NOT maker != ALL(SELECT maker FROM Product  WHERE type='laptop')

13. 
SELECT DISTINCT maker 
FROM Product
WHERE type = 'pc'
AND  NOT  maker = ANY (SELECT maker FROM Product  WHERE type='laptop')

14.
SELECT  DISTINCT maker
 FROM product
WHERE type IN ('pc') AND model = ANY ( SELECT model FROM pc ) 

15.
SELECT country,class 
FROM classes
WHERE COUNTRY = 'Ukraine' OR country = ANY (SELECT country FROM classes)

16.
SELECT ship,battle,date 
FROM outcomes,battles
WHERE battles.name=outcomes.battle AND result ='damaged'AND ship IN ( SELECT ship FROM outcomes WHERE result!='damaged')

17.
SELECT DISTINCT maker 
FROM product
WHERE EXISTS (SELECT model FROM pc WHERE product.model =pc.model) 

18.
SELECT DISTINCT maker FROM product
WHERE type='printer' AND maker IN (SELECT maker FROM product,pc WHERE product.model= pc.model AND speed IN(SELECT MAX(speed)FROM PC))

19.
SELECT DISTINCT  ships.class FROM ships,outcomes,classes
WHERE (outcomes.ship = ships.name) AND result='sunk'
UNION  SELECT classes.class FROM classes,outcomes
WHERE outcomes.ship=classes.class AND result='sunk'

20.
SELECT model,price FROM printer
WHERE price=(SELECT MAX(price)FROM printer)

21.
SELECT DISTINCT type,product.model,laptop.speed FROM product,laptop
WHERE laptop.model=product.model 
AND speed < ALL (SELECT speed FROM pc )  

22.
SELECT  DISTINCT maker,price FROM product p,printer s
WHERE p.model=s.model AND color ='y' AND price = (SELECT MIN(price) FROM printer WHERE color='y')

23.
SELECT battle,country,COUNT(ship)AS Countships 
FROM outcomes,ships,classes
WHERE outcomes.ship= ships.name AND ships.class=classes.class
GROUP BY country,battle
HAVING  COUNT(ship)>=2

24.
SELECT maker, COUNT(pc.code) AS pc,COUNT(laptop.code) AS laptop, COUNT(printer.code) AS printer
FROM product 
LEFT JOIN pc ON pc.model=product.model
LEFT JOIN laptop ON laptop.model=product.model
LEFT JOIN printer ON printer.model=product.model
GROUP BY maker

25.
SELECT maker,
(SELECT
   CASE WHEN COUNT(pc.model)= 0 THEN 'NO'
   ELSE CONCAT ('YES (', COUNT(pc.model) ,')')
   END) pc
FROM product p LEFT JOIN pc ON p.model=pc.model
GROUP BY maker

26.
SELECT DISTINCT A.пункт, A.дата ,inc AS прихід,out AS розхід
FROM (SELECT point AS пункт ,date AS дата 
FROM income_o
UNION ALL SELECT point,date FROM outcome_o ) A
LEFT JOIN income_o ON income_o.date=A.дата AND income_o.point=A.пункт 
LEFT JOIN outcome_o ON outcome_o.date=A.дата AND outcome_o.point=A.пункт 
ORDER BY A.пункт

27.
SELECT name,numGuns,bore,displacement,type,country,launched, A.class
FROM Ships AS A JOIN Classes AS B ON A.class = B.class
WHERE
CASE WHEN numGuns = 8 THEN 1 ELSE 0 END +
CASE WHEN bore = 15 THEN 1 ELSE 0 END +
CASE WHEN displacement = 32000 THEN 1 ELSE 0 END +
CASE WHEN type = 'bb' THEN 1 ELSE 0 END +
CASE WHEN launched = 1915 THEN 1 ELSE 0 END +
CASE WHEN A.class = 'Kon' THEN 1 ELSE 0 END +
CASE WHEN country = 'USA' THEN 1 ELSE 0 
END > = 4

28.
SELECT onse.point,
       onse.date,
CASE WHEN onse.out>more.sum_out THEN 'once a day'
     WHEN onse.out=more.sum_out THEN 'both'
	 ELSE 'more than once a day' END AS RESULT
FROM 
(SELECT point,date,SUM(out) AS sum_out
FROM outcome
GROUP BY date,point)more 
FULL JOIN outcome_o onse ON more.date=onse.date AND more.point=onse.point

29.
SELECT maker,A.model,type ,A.price
FROM product JOIN (SELECT model,price FROM pc UNION SELECT model,price FROM laptop UNION SELECT model,price FROM printer) A 
ON A.model=product.model
WHERE maker='B'

30.
SELECT A.nameship,class
FROM  (SELECT name AS nameship FROM ships UNION SELECT ship FROM outcomes)A
JOIN classes ON classes.class=A.nameship

31.
SELECT DISTINCT A.class
FROM  (SELECT name,class FROM ships UNION  SELECT ship,ship FROM outcomes)A,classes
WHERE A.class=classes.class
GROUP BY A.class
HAVING COUNT(A.class)=1

32.
SELECT name 
FROM Ships
WHERE launched < 1942
UNION 
SELECT ship
FROM Outcomes, Battles 
WHERE name = battle AND 
DATEPART(YEAR, date) < 1942
UNION 
SELECT ship
FROM Outcomes
WHERE ship IN (SELECT class
FROM Ships
WHERE launched < 1942
)
*/
