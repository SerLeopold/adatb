-- 1.
SELECT job_id, ROUND(AVG(salary), 2) atlagfizu
FROM hr.employees
GROUP BY job_id
ORDER BY atlagfizu DESC;

-- 2.
SELECT ROUND(AVG(salary)) atlag
FROM hr.employees
WHERE employee_id IN (SELECT manager_id FROM hr.employees)
ORDER BY atlag DESC;

-- 3.
SELECT department_id, MAX(salary*(1+NVL(commission_pct,0))) max_jov, MIN(salary*(1+NVL(commission_pct,0))) min_jov
FROM hr.employees
GROUP BY department_id;

-- 4.
SELECT department_id
FROM hr.employees
GROUP BY department_id
HAVING COUNT(*) >= 5
ORDER BY COUNT(*) DESC;

-- 5.
SELECT NVL(TO_CHAR(manager_id), 'tulajdonos vagy elnok') fonok, COUNT(*) beosztottak
FROM hr.employees
GROUP BY manager_id
ORDER BY beosztottak DESC;

-- 6.
SELECT MOD(employee_id, 3) maradek, AVG(salary*(1+NVL(commission_pct,0))) atlagjov, COUNT(*), MIN(salary)
FROM hr.employees
GROUP BY MOD(employee_id, 3);

-- 7.
SELECT job_id, ROUND(AVG(salary*(1+NVL(commission_pct,0)))) atlagjov
FROM hr.employees
GROUP BY job_id
HAVING AVG(salary*(1+NVL(commission_pct,0))) > 2000
ORDER BY job_id;

-- 8.
SELECT department_id
FROM hr.employees
GROUP BY department_id
HAVING AVG(salary) > 1500
ORDER BY AVG(salary) DESC;

-- 9.
SELECT job_id, MAX(salary*(1+NVL(commission_pct,0))) maxjov
FROM hr.employees
GROUP BY job_id
ORDER BY maxjov;

-- 10.
SELECT job_id, COUNT(*)
FROM hr.employees
GROUP BY job_id
ORDER BY COUNT(*);

-- 11.
SELECT manager_id, COUNT(*)
FROM hr.employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY COUNT(*);

-- 12.
SELECT job_id, AVG(salary*(1+NVL(commission_pct,0))) atlagjov
FROM hr.employees
WHERE LOWER(job_id) LIKE '%man%'
GROUP BY job_id
ORDER BY atlagjov DESC;

-- 13.
SELECT job_id, AVG(salary) atlag
FROM hr.employees
GROUP BY job_id
HAVING COUNT(*) >= 2
ORDER BY atlag;

-- 14.
SELECT department_id, COUNT(*), MAX(salary*(1+NVL(commission_pct,0))), MIN(salary*(1+NVL(commission_pct,0)))
FROM hr.employees
WHERE MOD(department_id, 2) = 0
GROUP BY department_id
ORDER BY department_id;

-- 15. feladat
SELECT MOD(employee_id, 2) paritas, first_name, last_name
FROM hr.employees
WHERE TO_CHAR(hire_date, 'yyyy') <= '1981'
GROUP BY MOD(employee_id, 2), first_name, last_name
ORDER BY paritas, first_name;

-- 16.
SELECT AVG(NVL(commission_pct, 0)) FROM hr.employees;

-- 17.
SELECT MOD(employee_id, 2) paritas, COUNT(*)
FROM hr.employees
GROUP BY MOD(employee_id, 2);

-- 18.
SELECT TRUNC(salary/1000) fizetesi_kategoria, COUNT(*)
FROM hr.employees
GROUP BY TRUNC(salary/1000);

-- 19.
SELECT manager_id, MIN(salary)
FROM hr.employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING MIN(salary) <= 2000
ORDER BY MIN(salary) ASC;

-- 20.
SELECT manager_id, AVG(salary)
FROM hr.employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
HAVING AVG(salary) <= 3000
ORDER BY AVG(salary) DESC;

-- 21.
SELECT manager_id, MAX(salary*(1+NVL(commission_pct,0))) maxjov
FROM hr.employees
WHERE commission_pct IS NOT NULL AND manager_id IS NOT NULL
GROUP BY manager_id
HAVING MAX(salary*(1+NVL(commission_pct,0))) <= 3500
ORDER BY maxjov DESC;

-- 22.
SELECT department_id, ROUND(AVG(salary), 1)
FROM hr.employees
WHERE hire_date >= TO_DATE('1981.01.01', 'yyyy.mm.dd')
GROUP BY department_id
HAVING MIN(salary) >= 1000
ORDER BY ROUND(AVG(salary), 1);

-- 23.
SELECT job_id, COUNT(*), ROUND(AVG(salary)) atlag, RPAD('*', TRUNC(AVG(salary)/200), '*') grafika
FROM hr.employees
GROUP BY job_id
ORDER BY AVG(salary) DESC;

-- 24.
SELECT manager_id, TRUNC(MAX(MONTHS_BETWEEN(SYSDATE, hire_date))/12) evek, RPAD('#', TRUNC(MAX(MONTHS_BETWEEN(SYSDATE, hire_date))/12)/5, '#') grafika
FROM hr.employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id
ORDER BY evek;
