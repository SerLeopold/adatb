SELECT 
    CONCAT(CONCAT(last_name,' '),first_name) név,
    salary fizu,
    TRUNC(salary/1000) "1000",
    TRUNC(MOD(salary,1000)/500) "500",
    TRUNC(MOD(MOD(salary,1000),500)/200) "200",
    TRUNC(MOD(MOD(MOD(salary,1000),500),200)/100) "100",
    MOD(MOD(MOD(MOD(salary,1000),500),200),100) "apró"    
FROM hr.employees;
