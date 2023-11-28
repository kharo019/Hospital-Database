

# which department has the maximum number of students with tot_cred > 100 
select S.dept_name, count(S.ID)
from student S
where tot_cred > 100
group by S.dept_name;


select * from student;
# Which courses (course_id and sec_id) are taught in Fall 2009 and Spring 2010? 
select distinct(T.course_ID) 
from takes T
where T.semester = 'Fall' and T.year = 2009 and T.course_id in 
(select T.course_id
from takes T
where T.semester = 'Spring' and T.year = 2010);



# Which department does the course (has to be the same section in the same semester, year) 
# with the maximum enrollment belong to? 
select * from department;
select * from takes; 
select * from student; 
select * from advisor; 
select * from classroom;
select * from instructor; 
select * from prereq; 
select * from section;
select * from teaches; 
select * from time_slot; 
select * from course;

# how many students are in each course and find the course with maximum then find the department name it belongs to 
create view V11 as 
select course_id, sec_id, semester, year, count(ID) as countD
from takes
group by course_id, sec_id, semester, year;

select C.dept_name 
from V11, course C
where V11.course_ID = C.course_ID and V11.countD = (select max(countD) from V11);


select * from course; 
select * from takes; 


