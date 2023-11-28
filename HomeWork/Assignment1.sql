select * from pilots;
select * from trips;
select * from services;
select * from flies; 
select * from works;
select * from departments;
select * from staff;
select * from passengers;



# 1 - Show the first name, last name, and ID of all staff whose position is “treasurer”
# works perfectly 
select * from staff; # display purposes 

select S.FirstName, S.LastName, S.StaffID
from staff S 
where S.PositionName = "treasurer";



# 2 - Show all trip IDs that passenger “James Bond” has booked in the July of 2019 
# (assume there is only one James Bond)
select * from passengers;
select * from booking;
select * from trips; 


select B.tripID
from booking B inner join passengers P on P.PassID = B.PassengerID
where P.FirstName = "James" and P.LastName = "Bond" and YEAR(BookDate) = 2019 and MONTH(BookDate) = 7;



# 3 - Show the first name, last name and phone numbers of every pilot 
# who has flown exactly 1 distinct time in the July of 2019
select * from pilots; # PilotID
select * from trips; # TripID
select * from flies; # PilotID and TripID 
select * from booking; # PassengerID and TripID
# use flies schema and see where PilotID is shown three times 


select P.FirstName, P.LastName, P.PhoneNumber
from flies F inner join pilots P on F.pilotID = P.pilotID inner join trips T on F.TripID = T.TripID
where YEAR(T.DeptDate) = 2019 and MONTH(T.DeptDate) = 7
group by P.FirstName, P.LastName,  P.PhoneNumber
having count(distinct F.TripID) = 1;
# ^ ^ ^ ^ ^ ^ ^ ^. ^
# This could be considered wrong - this 

select P.PilotID, P.FirstName, P.LastName, P.PhoneNumber
from flies F inner join pilots P on F.pilotID = P.pilotID inner join trips T on F.TripID = T.TripID
where YEAR(T.DeptDate) = 2019 and MONTH(T.DeptDate) = 7
group by P.PilotID, P.FirstName, P.LastName, P.PhoneNumber
having count(distinct F.TripID) = 1;
## ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ 
## Better optimal solution because if a pilot has the same name 
## So no duplicates are not excluded which can be important information 
## 



# 4 - Show the first name, last name, and reward points of every distinct passenger who has booked a trip to 
# "El Paso" and has reward points more than 2000. Show the results in ascending order of reward points
select * from passengers; #PassID
select * from booking; # PassengerID and TripID and BookDate
select * from trips; 


select distinct P.FirstName, P.LastName, P.RewardPoints
from booking B inner join passengers P on B.PassengerID = P.PassID inner join trips T on B.TripID = T.TripID
where T.ArrTown = "El Paso" and P.RewardPoints > 2000 
order by P.RewardPoints asc; 



# 5 - Show all the information of all managers working in the departments 
# belonging to "Finance" category.

select * from departments;
select * from staff;


select S.* 
from staff S join departments D on S.DepartmentID = D.DeptID
where S.PositionName = 'manager' and D.Category = 'Finance';



# 6 - Find all the trip IDs that passengers named “James Bond”
#  and “John Wick” have booked, using the IN operator.
select * from booking;
select * from passengers;

select B.TripID
from booking B, passengers P
where B.passengerID = P.passID and P.FirstName = "James" and P.LastName = "Bond"
and B.TripID in 
(select B.TripID from booking B, passengers P where B.passengerID = P.passID and P.FirstName = "John"
and P.LastName = "Wick");





# 7 - Show the first name, last name, and birth date of all staff and of all pilots 
# sharing the same first name with staff. (Hint: use left/right outer join)

select * from staff;
select * from pilots;

select S.FirstName, S.LastName, S.Birthdate , P.FirstName, P.LastName, P.Birthdate
from staff S left outer join pilots P on S.FirstName = P.FirstName;



# 8 - Find the first name, last name, ID, and ratings of pilots who have a rating less than the average
# Sort the results in ascending order of ratings
#
select * from pilots; 

select P.FirstName,P.LastName,P.PilotID, P.Rating
from pilots P 
where Rating < (select avg(P.Rating) from pilots P)
order by P.Rating ASC;



# 9 - Show the last name, the trip id, and arrival town of those pilots who have 
# flown with more than 450 passengers (capacity) and departed form an airport 
# whose name starts with “S” (i.e San Jose/San Fransisco). The query should use natural join
select * from pilots;
select * from flies;
select * from trips;


select P.LastName,T.TripID,T.ArrTown 
from pilots P NATURAL JOIN flies F NATURAL JOIN trips T
where T.capacity > 450 and T.DeptTown like 'S%';



# 10 - Find the total number of distinct services performed on the aircrafts in 
# which pilot “Parth Nagarkar” has flown

select * from pilots; # PilotID - 590915855, Parth, Nagarkar
select * from services; # ServiceID, StaffID, Staff2ID, AirCraftID
select * from aircrafts; #AircraftID
select * from flies; #PilotID, TripID
select * from trips; #TripID, AirCraftID

select count(distinct(S.ServiceID)) as Distinct_Services
from services S inner join aircrafts A on A.AircraftID = S.AirCraftID inner join trips T on A.AircraftID = T.AirCraftID
inner join flies F on T.TripID = F.TripID inner join pilots P on P.PilotID = F.PilotID
where P.FirstName = "Parth" and P.LastName = "Nagarkar";




