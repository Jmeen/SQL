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

-- ORDER BY : 정렬
-- 오름차순 : 작은값 -> 큰값 ASC(default)
-- 내림차순 : 큰값 -> 작은값 DESC

-- [연습] hr.employees
--  부서 번호를 오름차순으로 정렬하고 부서번호, 급여, 이름을 출력하십시오
SELECT department_id , salary ,first_name FROM employees Order by department_id ;

--  급여가 10000 이상인 직원의 이름을 급여 내림차순(높은 급여 -> 낮은 급여)으로 출력하십시오
SELECT first_name , salary FROM employees WHERE salary>=10000 Order by salary DESC;

--  부서 번호, 급여, 이름 순으로 출력하되 부서번호 오름차순, 급여 내림차순으로 출력하십시오
SELECT department_id , salary ,first_name FROM employees ORDER BY department_id ASC, salary DESC;

-----------------
-- 단일행 함수
-- 한 개의 레코드를 입력으로 받는 함수
-- 문자열 단일행 함수 연습

SELECT first_name , last_name, Concat(first_name, Concat(' ',Last_name)), -- 연결
Initcap(first_name||' '||last_name),  -- 각 단어의 첫글자만 대문자
LOWER(first_name), -- 모두 소문자 
UPPER(first_name), -- 모두 대문자
LPAD(first_name,10,'*'), -- 왼쪽 *로 채우기
RPAD(first_name,10,'*')  -- 오른쪽 * 로 채우기
from employees;

SELECT LTRIM ('                ORCLE          '), -- 왼쪽 공백 제거
RTRIM('                ORCLE          '), -- 오른쪽 공백 제거
TRIM('*' FROM '*********DATABASE*************'),
SUBSTR('ORACLE Database',8,4), -- 부분 문자열
SUBSTR('ORACLE Database',-8,8)
FROM employees;

-- 수치형 단일행 함수
SELECT ABS (3.14), -- 절대값
    CEIL (3.14), -- 소숫점 올림
    FLOOR(3.14), -- 소수점 내림
    MOD(7,3),  -- 나머지
    POWER (2,4), -- 제곱
    ROUND(3.5), -- 소수점 반올림
    ROUND(3.14159, 3), -- 소수점 3자리 까지 반올림 표현
    TRUNC(3.5), -- 소수점 버리기
    TRUNC(3.14159,3), -- 소수점 3자리까지 버림으로 표현
    SIGN(-10) -- 부호 혹은 0
FROM dual;

-- -------
-- DATE FORMAT
------------

-- 현재 날짜와 시간
SELECT SYSDATE FROM dual; -- 1행
SELECT SYSDATE FROM employees;  -- employees의 record갯수만큼

-- 날짜 관련 단일행 함수
SELECT SYSDATE, 
    ADD_MONTHS(sysdate,2), -- 2개월 후 
    LAST_DAY(SYSDATE), -- 이번달의 마지막 날
    MONTHS_BETWEEN(SYSDATE,'99/12/31'), -- 1999년 12/31 이후 몇달이 지났는가?
    NEXT_DAY(sysdate,7), -- 7일 후
    ROUND(sysdate,'MONTH'),
    ROUND(sysdate,'YEAR'), 
    TRUNC(sysdate,'MONTH'),
    TRUNC(sysdate,'YEAR')
FROM dual;

-------------------
-- 변환함수
-------------------

-- TO_NUMBER(s,fmt) : 문자열을 포맷에 맞게 수치형으로 변환
-- TO_DATE(S,FMT) : 문자열을 포맷에 맞게 날짜형으로 변환
-- TO_CHAR(O,FMT) : 숫자 OR 날짜를 포맷에 맞게 문자형으로 변환

-- TO_CHAR
SELECT first_name, HIRE_DATE,
    TO_CHAR(hire_date,'yyyy-mm-dd'),
    TO_CHAR(sysdate,'yyyy-mm-dd HH24-mi:ss')
FROM employees;

SELECT TO_CHAR(300000,'L999,999,999') FROM dual;

SELECT first_name, 
    To_CHAR(salary*12,'$999,999,999.99') SAL
FROM employees;

-- TO_NUMBER :  문자형 -> 숫자형
SELECT TO_NUMBER('2021'),
    To_NUMBER('$1,450.13','$999,999,999.99')
FROM dual;

-- TO_DATE : 문자형 -> 날짜형
SELECT TO_DATE('1999-12-31 23-59-59','YYYY-MM-DD HH24-MI-SS')
FROM dual;

-- 날짜 연산
-- Date +(-) NUMBER : 날짜에 일수 더하기(뺴기)
-- Date - Date : 두 date 사이의 차이 일수
-- Date +(-) Number /24 : 날짜에 시간 더하기
SELECT TO_CHAR(sysdate, 'yy/MM/DD HH24:MI') 오늘날짜,
    SYSDATE + 1, -- 1일 뒤
    Sysdate -1, -- 1일 전
    SYsdate - TO_DATE('19991231'),  -- 두날 사이의 차
    TO_CHAR(sysdate + 13/24 , 'YY/MM/DD HH24:MI')-- 13시간 후
FROM dual;

-------------
-- NULL 관련
-------------

SELECT first_name, 
    salary, 
    commission_pct, 
    salary+salary*nvl(commission_pct,0) commision
FROM employees;

SELECT first_name, 
    salary, 
    commission_pct, 
    nvl2(commission_pct, commission_pct*salary , 0) commission
FROM employees;

-- CASE
-- AD관련 직원에겐 20%,SA관련 직원에겐 10%, IT관련 직원에겐 8%, 나머지는 5% 지급

SELECT first_name, job_id,SUBSTR(job_id,1,2),
    CASE SUBSTR(job_id,1,2) WHEN 'AD' THEN salary * 0.2
                        WHEN 'SA' THEN salary*0.1
                        WHEN 'IT' THEN salary*0.08
                        ELSE salary*0.05
    END bonus
FROM employees;

-- DECODE 함수
SELECT first_name, job_id, salary, SUBSTR(job_id,1,2),
    DECODE(SUBSTR(job_id,1,2),
            'AD',salary * 0.2,
            'SA',salary*0.1,
            'IT',salary*0.08,
            salary * 0.05)
    bonus
FROM employees;

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