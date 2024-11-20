CREATE DATABASE TableTennis;
GO

USE TableTennis;
GO

DROP TABLE Paddle;
DROP TABLE Training;
DROP TABLE Player;
DROP TABLE Matchday;
DROP TABLE Coach;
DROP TABLE Meci;
DROP TABLE Tournament;
DROP TABLE ClubTeam;		
DROP TABLE StyleOfPlay;
DROP TABLE Exercise;
DROP TABLE ClubTeam_Player;
GO

CREATE TABLE StyleOfPlay 
(
    StyleId INT PRIMARY KEY,
    Attack INT,
    Defense INT,
);

CREATE TABLE Player
(
    PlayerId INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
	StyleId INT FOREIGN KEY REFERENCES StyleOfPlay(StyleId) ON DELETE SET NULL
);

CREATE TABLE Paddle
(
    PaddleId INT PRIMARY KEY,
    PlayerId INT FOREIGN KEY REFERENCES Player(PlayerId) ON DELETE CASCADE,
    Name VARCHAR(50),
	Price DECIMAL(8,2)
);

CREATE TABLE Coach
(
    CoachId INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(50),
    Phone VARCHAR(15)
);

CREATE TABLE Training
(
    PlayerId INT FOREIGN KEY REFERENCES Player(PlayerId) ON DELETE CASCADE,
    CoachId INT FOREIGN KEY REFERENCES Coach(CoachId) ON DELETE CASCADE,
    Duration INT,
    PRIMARY KEY (PlayerId, CoachId)
);

CREATE TABLE Exercise
(
    ExerciseId INT,
    Duration INT,
    PlayerId INT FOREIGN KEY REFERENCES Player(PlayerId) ON DELETE CASCADE
);

CREATE TABLE Matchday
(
    MatchdayId INT PRIMARY KEY ,
    Location VARCHAR(50),
	MatchdayDate DATE,
);

CREATE TABLE Meci
(
    MatchId INT PRIMARY KEY,
    Player1Id INT FOREIGN KEY REFERENCES Player(PlayerId) ON DELETE CASCADE,
    Player2Id INT,
    RefereeName VARCHAR(50),
	MatchdayId INT FOREIGN KEY REFERENCES Matchday(MatchdayId) ON DELETE CASCADE,
);

CREATE TABLE Tournament
(
    TournamentId INT PRIMARY KEY,
    NrOfPlayers INT,
    Winner VARCHAR(50),
    Venue VARCHAR(50),
    MatchdayId INT FOREIGN KEY REFERENCES Matchday(MatchdayId) ON DELETE CASCADE
);

CREATE TABLE ClubTeam
(
    ClubTeamId INT PRIMARY KEY,
    Name VARCHAR(50),
    NrOfPlayers INT
);

CREATE TABLE ClubTeam_Player
(
    ClubTeamId INT FOREIGN KEY REFERENCES ClubTeam(ClubTeamId) ON DELETE CASCADE,
    PlayerId INT FOREIGN KEY REFERENCES Player(PlayerId) ON DELETE CASCADE,
    PRIMARY KEY (ClubTeamId, PlayerId)
);
--inserts:
--insert in StyleOfPlay
INSERT INTO StyleOfPlay(StyleId,Attack,Defense) VALUES (1,45,85),(2,100,30),(3,55,65)
INSERT INTO StyleOfPlay(StyleId,Attack,Defense) VALUES (4,90,65),(5,81,92),(6,69,97)
SELECT * FROM StyleOfPlay

--insert in Player
INSERT INTO Player(PlayerId,Name,Age,StyleId) VALUES (1,'Fan Zhendong',27,2),(2,'Alexis Lebrun',17,2)
INSERT INTO Player(PlayerId,Name,Age,StyleId) VALUES (3,'Ovidiu Ionescu',31,2),(4,'Tomokhazu Harimoto',19,1),(5,'Darko Jorgic',25,2),(6,'Dang Qiu',23,3)
INSERT INTO Player(PlayerId,Name,Age,StyleId) VALUES (7,'Bernaddete Szocs',28,5),(8,'Elizabeta Samara',32,6),(9,'Miwa Harimoto',17,2)
--statement that violates referential integrity constraint:
INSERT INTO Player(PlayerId,Name,Age,StyleId) VALUES (20,'Pletea Cristian',24,12)
SELECT * FROM Player

--insert Coach
INSERT INTO Coach(CoachId,FirstName,LastName,Email,Phone) VALUES (1,'Ove-Waldner','Jan','janovewaldner@yahoo.com','0332597442'), (2,'Puie','Victor','puievictor@gmail.com','0762396447')
INSERT INTO Coach(CoachId,FirstName,LastName,Email,Phone) VALUES (3,'Chao','Shedong','chaosed@hotmail.com','0394418622'),(4,'Filimon','Bogdan','filimonbogdi@gmail.com','0763298117')
SELECT * FROM Coach

--insert Matchday
INSERT INTO Matchday(MatchdayId,Location,MatchdayDate) VALUES (1,'Montpellier','2024-10-18'),(2,'Almaty','2024-11-02'),(3,'Chengdu','2024-12-20')
INSERT INTO Matchday(MatchdayId,Location,MatchdayDate) VALUES (4,'Belgrade','2025-02-09'),(5,'Houston','2025-01-13')
SELECT * FROM Matchday

--insert Meci
INSERT INTO Meci(MatchId,Player1Id,Player2Id,RefereeName,MatchdayId) VALUES (1,4,5,'Gardos Robert',1),(2,1,2,'Zao Chan',3)
INSERT INTO Meci(MatchId,Player1Id,Player2Id,RefereeName,MatchdayId) VALUES (3,8,9,'Tamil Akantara',3)
INSERT INTO Meci(MatchId,Player1Id,Player2Id,RefereeName,MatchdayId) VALUES (4,2,6,'Gardos Robert',2)
SELECT * FROM Meci
SELECT * FROM Matchday

--insert ClubTeam
INSERT INTO ClubTeam(ClubTeamId,NrOfPlayers,Name) VALUES (1,3,'Fortuna Dusselforf'),(2,3,'Neu Ulm'),(3,2,'ACSS Montpellier'),(4,4,'CSA Steaua Bcuresti')
SELECT * from ClubTeam

--insert ClubTeam_Player
INSERT INTO ClubTeam_Player(ClubTeamId,PlayerId) VALUES (4,1),(3,2),(4,3),(2,5),(2,6)
SELECT * from ClubTeam_Player

--insert Training
INSERT INTO Training(CoachId,PlayerId,Duration) VALUES (1,1,2),(1,3,4),(2,2,3)
INSERT INTO Training(CoachId,PlayerId,Duration) VALUES (4,7,3),(3,5,2),(2,8,1)
SELECT * from Training

--insert Exercise
INSERT INTO Exercise(PlayerId,ExerciseId,Duration) VALUES(1,1,20),(2,1,20),(9,2,40),(6,3,5)
INSERT INTO Exercise(PlayerId,ExerciseId,Duration) VALUES(9,4,20)
SELECT * from Exercise

--insert Paddle
INSERT INTO Paddle(PaddleId,PlayerId,Price,Name) VALUES (1,1,500,'Garaydia ZLC'),(2,1,700,'Ultimate ALC')
INSERT INTO Paddle(PaddleId,PlayerId,Price,Name) VALUES (3,6,500,'Garaydia ZLC')
SELECT * from Paddle

--insert Tournament
INSERT INTO Tournament(TournamentId,MatchdayId,NrOfPlayers,Venue,Winner) VALUES (1,1,64,'Belgrade','Fan Zhendong'),(2,1,32,'Almaty','Kiril Gerassimenko')
SELECT * from Tournament

--updates:
UPDATE Player
SET StyleId = 1
WHERE Name = 'Fan Zhendong'

UPDATE Matchday
SET MatchdayDate = '2024-10-21'
WHERE Location = 'Montpellier'

UPDATE Coach
SET Email = 'janow@yahoo.com'
WHERE Phone = '0332597442'

UPDATE Paddle
SET Price = 800
WHERE Name = 'Garaydia ZLC'

--deletes:
DELETE
FROM StyleOfPlay
WHERE Attack = 45

DELETE
FROM Matchday
WHERE Location = 'Belgrade'

--custom updates/deletes:
UPDATE Matchday
SET Location = 'Bucharest'
WHERE MatchdayDate NOT BETWEEN '2024-12-15' AND '2025-01-15'

DELETE
FROM Player
WHERE Age >= 26 OR StyleId = 6 AND Name IS NOT NULL

--queries:
--a. 2 queries with the union operation
--the players that have the name starting with D and has at least 2 letters OR have the age >= 24
SELECT *
FROM Player
WHERE Name like 'D_%'
UNION
SELECT *
FROM Player
WHERE Age >=24
--OR
SELECT * 
FROM Player 
WHERE Name like 'D_%' OR Age >=24

--all the players that have the name starting with D and have at least 2 letters or players that have the StyleId 2 or 5, order by name 
SELECT p1.Name
FROM Player p1
WHERE Name like 'D_%'
UNION ALL
SELECT p2.Name
FROM Player p2
WHERE StyleId = 5 OR StyleId = 2
ORDER BY p1.Name
--OR
SELECT p.Name
FROM Player p
WHERE Name like 'D_%' OR StyleId = 5 OR StyleId = 2
ORDER BY p.Name

--b.2 queries withe the intersection operation; use INTERSECT and IN;
-- the players that have the name starting with D and the age smaller or equal to 25
SELECT p1.Name
FROM Player p1
WHERE Name like 'D_%'
INTERSECT --AND
SELECT p2.Name
FROM Player p2
WHERE Age<=25
ORDER BY p1.Name

select * from Player

-- find the name of players who play for the club with ClubTeamId 4
SELECT p.Name
FROM Player p
WHERE p.PlayerId IN
	( SELECT c.PlayerId
	  FROM ClubTeam_Player c
	  WHERE c.ClubTeamId = 4 
	)

select * from ClubTeam_Player

--c. 2 queries with the difference operation; use EXCEPT and NOT IN 
-- the players that have the name starting with D and has at leaast 2 letters BUT NOT have the age smaller or equal than 22 
SELECT p1.Name
FROM Player p1
WHERE Name like 'D_%'
EXCEPT -- IN first NOT IN second
SELECT p2.Name
FROM Player p2
WHERE Age <=22
ORDER BY p1.Name

--find the name of the players who DO NOT play for the club with ClubTeamId 4
SELECT p.Name
FROM Player p
WHERE p.PlayerId NOT IN
(
	SELECT C.PlayerId
	FROM ClubTeam_Player C
	WHERE C.ClubTeamId = 4
)

--joins:
--d.
--two queries with m:n relationship - (Player, Coach, Training) + (Player, ClubTeam_Player, ClubTeam)
SELECT P.PlayerId
FROM Player P INNER JOIN Training T ON P.PlayerId=T.PlayerId
INNER JOIN Coach C ON C.CoachId=T.CoachId
INNER JOIN ClubTeam_Player CTP ON P.PlayerId=CTP.PlayerId
INNER JOIN ClubTeam CT ON CTP.ClubTeamId=CT.ClubTeamId


--one query with 3 tables involved

SELECT P.PlayerId, M.Player1Id
FROM Player P LEFT OUTER JOIN Meci M ON P.PlayerId = M.Player1Id
INNER JOIN Matchday MD on MD.MatchdayId = M.MatchdayId

--two extra queries

SELECT P.StyleId, SP.StyleId
FROM Player P FULL OUTER JOIN StyleOfPlay SP ON P.StyleId = SP.StyleId

SELECT C.CoachId, T.CoachId
FROM Coach C RIGHT OUTER JOIN Training T ON T.CoachId = C.CoachId

--e. 2 queries using the IN operator to introduce a subquery in the WHERE clause; in at least one query,
-- the subquery should include a subquery in its own WHERE clause;

-- the club teams with the players that have the age over 25
SELECT p.PlayerId, p.Age
FROM Player p
WHERE Age > 25 and p.PlayerId IN (SELECT ctp.PlayerId FROM ClubTeam_Player ctp) 

-- the players that play a match and are part of a club team
SELECT p.PlayerId
FROM Player p
WHERE p.PlayerId IN (SELECT m.Player1Id FROM Meci m) and p.PlayerId IN (SELECT ctp.PlayerId FROM ClubTeam_Player ctp)

select * from Player

--f. 2 queries using the EXISTS operator to introduce a subquery in the WHERE clause
-- players that are older than 23 years and that are participating in training

SELECT p.PlayerId, p.Age
FROM Player p
WHERE Age > 23 and EXISTS (SELECT * FROM Training t WHERE t.PlayerId=p.PlayerId)

-- coaches that their names start with C and have at least 2 characters and that training players
SELECT c.CoachId, c.FirstName
FROM Coach c
WHERE c.FirstName like 'C_%' and EXISTS (SELECT * FROM Training t WHERE c.CoachId=t.CoachId) 

--g. 2 queries with a subquery in the FROM clause;
-- the age and name of the players that are training and are younger than 24 y.o.
SELECT A.Age, A.Name
FROM (SELECT t.PlayerId, p.Name, p.Age
	  FROM Player p INNER JOIN Training t ON p.PlayerId = t.PlayerId
	  WHERE p.Age<24) A

-- the location of the matchday that have matches of whom referee's name starts with G and has at least 2 letters
SELECT B.Location
FROM (SELECT md.MatchdayId, md.Location, m.MatchId
	  FROM Meci m INNER JOIN Matchday md ON m.MatchdayId = md.MatchdayId
	  WHERE m.RefereeName like 'G_%') B

--h. 4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter
-- will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX

--select the players that participate in exercises and are grouped by their PlayerId's and display their whole exercising time 
SELECT p.PlayerId, SUM(e.Duration)
FROM Player p INNER JOIN Exercise e ON p.PlayerId = e.PlayerId
GROUP BY p.PlayerId

--for each player the maximum price of its paddles if it is smaller or equal to 700
SELECT p.PlayerId, MAX(pd.Price)
FROM Player p INNER JOIN Paddle pd ON
p.PlayerId = pd.PlayerId
GROUP BY p.PlayerId
HAVING MAX(pd.Price) <= 700

--for each player the average duration of his/her exercises is grater or equal to the minimum duration of any exercise of any player
SELECT p.PlayerId, AVG(e.Duration)
FROM Player p INNER JOIN Exercise e ON p.PlayerId=e.PlayerId
GROUP BY p.PlayerId
HAVING AVG(e.Duration)>(SELECT MIN(Duration) from Exercise)

--for each macthday the min number of players from all the current touraments is smaller or equal to the average nr of players of the tournaments held during that matchday
SELECT m.MatchdayId, MIN(t.NrOfPlayers)
FROM Matchday m INNER JOIN Tournament t ON m.MatchdayId=t.MatchdayId
GROUP BY m.MatchdayId
HAVING MIN(t.NrOfPlayers) <=(SELECT AVG(NrOfPlayers) from Tournament)

--i. 4 queries using ANY and ALL to introduce a subquery in the WHERE clause; rewrite 2 of them with the aggregation
-- operators, and the other 2 with [NOT] IN + use arithmetic expressions in the SELECT clause in at least 3 queries;
-- + use conditions with AND, OR, NOT, and the parantheses in the WHERE clause in at least 3 queries;
-- + DISTINCT in at least 3 queries, ORDER BY in at least 2 queries, and TOP in at least 2 queries

--the first 2 paddle names and a custom computed price for every paddle that has a price bigger than all of the paddles that have the name starting with G and at least 2 letters
SELECT TOP 2 pd.Name , (pd.Price+70)/3
FROM Paddle pd
WHERE pd.Price>ALL(SELECT pd1.Price
				   FROM Paddle pd1
				   WHERE pd.PaddleId=pd1.PaddleId AND pd1.Name like 'G_%')

-- equivalent

SELECT TOP 2 pd.Name , (pd.Price+70)/3
FROM Paddle pd
WHERE pd.Price>(SELECT MAX(pd1.Price)
				   FROM Paddle pd1
				   WHERE pd.PlayerId=pd.PlayerId AND pd1.Name like 'G_%')

--------------------------------------------------
-- the distinct player names and a custom computed age for all players that have the age smaller than everyone's age or their styleId is biger than 2 and are ordered by name
SELECT DISTINCT p.Name, (p.Age-12)*3
FROM Player p
WHERE p.Age<=ALL(SELECT p1.Age
					   FROM Player p1
					   WHERE p.StyleId=p1.StyleId OR p1.StyleId>=2)
ORDER BY p.Name

--equivalent

SELECT DISTINCT p.Name, (p.Age-12)*3
FROM Player p
WHERE p.Age<=(SELECT MIN(p1.Age)
					   FROM Player p1
					   WHERE p.StyleId=p1.StyleId OR p1.StyleId>=2)
ORDER BY p.Name

---------------------------------------------------
-- the distinct name of the coaches and a custom nrOfPlayers that they have for all coaches that dont have the clubTeamId an even number and whose names dont start with the letter A or have at least 2 letters
SELECT DISTINCT c.Name, (c.NrOfPlayers+2)*3/2
FROM ClubTeam c
WHERE c.NrOfPlayers <>ALL (SELECT c1.NrOfPlayers
							FROM ClubTeam c1
							WHERE c1.ClubTeamId = 2*c.ClubTeamId AND NOT c1.Name like 'A_%')

--equivalent

SELECT DISTINCT c.Name, (c.NrOfPlayers+2)*3/2
FROM ClubTeam c
WHERE c.NrOfPlayers NOT IN (SELECT c1.NrOfPlayers
							FROM ClubTeam c1
							WHERE c1.ClubTeamId = 2*c.ClubTeamId AND NOT c1.Name like 'A_%')

---------------------------------------------------
-- the distinct first 3 tournament venues, nrOfPlayers and winners for any tournament that has a winner whose names starts with F and is ordered by tournamentId
SELECT DISTINCT TOP 3 t.Venue, t.NrOfPlayers, t.Winner
FROM Tournament t
WHERE t.NrOfPlayers = ANY(SELECT t1.NrOfPlayers
						  FROM Tournament t1
						  WHERE t.Winner like 'F%')
ORDER BY t.Venue

--equivalent

SELECT DISTINCT TOP 3 t.Venue, t.NrOfPlayers, t.Winner
FROM Tournament t
WHERE t.NrOfPlayers IN (SELECT t1.NrOfPlayers
						  FROM Tournament t1
						  WHERE t.Winner like 'F%')
ORDER BY t.Venue

Create table VersionTable (
	TVersion INT,
);
select * from VersionTable
insert into VersionTable values (0)
drop table VersionTable

