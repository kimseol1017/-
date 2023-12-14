-- 1.
select ename 이름, dno 부서번호
from employee e
where e.eno = 7788;

-- 2.
select ename 이름 , hiredate 입사일
from employee
where hiredate like '81%';

--3.
select ename 이름 , job 담당업무, salary 급여
from employee 
where job in ('CLERK','SALESMAN') and salary not in(1600,950,1300);

--4.
select trunc(months_between(sysdate,to_date('04/06/04','YY/MM/DD')))
from dual;

--5.
select round(AVG(salary),2) 월급의평균, dno 부서번호
from employee
group by dno
having AVG(salary) >= 2000
order by dno ASC;

--6.
select eno 사원번호 , ename 이름
from employee
where salary >= (select AVG(salary) from employee)
order by salary ASC;

-- 7.
select e.ename 사원이름 , e.dno 부서번호, d.dname 부서명, d.loc 부서위치
from employee e
    join department d
        on e.dno = d.dno
where job = 'MANAGER'
order by ename DESC; 

--8. 

create view v_join
AS
select e.ename 사원이름, e.job 직책, d.dname 부서명, d.loc 부서위치
from employee e
    join department d
        on e.dno = d.dno
where e.dno != 20 and e.salary in(select MIN(e.salary) from employee group by e.dno having MIN(e.salary) >= 900);

select * from v_join;

-- 9.
create table EMP50
as
select * from employee;

create table DEPT50
as
select * from department;

alter table DEPT50
add CONSTRAINT PK_DNO_DEPT05 primary key(dno);

ALTER TABLE EMP50
add CONSTRAINT PK_ENO_EMP50 primary key(eno);
ALTER TABLE EMP50
add CONSTRAINT FK_DNO_EMP50 FOREIGN KEY (dno) REFERENCES DEPT50(dno);

--10.
    -- 1.
insert into EMP50(eno,ename,job,manager,hiredate,salary,commission,dno)
VALUES (8181,'홍길동','사무원',7788,sysdate,1000,100,20);
    -- 2.
UPDATE emp50
set commission = 50
where commission = 0 or
commission is null;
commit;

UPDATE dept50
set dname = '운영부' , loc = '서울'
where dno = 40;
commit;

DELETE emp50
where job = 'MANAGER';
commit;

---------적용 확인
select * from EMP50;
select * from DEPT50;