/**
	Name of Script: pivotingAndUnpivoting.sql
    Author: Jacob Shuster
    Role: Consultant - 1099
    Umbrella Company: N/A
    Creation Date: 2024-09-08
    Script Cost: N/A
    Rate: 100.00 (Based on 2019*)

    Changelog:
        2024-09-08: Initial Creation
		2024-09-08: Added #managerTable table to the temporary tables for sample data sets.
		
    TO DO (Requested):
		N/A - No current modification requests pending.
	
	TO DO (SELF):
		Include Additional Examples, and will be using test data only.
            
    DISCLAIMER:
        After receipt, this Script is "as-is". Additional modifications past the base are at 100.00 per hour.
        This script is intended to setup your initial Python Auto Claims App.
    
    Non-Billable Items:
        Notes.
        
    Accessing the below variables is @nameOfVariable. The variable will ONLY be accessible within the bounds of the GO
		Paramater. This is because each batch is committed before the next can complete.

    WARNING: DO NOT MODIFY SCRIPT WITHOUT CONSULTING THE CREATOR FIRST. AS SOME CHANGES MAY PREVENT THE SCRIPT FROM
		EXECUTING PROPERLY.

    Scalar Variables:
		#employeeTable: Table for Storing our Employees for our Company.
		#managerTable: Table for Storing the Managers of our Employees, Non-Leadership.
		
	Citations:
		1. CREATE PROCEDURE (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/statements/create-procedure-transact-sql?view=sql-server-ver16
        2. NO COUNT (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/statements/set-nocount-transact-sql?view=sql-server-ver16
        3. ERROR_MESSAGE (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/functions/error-message-transact-sql?view=sql-server-ver16
        4. CASE (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/language-elements/case-transact-sql?view=sql-server-ver16
        5. IF...ELSE (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/language-elements/if-else-transact-sql?view=sql-server-ver16
        6. Tutorial: Signing Stored Procedures With a Certificate, https://learn.microsoft.com/en-us/sql/relational-databases/tutorial-signing-stored-procedures-with-a-certificate?view=sql-server-ver16
        7. Slash Star (Block Comment), https://learn.microsoft.com/en-us/sql/t-sql/language-elements/slash-star-comment-transact-sql?view=sql-server-ver16
        8. STRING_SPLIT (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/functions/string-split-transact-sql?view=sql-server-ver16
        9. TRY_CAST (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/functions/try-cast-transact-sql?view=sql-server-ver16
		10. JSON_OBJECT (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/functions/json-object-transact-sql?view=sql-server-ver16
    	11. OPENJSON (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/functions/openjson-transact-sql?view=sql-server-ver16
    	12. JSON data in SQL Server, https://learn.microsoft.com/en-us/sql/relational-databases/json/json-data-sql-server?view=sql-server-ver16
		13. DECLARE @local_variable, https://learn.microsoft.com/en-us/sql/t-sql/language-elements/declare-local-variable-transact-sql?view=sql-server-ver16
		14. WHERE (T-SQL), https://learn.microsoft.com/en-us/sql/t-sql/queries/where-transact-sql?view=sql-server-ver16
		15. Predicates (T-SQL), https://learn.microsoft.com/en-us/sql/t-sql/queries/predicates?view=sql-server-ver16
		16. Search Condition (T-SQL), https://learn.microsoft.com/en-us/sql/t-sql/queries/search-condition-transact-sql?view=sql-server-ver16
		17. Top 100 Rock Bands of the 70s, https://rateyourmusic.com/list/jweber14/top_100_rock_bands_of_the_70s/
		18. Pink Floyd, https://rateyourmusic.com/artist/pink-floyd
		19. Yes, https://rateyourmusic.com/artist/yes
		20. David Bowie, https://rateyourmusic.com/artist/david-bowie
		21. The Allman Brothers Band, https://rateyourmusic.com/artist/the-allman-brothers-band
		22. Gensis, https://rateyourmusic.com/artist/genesis
		23. Led Zeppelin, https://rateyourmusic.com/artist/led-zeppelin
		24. Neil Young, https://rateyourmusic.com/artist/neil-young
		25. Black Sabbath, https://rateyourmusic.com/artist/black-sabbath
		26. The Who, https://rateyourmusic.com/artist/the-who
		27. Rush, https://rateyourmusic.com/artist/rush
		28. Bruce Springsteen, https://rateyourmusic.com/artist/bruce-springsteen
		29. Jethro Tull, https://rateyourmusic.com/artist/jethro-tull,
		30. Caravan, https://rateyourmusic.com/artist/caravan
		31. Stevie Wonder, https://rateyourmusic.com/artist/stevie-wonder
		32. Can, https://rateyourmusic.com/artist/can
		33. King Crimson, https://rateyourmusic.com/artist/king-crimson
		34. RAND (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/functions/rand-transact-sql?view=sql-server-ver16
		35. Van der Graaf Generator, https://rateyourmusic.com/artist/van-der-graaf-generator
		36. Deep Purple, https://rateyourmusic.com/artist/deep-purple
		37. Joy Division, https://rateyourmusic.com/artist/joy-division
		38. Talking Heads, https://rateyourmusic.com/artist/talking-heads
		39. Steely Dan, https://rateyourmusic.com/artist/steely-dan
		40. Frank Zappa, https://rateyourmusic.com/artist/frank-zappa
		41. Elvis Costello, https://rateyourmusic.com/artist/elvis-costello
		42. Grateful Dead, https://rateyourmusic.com/artist/grateful-dead
		43. Kraftwerk, https://rateyourmusic.com/artist/kraftwerk
		44. The Stooges, https://rateyourmusic.com/artist/the-stooges
		45. Emerson, Lake & Palmer, https://rateyourmusic.com/artist/emerson-lake-and-palmer
		46. Brian Eno, https://rateyourmusic.com/artist/brian-eno
		47. The Clash, https://rateyourmusic.com/artist/the_clash
		48. Sly & The Family Stone, https://rateyourmusic.com/artist/sly-and-the-family-stone
		49. Rainbow, https://rateyourmusic.com/artist/rainbow
		50. George Harrison, https://rateyourmusic.com/artist/george-harrison
		51. The Rolling Stones, https://rateyourmusic.com/artist/the-rolling-stones
		52. UFO, https://rateyourmusic.com/artist/ufo
		53. Santana, https://rateyourmusic.com/artist/santana
		54. Supertramp, https://rateyourmusic.com/artist/supertramp
		55. Roxy Music, https://rateyourmusic.com/artist/roxy-music
		56. Soft Machine, https://rateyourmusic.com/artist/soft-machine
		57. Camel, https://rateyourmusic.com/artist/camel
		58. Queen, https://rateyourmusic.com/artist/queen
		59. Lynyrd Skynyrd, https://rateyourmusic.com/artist/lynyrd-skynyrd
		60. Bob Dylan, https://rateyourmusic.com/artist/bob-dylan
		61. John Lennon, https://rateyourmusic.com/artist/john-lennon
		62. Television, https://rateyourmusic.com/artist/television
		63. Gentle Giant, https://rateyourmusic.com/artist/gentle-giant
		64. Roberty Wyatt, https://rateyourmusic.com/artist/robert-wyatt
		65. Patti Smith, https://rateyourmusic.com/artist/patti-smith
		66. Funkadelic, https://rateyourmusic.com/artist/funkadelic
		67. T. Rex, https://rateyourmusic.com/artist/t-rex-2
		68. Judas Priest, https://rateyourmusic.com/artist/judas-priest
		69. Nick Drake, https://rateyourmusic.com/artist/nick-drake
		70. Crosby, Stills, Nash & Young, https://rateyourmusic.com/artist/crosby-stills-nash-and-young
		71. Uriah Heep, https://rateyourmusic.com/artist/uriah-heep
		72. The Jam, https://rateyourmusic.com/artist/the_jam
		73. Banco Del Mutuo Soccorso, https://rateyourmusic.com/artist/banco-del-mutuo-soccorso
		74. Van Morrison, https://rateyourmusic.com/artist/van-morrison
		75. Jorge Ben, https://rateyourmusic.com/artist/jorge-ben
		76. Gene Clark, https://rateyourmusic.com/artist/gene-clark
		77. Buzzcocks, https://rateyourmusic.com/artist/buzzcocks
		78. Rory Gallagher, https://rateyourmusic.com/artist/rory-gallagher
		79. Serge Gainsbourg, https://rateyourmusic.com/artist/serge-gainsbourg
		80. Blue Öyster Cult, https://rateyourmusic.com/artist/blue-oyster-cult
		81. The Cars, https://rateyourmusic.com/artist/the-cars
		82. Caetano Veloso, https://rateyourmusic.com/artist/caetano-veloso
		83. The Band, https://rateyourmusic.com/artist/the-band
		84. Tom Waits, https://rateyourmusic.com/artist/tom-waits
		85. Big Star, https://rateyourmusic.com/artist/big-star
		86. Focus, https://rateyourmusic.com/artist/focus
		87. Premiata Forneria Marconi, https://rateyourmusic.com/artist/premiata-forneria-marconi
		88. Derek and The Dominos, https://rateyourmusic.com/artist/derek-and-the-dominos
		89. Syd Barrett, https://rateyourmusic.com/artist/syd-barrett
		90. Hawkwind, https://rateyourmusic.com/artist/hawkwind
		91. Paul McCartney, https://rateyourmusic.com/artist/paul-mccartney
		92. Thin Lizzy, https://rateyourmusic.com/artist/thin-lizzy
		93. Mike Oldfield, https://rateyourmusic.com/artist/mike-oldfield
		94. Lou Reed, https://rateyourmusic.com/artist/lou-reed
		95. Cheap Trick, https://rateyourmusic.com/artist/cheap-trick
		96. Nektar, https://rateyourmusic.com/artist/nektar
		97. Renaissance, https://rateyourmusic.com/artist/renaissance
		98. John Martyn, https://rateyourmusic.com/artist/john-martyn
		99. Iggy Pop, https://rateyourmusic.com/artist/iggy-pop
		100. Fleetmood Mac, https://rateyourmusic.com/artist/fleetwood-mac
		101. Alice Cooper, https://rateyourmusic.com/artist/alice-cooper
		102. Scorpions, https://rateyourmusic.com/artist/scorpions
		103. Traffic, https://rateyourmusic.com/artist/traffic
		104. Electric Light Orchestra, https://rateyourmusic.com/artist/electric-light-orchestra
		105. Blondie, https://rateyourmusic.com/artist/blondie
		106. Ramones, https://rateyourmusic.com/artist/ramones
		107. Faust, https://rateyourmusic.com/artist/faust
		108. Elvis Presley, https://rateyourmusic.com/artist/elvis-presley
		109. Tom Petty and The Heartbreakers, https://rateyourmusic.com/artist/tom-petty-and-the-heartbreakers
		110. Bee Gees, https://rateyourmusic.com/artist/bee-gees
		111. Kansas, https://rateyourmusic.com/artist/kansas
		112. Billy Joel, https://rateyourmusic.com/artist/billy-joel
		113. Dire Straits, https://rateyourmusic.com/artist/dire-straits
		114. Jim Croce, https://rateyourmusic.com/artist/jim-croce
		115. AC/DC, https://rateyourmusic.com/artist/ac_dc
		116. Elton John, https://rateyourmusic.com/artist/elton-john
		117. Chicago, https://rateyourmusic.com/artist/chicago
		118. Kiss, https://rateyourmusic.com/artist/kiss
		119. JSON data type (preview), https://learn.microsoft.com/en-us/sql/t-sql/data-types/json-data-type?view=azuresqldb-current

	Author Notes:
		Inspired by my time at Hyland working with Phil Mosher and Brandon Rossin.
		GO Keyword does not require a semi-colon. As it would be redundant.
		BEGIN...END Blocks have been phased out completely for TRY...CATCH and GO.
        BEGIN TRANSACTION...COMMIT TRANSACTION Blocks to be used. As it is intended
            for the application to be running these statements. You MUST immediately
            COMMIT the TRANSACTION following the Statement(s) execution(s). This is
            to avoid erroneously leaving your cursor open.

  	BEST PRACTICES OF STORED PROCEDURES:
    	Use the SET NOCOUNT ON statement as the first statement in the body of the procedure. That is, place it just after the AS keyword. This turns off messages that SQL Server sends back to the client after any SELECT, INSERT, UPDATE, MERGE, and DELETE statements are executed. This keeps the output generated to a minimum for clarity. There is no measurable performance benefit however on today's hardware. For information, see SET NOCOUNT (Transact-SQL).
    	Use schema names when creating or referencing database objects in the procedure. It takes less processing time for the Database Engine to resolve object names if it doesn't have to search multiple schemas. It also prevents permission and access problems caused by a user's default schema being assigned when objects are created without specifying the schema.
    	Avoid wrapping functions around columns specified in the WHERE and JOIN clauses. Doing so makes the columns non-deterministic and prevents the query processor from using indexes.
    	Avoid using scalar functions in SELECT statements that return many rows of data. Because the scalar function must be applied to every row, the resulting behavior is like row-based processing and degrades performance.
    	Avoid the use of SELECT *. Instead, specify the required column names. This can prevent some Database Engine errors that stop procedure execution. For example, a SELECT * statement that returns data from a 12 column table and then inserts that data into a 12 column temporary table succeeds until the number or order of columns in either table is changed.
    	Avoid processing or returning too much data. Narrow the results as early as possible in the procedure code so that any subsequent operations performed by the procedure are done using the smallest data set possible. Send just the essential data to the client application. It is more efficient than sending extra data across the network and forcing the client application to work through unnecessarily large result sets.
    	Use explicit transactions by using BEGIN/COMMIT TRANSACTION and keep transactions as short as possible. Longer transactions mean longer record locking and a greater potential for deadlocking.
    	Use the Transact-SQL TRY...CATCH feature for error handling inside a procedure. TRY...CATCH can encapsulate an entire block of Transact-SQL statements. This not only creates less performance overhead, it also makes error reporting more accurate with significantly less programming.
    	Use the DEFAULT keyword on all table columns that are referenced by CREATE TABLE or ALTER TABLE Transact-SQL statements in the body of the procedure. This prevents passing NULL to columns that don't allow null values.
    	Use NULL or NOT NULL for each column in a temporary table. The ANSI_DFLT_ON and ANSI_DFLT_OFF options control the way the Database Engine assigns the NULL or NOT NULL attributes to columns when these attributes aren't specified in a CREATE TABLE or ALTER TABLE statement. If a connection executes a procedure with different settings for these options than the connection that created the procedure, the columns of the table created for the second connection can have different nullability and exhibit different behavior. If NULL or NOT NULL is explicitly stated for each column, the temporary tables are created by using the same nullability for all connections that execute the procedure.
    	Use modification statements that convert nulls and include logic that eliminates rows with null values from queries. Be aware that in Transact-SQL, NULL isn't an empty or "nothing" value. It is a placeholder for an unknown value and can cause unexpected behavior, especially when querying for result sets or using AGGREGATE functions.
    	Use the UNION ALL operator instead of the UNION or OR operators, unless there is a specific need for distinct values. The UNION ALL operator requires less processing overhead because duplicates aren't filtered out of the result set.
**/


CREATE TABLE #employeeTable
(
	EMP_ID INT IDENTITY(1,1) NOT NULL, --Only used for computations
	EMPLOYEE_ID AS N'EMP' + RIGHT('00000000' + CAST(EMP_ID AS NVARCHAR(8)),8) PERSISTED NOT NULL,
	EMPLOYEE_FIRST_NAME NVARCHAR(128) NULL,
	EMPLOYEE_MIDDLE_NAME NVARCHAR(128) NULL,
	EMPLOYEE_LAST_NAME NVARCHAR(128) NULL,
	EMPLOYEE_HONORIFICS NVARCHAR(3) NULL,
	EMPLOYEE_START_DATE DATETIME NULL,
	EMPLOYEE_TERMINATION_DATE DATETIME NULL,
	EMPLOYEE_ROLE_ID NVARCHAR(11) NULL,
	EMPLOYEE_MANAGER_ID NVARCHAR(11) NULL,
	EMPLOYEE_DEPARTMENT_ID NVARCHAR(11) NULL,
	CONSTRAINT Pk_EmpId PRIMARY KEY CLUSTERED (EMPLOYEE_ID),
	CHECK (LEN(EMPLOYEE_ID) = 11)
);


CREATE TABLE #managerTable
(
	MAN_ID INT IDENTITY(1,1) NOT NULL,
	MANAGER_ID AS N'MAN' + RIGHT('00000000' + CAST(MAN_ID AS NVARCHAR(8)),8) PERSISTED NOT NULL,
	MANAGER_FIRST_NAME NVARCHAR(128) NULL,
	MANAGER_MIDDLE_NAME NVARCHAR(128) NULL,
	MANAGER_LAST_NAME NVARCHAR(128) NULL,
	MANAGER_HONORIFICS NVARCHAR(3) NULL,
	MANAGER_TITLE NVARCHAR(128) NULL, --(Manager, Senior Manager, Director, Senior Director, VP, CEO)
	MANAGER_DEPARTMENT_ID NVARCHAR(11) NULL,
	MANAGER_TEAM_NAME NVARCHAR(128) NULL,
	CONSTRAINT Pk_ManId PRIMARY KEY CLUSTERED (MANAGER_ID),
	CHECK (LEN(MANAGER_ID) = 11)
);

CREATE TABLE #labelTable
(
	LAB_ID INT IDENTITY(1,1) NOT NULL,
	LABEL_ID AS N'LAB' + RIGHT('00000000' + CAST(LAB_ID AS NVARCHAR(8)), 8) PERSISTED NOT NULL,
	LABEL_NAME NVARCHAR(128) NOT NULL,
	LABEL_ESTABLISHED INT,
	LABEL_OWNER NVARCHAR(256),
	LABEL_MANAGER_ID NVARCHAR(11)
);

/*
	INSERT INTO #labelTable VALUES (N'',1970,N'',NULL);
*/

CREATE TABLE #bandTable
(
	BAN_ID INT IDENTITY(1,1) NOT NULL,
	BAND_ID AS N'BAN' + RIGHT('00000000' + CAST(BAN_ID AS NVARCHAR(8)), 8) PERSISTED NOT NULL,
	BAND_NAME NVARCHAR(128) NOT NULL,
	BAND_MEMBERS JSON NOT NULL, --This needs a plan to incorporate their assigned Unique IDs.
	BAND_LOGO_DESCRIPTION NVARCHAR(MAX)
);

/*
	INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')
*/

GO

INSERT INTO #employeeTable VALUES (N'Jimi',NULL,N'Hendrix',NULL,CURRENT_TIME_STAMP,NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Nick',NULL,N'Mason',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Waters',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Wright',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Clive',NULL,N'Metcalfe',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Noble',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Sheilagh',NULL,N'Noble',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vernon',NULL,N'Thompson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Dennis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Juliette',NULL,N'Gale',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Klose',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Syd',NULL,N'Barrett',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Gilmour',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Squire',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jon',NULL,N'Anderson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Kaye',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Bruford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Banks',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'O''Reilly',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Howe',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Wakeman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alan',NULL,N'White',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Patrick',NULL,N'Moraz',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Trevor',NULL,N'Horn',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Geoffrew',NULL,N'Downes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eddie',NULL,N'Jobson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'Sherwood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Igor',NULL,N'Khoroshev',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Benoit',NULL,N'David',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Oliver',NULL,N'Wakeman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jon',NULL,N'Davison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jay',NULL,N'Schellen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Bowie',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gregg',NULL,N'Allman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Butch',NULL,N'Trucks',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Duane',NULL,N'Allman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Betts',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Berry',NULL,N'Oakley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jai Johanny',NULL,N'Johanson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chuck',NULL,N'Leavell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lamar',NULL,N'Williams',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dan',NULL,N'Toler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Goldflies',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Lawler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David Frankie',NULL,N'Toler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Warren',NULL,N'Haynes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Johnny',NULL,N'Neel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Allen',NULL,N'Woody',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Marc',NULL,N'Quinones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jack',NULL,N'Pearson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Oteil',NULL,N'Burbridge',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Derek',NULL,N'Trucks',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Herring',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Banks',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Rutherford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Gabriel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Anthony',NULL,N'Phillips',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Stewart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Silver',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Mayhew',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Collins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Hackett',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ray',NULL,N'Wilson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Page',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Plant',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Bonham',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John Paul',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Young',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tonny',NULL,N'Iommi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Geezer',NULL,N'Butler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Ward',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ozzy',NULL,N'Osbourne',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Walker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Craig',NULL,N'Gruber',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Geoff',NULL,N'Nicholls',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ronnie James',NULL,N'Dio',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vinny',NULL,N'Appice',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Gillan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bev',NULL,N'Bevan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Donato',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ron',NULL,N'Keel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gordon',NULL,N'Copley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Glenn',NULL,N'Hughes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Spitz',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eric',NULL,N'Singer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ray',NULL,N'Gillen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Daisley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Martin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Terry',NULL,N'Chimes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jo',NULL,N'Burt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Laurence',NULL,N'Cottle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cozy',NULL,N'Powell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Murray',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bobby',NULL,N'Rondinelli',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Daultrey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roy',NULL,N'Ellis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'James',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Entwisle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pete',NULL,N'Townshend',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Doug',NULL,N'Sandom',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kenney',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alex',NULL,N'Lifeson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Rutsey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jeff',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Geddy',NULL,N'Lee',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lindy',NULL,N'Young',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Joe',NULL,N'Perna',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mitch',NULL,N'Bossi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Peart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bruce',NULL,N'Springsteen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Anderson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Abrahams',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Glenn',NULL,N'Cornick',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Clive',NULL,N'Bunker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Iommi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Martin',NULL,N'Barre',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Evans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jeffrey',NULL,N'Hammond',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Barriemore',NULL,N'Barlow',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Glascock',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dee',NULL,N'Palmer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Pegg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Craney',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter-John',NULL,N'Vettese',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gerry',NULL,N'Conway',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Doane',NULL,N'Perry',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Maartin',NULL,N'Allcock',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andrew',NULL,N'Giddings',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jonathan',NULL,N'Noyce',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Goodier',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'O''Hara',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Scott',NULL,N'Hammond',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Florian',NULL,N'Opahle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Joe',NULL,N'Parrish-James',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jack',NULL,N'Clark',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pye',NULL,N'Hastings',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Coughlan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Sinclair',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Sinclair',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Miller',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Derek',NULL,N'Austin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Geoffrey',NULL,N'Richardson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',N'G.',N'Perry',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Wedgewood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jan',NULL,N'Schelhaas',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dek',NULL,N'Messecar',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'Leverton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Hastings',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Simon',NULL,N'Bentall',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Doug',NULL,N'Boyle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Walker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Stevie',NULL,N'Wonder',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Irmin',NULL,N'Schmidt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Karoli',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Holger',NULL,N'Czukay',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',N'C.',N'Johnson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Malcolm',NULL,N'Mooney',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Damo',NULL,N'Suzuki',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Cousins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rosko',NULL,N'Gee',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Anthony',N'Reebop Kwaku',N'Baah',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Fripp',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'McDonald',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Greg',NULL,N'Lake',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Giles',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Sinfield',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gordon',NULL,N'Haskell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'McCulloch',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mel',NULL,N'Collins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Boz',NULL,N'Burrell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Wallace',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jamie',NULL,N'Muir',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Wetton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Cross',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Bruford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Levin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Adrian',NULL,N'Belew',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Trey',NULL,N'Gunn',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pat',NULL,N'Mastelotto',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gavin',NULL,N'Harrison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Rieflin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jakko',N'M.',N'Jakszyk',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jeremy',NULL,N'Stacey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Hammill',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Judge',NULL,N'Smith',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Nick',NULL,N'Pearne',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Hugh',NULL,N'Baton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Guy',NULL,N'Evans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Ellis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Nic',NULL,N'Potter',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Jackson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Graham',NULL,N'Smith',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Charles',NULL,N'Dickie',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Paice',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jon',NULL,N'Lord',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Nick',NULL,N'Simper',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rod',NULL,N'Evans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Glover',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Gillan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Coverdale',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Glenn',NULL,N'Hughes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tommy',NULL,N'Bolin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Curtis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Hook',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Stephen',NULL,N'Morris',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bernard',NULL,N'Sumner',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Byrne',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Frantz',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tina',NULL,N'Weymouth',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jerry',NULL,N'Harrison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Donald',NULL,N'Fagen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Walter',NULL,N'Becker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Denny',NULL,N'Dias',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Skunk',NULL,N'Baxter',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'Hodder',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Palmer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Royce',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'McDonald',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jeff',NULL,N'Porcaro',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Frank',NULL,N'Zappa',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Elvis',NULL,N'Costello',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jerry',NULL,N'Garcia',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Weir',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Kreutzmann',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ronald',N'Charles',N'McKernan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dana',NULL,N'Morgan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Lesh',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mickey',NULL,N'Hart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Constanten',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ketih',NULL,N'Godchaux',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Donna',N'Jean',N'Godchaux',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Brent',NULL,N'Mydland',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bruce',NULL,N'Hornsby',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vince',NULL,N'Welnick',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ralf',NULL,N'Hütter',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Florian',NULL,N'Schneider',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Houschäng',NULL,N'Nejadépour',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Scmidt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Charly',NULL,N'Weiss',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Thomas',NULL,N'Lohmann',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andreas',NULL,N'Hohmann',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eberhard',NULL,N'Kranemann',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Klaus',NULL,N'Dinger',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Rother',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Plato',NULL,N'Kostic',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Emil',NULL,N'Schult',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Wolfgang',NULL,N'Flür',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Klaus',NULL,N'Röder',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Karl',NULL,N'Bartos',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Fritz',NULL,N'Hilpert',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Fernando',NULL,N'Abrantes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Henning',NULL,N'Schmitz',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Falk',NULL,N'Grieffenhagen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Stafan',NULL,N'Pfaffe',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Georg',NULL,N'Bongantz',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Iggy',NULL,N'Pop',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Scott',NULL,N'Asheton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ron',NULL,N'Asheton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Alexander',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Mackay',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Zeke',NULL,N'Zettner',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Cheatham',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'James',NULL,N'Williamson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Recca',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Sheff',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Warren',NULL,N'Klein',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Scott',NULL,N'Thurston',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Watt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Emerson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Greg',NULL,N'Lake',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Carl',NULL,N'Palmer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Brian',NULL,N'Eno',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Joe',NULL,N'Strummer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Simonon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Terry',NULL,N'Chimes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Levene',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Topper',NULL,N'Headon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pete',NULL,N'Howard',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Nick',NULL,N'Sheppard',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vince',NULL,N'White',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Sly',NULL,N'Stone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cynthia',NULL,N'Robinson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Greg',NULL,N'Errico',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Larry',NULL,N'Graham',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Freddie',NULL,N'Stone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jerry',NULL,N'Martini',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rose',NULL,N'Stone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vet',NULL,N'Stone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mary',NULL,N'McCreary',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Elva',NULL,N'Mouton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gerry',NULL,N'Gibson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pat',NULL,N'Rizzo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rusty',NULL,N'Allen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Newmark',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Lordan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vicki',NULL,N'Blackwell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'Strassburg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ritchie',NULL,N'Blackmore',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ronnie',N'James',N'Dio',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Craig',NULL,N'Gruber',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Micky',N'Lee',N'Soule',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gary',NULL,N'Driscoll',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cozy',NULL,N'Powell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Bain',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Carey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Stone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Clarke',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Daisley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Clive',NULL,N'Chamen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jack',NULL,N'Green',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Graham',NULL,N'Bonnet',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Don',NULL,N'Airey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Glover',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bobby',NULL,N'Rondinelli',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Joe',N'Lynn',N'Turner',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Rosenthal',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chuck',NULL,N'Burgi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'O''Reilly',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Doogie',NULL,N'White',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Greg',NULL,N'Smith',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Morris',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Miceli',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ronnie',NULL,N'Romero',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jens',NULL,N'Johansson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Nouveau',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Keith',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'George',NULL,N'Harrison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Jagger',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Richards',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Brian',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Stewart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dick',NULL,N'Taylor',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Chapman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Avory',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Wyman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Charlie',NULL,N'Watts',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Taylor',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ronnie',NULL,N'Wood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Mogg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pete',NULL,N'Way',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Bolton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Colin',NULL,N'Turner',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Parker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Larry',NULL,N'Wallis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bernie',NULL,N'Marsden',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Schenker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Chapman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Danny',NULL,N'Peyronel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Raymond',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Sloman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Carter',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'Sheehan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Gray',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tommy',NULL,N'McLendon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robbie',NULL,N'France',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'Simpson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Jacobsen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Myke',NULL,N'Gray',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Fabio',N'Del',N'Rio',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rik',NULL,N'Sanford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Glidwell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Laurence',NULL,N'Archer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Clive',NULL,N'Edwards',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jem',NULL,N'Davis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Simon',NULL,N'Wright',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Aynsley',NULL,N'Dunbar',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vinnie',NULL,N'Moore',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jason',NULL,N'Bonham',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rob',N'De',N'Luca',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Carlos',NULL,N'Santana',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gregg',NULL,N'Rolie',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Carabello',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Frazier',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gus',NULL,N'Rodriguez',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rod',NULL,N'Harper',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Marcus',NULL,N'Malone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Brown',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',N'Doc',N'Livingston',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jose',N'Chepito',N'Areas',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Shrieve',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Francisco',NULL,N'Aguabella',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Neal',NULL,N'Schon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Rutley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rico',NULL,N'Reyes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Victor',NULL,N'Pantoja',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Coke',NULL,N'Escovedo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pete',NULL,N'Escovedo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Coster',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Kermode',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Doug',NULL,N'Rauch',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mingo',NULL,N'Lewis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Leon',NULL,N'Thomas',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Leon',N'Ndugu',N'Chancler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Leon',NULL,N'Patillo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jules',NULL,N'Broussard',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Greg',NULL,N'Walker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Raul',NULL,N'Rekow',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Armando',NULL,N'Peraza',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gaylord',NULL,N'Birch',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Graham',NULL,N'Lear',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Luther',NULL,N'Rabb',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Byron',NULL,N'Miller',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pablo',NULL,N'Tellez',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Margen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Solberg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Rhyne',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Russel',NULL,N'Tubbs',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alex',NULL,N'Ligertwood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alan',NULL,N'Pasqua',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Orestes',NULL,N'Vilató',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Baker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chester',NULL,N'Thompson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Sancious',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chester',NULL,N'Thompson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Sancious',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chester',NULL,N'Thompson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alphonso',NULL,N'Johnson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Sterling',NULL,N'Crew',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Buddy',NULL,N'Miles',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Walfredo',NULL,N'Reyes',N'Jr.',DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Benny',NULL,N'Reitveld',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Karl',NULL,N'Perazzo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'Johnson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Lindsay',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Myron',NULL,N'Dove',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vorriece',NULL,N'Cooper',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Oran',NULL,N'Coltrane',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rodney',NULL,N'Holmes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tommy',NULL,N'Bradford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Curtis',NULL,N'Salgado',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Horacio',N'El Negro',N'Hernández',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ricky',NULL,N'Wellman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dennis',NULL,N'Chambers',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Ortiz',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jeff',NULL,N'Cressman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Vargas',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tommy',NULL,N'Anthony',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Freddie',NULL,N'Ravel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',N'K.',N'Mathews',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paoli',NULL,N'Mejías',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jose',N'Pepe',N'Jimenez',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cindy',NULL,N'Blackman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ray',NULL,N'Greene',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Davies',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Hodgson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Palmer-James',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Millar',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Withrop',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kevin',NULL,N'Currie',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Frank',NULL,N'Farrell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dougie',NULL,N'Thomson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Siebenberg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Helliwell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Hart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Carl',NULL,N'Verheyen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lee',NULL,N'Thornburg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Walsh',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cliff',NULL,N'Hugo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jesse',NULL,N'Siebenberg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gabe',NULL,N'Dixon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cassie',NULL,N'Miller',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bryan',NULL,N'Ferry',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Mackay',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Graham',NULL,N'Simpson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Brian',NULL,N'Eno',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dexter',NULL,N'Lloyd',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Bunn',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Thompson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Davy',NULL,N'O''List',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Manzanera',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rik',NULL,N'Kenton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Porter',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Sal',NULL,N'Maida',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eddie',NULL,N'Jobson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Gustafson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Willis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Wetton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gary',NULL,N'Tibbs',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Carrack',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alan',NULL,N'Spenner',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Newmark',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Ratledge',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Wyatt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kevin',NULL,N'Ayers',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Daevid',NULL,N'Allen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Summ,ers',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Hugh',NULL,N'Hopper',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Elton',NULL,N'Dean',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lyn',NULL,N'Dobson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Charig',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Nick',NULL,N'Evans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Howard',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Marshall',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Karl',NULL,N'Jenkins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roy',NULL,N'Babbington',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Allan',NULL,N'Holdsworth',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Etheridge',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alan',NULL,N'Wakeman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ray',NULL,N'Warleigh',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ric',NULL,N'Sanders',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Cook',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'MacRae',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Carmichael',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Theo',NULL,N'Travis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Fred',N'Thelonious',N'Baker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Asaf',NULL,N'Sirkis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andrew',NULL,N'Latimer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Doug',NULL,N'Ferguson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Ward',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pete',NULL,N'Bardens',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mel',NULL,N'Collins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Sinclair',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kit',NULL,N'Watkins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Colin',NULL,N'Bass',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Rainbow',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Paton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Dalby',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ton',NULL,N'Scherpenzeel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Burgess',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mickey',NULL,N'Simmonds',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Stewart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Foss',NULL,N'Patterson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Guy',NULL,N'LeBlanc',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dennis',NULL,N'Clement',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jason',NULL,N'Hart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pete',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Brian',NULL,N'May',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Taylor',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Freddie',NULL,N'Mercury',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Grose',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Barry',NULL,N'Mitchell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Doug',NULL,N'Bogie',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Deacon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gary',NULL,N'Rossington',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ronnie',N'Van',N'Zant',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Allen',NULL,N'Collins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Burns',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Larry',NULL,N'Junstrom',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rickey',NULL,N'Medlocke',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Greg',N'T.',N'Walker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'Powell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ed',NULL,N'King',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Leon',NULL,N'Wilkenson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Artimus',NULL,N'Pyle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cassie',NULL,N'Gaines',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jo',N'Jo',N'Billingsley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Leslie',NULL,N'Hawkins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Gaines',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Johnny',N'Van',N'Zant',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dale',N'Krantz',N'Rossington',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Carol',NULL,N'Bristow',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Randall',NULL,N'Hall',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kurt',NULL,N'Custer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Debbie',NULL,N'Bailey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Estes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Owen',NULL,N'Hale',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Debbie',NULL,N'Davis-Estes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Hughie',NULL,N'Thomasson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Carol',NULL,N'Chase',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jeff',NULL,N'McAllister',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Cartellone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ean',NULL,N'Evans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Matejka',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Kearns',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Keys',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Johnny',NULL,N'Colt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Dylan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Lennon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Verlaine',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'Ficca',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Hell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Lloyd',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Fred',NULL,N'Smith',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Rip',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Derek',NULL,N'Shulman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ray',NULL,N'Shulman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kerry',NULL,N'Minnear',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gary',NULL,N'Green',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Shulman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Martin',NULL,N'Smith',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Malcom',NULL,N'Moritmore',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Weathers',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Wyatt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Patti',NULL,N'Smith',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'George',NULL,N'Clinton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ray',NULL,N'Davis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Clarence',N'Fuzzy',N'Haskins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Calvin',NULL,N'Simon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Grady',NULL,N'Thomas',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tiki',NULL,N'Fulwood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eddie',NULL,N'Hazel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tal',NULL,N'Ross',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'Nelson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mickey',NULL,N'Atkins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bernie',NULL,N'Worrell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Frank',NULL,N'Waddy',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bootsy',NULL,N'Collins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Catfish',NULL,N'Collins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Garry',NULL,N'Shider',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cordell',NULL,N'Mosson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tyrone',NULL,N'Lampkin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ron',NULL,N'Bykowski',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'James',N'Wesley',N'Jackson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Fred',NULL,N'Wesley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Maceo',NULL,N'Parker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Maichael',NULL,N'Hampton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Glenn',NULL,N'Goins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jerome',N'Big Foot',N'Bradley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Walter',N'Junie',N'Morrison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Marc',NULL,N'Bolan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',N'Peregrine',N'Took',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ben',NULL,N'Cartland',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mickey',NULL,N'Finn',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Currie',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Legend',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Fenton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gloria',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jack',NULL,N'Green',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Lutton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dino',NULL,N'Dines',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Miller',NULL,N'Anderson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Herbie',NULL,N'Flowers',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Newman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Hill',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'K.',N'K.',N'Downing',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Ellis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Al',NULL,N'Atkins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alan',NULL,N'Moore',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Campbell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Hinch',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rob',NULL,N'Halford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Glenn',NULL,N'Tipton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Les',NULL,N'Binks',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Holland',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Scott',NULL,N'Travis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tim',N'Ripper',N'Owens',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richie',NULL,N'Faulkner',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Nick',NULL,N'Drake',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Crosby',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Stephen',NULL,N'Stills',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Graham',NULL,N'Nash',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Young',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Box',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Byron',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Colin',NULL,N'Wood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ken',NULL,N'Hensley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Newton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alex',NULL,N'Napier',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Nigel',NULL,N'Olsson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Baker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Clark',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Clarke',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lee',NULL,N'Kerslake',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gary',NULL,N'Thain',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Wetton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Lawton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Trevor',NULL,N'Bolder',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Sloman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Slade',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gregg',NULL,N'Dechert',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Sinclair',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Goalby',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Daisley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Lanzon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steff',NULL,N'Fontaine',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bernie',NULL,N'Shaw',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Russell',NULL,N'Gilbrook',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Rimmer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Weller',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Buckler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Brookes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Waller',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bruce',NULL,N'Foxton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vittorio',NULL,N'Nocenzi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gianni',NULL,N'Nocenzi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Fabrizio',NULL,N'Falco',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Franco',NULL,N'Coletta',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mario',NULL,N'Achilli',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Claudio',NULL,N'Falco',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Franco',NULL,N'Pontecorvi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Francesco',N'Di',N'Giacomo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Periluigi',NULL,N'Caulderoni',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Renato',NULL,N'D''Angelo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Marcello',NULL,N'Todaro',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rodolfo',NULL,N'Maltese',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gianni',NULL,N'Colaiacomo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Karl',NULL,N'Potter',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gabriel',NULL,N'Amato',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tiziano',NULL,N'Ricci',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cinzia',NULL,N'Nocenzi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pietro',NULL,N'Letti',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Flippo',NULL,N'Marcheggiani',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Maurizio',NULL,N'Masi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alessandro',NULL,N'Papotto',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'D''Alessio',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Van',NULL,N'Morrison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jorge',NULL,N'Ben',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gene',NULL,N'Clark',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pete',NULL,N'Shelley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Howard',NULL,N'Devoto',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Garth',NULL,N'Smith',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Singleton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Diggle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Maher',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Barry',NULL,N'Adamson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Garvey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Joyce',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Gibson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Barber',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Barker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Danny',NULL,N'Farrant',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Remmington',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rory',NULL,N'Gallagher',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Serge',NULL,N'Gainsbourg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eric',NULL,N'Bloom',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Buck',NULL,N'Dharma',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Joe',NULL,N'Bouchard',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Allen',NULL,N'Lanier',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Albert',NULL,N'Bouchard',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Downey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Thommy',NULL,N'Price',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tommy',NULL,N'Zvoncheck',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Wilcox',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jon',NULL,N'Rogers',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ron',NULL,N'Riddle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chuck',NULL,N'Burgi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Danny',NULL,N'Miranda',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'O''Reilly',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bobby',NULL,N'Rondinelli',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richie',NULL,N'Castellano',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jules',NULL,N'Radino',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rudy',NULL,N'Sarzo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kasmin',NULL,N'Sulton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ric',NULL,N'Ocasek',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Elliot',NULL,N'Easton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Greg',NULL,N'Hawkes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Robinson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Benjamin',NULL,N'Orr',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Caeton',NULL,N'Veloso',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Garth',NULL,N'Hudson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Danko',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Levon',NULL,N'Helm',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Manuel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robbie',NULL,N'Robertson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'Weider',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Randy',NULL,N'Ciarlante',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Stan',NULL,N'Szelest',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Bell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Waits',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jody',NULL,N'Stephens',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alex',NULL,N'Chilton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Bell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Hummel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Lightman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ken',NULL,N'Stringfellow',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jon',NULL,N'Auer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Thijs',N'Van',N'Leer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jan',NULL,N'Akkerman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Hans',NULL,N'Cleuver',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Martin',NULL,N'Dresden',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pierre',N'Van Der',N'Linden',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cyril',NULL,N'Havermans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bert',NULL,N'Ruiter',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Colin',NULL,N'Allen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Kemper',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Catherine',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eef',NULL,N'Albers',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Menno',NULL,N'Gootjes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bobby',NULL,N'Jacobs',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jan',NULL,N'Dumée',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ruben',N'Van',N'Roon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bert',NULL,N'Smaak',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Niels',N'Van Der',N'Steenhoven',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Udo',NULL,N'Pannekeet',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Franco',NULL,N'Mussida',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Franz',N'Di',N'Ciocci',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Flavio',NULL,N'Premoli',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mauro',NULL,N'Pagani',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Giorgio',NULL,N'Piazza',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Patrick',NULL,N'Djivas',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bernardo',NULL,N'Lanzetti',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roberto',NULL,N'Colombo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lucio',N'Violino',N'Fabbri',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Walter',NULL,N'Calloni',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Gualdi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Drummy',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alessandro',NULL,N'Bonetti',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alessandro',NULL,N'Scaglione',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Marco',NULL,N'Sfogli',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alberto',NULL,N'Bravin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eric',NULL,N'Clapton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bobby',NULL,N'Whitlock',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'Gordon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Carl',NULL,N'Radle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Mason',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Syd',NULL,N'Barrett',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Brock',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Nik',NULL,N'Turner',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Terry',NULL,N'Ollis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Davies',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Harrison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Slattery',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vic',NULL,N'Vergat',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Huw',NULL,N'Lloyd-Langton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Thomas',NULL,N'Crimble',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Anderson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Del',NULL,N'Dettmar',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Calvert',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ian',N'Lemmy',N'Kilmister',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Simon',NULL,N'King',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Simon',NULL,N'House',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alan',NULL,N'Powell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Rudolph',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Adrian',NULL,N'Shaw',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Harvey',NULL,N'Bainbridge',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tim',NULL,N'Blake',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ginger',NULL,N'Baker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Jale',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Anderson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Martin',NULL,N'Griffin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rob',NULL,N'Heaton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dead',NULL,N'Fred',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Martinez',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Clive',NULL,N'Deamer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alan',NULL,N'Davey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Danny',NULL,N'Thompson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Chadwick',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bridget',NULL,N'Wishart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ron',NULL,N'Tree',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jerry',NULL,N'Richards',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jason',NULL,N'Stuart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mr',NULL,N'Dibs',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Niall',NULL,N'Hone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Magnus',NULL,N'Martin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Timothy',NULL,N'Lewis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Doug',NULL,N'MacKinnon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'McCartney',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Brian',NULL,N'Downey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Lynott',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eric',NULL,N'Bell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eric',NULL,N'Wrixon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gary',NULL,N'Moore',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',N'Du',N'Can',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Gee',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Scott',NULL,N'Gorham',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Brian',NULL,N'Robertson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Nauseef',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Flett',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Midge',NULL,N'Ure',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Snowy',NULL,N'White',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Darren',NULL,N'Wharton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Sykes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Marco',NULL,N'Mendoza',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tommy',NULL,N'Aldridge',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Lee',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Guy',NULL,N'Pratt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Randy',NULL,N'Gregg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Francesco',NULL,N'DiCosmo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ricky',NULL,N'Warwick',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vivian',NULL,N'Campbell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Fortus',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Damon',NULL,N'Johnson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mikkey',NULL,N'Dee',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Hamilton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Scott',NULL,N'Travis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Oldfield',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lou',NULL,N'Reed',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Nielsen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bun',N'E.',N'Carlos',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Petersson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Randy',NULL,N'Hogan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robin',NULL,N'Zander',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pete',NULL,N'Comita',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jon',NULL,N'Brant',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Daxx',NULL,N'Nielsen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roye',NULL,N'Albrington',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Allan',NULL,N'Freeman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Derek',NULL,N'Moore',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ron',NULL,N'Howden',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Brockett',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Nelson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Prater',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Carmine',NULL,N'Rojas',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ray',NULL,N'Hardwick',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Randy',NULL,N'Dembo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Hughes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Pichl',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Klaus',NULL,N'Henatsch',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lux',NULL,N'Vibratus',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ryche',NULL,N'Chlanda',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kendall',NULL,N'Scott',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'McCarty',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Relf',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Hawken',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Terry',NULL,N'Crowe',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Terry',NULL,N'Slade',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Korner',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Dunford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Anne-Marie',N'Binky',N'Cullom',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Tout',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Annie',NULL,N'Haslam',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Danny',NULL,N'McCulloch',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Frank',NULL,N'Farrell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Wetton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jon',NULL,N'Camp',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Parsons',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ginger',NULL,N'Dixon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Terence',NULL,N'Sullivan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rob',NULL,N'Hendry',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Finberg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gavin',NULL,N'Harrison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Taylor',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Greg',NULL,N'Carter',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Raphael',NULL,N'Rudd',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Lampariello',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Charles',NULL,N'Descarfino',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mickey',NULL,N'Simmonds',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rave',NULL,N'Tesar',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',N'J.',N'Keyes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Brislin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Frank',NULL,N'Pagano',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jason',NULL,N'Hart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ryche',NULL,N'Chlanda',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Leo',NULL,N'Traversa',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Geoffrey',NULL,N'Langley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Arbo',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Martyn',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Iggy',NULL,N'Pop',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Fleetwood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Green',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Brunning',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jeremy',NULL,N'Spencer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'McVie',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Danny',NULL,N'Kirwan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Christine',NULL,N'McVie',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Welch',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Weston',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Walker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lindsey',NULL,N'Buckingham',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Stevie',NULL,N'Nicks',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'Burnette',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Vito',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Mason',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bekka',NULL,N'Bramlett',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Finn',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Campbell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alice',NULL,N'Cooper',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rudolf',NULL,N'Schenker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Wolfgang',NULL,N'Dziony',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Karl-Heinz',NULL,N'Vollmer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Werner',NULL,N'Hoyer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Harald',NULL,N'Grosskopf',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lothar',NULL,N'Heimberg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ulrich',NULL,N'Worobiec',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bernd',NULL,N'Hegner',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Klaus',NULL,N'Meine',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Schenker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Werner',NULL,N'Löhr',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Joe',NULL,N'Wyman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Helmut',NULL,N'Eisenhut',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Uli',N'Jon',N'Roth',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Achim',NULL,N'Kirschning',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Francis',NULL,N'Buchholz',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jürgen',NULL,N'Rosenthal',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jürgen',NULL,N'Fechter',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rudy',NULL,N'Lenners',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Herman',NULL,N'Rarebell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Matthias',NULL,N'Jabs',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ralph',NULL,N'Rieckermann',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'James',NULL,N'Kottak',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Curt',NULL,N'Cress',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ken',NULL,N'Taylor',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paweł',NULL,N'Mąciwoda',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mikkey',NULL,N'Dee',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Winwod',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'Capaldi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Wood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Mason',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Grech',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Anthony',N'Reebop Kwaku',N'Baah',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'Gordon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Hood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Hawkins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Barry',NULL,N'Beckett',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rosko',NULL,N'Gee',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Randall',NULL,N'Bramblett',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'McEvoy',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Walfredo',NULL,N'Reyes',N'Jr.',DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jeff',NULL,N'Lynne',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bev',NULL,N'Bevan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Roy',NULL,N'Wood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Hunt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Woolam',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Tandy',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'Craig',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'High',NULL,N'McDowell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Edwards',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Wilf',NULL,N'Gibson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',N'de',N'Albuquerque',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Colin',NULL,N'Walker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mik',NULL,N'Kaminski',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kelly',NULL,N'Groucutt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Melvyn',NULL,N'Gale',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Deborah',NULL,N'Harry',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Stein',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Clem',NULL,N'Burke',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'O''Connor',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Destri',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gary',NULL,N'Valentine',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Frank',NULL,N'Infante',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Nigel',NULL,N'Harrison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Leigh',NULL,N'Foxx',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Carbonara',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kevin',NULL,N'Patrick',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Matt',NULL,N'Katz-Bohen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tommy',NULL,N'Kessler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Joey',NULL,N'Ramone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Johnny',NULL,N'Ramone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dee Dee',NULL,N'Ramone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tommy',NULL,N'Ramone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Marky',NULL,N'Ramone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Richie',NULL,N'Ramone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'C.',N'J.',N'Ramone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Zappi',N'W.',N'Diermaier',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Hans',N'Joachim',N'Irmler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jean-Hervé',NULL,N'Peron',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rudolf',NULL,N'Sosna',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gunther',NULL,N'Wüsthoff',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Arnulf',NULL,N'Meifert',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Blegvad',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Uli',NULL,N'Trepte',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steven',N'Wray',N'Lobdell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Stoll',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lars',NULL,N'Paukstat',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Amaury',NULL,N'Cambuzat',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Olivier',NULL,N'Manchion',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jan',NULL,N'Fride',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keef',NULL,N'Roberts',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Elvis',NULL,N'Presley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Petty',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Campbell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Benmont',NULL,N'Tench',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ron',NULL,N'Blair',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Stan',NULL,N'Lynch',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Howie',NULL,N'Epstein',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Scott',NULL,N'Thurston',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Ferrone',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Barry',NULL,N'Gibb',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robin',NULL,N'Gibb',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Maurice',NULL,N'Gibb',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vince',NULL,N'Melouney',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Colin',NULL,N'Petersen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Geoff',NULL,N'Bridgford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rich',NULL,N'Williams',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Ehart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Walsh',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robby',NULL,N'Steinhardt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Hope',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Kerry',NULL,N'Livgreen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Elefante',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Morse',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'Greer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Greg',NULL,N'Robert',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Ragsdale',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Manion',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ronnie',NULL,N'Platt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Zak',NULL,N'Rizvi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tom',NULL,N'Brislin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Joe',NULL,N'Deninzon',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'Joel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Knopflier',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Illsley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Pick',NULL,N'Withers',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Knopflier',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Hal',NULL,N'Lindes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Alan',NULL,N'Clark',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Terry',NULL,N'Williams',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Guy',NULL,N'Fletcher',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jack',NULL,N'Sonni',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'Croce',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Angus',NULL,N'Young',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Malcolm',NULL,N'Young',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Evans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Colin',NULL,N'Burgess',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Larry',N'Van',N'Kriedt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Noel',NULL,N'Taylor',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Clark',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Rob',NULL,N'Bailey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bon',NULL,N'Scott',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Rudd',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Evans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Cliff',NULL,N'Williams',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Brian',NULL,N'Johnson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Simon',NULL,N'Wright',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Slade',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Stevie',NULL,N'Young',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Elton',NULL,N'John',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Lamm',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'James',NULL,N'Pankow',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lee',NULL,N'Loughnane',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Walter',NULL,N'Parazaider',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Danny',NULL,N'Seraphine',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Cetera',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Terry',NULL,N'Kath',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Laudir',N'De',N'Oliveira',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Donnie',NULL,N'Dacus`',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Pinnick',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Champlin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jason',NULL,N'Scheff',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Dawayne',NULL,N'Bailey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tris',NULL,N'Imboden',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Howland',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Lou',NULL,N'Pardini',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Drew',NULL,N'Hester',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Daniel',N'De Los',N'Reyes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Walfredo',NULL,N'Reyes',N'Jr.',DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Jeff',NULL,N'Coffey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ray',NULL,N'Hermann',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Donell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Brett',NULL,N'Simons',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Raymon',N'Ray',N'Yslas',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Paul',NULL,N'Stanley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Gene',NULL,N'Simmons',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Criss',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Ace',NULL,N'Frehley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eric',NULL,N'Carr',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Vinnie',NULL,N'Vincent',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Mark',N'St.',N'John',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Bruce',NULL,N'Kutlick',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Eric',NULL,N'Singer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);
INSERT INTO #employeeTable VALUES (N'Tommy',NULL,N'Thayer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL);

GO

INSERT INTO #labelTable VALUES (N'Red Label',1970,N'Bilbo Baggins',NULL);
INSERT INTO #labelTable VALUES (N'Yellow Label',1970,N'Elrond of Rivendell',NULL);
INSERT INTO #labelTable VALUES (N'Blue Label',1970,N'Peregrin Took',NULL);
INSERT INTO #labelTable VALUES (N'Green Label',1970,N'Frodo Baggins',NULL);
INSERT INTO #labelTable VALUES (N'Grey Label',1970,N'Ring Wraiths',NULL);
INSERT INTO #labelTable VALUES (N'Black Label',1970,N'Samwise Gamgee',NULL);
INSERT INTO #labelTable VALUES (N'Orange Label',1970,N'Thorin Oakenshield',NULL);
INSERT INTO #labelTable VALUES (N'Magenta Label',1970,N'Tom Bombadil',NULL);
INSERT INTO #labelTable VALUES (N'Turquoise Label',1970,N'Treebeard of Ents',NULL);
INSERT INTO #labelTable VALUES (N'Cyan Label',1970,N'Ungoliant of Shelob',NULL);

GO

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Pink Floyd',1,N'[
		{
			"Band_Name":"Pink Floyd"
			"Band_Members":[
				{
					"Singer Name":"Roger Waters",
					"Drummer":"Nick Mason",
					"Keyboard":"Richard Wright",
					"Bass":"David Gilmour",
					"Guitar":"Syd Barrett"
				}
				]
			}
		]', N'Light through a Prism emitting a rainbow with their name in white letters, Pink on the top and Floyd on the bottom')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

INSERT INTO #bandTable VALUES (N'Jimi Hendrix',1,N'[
		{
			"Band_Name":"Jimi Hendrix"
			"Band_Members":[
				{
					"Singer Name":"Jimi Hendrix"
				}
				]
			}
		]', N'Jimi Hendrix''s name in Hendrix Groove Font')

GO
