/**
	Name of Script: paca-update-statements.sql
    Author: Jacob Shuster
    Role: Consultant - 1099
    Umbrella Company: N/A
    Creation Date: 2024-08-04
    Script Cost: N/A
    Rate: 100.00 (Based on 2019*)

    Changelog:
        2024-08-02: Staging for Certificates to be added to Stored Procedures
          per best practices.
        2024-08-05: Removed USE Clause.
        2024-08-05: Resolve Syntax errors.
        2024-08-05: Addeed BEGIN...END Transaction (T-SQL) blocks.
        2024-08-05: IF...ELSE (T-SQL), replaced the USE Clauses.
        2024-08-06: Added Homes Update Statements.
        2024-08-06: Removed Default set of Citations that were not applicable.
        2024-08-06: Added missing Schema for any applicable Stored Procedures.
        2024-08-09: Added AND VEHICLE_VIN = @vehicleVin line for the WHERE clause of the
            Vehicle Update Stored Procedure.
        2024-08-11: Re-design of updateAccount_v1.
		2024-08-14: Full replacement of updateAccounts_v1.
		2024-08-15: Added an additional DECLARE to separate the Inputs from the already existing values.
		2024-08-15: Resolved repetitive logic causing double SET.
		2024-08-16: Updated Variable notes.
		2024-08-16: Added new shell for updateHomes_v1. All future update stored procedures will utilize
			this shell.
		2024-08-18: Shell applied to updateVehicles_v1.
		
    TO DO (Requested):
		N/A - No current modification requests pending.
	
	TO DO (SELF):
		Policies Enumerations. - DONE
		Bundle Enumeration for Car and Home. For non-goal. - DONE
        Incorporation of the STRING_SPLIT() function. This was introduced in MS SQL Server 2016,
            
		
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
        @sqlQuery:
		@successFlag: Set to 1 for Success, 0 for Failure.
		@origData: What was originally in the given column.
		@myResults: Our Results
		@counter: Counter
		@counter2: Counter2
		@rowCount Row Counter
		@rowCount2: Row Counter2
		@lastName: Last Name of the Person.
		@firstName: First Name of the Person.
		@personID: Unique Identifier for a given Person, this is to give uniqueness to prevent Updates hitting
			unintended targets.
		@SQL: Our actual Query
		@SQL2: Our actual Query2
		@val: This is a temporary value using a Unique Identifier. It is a placeholder.


		
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

	Author Notes:
		Inspired by my time at Hyland working with Phil Mosher and Brandon Rossin.
		GO Keyword does not require a semi-colon. As it would be redundant.
		BEGIN...END Blocks have been phased out completely for TRY...CATCH and GO.
        BEGIN TRANSACTION...COMMIT TRANSACTION Blocks to be used. As it is intended
            for the application to be running these statements. You MUST immediately
            COMMIT the TRANSACTION following the Statement(s) execution(s). This is
            to avoid erroneously leaving your cursor open.
        STRING_SPLIT() - No longer being considered.

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

DECLARE
@successFlag INT = 0,
@origData NVARCHAR(MAX),
@myResults NVARCHAR(MAX),
@counter INT = 1,
@counter2 INT = 1,
@rowCount INT,
@rowCount2 INT,
@lastName NVARCHAR(128),
@firstName NVARCHAR(128),
@personID NVARCHAR(6),
@SQL NVARCHAR(MAX),
@SQL2 NVARCHAR(MAX),
@val UNIQUEIDENTIFIER = NEWID();


CREATE TABLE #tempTable
(ID INT IDENTITY(1,1),
PERSON_ID AS N'PER' + RIGHT('000' + CAST(ID AS NVARCHAR(3)),3) PERSISTED NOT NULL,
FIRST_NAME NVARCHAR(128),
LAST_NAME NVARCHAR(128));

CREATE TABLE #processingTable
(ID INT IDENTITY(1,1),
SUCCESS_FLAG INT,
SQLQuery NVARCHAR(MAX),
ORIGINAL_DATA NVARCHAR(MAX),
RESULTS NVARCHAR(MAX));

INSERT INTO #tempTable VALUES (N'Al' + CHAR(2) + N'ex',N'Lifeson');
INSERT INTO #tempTable VALUES (N'John',N'Rut' + CHAR(9) + N'sey');
INSERT INTO #tempTable VALUES (CHAR(3) + N'Jeff',N'Jones');
INSERT INTO #tempTable VALUES (N'Geddy',N'Lee');
INSERT INTO #tempTable VALUES (N'Lindy',N'Young');
INSERT INTO #tempTable VALUES (N'Jo'+ CHAR(2) + N'e',N'Perna');
INSERT INTO #tempTable VALUES (N'Bob' + CHAR(10),N'Vopni');
INSERT INTO #tempTable VALUES (N'Mitch',N'Bossi');
INSERT INTO #tempTable VALUES (N'Neil',N'Peart' + CHAR(32));

INSERT INTO #processingTable
SELECT 0,
N'UPDATE #tempTable SET FIRST_NAME= ' + '''' + REPLACE(REPLACE(REPLACE(FIRST_NAME,CHAR(2),N''),CHAR(3),N''),CHAR(10),N'') + ''''+ N' WHERE PERSON_ID = '+ '''' + PERSON_ID + '''',
FIRST_NAME,
NULL
FROM #tempTable
WHERE FIRST_NAME like N'%[' + CHAR(2) + N']%'
OR FIRST_NAME like N'%[' + CHAR(3) + N']%'
OR FIRST_NAME like N'%[' + CHAR(10) + N']%'
--OR LAST_NAME like N'%[' + CHAR(2) + ']%'


SET @rowcount = (
	SELECT COUNT(ID)
	FROM #processingTable)


WHILE (@rowcount >= @counter)
BEGIN
SET @SQL = (SELECT TOP 1 SQLQuery FROM #processingTable WHERE ID = @counter);
BEGIN TRY
	EXECUTE sp_executesql @SQL, N'@val NVARCHAR(max) OUTPUT',@val OUTPUT
	UPDATE #processingTable
	SET SUCCESS_FLAG = 1,
	RESULTS = N'Success'
	WHERE ID = @counter
END TRY
BEGIN CATCH
DECLARE @errMessage NVARCHAR(MAX) = (SELECT ERROR_MESSAGE())
UPDATE #processingTable
SET SUCCESS_FLAG = 0,
RESULTS = @errMessage

END CATCH
SET @counter += 1
END


--SELECT * FROM #tempTable
--SELECT * FROM #processingTable

TRUNCATE TABLE #tempTable
TRUNCATE TABLE #processingTable

--  CHAR(32) typically is an accepted Character by most software, it is used only as an example. In the real world do not replace it unless you have to.

INSERT INTO #processingTable
SELECT 0,
N'UPDATE #tempTable SET LAST_NAME= ' + '''' + REPLACE(REPLACE(FIRST_NAME,CHAR(9),N''),CHAR(32),N'') + ''''+ N' WHERE PERSON_ID = '+ '''' + PERSON_ID + '''',
LAST_NAME,
NULL
FROM #tempTable
WHERE LAST_NAME like N'%[' + CHAR(9) + N']%'
OR LAST_NAME like N'%[' + CHAR(32) + N']%'

SET @rowcount2 = (
	SELECT COUNT(ID)
	FROM #processingTable)


WHILE (@rowcount2 >= @counter2)
BEGIN
SET @SQL2 = (SELECT TOP 1 SQLQuery FROM #processingTable WHERE ID = @counter);
BEGIN TRY
	EXECUTE sp_executesql @SQL2, N'@val NVARCHAR(max) OUTPUT',@val OUTPUT
	UPDATE #processingTable
	SET SUCCESS_FLAG = 1,
	RESULTS = N'Success'
	WHERE ID = @counter2
END TRY
BEGIN CATCH
DECLARE @errMessage NVARCHAR(MAX) = (SELECT ERROR_MESSAGE())
UPDATE #processingTable
SET SUCCESS_FLAG = 0,
RESULTS = @errMessage

END CATCH
SET @counter2 += 1
END

--SELECT * FROM #tempTable
--SELECT * FROM #processingTable