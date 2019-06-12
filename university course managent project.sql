create table teachers(
                      teacher_id number(10),
                      name varchar2(30),
                      designation varchar2(20),
                      department varchar2(20),
                      phonenumber number(11),
                      constraint teachers_pk primary key(teacher_id)
                      );
create table course(
                     course_id varchar2(10),
                     name varchar2(30),
                     credit number(10),
                     constraint course_pk primary key(course_id)            
                   );
create table students(
                     students_id varchar2(20),
                     name varchar2(20),
                     year number(5),
                     department varchar2(10),
                     cgpa number(5,3),
                     grade varchar2(5),
                     constraint students_pk primary key(students_id)
                     );
create table teacou(
                    tea_id number(10),
                    cours_id varchar2(10),
                    semester varchar2(20),
                    foreign key(tea_id) references teachers(teacher_id),
                    foreign key(cours_id) references course(course_id),
                    CONSTRAINT cours_pk primary key(cours_id)
                   );
create table stu_cou(
                     stu_id varchar2(20),
                     cour_id varchar2(10),
                     semester_name varchar2(20),
                     foreign key(stu_id) references students(students_id),
                     foreign key(cour_id) references course(course_id),
                     CONSTRAINT cour_pk primary key(cour_id)
                     );
--alter 

ALTER TABLE teacou
DROP CONSTRAINT cours_pk; 

ALTER TABLE teacou	
ADD CONSTRAINT tea_pk PRIMARY KEY (tea_id);

ALTER TABLE stu_cou
DROP CONSTRAINT cour_pk; 

ALTER TABLE stu_cou	
ADD CONSTRAINT student_pk PRIMARY KEY (stu_id);

ALTER TABLE teacou
DISABLE CONSTRAINT tea_pk;

ALTER TABLE teacou
ENABLE CONSTRAINT tea_pk;

ALTER TABLE stu_cou
DISABLE CONSTRAINT student_pk;

ALTER TABLE stu_cou
ENABLE CONSTRAINT student_pk;

--trigger

CREATE TRIGGER T_GRADE 
BEFORE UPDATE OR INSERT ON students 
FOR EACH ROW 
BEGIN
IF :NEW.cgpa=4 THEN
:NEW.grade:='A+';
ELSIF :NEW.cgpa>3.74 AND :NEW.cgpa<4 THEN
:NEW.grade:='A';
ELSIF :NEW.cgpa>3.49 AND :NEW.cgpa<3.75 THEN
:NEW.grade:='A-';
ELSIF :NEW.cgpa>3.24 AND :NEW.cgpa<3.50 THEN
:NEW.grade:='B+';
ELSIF :NEW.cgpa>2.99 AND :NEW.cgpa<3.25 THEN
:NEW.grade:='B';
ELSIF :NEW.cgpa>2.74 AND :NEW.cgpa<3  THEN
:NEW.grade:='B-';
ELSIF :NEW.cgpa>2.49 AND :NEW.cgpa<2.75 THEN
:NEW.grade:='C+';
ELSIF :NEW.cgpa>2.24 AND :NEW.cgpa<2.50 THEN
:NEW.grade:='C-';
ELSIF :NEW.cgpa>1.99 AND :NEW.cgpa<2.25 THEN
:NEW.grade:='D';
ELSIF :NEW.cgpa<2 THEN
:NEW.grade:='F';
END IF;
END T_GRADE;
/

--insert into teachers

insert into teachers values(001,'Md Asraful Islam','Assistant Professor','Cse',+881234);  
insert into teachers values(002,'Muhhammad Sajjad Hossain','Assistant Professor','Cse',+881235); 
insert into teachers values(003,'Md Rafiqul Islam','Assistant Professor','Cse',+881236);
insert into teachers values(004,'Sohaib Abdullah','Assistant Professor','Cse',+881237);
insert into teachers values(005,'Ali Hossain','Assistant Professor','Cse',+881238); 
insert into teachers values(006,'Abu Jafor Md Nurruzamman Abir','Lecturer','Cse',+881239);   

--insert into course

insert into course values('CSE101','Essential Computing',3); 
insert into course values('CSE102','Stuctured Programming',3);
insert into course values('MTH101','Engineering Mathematics',3);
insert into course values('CSE208','Data stucture',3); 
insert into course values('CSE203','Theory of computing',2);
insert into course values('CSE304','Database',4);

--insert into studets

insert into students values('15CSE00655','Rafi',1,'Cse',3.50,null); 
insert into students values('15CSE00665','Shaheen',1,'Cse',2.55,null);
insert into students values('15CSE00650','Rakib',1,'Cse',3.00,null);
insert into students values('15CSE00555','Rajib',2,'Cse',3.70,null);
insert into students values('15CSE00550','Salam',2,'Cse',3.80,null);
insert into students values('15CSE00455','Hasan',3,'Cse',3.30,null);

--insert into teacou

insert into teacou values(001,'CSE101','Spring 2018');
insert into teacou values(002,'CSE102','Spring 2018');
insert into teacou values(003,'MTH101','Spring 2018');
insert into teacou values(004,'CSE208','Spring 2018');
insert into teacou values(005,'CSE203','Spring 2018');
insert into teacou values(006,'CSE304','Spring 2018');

--insert into stu_cou

insert into stu_cou values('15CSE00655','CSE101','Spring 2018');
insert into stu_cou values('15CSE00665','CSE102','Spring 2018');
insert into stu_cou values('15CSE00650','MTH101','Spring 2018');
insert into stu_cou values('15CSE00555','CSE208','Spring 2018');
insert into stu_cou values('15CSE00550','CSE203','Spring 2018');
insert into stu_cou values('15CSE00455','CSE304','Spring 2018');

SELECT d.name, d.designation, d.phonenumber, l.semester
	FROM teachers d JOIN teacou l
	ON d.teacher_id = l.tea_id;
--nutural join

SELECT teachers.name, teacou.cours_id
	FROM teachers JOIN teacou
	ON teachers.teacher_id = teacou.tea_id;
SELECT students.name, stu_cou.cour_id
	FROM students JOIN stu_cou
        ON students.students_id = stu_cou.stu_id;
--inner join
SELECT d.name, d.designation, d.phonenumber, l.semester
	FROM teachers d INNER JOIN teacou l
	ON d.teacher_id = l.tea_id;
--left outter join
SELECT d.name, d.designation, l.semester
	FROM teachers d LEFT OUTER JOIN teacou l
	ON d.teacher_id = l.tea_id;
--Right outter join
SELECT d.name, d.designation, l.semester
	FROM teachers d RIGHT OUTER JOIN teacou l
	ON d.teacher_id = l.tea_id;

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE getemp IS 
   t_id teachers.teacher_id%type;
    d teachers.designation%type;
BEGIN
    t_id := 006;
    SELECT designation INTO d
    FROM teachers
    WHERE teacher_id = t_id;
    DBMS_OUTPUT.PUT_LINE('designation: '||d);
END;
/
SHOW ERRORS;
BEGIN
   getemp;
END;
/
CREATE OR REPLACE FUNCTION avg_salary RETURN NUMBER IS
   avg_sal students.cgpa%type;
BEGIN
  SELECT AVG(cgpa) INTO avg_sal
  FROM students;
   RETURN avg_sal;
END;
/
SET SERVEROUTPUT ON
BEGIN
dbms_output.put_line('Average cgpa: ' || avg_salary);
END;
/
select * from students;










                                                           