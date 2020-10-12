USE mydb;

INSERT INTO User (firstName,lastName,email,number,createAt,updateAt) 
VALUES ("Script","Script","script@script.script","script_number",NOW(),NOW());

UPDATE User
SET firstName='Script2', lastName='Script2'
WHERE firstName="Script";

INSERT INTO Subcription (title,description,price,createAt,updateAt) 
VALUES ("Script","Script","0",NOW(),NOW());

INSERT INTO UserSubscribtion (startAt,expiresAt,createAt,updateAt,idSub,idUserSub) 
VALUES (NOW(),NOW(),NOW(),NOW(),3,21);

INSERT INTO Scooter (needCharge,needRepair) 
VALUES (0,0);
INSERT INTO Scooter (needCharge,needRepair) 
VALUES (0,1);
INSERT INTO Scooter (needCharge,needRepair) 
VALUES (1,0);


INSERT INTO Rental (startAt,endAt,price,idUserRental,idScooterRental) 
VALUES (NOW(),NULL,10 ,21,21);

UPDATE Rental
SET endAt=NOW()
WHERE idRental=6;


UPDATE Scooter 
SET needRepair=1 
WHERE idScooter=21;


INSERT INTO Worker (firstName,lastName,email,number,createAt,updateAt) 
VALUES ("Script","Script","script@script.script","script_number",NOW(),NOW());


INSERT INTO Repair (dateRepair,startAt,endAT,idScooterRepair,idWorkerRepair) 
VALUES (NOW(),NOW(),NULL,21,6);

UPDATE Repair
SET endAt=NOW()
WHERE idRepair=6;
