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
		17. Pink Floyd, https://rateyourmusic.com/artist/pink-floyd
		18. Yes, https://rateyourmusic.com/artist/yes
		19. David Bowie, https://rateyourmusic.com/artist/david-bowie
		20. The Allman Brothers Band, https://rateyourmusic.com/artist/the-allman-brothers-band
		21. Gensis, https://rateyourmusic.com/artist/genesis
		22. Led Zeppelin, https://rateyourmusic.com/artist/led-zeppelin
		23. Neil Young, https://rateyourmusic.com/artist/neil-young
		24. Black Sabbath, https://rateyourmusic.com/artist/black-sabbath
		25. The Who, https://rateyourmusic.com/artist/the-who
		26. Rush, https://rateyourmusic.com/artist/rush
		27. Bruce Springsteen, https://rateyourmusic.com/artist/bruce-springsteen
		28. Jethro Tull, https://rateyourmusic.com/artist/jethro-tull,
		29. Caravan, https://rateyourmusic.com/artist/caravan
		30. Stevie Wonder, https://rateyourmusic.com/artist/stevie-wonder
		31. Can, https://rateyourmusic.com/artist/can
		32. King Crimson, https://rateyourmusic.com/artist/king-crimson
		33. RAND (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/functions/rand-transact-sql?view=sql-server-ver16
		34. Van der Graaf Generator, https://rateyourmusic.com/artist/van-der-graaf-generator
		35. Deep Purple, https://rateyourmusic.com/artist/deep-purple
		36. Joy Division, https://rateyourmusic.com/artist/joy-division

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
	EMPLOYEE_HONORIFICS NVARCHAR(128) NULL,
	EMPLOYEE_START_DATE DATETIME NULL,
	EMPLOYEE_TERMINATION_DATE DATETIME NULL,
	EMPLOYEE_ROLE_ID NVARCHAR(11) NULL,
	EMPLOYEE_MANAGER_ID NVARCHAR(11) NULL,
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
	MANAGER_HONORIFICS NVARCHAR(128) NULL,
	MANAGER_TITLE NVARCHAR(128) NULL,
	MANAGER_DEPARTMENT NVARCHAR(128) NULL,
	MANAGER_TEAM_NAME NVARCHAR(128) NULL,
	CONSTRAINT Pk_ManId PRIMARY KEY CLUSTERED (MANAGER_ID),
	CHECK (LEN(MANAGER_ID) = 11)
)


INSERT INTO #employeeTable VALUES (N'Jimi',NULL,N'Hendrix',NULL,CURRENT_TIME_STAMP,NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Nick',NULL,N'Mason',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Waters',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Wright',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Clive',NULL,N'Metcalfe',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Noble',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Sheilagh',NULL,N'Noble',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Vernon',NULL,N'Thompson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Dennis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Juliette',NULL,N'Gale',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Klose',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Syd',NULL,N'Barrett',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Gilmour',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Squire',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jon',NULL,N'Anderson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Kaye',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Bruford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Banks',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'O''Reilly',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Howe',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Rick',NULL,N'Wakeman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Alan',NULL,N'White',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Patrick',NULL,N'Moraz',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Trevor',NULL,N'Horn',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Geoffrew',NULL,N'Downes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Eddie',NULL,N'Jobson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Billy',NULL,N'Sherwood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Igor',NULL,N'Khoroshev',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Benoit',NULL,N'David',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Oliver',NULL,N'Wakeman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jon',NULL,N'Davison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jay',NULL,N'Schellen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Bowie',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Gregg',NULL,N'Allman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Butch',NULL,N'Trucks',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Duane',NULL,N'Allman',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Betts',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Berry',NULL,N'Oakley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jai Johanny',NULL,N'Johanson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Chuck',NULL,N'Leavell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Lamar',NULL,N'Williams',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Dan',NULL,N'Toler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Goldflies',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Lawler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'David Frankie',NULL,N'Toler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Warren',NULL,N'Haynes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Johnny',NULL,N'Neel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Allen',NULL,N'Woody',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Marc',NULL,N'Quinones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jack',NULL,N'Pearson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Oteil',NULL,N'Burbridge',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Derek',NULL,N'Trucks',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Herring',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Banks',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Rutherford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Gabriel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Anthony',NULL,N'Phillips',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Chris',NULL,N'Stewart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Silver',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Mayhew',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Phil',NULL,N'Collins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Hackett',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ray',NULL,N'Wilson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Page',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Plant',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Bonham',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John Paul',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Young',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Tonny',NULL,N'Iommi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Geezer',NULL,N'Butler',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Ward',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ozzy',NULL,N'Osbourne',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Walker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Craig',NULL,N'Gruber',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Geoff',NULL,N'Nicholls',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ronnie James',NULL,N'Dio',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Vinny',NULL,N'Appice',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Gillan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Bev',NULL,N'Bevan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Donato',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ron',NULL,N'Keel',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Gordon',NULL,N'Copley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Glenn',NULL,N'Hughes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Spitz',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Eric',NULL,N'Singer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ray',NULL,N'Gillen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Bob',NULL,N'Daisley',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Martin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Terry',NULL,N'Chimes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jo',NULL,N'Burt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Laurence',NULL,N'Cottle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Cozy',NULL,N'Powell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Murray',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Bobby',NULL,N'Rondinelli',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Daultrey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Roy',NULL,N'Ellis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'James',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Entwisle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Pete',NULL,N'Townshend',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Doug',NULL,N'Sandom',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Kenney',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Alex',NULL,N'Lifeson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Rutsey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jeff',NULL,N'Jones',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Geddy',NULL,N'Lee',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Lindy',NULL,N'Young',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Joe',NULL,N'Perna',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Mitch',NULL,N'Bossi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Neil',NULL,N'Peart',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Bruce',NULL,N'Springsteen',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Anderson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Mick',NULL,N'Abrahams',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Glenn',NULL,N'Cornick',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Clive',NULL,N'Bunker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Iommi',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Martin',NULL,N'Barre',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Evans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jeffrey',NULL,N'Hammond',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Barriemore',NULL,N'Barlow',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Glascock',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Dee',NULL,N'Palmer',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Pegg',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Craney',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Peter-John',NULL,N'Vettese',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Gerry',NULL,N'Conway',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Doane',NULL,N'Perry',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Maartin',NULL,N'Allcock',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Andrew',NULL,N'Giddings',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jonathan',NULL,N'Noyce',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Goodier',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John',NULL,N'O''Hara',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Scott',NULL,N'Hammond',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Florian',NULL,N'Opahle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Joe',NULL,N'Parrish-James',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jack',NULL,N'Clark',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Pye',NULL,N'Hastings',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Coughlan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Dave',NULL,N'Sinclair',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Richard',NULL,N'Sinclair',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Steve',NULL,N'Miller',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Derek',NULL,N'Austin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Geoffrey',NULL,N'Richardson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John',N'G.',N'Perry',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Mike',NULL,N'Wedgewood',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jan',NULL,N'Schelhaas',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Dek',NULL,N'Messecar',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jim',NULL,N'Leverton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jimmy',NULL,N'Hastings',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Simon',NULL,N'Bentall',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Doug',NULL,N'Boyle',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Mark',NULL,N'Walker',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Stevie',NULL,N'Wonder',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Irmin',NULL,N'Schmidt',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Karoli',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Holger',NULL,N'Czukay',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'David',N'C.',N'Johnson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Malcolm',NULL,N'Mooney',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Damo',NULL,N'Suzuki',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Cousins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Rosko',NULL,N'Gee',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Anthony',N'Reebop Kwaku',N'Baah',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Robert',NULL,N'Fripp',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'McDonald',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Greg',NULL,N'Lake',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Michael',NULL,N'Giles',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Sinfield',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Gordon',NULL,N'Haskell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Andy',NULL,N'McCulloch',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Mel',NULL,N'Collins',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Boz',NULL,N'Burrell',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Wallace',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jamie',NULL,N'Muir',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'John',NULL,N'Wetton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Cross',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Bruford',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Tony',NULL,N'Levin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Adrian',NULL,N'Belew',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Trey',NULL,N'Gunn',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Pat',NULL,N'Mastelotto',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Gavin',NULL,N'Harrison',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Bill',NULL,N'Rieflin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jakko',N'M.',N'Jakszyk',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jeremy',NULL,N'Stacey',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Peter',NULL,N'Hammill',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Judge',NULL,N'Smith',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Nick',NULL,N'Pearne',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Hugh',NULL,N'Baton',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Guy',NULL,N'Evans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Keith',NULL,N'Ellis',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Nic',NULL,N'Potter',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Jackson',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Graham',NULL,N'Smith',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Charles',NULL,N'Dickie',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Paice',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Jon',NULL,N'Lord',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Nick',NULL,N'Simper',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Rod',NULL,N'Evans',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Roger',NULL,N'Glover',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Ian',NULL,N'Gillan',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'David',NULL,N'Coverdale',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Glenn',NULL,N'Hughes',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'Tommy',NULL,N'Bolin',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
INSERT INTO #employeeTable VALUES (N'',NULL,N'',NULL,DATEADD(YY,-RAND(100),CURRENT_TIME_STAMP),NULL,NULL,NULL)
