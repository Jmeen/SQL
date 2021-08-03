--[연습] hr.employees
-- 직원의 이름, 부서, 팀을 출력하십시오
-- 팀은 코드로 결정하며 다음과 같이 그룹 이름을 출력합니다
-- 부서 코드가 10 ~ 30이면: 'A-GROUP'
-- 부서 코드가 40 ~ 50이면: 'B-GROUP'
-- 부서 코드가 60 ~ 100이면 : 'C-GROUP'
-- 나머지 부서는 : 'REMAINDER'
SELECT first_name, department_id , 
    CASE
    WHEN department_id>=10 and department_id<=30 THEN 'A-GROUP'
    WHEN department_id>=40 and department_id<=50 THEN 'B-GROUP'
    WHEN 50<department_id and department_id<60 THEN 'C-GROUP'
    ELSE 'REMAINDER' 
    END 
FROM employees ORDER BY department_id;
                                             
-- 연습문제
--
--전체직원의다음정보를조회하세요. 
--정렬은입사일(hire_date)의올림차순(ASC)으로가장선임부터출력이되도록하세요.
--이름(first_name   last_name),월급(salary),전화번호(phone_number), 입사일(hire_date) 순서이고
--“이름”, “월급”, “전화번호”, “입사일”로컬 럼이름을대체해보세요.
SELECT first_name||' '||last_name 이름,
    salary 월급,
    phone_number 전화번호,
    hire_date 입사일
FROM employees ORDER BY hire_date ASC;

-- 문제 2
-- 업무(jobs)별로업무이름(job_title)과최고월급(max_salary)을월급의내림차순(DESC)로정렬하세요
SELECT job_title, max_salary
FROM jobs ORDER BY max_salary DESC;

-- 문제3.
-- 담당 매니저가 배정되어있으나커미션비율이없고,월급이3000초과인직원의이름, 매니저아이디,커미션비율,월급을출력하세요.
SELECT first_name, manager_id, commission_pct, salary 
FROM employees 
WHERE manager_id IS NOT NULL and commission_pct IS NULL and salary>3000;

--문제4.
--최고월급(max_salary)이 10000 이상인 업무의 이름(job_title)과 최고월급(max_salary)을 
--최고월급의(max_salary) 내림차순(DESC)로 정렬하여 출력하세요.
SELECT job_title, max_salary 
FROM jobs
WHERE max_salary>1000
ORDER BY max_salary DESC;

--문제5.
--월급이 14000 미만 10000 이상인 직원의 이름(first_name), 월급, 커미션퍼센트 를 월급순
--(내림차순) 출력하세오. 단 커미션퍼센트 가 null 이면 0 으로 나타내시오
SELECT first_name, salary, nvl(commission_pct,0)
FROM employees
WHERE salary<140000 and salary>10000
ORDER BY salary DESC;

--문제6.
--부서번호가 10, 90, 100 인 직원의 이름, 월급, 입사일, 부서번호를 나타내시오
--입사일은 1977-12 와 같이 표시하시오

SELECT first_name 이름 , salary 월급, TO_CHAR(hire_date,'yyyy-mm-dd') 입사일, department_id 부서번호
FROM employees;
    
--문제7.
--이름(first_name)에 S 또는 s 가 들어가는 직원의 이름, 월급을 나타내시오
SELECT first_name 이름, salary 월급
FROM employees
WHERE LOWER(first_name) LIKE '%s%';

-- 문제8.
-- 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세오.
SELECT department_name
FROM departments
ORDER BY LENGTH(department_name) DESC;

--문제9.
--정확하지 않지만, 지사가 있을 것으로 예상되는 나라들을 나라이름을 대문자로 출력하고
--올림차순(ASC)으로 정렬해 보세오.

SELECT UPPER(country_name)
FROM countries
ORDER BY country_name ASC;

--문제10.
--입사일이 03/12/31 일 이전 입사한 직원의 이름, 월급, 전화 번호, 입사일을 출력하세요
--전화번호는 545-343-3433 과 같은 형태로 출력하시오

SELECT first_name 이름, salary 월급, REPLACE(phone_number,'.','-') "전화 번호", hire_date 입사일
FROM employees
WHERE hire_date<'03/12/31';

