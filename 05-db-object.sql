------
-- db object
------

-- view
-- system 계정으로 수행
-- create view권한 필요
GRANT
    CREATE VIEW
TO c##bituser;

-- C##BITUSER로 전환
-- HR.employees테이블로부터 department_id=10 사원의 view생성
CREATE TABLE emp_123
    AS
        SELECT
            *
        FROM
            hr.employees
        WHERE
            department_id IN ( 10, 20, 30 );
        
-- simple view 생성
CREATE OR REPLACE VIEW emp_20 AS
    SELECT
        employee_id,
        first_name,
        last_name,
        salary
    FROM
        emp_123
    WHERE
        department_id = 20;

DESC emp_10;

-- 마치 일반 테이블처럼 SELECT 할 수 있다.
SELECT
    employee_id,
    first_name,
    salary
FROM
    emp_20;

-- SIMPLE view는 제약 사항에 위배되지 않으면 갱신 가능.
UPDATE emp_20
SET
    salary = salary * 2;

SELECT
    employee_id,
    first_name,
    salary
FROM
    emp_20;

-- 가급적 VIEW는 조회전용으로 사용하기를 권장
-- WITH READ ONLY 옵션
CREATE OR REPLACE VIEW emp_10 AS
    SELECT
        employee_id,
        first_name,
        salary
    FROM
        emp_123
    WHERE
        department_id = 10
WITH READ ONLY;

SELECT
    *
FROM
    emp_10;

UPDATE emp_10
SET
    salary = salary * 2;

-- COMPLEX VIEW
CREATE OR REPLACE VIEW book_detail (
    book_id,
    title,
    author_name,
    pub_date
) AS
    SELECT
        book_id,
        title,
        author_name,
        pub_date
    FROM
        book   b,
        author a
    WHERE
        b.author_id = a.author_id;

SELECT
    *
FROM
    book_detail;

SELECT
    *
FROM
    author;

DESC book;

INSERT INTO book (
    book_id,
    title,
    author_id
) VALUES (
    1,
    '토지',
    1
);

INSERT INTO book (
    book_id,
    title,
    author_id
) VALUES (
    2,
    '살인자의 기억법',
    2
);

COMMIT;

-- COMPLEX VIEW로 조회
SELECT
    *
FROM
    book_detail;

-- complex view는 갱신이 불가하다.
--UPDATE book_detail SET Author_name = '소설가'; -- ERROR

-- view의 삭제
-- book_datail은 book, author 테이블을 기반으로 함.
DROP VIEW book_detail; -- view 삭제
SELECT
    *
FROM
    tab;


-- VIEW 확인을 위한 DICTIONARY
SELECT
    *
FROM
    user_views;


SELECT
    *
FROM
    user_objects;

SELECT
    object_name,
    object_type,
    status
FROM
    user_objects
WHERE
    object_type = 'VIEW';
    
-- INDEX : 검색 속도 증가
-- INSET, UPDATE, DELETE -> 인덱스의 갱신 발생
-- HR.employees 테이블 복사 -> s_emp 테이블 생성
CREATE TABLE s_emp 
    AS SELECT * FROM HR.employees;
    
SELECT * FROM s_emp;

-- S_emp.employee_id에 UNIQUE_INDEX 부여
CREATE UNIQUE INDEX s_emp_id
    ON s_emp (employee_id);
    
    
-- index 위한 dictionalry
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;
    
-- 어느 테이블에 어느 컬럼에 S_emp_ID가 부여되었는가?
SELECT t.index_name , t.table_name, c.column_name, c.column_position
FROM USER_INDEXES t, USER_IND_COLUMNS c
WHERE t.index_name = c.index_name AND t.table_name = 'S_EMP';

SELECT * FROM s_emp;

-- 인덱스 삭제
DROP INDEX s_emp_id;
SELECT * FROM USER_INDEXES;

-- 인덱스는 테이블과 독립적: 인덱스 삭제해도 테이블 데이터는 남아있다.


-- SEQUENCE
-- author 테이블 정보 확인
SELECT MAX(author_id) FROM author;

INSERT INTO author(author_id, author_name)
VALUES((SELECT MAX(author_id)+1 FROM author),'Unknown');
SELECT * FROM author;
-- 안전하지 않을 수 있다.
-- 시퀀스 생성, 안전하게 중복처리
ROLLBACK;

SELECT MAX(author_id) FROM author;
CREATE SEQUENCE seq_author_id
    start WITH 3
    INCREMENT BY 1
    MAXVALUE 10000000;
    
INSERT INTO author(author_id, author_name)
values(seq_author_id.nextval,'Steven King');
SELECT * FROM author;

-- 새 시퀸스 만들기
CREATE sequence my_seq
    Start with 1
    Increment by 2
    maxvalue 10;
    
-- 수도컬럼 : CURRVAL(현재 시퀀스 값), NEXTVAL*(값을 증가 새값)
select my_seq.nextval FROM dual;
SELECT my_seq.currval FROM dual;

-- 시퀀스 변경
ALTER SEQUENCE my_seq
    INCREMENT BY 3
    MAXVALUE 1000000;
    
SELECT my_seq.currval FROM dual;
select my_seq.nextval FROM dual;

-- sequence를 위한 dictionary
SELECT * FROM USER_SEQUENCEs;
SELECT * FROM USER_OBJECTS
WHERE object_type='SEQUENCE';

-- 시퀀스 삭제
DROP SEQUENCE my_seq;
SELECT * FROM USER_SEQUENCES;

-- book.book_id 를 위한 시퀀스 생성
SELECT MAX(book_id) FROM book;
CREATE SEQUENCE seq_book_id
    START WITH 3
    INCREMENT BY 1;

SELECT * FROM USER_sequences;