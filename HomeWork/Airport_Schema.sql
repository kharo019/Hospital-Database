
create table passengers
	(PassID				int,
	 FirstName		varchar(32),
	 LastName		varchar(32),
	 Birthdate	    date,
	 Address		varchar(128),
	 Email			varchar(32),
	 PhoneNumber	char(10),
	 RewardPoints	int,
	 Citizenship	varchar(32),
	 Gender			char(1),
	 primary key (PassID)
	);
create table aircrafts
	(AircraftID				int,
	 Name			varchar(32),
	 NumSeats		int,
	 ManufacturedDate date,
	 LastServiceDate date,
	 primary key (AircraftID)
	);
create table trips
	(TripID				int, 
	 AirCraftID		int, 
	 Capacity		int,
	 DeptTown		varchar(32),
	 DeptDate		date,
	 DeptTime		time,
	 ArrTown		varchar(32),
	 ArrDate		date,
	 ArrTime		time,
	 Fare			float(4,2),
	 primary key (TripID),
	 foreign key (AirCraftID) references aircrafts(AircraftID)
		on delete set null
	);
create table departments
	(DeptID				int, 
	 Name			varchar(32),
	 Category		varchar(32), 
	 primary key (DeptID)
	);
create table staff
	(StaffID				int, 
	 FirstName		varchar(32), 
	 LastName		varchar(32),
	 Birthdate		date,
	 Address		varchar(128),
	 Email			varchar(32),
	 PhoneNumber	char(10),
	 Gender			char(1),
	 Salary			int,
	 DepartmentID	int,
	 HiredDate		date,
	 PositionName		varchar(32),
	 primary key (StaffID),
	 foreign key (DepartmentID) references departments(DeptID)
		on delete set null
	);
create table pilots
	(PilotID				int, 
	 FirstName		varchar(32),
	 LastName		varchar(32), 
	 Birthdate		date,
	 Address		varchar(128),
	 Email			varchar(32),
	 PhoneNumber	char(10),
	 Gender			char(1),
	 Salary			int,
	 HiredDate		date,
	 Rating			int,
	 primary key (PilotID)
	);	

create table booking
	(PassengerID	int,
	 TripID			int,
	 BookDate		date,
	 BookTime		time,
	 primary key (PassengerID, TripID),
	 foreign key (PassengerID) references passengers(PassID)
		on delete cascade,
	 foreign key (TripID) references trips(TripID)
		on delete cascade
	);
create table works
	(StaffID		int,
	 DepartmentID	int,
	 Year			int,
	 primary key (StaffID, DepartmentID),
	 foreign key (StaffID) references staff(StaffID)
		on delete cascade,
	 foreign key (DepartmentID) references departments(DeptID)
		on delete cascade
	);
create table flies
	(PilotID		int,
	 TripID			int,
	 primary key (PilotID, TripID),
	 foreign key (PilotID) references pilots(PilotID)
		on delete cascade,
	 foreign key (TripID) references trips(TripID)
		on delete cascade
	);
create table services
	(ServiceID				int,
	 StaffID		int,
	 Staff2ID		int,
	 AirCraftID		int,
	 ServiceDate	date,
	 Description	varchar(32),
	 primary key (ServiceID),
	 foreign key (StaffID) references staff(StaffID)
		on delete cascade,
	 foreign key (Staff2ID) references staff(StaffID)
		on delete cascade,
	 foreign key (AirCraftID) references aircrafts(AircraftID)
		on delete cascade
	);
