-- 1. Feladat
SELECT first_name, last_name, hire_date 
FROM hr.employees 
WHERE department_id = 20 
ORDER BY last_name DESC, first_name DESC;

-- 2. Feladat
SELECT * FROM hr.employees ORDER BY salary ASC;
SELECT * FROM hr.employees ORDER BY salary DESC;

-- 3. Feladat (Jövedelem = fizetés + (fizetés * jutalék). Az NVL kezeli, ha a jutalék NULL)
SELECT first_name, last_name, salary, 
       salary + (salary * NVL(commission_pct, 0)) AS jovedelem 
FROM hr.employees 
ORDER BY jovedelem DESC;

-- 4. Feladat
SELECT first_name, last_name, department_id, 
       salary + (salary * NVL(commission_pct, 0)) AS jovedelem, 
       (salary + (salary * NVL(commission_pct, 0))) * 0.2 AS ado 
FROM hr.employees 
ORDER BY ado DESC, first_name ASC;

-- 5. Feladat
SELECT first_name || ' ' || last_name AS "Név", 
       job_id AS "Munkakör azonosító", 
       salary AS "Fizetés" 
FROM hr.employees 
WHERE salary NOT BETWEEN 6000 AND 12000;

-- 6. Feladat
SELECT first_name, last_name, job_id, salary, commission_pct, department_id 
FROM hr.employees 
WHERE salary > 1000 
  AND hire_date BETWEEN TO_DATE('2002-03-01', 'YYYY-MM-DD') AND TO_DATE('2002-09-30', 'YYYY-MM-DD');

-- 7. Feladat
SELECT first_name, last_name, commission_pct, manager_id 
FROM hr.employees 
WHERE commission_pct IS NOT NULL 
ORDER BY manager_id, last_name;

-- 8. Feladat
SELECT employee_id, first_name, last_name, job_id, salary, commission_pct 
FROM hr.employees 
WHERE commission_pct > 0.30;

-- 9. Feladat
SELECT first_name, last_name, job_id, salary, hire_date 
FROM hr.employees 
WHERE TO_CHAR(hire_date, 'YYYY') = '2002' 
ORDER BY hire_date;

-- 10. Feladat
SELECT first_name, last_name, job_id, 
       salary + (salary * NVL(commission_pct, 0)) AS jovedelem 
FROM hr.employees 
WHERE LOWER(first_name || last_name) LIKE '%l%l%' 
  AND (department_id = 30 OR manager_id = 121);

-- 11. Feladat
SELECT first_name, last_name, salary * 12 AS eves_fizetes, department_id 
FROM hr.employees 
WHERE job_id IN ('ST_CLERK', 'SA_MAN') 
ORDER BY department_id;

-- 12. Feladat
SELECT employee_id AS azonosito, hire_date AS belepesi_datum, 
       first_name || ' ' || last_name AS nev, 
       job_id AS foglalkozas_azonosito, 
       NVL(TO_CHAR(commission_pct), 'Nincs jutalék') AS jutalek 
FROM hr.employees;

-- 13. Feladat
SELECT first_name, last_name, job_id 
FROM hr.employees 
WHERE LOWER(job_id) LIKE '%man%' 
ORDER BY job_id, first_name, last_name;

-- 14. Feladat
SELECT first_name, last_name, job_id, 
       salary + (salary * NVL(commission_pct, 0)) AS jovedelem, 
       department_id 
FROM hr.employees 
WHERE (salary + (salary * NVL(commission_pct, 0))) < 2500 
  AND TO_CHAR(hire_date, 'YYYY') IN ('2002', '2003') 
ORDER BY job_id, last_name, first_name;

-- 15. Feladat
SELECT first_name, last_name, salary * 12 AS eves_fizetes, 
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS honapok 
FROM hr.employees 
WHERE hire_date < TO_DATE('2002-05-01', 'YYYY-MM-DD') 
ORDER BY honapok DESC;

-- 16. Feladat (Az INITCAP formázza: Nagybetűvel kezd, utána kisbetű)
SELECT INITCAP(first_name) || ' ' || INITCAP(last_name) AS nev, 
       LENGTH(first_name || last_name) AS nev_hossz 
FROM hr.employees 
WHERE UPPER(job_id) LIKE 'C%' OR UPPER(job_id) LIKE 'M%' 
ORDER BY job_id;

-- 17. Feladat (A 'D' formátum a hét napját adja vissza 1-7 között)
SELECT employee_id, first_name, last_name, 
       salary + (salary * NVL(commission_pct, 0)) AS jovedelem, 
       hire_date, department_id 
FROM hr.employees 
WHERE (salary + (salary * NVL(commission_pct, 0))) BETWEEN 1300 AND 5500 
ORDER BY TO_CHAR(hire_date, 'D'), last_name, first_name;

-- 18. Feladat
SELECT employee_id, first_name, last_name, salary, 
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) AS evek 
FROM hr.employees 
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) >= 15 
ORDER BY evek DESC, employee_id ASC;