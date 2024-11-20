USE TableTennis;
GO

CREATE TABLE Rankings(
		Rid INT NOT NULL,
		PlayerName VARCHAR(50),
		DateOfRegistration DATE,
	);
CREATE TABLE Rankings1(
		Rid INT NOT NULL,
		PlayerName VARCHAR(50),
		DateOfRegistration DATE,
	);
drop table Rankings1

--modify a column
Create procedure do_proc_1
AS
BEGIN
	ALTER TABLE Exercise
	ALTER COLUMN Duration float NOT NULL 
	PRINT 'Modify in table Exercise the type of the column Duration from INT to FLOAT'
END
go
--modify back a cloumn
Create procedure undo_proc_1
AS
BEGIN
	ALTER TABLE Exercise
	ALTER COLUMN Duration INT 
	PRINT 'Modify back in table Exercise the type of the column Duration from FLOAT to INT'
END
go
--add a new column
Create procedure do_proc_2
AS
BEGIN
	ALTER TABLE Player
	ADD DateOfBirth Date
	SELECT * from Player
	PRINT 'Added column DateOfBirth to table Player'
END
--remove a column
go
--drop procedure undo_proc_2
Create procedure undo_proc_2
AS
BEGIN
	ALTER TABLE Player
	DROP COLUMN DateOFBirth
	SELECT * FROM Player
	PRINT 'Removed column DateOfBirth from table Player'
END
go
--add a default constraint
Create procedure do_proc_3
AS
BEGIN
	ALTER TABLE Rankings
	ADD ClubName VARCHAR(50)
	CONSTRAINT df_u_3 DEFAULT 'Empty'
	PRINT 'Added the column ClubName and added default constraint named df_u_3 to table Rankings'
END
go
--drop procedure undo_proc_3
--remove a default constraint
Create procedure undo_proc_3
AS
BEGIN
	ALTER TABLE Rankings
	DROP CONSTRAINT df_u_3
	ALTER TABLE Rankings
	DROP column ClubName
	PRINT 'Removed default constraint df_u_3 from table Rankings and removed the column ClubName from the same table'
END
--DROP procedure undo_proc_3
go
--add a primary key
Create procedure do_proc_4
AS
BEGIN
	ALTER TABLE Rankings1
	ADD CONSTRAINT pk_Rankings1 PRIMARY KEY(Rid)
	PRINT 'Added primary key pk_Rankings1 to table Rankings1'
END
go
--drop procedure undo_proc_4
--remove a primary key
Create procedure undo_proc_4
AS
BEGIN
	ALTER TABLE Rankings1
	DROP CONSTRAINT pk_Rankings1
	PRINT 'Removed primary key pk_Rankings1 from table Rankings1'
END
go
--add a candidate key
Create procedure do_proc_5
AS
BEGIN
	ALTER TABLE Rankings
	ADD CONSTRAINT uk_Rankings UNIQUE(Rid)
	PRINT 'Added candidate key to Rid from Rankings'
END
go
--drop procedure undo_proc_5
--remove a candidate key
Create procedure undo_proc_5
AS
BEGIN
	ALTER TABLE Rankings
	DROP CONSTRAINT uk_Rankings
	PRINT 'Removed candidate key to Rid from Rankings'
END
go
--add a foreign key
Create procedure do_proc_6
AS
BEGIN
	CREATE TABLE Sponsor(
	Sid int NOT NULL PRIMARY KEY,
	Pid int CONSTRAINT fk_Sponsor_Player FOREIGN KEY(Pid) REFERENCES Player(PlayerId)
	);
	PRINT 'Created table Sponsor with foreign key Pid that references Player(PlayerId)'
END
go
--drop procedure undo_proc_6
--remove a foreign key
Create procedure undo_proc_6
AS
BEGIN
	ALTER TABLE Sponsor
	DROP CONSTRAINT fk_Sponsor_Player;
	DROP TABLE Sponsor
	PRINT 'Removed the foreign key from table Sponsor and removed table Sponsor'
END
go
--DROP procedure undo_proc_6
DROP TABLE Sponsor
--create a table
Create procedure do_proc_7
AS
BEGIN
	CREATE TABLE Rankings2(
		Rid INT NOT NULL PRIMARY KEY,
		PlayerName VARCHAR(50),
		DateOfRegistration DATE,
	);
	PRINT 'Table Rankings2 was created'
END
go
--delete a table
Create procedure undo_proc_7
AS
BEGIN
	DROP TABLE Rankings2
	PRINT 'Table Rankings2 was droped'
END
--drop procedure undo_proc_7
