USE labor_sql
/*
1.
SELECT maker,type,pc.speed,pc.hd FROM product
JOIN pc ON pc.model=product.model 
WHERE hd<=8
2.
SELECT maker FROM product
JOIN pc ON pc.model=product.model 
WHERE speed >=600
3.
SELECT maker FROM product
JOIN laptop ON laptop.model=product.model 
WHERE speed<=500
4.
SELECT DISTINCT  A.model AS model_1, B.model AS model_2,A.hd ,A.ram 
FROM  laptop AS A,laptop B
WHERE A.hd=B.hd AND A.ram=B.ram 
AND A.model>B.model
5.
SELECT A.country, A.type,B.type FROM classes AS A,classes B
WHERE A.type='bb'AND B.type ='bc'AND A.country=B.country
6.
SELECT pc.model,maker FROM product 
JOIN pc ON pc.model=product.model 
WHERE price<600
7.
SELECT printer.model,maker FROM product,printer
WHERE printer.model=product.model AND price>300
8.
SELECT product.maker,laptop.model,price  FROM Laptop JOIN Product ON Laptop.model= Product.model 
UNION
SELECT product.maker,printer.model,price  FROM Printer JOIN Product ON Printer.model= Product.model 
9.
SELECT DISTINCT product.model,maker,price FROM product
JOIN pc ON pc.model=product.model
10.
SELECT maker,type,laptop.model,speed FROM product
JOIN laptop ON laptop.model=product.model
WHERE speed>600
11.
SELECT B.*,displacement FROM classes AS A
JOIN ships AS  B ON B.class=A.class
12.
SELECT B.*,date FROM battles A
JOIN outcomes B ON B.battle=A.name
WHERE result= 'OK'
13.
SELECT B.*, country FROM classes A
JOIN ships B ON B.class=A.class
14.
SELECT A.*,name FROM trip A
JOIN company B ON B.id_comp=A.id_comp
WHERE plane='Boeing'
15.
SELECT DISTINCT A.*,date FROM passenger A
JOIN pass_in_trip B ON B.id_psg=A.id_psg
ORDER BY A.id_psg
16.
SELECT pc.model,speed,hd FROM pc
JOIN product ON product.model=pc.model
WHERE ram ='10'OR ram ='20' AND maker='A'
ORDER BY speed
17.
SELECT maker,
[pc], [laptop], [printer] 
FROM product 
PIVOT 
(COUNT(model) 
FOR type 
IN([pc], [laptop], [printer]) 
) pvt 
18.
SELECT [avg_],
[11],[12],[14],[15]
FROM (SELECT 'average price' AS 'avg_', screen, price FROM laptop) x
PIVOT
(AVG(price)
FOR screen
IN([11],[12],[14],[15])
) pvt;
19.
SELECT A.maker, B.*  FROM 
product A 
CROSS APPLY
(SELECT * FROM laptop B WHERE A.model= B.model) B
20.
SELECT *
FROM laptop L1
CROSS APPLY
(SELECT MAX(price) MAXPRICE FROM Laptop L2
JOIN  Product P1 ON L2.model=P1.model 
WHERE maker = (SELECT maker FROM Product P2 WHERE P2.model= L1.model))data
21.
SELECT * FROM laptop L1
CROSS APPLY
(SELECT TOP 1 * FROM Laptop L2 
WHERE L1.model < L2.model OR (L1.model = L2.model AND L1.code < L2.code) 
ORDER BY model, code) DATA
ORDER BY L1.model
22.
SELECT * FROM laptop L1
OUTER APPLY
(SELECT TOP 1 * FROM Laptop L2 
WHERE L1.model < L2.model OR (L1.model = L2.model AND L1.code < L2.code) 
ORDER BY model, code) DATA
ORDER BY L1.model
23.
SELECT B.* FROM 
(SELECT DISTINCT type FROM product) A
CROSS APPLY 
(SELECT TOP 3 * FROM product A1 WHERE  A.type=A1.type ORDER BY A1.model) B
24.
SELECT code, name, value 
FROM Laptop
CROSS APPLY (
VALUES('hd', hd),('ram', ram)
,('screen', screen),('speed', speed)
) A (name, value)

*/
