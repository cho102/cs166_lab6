SELECT P.PNAME, S.SNAME, P.COLOR, C.COST 
FROM CATALOG C
JOIN PARTS p
ON C.PID=P.PID
JOIN SUPPLIERS S 
ON S.SID=C.SID;


/*Find the total number of parts supplied by each supplier.*/
SELECT C.SID, COUNT(C.PID)
FROM catalog C
GROUP BY C.SID;

/*Find the total number of parts supplied by each supplier who supplies at least 3 parts.*/
SELECT C.SID, COUNT(C.PID)
FROM catalog C
GROUP BY C.SID
HAVING COUNT(C.PID)>=3;

/*For every supplier that supplies only green parts, print the name of the supplier and the total number of parts that he supples.*/

SELECT DISTINCT S.sname, COUNT(C.PID)
FROM catalog C, suppliers S, PARTS P
WHERE C.sid=S.sid AND NOT EXISTS 
	(SELECT * 
	FROM catalog C1, parts P1 
	WHERE C1.sid=C.sid AND  C1.pid=P1.pid AND P1.color!='Green')
	AND EXISTS
	(SELECT *
        FROM catalog C1, parts P1
        WHERE C1.sid=C.sid AND  C1.pid=P1.pid AND P1.color='Green')
GROUP BY S.sid;

/*For every supplier that supplies green part and red part, print the name of the supplier and the price of the most expensive part that he supplies.*/

SELECT S.sname, Max(C.cost)
FROM suppliers S, catalog C, 	(SELECT C1.sid
				FROM catalog C1, parts P1
				WHERE P1.PID=C1.PID AND P1.color='Green'
				INTERSECT
				SELECT C2.sid
				FROM catalog C2, parts P2
				WHERE P2.PID=C2.PID AND P2.color='Red') AS temp
WHERE temp.sid=C.sid AND S.sid=C.sid
GROUP BY S.sid;




