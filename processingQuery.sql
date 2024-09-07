DECLARE @sqlQuery NVARCHAR(MAX),
@successFlag INT = 0,
@origData NVARCHAR(MAX),
@myResults NVARCHAR(MAX),
@counter INT = 1,
@rowCount INT,
@lastName NVARCHAR(128),
@firstName NVARCHAR(128),
@personID NVARCHAR(6),
@SQL NVARCHAR(MAX),
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
N'UPDATE #tempTable SET FIRST_NAME= ' + '''' + REPLACE(FIRST_NAME,CHAR(2),'') + ''''+ N' WHERE PERSON_ID = '+ '''' + PERSON_ID + '''',
FIRST_NAME,
NULL
FROM #tempTable
WHERE FIRST_NAME like N'%[' + CHAR(2) + N']%'
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


SELECT * FROM #tempTable
SELECT * FROM #processingTable

DROP TABLE #tempTable
DROP TABLE #processingTable