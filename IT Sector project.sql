create database IT_Sector;
use IT_Sector;
create table dep
(deptno int primary key,
dname varchar(50) not null,
loc varchar(50) not null);

insert into dep values
(10,'accounting','new york'),
(20,'research','dallas'),
(30,'sales','chicago'),
(40,'operations','boston');

create table emp
(eno int primary key,
ename varchar(50) not null,
job varchar(50) not null,
mgr int,
hiredate date not null,
salary int not null,
commission int,
deptno int not null);

INSERT INTO emp VALUES
  (7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
  (7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
  (7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
  (7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
  (7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
  (7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
  (7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
  (7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20),
  (7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
  (7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
  (7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20),
  (7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
  (7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
  (7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);
  
  select * from dep;
  select * from emp;
  
  select distinct(job) from emp;
  select ename,salary from emp order by salary;
  select * from emp order by deptno asc,job desc;
  select * from emp where eno in (select mgr from emp where mgr is not null);
  select * from emp where year(hiredate) < 1981;
  select eno,ename,salary,salary/365 from emp order by salary asc;
  select eno,ename,job,2024-year(hiredate) from emp;
  select e2.eno as Mgr_No,e2.ename as Mgr_Name, e2.hiredate as Hire_Date ,2024-(Year(e2.hiredate)) as Mgr_Exp from emp as e1 join emp as e2 on e1.mgr=e2.eno;
  select eno,ename,salary,hiredate,2024-(Year(hiredate)) as Mgr_Exp from emp where mgr=7369;
  select * from emp;
  select * from emp where salary<commission;
  select * from emp where hiredate>1981-07-01 order by job;
  select *,datediff(curdate(),hiredate)/365 as exp from emp where salary/30>100;
  select * from emp where job in ("clerk","analyst") order by job desc;
  select * from emp where hiredate between 1980-08-01 and 1980-08-31;
  select * from emp where length(ename)=5;
  select * from emp where ename like "_____";
  select * from emp where hiredate in ("1981-05-01","1981-12-03","1981-12-17","1980-01-19") ; 
  select d.dname, count(*) as num_emp from emp e join dep d on e.deptno = d.deptno group by d.dname having count(*)>3;
  select * from 
  (select e.*,
  dense_rank() over (partition by deptno) as Num_Emp from emp as e) as emp where Num_Emp<=3;
  select * from emp order by salary desc limit 5;
  select * from emp where ename like "%a%";
  select * from emp where (salary*0.1)=year(hiredate);
  select * from emp where day(hiredate) between 1 and 15;
  select * from emp where ename like "_____";
  select ename,salary from emp where salary between 2000 and 5000;
  select * from emp where hiredate="1980-08-01";
  select * from emp where deptno between 10 and 20;
  select e1.* from emp as e1 join emp e2 on e1.mgr=e2.eno where e2.ename="jones";
select distinct(e2.ename),q.sum ,e2.salary from
(
select p.*,row_number() over(partition by p.mgr ) as rn from
(
select e.*,avg(salary) over(partition by e.mgr) as sum from emp as e) as p) as q join emp e2 on q.mgr=e2.eno where e2.salary>q.sum;
select p.*,row_number() over(partition by p.mgr ) as rn from emp p ;
select e.*,avg(salary) over(partition by e.mgr) as sum from emp as e;
select e.*,sum(salary) over(partition by e.deptno) as sum from emp e;
select *,avg(salary) from emp where salary>(select avg(salary) from emp) group by eno;