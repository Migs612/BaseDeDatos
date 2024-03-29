use jardineria; use laliga;
-- 1.4.5 Consultas multitabla (Composición interna) --
-- Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN. --
-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
select * from cliente; select * from empleado; select * from pedido; select * from pago; select * from oficina;

SELECT CONCAT(C.NOMBRE_CONTACTO," ",C.APELLIDO_CONTACTO) CLIENTE,
CONCAT(E.NOMBRE," ",E.APELLIDO1," ",E.APELLIDO2) REPRESENTANTE_DE_VENTAS,
C.CODIGO_EMPLEADO_REP_VENTAS AS CODIGO_EMPLEADO
FROM CLIENTE C INNER JOIN EMPLEADO E ON C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO
ORDER BY CODIGO_EMPLEADO;

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT
	P.ID_TRANSACCION,
	CONCAT(C.NOMBRE_CONTACTO," ",C.APELLIDO_CONTACTO) CLIENTE,
	CONCAT(E.NOMBRE," ",E.APELLIDO1," ",E.APELLIDO2) REPRESENTANTE_DE_VENTAS
FROM CLIENTE C 
INNER JOIN EMPLEADO E ON C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO
INNER JOIN PAGO P ON P.CODIGO_CLIENTE = C.CODIGO_CLIENTE
ORDER BY P.ID_TRANSACCION;

-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.

SELECT
    CONCAT(C.NOMBRE_CONTACTO," ",C.APELLIDO_CONTACTO) CLIENTE,
    CONCAT(E.NOMBRE, ' ', E.APELLIDO1, ' ', E.APELLIDO2) REPRESENTANTE_DE_VENTAS
FROM CLIENTE C 
INNER JOIN EMPLEADO E ON C.CODIGO_EMPLEADO_REP_VENTAS = E.CODIGO_EMPLEADO
LEFT JOIN PAGO P ON P.CODIGO_CLIENTE = C.CODIGO_CLIENTE
WHERE P.ID_TRANSACCION IS NULL OR P.CODIGO_CLIENTE IS NULL;


-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
SELECT *
FROM CLIENTE C INNER JOIN EMPLEADO B
ON C.CODIGO_EMPLEADO_REP_VENTAS=B.CODIGO_EMPLEADO
INNER JOIN OFICINA C ON B.CODIGO_OFICINA=C.CODIGO_OFICINA;

SELECT 
CONCAT(C.NOMBRE_CONTACTO," ",C.APELLIDO_CONTACTO) CLIENTE,
CONCAT(E.NOMBRE, ' ', E.APELLIDO1, ' ', E.APELLIDO2) REPRESENTANTE_DE_VENTAS, O.CIUDAD "CIUDAD REPRESENTANTE"
FROM CLIENTE C, EMPLEADO E,OFICINA O
WHERE C.CODIGO_EMPLEADO_REP_VENTAS=E.CODIGO_EMPLEADO AND
E.CODIGO_OFICINA=O.CODIGO_OFICINA;

-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.

SELECT T.APELLIDO1,J.APELLIDO1
FROM EMPLEADO T, EMPLEADO J
WHERE T.CODIGO_JEFE=J.CODIGO_EMPLEADO;

-- 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.


-- 10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
-- 11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.

SELECT DEPTNO,COUNT(*) NE,SUM(SAL) TOTAL, AVG(SAL) MEDIA
FROM EMP
WHERE DEPTNO IS NOT NULL
GROUP BY DEPTNO
HAVING COUNT(*)>=5;

SELECT DEPTNO,JOB,COUNT(*) NE,SUM(SAL) TOTAL,AVG(SAL) MEDIA
FROM EMP
WHERE DEPTNO IS NOT NULL
GROUP BY DEPTNO,JOB
ORDER BY 1,2;

SELECT *
FROM EMP A INNER JOIN DEPT B ON A.DEPTNO=B.DEPTNO;

SELECT *
FROM EMP A,DEPT B
WHERE A.DEPTNO=B.DEPTNO;

SELECT A.DEPTNO,MIN(B.DNAME) NOMBRE_DEPARTAMENTO,
COUNT(*) NE, SUM(SAL) TOTAL, AVG(SAL)MEDIA
FROM EMP A,DEPT B
WHERE A.DEPTNO=B.DEPTNO
GROUP BY A.DEPTNO;


-- 1.4.6 Consultas multitabla (Composición externa)
-- Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL LEFT JOIN y NATURAL RIGHT JOIN.
-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.
-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.
-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.
-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.
-- 6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos de la oficina donde trabajan.
-- 7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.
-- 8. Devuelve un listado de los productos que nunca han aparecido en un pedido.
-- 9. Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, la descripción y la imagen del producto.
-- 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.
-- 11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
-- 12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

SELECT Q.EQUIPO,Z.NOMBRE, TOTAL
FROM (SELECT EQUIPO, SUM(PTOS) TOTAL
		FROM (SELECT IDJORNADA,IDLOCAL EQUIPO, CASE
			WHEN GOL_LOCAL>GOL_VISITANTE THEN 3
			WHEN GOL_LOCAL<GOL_VISITANTE THEN 0
			WHEN GOL_LOCAL=GOL_VISITANTE THEN 1
		END AS PTOS
		FROM PARTIDOS A
		UNION
		SELECT IDJORNADA, IDVISITANTE EQUIPO,
		CASE
			WHEN GOL_LOCAL>GOL_VISITANTE THEN 0
			WHEN GOL_LOCAL<GOL_VISITANTE THEN 3
			WHEN GOL_LOCAL=GOL_VISITANTE THEN 1
		END AS PTOS
		FROM PARTIDOS A ) T
	GROUP BY EQUIPO) Q, EQUIPOS Z
    WHERE Q.EQUIPO=Z.IDEQUIPO;
