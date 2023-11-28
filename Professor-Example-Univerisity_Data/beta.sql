#
#
# EXAM QUESTION - 5 POINTS 
#
# Example of Attribute Set Clause Slide - Chapter 8 Powerpoint
# There exists # combinations - it depends
# 
# The length of the candidate keys is 2 or 3 
# R = (A,B,C,G,H,I)
# if 3 then it'll be ABC,ACG,AGH,AHI,BCG,GHI 
# if 2 then it'll be AB,AC,AG,AH,AI,BC,BG,BH,BI,CG,GH,HI,



# What is not following BCNF ask yourself this when doing these questions!!!!!

#
#
# Exam Question 
# Boyce-Codd Normal (BCNF) Slide 31 
# Is value alpha(b) to beta 


##
# Exam Question 
# Decomposig a Schema into BCNF Slide 33 
#

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


select P.physicianID, P.name, P.position, P.ssn
select *
from physician P inner join department D on D.headID = P.physicianID 


select P.patientID, P.ssn, P.name, P.address, P.dob, P.phone, P.insuranceNumber, P.primaryPhysID 
		from patient P inner join Physician PH on P.primaryPhysID = PH.physicianID inner join department D on PH.physicianID = D.headID
		where PH.position = "Intern";
        
        
        
# Find information about all appointments with physicians affiliated with a given department name. 
# Show the detailed information of each patient along with the detailed information of the physician with whom they have met and the appointment ID. 
# Sample output: As an example, following is the output for the given department name "Surgery":
# patientID: 1, patient_ssn: 100001, patient_name: John Smith, patient_address: 12 Foo Drive, patient_dob: 1980-01-01, 
# patient_phone: 575-123-1234, patient_insuranceNumber: 123454, patient_primaryPhysID: 1, physicianID: 1, physician_name: John Doe, 
# physician_position: Surgeon, physician_ssn: 11111111, appointmentID: 1


select P.patientID, P.ssn as patient_ssn, P.name as patient_name, P.address as patient_address,
		P.dob as patient_dob, P.phone as patient_phone, P.insuranceNumber as patient_insuranceNumber,
		P.primaryPhysID as patient_primaryPhysID, PH.physicianID, PH.name as physician_name, 
        PH.position as physician_position, PH.ssn as physician_ssn, A.appID as appointmentID 
from patient P inner join physician PH on P.primaryPhysID = PH.physicianID 
		inner join Appointment A on PH.physicianID = A.physicianID 
where PH.position = "Surgery";
			
		


