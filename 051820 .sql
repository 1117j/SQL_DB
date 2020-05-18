-- 2020.05.18

select * from emp; --ctrl + ���� --> �ؿ� ���̺�? ����

SELECT * from dept;

-- �α����� ������ ������ ���̺� Ȯ��
select * from tab;

-- emp : �������
-- dept : �μ�����
-- bonus : �ӽ� ���̺�
-- salgrade : �޿� ���̺�


-- ���̺��� ���� Ȯ�� : desc ���̺��̸�
desc emp;
desc dept;
desc salgrade;

select * from emp;
select * from dept;

-- ������ �˻� ����
select ename, sal, deptno, empno -- �÷� �̸�
from emp -- ���̺� �̸�
;

select * from dept;

select deptno, dname from dept;


-- select �� ����� ���ο� ���̺��̴�.
-- �÷��� ��������� �����ϴ�. +, -, *, /, mod�Լ�(����������)

select * from emp;
select ename, sal, sal + comm
from emp;


select ename, sal, sal+500,sal-100, sal*2, sal/2
from emp;

-- null ���� Ȯ��
select ename, job, sal, comm, SAL*12, SAL*12+COMM
from emp
;

-- null �� ġȯ �Լ� : nvl(�÷���, �⺻��)
-- �⺻���� �÷��� �������� �ڷ����� ���ƾ� �Ѵ�.

select ename, job, sal, nvl(comm, 0), --nvl(comm, 0) : null���� 0���� �ְڴ� �Ҹ�
       sal*12+nvl(comm,0) as total
from emp;

-- �����ͺ��̽��� ���ڿ� ǥ�� -> ���� ����ǥ�� �̿�
-- '���ڿ�'
-- ���ڿ��� �ٿ��� ����ϴ� ���� -> ||

select ename || 'is a' || job as msg
from emp;

select ename, job from emp;


-- ��� �÷��� �ߺ��� �����ϰ� �ϳ����� ��� : distinct
select deptno from emp;

select distinct deptno from emp;

select deptno, job from emp order by deptno;
select distinct deptno, job from emp order by deptno;




