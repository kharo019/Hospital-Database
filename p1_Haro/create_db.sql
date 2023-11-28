##
##
## Name: Kevin Haro
## CS-482
## FileName: create_db.sql
## Date: 03/07/22
## 
## Since PhysicianID and deptID are primary keys, "on delete set null"
## will not work in the AffiliatedWith table and "on delete cascade" should be used instead.
##
select * from physician;
select * from mediciation;
select * from `procedure`;


drop table Physician;
drop table Department;
drop table AffiliatedWith;
drop table `procedure`;
drop table patient;
drop table nurse;
drop table mediciation;
drop table prescribes;
drop table room;
drop table stay;
drop table Undergoes;
drop table onCall;
drop table appointment; 

delete from Physician;
delete from Department;
delete from AffiliatedWith;
delete from `procedure`;
delete from patient;
delete from nurse;
delete from mediciation;
delete from prescribes;
delete from room;
delete from stay;
delete from Undergoes;
delete from onCall;
delete from appointment; 


# 1
create table Physician(
	physicianID		integer,
    `name` 			varchar(40), 
    `position`		varchar(40),
    ssn				integer,
    
    primary key (physicianID),

    check(`position` in ('Intern', 'Surgeon','Senior','Chief of Medicine','Resident','Psychiatrist'))
);


# 2
create table Department(
	deptID			integer,
    `name`			varchar(40),
    headID			integer,
    
    primary key	(deptID),
    
    check(`name` in ('General Medicine', 'Surgery','Psychiatry')),
    
    foreign key (headID) references Physician(physicianID) on delete cascade
);


# 3
create table AffiliatedWith(
	physicianID		integer,
    departmentID	integer,
    
    primary key (physicianID, departmentID),
    
    foreign key (physicianID) references Physician(physicianID) on delete cascade,
    foreign key (departmentID) references Department(deptID) on delete cascade
);
  
  # 4
create table `procedure`(
	procID			integer,
    `name`			varchar(40),
    cost			real,
    
    primary key (procID)
);

# 5
create table Patient(
	patientID			integer, 
    ssn					integer,
    `name`				varchar(40),
    address 			varchar(100),
    dob					date,
    phone				varchar(16),
    insuranceNumber 	integer,
    primaryPhysID		integer,
    
	primary key(patientID),
    
    foreign key (primaryPhysID) references Physician(physicianID) on delete cascade
);

# 6
create table Nurse(
	nurseID				integer,
    `name`				varchar(40),
    `position`			varchar(40),
    ssn					integer,
    
    primary key(nurseID),
    
    check(`position` in ('Head Nurse','Nurse'))
);

# 7
create table Medication(
	medID				integer,
    `name`				varchar(40),
    
    primary key(medID)
);

# 8
create table Prescribes(
	physicianID			integer,
    patientID			integer,
    medicationID		integer,
    prescribedDate		date,
    dose				varchar(40),
    
    primary key(physicianID, patientID, medicationID, prescribedDate),
    
    foreign key(physicianID) references Physician(physicianID) on delete cascade,
    foreign key(patientID) references Patient(patientID) on delete cascade,
    foreign key(medicationID) references Medication(medID) on delete cascade
);

# 9 
create table Room(
	roomID				integer,
    roomType			varchar(40),
    
    primary key(roomID),
    
    check(`roomType` in ('Single','Double'))
);

# 10 
create table Stay(
	stayID				integer,
    patientID			integer,
    roomID				integer,
    startDate			date,
    endDate				date,
    
    primary key(stayID),
    
    foreign key(patientID) references Patient(patientID) on delete set null,
    foreign key(roomID) references Room(roomID) on delete set null
);

# 11 
create table Undergoes(
	patientID			integer,
    procedureID			integer,
    stayID				integer,
    procDate			date,
    physicianID			integer,
    nurseID				integer,
    
    primary key(patientID, procedureID, stayID, procDate),
    
    foreign key(patientID) references Patient(patientID),
	foreign key(procedureID) references `Procedure`(procID),   
    foreign key(stayID) references Stay(stayID),
    foreign key(physicianID) references Physician(physicianID),
    foreign key(nurseID) references Nurse(nurseID)
);

# 12 
create table onCall(
	nurseID				integer,
    startDate			date,
    endDate				date,
    
    primary key(nurseID, startDate, endDate),
    
    foreign key(nurseID) references Nurse(nurseID)
);

# 13
create table Appointment(
	appID				integer,
    patientID			integer,
    nurseID				integer,
    physicianID			integer,
    startDateTime		datetime,
    endDateTie			datetime,
    
    primary key(appID),
    
    foreign key(patientID) references Patient(patientID) on delete set null,
    foreign key(nurseID) references Nurse(nurseID) on delete set null,
    foreign key(physicianID) references Physician(physicianID) on delete set null
);

