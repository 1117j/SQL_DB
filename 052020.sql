--052020 수업 

-- 숫자함수 
-- mod = 나머지값 반환 
select mod (10,3) from dual;
select ename, mod (sal, 10) from emp;

--abs = 절대값 반환
select abs(-10) from dual; 
select ename, abs(sal) from emp;

--trunc = 특정 자리수 버리기 (-양/ +소숫점) 
select trunc(1282, -2) from dual;
select trunc(1282.42351211, 0) from dual;
select ename, trunc(sal, -1) from emp; 

--round = 특정 자리수에서 반올림 
select round(3.141592, 2) from dual;
select ename, sal, round(sal, -3) from emp;

-- 날짜 함수 
-- sysdate : 시스템 저장된 현재 날짜 반환 
select sysdate from dual; 

-- to_char 
-- date = > vachar2
 select sysdate, to_char(sysdate, 'YYYY.MM.DD')
 from dual;
 
 select ename, to_char(hiredate,'YYYY.MM.DD') as hiredate
 from emp;
 
 select sysdate, to_char(sysdate, 'HH24:MI:SS') from dual; 
 
 -- 자릿수 맞추기
 select to_char(12500, '000,000') from dual;

select to_char(12500, '999,999') from dual;

-- 원화 표현으로 바꾸기(L) 
select to_char(12500, 'L999,999') from dual;

select to_char(3.14, '000,000.000') from dual;
select to_char(3.141592, '999,999.99') from dual;

select sal, to_char(sal*1277, 'L999,999,999') from emp;
select ename, sal, to_char(sal*1277*12+nvl(comm,0),'L999,999,999') as Income from emp order by income desc;

--To_date(원본, 패턴) str-> date 
select to_date('19810220', 'YYYYMMDD') from dual;
select to_date('19810220', 'YYYY/MM/DD') from dual;
select ename, hiredate from emp where hiredate = to_date('1981/02/20','YYYY/MM/DD');

select sysdate, to_date('20201225','yyyymmdd') from dual;
select sysdate, to_date('20201225','yyyymmdd'), trunc(to_date('20201225','yyyymmdd')-sysdate) from dual;
-- 날짜계산 ( 오늘날짜-이전날짜) 
select sysdate, trunc(sysdate-to_date('19921117','yyyymmdd')) from dual;
select sysdate, trunc(sysdate-to_date('19860919','yyyymmdd')) from dual;
select sysdate, trunc(sysdate-to_date('19880214','yyyymmdd')) from dual;
select sysdate, trunc(sysdate-to_date('19950119','yyyymmdd')) from dual;

--To_number (원본, '패턴')  str --> number : 산술연산이 목적 
select to_number('20,000' , '999,999,999') from dual;
select to_number('20,000' , '999,999,999')- to_number('10,000' , '999,999,999') from dual;

--Decode 함수 : if or switch 구문과 유사하게 사용됨(조건에 따라 특정값 반환) 
select ename, deptno, 
decode(deptno, 10, 'Accounting',
20, 'Research',
30, 'Sales',
40, 'Operating') as deptName
from emp;

-- 직급에 따라 급여 인상, 직급 분석가는 5%, 세일즈 10%, 매니저 15%, 사원 20% 인상
select ename, deptno, 
decode(job, 
'ANALYST', sal*1.05,
'SALESMAN', sal*1.1,
'MANAGER', sal*1.15,
'CLERK', sal*1.2
) as Upsal
from emp;

--case 함수(if else) 
select ename, deptno, 
case when deptno = 10 then 'Acct'
when deptno = 20 then 'Research'
when deptno = 30 then 'Sales'
when deptno = 40 then 'OP'
end as Dname from emp order by ename;

-----------------------
-- 그룹
-----------------------
--sum(컬럼이름) : 해당 컬럼 데이터들의 합 반환 
--ex1) 매월 지급되는 급여의 총 합 
select to_char(sum(sal)*1277 ,'L999,999,999')as totalSal from emp;



--avg(컬럼명) :  해당 컬럼 데이터들의 평균값을 반환
--ex2) 
select trunc(avg(sal*1277), 2)as avgSal from emp;

select avg(comm)from emp; 

--max, min : 해당 컬럼의 데이터 중 최댓값, 최솟값
select max(sal), min(sal), max(comm), min(comm)
from emp;

--count : row(행)을 구해준다. 
select count(comm) from emp;
select count(job) from emp;
select count(distinct job) from emp order by job;

-- group by 절 : 특정 컬럼으로 그루핑 해준다.
select deptno from emp group by deptno;
select job from emp group by job;

-- 부서별로 
-- 사원 수와 커미션을 받는 사원들의 수를 계산하자
select deptno, count(*), count(comm)
from emp
where comm <> 0
group by deptno
;

-- 부서별 
-- 평균 급여가 2000 이상인(HAVING) 
-- 부서번호와 부서별 평균 급여를 출력
select deptno, avg(sal), count(*), count(comm), sum(comm)
from emp
group by deptno
having avg(sal)<=2000
;


-- 직급별 , 지표 출력
select job, count(*) as "직급별 인원",
            sum(sal) as "직급별 월 총 급여",
            trunc(avg(sal)) as "직급별 월 평균 급여",
            nvl(sum(comm), 0) as "직급별 수령 커미션의 총 합",
            max(sal) as "직급별 최고 급여 금액"
from emp
group by job
--having  count(*)>=2   -- 직급의 인원이 2명 이상인 직급
having avg(sal) >= 2000 and count(*)>1
;

select  deptno, job
from emp
group by deptno, job
order by job
;

-- substr(원본 데이터, 시작 인덱스, 개수)
select substr(hiredate, 0,5) from emp;  -- 81/02
select substr(hiredate, 4,2) from emp;  -- 








