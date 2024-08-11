/**
	Name of Script: proof-of-concepts.sql
    Author: Jacob Shuster
    Role: Consultant - 1099
    Umbrella Company: N/A
    Creation Date: 2024-07-30
    Script Cost: N/A
    Rate: 100.00 (Based on 2019*)

    Changelog:
        2024-08-02: Staging for Certificates to be added to Stored Procedures
          per best practices. (Researching further).
        2024-08-05: Reseolved Syntax issues with Stored Procedures.
        2024-08-05: Remove USE clause, because CREATE PROCEDURE (T-SQL)
          does not allow for statements above it.

    TO DO (Requested):
		N/A - No current modification requests pending.
	
	TO DO (SELF):
		Policies Enumerations. - DONE
		Bundle Enumeration for Car and Home. For non-goal. - DONE
		
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
        @firstName First Name of the Account Holder.
        @lastName Last Name of the Account Holder.
        @intent: Our mode of searching; 1 = Equal to for First Name and Last Name,
          2 = First Name Ends With and Last Name Equal To.
          3 = First Name Starts With and Last Name Equal To.
          4 = Last Name Ends  With and First Name Equal To.
          5 = Last Name Starts With and First Name Equal To.
          Contains is not being considered at this time. The table will be full scans due to their small size regardless of the Index.
        @accountNum: Account Number of the Client Account.
        @homeAddress: Home Address of the Insured Home.

		
	Citations:
		1. CREATE PROCEDURE (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/statements/create-procedure-transact-sql?view=sql-server-ver16
    2. NO COUNT (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/statements/set-nocount-transact-sql?view=sql-server-ver16
    3. ERROR_MESSAGE (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/functions/error-message-transact-sql?view=sql-server-ver16
    4. CREATE_QUEUE (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/statements/create-queue-transact-sql?view=sql-server-ver16
    5. CREATE_ENDPOINT (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/statements/create-endpoint-transact-sql?view=sql-server-ver16
    6. CASE (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/language-elements/case-transact-sql?view=sql-server-ver16
    7. IF...ELSE (Transact-SQL), https://learn.microsoft.com/en-us/sql/t-sql/language-elements/if-else-transact-sql?view=sql-server-ver16
    8. Tutorial: Signing Stored Procedures With a Certificate, https://learn.microsoft.com/en-us/sql/relational-databases/tutorial-signing-stored-procedures-with-a-certificate?view=sql-server-ver16
    9. Slash Star (Block Comment), https://learn.microsoft.com/en-us/sql/t-sql/language-elements/slash-star-comment-transact-sql?view=sql-server-ver16

	Author Notes:
		Inspired by my time at Hyland working with Phil Mosher and Brandon Rossin.
		GO Keyword does not require a semi-colon. As it would be redundant.
		BEGIN...END Blocks have been phased out completely for TRY...CATCH and GO.
        BEGIN TRANSACTION...COMMIT TRANSACTION Blocks to be used. As it is intended
            for the application to be running these statements.
        This is intended for proofing any theories
        
        

**/


/*

STRING_SPLIT() THEORY - CONFIRMED

PROOF OF CONCEPT: v1.0

**/

DECLARE @stringsplittheory NVARCHAR(MAX)

SET @stringsplittheory = REPLACE(REPLACE('{VEHICLE_YEAR:2022,VEHICLE_MAKE:Hyundai,VEHICLE_MODEL:Elantra,VEHICLE_ANNUAL_MILEAGE:20000}','{',''),'}','')

IF(OBJECT_ID(N'mytemptable',N'U')) is null
BEGIN
CREATE TABLE mytemptable
(ID INT IDENTITY(1,1),
QUERY NVARCHAR(MAX));
END
ELSE
BEGIN
DROP TABLE mytemptable;
CREATE TABLE mytemptable
(ID INT IDENTITY(1,1),
QUERY NVARCHAR(MAX));
END

INSERT INTO mytemptable
SELECT REPLACE(value,CHAR(58),' ' + CHAR(61) + ' '+'''')+'''' FROM STRING_SPLIT(@stringsplittheory,',')

SELECT * FROM mytemptable

DECLARE @updStatement NVARCHAR(MAX) = N'UPDATE paca.VEHICLES SET ',
@count INT = 1, @secondaryCounter INT, @currentVal NVARCHAR(MAX),@rowCount INT

SET @rowCount = (SELECT COUNT(QUERY) FROM mytemptable)

WHILE @count <= @rowCount
BEGIN
SET @currentVal = (
SELECT TOP 1 QUERY
FROM mytemptable
WHERE ID = @count
)

IF(@count = 1)
BEGIN
SET @updStatement += @currentVal +' '
END
IF(@count <= @rowCount)
BEGIN
SET @updStatement += ',' + @currentVal +' '
END
SET @count += 1

END

SELECT @updStatement

DROP TABLE mytemptable