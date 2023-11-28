select * from pilots;
select * from trips;
select * from services;
select * from flies; 
select * from works;
select * from departments;
select * from staff;
select * from passengers;



# 1 - For each department find the max salary of the staff in that department 
select * from departments;
select * from staff;


select D.Name, max(S.Salary)
from departments D inner join staff S on D.DeptID = S.DepartmentID 
group by D.Name;



# 2 - Findd the average income of the pilots 
select * from pilots;

select AVG(Salary)
from pilots;




# 3 - Show the first name, last name, trip id, and departure date of those pilots who have flown 
# from the "El Paso" airport to the "Seattle" or "San Antonio" airports. You should use natural join

# Hint: The symbol of natural join in relational algebra is 
select * from pilots;
select * from trips;
select * from flies; 

select P.FirstName, P.LastName, T.TripID, T.DeptDate
from pilots P natural join trips T
where T.DeptTown = "El Paso" and (T.ArrTown = "Seattle" || T.ArrTown = "San Antonio");

select P.FirstName, P.LastName, T.TripID, T.DeptDate
from trips T, pilot P, flies F
where T.DeptTown IN ("El Paso") and (T.ArrTown in ("Seattle")  || T.ArrTown in ("San Antonio") );

select P.FirstName, P.LastName, T.TripID, P.PilotID, T.DeptDate
from trips T, pilots P, flies F
where T.TripID = F.TripID and P.PilotID = F.pilotID and T.deptTown = "El Paso" and P.PilotID in 
(select P.pilotID from trips T, pilots P, flies F where T.TripID = F.TripID and P.PilotID = F.PilotID 
and T.DeptTown = "Seattle");



# 4 - Find all the AircraftID departing from "El Paso" or arriving to "El Paso" using one of 
# the set operators (union, intersect, minus, etc)
select * from pilots; 
select * from trips; 
select * from aircrafts; 


select T.AirCraftID
from trips T
where T.DeptTown = "El Paso" || T.ArrTown = "El Paso"
union
select A.AirCraftID
from aircrafts A;


select distinct(T.AirCraftID)
from trips T 
where T.DeptTown = 'El Paso' or ArrTown = 'El Paso';




# 5 - Find the last name, id, position, and salary of the staffs whose salary is more than 
# the average salary of pilots 

select * from staff;
select * from pilots;

select S.LastName, S.PositionName, S.StaffID, S.Salary
from staff S
where S.Salary > (select avg(P.Salary) from pilots P);

# group by only used in aggregate function 
# Find lastName with the letter B at the start of their lastName so Brown, Bradshaw, etc..
Select * 
from staff S 
Where S.LastName like 'B%';
