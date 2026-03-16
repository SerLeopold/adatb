-- 2. Egytáblás csoportosító lekérdezések

	-- 1. Feladat
	-- Listázza  munkakörönként  az  átlagfizetéseket  két  tizedesre  kerekítve.  Rendezze 
	-- átlagfizetések szerint csökkenõen. 
	SELECT job_id, ROUND(AVG(salary), 2) AS atlagfizetes 
	FROM employees 
	GROUP BY job_id 
	ORDER BY atlagfizetes DESC;
	
	-- 2. Feladat
	-- Listázza csökkenõen rendezve a fõnökök átlagfizetését egész értékre kerekítve.  
	-- (Fõnök az a dolgozó, akinek azonosítója szerepel az mgr oszlopban.) 
	SELECT manager_id, ROUND(AVG(salary), 0) AS atlagfizetes 
	FROM employees 
	WHERE manager_id IS NOT NULL 
	GROUP BY manager_id 
	ORDER BY atlagfizetes DESC;
	
	-- 3. Feladat
	-- Listázza részlegenként a legnagyobb és legkisebb havi jövedelmeket. 
	SELECT department_id, MAX(salary) AS max_jovedelem, MIN(salary) AS min_jovedelem 
	FROM employees 
	GROUP BY department_id;
	
	-- 4. Feladat
	-- Listázza a legalább 5 főt foglakoztató részlegeket a dolgozószám szerint csökkenõen rendezve. 
	SELECT department_id, COUNT(*) AS dolgozok_szama 
	FROM employees 
	GROUP BY department_id 
	HAVING COUNT(*) >= 5 
	ORDER BY dolgozok_szama DESC;
	
	-- 5. Feladat
	-- Listázza  ki  a  fõnökök  azonosítóit,  valamint  azt,  hogy  hány  beosztottjuk  van. Rendezze  a 
	-- listát  a  beosztottak  száma  szerint  csökkenõen. Akinek  nincs  fõnöke,  oda  írjon  valamilyen 
	-- megjegyzést ( tulajdonos vagy elnök stb.). 
	SELECT NVL(TO_CHAR(manager_id), 'Nincs főnöke') AS fonok, COUNT(*) AS beosztottak 
	FROM employees 
	GROUP BY manager_id 
	ORDER BY beosztottak DESC;
	
	-- 6. Feladat
	-- Listázza  az  azonosítójuk hárommal való oszthatósága  alapján  a dolgozók  átlagjövedelmét, 
	-- dolgozók számát, és legkisebb fizetését. 
	SELECT MOD(employee_id, 3) AS oszthatosag, AVG(salary) AS atlag, COUNT(*) AS db, MIN(salary) AS min_fizetes 
	FROM employees 
	GROUP BY MOD(employee_id, 3);
	
	-- 7. Feladat
	-- Listázza a 2000 USD-nál nagyobb átlagjövedelmeket egész értékre kerekítve a foglalkozás 
	-- szerint csoportosítva. A lista a foglalkozás szerint legyen rendezett. 
	SELECT job_id, ROUND(AVG(salary), 0) AS atlag 
	FROM employees 
	GROUP BY job_id 
	HAVING AVG(salary) > 2000 
	ORDER BY job_id;
	
	-- 8. Feladat
	-- Listázza  azokat  a  részlegeket,  ahol  a  fizetésátlag  nagyobb  1500  USD-nál.  Rendezze 
	-- fizetésátlag szerint csökkenõen. 
	SELECT department_id, AVG(salary) AS atlag 
	FROM employees 
	GROUP BY department_id 
	HAVING AVG(salary) > 1500 
	ORDER BY atlag DESC;
	
	-- 9. Feladat
	-- Listázza foglalkozásonként a legnagyobb jövedelmeket, jövedelem szerint rendezve. 
	SELECT job_id, MAX(salary + (salary * NVL(commission_pct, 0))) AS max_jovedelem 
	FROM employees 
	GROUP BY job_id 
	ORDER BY max_jovedelem;
	
	-- 10. Feladat
	-- Listázza  ki,  hogy  az  egyes  foglalkozási  csoportokon  belül  hányan  dolgoznak.  A  lista  a 
	-- létszám szerint legyen rendezett. 
	SELECT job_id, COUNT(*) AS letszam 
	FROM employees 
	GROUP BY job_id 
	ORDER BY letszam;
	
	-- 11. Feladat
	-- Listázza ki a fõnökök azonosítóit és a fõnökökhöz tartozó beosztottak számát, ez utóbbi adat 
	-- szerint rendezve. 
	SELECT manager_id, COUNT(*) AS beosztottak 
	FROM employees 
	WHERE manager_id IS NOT NULL 
	GROUP BY manager_id 
	ORDER BY beosztottak;
	
	-- 12. Feladat
	-- Listázza  azon  foglalkozások  átlagjövedelmét,  amelyek  nevében  a  man  alsztring 
	-- megtalálható. A listát rendezze az átlagjövedelem szerint csökkenõ sorrendben.  
	SELECT job_id, AVG(salary + (salary * NVL(commission_pct, 0))) AS atlag 
	FROM employees 
	WHERE LOWER(job_id) LIKE '%man%' 
	GROUP BY job_id 
	ORDER BY atlag DESC;
    
	-- 13. Feladat
	-- Listázza  rendezve  azon  foglalkozási  csoportok  átlagfizetését,  ahol  kettõ,  vagy  ennél  több 
	-- alkalmazott dolgozik. 
	SELECT job_id, AVG(salary) AS atlag 
	FROM employees 
	GROUP BY job_id 
	HAVING COUNT(*) >= 2 
	ORDER BY atlag;
    
	-- 14. Feladat
	-- Írjon  utasítást  azon  részlegek  azonosítójának,  dolgozói  számának  és  azok  legnagyobb  és 
	-- legkisebb jövedelmének lekérdezésére, ahol a részlegszám páros. A lista a részleg azonosító 
	-- szerint legyen rendezve. 
	SELECT department_id, COUNT(*) AS db, MAX(salary) AS max_f, MIN(salary) AS min_f 
	FROM employees 
	WHERE MOD(department_id, 2) = 0 
	GROUP BY department_id 
	ORDER BY department_id;
	
	-- 15. Feladat
	-- Listázza  ki  az  azonosító  paritása  szerint  csoportosítva  a  dolgozókat.  Hagyja  ki  azon 
	-- dolgozókat, akik 1981 után léptek be a vállalathoz. Rendezze elsõdlegesen paritás szerint, 
	-- másodlagosan a dolgozó neve szerint. 
	SELECT employee_id, last_name, MOD(employee_id, 2) AS paritas 
	FROM employees 
	WHERE TO_CHAR(hire_date, 'YYYY') <= '1981' 
	ORDER BY paritas, last_name;
	
	-- 16. Feladat
	-- Számítsa ki az átlagos jutalékot. 
	SELECT AVG(commission_pct) AS atlag_jutalek FROM employees;
	
	-- 17. Feladat
	-- Készítsen listát a páros és páratlan azonosítójú dolgozók számáról. 
	SELECT MOD(employee_id, 2) AS paritas, COUNT(*) AS db 
	FROM employees 
	GROUP BY MOD(employee_id, 2);

	-- 18. Feladat
	-- Listázza  fizetési  kategóriák  szerint  a  dolgozók  számát.  (A  fizetési  kategóriákat  vagy  Ön 
	-- definiálja, vagy vegye a salgrade táblából.)
	SELECT TRUNC(salary/5000) AS kategoria, COUNT(*) AS db 
	FROM employees 
	GROUP BY TRUNC(salary/5000) 
	ORDER BY kategoria;
    
	-- 19. Feladat
	-- Listázza  fõnökönként  (mgr)  a  fõnökhöz  tartozó  legkisebb dolgozói  fizetéseket. Hagyja ki 
	-- azon  dolgozók  fizetését,  akiknek  nincs  fõnökük,  valamint  azokat  a  csoportokat,  ahol  a 
	-- legkisebb  fizetés  nagyobb 2000 USD-nál. Rendezze  a  listát  a  legkisebb  fizetések  szerint 
	-- növekvõen. 
	SELECT manager_id, MIN(salary) AS min_fiz 
	FROM employees 
	WHERE manager_id IS NOT NULL 
	GROUP BY manager_id 
	HAVING MIN(salary) <= 2000 
	ORDER BY min_fiz ASC;
	
	-- 20. Feladat
	-- Listázza  fõnökönként  (mgr)  a  fõnökhöz  tartozó dolgozói  átlagfizetéseket. Hagyja ki  azon 
	-- dolgozók  fizetését,  akiknek  nincs  fõnökük,  valamint  azokat  a  csoportokat,  ahol  az 
	-- átlagfizetés nagyobb 3000 USD-nál. Rendezze a listát az átlagfizetések szerint csökkenõen. 
	SELECT manager_id, AVG(salary) AS atlag 
	FROM employees 
	WHERE manager_id IS NOT NULL 
	GROUP BY manager_id 
	HAVING AVG(salary) <= 3000 
	ORDER BY atlag DESC;
	
	-- 21. Feladat
	-- Listázza fõnökönként a fõnökhöz tartozó dolgozók jövedelme közül a legnagyobbat. Hagyja 
	-- ki  a  listakészítésbõl  azon  dolgozókat,  akiknek  nincs  jutalékuk,  valamint  azokat  a 
	-- (legnagyobb)  jövedelemeket,  melyek  nagyobbak  3500  USD-nál.  Rendezze  a  listát  a 
	-- legnagyobb jövedelem szerint csökkenõen. 
	SELECT manager_id, MAX(salary + (salary * NVL(commission_pct, 0))) AS max_jov 
	FROM employees 
	WHERE commission_pct IS NOT NULL AND manager_id IS NOT NULL 
	GROUP BY manager_id 
	HAVING MAX(salary + (salary * NVL(commission_pct, 0))) <= 3500 
	ORDER BY max_jov DESC;
	
	-- 22. Feladat
	-- Listázza  részlegenként  az  egy  tizedesre  kerekített  átlagfizetéseket.  Hagyja  ki  az  átlag 
	-- meghatározásból  az  1981.  január. 1-e  elõtt  belépett  dolgozókat,  valamint  azon 
	-- részlegek átlagfizetését, melyekben a  legkisebb  fizetés kisebb 1000 USD-nál. Rendezze a 
	-- listát az átlagfizetések szerint növekvõen. 
	SELECT department_id, ROUND(AVG(salary), 1) AS atlag 
	FROM employees 
	WHERE hire_date >= TO_DATE('1981-01-01', 'YYYY-MM-DD') 
	GROUP BY department_id 
	HAVING MIN(salary) >= 1000 
	ORDER BY atlag ASC;
	
	-- 23. Feladat
	-- Listázza munkakörönként a dolgozók számát és az egész értékre kerekített átlagfizetésüket 
	-- numerikusan és grafikusan  is. Ez utóbbit csillag  (*) karakterek  sorozataként balra  igazítva 
	-- jelenítse meg  olymódon,  hogy  e  sorozatban 200 USD-onként  egy  csillag  karakter  álljon. 
	-- Rendezze a listát az átlagfizetések szerint csökkenõen. 
	SELECT job_id, COUNT(*) AS db, ROUND(AVG(salary), 0) AS atlag, 
	       RPAD('*', TRUNC(ROUND(AVG(salary), 0) / 200), '*') AS grafika 
	FROM employees 
	GROUP BY job_id 
	ORDER BY atlag DESC;
	
	-- 24. Feladat
	-- Listázza  fõnökönként  a  legrégebb  óta  munkaviszonyban  álló  dolgozóknak  a  mai  napig 
	-- munkában töltött éveinek számát numerikusan és grafikusan is. Ez utóbbit kettõskereszt (#) 
	-- karakterek  sorozataként  balra  igazítva  jelenítse  meg  olymódon,  hogy  e  sorozatban  5 
	-- évenként  egy  kettõskereszt  karakter  álljon.  Rendezze  a  listát  az  évek  száma  szerint 
	-- növekvõen. 
	SELECT manager_id, 
	       TRUNC(MAX(MONTHS_BETWEEN(SYSDATE, hire_date) / 12)) AS max_evek, 
	       RPAD('#', TRUNC(MAX(MONTHS_BETWEEN(SYSDATE, hire_date) / 12) / 5), '#') AS grafika 
	FROM employees 
	WHERE manager_id IS NOT NULL 
	GROUP BY manager_id 
	ORDER BY max_evek ASC;
