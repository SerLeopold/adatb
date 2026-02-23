SELECT 
    *  
FROM hr.employees;

SELECT 
    first_name FN,
    last_name "L N",
    email AS mail,
    salary AS "Nettó Fizetés",
    commission_pct jutalék
FROM hr.employees;

SELECT 
    first_name || ' ' ||last_name "Név",
    email AS mail,
    salary AS "Nettó Fizetés",
    commission_pct jutalék
FROM hr.employees;


SELECT 
    first_name || ' ' ||last_name "Név",
    email AS mail,
    salary AS "Nettó Fizetés",
    salary*commission_pct jutalék,
    salary*(1+commission_pct)ber,
    1200*15
FROM hr.employees;


SELECT 
    department_id ,
    first_name || ' ' ||last_name "Név",
    email AS mail,
    salary AS "Nettó Fizetés",
    salary*commission_pct jutalék,
    salary*(1+commission_pct)ber
   -- 1200*15
FROM hr.employees
WHERE salary*commission_pct IS  NULL AND department_id > 80
        ;
        
        
SELECT 
    department_id ,
    first_name || ' ' ||last_name "Név",
    email AS mail,
    salary AS "Nettó Fizetés",
    salary*commission_pct jutalék,
    salary*(1+commission_pct)ber
   -- 1200*15
FROM hr.employees
WHERE salary*commission_pct IS NOT  NULL
ORDER BY "Nettó Fizetés", jutalék DESC  ;


SELECT 
    department_id ,
    first_name || ' ' ||last_name "Név",
    email AS mail,
    salary AS "Nettó Fizetés",
    salary*commission_pct jutalék,
    salary*(1+commission_pct)ber
   -- 1200*15
FROM hr.employees
WHERE salary*commission_pct IS NOT  NULL
ORDER BY salary, jutalék DESC ;