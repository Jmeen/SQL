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