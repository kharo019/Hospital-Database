##
##
## Name: Kevin Haro
## CS-482
## FileName: insert_db.sql
## Date: 03/07/22
##
##


# Run this code to erase everything of previous data 
SET SQL_SAFE_UPDATES = 0;

delete from Physician;
delete from Department;
delete from AffiliatedWith;
delete from `procedure`;
delete from Patient;
delete from Nurse;
delete from Medication;
delete from Prescribes;
delete from Room;
delete from Stay;
delete from Undergoes;
delete from onCall;
delete from Appointment;


## Display Purposes
select * from physician;
select * from department;
select * from AffliatedWith;
select * from `procedure`;
select * from Patient;
select * from Nurse;
select * from Medication;
select * from Prescribes;
select * from Room;
select * from Stay;
select * from Undergoes;
select * from onCall;
select * from Appointment;


# Insert to Physician
INSERT INTO physician VALUES (100, "George Washington", "Intern", 1111111);
INSERT INTO physician VALUES (101, "Grace Hopper", "Intern", 2222222);
INSERT INTO physician VALUES (102, "Clara Barton", "Senior", 3333333);
INSERT INTO physician VALUES (103, "Joan Crawford", "Senior", 4444444);
INSERT INTO physician VALUES (104, "Pancho Villa", "Surgeon", 5555555);
INSERT INTO physician VALUES (105, "Julius Caesar", "Surgeon", 6666666);
INSERT INTO physician VALUES (106, "Benito Juarez", "Resident", 7777777);
INSERT INTO physician VALUES (107, "Charles Chaplin", "Psychiatrist", 8888888);
INSERT INTO physician VALUES (108, "Emiliano Zapata", "Psychiatrist", 9999999);
INSERT INTO physician VALUES (109, "Miguel Hidalgo", "Chief of Medicine", 1000000);
# Physician (physicianID: integer, name: varchar(40), position: varchar(40), ssn: integer)
# Physician (1, "John Doe", "Surgeon", 11111111)
# Physicians can only have positions 
# "Intern", "Surgeon", "Senior", "Chief of Medicine", "Resident", and "Psychiatrist"


# Insert to Department
INSERT INTO department VALUES (123, "Psychiatry", 107);
INSERT INTO department VALUES (124, "Psychiatry", 108);
INSERT INTO department VALUES (125, "Surgery", 105);
INSERT INTO department VALUES (126, "Surgery", 104);
INSERT INTO department VALUES (130, "General Medicine", 104);
INSERT INTO department VALUES (134, "General Medicine", 100);
INSERT INTO department VALUES (132, "General Medicine", 103);
# Department (deptID: integer, name: varchar(40), headID: integer)
# Foreign key: headID references Physician(physicianID)
# Department (1, "Surgery", 1)
# Departments name can only be "General Medicine", "Surgery", and "Psychiatry".


# Insert to AffiliatedWith
INSERT INTO AffiliatedWith VALUES (107,123);
INSERT INTO AffiliatedWith VALUES (108,124);
INSERT INTO AffiliatedWith VALUES (109,130);
INSERT INTO AffiliatedWith VALUES (109,134);
INSERT INTO AffiliatedWith VALUES (109,132);
INSERT INTO AffiliatedWith VALUES (104,125);
INSERT INTO AffiliatedWith VALUES (105,126);

# AffiliatedWith (physicianID: integer, departmentID: integer)
# Foreign key: physicianID references Physician(physicianID)
# Foreign key: departmentID references Department(deptID)
# AffiliatedWith (1, 1)

# Insert to Procedure
INSERT INTO `procedure`  VALUES (1, "Sergio Ramos", 178000);
INSERT INTO `procedure`  VALUES (2, "David Beckham", 13810);
INSERT INTO `procedure`  VALUES (3, "Roberto Carlos", 3902);
INSERT INTO `procedure`  VALUES (4, "Luis Suarez", 93108);
# Procedure (procID: integer, name: varchar(40), cost: real)


# Insert to Patient - First galactico era 
INSERT INTO Patient VALUES (2000, 6000, "Luis Figo", "200060 Barcelona Avenue", "1972-09-04", "646-123-1234", 123214, 100);
INSERT INTO Patient VALUES (2001, 7350, "Zinedine Zidane", "200735 Juventus Court", "1972-06-23", "646-198-9192", 123785, 100);
INSERT INTO Patient VALUES (2002, 4500, "Ronaldo Luis Nazario De Lima", "200060 InterMilan Street", "1976-09-18", "575-908-7291", 123093, 100);
INSERT INTO Patient VALUES (2003, 3750, "David Beckham", "203375 ManchesterUnited Avenue", "1975-05-02", "426-421-0427", 1832190, 101);
INSERT INTO Patient VALUES (2004, 9000, "Michael Owen", "200490 Liverpool Street", "1979-12-14", "928-293-5291", 892093, 103);
INSERT INTO Patient VALUES (1996, 3500, "Roberto Carlos", "199635 InterMilan Avenue", "1973-04-10", "319-821-0937", 579183, 106);
INSERT INTO Patient VALUES (1999, 4201, "Iker Casillas", "200060 Spain Avenue", "1981-05-20", "283-492-3042", 482013, 107);
INSERT INTO Patient VALUES (2005, 2700, "Sergio Ramos", "200527 Sevilla Court", "1986-03-30", "102-532-3091", 910271, 108);
INSERT INTO Patient VALUES (1989, 1000, "Fernando Hierro", "198910 Valladolid Street", "1968-03-23", "901-290-5731", 581092, 109);
# Patient (patientID: integer, ssn: integer, name: varchar(40), address: varchar(100), dob: date, phone: varchar(16), insuranceNumber: integer, primaryPhysID: integer)
#Foreign key: primaryPhysID references Physician(physicianID)
# Patient (1, 100001, "John Smith", "12 Foo Drive", "1980-01-01", "575-123-1234", 123454, 1)

# Insert to Nurse
INSERT INTO Nurse VALUES (0001, "Mary Breckinridge", "Head Nurse", 11111112);
INSERT INTO Nurse VALUES (0002, "Lillian Wald", "Head Nurse", 22222221);
INSERT INTO Nurse VALUES (0003, "Dorothea Dix", "Head Nurse", 44444443);
INSERT INTO Nurse VALUES (0004, "Florence Wald", "Head Nurse", 55555554);
INSERT INTO Nurse VALUES (0005, "Florence Nightingale", "Nurse", 66666665);
INSERT INTO Nurse VALUES (0006, "Clara Barton", "Nurse", 77777776);
INSERT INTO Nurse VALUES (0007, "Margaret Sanger", "Nurse", 88888887);
INSERT INTO Nurse VALUES (0008, "Elizabeth Grace Neill", "Nurse", 99999998);
INSERT INTO Nurse VALUES (0009, "Mary Eliza Mahoney", "Nurse", 11111119);
# Nurse (nurseID: integer, name: varchar(40), position: varchar(40), ssn: integer
# Nurses can only have positions "Head Nurse" and "Nurse".
# Nurse (1, "Jane Doe", "Head Nurse", 333333)

# Insert to Medication
INSERT INTO Medication VALUES (0001,"Med Alpha");
INSERT INTO Medication VALUES (0002,"Med Beta");
INSERT INTO Medication VALUES (0003,"Med Charlie");
INSERT INTO Medication VALUES (0004,"Med Delta");
INSERT INTO Medication VALUES (0005,"Med Echo");
INSERT INTO Medication VALUES (0006,"Med Foxtrot");
INSERT INTO Medication VALUES (0007,"Med Golf");
INSERT INTO Medication VALUES (0008,"Med Hotel");
# Medication (1, "Med A")


# Insert to Prescribes
INSERT INTO Prescribes VALUES(100,2000,0001,"2022-03-27", "4/day");
INSERT INTO Prescribes VALUES(101,2001,0003,"2022-05-02", "5/day");
INSERT INTO Prescribes VALUES(102,2002,0005,"2022-01-13", "3/day");
INSERT INTO Prescribes VALUES(103,2003,0007,"2022-10-19", "3/day");
INSERT INTO Prescribes VALUES(104,2004,0008,"2022-09-30", "1/day");
# Prescribes (physicianID: integer, patientID: integer, medicationID: integer, prescribedDate: date, dose: varchar(40))
# Foreign key: physicianID references Physician(physicianID)
# Foreign key: patientID references Patient(patientID)
# Foreign key: medicationID references Medication(medID)
# Prescribes (1, 1, 1, "2022-01-15", "5/day")

# Insert to Room
INSERT INTO Room VALUES(1234, "Single");
INSERT INTO Room VALUES(1345, "Single");
INSERT INTO Room VALUES(1456, "Single");
INSERT INTO Room VALUES(1567, "Single");
INSERT INTO Room VALUES(2123, "Double");
INSERT INTO Room VALUES(2234, "Double");
INSERT INTO Room VALUES(2345, "Double");
INSERT INTO Room VALUES(2456, "Double");
INSERT INTO Room VALUES(2567, "Double");
# Room (roomID: integer, roomType: varchar(40))
# Room (1, "Single")

# Insert to Stay
INSERT INTO Stay VALUES(0001,2000, 1234, "2022-11-29", "2022-12-20");
INSERT INTO Stay VALUES(0002,2001, 1345, "2022-01-02", "2022-02-01");
INSERT INTO Stay VALUES(0003,2002, 1456, "2022-04-29", "2022-05-15");
INSERT INTO Stay VALUES(0004,2003, 1567, "2022-01-03", "2022-01-27");
INSERT INTO Stay VALUES(0005,2004, 2123, "2022-07-29", "2022-08-13");
INSERT INTO Stay VALUES(0006,1996, 2234, "2022-10-19", "2022-10-31");
INSERT INTO Stay VALUES(0007,1999, 2345, "2022-03-19", "2022-04-18");
INSERT INTO Stay VALUES(0008,2005, 2456, "2022-10-12", "2022-11-12");
INSERT INTO Stay VALUES(0009,1989, 2567, "2022-12-04", "2022-12-29");
# Stay (stayID: integer, patientID: integer, roomID: integer, startDate: date, endDate: date)
# Foreign key: patientID references Patient(patientID)
# Foreign key: roomID references Room(roomID)
# Stay (1, 1, 1, "2022-01-07", "2022-01-20")



# Insert to Undergoes 
INSERT INTO Undergoes VALUES(2000,1,0001,"2022-03-29",100,0001);
INSERT INTO Undergoes VALUES(2001,2,0002,"2022-10-13",101,0003);
INSERT INTO Undergoes VALUES(2003,3,0003,"2022-01-02",102,0006);
INSERT INTO Undergoes VALUES(2004,4,0004,"2022-05-26",103,0007);
# Undergoes (patientID: integer, procedureID: integer, stayID: integer, procDate: date, physicianID: integer, nurseID: integer)
# Foreign key: patientID references Patient(patientID)
# Foreign key: procedureID references Procedure(procID)
# Foreign key: stayID references Stay(stayID)
# Foreign key: physicianID references Physician(physicianID)
# Foreign key: nurseID references Nurse(nurseID)
# Undergoes (1, 1, 1, "2022-01-10", 1, 1)



# Insert to onCall
INSERT INTO onCall VALUES(0001, "2022-02-04","2022-02-28");
INSERT INTO onCall VALUES(0002, "2022-03-01","2022-03-20");
INSERT INTO onCall VALUES(0003, "2022-03-20","2022-03-30");
INSERT INTO onCall VALUES(0004, "2022-04-04","2022-04-28");
INSERT INTO onCall VALUES(0005, "2022-04-28","2022-05-13");
INSERT INTO onCall VALUES(0006, "2022-05-13","2022-05-31");
INSERT INTO onCall VALUES(0007, "2022-06-01","2022-06-28");
INSERT INTO onCall VALUES(0008, "2022-06-28","2022-07-12");
INSERT INTO onCall VALUES(0009, "2022-07-12","2022-08-30");
# OnCall (1, "2022-01-01", "2022-02-01")
# OnCall (nurseID: integer, startDate: date, endDate: date)
# Foreign key: nurseID references Nurse(nurseID)


# Insert to Appointment
INSERT INTO Appointment VALUES(001,2000,0001, 100,"2022-09-17 12:00","2022-09-17 13:00");
INSERT INTO Appointment VALUES(002,2001,0002, 101,"2022-10-19 9:30","2022-10-19 10:30");
INSERT INTO Appointment VALUES(003,2002,0003, 102,"2022-11-21 15:00","2022-11-21 16:45");
# Appointment (appID: integer, patientID: integer, nurseID: integer, physicianID: integer, startDateTime: datetime, endDateTime: datetime)
# Foreign key: patientID references Patient(patientID)
# Foreign key: nurseID references Nurse(nurseID)
# Foreign key: physicianID references Physician(physicianID)
# Appointment (1, 1, 1, 1, "2021-12-05 14:00", "2021-12-05 15:00")











