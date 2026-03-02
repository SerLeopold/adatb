-- 1. Feladat
SELECT job_id, ROUND(AVG(salary), 2) AS atlagfizetes 
FROM hr.employees 
GROUP BY job_id 
ORDER BY atlagfizetes DESC;

-- 2. Feladat (Azoknak az alkalmazottaknak az átlaga, akik vezetők)
SELECT ROUND(AVG(salary), 0) AS fonok_atlagfizu 
FROM hr.employees 
WHERE employee_id IN (SELECT manager_id FROM hr.employees WHERE manager_id IS NOT NULL);

-- 3. Feladat
SELECT department_id, 
       MAX(salary + (salary * NVL(commission_pct, 0))) AS max_jov, 
       MIN(salary + (salary * NVL(commission_pct, 0))) AS min_jov 
FROM hr.employees 
GROUP BY department_id;

-- 4. Feladat
SELECT department_id 
FROM hr.employees 
GROUP BY department_id 
HAVING COUNT(*) >= 5 
ORDER BY COUNT(*) DESC;

-- 5. Feladat
SELECT NVL(TO_CHAR(manager_id), 'Tulajdonos/Elnök') AS fonok, 
       COUNT(*) AS beosztottak_szama 
FROM hr.employees 
GROUP BY manager_id 
ORDER BY beosztottak_szama DESC;

-- 6. Feladat
SELECT MOD(employee_id, 3) AS azonosito_csoport, 
       AVG(salary + (salary * NVL(commission_pct, 0))) AS atlagjovedelem, 
       COUNT(*) AS dolgozok_szama, 
       MIN(salary) AS min_fizetes 
FROM hr.employees 
GROUP BY MOD(employee_id, 3);

-- 7. Feladat
SELECT job_id, 
       ROUND(AVG(salary + (salary * NVL(commission_pct, 0))), 0) AS atlag_jov 
FROM hr.employees 
GROUP BY job_id 
HAVING AVG(salary + (salary * NVL(commission_pct, 0))) > 2000 
ORDER BY job_id;

-- 8. Feladat
SELECT department_id 
FROM hr.employees 
GROUP BY department_id 
HAVING AVG(salary) > 1500 
ORDER BY AVG(salary) DESC;

-- 9. Feladat
SELECT job_id, MAX(salary + (salary * NVL(commission_pct, 0))) AS max_jov 
FROM hr.employees 
GROUP BY job_id 
ORDER BY max_jov;

-- 10. Feladat
SELECT job_id, COUNT(*) AS letszam 
FROM hr.employees 
GROUP BY job_id 
ORDER BY letszam;

-- 11. Feladat
SELECT manager_id, COUNT(*) AS beosztottak 
FROM hr.employees 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id 
ORDER BY beosztottak;

-- 12. Feladat
SELECT job_id, AVG(salary + (salary * NVL(commission_pct, 0))) AS atlag_jov 
FROM hr.employees 
WHERE LOWER(job_id) LIKE '%man%' 
GROUP BY job_id 
ORDER BY atlag_jov DESC;

-- 13. Feladat
SELECT job_id, AVG(salary) AS atlagfizetes 
FROM hr.employees 
GROUP BY job_id 
HAVING COUNT(*) >= 2 
ORDER BY atlagfizetes;

-- 14. Feladat
SELECT department_id, COUNT(*) AS dolgozo_szam, 
       MAX(salary + (salary * NVL(commission_pct, 0))) AS max_jov, 
       MIN(salary + (salary * NVL(commission_pct, 0))) AS min_jov 
FROM hr.employees 
WHERE MOD(department_id, 2) = 0 
GROUP BY department_id 
ORDER BY department_id;

-- 15. Feladat (Mivel csoportosítást kér dolgozók kilistázásával, trükkös. Ha listázzuk a neveket is, azokat is bele kell tenni a GROUP BY-ba a standard SQL szerint).
SELECT MOD(employee_id, 2) AS paritas, first_name, last_name 
FROM hr.employees 
WHERE EXTRACT(YEAR FROM hire_date) <= 1981 
GROUP BY MOD(employee_id, 2), first_name, last_name 
ORDER BY paritas, last_name, first_name;

-- 16. Feladat
SELECT AVG(NVL(commission_pct, 0)) AS atlag_jutalek FROM hr.employees;

-- 17. Feladat
SELECT MOD(employee_id, 2) AS paritas, COUNT(*) AS dolgozok_szama 
FROM hr.employees 
GROUP BY MOD(employee_id, 2);

-- 18. Feladat (CASE használata a saját kategóriákhoz)
SELECT CASE 
         WHEN salary < 5000 THEN 'Alacsony'
         WHEN salary BETWEEN 5000 AND 10000 THEN 'Közepes'
         ELSE 'Magas' 
       END AS fizetesi_kategoria, 
       COUNT(*) AS letszam 
FROM hr.employees 
GROUP BY CASE 
           WHEN salary < 5000 THEN 'Alacsony'
           WHEN salary BETWEEN 5000 AND 10000 THEN 'Közepes'
           ELSE 'Magas' 
         END;

-- 19. Feladat
SELECT manager_id, MIN(salary) AS min_fizu 
FROM hr.employees 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id 
HAVING MIN(salary) <= 2000 
ORDER BY min_fizu ASC;

-- 20. Feladat
SELECT manager_id, AVG(salary) AS atlag_fizu 
FROM hr.employees 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id 
HAVING AVG(salary) <= 3000 
ORDER BY atlag_fizu DESC;

-- 21. Feladat
SELECT manager_id, MAX(salary + (salary * commission_pct)) AS max_jov 
FROM hr.employees 
WHERE commission_pct IS NOT NULL AND manager_id IS NOT NULL
GROUP BY manager_id 
HAVING MAX(salary + (salary * commission_pct)) <= 3500 
ORDER BY max_jov DESC;

-- 22. Feladat
SELECT department_id, ROUND(AVG(salary), 1) AS atlag_fizu 
FROM hr.employees 
WHERE hire_date >= TO_DATE('1981-01-01', 'YYYY-MM-DD') 
GROUP BY department_id 
HAVING MIN(salary) >= 1000 
ORDER BY atlag_fizu ASC;

-- 23. Feladat (Az LPAD/RPAD függvény kiváló kis "grafikák" rajzolására terminálban)
SELECT job_id, COUNT(*) AS letszam, ROUND(AVG(salary), 0) AS atlag_fizu, 
       RPAD('*', ROUND(AVG(salary) / 200), '*') AS grafika 
FROM hr.employees 
GROUP BY job_id 
ORDER BY atlag_fizu DESC;

-- 24. Feladat
SELECT manager_id, 
       MAX(TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12)) AS evek, 
       RPAD('#', MAX(TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date) / 12)) / 5, '#') AS grafika 
FROM hr.employees 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id 
ORDER BY evek ASC;