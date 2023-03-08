CREATE DATABASE Milestone2;
GO;
SELECT * FROM Ticket
-- Question 2.1 a --

CREATE PROCEDURE createAllTables AS
	CREATE TABLE SystemUser(
	Username VARCHAR(20) PRIMARY KEY,
	Password VARCHAR(20)
	);

	CREATE TABLE Stadium_Manager(
	ID INT PRIMARY KEY IDENTITY,
	name VARCHAR(20),
	Username VARCHAR(20) UNIQUE FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE SET NULL ON UPDATE SET NULL
	);

	CREATE TABLE Club_Representative(
	ID INT PRIMARY KEY IDENTITY,
	name VARCHAR(20),
	Username VARCHAR(20) UNIQUE FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE SET NULL ON UPDATE SET NULL
	);

	CREATE TABLE Sport_Association_Manager(
	ID INT PRIMARY KEY IDENTITY,
	name VARCHAR(20),
	Username VARCHAR(20) UNIQUE FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE SET NULL ON UPDATE SET NULL
	);

	CREATE TABLE System_Admin(
	ID INT PRIMARY KEY IDENTITY,
	name VARCHAR(20),
	Username VARCHAR(20) UNIQUE FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE SET NULL ON UPDATE SET NULL
	);

	CREATE TABLE Fan(
	national_ID VARCHAR(20) PRIMARY KEY,
	name VARCHAR(20),
	phone_no VARCHAR(20),
	address VARCHAR(20),
	status BIT DEFAULT 1, -- 0 means blocked, while 1 means unblocked --
	birth_date DATETIME,
	Username VARCHAR(20) UNIQUE FOREIGN KEY REFERENCES SystemUser(Username) ON DELETE SET NULL ON UPDATE SET NULL
	);

	CREATE TABLE Stadium(
	ID INT PRIMARY KEY IDENTITY,
	name VARCHAR(20),
	capacity INT,
	location VARCHAR(20),
	status BIT DEFAULT 1, -- 0 means unavailable, while 1 means available --
	stadium_manager_ID INT FOREIGN KEY REFERENCES Stadium_Manager(ID) ON DELETE SET NULL ON UPDATE SET NULL
	);
	
	CREATE TABLE Club(
	ID INT PRIMARY KEY IDENTITY,
	name VARCHAR(20),
	location VARCHAR(20),
	club_rep_ID INT FOREIGN KEY REFERENCES Club_Representative(ID) ON DELETE SET NULL ON UPDATE SET NULL
	);

	CREATE TABLE Match(
	ID INT PRIMARY KEY IDENTITY,
	start_time DATETIME,
	end_time DATETIME,
	host_stadium_ID INT DEFAULT NULL FOREIGN KEY REFERENCES Stadium(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	host_club_ID INT DEFAULT NULL FOREIGN KEY REFERENCES Club(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
	guest_club_ID INT DEFAULT NULL FOREIGN KEY REFERENCES Club(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
	);

	CREATE TABLE Host_Request(
	ID INT PRIMARY KEY IDENTITY,
	status VARCHAR(20) DEFAULT 'unhandled',
	Match_ID INT FOREIGN KEY REFERENCES Match(ID) ON DELETE CASCADE ON UPDATE CASCADE,
	stadium_manager_ID INT FOREIGN KEY REFERENCES Stadium_Manager(ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
	club_rep_ID INT FOREIGN KEY REFERENCES Club_Representative(ID) ON DELETE NO ACTION ON UPDATE NO ACTION
	);
	
	CREATE TABLE Ticket(
	ID INT PRIMARY KEY IDENTITY,
	status BIT DEFAULT 1, -- 0 means sold while 1 means unsold --
	match_ID INT FOREIGN KEY REFERENCES Match(ID) ON DELETE SET NULL ON UPDATE SET NULL,
	fan_ID VARCHAR(20) DEFAULT NULL FOREIGN KEY REFERENCES Fan(national_ID) ON DELETE NO ACTION
	);
	
GO;

-- Question 2.1 b --
CREATE PROCEDURE dropAllTables AS
	DROP TABLE Ticket;
	DROP TABLE Host_Request;
	DROP TABLE Match;
	DROP TABLE Club;
	DROP TABLE Stadium;
	DROP TABLE Sport_Association_Manager;
	DROP TABLE Stadium_Manager;
	DROP TABLE System_Admin;
	DROP TABLE Fan;
	DROP TABLE Club_Representative;
	DROP TABLE SystemUser;
GO;

-- Question 2.1 c --
CREATE PROCEDURE dropAllProceduresFunctionsViews AS
	DROP PROCEDURE dropAllTables;
	DROP PROCEDURE createAllTables;
	DROP PROCEDURE clearAllTables;
	DROP PROCEDURE deleteMatch;
	DROP PROCEDURE addTicket;
	DROP PROCEDURE deleteStadium;
	DROP PROCEDURE addStadiumManager;
	DROP PROCEDURE rejectRequest;
	DROP PROCEDURE addNewMatch;
	DROP PROCEDURE deleteClub;
	DROP PROCEDURE addStadium;
	DROP PROCEDURE blockFan;
	DROP PROCEDURE unblockFan;
	DROP PROCEDURE purchaseTicket;
	DROP PROCEDURE addAssociationManager;
	DROP PROCEDURE addHostRequest;
	DROP PROCEDURE acceptRequest;
	DROP PROCEDURE addFan;
	DROP PROCEDURE deleteMatchesOnStadium;
	DROP PROCEDURE addClub;
	DROP PROCEDURE addRepresentative;
	DROP PROCEDURE updateMatchHost;

	DROP FUNCTION upcomingMatchesOfClub;
	DROP FUNCTION matchWithHighestAttendance;
	DROP FUNCTION requestsFromClub;
	DROP FUNCTION availableMatchesToAttend;
	DROP FUNCTION allPendingRequests;
	DROP FUNCTION matchesRankedByAttendance;
	DROP FUNCTION viewAvailableStadiumsOn;
	DROP FUNCTION allUnassignedMatches;
	DROP FUNCTION clubsNeverPlayed;

	DROP VIEW allAssocManagers;
	DROP VIEW allClubRepresentatives;
	DROP VIEW allStadiumManagers;
	DROP VIEW allFans;
	DROP VIEW allMatches;
	DROP VIEW allTickets;
	DROP VIEW allClubs;
	DROP VIEW allStadiums;
	DROP VIEW allRequests;
	DROP VIEW clubsNeverMatched;
	DROP VIEW clubsWithNoMatches;
	DROP VIEW matchesPerTeam;
GO;

-- Question 2.1 d --
CREATE PROCEDURE clearAllTables AS
	TRUNCATE TABLE Ticket;
	TRUNCATE TABLE Match;
	TRUNCATE TABLE Club;
	TRUNCATE TABLE Stadium;
	TRUNCATE TABLE Host_Request;
	TRUNCATE TABLE Sport_Association_Manager;
	TRUNCATE TABLE Stadium_Manager;
	TRUNCATE TABLE System_Admin;
	TRUNCATE TABLE Fan;
	TRUNCATE TABLE Club_Representative;
	TRUNCATE TABLE SystemUser;
GO;

-- Question 2.2 a --
CREATE VIEW allAssocManagers AS
	SELECT SU.Username, SU.Password, SAM.name
	FROM Sport_Association_Manager SAM INNER JOIN SystemUser SU
	ON SAM.Username = SU.Username;
GO;

-- Question 2.2 b --
CREATE VIEW allClubRepresentatives AS
	SELECT SU.Username, SU.Password, CR.name, C.name AS 'Represented Club Name'
	FROM Club_Representative CR INNER JOIN SystemUser SU
	ON CR.Username = SU.Username
	INNER JOIN Club C
	ON C.club_rep_ID = CR.ID;
GO;

-- Question 2.2 c --
CREATE VIEW allStadiumManagers AS
	SELECT SU.Username, SU.Password, SM.name, S.name AS 'Managed Stadium Name'
	FROM Stadium_Manager SM INNER JOIN SystemUser SU
	ON SM.Username = SU.Username
	INNER JOIN Stadium S
	ON SM.ID = S.stadium_manager_ID;
GO;

-- Question 2.2 d --
CREATE VIEW allFans AS
	SELECT F.Username, SU.Password, F.name, F.national_ID, F.birth_date, F.status
	FROM Fan F INNER JOIN SystemUser SU
	ON F.Username = SU.Username;
GO;

-- Question 2.2 e --
CREATE VIEW allMatches AS
	SELECT C1.name AS 'Host Club Name', C2.name AS 'Guest Club Name', M.start_time AS 'Match Start Time'
	FROM Match M INNER JOIN Club C1
	ON M.host_club_ID = C1.ID
	INNER JOIN Club C2
	ON M.guest_club_ID = C2.ID;
GO;

-- Question 2.2 f --
CREATE VIEW allTickets AS
	SELECT C1.name AS  'Host Club', C2.name AS 'Guest Club', S.name AS 'Host Stadium', M.start_time AS 'Match Start Time'
	FROM Ticket T INNER JOIN Match M
	ON T.match_ID = M.ID
	INNER JOIN Stadium S
	ON M.host_stadium_ID = S.ID
	INNER JOIN Club C1
	ON M.host_club_ID = C1.ID
	INNER JOIN Club C2
	ON M.guest_club_ID = C2.ID;
GO;

-- Question 2.2 g --
CREATE VIEW allClubs AS
	SELECT name, location
	FROM Club;
GO;

-- Question 2.2 h --
CREATE VIEW allStadiums AS
	SELECT name, location, capacity, status
	FROM Stadium;
GO;

-- Question 2.2 i --
CREATE VIEW allRequests AS
	SELECT CR.Username AS 'Club Representative Username', SM.Username AS 'Stadium Manager Username', HR.status AS 'Request Status'
	FROM Host_Request HR INNER JOIN Club_Representative CR
	ON HR.club_rep_ID = CR.ID
	INNER JOIN Stadium_Manager SM
	ON HR.stadium_manager_ID = SM.ID;
GO;

-- Question 2.3 --

-- Question I --    
CREATE PROCEDURE addAssociationManager
	@name VARCHAR(20),
	@user_name VARCHAR(20),
	@password VARCHAR(20)
	AS
		INSERT INTO SystemUser VALUES(@user_name,@password);
		INSERT INTO Sport_Association_Manager (name, Username) VALUES(@name, @user_name);
GO;

-- Question II -- 
CREATE PROCEDURE addNewMatch 
	@host_club VARCHAR(20),
	@guest_club VARCHAR(20),
	@start_time DATETIME,
	@end_time DATETIME
	AS
		DECLARE @host_club_ID INT
		DECLARE @guest_club_ID INT
		SELECT @host_club_ID = C.ID
		FROM Club C
		WHERE @host_club = C.name
		SELECT @guest_club_ID = C.ID
		FROM Club C
		WHERE @guest_club = C.name
		INSERT INTO Match (start_time, end_time, host_club_ID, guest_club_ID)
		VALUES(@start_time,@end_time, @host_club_ID,@guest_club_ID);
GO;

-- Question III --
CREATE VIEW clubsWithNoMatches 
	AS
	SELECT C.name
	FROM Club C INNER JOIN Match M
	ON C.ID = M.host_club_ID
	WHERE m.host_club_ID IS NULL;
GO;

-- Question IV --
CREATE PROCEDURE deleteMatch
	@host_club_name VARCHAR(20),
	@guest_club_name VARCHAR(20)
	AS
		DELETE 
		FROM Match
		WHERE ID IN (
			SELECT M.ID
			FROM Match M INNER JOIN Club C1
			ON C1.ID = M.host_club_ID
			INNER JOIN Club C2
			ON C2.ID = M.guest_club_ID
			WHERE C1.name = @host_club_name AND
			C2.name = @guest_club_name
		);
GO;

-- Question V --
CREATE PROCEDURE deleteMatchesOnStadium
	@StadiumName VARCHAR(20)
	AS
		DELETE
		FROM Match
		WHERE Match.host_stadium_ID = (SELECT ID FROM Stadium WHERE Stadium.name = @StadiumName);
GO;

-- Question VI -- 
CREATE PROCEDURE addClub
	@ClubName VARCHAR(20),
	@ClubLocation VARCHAR(20)
	AS
		INSERT INTO Club (name , location) VALUES(@ClubName,@ClubLocation);
GO;

-- Question VII --
CREATE PROCEDURE addTicket
	@host_club_name VARCHAR(20),
	@guest_club_name VARCHAR(20),
	@match_start_time DATETIME
	AS
		INSERT INTO Ticket (match_ID)
		SELECT M.ID
		FROM Match M INNER JOIN Club C1
		ON M.host_club_ID = C1.ID
		INNER JOIN Club C2
		ON M.guest_club_ID = C2.ID
		WHERE C1.name = @host_club_name AND
		C2.name = @guest_club_name AND
		M.start_time = @match_start_time;
GO;

-- Question VIII --
Create PROCEDURE deleteClub 
	@name VARCHAR(24)
	AS
		DELETE
		FROM Club 
		WHERE name = @name;
GO;

-- Question IX --
CREATE PROCEDURE addStadium 
	@stadium_name VARCHAR(20),
	@location VARCHAR(20),
	@capacity INT
	AS
		INSERT INTO Stadium (name, location, capacity) VALUES(@stadium_name,@location,@capacity);
GO;

-- Question X --
CREATE PROCEDURE deleteStadium
	@stadium_name VARCHAR(20)
	AS
		DELETE FROM Stadium
		WHERE name = @stadium_name;
GO;

-- Question XI --
CREATE PROCEDURE blockFan 
	@national_id_fan VARCHAR(20)
	AS
		UPDATE Fan
		SET status = 0
		WHERE national_ID = @national_id_fan;
GO;

-- Question XII --
Create PROCEDURE unblockFan
	@national_ID VARCHAR(20)
	AS
	Update Fan
	SET status = 1
	WHERE national_ID = @national_ID;
GO;

-- Question XIII --
CREATE PROCEDURE addRepresentative
	@Name VARCHAR(20),
	@ClubName VARCHAR(20),
	@Username VARCHAR(20),
	@Password VARCHAR(20)
	AS
		INSERT INTO SystemUser VALUES(@Username,@Password)
		INSERT INTO Club_Representative (name, Username) VALUES(@Name, @Username);
		UPDATE Club
		SET club_rep_ID = (SELECT CR.ID FROM Club_Representative CR WHERE CR.name = @Name AND CR.Username = @Username)
		WHERE Club.name = @ClubName;
GO;

-- Question XIV --
CREATE FUNCTION viewAvailableStadiumsOn 
	(@DateTime DATETIME)
	RETURNS TABLE
	AS
	RETURN
		SELECT Name,Capacity,Location
		FROM Stadium
		WHERE status = 1 AND NOT EXISTS (
										SELECT * 
										FROM Stadium S INNER JOIN Match M
										ON S.ID = M.host_stadium_ID
										WHERE M.start_time = @DateTime
										);
GO;

-- Question XV --
CREATE PROCEDURE addHostRequest
	@clubname VARCHAR(20),
	@stadiumname VARCHAR(20),
	@datetime DATETIME 
	AS
	DECLARE @repid INT;
	SELECT @repid = CR.ID  
	FROM Club_Representative CR INNER JOIN Club C
	ON CR.ID = C.ID 
	WHERE C.name = @clubname
	DECLARE @managerid INT 
	SELECT @managerid = SM.ID
	FROM Stadium_Manager SM INNER JOIN  Stadium S
	ON  SM.ID = S.ID
	WHERE S.name = @stadiumname
	DECLARE @matchid INT 
	SELECT @matchid = M.ID
	FROM match M INNER JOIN Club C
	ON M.ID = C.ID
	WHERE M.start_time = @datetime
	INSERT INTO Host_Request (club_rep_ID ,stadium_manager_ID,Match_ID) VALUES (@repid,@managerid,@matchid);
GO;

-- Question XVI --
CREATE FUNCTION allUnassignedMatches
	(@ClubName VARCHAR(20))	
	RETURNS TABLE
	AS
	RETURN
		SELECT C.name AS 'Guest Club Name', M.start_Time 
		FROM Match M FULL OUTER JOIN Club C
		ON M.guest_club_ID = C.ID 
		INNER JOIN  Club C1
		ON C1.ID = m.host_club_ID
		INNER JOIN Host_Request H
		ON H.club_rep_ID = C1.club_rep_ID
		WHERE C1.name = @ClubName AND H.status = 'unhandled';
GO;

-- Question XVII --
CREATE PROCEDURE addStadiumManager
	@name VARCHAR(20),
	@stadium_name VARCHAR(20),
	@username VARCHAR(20),
	@password VARCHAR(20)
	AS
		INSERT INTO SystemUser VALUES (@username, @password);
		INSERT INTO Stadium_Manager VALUES (@name, @username);
		DECLARE @manager_ID INT
		SELECT @manager_ID = COUNT(*)
		FROM Stadium_Manager
		UPDATE Stadium
		SET stadium_manager_ID = @manager_ID
		WHERE name = @stadium_name;
GO;

-- Question XVIII --
CREATE FUNCTION allPendingRequests
	(@stadium_manager_username VARCHAR(20))
	RETURNS TABLE 
	AS 
	RETURN
		SELECT CR.name AS 'club rep name', C.name AS 'guest club name', M.start_time
		FROM Stadium_Manager SM  INNER JOIN Host_Request H
		ON SM.ID = H.ID
		INNER JOIN Club_Representative CR
		ON H.ID = CR.ID
		INNER JOIN Club C
		ON CR.ID = C.ID
		INNER JOIN Match M
		ON C.ID = M.guest_club_ID 
		WHERE SM.Username = @stadium_manager_username; 
GO;

-- Question XIX --
CREATE PROCEDURE acceptRequest
	@stadium_manager_username VARCHAR(20),
	@hostingclubname VARCHAR(20),
	@guestclubname VARCHAR(20),
	@starttime DATETIME
	AS
	DECLARE @managerid INT 
	SELECT @managerid = SM.ID
	FROM Stadium_Manager SM 
	WHERE SM.Username = @stadium_manager_username
	DECLARE @clubrepid INT
	SELECT @clubrepid = C.club_rep_ID
	FROM Club C
	WHERE C.name = @hostingclubname
	DECLARE @matchid INT 
	SELECT @matchid = M.ID
	FROM Match M INNER JOIN Club C1
	ON M.host_club_ID = C1.ID AND C1.name = @hostingclubname
	INNER JOIN Club C2
	ON M.guest_club_ID = C2.ID AND C2.name = @guestclubname
	WHERE M.start_time = @starttime 
	UPDATE Host_Request
	SET status = 'accepted'
	WHERE stadium_manager_ID = @managerid AND
	club_rep_ID = @clubrepid AND
	Match_ID = @matchid AND status = 'unhandled';
	DECLARE @StadiumCapacity INT, @StadiumID INT
	SELECT @StadiumCapacity = S.capacity, @StadiumID = S.ID
	FROM Host_Request HR INNER JOIN Match M
	ON HR.Match_ID = M.ID
	INNER JOIN Stadium S
	ON HR.stadium_manager_ID = S.stadium_manager_ID
	WHERE S.stadium_manager_ID = @managerid AND M.ID = @matchid AND HR.status = 'accepted'
	
	UPDATE Match
	SET host_stadium_ID = @StadiumID
	WHERE ID = @matchid

	DECLARE @i INT = 0
	WHILE @i < @StadiumCapacity
		BEGIN
			INSERT INTO Ticket VALUES(1, @matchid, NULL)
			SET @i = @i + 1
		END;
GO;

-- Question XX --
CREATE PROCEDURE rejectRequest
	@stadium_manager_username VARCHAR(20),
	@host_club_name VARCHAR(20),
	@guest_club_name VARCHAR(20),
	@match_start_time DATETIME
	AS
		DECLARE @managerid INT 
		SELECT @managerid = SM.ID
		FROM Stadium_Manager SM 
		WHERE SM.Username = @stadium_manager_username
		DECLARE @clubrepid INT
		SELECT @clubrepid = C.club_rep_ID
		FROM Club C
		WHERE C.name = @host_club_name
		DECLARE @matchid INT 
		SELECT @matchid = M.ID
		FROM Match M INNER JOIN Club C1
		ON M.host_club_ID = C1.ID AnD C1.name = @host_club_name
		INNER JOIN Club C2
		ON M.guest_club_ID = C2.ID AND C2.name = @guest_club_name
		WHERE M.start_time = @match_start_time 
		UPDATE Host_Request
		SET status = 'rejected'
		WHERE stadium_manager_ID = @managerid AND
		club_rep_ID = @clubrepid AND
		Match_ID = @matchid AND status = 'unhandled';
GO;

-- Question XXI --
CREATE PROCEDURE addFan
	@name VARCHAR(20),
	@username VARCHAR(20),
	@password VARCHAR(20),
	@natIDno VARCHAR(20),
	@datetime DATETIME,
	@adress VARCHAR(20),
	@phoneno INT
	AS
		INSERT INTO SystemUser VALUES(@username,@password);
		INSERT INTO Fan (name,national_ID, birth_date,address,phone_no, Username) VALUES (@name,@natIDno,@datetime,@adress,@phoneno, @username);
GO;

-- Question XXII --
CREATE FUNCTION upcomingMatchesOfClub
	(@club_name VARCHAR(20))
	RETURNS TABLE
	AS
	RETURN
		SELECT C1.name AS 'Host Club Name', C2.name 'Guest Club Name', M.start_time AS 'Match Start Time', S.name AS 'Host Stadium Name'
		FROM Match M RIGHT OUTER JOIN Club C1
		ON M.host_club_ID = C1.ID
		RIGHT OUTER JOIN Club C2
		ON M.guest_club_ID = C2.ID
		LEFT OUTER JOIN Stadium S
		ON M.host_stadium_ID = S.ID
		WHERE M.start_time > CURRENT_TIMESTAMP AND (C1.name = @club_name OR C2.name = @club_name);
GO;

-- Question XXIII -- 
CREATE FUNCTION availableMatchesToAttend
	(@dateofMatches datetime)
	RETURNS TABLE
	AS
	RETURN 
		SELECT C.name AS 'Host Club Name', C1.name AS 'Guest Club Name', M.start_time AS 'Start Time_of Match', S.name AS 'Host Stadium Name',S.location AS 'Stadium Location'
		FROM Match M RIGHT OUTER JOIN Club C 
		ON C.ID = M.host_club_ID
		RIGHT OUTER JOIN Club C1
		ON C1.ID = M.guest_club_ID
		RIGHT OUTER JOIN Stadium S
		ON S.ID = M.host_stadium_ID
		WHERE M.start_time > @dateofMatches;
Go;
--EXECUTE purchaseTicket '1A2B', 'Trojan', 'Trojan2', '12/12/2022 23:00:00'; SELECT * FROM Ticket;
-- Question XXIV --
CREATE PROCEDURE purchaseTicket
	@national_ID_fan VARCHAR(20),
	@host_club_name VARCHAR(20),
	@guest_club_name VARCHAR(20),
	@start_time DATETIME
	AS
		DECLARE @match_ID INT
		SELECT @match_ID = M.ID 
		FROM Match M RIGHT OUTER JOIN Club C
		ON C.ID = M.host_club_ID
		RIGHT OUTER JOIN Club C1
		ON C1.ID = M.guest_club_ID
		WHERE @host_club_name = C.name AND
		@guest_club_name = C1.name AND
		@start_time = M.start_time
		DECLARE @Ticket_ID INT
		SELECT TOP 1 @Ticket_ID = T.ID
		FROM Ticket T INNER JOIN Match M
		ON T.match_ID = M.ID AND M.ID = @match_ID
		WHERE T.status = 1
		Update Ticket set status = 0 where match_ID = @match_ID AND Ticket.ID = @Ticket_ID;
		Update Ticket set fan_ID = @national_ID_fan where match_ID = @match_ID AND Ticket.ID = @Ticket_ID AND fan_ID IS NULL;
GO;

EXECUTE purchaseTicket '1a', 'Ahly', 'Zamalk','12/12/2022';
GO;

-- Question XXV -- 
CREATE PROCEDURE updateMatchHost
	@HostClubName VARCHAR(20),
	@GuestClubName VARCHAR(20),
	@StartTime DATETIME
	AS
		DECLARE @host_club_ID INT
		DECLARE @guest_club_ID INT
		DECLARE @match_ID INT
		SELECT @match_ID = M.ID, @host_club_ID = C.ID, @guest_club_ID = C1.ID
		FROM Match M,Club C, Club C1
		where M.host_club_ID = C.ID AND
		M.guest_club_ID = C1.ID AND
		@StartTime = M.start_time AND
		@HostClubName = C.name AND
		@GuestClubName = C1.name 
		UPDATE Match
		SET host_club_ID = @guest_club_ID
		WHERE @match_ID = ID;
GO;

-- Question XXVI --
CREATE VIEW matchesPerTeam
	AS
		WITH all_matches AS (
			SELECT C.ID, C.name, M.end_time
			FROM Club C INNER JOIN Match M
			ON C.ID = M.host_club_ID
			UNION ALL
			SELECT C.ID, C.name, M.end_time
			FROM Club C INNER JOIN Match M
			ON C.ID = M.guest_club_ID
		)
		SELECT Club.name, COUNT(CASE WHEN CURRENT_TIMESTAMP > M.end_time THEN 1 END) AS 'number of matches played'
		FROM Club 
		LEFT JOIN all_matches M
		ON Club.ID = M.ID 
		GROUP BY Club.ID, Club.name;
GO;

-- Question XXVII --
CREATE VIEW clubsNeverMatched
	AS
		SELECT C.name AS 'First club name', C1.name AS 'Second club name'
		FROM Club C1, Club C
		WHERE C.ID <> C1.ID AND
		NOT EXISTS(
			SELECT C.name AS 'First club name', C1.name AS 'Second club name'
			FROM Club C, Club C1, Match M
			WHERE M.host_club_ID = C.ID AND
			M.guest_club_ID = C1.ID AND
			C.ID <> C1.ID
		);
GO;

--- Question XXVIII ---
CREATE FUNCTION clubsNeverPlayed
	(@ClubName VARCHAR(20))	
	RETURNS TABLE
	AS
	RETURN
		SELECT C.name 
		FROM Club C
		WHERE @ClubName <> C.name AND
		C.name NOT IN(
					  SELECT C2.name
					  FROM Match M INNER JOIN Club C1
					  ON M.host_club_ID = C1.ID
					  INNER JOIN Club C2
					  ON M.guest_club_ID = C2.ID
					  WHERE C1.name = @ClubName
					  )	AND
		C.name NOT IN(
					  SELECT C2.name
					  FROM Match M INNER JOIN Club C1
					  ON M.host_club_ID = C1.ID
					  INNER JOIN Club C2
					  ON M.guest_club_ID = C2.ID
					  WHERE C1.name = @ClubName
					  );
GO;
-- Question XXIX --
CREATE FUNCTION matchWithHighestAttendance
	()
	RETURNS TABLE
	AS
	RETURN
		SELECT TOP 1 C1.name AS 'Host Club Name', C2.name AS 'Guest Club Name'
		FROM Match M RIGHT OUTER JOIN Club C1
		ON M.host_club_ID = C1.ID
		RIGHT OUTER JOIN Club C2
		ON M.guest_club_ID = C2.ID
		RIGHT OUTER JOIN Ticket T
		ON T.match_ID = M.ID
		GROUP BY C1.name, C2.name, M.ID
		ORDER BY COUNT(CASE T.status WHEN 0 THEN 1 END) DESC;
GO;

-- Question XXX --
CREATE FUNCTION matchesRankedByAttendance
	()
	RETURNS TABLE 
	AS
	RETURN  
		SELECT C1.name AS 'First Club', C2.name AS 'Second Club', M.start_time AS 'Match Start Time', M.end_time AS 'Match End Time' 
		FROM club C1 INNER JOIN Match M
		ON C1.ID = M.host_club_ID 
		INNER JOIN club C2
		ON M.guest_club_ID = C2.ID
		LEFT OUTER JOIN Ticket T
		ON T.match_ID = M.ID
		WHERE M.host_stadium_ID IS NOT NULL AND M.start_time < CURRENT_TIMESTAMP
		GROUP BY C1.name, C2.name, M.ID, M.start_time, M.end_time
		ORDER BY COUNT(CASE T.status WHEN 0 THEN 1 END) DESC
		OFFSET 0 ROWS;
GO;

-- Question XXXI --
CREATE FUNCTION requestsFromClub
	(@stadium_name VARCHAR(20), @club_name VARCHAR(20))
	RETURNS TABLE
	AS
	RETURN
		SELECT C1.name AS 'Host Club Name', C2.name AS 'Guest Club Name'
		FROM Host_Request HR INNER JOIN Match M
		ON HR.Match_ID = M.ID
		INNER JOIN Club C1
		ON HR.club_rep_ID = C1.club_rep_ID AND
		M.host_club_ID = C1.ID
		INNER JOIN Club C2
		ON M.guest_club_ID = C2.ID
		RIGHT OUTER JOIN Stadium S
		ON M.host_stadium_ID = S.ID AND
		HR.stadium_manager_ID = S.stadium_manager_ID
		WHERE S.name = @stadium_name AND
		C1.name = @club_name;

--- extras ---
GO;
Create Procedure UsernameToID 
@username varchar(20),
@Output INT OUTPUT
as
	 Select @Output=ID from Club_Representative where @username = Username
	 print (@Output)
Go;


CREATE FUNCTION ClubInfo
	(@club_rep_id VARCHAR(20))
	RETURNS TABLE
	AS
	RETURN
		Select ID,Name,Location from Club where @club_rep_id = club_rep_ID
GO;

CREATE PROCEDURE deleteMatchWithTime
	@host_club_name VARCHAR(20),
	@guest_club_name VARCHAR(20),
	@Start_Time DATETIME,
	@End_Time DATETIME
	AS
		DELETE 
		FROM Match
		WHERE ID IN (
			SELECT M.ID
			FROM Match M INNER JOIN Club C1
			ON C1.ID = M.host_club_ID
			INNER JOIN Club C2
			ON C2.ID = M.guest_club_ID
			WHERE C1.name = @host_club_name AND
			C2.name = @guest_club_name AND M.start_time = @Start_Time AND M.end_time = @End_Time
		);

INSERT INTO SystemUser VALUES ('Ziad Maged', 'Ziad2002'); -- For the System Admin
INSERT INTO System_Admin VALUES ('Ziad Elsabbagh', 'Ziad Maged'); -- For The System Admin