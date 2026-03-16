-- 1 Egyszerû lekérdezések:

	-- 1. Feladat
	-- Listázza ki a 20-as részleg dolgozóinak nevét, belépési idejét a nevek szerint csökkenõen rendezve.
	SELECT last_name, hire_date 
	FROM employees 
	WHERE department_id = 20 
	ORDER BY last_name DESC;
        
	-- 2. Feladat
	-- Készítsen  két  listát, melyek  a  dolgozók  adatait  tartalmazzák. Az  egyiket  a  fizetés  szerint 
	-- növekvõen, a másikat a fizetés szerint csökkenõen rendezze. 
	SELECT * FROM employees ORDER BY salary ASC;
	SELECT * FROM employees ORDER BY salary DESC;
    
	-- 3. Feladat
	-- Listázza  ki  a  dolgozók  nevét,  fizetést,  jövedelmét  a  jövedelmük  szerint  csökkenõen 
	-- rendezve. (A jövedelem a fizetés és a jutalék összege.) 
	SELECT last_name, salary, salary + (salary * NVL(commission_pct, 0)) AS jovedelem 
	FROM employees 
	ORDER BY jovedelem DESC;
	
	-- 4. Feladat
	-- Listázza  ki  a  dolgozók  nevét,  részlegüket,  jövedelmüket,  és  az  adójukat  (a  jövedelmük 
	-- 20%-a), az adójuk szerint csökkenõen, a nevük szerint pedig növekvõ módon rendezve. 
	SELECT last_name, department_id, 
	       salary + (salary * NVL(commission_pct, 0)) AS jovedelem, 
	       (salary + (salary * NVL(commission_pct, 0))) * 0.20 AS ado 
	FROM employees 
	ORDER BY ado DESC, last_name ASC;
	
    -- 5. Feladat
	-- Írassa  ki  azon  alkalmazottak  nevét,  munkakörének azonosítóját  és  fizetését,  akiknek  fizetése  nincs  az 
	-- 6000-12000 USD tartományban. A lista fejléce legyen ”Név”, ”Munkakör azonosító”, ”Fizetés”. . 
	SELECT last_name AS "Név", job_id AS "Munkakör azonosító", salary AS "Fizetés" 
	FROM employees 
	WHERE salary NOT BETWEEN 6000 AND 12000;
       
	-- -- 6. Feladat
	-- Írassa ki azon dolgozók nevét, munkakör-azonosítóját, fizetését, jutalékát és részleg-azonosítóját, akik 
	-- 1000 USD-nál  többet  keresnek,  és  2002.  március  1.  és  szeptember  30.  között 
	-- léptek be a vállalathoz.  
	SELECT last_name, job_id, salary, commission_pct, department_id 
	FROM employees 
	WHERE salary > 1000 
	  AND hire_date BETWEEN TO_DATE('2002-03-01', 'YYYY-MM-DD') AND TO_DATE('2002-09-30', 'YYYY-MM-DD');
           
	-- 7. Feladat
	-- Írassa ki minden jutalékkal rendelkezõ alkalmazott nevét, jutalékát, fõnökének azonosítóját. 
	-- Legyen a lista rendezett a fõnök azonosítója, és az alkalmazottak neve szerint. 
	SELECT last_name, commission_pct, manager_id 
	FROM employees 
	WHERE commission_pct IS NOT NULL 
	ORDER BY manager_id, last_name;
    
	--	-- 8. Feladat
	-- Írassa  ki  azon  alkalmazottak  azonosítóját,  nevét,  foglalkozás azonosítóját,  fizetését  és  jutalékát, 
	-- akiknek jutaléka meghaladja a fizetésük 30%-át. 
	SELECT employee_id, last_name, job_id, salary, commission_pct 
	FROM employees 
	WHERE (salary * commission_pct) > (salary * 0.30);
	
	-- 9. Feladat
	-- Írja  ki  azon  dolgozók  nevét,  foglalkozás azonosítóját.  fizetését  és  belépési  dátumát,  akik  2002-ben 
	-- léptek be a vállalathoz. A lista legyen a belépési dátum szerint rendezve. 
	SELECT last_name, job_id, salary, hire_date 
	FROM employees 
	WHERE TO_CHAR(hire_date, 'YYYY') = '2002' 
	ORDER BY hire_date;
    
	-- 10. Feladat
	-- Listázza  azon  alkalmazottak  nevét,  foglalkozás azonosítóját,  jövedelmét,  akiknek  a  nevében  két  ”L” 
	-- betû  szerepel,  továbbá  vagy  a  30-as  részlegen  dolgozik,  vagy  a  fõnökének  azonosítója 121. 
	SELECT last_name, job_id, salary + (salary * NVL(commission_pct, 0)) AS jovedelem 
	FROM employees 
	WHERE UPPER(last_name) LIKE '%L%L%' 
	  AND (department_id = 30 OR manager_id = 121);

	-- 11. Feladat
	-- Listázza  ki  részlegazonosító  szerint  rendezve  a  "ST_CLERK"  és  a  "SA_MAN"  munkakör azonosítójú 
	-- dolgozók nevét,  éves fizetését és  részlegazonosítóját.
	SELECT last_name, salary * 12 AS eves_fizetes, department_id 
	FROM employees 
	WHERE job_id IN ('ST_CLERK', 'SA_MAN') 
	ORDER BY department_id;
	
	-- 12. Feladat
	-- Listázza ki  az összes dolgozót oly módon, hogy  azoknál,  akik nem kapnak  jutalékot,  az  a 
	-- szöveg jelenjen meg, hogy ”Nincs jutalék”. A lista fejléce legyen azonosító, belépési dátum, 
	-- név, foglalkozás azonosító , jutalék. 
	SELECT employee_id AS azonosito, hire_date AS belepesi_datum, last_name AS nev, job_id AS foglalkozas_azonosito, 
	       NVL(TO_CHAR(commission_pct), 'Nincs jutalék') AS jutalek 
	FROM employees;
	
	-- 13. Feladat
	-- Listázza  ki  a  man  karaktersorozatot  tartalmazó munkakör azonosítójú munkakörben  dolgozók  nevét  és 
	-- munkakör azonosítóját, a munkakör azonosító  és a név szerint rendezve. 
	SELECT last_name, job_id 
	FROM employees 
	WHERE LOWER(job_id) LIKE '%man%' 
	ORDER BY job_id, last_name;
	
	-- 14. Feladat
	-- Listázza foglalkozás szerint csoportosítva azon dolgozók nevét, foglalkozás azonosítóját, jövedelmét és 
	-- részlegének a kódját, akiknek jövedelme kisebb 2500 USD-nál, valamint 2002 és 2003 között léptek be.
    -- A keletkezett  lista  elsõdlegesen  a  foglalkozás,  másodlagosan  a  dolgozó  neve  szerint legyen rendezve. 
	SELECT last_name, job_id, salary + (salary * NVL(commission_pct, 0)) AS jovedelem, department_id 
	FROM employees 
	WHERE (salary + (salary * NVL(commission_pct, 0))) < 2500 
	  AND TO_CHAR(hire_date, 'YYYY') BETWEEN '2002' AND '2003' 
	ORDER BY job_id, last_name;
	
	-- 15. Feladat
	-- Listázza  ki  azoknak  az  alkalmazottaknak  a  nevét,  éves  fizetését  és  a  munkában  eltöltött 
	-- hónapjainak  számát,  akik  2002.05.01.  elõtt  léptek  be  a  vállalathoz.  A  lista  legyen  a 
	-- hónapszámok szerint csökkenõen rendezve. 
	SELECT last_name, salary * 12 AS eves_fizetes, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS honapok_szama 
	FROM employees 
	WHERE hire_date < TO_DATE('2002-05-01', 'YYYY-MM-DD') 
	ORDER BY honapok_szama DESC;
	
	-- 16. Feladat
	-- Listázza  ki  a C  és  az M  betûvel  kezdõdõ  foglalkozás azonosítójú alkalmazottak  nevét  (nevüket  nagy 
	-- betûvel  kezdve  és  kisbetûvel  folytatva),  valamint  nevük  hosszát.  Rendezze  a  listát  a 
	-- foglalkozás azonosító szerint.
	SELECT INITCAP(last_name) AS nev, LENGTH(last_name) AS nev_hossza 
	FROM employees 
	WHERE UPPER(job_id) LIKE 'C%' OR UPPER(job_id) LIKE 'M%' 
	ORDER BY job_id;
	
	-- 17. Feladat
	-- A  belépési  dátum  napjai  szerint  csoportosítva  listázza  azon  dolgozók  azonosítóját,  nevét, 
	-- jövedelmét,  munkába  állásuk  napját,  részlegének azonosítóját,  akiknek  jövedelme  1300  és  5500  USD 
	-- közötti  érték.  A  keletkezett  lista  elsõdlegesen  a  napok  sorszáma  szerint, másodlagosan  a 
	-- dolgozó neve szerint legyen rendezve. A hét elsõ napja legyen a vasárnap. 
	SELECT employee_id, last_name, salary + (salary * NVL(commission_pct, 0)) AS jovedelem, 
	       TO_CHAR(hire_date, 'Day') AS nap, department_id 
	FROM employees 
	WHERE salary + (salary * NVL(commission_pct, 0)) BETWEEN 1300 AND 5500 
	ORDER BY TO_CHAR(hire_date, 'D'), last_name;
	
	-- 18. Feladat
	-- A vállalatnál  hûségjutalmat  adnak,  és  ehhez  szükséges  azon  dolgozók  azonosítója,  neve, 
	-- fizetése, munkában eltöltött éve, akik legalább 15 éve álltak munkába. Rendezze a listát a 
	-- munkában eltöltött évek szerint csökkenõen, valamint az azonosító szerint növekvõen. 
	SELECT employee_id, last_name, salary, TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) AS evek 
	FROM employees 
	WHERE MONTHS_BETWEEN(SYSDATE, hire_date)/12 >= 15 
	ORDER BY evek DESC, employee_id ASC;
