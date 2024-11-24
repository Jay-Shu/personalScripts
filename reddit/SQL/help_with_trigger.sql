/*
    Serialization and Deserialization to protect yourself from injections. But we also need to consider cases such as O'Connell and {Bob }
    Since I don't know how the information is being shipped this is generalized version.
*/

CREATE TABLE myexample
(
    id INT identity(1,1) PRIMARY KEY,
    -- To give us a primary key
    user_account_num NVARCHAR(11),
    permission INT,
    permission_change BIT,
    actual_sql_executed NVARCHAR(MAX),
    -- You can audit to this level of granularity if you really wanted to. I used it in Tech Support and stored a before and after as well.
    date_of_audit DATETIME
)

GO


CREATE PROCEDURE AUDITING
    @json NVARCHAR(MAX)
AS
SET NOCOUNT ON

DECLARE @tempTable TABLE (
    user_account_num NVARCHAR(11),
    permission INT,
    permission_change BIT,
    actual_sql_executed NVARCHAR(MAX) NULL,
    date_of_audit DATETIME NULL)

INSERT INTO @tempTable
SELECT
    user_account_num,
    permission_change,
    actual_sql_executed,
    date_of_audit
FROM OPENJSON(@json) WITH (
    user_account_num NVARCHAR(11) 'strict $.user_account_num',
    permission_change 	BIT 'strict $.permission_change',
	  [actual_sql_executed] NVARCHAR(MAX) AS JSON,
	  date_of_audit DATETIME '$.date_of_audit'
)
;

DECLARE @subqueries_table TABLE(
    id INT IDENTITY(1,1),
    statements_ran NVARCHAR(MAX)
)



INSERT INTO @subqueries_table
SELECT statements_ran
FROM OPENJSON(@json,'$.actual_sql_executed')
WITH (
    statement_id INT 'strict $.statement_id',
    statements_ran NVARCHAR(MAX) 'strict $.statement'
)

DECLARE
@user_account_num NVARCHAR(11) = (SELECT TOP 1 user_account_num FROM @tempTable),
@permission_change BIT = (SELECT TOP 1 CONVERT(NVARCHAR(1),permission_change) FROM @tempTable),
--@actual_sql_executed NVARCHAR(MAX) = (SELECT TOP 1 actual_sql_executed FROM @tempTable),
@current_statement NVARCHAR(MAX),
@date_of_audit DATETIME = (SELECT TOP 1 CONVERT(NVARCHAR(32),date_of_audit) FROM @tempTable),
@rowcount INT = (SELECT COUNT(statement) FROM @subqueries_table),
@counter INT = 1,
@val UNIQUEIDENTIFIER  = NEWID();

WHILE @counter <= @rowcount
BEGIN TRY
SET @current_statement = (SELECT TOP 1 statements_ran FROM @subqueries_table WHERE ID = @counter)

SET @sql = 'INSERT INTO SCHEMA.TABLEB VALUES('+''''+ @user_account_num +','+
    ''''+ @date_of_audit + '''' + ',' + ''''+ @permission_change + '''' +
    ','+ ''''+ REPLACE(@current_statement,'''','''''''') + '''' +
    ')';

-- @val is a placeholder, it isn't needed otherwise since we are not inputting params and just running the query instead.
EXEC sp_executesql @sql , N'@val NVARCHAR(MAX) OUTPUT', @val OUTPUT

SET @counter = @counter + 1
END TRY
BEGIN CATCH
  SELECT 
    ERROR_NUMBER() AS ErrorNumber
   ,ERROR_SEVERITY() AS ErrorSeverity
   ,ERROR_STATE() AS ErrorState
   ,ERROR_PROCEDURE() AS ErrorProcedure
   ,ERROR_LINE() AS ErrorLine
   ,ERROR_MESSAGE() AS ErrorMessage;
END CATCH
;

/*
    Only send over what you are working with.
    {
        "user_account_num":"USR12345678",
        "permission_change": true,
        "actual_sql_executed":[
                {  
                    "statement_id":1
                    "statement":"INSERT INTO TABLE A VALUES(USR12345678,112233,c,d)"
                },
                {
                    "statement_id":2
                    "statement":"INSERT INTO TABLE A VALUES(USR12345678,-113341,c,d)"
                },
                {   
                    "statement_id":3
                    "statement":"INSERT INTO TABLE A VALUES(USR12345678,-4345,c,d)"
                    }
            }
        ],
        "date_of_audit":"YYYY-MM-DD HH:MM:SS.MMM"
    }
*/
RETURN; --If you need to return something then add it here.

GO
