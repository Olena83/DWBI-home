USE labor_sql
/*HOMEWORK 1
1.
SELECT maker,type FROM product
ORDER BY maker
2.
SELECT model,ram,screen,price FROM laptop
WHERE price>1000
ORDER BY ram ASC,price DESC
3.
SELECT*FROM printer
WHERE color ='y'
ORDER BY price DESC
4.
SELECT model,speed,hd,cd,price FROM PC
WHERE (cd ='12x' OR cd= '24x') AND price < 600
ORDER BY speed DESC
5.
SELECT name,class FROM ships
WHERE name IN (SELECT class FROM classes)
ORDER BY name
6.
SELECT*FROM pc
WHERE speed >=500 AND price<800
ORDER BY price DESC 
7.
SELECT*FROM printer 
WHERE type NOT IN ('Matrix') AND price<300
ORDER BY type DESC
8.
SELECT model,speed FROM pc
WHERE price BETWEEN 400 AND 600
ORDER BY hd
9.
SELECT model,speed,hd,price
FROM laptop
WHERE screen >=12
ORDER BY price DESC 
10.
SELECT model,type,price FROM printer
WHERE price <300
ORDER BY type DESC
11.
SELECT model,ram,price
FROM laptop
WHERE ram =64
ORDER BY screen
12.
SELECT model,ram,price FROM pc
WHERE ram >64
ORDER BY hd
13.
SELECT model,speed,price FROM pc
WHERE speed BETWEEN 500 AND 750
ORDER BY hd DESC
14.
SELECT*FROM outcome_o
WHERE out >2000
ORDER BY date DESC
15.
SELECT*FROM income_o
WHERE inc BETWEEN 5000 AND 10000
ORDER BY inc
16.
SELECT*FROM income_o
WHERE point=1
ORDER BY inc
17.
SELECT*FROM outcome
WHERE point=2
ORDER BY out
18.
SELECT *FROM classes
WHERE country='Japan'
ORDER BY type DESC
19.
SELECT name,launched FROM ships
WHERE launched BETWEEN 1920 AND 1942
ORDER BY launched DESC
20.
SELECT ship,battle,result FROM outcomes
WHERE battle ='Guadalcanal' AND result NOT IN ('sunk')
ORDER BY ship DESC 
21.
SELECT  ship,battle,result FROM outcomes
WHERE result='sunk'
ORDER BY ship DESC 
22.
SELECT class,displacement FROM classes
WHERE displacement>=40000
ORDER BY type
23.
SELECT trip_no,town_from,town_to
FROM trip
WHERE town_from='London' OR town_to='London'
ORDER BY time_out
24.
SELECT trip_no,plane,town_from,town_to FROM trip
WHERE plane ='TU-134'
ORDER BY time_out DESC
25.
SELECT trip_no,plane,town_from,town_to FROM trip
WHERE plane !='IL-86'
ORDER BY plane
26.
SELECT trip_no,town_from,town_to FROM trip
WHERE town_from!='Rostov'AND town_to!='Rostov'
ORDER BY plane
27.
SELECT  model 
FROM pc
WHERE CHARINDEX ('1',SUBSTRING (model, (SELECT CHARINDEX ('1' , model)+1), (SELECT LEN(model)))) !=0
28.
SELECT * FROM outcome
WHERE MONTH (date)=3
29.
SELECT*FROM outcome_o
WHERE DAY(date)=14
30.
SELECT name FROM ships
WHERE SUBSTRING (name, 1, 1) = 'W' AND SUBSTRING (name,(SELECT LEN(name)), 1)='n'
31.
SELECT name FROM ships
WHERE CHARINDEX ('e',SUBSTRING (name, (SELECT CHARINDEX ('e' , name)+1), (SELECT LEN(name)))) !=0
32.
SELECT name,launched FROM ships
WHERE SUBSTRING (name,(SELECT LEN(name)), 1)!='a'
33.
SELECT name FROM battles
WHERE CHARINDEX (' ',name)!=0 AND SUBSTRING(name,LEN(name), 1)!='c'
34.
SELECT * FROM trip
WHERE DATENAME (hour,time_out) BETWEEN 12 AND 17
35.
SELECT*FROM trip
WHERE DATENAME (hour,time_in) BETWEEN 17 AND 23
36.
SELECT*FROM trip
WHERE DATENAME (hour,time_in) BETWEEN 21 AND 23  OR DATENAME (hour,time_in) BETWEEN 0 AND 10
37.
SELECT date FROM pass_in_trip
WHERE place LIKE '1%'
38.
SELECT date FROM pass_in_trip
WHERE place LIKE '%c'
39.
SELECT SUBSTRING(name, CHARINDEX(' ', name)+1,LEN (name) - (CHARINDEX(' ', name)))FROM passenger
WHERE SUBSTRING(name, CHARINDEX(' ', name)+1,LEN (name) - (CHARINDEX(' ', name))) LIKE 'C%'
40.
SELECT SUBSTRING(name, CHARINDEX(' ', name)+1,LEN (name) - (CHARINDEX(' ', name)))FROM passenger
WHERE SUBSTRING(name, CHARINDEX(' ', name)+1,LEN (name) - (CHARINDEX(' ', name))) NOT LIKE 'J%'
41.
SELECT  'середня ціна ='+ CAST (AVG(price) AS nvarchar ) FROM laptop
42.
SELECT 'КОД :'+ CAST(code AS nvarchar) + '   модель :'+ CAST(model AS nvarchar) +'    швидкість процесора :' + CAST(speed AS nvarchar)+
'   об"єм пам"яті:'+CAST (ram AS nvarchar)+ '   розмір диску:'+ CAST(hd AS nvarchar)+
 '  швидкість CD-приводу:'+CAST(cd AS nvarchar) +'   ціна:'+ CAST(price AS nvarchar) FROM pc 
43.
SELECT CONVERT(VARCHAR(10), date, 102)FROM income
44.
SELECT REPLACE(REPLACE(REPLACE(result,'sunk' ,'потоплений'),'damaged','пошкоджений'),'OK','цілий') FROM  outcomes
45.
SELECT 'ряд:' + SUBSTRING(place, 1, LEN(place)-1) AS Numberplace,
'місце:'+SUBSTRING(place, LEN(place), 1) AS Letterplace FROM pass_in_trip
46.
SELECT CONCAT('from ',town_from ,'to ',town_to) AS Towntrip FROM trip
47. 
SELECT REPLACE((LEFT (CAST(trip_no AS nvarchar), 1)+ RIGHT (CAST(trip_no AS nvarchar),1)+
LEFT (CAST(id_comp AS nvarchar),1)+RIGHT(CAST (id_comp AS nvarchar),1)+
LEFT (CAST(plane AS nvarchar), 1)+ RIGHT (CAST(plane AS nvarchar), 11-LEN (plane))+
LEFT (CAST(town_from AS nvarchar), 1)+ RIGHT (CAST(town_from AS nvarchar), 26-LEN (town_from))+
LEFT (CAST(town_to AS nvarchar), 1)+ RIGHT (CAST(town_to AS nvarchar), 26-LEN (town_to))+
LEFT (CONVERT(nvarchar,time_out,21), 1)+ RIGHT (CONVERT(nvarchar,time_out,21), 1)+
LEFT (CONVERT(nvarchar,time_in,21), 1)+ RIGHT (CONVERT(nvarchar,time_in,21), 1)),' ','') AS ALLDATA FROM trip
48.
SELECT maker, COUNT(model) FROM product
WHERE type='PC' 
GROUP BY maker
HAVING (MAX(model)!=MIN(model))
49.
SELECT TOWN, COUNT(DATA) AS CountDataALL 
FROM (SELECT town_from AS TOWN, time_out AS DATA FROM Trip
UNION ALL SELECT town_to AS TOWN, time_in AS DATA FROM Trip)A
GROUP BY TOWN
50.
SELECT type, COUNT(model)FROM printer
GROUP BY type
51.
SELECT p1.model,p1.cd,Countcd,Countmodel 
FROM (SELECT DISTINCT model,cd ,COUNT(cd) AS Countcd  FROM pc GROUP BY model,cd) AS p1
JOIN  (SELECT DISTINCT cd,COUNT(model) AS Countmodel FROM pc GROUP BY cd ) AS p2
ON p2.cd=p1.cd
ORDER BY p1.model 
52. 
SELECT  CONVERT (nvarchar(10),time_in-time_out,108) AS Timetrip FROM trip
53.
SELECT DATA1.point,SUMM1,SUMM2,Maxsumma1,Minsumma1,Maxsumma2,Minsumma2
FROM (SELECT point,date,SUM (out)AS SUMM1 FROM outcome GROUP BY date,point) AS DATA1 
JOIN (SELECT point, SUM(out) AS SUMM2 FROM outcome GROUP BY point) AS DATA2 ON DATA2.point=DATA1.point
JOIN (SELECT point,MAX(SUMM1)AS Maxsumma1 FROM (SELECT date,point ,SUM (out) AS SUMM1 FROM outcome GROUP BY date,point)AS DATA1 GROUP BY point)AS DATA3 ON DATA3.point=DATA1.point
JOIN (SELECT point,MIN(SUMM1)AS Minsumma1 FROM (SELECT date,point ,SUM (out) AS SUMM1 FROM outcome GROUP BY date,point)AS DATA1 GROUP BY point) AS DATA4  ON DATA4.point=DATA1.point
JOIN (SELECT point,MAX(SUMM2)AS Maxsumma2 FROM (SELECT point, SUM(out) AS SUMM2 FROM outcome GROUP BY point)AS DATA2 GROUP BY point)AS DATA5 ON DATA5.point=DATA1.point
JOIN (SELECT point,MIN(SUMM2)AS Minsumma2 FROM (SELECT point, SUM(out) AS SUMM2 FROM outcome GROUP BY point)AS DATA2 GROUP BY point)AS DATA6 ON DATA6.point=DATA1.point
54.
SELECT trip_no, SUBSTRING (place,LEN(place)-1,1) AS Placenumber ,COUNT (SUBSTRING (place,LEN(place)-1,1)) AS COUNTNUMBERplace FROM pass_in_trip 
GROUP BY trip_no, SUBSTRING (place,LEN(place)-1,1)
ORDER BY trip_no
55. 
SELECT SUBSTRING (name,1,1) AS LetterNAME, COUNT (SUBSTRING (name,1,1)) AS COUNTPASSENGER FROM passenger
WHERE  SUBSTRING (name,1,1) ='S' OR SUBSTRING (name,1,1) ='B' OR SUBSTRING (name,1,1) ='A'
GROUP BY SUBSTRING (name,1,1) */
 
  