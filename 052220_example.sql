--052220 assignment
--43. 사원 번호가 7788인 사원과 담당 업무가 같은 사원을 표시(사원 이름과 담당업무)하시오.
select ename, job 
from emp 
where job = (select job from emp where empno = 7788);

--44. 사원번호가 7499인 사원보다 급여가 많은 사원을 표시하시오. 사원이름과 감당 업무
select ename, job 
from emp 
where sal > (select sal from emp where empno = 7499);

--45. 최소급여를 받는 사원의 이름, 담당업무 및 급여를 표시하시오. (그룹함수 사용)
select min(sal) from emp;
select ename, job, sal 
from emp 
where sal = (select min(sal) from emp);

--46. 평균급여가 가장 적은 직급의 직급 이름과 직급의 평균을 구하시오.
select job, avsal 
from emp, (select avg(Sal) as avsal from emp group by job) 
where rownum < = 1 order by avsal; 

--47. 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표시하시오.
--select min(sal) from emp group by deptno;
select ename, sal, deptno 
from emp 
where sal in(select min(sal) from emp group by deptno); 

--48. 담당업무가 ANALYST 인 사원보다 급여가 적으면서 업무가 ANALYST가 아닌 
-- 사원들을 표시(사원번호, 이름, 담당 업무, 급여)하시오.
--select avg(sal) from emp where job = 'ANALYST';
select empno, ename, job, sal 
from emp 
where sal< (select avg(sal) from emp where job = 'ANALYST')
and job <> 'ANALYST';

--49. 부하직원이 없는 사원의 이름을 표시하시오.
--select distinct m.ename from emp e, emp m where e.mgr  = m.empno;
select ename 
from emp 
where ename not in (select distinct m.ename from emp e, emp m where e.mgr = m.empno) ;

--50. 부하직원이 있는 사원의 이름을 표시하시오.
select distinct m.ename 
from emp e, emp m 
where e.mgr  = m.empno;

--51. BLAKE와 동일한 부서에 속한 사원의 이름과 입사일을 표시하는 질의를 작성하시오. ( 단 BLAKE는 제외 )
--select deptno from emp where ename = 'BLAKE';
select ename, hiredate 
from emp 
where deptno = (select deptno from emp where ename = 'BLAKE') 
and ename != 'BLAKE';

--52. 급여가 평균 급여보다 많은 사원들의 사원 번호와 이름을 표시하되 결과를 급여에 대해서 오름차순으로 정렬하시오.
--select avg(sal) from emp;
select empno, ename 
from emp 
where sal >(select avg(sal) from emp) order by sal desc;

--53. 이름에 K가 포함된 사원과 같은 부서에서 일하는 사원의 사원 번호와 이름을 표시하시오.
--select distinct deptno from emp where ename like '%K%';
select empno, ename 
from emp 
where deptno in(select distinct deptno from emp where ename like '%K%'); 

--54. 부서위치가 DALLAS인 사원의 이름과 부서번호 및 담당업무를 표시하시오.
select ename, e.deptno, e.job 
from emp e , dept d 
where e.deptno = d.deptno and loc = 'DALLAS';
--서브쿼리 사용 
--select deptno from dept where loc = 'DALLAS';
select ename, e.deptno, e.job 
from emp e, (select deptno from dept where loc = 'DALLAS') d
where e.deptno = d.deptno;

--55. KING의 부하 사원의 이름과 급여를 표시하시오.
--1. 킹의 사번 뽑기 2.mgr이 king인 사람 뽑기 
--select empno from emp where ename = 'KING';
select ename, sal 
from emp 
where mgr = (select empno from emp where ename = 'KING');

--56. RESEARCH 부서의 사원에 대한 부서번호, 사원이름 및 담당 업무를 표시하시오.
--select deptno from dept where dname = 'RESEARCH';
select ename, e.deptno, job 
from emp e, (select deptno from dept where dname = 'RESEARCH') d
where e.deptno  = d.deptno;

--57. 평균 월급보다 많은 급여를 받고 이름에 M이 포함된 사원과 같은 부서에서 근무하는 
--사원의 사원 번호, 이름, 급여를 표시하시오.
--1.평균월급 
--select avg(Sal) from emp;
--select distinct deptno from emp where ename like '%M%';
select empno, ename, sal 
from emp 
where sal > (select avg(Sal) from emp) 
and deptno in(select distinct deptno from emp where ename like '%M%');

--58. 평균급여가 가장 적은 업무를 찾으시오.
--select avg(sal) from emp group by job;
--select min(avgsal) from (select avg(sal) as avgsal from emp group by job);
select job from emp group by job
having avg(sal) = (
        select min(avgsal) from (select avg(sal) as avgsal from emp group by job
        )
    );
    
--59. 담당업무가 MANAGER 인 사원이 소속된 부서와 동일한 부서의 사원을 표시하시오.
--select deptno from emp where job = 'MANAGER';
select ename 
from emp 
where deptno in (select deptno from emp where job = 'MANAGER');


--1 마당서점의고객이요구하는다음질문에대해SQL 문을작성하시오.
--(5) 박지성이 구매한 도서의 출판사수
--select custid from customer where name = '박지성';
--select bookid from orders where custid = (select custid from customer where name = '박지성');
select count(publisher) 
from book 
where bookid in(select bookid from orders 
                where custid = (select custid from customer where name = '박지성'));


--(6) 박지성이구매한도서의이름, 가격, 정가와판매가격의차이
--select custid from customer where name = '박지성';
--select bookid from orders where custid = (select custid from customer where name = '박지성');
select bookname, price, price-saleprice  
from book bk, orders od 
where bk.bookid = od.bookid
and bk.bookid in(select bookid from orders where custid = (select custid from customer where name = '박지성'));

--(7) 박지성이구매하지않은도서의이름
--select bookid from orders where custid <>  (select custid from customer where name = '박지성');
select bookname 
from book bk, orders od 
where bk.bookid = od.bookid 
and bk.bookid in (select distinct bookid from orders where custid <>  (select custid from customer where name = '박지성'));


--2 마당서점의운영자와경영자가요구하는다음질문에대해SQL 문을작성하시오.
--(8) 주문하지않은고객의이름(부속질의사용)
--(9) 주문금액의총액과주문의평균금액
--(10) 고객의이름과고객별구매액
--(11) 고객의이름과고객이구매한도서목록
--(12) 도서의가격(Book 테이블)과판매가격(Orders 테이블)의차이가가장많은주문
--(13) 도서의판매액평균보다자신의구매액평균이더높은고객의이름

--3. 마당서점에서 다음의 심화된 질문에 대해 SQL 문을 작성하시오.
--(1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
--(2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름