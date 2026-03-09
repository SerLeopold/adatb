-- 3.1.
select e.first_name, e.last_name, d.department_name 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
where upper(e.first_name||e.last_name) like '%A%';

-- 3.2.
select e.first_name, e.last_name, e.job_id, e.salary, e.department_id 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join hr.locations l on d.location_id = l.location_id 
where upper(l.city) = 'OXFORD';

-- 3.3.
select distinct d.department_id, d.department_name, l.city 
from hr.departments d 
join hr.locations l on d.location_id = l.location_id 
join hr.employees e on d.department_id = e.department_id 
where upper(e.job_id) like '%CLERK%' 
order by d.department_name;

-- 3.4.
select e.first_name, e.last_name, e.job_id, l.city 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join hr.locations l on d.location_id = l.location_id 
where upper(l.city) in ('OXFORD', 'SOUTHLAKE') 
order by l.city;

-- 3.5.
select d.department_name, l.street_address, l.city, avg(e.salary) atlagfizu
from hr.departments d 
join hr.locations l on d.location_id = l.location_id 
join hr.employees e on d.department_id = e.department_id 
group by d.department_name, l.street_address, l.city 
order by d.department_name;

-- 3.6.
select employee_id, first_name, last_name, job_id, commission_pct, hire_date 
from hr.employees 
where (department_id, salary) in (
    select department_id, max(salary) 
    from hr.employees 
    where department_id in (20, 30) 
    group by department_id
);

-- 3.7.
select employee_id, first_name, last_name, job_id, commission_pct, hire_date 
from hr.employees 
where (department_id, salary*(1+nvl(commission_pct,0))) in (
    select department_id, min(salary*(1+nvl(commission_pct,0))) 
    from hr.employees 
    group by department_id
);

-- 3.8.
select d.department_name, l.city 
from hr.departments d 
join hr.locations l on d.location_id = l.location_id 
join hr.employees e on d.department_id = e.department_id 
group by d.department_name, l.city 
having avg(e.salary*(1+nvl(e.commission_pct,0))) < 7500;

-- 3.9.
select e.first_name, e.last_name, d.department_name, l.city 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join hr.locations l on d.location_id = l.location_id 
where e.commission_pct is not null;

-- 3.10.
select e.first_name, e.last_name, e.employee_id, 
       nvl(m.first_name||' '||m.last_name, 'Legfőbb') fonok_nev, 
       nvl(to_char(m.employee_id), 'Legfőbb') fonok_id 
from hr.employees e 
left join hr.employees m on e.manager_id = m.employee_id;

-- 3.11.
select e.first_name, e.last_name, e.employee_id, e.salary*(1+nvl(e.commission_pct,0)) jovedelem, 
       m.first_name||' '||m.last_name fonok_nev, ml.city fonok_hely 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join hr.locations l on d.location_id = l.location_id 
left join hr.employees m on e.manager_id = m.employee_id 
left join hr.departments md on m.department_id = md.department_id 
left join hr.locations ml on md.location_id = ml.location_id 
where upper(l.city) = 'NEW YORK';

-- 3.12.
select e.first_name, e.last_name, d.department_name, e.salary 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
where e.salary in (
    select e2.salary 
    from hr.employees e2 
    join hr.departments d2 on e2.department_id = d2.department_id 
    join hr.locations l2 on d2.location_id = l2.location_id 
    where upper(l2.city) = 'DALLAS'
)
order by e.salary, d.department_name;

-- 3.13.
select e.first_name, e.last_name 
from hr.employees e 
join hr.jobs j on e.job_id = j.job_id 
where instr(lower(e.first_name||e.last_name), lower(j.job_title)) > 0;

-- 3.14.
select employee_id 
from hr.employees 
where employee_id in (select manager_id from hr.employees) 
and upper(job_id) not like '%MAN%' 
order by employee_id;

-- 3.15.
select count(employee_id) 
from hr.employees 
where employee_id in (select manager_id from hr.employees) 
and upper(job_id) not like '%MAN%';

-- 3.16.
select manager_id, min(salary*(1+nvl(commission_pct,0))) min_jov 
from hr.employees 
where manager_id is not null 
group by manager_id 
having min(salary*(1+nvl(commission_pct,0))) <= 3000 
order by min_jov asc;

-- 3.17.
select e.employee_id, e.first_name, e.last_name nev, l.city 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join hr.locations l on d.location_id = l.location_id 
where e.department_id in (
    select department_id 
    from hr.employees 
    where upper(first_name||last_name) like '%T%'
) 
order by l.city, nev;

-- 3.18.
select manager_id fonok_kodja, first_name||' '||last_name dolgozonev, salary fizetese 
from hr.employees 
where (manager_id, salary) in (
    select manager_id, min(salary) 
    from hr.employees 
    where manager_id is not null 
    group by manager_id
) 
and salary > 1000 
order by fizetese;

-- 3.19.
select manager_id fonok_kodja, min(salary) legkisebb_fizetes, max(salary) legnagyobb_fizetes 
from hr.employees 
where manager_id is not null 
group by manager_id 
having min(salary) < 3000 
order by legkisebb_fizetes;

-- 3.20.
select m.first_name||' '||m.last_name fonok_neve, m.salary fonok_fizetese, 
       e.first_name||' '||e.last_name sajat_nev, e.job_id, e.salary sajat_fizu, 
       round(e.salary/m.salary, 2) arany 
from hr.employees e 
join hr.employees m on e.manager_id = m.employee_id 
where upper(e.job_id) like '%CLERK%' or upper(e.job_id) like '%REP%' 
order by fonok_neve, arany;

-- 3.21.
select m.first_name, m.last_name, m.employee_id, m.job_id, m.salary, 
       avg(e.salary) beosztottak_atlaga, stddev(e.salary) szoras, variance(e.salary) variancia 
from hr.employees e 
join hr.employees m on e.manager_id = m.employee_id 
join hr.departments md on m.department_id = md.department_id 
join hr.locations ml on md.location_id = ml.location_id 
where upper(ml.city) = 'CHICAGO' 
group by m.first_name, m.last_name, m.employee_id, m.job_id, m.salary;

-- 3.22.
select m.first_name, m.last_name, m.salary, ml.city, avg(e.salary) beosztottak_atlaga 
from hr.employees e 
join hr.employees m on e.manager_id = m.employee_id 
left join hr.departments md on m.department_id = md.department_id 
left join hr.locations ml on md.location_id = ml.location_id 
where m.salary between 2000 and 4000 
group by m.first_name, m.last_name, m.salary, ml.city 
order by m.last_name;

-- 3.23.
select e.employee_id, e.first_name, e.last_name, e.job_id, e.department_id, l.city, 
       trunc(months_between(sysdate, e.hire_date)/12) evek 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join hr.locations l on d.location_id = l.location_id 
where (e.department_id, e.salary*(1+nvl(e.commission_pct,0))) in (
    select department_id, min(salary*(1+nvl(commission_pct,0))) 
    from hr.employees 
    group by department_id
) 
order by evek;

-- 3.24.
select distinct l.city, da.atlag_jov, m.first_name, m.last_name, m.salary, ml.city fonok_telephely 
from hr.departments d 
join hr.locations l on d.location_id = l.location_id 
join (
    select department_id, round(avg(salary*(1+nvl(commission_pct,0)))) atlag_jov 
    from hr.employees group by department_id
) da on d.department_id = da.department_id 
left join hr.employees m on d.manager_id = m.employee_id 
left join hr.departments md on m.department_id = md.department_id 
left join hr.locations ml on md.location_id = ml.location_id 
order by da.atlag_jov;

-- 3.25.
select e.first_name, e.last_name, e.job_id, l.city, 
       e.salary*(1+nvl(e.commission_pct,0)) jov, 
       e.salary*(1+nvl(e.commission_pct,0)) - da.atlag jov_kulonbseg 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join hr.locations l on d.location_id = l.location_id 
join (select department_id, avg(salary*(1+nvl(commission_pct,0))) atlag from hr.employees group by department_id) da on e.department_id = da.department_id 
join (select job_id, avg(salary*(1+nvl(commission_pct,0))) jatlag from hr.employees group by job_id) ja on e.job_id = ja.job_id 
where ja.jatlag < (select avg(salary*(1+nvl(commission_pct,0))) from hr.employees) 
order by l.city;

-- 3.26.
select e.first_name, e.last_name, e.job_id, e.salary*(1+nvl(e.commission_pct,0)) jov, l.city, ja.jatlag 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join hr.locations l on d.location_id = l.location_id 
join (select job_id, avg(salary*(1+nvl(commission_pct,0))) jatlag from hr.employees group by job_id) ja on e.job_id = ja.job_id 
where e.salary*(1+nvl(e.commission_pct,0)) < ja.jatlag 
order by e.last_name;

-- 3.27.
select e.first_name, e.last_name, e.job_id, d.department_name, 
       da.atlag - e.salary*(1+nvl(e.commission_pct,0)) kulonbseg 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join (select department_id, avg(salary*(1+nvl(commission_pct,0))) atlag from hr.employees group by department_id) da on e.department_id = da.department_id 
join (select job_id, avg(salary*(1+nvl(commission_pct,0))) jatlag from hr.employees group by job_id) ja on e.job_id = ja.job_id 
where ja.jatlag < (select avg(salary*(1+nvl(commission_pct,0))) from hr.employees) 
order by d.department_name;

-- 3.28.
select e.first_name, e.last_name, e.job_id, d.department_name, e.salary, jla.jatlag, la.latlag 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join (
    select e2.job_id, d2.location_id, avg(e2.salary) jatlag 
    from hr.employees e2 join hr.departments d2 on e2.department_id=d2.department_id 
    group by e2.job_id, d2.location_id
) jla on e.job_id = jla.job_id and d.location_id = jla.location_id 
join (
    select d3.location_id, avg(e3.salary) latlag 
    from hr.employees e3 join hr.departments d3 on e3.department_id=d3.department_id 
    group by d3.location_id
) la on d.location_id = la.location_id 
order by e.job_id, d.location_id asc;

-- 3.29.
select e.first_name, e.last_name, e.job_id, d.department_name, e.salary, 
       trunc((e.salary / ja.jatlag) * 100) munkakor_szazalek, 
       trunc((e.salary / da.atlag) * 100) reszleg_szazalek 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join (select job_id, avg(salary) jatlag from hr.employees group by job_id) ja on e.job_id = ja.job_id 
join (select department_id, avg(salary) atlag from hr.employees group by department_id) da on e.department_id = da.department_id 
order by e.job_id, d.department_name asc;

-- 3.30.
select e.first_name, e.last_name, e.job_id, l.city 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join hr.locations l on d.location_id = l.location_id 
join (select job_id, avg(salary) jatlag from hr.employees group by job_id) ja on e.job_id = ja.job_id 
where e.salary > ja.jatlag 
order by e.job_id;

-- 3.31.
select e.first_name, e.last_name, d.department_name, da.atlag, l.city 
from hr.employees e 
join hr.departments d on e.department_id = d.department_id 
join hr.locations l on d.location_id = l.location_id 
join (select department_id, avg(salary) atlag from hr.employees group by department_id) da on d.department_id = da.department_id 
where d.department_id = (
    select department_id from hr.employees 
    group by department_id 
    having avg(salary) = (select min(avg(salary)) from hr.employees group by department_id)
);

-- 3.32.
select first_name, last_name, job_id 
from hr.employees 
where job_id = (
    select job_id from hr.employees 
    where upper(job_id) not like '%PRES%' 
    group by job_id 
    having count(*) = (
        select max(count(*)) from hr.employees 
        where upper(job_id) not like '%PRES%' 
        group by job_id
    )
);

-- 3.33.
select first_name, last_name, job_id 
from hr.employees 
where job_id = (
    select job_id from hr.employees 
    where upper(job_id) not like '%PRES%' 
    group by job_id 
    having count(*) = (
        select min(count(*)) from hr.employees 
        where upper(job_id) not like '%PRES%' 
        group by job_id
    )
);