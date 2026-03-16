-- 3. Tbbtbls lekrdezsek,allekrdezsek
	
	-- 3.1. Feladat
	-- Listzza azon dolgozk nevt s rszlegk nevt, akiknek nevben az A bet szerepel. 
	SELECT e.last_name, d.department_name 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	WHERE UPPER(e.last_name) LIKE '%A%';
	
	-- 3.2. Feladat
	-- Listzza  ki  a  Oxford-i  telephely  minden  dolgozjnak  nevt,  munkakr azonostjt,  fizetst  s 
	-- rszlegnek azonostjt. 
	SELECT e.last_name, e.job_id, e.salary, e.department_id 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE UPPER(l.city) = 'OXFORD';

	-- 3.3. Feladat
	-- Listzza ki a clerk munkakr dolgozkat  foglalkoztat  rszlegek azonostjt, nevt  s 
	-- telephelyt. A lista legyen rendezve a rszlegnv szerint. 
	SELECT DISTINCT d.department_id, d.department_name, l.city 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE LOWER(e.job_id) LIKE '%clerk%' 
	ORDER BY d.department_name;
        
	-- 3.4. Feladat
	-- Listzza ki a Oxford-ban s a SOUTHLAKE-ban dolgozk nevt, munkakrt s telephelyt. 
	-- A lista telephely szerint legyen rendezett. 
	SELECT e.last_name, e.job_id, l.city 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE UPPER(l.city) IN ('OXFORD', 'SOUTHLAKE') 
	ORDER BY l.city;

-- Allekrdezsek --- 
    
	-- 3.5. Feladat
	-- Listzza  ki  az  egyes  rszlegek  nevt,  telephelyk  cmt,  dolgozik  tlagfizetst  a 
	-- rszlegnevek szerint rendezve. 
	SELECT d.department_name, l.street_address, AVG(e.salary) AS atlagfizetes 
	FROM departments d 
	JOIN locations l ON d.location_id = l.location_id 
	LEFT JOIN employees e ON d.department_id = e.department_id 
	GROUP BY d.department_name, l.street_address 
	ORDER BY d.department_name;
	  
	-- 3.6. Feladat
	-- Listzza ki a 20-as s a 30-as rszleg legnagyobb fizets dolgozinak azonostjt, nevt, 
	-- foglalkozst, jutalkt s belpsi dtumt. 
	SELECT employee_id, last_name, job_id, commission_pct, hire_date 
	FROM employees 
	WHERE (department_id, salary) IN (
	    SELECT department_id, MAX(salary) 
	    FROM employees 
	    WHERE department_id IN (20, 30) 
	    GROUP BY department_id
	);
	
	-- 3.7. Feladat
	-- Listzza  ki  minden  rszleg  legkisebb  jvedelm  dolgozjnak  azonostjt,  nevt, 
	-- foglalkozst, jutalkt s belpsi dtumt. 
	SELECT employee_id, last_name, job_id, commission_pct, hire_date 
	FROM employees 
	WHERE (department_id, salary + (salary * NVL(commission_pct, 0))) IN (
	    SELECT department_id, MIN(salary + (salary * NVL(commission_pct, 0))) 
	    FROM employees 
	    GROUP BY department_id
	);
    
	-- 3.8. Feladat
	-- Listzza ki azon rszlegek nevt s telephelyt, ahol a dolgozk tlagjvedelme kisebb, mint 
	-- 7500 USD. 
	SELECT d.department_name, l.city 
	FROM departments d 
	JOIN locations l ON d.location_id = l.location_id 
	JOIN employees e ON d.department_id = e.department_id 
	GROUP BY d.department_name, l.city 
	HAVING AVG(e.salary + (e.salary * NVL(e.commission_pct, 0))) < 7500;
                    
    -- 3.9. Feladat
	-- rjon  olyan  lekrdezst,  ami  megadja  az  sszes  jutalkkal  rendelkez  alkalmazott  nevt, 
	-- rszlegnek nevt s helyt. 
	SELECT e.last_name, d.department_name, l.city 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE e.commission_pct IS NOT NULL;
    
	-- 3.10. Feladat
	-- Listzza a dolgozk nevt s azonostjt a fnkk (mgr) nevvel s azonostjval egytt 
	-- gy,  hogy  akinek  nincs  fnke,  annak  a  NULL  rtk  helyre  a  Legfbb 
	-- karaktersorozatot rja. 
	SELECT e.last_name AS dolgozo_neve, e.employee_id AS dolgozo_id, 
	       NVL(m.last_name, 'Legfőbb') AS fonok_neve, m.employee_id AS fonok_id 
	FROM employees e 
	LEFT JOIN employees m ON e.manager_id = m.employee_id;
	
	-- 3.11. Feladat
	-- Listzza ki a NEW YORK telephely minden dolgozjnak nevt, azonostjt, jvedelmt s 
	-- fnknek nevt, telephelyt. 
	SELECT e.last_name, e.employee_id, e.salary + (e.salary * NVL(e.commission_pct, 0)) AS jov, 
	       m.last_name AS fonok_neve, ml.city AS fonok_telephely 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	LEFT JOIN employees m ON e.manager_id = m.employee_id 
	LEFT JOIN departments md ON m.department_id = md.department_id 
	LEFT JOIN locations ml ON md.location_id = ml.location_id 
	WHERE UPPER(l.city) = 'NEW YORK';
	
	-- 3.12. Feladat
	-- Listzza  mindazon  alkalmazott  nevt,  rszlegnek  nevt  s  fizetst,  akiknek  fizetse 
	-- megegyezik valamelyik Dallas-ban dolgoz  alkalmazottval. Legyen  a  lista  fejlce nv, 
	-- rszlegnv, fizets, s a lista legyen a fizets s a rszlegnv szerint rendezett. 
	SELECT e.last_name AS "név", d.department_name AS "részlegnév", e.salary AS "fizetés" 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	WHERE e.salary IN (
	    SELECT emp.salary 
	    FROM employees emp 
	    JOIN departments dep ON emp.department_id = dep.department_id 
	    JOIN locations loc ON dep.location_id = loc.location_id 
	    WHERE UPPER(loc.city) = 'DALLAS'
	) 
	ORDER BY "fizetés", "részlegnév";
	
	-- 3.13. Feladat
	-- Listzza azon dolgozkat, akiknek neve hasonlt egy munkakr nevhez. 
	SELECT e.last_name 
	FROM employees e 
	JOIN jobs j ON UPPER(j.job_title) LIKE '%' || UPPER(e.last_name) || '%';
	
	-- 3.14. Feladat
	-- Listzza  azon  fnkk  azonostjt,  akik nem menedzser  foglalkozsak. A  lista  legyen  a 
	-- fnk azonost (mgr) szerint rendezett. 
	SELECT DISTINCT e.manager_id 
	FROM employees e 
	JOIN employees m ON e.manager_id = m.employee_id 
	WHERE LOWER(m.job_id) NOT LIKE '%man%' AND LOWER(m.job_id) NOT LIKE '%mgr%' 
	ORDER BY e.manager_id;
	
	-- 3.15. Feladat
	-- Hny olyan fnk van, aki nem menedzser foglalkozs? 
	SELECT COUNT(DISTINCT m.employee_id) 
	FROM employees e 
	JOIN employees m ON e.manager_id = m.employee_id 
	WHERE LOWER(m.job_id) NOT LIKE '%man%' AND LOWER(m.job_id) NOT LIKE '%mgr%';
	
	-- 3.16. Feladat
	-- Listzza a fnkeik szerint csoportostva a legkisebb jvedelm dolgozkat. Hagyja ki azon 
	-- dolgozkat,  akiknek  nincs  fnkk,  valamint  azokat  a  csoportokat,  ahol  a  legkisebb 
	-- jvedelem  nagyobb  3000  USD-nl.  Rendezze  a  listt  a  legkisebb  jvedelmek  szerint 
	-- nvekven. 
	SELECT manager_id, MIN(salary + (salary * NVL(commission_pct, 0))) AS min_jov 
	FROM employees 
	WHERE manager_id IS NOT NULL 
	GROUP BY manager_id 
	HAVING MIN(salary + (salary * NVL(commission_pct, 0))) <= 3000 
	ORDER BY min_jov ASC;
	
	-- 3.17. Feladat
	-- Listzza  minden  olyan  dolgoz  azonostjt  s  nevt,  akik  olyan  rszlegen  dolgoznak, 
	-- melyen tallhat nevben T bett tartalmaz dolgoz. Legyen a lista fejlce azonost, nv, 
	-- rszleg helye, s a lista legyen a rszleg helye s a nv szerint rendezett. 
	SELECT e.employee_id AS "azonosító", e.last_name AS "név", l.city AS "részleg helye" 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE e.department_id IN (
	    SELECT department_id FROM employees WHERE UPPER(last_name) LIKE '%T%'
	) 
	ORDER BY "részleg helye", "név";
	
	-- 3.18. Feladat
	-- Listzza  a  fnkeik  (mgr)  szerint  csoportostva  azokat  a  dolgozkat,  akiknek  fizetse  e 
	-- csoportosts  szerint  a  legkisebb,  de  nagyobb  1000  USD-nl.  A  lista  a  fizets  nvekv 
	-- rtke szerint legyen rendezett. Legyen a lista fejlce: fnk kdja, dolgoznv, fizetse. 
	SELECT e.manager_id AS "fõnök kódja", e.last_name AS "dolgozónév", e.salary AS "fizetése" 
	FROM employees e 
	WHERE (e.manager_id, e.salary) IN (
	    SELECT manager_id, MIN(salary) 
	    FROM employees 
	    WHERE manager_id IS NOT NULL 
	    GROUP BY manager_id 
	    HAVING MIN(salary) > 1000
	) 
	ORDER BY "fizetése" ASC;
	
	-- 3.19. Feladat
	-- Listzza  azon  fnkknl  (mgr)  a  legkisebb  s  legnagyobb  fizetseket,  melyeknl  a 
	-- legkisebb  fizetsek  3000  USD-nl  alacsonyabbak.  A  listt  a  legkisebb  fizets  szerint 
	-- rendezze,  a  fejlc  pedig  legyen  Fnk  kdja,  Legkisebb  Fizets  s  Legnagyobb 
	-- Fizets. 
	SELECT manager_id AS "Fõnök kódja", MIN(salary) AS "Legkisebb Fizetés", MAX(salary) AS "Legnagyobb Fizetés" 
	FROM employees 
	WHERE manager_id IS NOT NULL 
	GROUP BY manager_id 
	HAVING MIN(salary) < 3000 
	ORDER BY "Legkisebb Fizetés";
	
	-- 3.20. Feladat
	-- Listzza  a  fizets  szerint  cskkenen  rendezve  az  eladk  (salesman)  s  a  hivatalnokok 
	-- (clerk) fnkeinek nevt s fizetst, a sajt nevt, munkakrt, fizetst, valamint a sajt 
	-- fizets   fnk  fizets arnyukat a  fnk neve  szerint elsdlegesen, a  fizets arny  szerint 
	-- msodlagosan rendezve. 
	SELECT m.last_name AS fonok_neve, m.salary AS fonok_fizetese, 
	       e.last_name AS dolgozo_neve, e.job_id AS munkakor, e.salary AS dolgozo_fizetese, 
	       ROUND(e.salary / m.salary, 2) AS arany 
	FROM employees e 
	JOIN employees m ON e.manager_id = m.employee_id 
	WHERE LOWER(e.job_id) LIKE '%rep%' OR LOWER(e.job_id) LIKE '%clerk%' 
	ORDER BY fonok_neve, arany, dolgozo_fizetese DESC;
	
	-- 3.21. Feladat
	-- Listzza  a  Chicago-i  telephely  fnk  nevt,  azonostjt,  munkakrt,  fizetst, 
	-- beosztottjainak tlagfizetst s annak szrst s variancijt. 
	SELECT m.last_name, m.employee_id, m.job_id, m.salary, 
	       AVG(e.salary) AS beosztott_atlag, 
	       STDDEV(e.salary) AS szoras, 
	       VARIANCE(e.salary) AS variancia 
	FROM employees e 
	JOIN employees m ON e.manager_id = m.employee_id 
	JOIN departments d ON m.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE UPPER(l.city) = 'CHICAGO' 
	GROUP BY m.last_name, m.employee_id, m.job_id, m.salary;
	
	-- 3.22. Feladat
	-- Listzza  a  2000  s  4000  USD  kztti  fizets  fnkk  nevt,  fizetst,  telephelyt  s 
	-- beosztottjainak tlagfizetst a fnk neve szerint rendezve. 
	SELECT m.last_name, m.salary, l.city, AVG(e.salary) AS atlagfizetes 
	FROM employees e 
	JOIN employees m ON e.manager_id = m.employee_id 
	JOIN departments d ON m.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE m.salary BETWEEN 2000 AND 4000 
	GROUP BY m.last_name, m.salary, l.city 
	ORDER BY m.last_name;
	
	-- 3.23. Feladat
	-- Listzza  minden  rszleg  legkisebb  jvedelm  dolgozjnak  azonostjt,  nevt, 
	-- foglalkozst,  rszlegnek  azonostjt,  telephelyt  s munkban  eltlttt  veinek  szmt. 
	-- Legyen a lista a munkban tlttt vek szerint listzva. 
	SELECT e.employee_id, e.last_name, e.job_id, e.department_id, l.city, 
	       TRUNC(MONTHS_BETWEEN(SYSDATE, e.hire_date) / 12) AS evek_szama 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE (e.department_id, e.salary + (e.salary * NVL(e.commission_pct, 0))) IN (
	    SELECT department_id, MIN(salary + (salary * NVL(commission_pct, 0))) 
	    FROM employees 
	    GROUP BY department_id
	) 
	ORDER BY evek_szama;
    	
	-- 3.24. Feladat
	-- Listzza  ki  az  egyes  rszlegek  telephelynek  nevt,  a  rszleg  dolgozinak  egszrtkre 
	-- kerektett  tlagjvedelmt,  valamint  az  itt  dolgozk  fnkeinek  nevt,  fizetst  s 
	-- telephelyt  az  tlagjvedelem  szerint  rendezve,  s  a  rszlegadatokat  ismtlsmentesen 
	-- megjelentve. 
	SELECT DISTINCT l.city, 
	       ROUND(AVG(e.salary + (e.salary * NVL(e.commission_pct, 0))) OVER (PARTITION BY e.department_id), 0) AS atlag, 
	       m.last_name AS fonok_neve, m.salary AS fonok_fizetese, ml.city AS fonok_telephely 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	JOIN employees m ON d.manager_id = m.employee_id 
	JOIN departments md ON m.department_id = md.department_id 
	JOIN locations ml ON md.location_id = ml.location_id 
	ORDER BY atlag;
	
	-- 3.25. Feladat
	-- Listzza ki mindazon dolgozk nevt, foglalkozst, telephelyt, valamint jvedelmk s a 
	-- rszlegk  tlagjvedelme  kzti klnbsget,  akiknl  a munkakrk  tlagjvedelme kisebb 
	-- az sszes dolgoz tlagjvedelmnl. A listt rendezze telephely szerint. 
	SELECT e.last_name, e.job_id, l.city, 
	       (e.salary + (e.salary * NVL(e.commission_pct, 0))) - (
	           SELECT AVG(salary + (salary * NVL(commission_pct, 0))) 
	           FROM employees WHERE department_id = e.department_id
	       ) AS jov_kulonbseg 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE (SELECT AVG(salary + (salary * NVL(commission_pct, 0))) FROM employees WHERE job_id = e.job_id) < 
	      (SELECT AVG(salary + (salary * NVL(commission_pct, 0))) FROM employees) 
	ORDER BY l.city;
	
	-- 3.26. Feladat
	-- Listzza  ki  azon  dolgozk  nevt,  munkakrt,  jvedelmt,  telephelyt,  a  munkakrk 
	-- tlagjvedelmt, akiknek jvedelme a munkakrk tlagjvedelmnl kisebb. A lista legyen 
	-- a dolgozk neve szerint rendezve. 
	SELECT e.last_name, e.job_id, (e.salary + (e.salary * NVL(e.commission_pct, 0))) AS jov, 
	       l.city, 
	       (SELECT AVG(salary + (salary * NVL(commission_pct, 0))) FROM employees WHERE job_id = e.job_id) AS mk_atlag 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE (e.salary + (e.salary * NVL(e.commission_pct, 0))) < 
	      (SELECT AVG(salary + (salary * NVL(commission_pct, 0))) FROM employees WHERE job_id = e.job_id) 
	ORDER BY e.last_name;
	
	-- 3.27. Feladat
	-- Listzza  ki mindazon  dolgozk  nevt,  foglalkozst,  rszlegk  nevt,  valamint  rszlegk 
	-- tlagjvedelme s sajt jvedelmk kzti klnbsget, akiknek a munkakri tlagjvedelme 
	-- kisebb az sszes dolgoz tlagjvedelmnl. A listt rendezze a rszleg neve szerint. 
	SELECT e.last_name, e.job_id, d.department_name, 
	       (SELECT AVG(salary + (salary * NVL(commission_pct, 0))) FROM employees WHERE department_id = e.department_id) - 
	       (e.salary + (e.salary * NVL(e.commission_pct, 0))) AS kulonbseg 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	WHERE (SELECT AVG(salary + (salary * NVL(commission_pct, 0))) FROM employees WHERE job_id = e.job_id) < 
	      (SELECT AVG(salary + (salary * NVL(commission_pct, 0))) FROM employees) 
	ORDER BY d.department_name;
	
	-- 3.28. Feladat
	-- Listzza  ki  minden  dolgoz  nevt,  munkakrt,  rszlegt,  fizetst,  valamint  a  sajt 
	-- telephelyn  a  munkakrnek  tlagfizetst,  s  telephelynek  tlagfizetst.  A  listt 
	-- munkakr s telephely szerint nvekv mdon rendezze. 
	SELECT e.last_name, e.job_id, d.department_name, e.salary, 
	       (SELECT AVG(emp.salary) 
	        FROM employees emp 
	        JOIN departments dep ON emp.department_id = dep.department_id 
	        WHERE dep.location_id = d.location_id AND emp.job_id = e.job_id) AS mk_telephely_atlag, 
	       (SELECT AVG(emp.salary) 
	        FROM employees emp 
	        JOIN departments dep ON emp.department_id = dep.department_id 
	        WHERE dep.location_id = d.location_id) AS telephely_atlag 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	ORDER BY e.job_id, l.city;

	-- 3.29 Feladat
	-- Listzza  ki minden  dolgoz  nevt, munkakrt,  rszlegt,  fizetst,  valamint  fizetst  a 
	-- sajt munkakre tlagfizetsnek szzalkban, s a fizetst a sajt rszlege 
	-- tlagfizetsnek  szzalkban  a  szzalkrtkeket  egszknt  kiratva)  a  munkakr  s  a 
	-- rszleg szerint nvekv mdon rendezve. 
	SELECT e.last_name, e.job_id, d.department_name, e.salary, 
	       ROUND((e.salary / (SELECT AVG(salary) FROM employees WHERE job_id = e.job_id)) * 100, 0) || '%' AS mk_szazalek, 
	       ROUND((e.salary / (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id)) * 100, 0) || '%' AS r_szazalek 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	ORDER BY e.job_id, d.department_name;
    
	-- 3.30. Feladat
	-- Listzza  munkakrnknt  azon  dolgozkat  s  telephelyket,  akiknek  fizetse  tbb  a 
	-- munkakrk tlagfizetsnl.  
	SELECT e.job_id, e.last_name, l.city 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE job_id = e.job_id) 
	ORDER BY e.job_id;
	
	-- 3.31. Feladat
	-- Listzza  a  legkisebb  tlagfizets  rszleg  dolgozit,  a  rszleg  nevt,  tlagfizetst  s 
	-- telephelyt. 
	SELECT e.last_name, d.department_name, 
	       (SELECT AVG(salary) FROM employees WHERE department_id = d.department_id) AS atlagfizetes, 
	       l.city 
	FROM employees e 
	JOIN departments d ON e.department_id = d.department_id 
	JOIN locations l ON d.location_id = l.location_id 
	WHERE d.department_id = (
	    SELECT department_id FROM (
	        SELECT department_id, AVG(salary) AS avg_sal 
	        FROM employees 
	        GROUP BY department_id 
	        ORDER BY avg_sal ASC
	    ) WHERE ROWNUM = 1
	);
    
	-- 3.32. Feladat
	-- Listzza  a  Legnagyobb  ltszm  foglalkozsi  csoport munkakr  dolgozinak  nevt  s  foglalkozst. 
	-- (Termszetesen az elnk munkakr figyelmen kvl hagysval.) 
	SELECT last_name, job_id 
	FROM employees 
	WHERE job_id = (
	    SELECT job_id FROM (
	        SELECT job_id, COUNT(*) 
	        FROM employees 
	        WHERE UPPER(job_id) NOT LIKE '%PRES%' 
	        GROUP BY job_id 
	        ORDER BY COUNT(*) DESC
	    ) WHERE ROWNUM = 1
	);

	-- 3.33. Feladat
	-- Listzza  a  Legkisebb  ltszm  foglalkozsi csoport (munkakr) dolgozinak  nevt  s  foglalkozst. 
	-- (Termszetesen az elnk (president) munkakr figyelmen kvl hagysval.)
	SELECT last_name, job_id 
	FROM employees 
	WHERE job_id = (
	    SELECT job_id FROM (
	        SELECT job_id, COUNT(*) 
	        FROM employees 
	        WHERE UPPER(job_id) NOT LIKE '%PRES%' 
	        GROUP BY job_id 
	        ORDER BY COUNT(*) ASC
	    ) WHERE ROWNUM = 1
	);
