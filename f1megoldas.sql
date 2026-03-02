-- 1. feladat
SELECT first_name, last_name, hire_date FROM hr.employees
WHERE department_id=20
ORDER BY last_name DESC, first_name DESC;

-- 2.
SELECT * FROM hr.employees ORDER BY salary;
SELECT * FROM hr.employees ORDER BY salary DESC;

-- 3.
SELECT first_name, last_name, salary, salary*(1+NVL(commission_pct,0)) jovedelem
FROM hr.employees
ORDER BY jovedelem DESC;

-- 4.
SELECT first_name, department_id, salary*(1+NVL(commission_pct,0)) jovedelem, (salary*(1+NVL(commission_pct,0)))*0.2 ado
FROM hr.employees
ORDER BY ado DESC, first_name ASC;

-- 5.
SELECT first_name||' '||last_name "Név", job_id "Munkakör azonosító", salary "Fizetés"
FROM hr.employees
WHERE salary NOT BETWEEN 6000 AND 12000;

-- 6.
SELECT first_name, last_name, job_id, salary, commission_pct, department_id
FROM hr.employees
WHERE salary>1000 AND hire_date BETWEEN TO_DATE('2002.03.01', 'yyyy.mm.dd') AND TO_DATE('2002.09.30', 'yyyy.mm.dd');

-- 7.
SELECT first_name, last_name, commission_pct, manager_id
FROM hr.employees
WHERE commission_pct IS NOT NULL
ORDER BY manager_id, first_name;

-- 8. feladat
SELECT employee_id, first_name, last_name, job_id, salary, commission_pct
FROM hr.employees
WHERE commission_pct > 0.3;

-- 9.
SELECT first_name, last_name, job_id, salary, hire_date
FROM hr.employees
WHERE TO_CHAR(hire_date, 'YYYY') = '2002'
ORDER BY hire_date;

-- 10.
SELECT first_name, last_name, job_id, salary*(1+NVL(commission_pct,0)) jovedelem
FROM hr.employees
WHERE LOWER(first_name||last_name) LIKE '%l%l%'
AND (department_id=30 OR manager_id=121);

-- 11.
SELECT first_name, last_name, salary*12 eves_fizetes, department_id
FROM hr.employees
WHERE job_id IN ('ST_CLERK', 'SA_MAN')
ORDER BY department_id;

-- 12.
SELECT employee_id azonosito, hire_date belepesi_datum, first_name||' '||last_name nev, job_id foglalkozas_azonosito, NVL(TO_CHAR(commission_pct), 'Nincs jutalék') jutalek
FROM hr.employees;

-- 13.
SELECT first_name, last_name, job_id
FROM hr.employees
WHERE LOWER(job_id) LIKE '%man%'
ORDER BY job_id, first_name;

-- 14.
SELECT first_name, last_name, job_id, salary*(1+NVL(commission_pct,0)) jovedelem, department_id
FROM hr.employees
WHERE salary*(1+NVL(commission_pct,0)) < 2500
AND TO_CHAR(hire_date, 'yyyy') IN ('2002', '2003')
ORDER BY job_id, first_name;

-- 15.
SELECT first_name, last_name, salary*12, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) honapok
FROM hr.employees
WHERE hire_date < TO_DATE('2002-05-01', 'yyyy-mm-dd')
ORDER BY honapok DESC;

-- 16.
SELECT INITCAP(first_name||' '||last_name) nev, LENGTH(first_name||last_name) hossz
FROM hr.employees
WHERE UPPER(job_id) LIKE 'C%' OR UPPER(job_id) LIKE 'M%'
ORDER BY job_id;

-- 17.
SELECT employee_id, first_name, last_name, salary*(1+NVL(commission_pct,0)) jovedelem, hire_date, department_id
FROM hr.employees
WHERE salary*(1+NVL(commission_pct,0)) BETWEEN 1300 AND 5500
ORDER BY TO_CHAR(hire_date, 'D'), first_name;

-- 18.
SELECT employee_id, first_name, last_name, salary, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) eltoltott_ev
FROM hr.employees
WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) >= 15
ORDER BY eltoltott_ev DESC, employee_id ASC;
