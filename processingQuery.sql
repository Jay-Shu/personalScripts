/**
	Name of Script: processingQuery.sql
    Author: Jacob Shuster
    Role: Consultant - 1099
    Umbrella Company: N/A
    Creation Date: 2024-08-04
    Script Cost: N/A
    Rate: 100.00 (Based on 2019*)

    Changelog:
        2024-09-06: Initial Creation.
		
    TO DO (Requested):
		N/A - No current modification requests pending.
	
	TO DO (SELF):
		N/A
            
		
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
        @sqlQuery: The Query we are physically building.
        @successFlag: 1 or 0, 1 success and 0 fail.
        @origData: What did the Data look like before hand.
        @myResults: What the Data looks like afterward.
        @counter: Ensuring we do not exceed our maximum rows that need to be updated.
        @rowCount: Count of the rows we are intending to work with.
        @lastName: Last Name of the individual.
        @firstName: First Nama of the individual.
        #tempTable: Temporary Table required by the query.
        #processingTable: Temporary table intended for processing each row.

		
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


DECLARE @sqlQuery NVARCHAR(MAX),
@successFlag INT = 0,
@origData NVARCHAR(MAX),
@myResults NVARCHAR(MAX),
@counter INT = 1,
@rowCount INT,
@lastName NVARCHAR(128),
@firstName NVARCHAR(128);


CREATE TABLE #tempTable
(ID INT IDENTITY(1,1),
PERSON_ID AS N'PER' + RIGHT('000' + CAST(ID AS NVARCHAR(8)),8) PERSISTED NOT NULL,
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
INSERT INTO #tempTable VALUES (N'Joe',N'Perna');
INSERT INTO #tempTable VALUES (N'Bob' + CHAR(10),N'Vopni');
INSERT INTO #tempTable VALUES (N'Mitch',N'Bossi');
INSERT INTO #tempTable VALUES (N'Neil',N'Peart' + CHAR(32));

SET @rowcount = (
	SELECT COUNT(ID)
	FROM #tempTable
	WHERE LAST_NAME like N'%' + CHAR(2) + N'%');

WHILE (@rowcount <= @counter)
BEGIN
SELECT TOP 1 LAST_NAME
FROM #tempTable
WHERE LAST_NAME like N'%' + CHAR(2) + N'%';
END