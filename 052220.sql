--052220 수업내용: 서브쿼리 subquery

--예제1)  평균급여를 구하는 쿼리문을 서브 쿼리 사용
-- 평균 급여보다 더 많은 급여를받는 사원을 검색하는 문장. 

select avg(sal) from emp;
select * from emp where sal>2073.214285714285714285714285714285714286;

--서브쿼리 사용하기 
--단일행 주의!! sal-> 하나의 값, 그러므로 서브쿼리도 단일행 유지해줘야함.
select * from emp where sal> (select avg(sal) from emp);
--메인쿼리/서브쿼리 따로 만들고 합치기  : 헷갈림 방지 
--select deptno from emp where ename = 'SCOTT'
select * from emp where deptno = 20;
select * from emp where deptno = (select deptno from emp where ename = 'SCOTT');

--3000이상 받는 사원이 소속된 부서 10, 20 와 동일부서 근무사원이기에, 
--서브쿼리의 결과 중 하나라도 일치하면 참인 결과를 구하는In 연산자와 함께 사용 되어야함 
 select * from emp where deptno in(20,30) ; --1 
 select deptno from emp where sal > = 3000;  --2 
  
--All  
select * from emp where deptno in (select deptno from emp where sal > = 3000);
select ename, sal from emp where sal > all (select sal from emp where deptno = 30);
 
--any
--부서번호 30인 사원의 급옂 가장 작은 값 보다 더 많은 급여를 받느 사원의 이름, 급여 출력
select min(sal) from emp where deptno = 30;
select ename, sal from emp where sal> 950;
select ename, sal from emp where deptno = 30;
select ename, sal from emp where sal > (select min(sal) from emp where deptno = 30); 
select ename, sal from emp where sal < any( select sal from emp where deptno = 30);

--Rownum(오라클 내부적으로 생성되는 가상 컬럼, SQL 조회 결과의 순번을 나타냄)(MySQL limit) 
--ROWNUM : 입력순서의 번호 
select rownum, ename from emp;
select rownum, ename from emp where rownum <=3 order by ename;

--스칼라 부속질의: 컬럼을 표현 
--마당서점의 고객별 판매액을 보이시오 
select name, sum(saleprice)from orders o, customer c 
where o.custid = c.custid group by name order by name;
--서브쿼리 이용하는 방법
select custid, 
(select name from customer c where c.custid = o.custid) 
as customer_name,
sum(saleprice) from orders o;

-- 고객번호 2이하인 고객의 이름, 판매액 출력 

select custid from customer where custid <=2;
select cs.name from (select * from customer where custid <=2) cs, 
orders od where cs.custid = od.custid group by cs.name;

select * from (select ename, empno, job, deptno from emp);

select rownum , ename from emp;

select rownum , ename, empno, sal
from (select ename, empno, job, sal, deptno from emp order by sal desc)
where rownum <= 3;


-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 보이자 
select avg(saleprice) from orders;
select orderid, saleprice from orders where saleprice <= 11800;
-- 서브쿼리 사용
select orderid, saleprice from orders 
where saleprice <= (select avg(saleprice) from orders);
-- 각 고객의 평균 주문금액 보다 큰 금액의 주문 내역에 대해 주문번호, 고객번호, 금액 출력
select avg(saleprice) from orders where custid  = 1;

select orderid, custid, saleprice
from orders o where saleprice > 
(select avg(saleprice) from orders a where custid  = 1);

select * from customer where address like '%대한민국%';

select sum(saleprice) from orders 
where custid in(select * from customer where address like '%대한민국%');

-- 3번 고객이 주문한 도서의 최고금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액
select max(saleprice) from orders where custid = 3;

select custid, sum(saleprice) from orders o
where saleprice > (select max(saleprice) from orders b where custid = 3);  

-- 대한민국에 사는 사람들 오더정보 뽑아내기 
select * from customer where address like '%대한민국%';

select * from orders o 
where exists 
(select * from customer c where address like '%대한민국%'
and o.custid = c. custid);


