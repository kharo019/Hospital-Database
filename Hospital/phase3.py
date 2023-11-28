#
# 
#
#

import mysql.connector
from mysql.connector import Error

import sys

from typing import List

# in the read file include when running on the terminal if they are running it on the mac 
# it must be python3 fileName.py 1 arguments

RED = '\033[91m'
END = '\033[0m'

one_param_message = f"""
                        {RED}Wrong argument count, please pass only one argument,
                        The question number {END}
                    """

two_param_message = f"""
                        {RED}Wrong argument count please pass two arguments,
                        the question number and the query parameters {END}
                    """
three_param_message = f"""
                        {RED}Wrong argument count please pass three arguments,
                        the question number and the query parameters {END}
                    """

# try: # this works well reference 
# 	connection = mysql.connector.connect(
#     	host="localhost",
#     	database="Hospital_Schema",
#     	user="root",
#     	password="" )
# 	# conn = pyodbc.connect(conn_str)
# 	cursor = connection.cursor()
# 	cursor.execute("SELECT * FROM Physician")
# 	for row in cursor:
#     		print(row)
# except Error as e:
# 	print("Error")


# connectioToDatabase takes in the parameters required to connect to a database 
# specifically in mySQL workbench 
# It'll prompt the user from main and pass it to this function 
# it'll either prompt a success message or error message 
def connectionToDatabase(hostName, databaseName,userName,passwordName):
	try:
		connection = mysql.connector.connect(
    		host = hostName,
    		database = databaseName,
    		user = userName,
    		password = passwordName
		)
		print("Connection established with database")

	except Error as err:
		print("Connection to database failed. Error: %s" % err)
	
	return connection

def executionDisplay(connection,input_query:str):
	cursor = connection.cursor()
	ouput = [("NO RESULT",)]

	try:
		cursor.execute(input_query)
		try:
			output = cursor.fetchall()
			num_tables = len(cursor.description)
			table_names = [i[0] for i in cursor.description]
			print(table_names)

		except mysql.connector.InterfaceError:
			print("MySQl Connect")

		connection.commit()
		cursor.close()
	except Error as e:
		print(e)
		print(cursor.statement)
	if type(output) == list and len(output) == 0:
		output = [("NO RESULT",)]
	
	return output


def execution(connection, input_query:str, arguments:list) -> List[tuple]:

	ouput = [("NO RESULT",)]
	cursor = connection.cursor()

	try: 
		cursor.execute(input_query, arguments)
		try: 
			output = cursor.fetchall()
		except mysql.connector.InterfaceError:
			print("MySQl Connect")

		connection.commit() # Remember to add this bad boy back in the future 
		cursor.close()

	except Error as e:
		print(e)
		print(cursor.statement)
	if type(output) == list and len(output) == 0:
		output = [("NO RESULT",)]

	return output


def printResults(output):
	for i in output:
		print(i)
	print("\n")

# To answer the query questions, a function was created for each problem 
# each function will take in the connection to the database access and return 
# the solution data of the query problem 



# Find information about all appointments with physicians affiliated with a given department name. 
# Show the detailed information of each patient along with the detailed information of the physician with whom they have met and the appointment ID. 
# Sample output: As an example, following is the output for the given department name "Surgery":
# patientID: 1, patient_ssn: 100001, patient_name: John Smith, patient_address: 12 Foo Drive, patient_dob: 1980-01-01, 
# patient_phone: 575-123-1234, patient_insuranceNumber: 123454, patient_primaryPhysID: 1, physicianID: 1, physician_name: John Doe, 
# physician_position: Surgeon, physician_ssn: 11111111, appointmentID: 1

def question8(connection, args: List):
	
	assert len(args) == 1, two_param_message

	
	input_query = """

		select P.patientID, P.ssn as patient_ssn, P.name as patient_name, P.address as patient_address,
			P.dob as patient_dob, P.phone as patient_phone, P.insuranceNumber as patient_insuranceNumber,
        	P.primaryPhysID as patient_primaryPhysID, PH.physicianID, PH.name as physician_name, 
			PH.position as physician_position, 
        	PH.ssn as physician_ssn, A.appID as appointmentID 
		from patient P inner join physician PH on P.primaryPhysID = PH.physicianID 
			inner join Appointment A on PH.physicianID = A.physicianID 
		where PH.position = %s;
			
		"""

	results = execution(connection,input_query, args)

	printResults(results)
	
	

# Find all patients that have stayed together in a "Double" room at a given date. For each room ID, show each patient's name and their start and end date of stay.
# Sample output: As an example, following is the output for the given date 2022-01-15 
# (In this example, Dr. Nagarkar was lucky enough to stay with Bruno Mars in the same room).
# Room ID: 1
# Patient: John Doe, Stay Start Date: 2022-01-10, Stay End Date: 2022-01-20
# Patient: Jane Doe, Stay Start Date: 2022-01-14, Stay End Date: 2022-01-16
# Room ID: 2
# Patient: Parth Nagarkar, Stay Start Date: 2022-01-12, Stay End Date: 2022-01-17
# Patient: Bruno Mars, Stay Start Date: 2022-01-15, Stay End Date: 2022-01-15
def question7(connection, args: List):
	
	print("question 7")

	assert len(args) ==1, two_param_message

	input_query = """
	select P.name, S.startDate, S.endDate 
	from Patient P inner join Stay S on P.patientID = S.patientID inner join Room R on S.roomID = R.roomID 
	where R.roomType = "Double" and (%s between S.startDate and S.endDate);
	"""

	results = execution(connection,input_query,args)

	printResults(results)






#Find nurses who have been on call at a given date. Show the detailed information of each nurse and their on call start date and end date.
# Sample output: As an example, following is the output for the given date 2022-01-15:
# nurseID: 1, name: Jane Doe, position: Head Nurse, ssn:3333333, on_call_start_date: 2022-01-01, on_call_end_date: 2022-02-01
def question6(connection, args: List):
	print("question 6")

	assert len(args) == 1, two_param_message

	input_query = """
        select N.nurseID, N.name, N.position, N.ssn, OC.startDate as on_call_start_date, OC.endDate as on_call_end_date
		from nurse N inner join onCall OC on OC.nurseID = N.nurseID
		where %s between OC.startDate and OC.endDate;
    """
	results = execution(connection,input_query,args)

	printResults(results)



# Find information about a prescribed medication name. Show the patients name, physicians names, and the prescribed dates. 
# Sample output: As an example, following is the output for the given medication name "Med A":
# patient_name: John Smith, physician_name: John Doe, prescribed_date: 2022-01-15
def question5(connection, args: List):
	print("question 5")

	# NEEDS FIXING FOR MEDICATION PART SO SEE IF WE CAN ACCEPT MORE THAN TWO PARAMETERS!!!!
	#assert len(args) == 1, two_param_message
	
	input_query = """
        select PA.name as patient_name, PH.name as physician_name, PR.prescribedDate as prescribed_date
		from Medication M inner join Prescribes PR on M.medID = PR.medicationID 
				inner join Patient PA on PA.patientID = PR.patientID 
				inner join physician PH on PH.physicianID = PR.physicianID
		where M.name = %s;
    	"""
	
	results = execution(connection,input_query, args)

	printResults(results)


# Find the patients that their primary physician is the head of a given department name. Show the detailed information of each patient. 
# Sample output: As an example, following is the output for the given department "Surgery":
# patientID: 1, ssn: 100001, name: John Smith, address: 12 Foo Drive, dob: 1980-01-01, phone: 575-123-1234, insuranceNumber: 123454, primaryPhysID: 1
def question4(connection, args: List):
	print("question 4")

	assert len(args) == 1, two_param_message

	input_query = """""
		select P.patientID, P.ssn, P.name, P.address, P.dob, P.phone, P.insuranceNumber, P.primaryPhysID 
		from patient P inner join Physician PH on P.primaryPhysID = PH.physicianID inner join department D on PH.physicianID = D.headID
		where PH.position = %s;
	"""

	results = execution (connection,input_query, args)

	printResults(results)



# Find the patients that have undergone a procedure with a cost larger than a given cost. Show the detailed information of each patient. 
# Sample output: As an example, following is the output for the given cost 500.00:
# patientID: 1, ssn: 100001, name: John Smith, address: 12 Foo Drive, dob: 1980-01-01, phone: 575-123-1234, insuranceNumber: 123454, primaryPhysID: 1
def question3(connection, args: List):
	print("question3")

	input_query = """""
		select P.patientID, P.ssn, P.name, P.address, P.dob, P.phone, P.insuranceNumber, P.primaryPhysID 
		from patient P inner join `procedure` PR on PR.name = P.name
		where PR.cost > %s;
	"""

	results = execution(connection,input_query, args)

	printResults(results)




# Find appointments where a patient met with a physician other than their primary physician.
# Show patient name, physician name, nurse name, start and end datetime of appointment, and the name of the patient's primary physician.
# Sample output: As an example, following is the output:
# patient_name: John Smith, physician_name: John Doe, nurse_name: Jane Doe, start_datetime: 2021-12-05 14:00, end_datetime: 2021-12-05 15:00, 
# primary_physician: John Doe
def question2(connection,args: List):

	assert len(args) == 0, one_param_message
	
	print("question 2 ")

	input_query = """
        select P.name as patient_name, PH.name as physician_name, N.name as nurse_name,
				A.startDateTime, A.endDateTime, physician.name as primary_physician
		from Appointment A inner join Patient P on A.patientID = P.patientID
				inner join Physician PH on A.physicianID = PH.physicianID 
   				inner join Nurse N on A.nurseID = N.nurseID inner join Physician on physician.physicianID = P.primaryPhysID
		where P.primaryPhysID != PH.physicianID;

    	"""
	results = execution(connection,input_query,())
	printResults(results)


# Find physicians that have performed a given procedure name. Show the detailed information of each physician. 
# Sample output: As an example, following is the output for the given procedure name "Proc A":
# physicianID: 1, name: John Doe, position: Surgeon, ssn: 11111111
def question1(connection, arguments: List):
	
	assert len(arguments) == 1, two_param_message
	print("question1")

	input_query = """
        select P.physicianID, P.name, P.position, P.ssn
		from physician P inner join department D on D.headID = P.physicianID
		where D.name = %s;
    	"""


	results = execution(connection,input_query, arguments)
	printResults(results)


def retrieveAllData(connection, arguments: List):
	assert len(arguments) == 1, two_param_message
	print("\n")
	print("retrieveAllData")

	# print(input_query + ' '.join(arguments))
	# arguments is this -> fruits = ['banana', 'apple', 'plum', 'pineapple', 'cherry']
	# mystr = 'i like the following fruits: '
	# print (mystr + ', '.join(fruits))
	#print(arguments)
	#print("select * from " + arguments)

	if arguments[0] == 'procedure':		
		input_query = """select * from `procedure`;"""
		print("\n")
		print(input_query)
		print("\n")
		results = executionDisplay(connection,input_query)
		printResults(results)
	
	else:
		input_query = "select * from " + " ".join(arguments)
		print("\n")
		print(input_query)
		print("\n")
		results = executionDisplay(connection,input_query)
		printResults(results)
		


def average(connection, arguments: List):
	assert len(arguments) == 2, two_param_message
	print("\n")
	print("Average")


	table_name = arguments[0]
	aggregateFunction = arguments[1]

	if table_name == 'procedure':
		input_query = "select avg(`procedure`." + aggregateFunction + ") from `procedure`"
		print("\n")
		print(input_query)
		print("\n")
		results = executionDisplay(connection,input_query)
		printResults(results)	
	else:
		input_query = "select avg(" + table_name + "." + aggregateFunction + ") from " + table_name
		print("\n")
		print(input_query)
		print("\n")
		results = executionDisplay(connection,input_query)
		printResults(results)
	# select avg(physician.ssn)
	#from physician
	#print(input_query)

def insertion(connection, arguments: List):

	print("\n")
	print("Insertion in progress")

	table_name = arguments[0]
	print(table_name)

	if(table_name == "procedure"):
		input_query = " select * from `procedure`"
	else:
		input_query = "select * from " + table_name

	print("\nYou'll be inserting data into table: " + table_name)
	print("The column names and data to " + table_name + " are:\n")
	results = executionDisplay(connection,input_query)
	printResults(results)


	cursor = connection.cursor()

	try:
		cursor.execute(input_query)
		output = cursor.fetchall()
		num_tables = len(cursor.description)
		table_names = [i[0] for i in cursor.description]
		print(table_names)

		totalTables = int(num_tables)
		print("The total number of values you can insert into table " + table_name + " is ")
		print(totalTables)


		if(table_name == "physician"):
			print("\nPhysician Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1] 
			third = values[2]
			fourth = values[3]

			test = 'Insert into physician values({}, \"{}\", \"{}\", {});'.format(first, second, third, fourth)
			print(test)
		
			#mySQLquery = "INSERT INTO physician VALUES (" + first + "," + second + "," + third + "," + fourth + ");"

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)

		elif(table_name == "department"):
			print("\nDepartment Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1] 
			third = values[2]

			test = 'Insert into {} values({}, \"{}\", {});'.format(table_name,first, second, third)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)

		elif(table_name == "affiliatedWith"):
			print("\nAffiliatedWith Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1] 

			test = 'Insert into {} values({}, {});'.format(table_name,first, second)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)

		elif(table_name == "procedure"):
			print("\nProcedure Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#input_query = "select avg(`procedure`." + aggregateFunction + ") from `procedure`"		
			first = values[0]
			second = values[1] 
			third = values[2]

			test = 'Insert into `procedure` values({}, \"{}\", {});'.format(first, second, third)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from `procedure`"
			results = executionDisplay(connection,input_query)
			printResults(results)

		elif(table_name == "patient"):
			print("\nPatient Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1]
			third = values[2]
			fourth = values[3]
			fifth = values[4]
			sixth = values[5]
			seventh = values[6]
			eightth = values[7]

			test = 'Insert into {} values({}, {}, \"{}\", \"{}\", \"{}\", \"{}\", {}, {});'.format(table_name,first, second, third, fourth, fifth, sixth, seventh, eightth)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)
		
		elif(table_name == "nurse"):
			print("\nNurse Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1] 
			third = values[2]
			fourth = values[3]

			test = 'Insert into {} values({}, \"{}\", \"{}\", {});'.format(table_name, first, second, third, fourth)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)
		
		elif(table_name == "medication"):
			print("\nMedication Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			first = values[0]
			second = values[1] 

			test = 'Insert into {} values({}, \"{}\");'.format(table_name, first, second)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)
		
		elif(table_name == "prescribes"):
			print("\nPrescribes Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1] 
			third = values[2]
			fourth = values[3]
			fifth = values[4]

			test = 'Insert into {} values({}, {}, {}, \"{}\", \"{}\");'.format(table_name,first, second, third, fourth, fifth)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)
		
		elif(table_name == "room"):
			print("\nRoom Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1] 

			test = 'Insert into {} values({}, \"{}\");'.format(table_name,first, second)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)
		
		elif(table_name == "stay"):
			print("\nStay Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1] 
			three = values[2]
			fourth = values[3]
			fifth = values[4]

			test = 'Insert into {} values({}, {}, {}, \"{}\", \"{}\");'.format(table_name,first, second, three, fourth, fifth)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)

		elif(table_name == "undergoes"):
			print("\nUndergoes Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1] 
			three = values[2]
			fourth = values[3]
			fifth = values[4]
			sixth = values[5]

			test = 'Insert into {} values({}, {}, {}, \"{}\", {}, {});'.format(table_name,first, second, three, fourth, fifth, sixth)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)

		elif(table_name == "onCall"):
			print("\nonCall Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1] 
			three = values[2]

			test = 'Insert into {} values({}, \"{}\", \"{}\");'.format(table_name, first, second, three)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)
		
		elif(table_name == "appointment"):
			print("\Appointment Insertion\n")
			values = []

			for i in range(0,totalTables):
				inputUser = input("Enter the values you want to insert into " + table_name + " separated by enter\n")
				values.insert(i,inputUser)
		
			print("\n")

			#values = list(values)
		
			first = values[0]
			second = values[1] 
			third = values[2]
			fourth = values[3]
			fifth = values[4]
			sixth = values[5]

			test = 'Insert into {} values({}, {}, {}, {}, \"{}\", \"{}\");'.format(table_name,first, second, third, fourth, fifth, sixth)
			print(test)

			cursor.execute(test)
			print("Insertion Completed")
			print("Display Purposes")
			input_query = "select * from " + table_name
			results = executionDisplay(connection,input_query)
			printResults(results)

		else:
			print("Table is unknown!")

	
		
		cursor.close()

	except Error as e:
		print(e)
		print(cursor.statement)
	if type(output) == list and len(output) == 0:
		print[("NO RESULT",)]

def delete(connection, arguments: List):
		print("Delete")
		print("\n")
		print("Delete in progress")

		table_name = arguments[0]
		print(table_name)

		if(table_name == "procedure"):
			input_query = "select * from `procedure`"
		else:
			input_query = "select * from " + table_name

		print("\nYou'll be deleting data from table: " + table_name)
		print("The column names and data to " + table_name + " are:\n")
		results = executionDisplay(connection,input_query)
		printResults(results)


		cursor = connection.cursor()

		try:
			cursor.execute(input_query)
			output = cursor.fetchall()
			num_tables = len(cursor.description)
			table_names = [i[0] for i in cursor.description]
			print(table_names)

			totalTables = int(num_tables)
			#print("The total number of values you can insert into table " + table_name + " is ")
			#print(totalTables)


			if(table_name == "physician"):
				print("\nPhysician Deletion\n")

				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)

			elif(table_name == "department"):
				print("\nDepartment Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)
			
			elif(table_name == "affiliatedWith"):
				print("\naffiliatedWith Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)
			
			elif(table_name == "procedure"):
				print("\nProcedure Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from `procedure` where ...")
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from `procedure` where {};'.format(inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from `procedure`" 
				results = executionDisplay(connection,input_query)
				printResults(results)
			

			elif(table_name == "patient"):
				print("\nPatient Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)


			elif(table_name == "nurse"):
				print("\nNurse Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)


			elif(table_name == "medication"):
				print("\nMedication Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)

			
			elif(table_name == "prescribes"):
				print("\nPrescribes Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)

			elif(table_name == "room"):
				print("\nRoom Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)

			elif(table_name == "stay"):
				print("\nStay Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)

			elif(table_name == "undergoes"):
				print("\nUndergoes Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)


			elif(table_name == "onCall"):
				print("\nonCall Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)

			elif(table_name == "appointment"):
				print("\nAppointment Deletion\n")
				
				print("The deletion will be performed on the where clause for: " + table_name)
				print("Delete from %s where ..." %table_name)
				inputUser = input("What would you like to delete from " + table_name + "?\n")
				print("\n")



				test = 'Delete from {} where {};'.format(table_name, inputUser)
				print(test)

				cursor.execute(test)
				print("Deletion Completed")
				print("Display Purposes")
				input_query = "select * from " + table_name
				results = executionDisplay(connection,input_query)
				printResults(results)



		except Error as e:
			print(e)
			print(cursor.statement)
		if type(output) == list and len(output) == 0:
			print[("NO RESULT",)]


		#hostName = input ("By default, the host is 'localhost':")
		#print("INSERT INTO physician VALUES (100, "George Washington", "Intern", 1111111);")


	# -5: Query 1 is wrong and is not the answer to question 1.
	# -5: Query 4 is wrong and not outputting any results.
	# -5: Query 8 is wrong and not outputting any results.

	# when inputting data put it in a fstring and insert 
	# integer execute 


# When python proj.py 1 <procedure_name> is ran
# the first argument will be the questionNumber args that'll recognize what number
# of question it is expecting
questionNum = {
	"1": question1,
	"2": question2,
	"3": question3,
	"4": question4,
	"5": question5,
	"6": question6,
	"7": question7,
	"8": question8,
	"retrieveAllData": retrieveAllData,
	"average": average,
	"insert": insertion,
	"delete": delete,
}





# main function to call other functions to connect to databases 
# 
def main():

	print("\nEnter the name of your host:")


	hostName = input ("By default, the host is 'localhost':")
	databaseName = input("\nEnter the database name: ")
	userName = input("\nEnter the user name: ")
	passwordName = input("\nEnter your password: ")

	connection = connectionToDatabase(hostName,databaseName,userName,passwordName)

	print("\nConnection to database is established\n")

	queryNumber = sys.argv[1]
	arguments = sys.argv[2:]

	print("Solution to the query number " + queryNumber)

	try: 
		questionNum[queryNumber](connection, arguments)
		try:
			questionNum[queryNumber](connection)
		except:
			print("Printing Completed\n")
	except:
		print("Unidenitified question number " + queryNumber)
		print("Or other unknown error occurred")


# Without this line of code, main will never be run and will just compile the script
if __name__ == "__main__":
    main()



