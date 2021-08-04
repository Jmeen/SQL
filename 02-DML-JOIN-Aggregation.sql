--------------------
-- JOIN
--------------------

-- 먼저 empoyees 와 department를 확인
DESC employees;
DESC department;

-- 두 테이블로 부터 모든 레코드를 추출 : Cartision product or Cross join
SELECT first_name, emp.department_id, dpt.department_id, department_name
FROM employees emp, departments dpt
ORDER by first_name;


-- 테이블 조인을 위한 조건을 부여할 수 있다.
SELECT first_name, emp.department_id, dpt.department_id, department_name
FROM employees emp, departments dpt
WHERE emp.department_id = dpt.department_id;

-- 총 몇명의 사원이 있는가?
SELECT count(*) FROM employees;  -- 107명

SELECT first_name, emp.department_id, department_name
FROM employees emp , departments dpt
WHERE emp.department_id = dpt.department_id;  -- 106명

-- department_id 가 NULL인 사원 확인
SELECT * FROM employees
WHERE department_id IS NULL;

-- emp와 dpt를 연결하는데, department_id를 이용해 붙여주셈
-- USING : 조인할 칼럼을 명시
SELECT first_name, department_name 
FROM employees emp JOIN departments USING(department_id);

-- ON : JOIN의 조건절
SELECT first_name , department_name
FROM employees emp JOIN departments dpt 
                    on (emp.department_id = dpt.department_id); -- JOIN의 조건

-- Natural Join
-- 조건 명시 하지않고, 같은 이름을 가진 컬럼으로 JOINS

SELECT first_name, department_name
FROM employees emp NATURAL JOIN departments;
-- 잘못된 쿼리 : Natural JOIN은 조건을 잘 확인하자.

----------------
-- OUTER JOIN
----------------
-- 조긴이 만족하는 짝이 없는 튜플도 NULL을 포함하여 결과를 출력
-- 모든 레코드를 출력할 테이블의 위치에 따라 LEFT, RIGHT, FULL OUTER JOIN으로 구분
-- ORACLE의 경우, NULL을 출력할 조건 쪽에 (+)를 붙인다.

SELECT first_name, emp.department_id, dpt.department_id, department_name
FROM employees emp , departments dpt
WHERE emp.department_id = dpt.department_id(+);

-- ANSY SQL
SELECT emp.first_name, emp.department_id, dpt.department_id , dpt.department_name
FROM employees emp LEFT OUTER JOIN departments dpt
    on emp.department_id = dpt.department_id;

-- Right outer join : 짝이 없는 오른쪽 레코드도 null을 포함하여 출력
SELECT first_name, emp.department_id, dpt.department_id, department_name
FROM employees emp , departments dpt
WHERE emp.department_id(+) = dpt.department_id;

-- ANSY SQL
SELECT emp.first_name, emp.department_id, dpt.department_id , dpt.department_name
FROM employees emp RIGHT OUTER JOIN departments dpt
    on emp.department_id = dpt.department_id;
    
-- FULL OUTER JOIN
-- 양쪽 테이블 레코드 전부를 짝이 없어도 출력에 참여
--SELECT emp.first-name, emp.department_id, dpt.department_id, dpt.department_name
--FROM employees emp , departments dpt
--WHERE emp.department_id (+) = dpt.department_id(+);  -- ORACLE SQL에선 FULL OUTER 못함.

-- ANSY SQL
SELECT emp.first_name, emp.department_id, dpt.department_id , dpt.department_name
FROM employees emp FULL OUTER JOIN departments dpt
    on emp.department_id = dpt.department_id;
    
-- SELF 조인 
-- 자기 자신과 JOIN
-- 자기 자신을 두번 이상 호출 --> alias를 사용할 수 밖에 없는 JOIN
--[연습] hr.employees
-- SELF JOIN을 이용하여 다음의 값을 출력하시오
-- EMPLOYEE_ID
-- FIRST_NAME
-- MANAGER의 EMPLOYEE ID
-- MANAGER의 FIRST_NAME    
 

 SELECT * FROM employees; -- 107명
 -- 사원 정보
SELECT emp.employee_id, emp.first_name, man.employee_id, man.first_name
FROM employees emp JOIN employees man
ON emp.manager_id = man.employee_id
ORDER BY emp.employee_id;

-- Steven 포함하게
SELECT emp.employee_id, emp.first_name, man.employee_id, man.first_name
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id(+)
ORDER BY emp.employee_id;

-- Steven 포함하게(ANSI SQL)
SELECT emp.employee_id, emp.first_name, man.employee_id, man.first_name
FROM employees emp LEFT OUTER JOIN employees man
ON emp.manager_id = man.employee_id
ORDER BY emp.employee_id;