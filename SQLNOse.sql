
SELECT *
FROM DEPT A WHERE DEPTNO NOT IN (SELECT DEPTNO FROM  EMP WHERE DEPTNO IS NOT NULL);
use bd_scott;
-- Insertar un nuevo departamento de recursos humanos que estara en ciudad real, donde el numero de departamento sera el siguiente al maximo del que hay en la tabla de departamentos
select * from dept;

INSERT INTO DEPT
SELECT MAX(DEPTNO)+1,'CENTRO','CIUDAD REAL' FROM DEPT;

-- INsertar un empleado cuyo num empleado sea el siguiente al maximo, incluir departmaneto de ventas, manager, salario min manager
select * from emp;


UPDATE EMP 
SET SAL = (SELECT MIN_SAL FROM (SELECT MIN(SAL) AS MIN_SAL FROM EMP WHERE JOB LIKE 'MANAGER') AS TEMP) 
WHERE ENAME = 'Jose Manuel';

INSERT INTO EMP
SELECT MAX(EMPNO)+1,'Jose Manuel','Manager',null,MIN(SAL), null, null, null from EMP;

-- Subir 30% a todos los que tienen el sueldo minimo

UPDATE EMP SET SAL = SAL + (SAL * 0.3) WHERE SAL = (SELECT MIN(SAL) FROM EMP);

UPDATE EMP 
SET SAL = SAL + (SAL * 0.3)
WHERE SAL = (
    SELECT min_sal
    FROM (
        SELECT MIN(SAL) as min_sal
        FROM EMP
    ) AS min_salary
);