select * 
from instructor i 
where I.salary = (select max(I.salary) from instructor I);


# Which studio spent the most in the year 2014
# (the sum of the budgets of the movies that the 
# studio produced was the highest 



#
# Which instructor taught the most number of classes in 2009?
# Break down these queries step by step so break everything down as seperate tables 
#
create view V1 as  
select T.ID, count(T.course_id) as ccID
from teaches T 
where T.year = 2009;


select ID 
from V1 
where ccID = (select max(ccID) from V1);



# which departments have their average salary greater than the average salary of the instructors


select I.dept_name
from instructor I 
group by I.dept_name 
having avg(I.salary) > (select avg(salary) from instructor)




