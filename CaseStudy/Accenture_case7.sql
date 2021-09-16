/*Accenture Casestudy*/

/*Creating a database*/
create database Accenture;

/*Use accenture as a default database*/
use accenture;

select * from class;

select * from class_curriculum;

select * from exam;

select * from exam_paper;

select * from student;

select * from teacher;

select * from teacher_allocation;

/*Queries*/

/*1. In the school one teacher might be teaching more than one class.
Write a query to identify how many classes each teacher is taking*/

select t.teacher_id, count(*) as NoOfClasses
from class c inner join teacher_allocation ta on c.class_id = ta.class_id
inner join teacher t on t.teacher_id = ta.teacher_id
group by teacher_id;

/*Or*/

select teacher_id, count(*) as NoOfClasses
from teacher_allocation
group by teacher_id;

/*2. It is interesting for teachers to come across students with names similar to theirs. John is one of the teachers who
finds this fascinating and wants to find out how many students in each class have names similar to his.
Write a query to help him find this data*/

select count(student_name) as John 
from student 
where student_name like "%John%";


/*3. Every class teacher assigns roll number to their class students based on the alphabetical order of their names.
Can you help by writing a query that will assign roll number to each student in a class.*/

select student_name, class_id,
row_number() over (partition by class_id order by student_name) as RollNumber
from student; 


/*4. The principal of the school wants to understand the diversity of students in his school. One of the
important aspects is gender diversity. Provide a query that computes the male to female gender ratio in each class*/

select class_id, sum(case when gender = "M" then 1 else 0 end) as male,
sum(case when gender = "F" then 1 else 0 end) as female,
sum(case when gender = "M" then 1 else 0 end)/sum(case when gender = "F" then 1 else 0 end) as Ratio
from student
group by class_id;

/*5. Every school has teachers with differnt years of experience working in that school.
The principal wants to know the average experience of teachers at this school*/

select teacher_name, round(avg(year(current_date()) - year(date_of_joining)),1)
from teacher
group by teacher_name; 

/*6. At the end of every year class teachers must provide students with their marks sheet for the whole year.
The marks sheet of a student consists of exam (Quarterly, Half-yearly, etc.) wise marks obtained out of
the total marks. Help them by writing a query that gives the student wise marks sheet*/

select s.student_name, e.exam_name, e.exam_subject, marks, total_marks,
marks/total_marks as MarksObtainedOutOfTotal,
concat(marks/total_marks * 100, "%") as PercentOfMarksObt
from exam e inner join exam_paper ep on e.exam_id = ep.exam_id
inner join student s on s.student_id = ep.student_id;

/*7. Every teacher has certain group of favourite students and keep track of their performance in exams. A teacher approached
you to find out the percentages attained by students with ids 1,4,9,16,25 in the "Quaterly" exam. Write a query to obtain this 
data for each student*/

select s.student_id, e.exam_name,
marks/total_marks as MarksObtainedOutOfTotal,
concat(marks/total_marks * 100, "%") as Percentage
from exam e inner join exam_paper ep on e.exam_id = ep.exam_id
inner join student s on s.student_id = ep.student_id 
where s.student_id IN (1,4,9,16,25) and e.exam_name = "Quarterly";

/*8. Class teachers assign ranks to their students based on their ranks obtained in each exam.
Write a query to assign ranks (continous) to students in each class for "Half-yearly" exams*/

select c.class_id, s.student_id,
dense_rank() over (partition by c.class_id order by sum(marks) desc) as AssignedRanks
from class c inner join student s on c.class_id = s.class_id
inner join exam_paper ep on ep.student_id = s.student_id
inner join exam e on e.exam_id = ep.exam_id
where e.exam_name = "Half Yearly"
group by c.class_id, s.student_id
order by c.class_id, AssignedRanks;


#################################################################/*CASESTUDY*/##############################################################################




























