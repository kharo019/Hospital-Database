

Name: Kevin Haro 
Class: CS482 

This file is serving as an instruction information to run this project of phase 2 for 
databases. 

What is included in this file is my Hospital_Schema: 
insert.dbl # Data to be inserted into the database
create.dbl # creation of the tables for the database
phase3.py  # My python file to connect and run mySQL queries 

In my phase3.py, you don't need to edit any of the python code so there's no hard code needed
to be changed. It'll prompt you the information needed to connect and run mySQL queries

HEADS-UP: 
	If you're running this script on MacOS, you need to type python3 and not like the professor 
	sample to run it with just python <file_name.py> 6 beta
	In MacOS, you need to run it as python3 <file_name.py> 6 beta
	This was the error I was getting on my end but it might be different for you but wanted
	to suggest a quick solution

Example: 
	For query 6,
	> python3 phase3.py 6 2022-03-22

	After entering this it'll prompt you with a series of questions to connect 
	to mySQL workbench 
	It'll ask for the name of host, database name, user_name, and password.
	and output of the query will display



Running retrieve all data:
	Same way of running as before examples shown above; however, it'll be string names
	instead of numbers like in this example of retrieving all data for physicians
	> python3 phase3.py retrieveAllData physicians
	
	The output will display all of the data from the table

	Special case scenarion with `procedure`, you don't need to modify anything just follow
	with the same example as previous so it'll be 
	>python3 phase3.py retrieveAllData procedure

	And the output will display properly within the function of retrieveAllData I used an
	if to grab the arguments from the command line and store it in a list and I grab
	the first index of the list and compare it and if its procedure then run a different way
	compared to the other table names


Running Average:
	Same concept as retrieveAllData function, if we wanted to find the average in the 
	table name called physician in the ssn column then we'll run it as 
	>python3 phase3.py average physician ssn

	If we want to find the average in `procedure` same as retrieveAllData function, don't 
	include the ` ` it is not needed
	>python3 phase3.py procedure cost
	
	It'll output what it is needed; however, this function only works if the table you 
	wanted to find the average in a column. It has to be numeric otherwise it'll barf\throw 
	errors at you. 

Running Insert: 
	physician
	department
	affliatedWith
	procedure
	patient
	nurse
	medication
	prescribes
	room
	stay
	undergoes
	onCall
	appointment
	These are the table names you must follow when typign in 
	>python3 phase3.py insert medication

	Same as above instructions about procedure just type it as it is no ``
	>python3 phase3.py insert procedure

	You'll be displayed how many times you can insert into the table and the output of it before and after insertion


Running Delete: 
	physician
	department
	affliatedWith
	procedure
	patient
	nurse
	medication
	prescribes
	room
	stay
	undergoes
	onCall
	appointment
	These are the table names you must follow when typing out the command line
	> python3 phase3.py delete physician

	You'll be prompted with serious of questions and the format that this will be run is that you just enter what you wish to delete
	Example: 
	You want to delete physicianID = 2
	You'll be prompted with the same question and you just need to enter 
	physicianID = 2
	OR
	if its a string variable you wish to delete like name then it'll be 
	name = "Goku" 
	this was a name of my example, you have to add the " " when its a string variable 


