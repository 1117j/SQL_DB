-- 2020.05.18

select * from emp; --ctrl + 엔터 --> 밑에 테이블? 나옴

SELECT * from dept;

-- 로그인한 계정이 소유한 테이블 확인
select * from tab;

-- emp : 사원정보
-- dept : 부서정보
-- bonus : 임시 테이블
-- salgrade : 급여 테이블


-- 테이블의 구조 확인 : desc 테이블이름 (describe) 
desc emp;
desc dept;
desc salgrade;

select * from emp;
select * from dept;

-- 데이터 검색 질의
select ename, sal, deptno, empno -- 컬럼 이름
from emp -- 테이블 이름
;

select * from dept;

select deptno, dname from dept;


-- select 의 결과는 새로운 테이블이다.
-- 컬럼의 산술연산이 가능하다. +, -, *, /, mod함수(나머지연산)

select * from emp;
select ename, sal, sal + comm
from emp;


select ename, sal, sal+500,sal-100, sal*2, sal/2
from emp;

-- null 값의 확인
select ename, job, sal, comm, SAL*12, SAL*12+COMM
from emp
;

-- null 값 치환 함수 : nvl(컬럼명, 기본값)
-- 기본값은 컬럼의 도메인의 자료형과 같아야 한다.

select ename, job, sal, nvl(comm, 0), --nvl(comm, 0) : null값은 0으로 주겠단 소리
       sal*12+nvl(comm,0) as total
from emp;

-- 데이터베이스의 문자열 표현 -> 작은 따옴표를 이용
-- '문자열'
-- 문자열을 붙여서 출력하는 연산 -> ||

select ename || 'is a' || job as msg
from emp;

select ename, job from emp;


-- 출력 컬럼의 중복을 제거하고 하나씩만 출력 : distinct
select deptno from emp;

select distinct deptno from emp;

select deptno, job from emp order by deptno;
select distinct deptno, job from emp order by deptno;



-- 2020.05.19 // 051920 




-- 특정 데이터를 추출하는 방법: where 절을 적용 
-- select  컬럼명 from 테이블 이름 where 조건 (true/ false) 



-- 예시1)전체 사원중의 월 급여가 3000 이사인 사원의 이름리스트 뽑기 

 select ename, sal
 from emp 
 where sal >= 3000;
 
 --예시2) 전체 사원중 10번 부서(deptno) 소속 사원의 이름(ename)과 직급(job)을 출력하기 
select ename, job from emp
where deptno = 10;


-- 문자열 표현: '작은 따옴표'로 묶는다. 
-- 예시 3)문자열로 찾기  
select * 
from emp 
where job =  'MANAGER'
;

select * 
from emp 
where ename  = 'SCOTT'; 

--날짜 검색 : ''로 묶는다, 대소문자 구분이 없다. 
-- 예시 4) 입사날짜를 겁색해보자
select * 
from emp 
where hiredate = '80-12-17' 
;

--논리 연산자: and (여러개의 조건을 충족해야 출력)
--예시 5) 10번부서에서 매니저 직급인 사람을 찾아보자 
select ename, deptno, job 
from emp where deptno = 10 and job = 'MANAGER';

--논리 연산자 : or (둘중에 한 조건만 충족해도 출력) 
--예시 6) 조건 1: 10번 부서 소속 / 조건 2 : 직급이 매니저 
select * from emp
where deptno = 10 or job = 'MANAGER';

--논리 연산자 : not 논리부정 (조건을 충족하지 않는 사람들을 출력) 
--예시 7) 부서번호가 10번이 아닌 사람들을 출력해보자 
select * from emp 
where not deptno = 10;
-- select * from emp where deptno != 10;
-- where deptno <> 10 도 가능하다. 

-- 범위 연산자:  논리연산의 사용 and 을 사용하는 방법
-- 예시 8) 조건 2000~ 3000 급여를 받는 사원의 정보를 출력
 select * from emp
 where sal >= 2000 and sal <=3000;
-- 범위 연산자: between A and B -> A이상 B이하 
select * from emp 
where sal between 2000 and 3000;  
-- 2000을 초과하고 3000 미만의 급여를 받는 사원 
-- sal > 2000 and sal < 3000
-- sal between 2001 and 2999 

--범위연산자는 문자형/날짜형에도 사용할 수 있다. 
--예시 9) 
select * from emp
where hiredate between '1981/01/01' and '1981/12/31'; 
-- where hiredate >= '1987/01/01' and hiredate <= 1987/12/31;

-- in연산자 ( or 연산을 간소화하여 찾을 수 있다) 
-- 예시 10) 커미션이 300/ 500/ 1400 인 직원을 찾아보자 
-- 컬럼 이름 in(데이터1, 데이터2, 데이터3 ... :이것을 서브쿼리라고 함 )  <-  컬럼 = 데이터1 or 컬럽 = 데이터 2 ... 를 간소화  
select * from emp 
--where comm = 300 or comm = 500 or comm = 1400;
where comm in( 300, 500, 1400); 


--패턴검색 Like 연산자와 와일드카드(%와 _) 사용방법: 컬럼 이름 like 패턴(%와 _)
-- '%'는 0개 이상의 문자열이 가능하다. 
-- '%'의 예) 'S%' -> S로 시작하는 문자열 or '%S' -> S로 끝나는 문자열 or '%S%' -> S를 포함하는 문자열
-- '_'는 1개의 자리수에 어떠한 문자가 와도 가능하다. 
--예시11) 이름이 S로 시작하는 직원을 찾아보자/ 이름에 S가 들어가는 직원을 찾아보자/ 이름의 두번째 문자가 A인 직원을 찾아보자 
select * from emp where ename like 'S%';
select * from emp where ename like '%S%';
-- '_'를 써보자 -> 두번째 글자가 A인 자료 검색 시 '_A%' 세번째는 '__A%'
select * from emp where ename like '_A%';
-- 끝에서 두번째 문자열이 B인 경우 --> '%B_'; 

-- null 값 확인을 위한 연산자: is null, is not null 
-- 컬럼명 is null : 해당 컬럼의 값이 null 인 경우 true
-- 예시 12) 커미션을 받지 않는 사원 조회 // null이 아닌 사원 조회 
select * from emp where comm is null; 
select * from emp where comm is not null; 

--row의 정렬
--order by 절 : 오름차순(작->큰) asc으로 씀, 기본값이므로 생략 가능하다. 
--내림차순(큰 -> 작) desc, 기본값이 아니므로 꼭 명시 
select ename, sal, hiredate, comm
from emp 
where empno > 0 -- where절 생략 가능
-- order by ename asc;
-- order by sal asc;
-- order by sal desc; 
-- order by hiredate asc;
order by comm asc;

select ename, sal
from emp 
--급여 내림차순으로 했을 때, 급여가 같은경우 이름 오름차순으로 정렬
order by sal desc, ename asc;

select ename, deptno from emp
order by deptno, ename, sal;

--문제1 
select ename, sal, sal+300 from emp;
--문제2
select ename, sal, sal*12+100 from emp order by sal*12+100 ASC;
--문제3 
select ename, sal from emp where sal >= 2000 order by sal DESC;
--문제4
select ename, deptno from emp where empno = 7788; 
--문제5 
select ename, sal from emp where not (sal >= 2000 and sal <= 3000);
select ename, sal from emp where not sal between 2000 and 3000;
--문제6
select ename, job, hiredate from emp 
where hiredate between '1981-2-20' and '1981-5-1';
--문제7 
select ename, deptno from emp where deptno = 20 or deptno = 30 order by ename; 
select ename, deptno from emp where deptno between 20 and 30 order by ename;
select ename, deptno from emp where deptno in(20, 30) order by ename;
--문제8 
select ename, sal, deptno from emp 
where sal between 2000 and 3000 and (deptno = 20 or deptno = 30)
order by ename desc;
select ename, sal , deptno from emp where sal between 2000 and 3000 and deptno in(20,30) order by ename desc; 




--문제9 
select ename, hiredate from emp where hiredate like '81%'; 
--문제10 
select ename, job from emp where mgr is null;
--문제11
select ename, sal, comm from emp 
where comm is not null and comm != 0 order by sal desc, comm desc;
--문제12
select ename from emp where ename like '__R%';
--문제13
select ename from emp where ename like'%A%' and ename like '%E%';
--문제14
select ename, job, sal from emp where (job = 'CLERK' or job = 'SALESMAN')
and not sal in(950, 1300, 1600);
--문제15
select ename, sal, comm from emp where comm >= 500;






