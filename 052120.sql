--052120 join
--Equi Join 

select * from emp e, dept d 
where e.deptno = d.deptno;

--이름이 scott인 사람의 부서명을 출력하기 
select ename, dname from emp, dept 
where emp.deptno = dept.deptno and ename = 'SCOTT';

select * 
from orders o, book b, customer c 
where o.bookid = b.bookid and o.custid = c.custid;

--박지성의 총 구매액, 박지성 고객번호 1번
select sum(price) 
from orders o, book b, customer c 
where o.bookid = b.bookid and o.custid = c.custid and name = '박지성';

--non equi join 
select * from emp;
select * from salgrade;

select * from emp e, salgrade s ;

select * from emp e, salgrade s where e.sal >= s.losal and e.sal <= s.hisal ;

select ename, sal, s.grade from emp e, salgrade s where e.sal >= s.losal and e.sal <= s.hisal ; 

select ename, sal, grade from emp e, salgrade s where sal between losal and hisal;

--self join 
--관리자의 이름을 알아보자 
select * from emp;

select employee.ename|| '사원의 관리자는 ' || manager.ename || ' 입니다.'
from emp employee, emp manager where employee.mgr = manager.empno;

select e.ename ||'의 상사는' || m.ename || '입니다.'
from emp e, emp m 
where e.mgr = m.empno;

select ename, dname from emp inner join dept
on emp.deptno = dept.deptno;

select ename, dname from emp natural join dept;

