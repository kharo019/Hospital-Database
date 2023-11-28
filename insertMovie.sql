
SET SQL_SAFE_UPDATES = 0;

delete from MovieStar;
delete from Studio;
delete from StarsIn;
delete from Movie;

# Insert to MovieStar
INSERT INTO MovieStar VALUES ("Arquette", 200);
INSERT INTO MovieStar VALUES ("Coltrane", 100);
INSERT INTO MovieStar VALUES ("Foxx", 500);
INSERT INTO MovieStar VALUES ("Galifianakis", 200);
INSERT INTO MovieStar VALUES ("Hathaway", 300);
INSERT INTO MovieStar VALUES ("Keaton", 250);
INSERT INTO MovieStar VALUES ("McConaughey", 400);
INSERT INTO MovieStar VALUES ("Simmons", 150);
INSERT INTO MovieStar VALUES ("Teller", 100);
INSERT INTO MovieStar VALUES ("Waltz", 300);


# Insert to Studio
INSERT INTO Studio VALUES ("JafariStudios", 2000);
INSERT INTO Studio VALUES ("OssorginStudios", 1500);

# Insert to StarsIn
INSERT INTO StarsIn VALUES ("Birdman", 2014, "Galifianakis");
INSERT INTO StarsIn VALUES ("Birdman", 2014, "Keaton");
INSERT INTO StarsIn VALUES ("Boyhood", 2014, "Arquette");
INSERT INTO StarsIn VALUES ("Boyhood", 2014, "Coltrane");
INSERT INTO StarsIn VALUES ("Django Unchained", 2012, "Foxx");
INSERT INTO StarsIn VALUES ("Django Unchained", 2012, "Waltz");
INSERT INTO StarsIn VALUES ("Interstellar", 2014, "Hathaway");
INSERT INTO StarsIn VALUES ("Interstellar", 2014, "McConaughey");
INSERT INTO StarsIn VALUES ("Whiplash", 2014, "Simmons");
INSERT INTO StarsIn VALUES ("Whiplash", 2014, "Teller");


 #Insert to Movie 
INSERT INTO Movie VALUES ("Birdman", 2014, 119, "JafariStudios", 700);
INSERT INTO Movie VALUES ("Boyhood", 2014, 165, "OssorginStudios", 400);
INSERT INTO Movie VALUES ("Django Unchained", 2012, 165, "JafariStudios", 800);
INSERT INTO Movie VALUES ("Interstellar", 2014, 169, "OssorginStudios", 600);
INSERT INTO Movie VALUES ("Whiplash", 2014, 106, "OssorginStudios", 300);
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 select * from StarsIn;
 select * from Studio;
 select * from MovieStar;
 select * from Movie;
 
 
 
 
 # Question 1: Which studio spent the most in the year 2014 (i.e. the sum of the budgets
 # of the movies that the studio producted was the highest? (20 pts) 
 select * from StarsIn;
select * from Studio;
select * from MovieStar;
select * from Movie;
 




create view V3 as 
(select M.StudioName, sum(M.Budget)as Budget
from Movie M 
where M.Year = 2014 and (select max(M.Budget) from Movie M)
group by M.StudioName);

select * 
from V3 
where V3.Budget = (select max(V3.Budget) from V3);




 # Output expected: 
 # 
 
 
 # Question 2: Which movie stars have the highest net worth? (10 pts)
 select MS.name
 from MovieStar MS 
 where MS.NetWorth >= (select max(MS.NetWorth) from MovieStar MS);
 
 # Output expected:
 # name
 # Foxx
 
 
 # Question 3: Which movie have the average netWorth of the movie stars greater than the 
 # average networth of all movie stars? 
select * from StarsIn;
select * from Studio;
select * from MovieStar;
select * from Movie;

# Finds the total average networth of movie stars which should output 250
Select avg(MS.NetWorth)
from movieStar MS;

# Finds average networth of movie stars associated with their movie they star in 
select M.title, avg(MS.netWorth)
from StarsIn SI inner join MovieStar MS on MS.name = SI.starName
		inner join Movie M on M.Title = SI.movieTitle 
group by M.title;
 
 
# the answer query 
select M.Title, avg(MS.Networth)
from StarsIn SI inner join MovieStar MS on MS.name = SI.starName
		inner join Movie M on M.Title = SI.movieTitle 
group by M.Title
having avg(MS.NetWorth) > (Select avg(MS.NetWorth) from movieStar MS);


 
 # Output expected: 
 # movieTitle			avg(M.netWorth)
 # Django Unchained		400.00
 # Interstellar			400.00
 
 
 
 
 # Question 4: Find the movies whose title starts with B and were released in 2014? (10 pts) 
select * from StarsIn;
select * from Studio;
select * from MovieStar;
select * from Movie;


 select M.Title 
 from Movie M
 where M.Title like "B%" and M.Year = 2014;
 
# Expected Output
# Title 
# Birdman 
# Boyhood




# Question 5: What is the runtime and title of the movie that has the maximum number of stars? 
# Hint: Count the number of stars in each movie. Then, find the movie name that has the max number of stars, 
# and then find the runtime and title of this movie 
select * from StarsIn;
select * from Studio;
select * from MovieStar;
select * from Movie;
 
select *
from StarsIn SI inner join MovieStar MS on MS.name = SI.starName
		inner join Movie M on M.Title = SI.movieTitle;
 
SELECT M.Length, M.Title, COUNT(S.StarName) AS NumStars
FROM Movie M,StarsIn S
WHERE S.movieTitle = M.Title
GROUP BY M.Title, M.Length;


select M.Length, M.Title, count(SI.StarName) 
from movie M inner join StarsIn SI on SI.movieTitle = M.Title  
group by M.title, M.Length;



 
 
 
 
 
# Extra Credit - Find the movies where the netWorth of each of the stars is greater 
# than the average netWorth of all movie stars? 

# Hint: First, find the netWorth of all movie stars. Then, find the stars who have a netWorth 
# higher than the average networth of all movie stars. Then, find the movie title names in which 
# the above stars did not star in, and then remove the above movie titles from the set of movie titles
# to get the final result

select * from StarsIn;
select * from Studio;
select * from MovieStar;
select * from Movie;

# Networth of all movie stars
Select avg(MS.NetWorth)
from movieStar MS;

# Stars with a networth higher than the average networth of all movie stars



select * from StarsIn;
select * from Studio;
select * from MovieStar;
select * from Movie;

# 478767
SELECT M.Title, MS.netWorth 
FROM Movie M inner join StarsIn SI on SI.movieTitle = M.Title inner join MovieStar MS on MS.name = SI.starName
#WHERE S.starName = MS.name AND S.movieTitle=M.Title
GROUP BY M.Title, MS.netWorth
HAVING MS.netWorth > (SELECT AVG(MS.netWorth) FROM MovieStar MS);








 
 
 
 
