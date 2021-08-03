-- DML: SELECT

-----------------

-- SELECT ~ FROM
-- 전체 데이터의 모든 컬럼 조회
-- 컬럼의 출력순서는 정의에 따른다. 테이블 생성했을때 정의한 순서
SELECT * FROM employees;

SELECT * FROM departments;

-- 특정 컬럼만 선별하여 Projection
-- 사원의 이름, 입사일, 급여 출력

SELECT first_name, hire_date, salary FROM employees;

-- 산술연산 : 기본적인 산술 연산이 가능하다.
-- dual : 가상테이블. 
-- 특정 테이블에 속한 데이터가 아닌
-- 오라클 시스템에서 값을 구한다.
SELECT 10*10*3.14159 FROM dual; -- 결과는 1개
SELECT 10*10*3.14159 FROM employees; -- 결과는 Table의 레코드 수 만큼.

-- 임플로이에서 퍼스트네임과 잡아이디를 불러와서 산술연산
SELECT first_name, job_id*12 From employees; -- 에러 발생 - jobid는 문자열이라 곱하기가 안됨.
desc employees;

SELECT first_name + ' ' + last_name FROM employees; -- ERROR 문자열끼리 합산은 불가하다.

-- 문자열 연결은 ||로 연결
SELECT first_name || ' ' || last_name FROM employees;

-- NULL
SELECT first_name, salary, salary*12 FROM employees;

SELECT first_name, salary, commission_pct FROM employees;

SELECT first_name, salary+salary * commission_pct FROM employees;
SELECT first_name, salary , commission_pct,salary+salary * commission_pct FROM employees; -- null이 포함된 산술식은 null

-- NVL
SELECT first_name, salary, commission_pct, salary+salary * NVL(commission_pct,0) FROM employees; 
-- commision pct가 null이면 0으로 치환

-- Alias : 별칭
SELECT first_name || ' ' || last_name  이름, phone_number as 전화번호, salary "급  여" FROM employees;
-- 공백 여백이면 ""로 묶는다


--[예제] hr.employees 전체 튜플에 다음과 같이 Column Alias를 붙여 출력해 봅니다
   -- 이름 : first_name last_name
   -- 입사일: hire_date
   -- 전화번호 : phone_number
   -- 급여 : salary
   -- 연봉 : salary * 12
SELECT first_name || ' ' || last_name  이름, hire_date 입사일, phone_number 전화번호, salary 급여, salary * 12 연봉 FROM employees;
-- 비교연산
-- 급여가 15000 이상인 사원의 목록

SELECT first_name, salary From employees Where salary>=15000;

-- 날짜도 대소 비교 가능
-- 입사일이 07/01/01 이후인 사원의 목록

SELECT First_name, hire_date From employees where hire_date>'07/01/01';

-- 이름이 lex인 사원이 이름, 급여, 입사일 출력
select first_name , salary, hire_date From employees where first_name = 'Lex';

-- 논리연산자
-- 급여가 14000 이하이거나 17000 이상인 사원의 목록
select first_name, salary FROM employees where salary<10000 or salary>17000;

-- 급여가 14000 이상, 17000 이하인 사원의 목록
select first_name, salary FROM employees where salary>=14000 and salary<=17000;
-- BETWEEN : 위 쿼리와 결과 동일
select first_name, salary FROM employees where salary BETWEEN 14000 and 17000;

-- NULL 체크
-- =NULL, !=NULL 은 하면 안됨
-- IS NULL , IS NOT NULL 사용
-- 커미션을 받지 않는 사원의 목록
SELECT first_name, commission_pct FROM employees WHERE commission_pct IS NULL;

-- 연습문제
-- 담당 매니저가 없고, 커미션을 받지 않는 사원의 목록
SELECT first_name, manager_id, commission_pct FROM employees WHERE manager_id IS NULL and commission_pct IS NULL ;

-- 집합 연산자 IN
-- 부서번호가 10, 20, 30 인 사원들의 목록
SELECT first_name , department_id FROm employees Where department_id = 10 or  department_id = 20  or department_id = 30;

SELECT first_name , department_id FROM employees WHERE department_id IN (10, 20, 30);

-- ANY
SELECT first_name , department_id FROM employees WHERE department_id =ANY (10,20,30);

-- ALL : 뒤에 나오는 집합 전무 만족
select first_name, salary FROM employees WHERE salary>ALL(12000,17000);

-- LIKE 연산자 : 부분 검색
-- % : 0글자 이상의 정해지지 않은 문자열
-- 1글자 (고정) 정해지지 않은 문자
-- 이름에 am을 포함한 사원의 이름과 급여를 출력
select first_name, salary FROM employees WHERE first_name LIKE '%am%';

-- 연습
-- 이름의 두번재 글자가 a인 사원의 이름과 연봉
select first_name, salary FROM employees WHERE first_name LIKE 'a%';



