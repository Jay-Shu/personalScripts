<#
                    .SYNOPSIS
                    For performing Database Queries against the Perceptive Content Database, e.g. INOW, INOW7, INOW6, etc.

                    .DESCRIPTION
                    This is intended for Database Queries
                    
                    Changelog:
                        2024-10-29: Added remaining logic for all actions.
                        2024-10-30: Incorrect formatting of Hash Table.
                        2024-10-30: paca.getAccounts to paca.getAccounts_v1.
                        2024-10-31: Migrated from previous connection model to Invoke-Sqlcmd.
                        2024-10-31: Standardization of Invoke-Sqlcmd.
                        2024-11-01: Transition from Citations to .LINK keyword.
                        2024-11-02: Query added using Common Table Expression for Index Fragmentation.
                        2024-11-02: Actual Execution Plan Example for Index Fragmentation.
                        2024-11-02: Logic added and while loop for selection instead of running all queries at once.

                    .EXAMPLE
                        Effectively this is what we are doing.
                        EXECUTE paca.getAccounts_v1
                        Invoke-Sqlcmd -Query "SELECT CURRENT_TIMESTAMP" -Hostname "localhost" -Database "MyDatabaseName" -EncryptConnection -Username "username" -Password "password" -TrustServerCertificate $TRUE
                            For this example the parameters are supplied.

                    .NOTES
                        Needing to move over to Invoke-Sqlcmd from the current model.
                        This is to keep it consistent and perhaps easier to manage.

                    .INPUTS
                        configurationActive: 1 = Perceptive Content, 2 = Python Auto Claims App

                    .LINK
                        https://learn.microsoft.com/en-us/powershell/scripting/developer/help/syntax-of-comment-based-help?view=powershell-7.4
                        Links to Syntax of Comment-Based Help

                    .LINK
                        https://learn.microsoft.com/en-us/powershell/module/sqlserver/invoke-sqlcmd?view=sqlserver-ps
                        Invoke-Sqlcmd
                    
                    .LINK
                        https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_special_characters?view=powershell-7.4
                        about_Special_Characters

                    .LINK
                        https://stackoverflow.com/questions/43683716/how-can-i-quickly-detect-and-resolve-sql-server-index-fragmentation-for-a-databa
                        How can I quickly detect and resolve SQL Server Index Fragmentation for a database. 

                    .LINK
                        https://learn.microsoft.com/en-us/sql/t-sql/queries/with-common-table-expression-transact-sql?view=sql-server-ver16
                        WITH common_table_expression (Transact-SQL)
                    #>
    #param (
    #
    #)

$configurationActive = 2

IF ($configurationActive -eq 1){
    $globalPerceptiveVars = @{
        uname = "inuser";
        password = "yourinuserpassword";
        server = "127.0.0.1";
        database = "INOW";
        trustServerCertificate = "YES";
        encrypt = "YES";
        
        # Name of the stored procedure to execute
        # This is not needed for Perceptive Content
        # getAccounts = "paca.getAccounts_v1";
    }

   <#  $connectionStringActual = "Server=$($globalVars.server);Database=$($globalVars.database);User Id=$($globalVars.uname);Password=$($globalVars.password);Integrated Security=False"

    # Load SQL Server .NET Data Provider
    Add-Type -AssemblyName "System.Data"

    # Create a new SQL connection
    $connection = New-Object System.Data.SqlClient.SqlConnection
    $connection.ConnectionString = $connectionStringActual
 #>
    # We only want to retrieve 1 result for our test.
    $databaseSchema = @"
SELECT TOP 1 <DB_SCHEMA_VERSION_COLUMN>, <DATE_COLUMN>
FROM inuser.IN_PRODUCT_MOD_HIST
ORDER BY COLUMN_NAME DESC
"@

# Escaping N'' is not necessary when using Invoke-Sqlcmd
    $retrieve1Document = @"
SELECT TOP 1 DOC_ID,FOLDER,TAB,FIELD_3,FIELD_4,FIELD_5
FROM inuser.IN_DOC WHERE DOC_ID = N'321Z1234_1234567890'
"@

# For the Output Agent I am unsure on the column at this time. Escapes my memory.
# Providing the Document Name is the fastest way to review it aside from the DOC_ID.
# It is always recommended to supply schemas and column names as this reduces extra overhead.
    $constructOutPutAgentFile = @"
SELECT dr.DRAWER_NAME + N'^' + FOLDER + N'^' + TAB + N'^' + F3 + N'^' + F4 + N'^' + F5 + N'^' + N'^' + i.WORKING_NAME
FROM inuser.IN_DOC d
inner join inuser.IN_DRAWER dr on dr.DRAWER_ID = d.DRAWER_ID
inner join inuser.IN_INSTANCE i on d.INSTANCE_ID = i.INSTANCE_ID
WHERE DOC_ID = N'321Z1234_1234567890'
"@

# Message Status of 4 needs to be reviewed. If it is related to HL7, then it could be as simple as inserting a value into the relevant tables.
# Due to aggregation we have to use both MESSAGE_STATUS and MESSAGE_TYPE in the GROUP BY and OREDER BY Clauses.
$externMessageTable = @"
SELECT
COUNT(MESSAGE_STATUS),
CASE MESSAGE_STATUS
WHEN 0 THEN N'Not Started'
WHEN 1 THEN N'Started'
WHEN 2 THEN N'In Process'
WHEN 3 THEN N'Success (Complete)'
WHEN 4 THEN N'Success (Incomplete)'
WHEN 999 THEN N'Locked'
END as N'Message Statuses',
MESSAGE_TYPE
FROM inemuser.IN_EXTERN_MESSAGE
GROUP BY MESSAGE_STATUS, MESSAGE_TYPE
HAVING COUNT(MESSAGE_STATUS) > 0
ORDER BY MESSAGE_STATUS, MESSAGE_TYPE DESC
"@


$fragmentation = @"
WITH Index_CTE (NAME,avg_fragmentation_in_percent,fragment_count,avg_fragment_size_in_pages)
AS
(SELECT NAME, 
       avg_fragmentation_in_percent, 
       fragment_count, 
       avg_fragment_size_in_pages 
FROM   sys.Dm_db_index_physical_stats(Db_id('dbName'), Object_id('tableName'), 
       NULL, 
              NULL, NULL) AS a 
       INNER JOIN sys.indexes b 
               ON a.object_id = b.object_id 
                  AND a.index_id = b.index_id
				WHERE avg_fragmentation_in_percent > 30
)
SELECT NAME,avg_fragmentation_in_percent,fragment_count,avg_fragment_size_in_pages
FROM Index_CTE
"@


# If you do not have an ERD, this will be the next best thing. Aside from downloading the creation script.
$initialDatabaseProbe = @"
SELECT sc.TABLE_NAME,sc.COLUMN_NAME, (UPPER(REPLACE(REPLACE(REPLACE(REPLACE(DATA_TYPE + '('+CAST(isNull(sc.CHARACTER_MAXIMUM_LENGTH,'') as varchar(max))
+')','(0)',''),'nvarchar(-1)','nvarchar(max)'),'varbinary(-1)','varbinary(max)'),'varchar(-1)','varchar(max)'))) as 'Data Type',
CASE sc.IS_NULLABLE
WHEN 'NO' THEN 'NOT NULL'
WHEN 'YES' THEN 'NULL'
end as 'Nullable'
FROM INFORMATION_SCHEMA.COLUMNS sc
"@

<#
    Actual Execution Plan of WITH Index_CTE
    WITH Index_CTE (NAME,avg_fragmentation_in_percent,fragment_count,avg_fragment_size_in_pages)  AS  (SELECT NAME,          avg_fragmentation_in_percent,          fragment_count,          avg_fragment_size_in_pages   FROM   sys.Dm_db_index_physical_stats(Db_id('dbName'), Object_id('tableName'),          NULL,                 NULL, NULL) AS a          INNER JOIN sys.indexes b                  ON a.object_id = b.object_id                     AND a.index_id = b.index_id      WHERE avg_fragmentation_in_percent > 30  )  SELECT NAME,avg_fragmentation_in_percent,fragment_count,avg_fragment_size_in_pages  FROM Index_CTE
  |--Nested Loops(Inner Join, OUTER REFERENCES:([i].[id], [Expr1026]) WITH UNORDERED PREFETCH)
       |--Hash Match(Inner Join, HASH:([i].[id], [i].[indid])=(INDEXANALYSIS.[object_id], INDEXANALYSIS.[index_id]), RESIDUAL:(INDEXANALYSIS.[object_id]=[PACA].[sys].[sysidxstats].[id] as [i].[id] AND INDEXANALYSIS.[index_id]=[PACA].[sys].[sysidxstats].[indid] as [i].[indid]))
       |    |--Filter(WHERE:(has_access('CO',[PACA].[sys].[sysidxstats].[id] as [i].[id])=(1)))
       |    |    |--Clustered Index Scan(OBJECT:([PACA].[sys].[sysidxstats].[clst] AS [i]), WHERE:(([PACA].[sys].[sysidxstats].[status] as [i].[status]&(1))<>(0) AND ([PACA].[sys].[sysidxstats].[status] as [i].[status]&(67108864))=(0)))
       |    |--Filter(WHERE:(INDEXANALYSIS.[avg_fragmentation_in_percent]>(3.0000000000000000e+001)))
       |         |--Table-valued function
       |--Clustered Index Seek(OBJECT:([PACA].[sys].[sysschobjs].[clst] AS [obj]), SEEK:([obj].[id]=[PACA].[sys].[sysidxstats].[id] as [i].[id]) ORDERED FORWARD)
#>


# Moving to Invoke-Sqlcmd
    try {

        $querySelection = Read-Host "What would you like to run?"
        WHILE($NULL -ne $querySelection){
        IF($querySelection -eq 1)
        {
        # Each of these can be separate instead of wrapped within 1 try...catch block
            Invoke-Sqlcmd -Query $databaseSchema -Hostname $globalPerceptiveVars.server -Database "INOW" -EncryptConnection -Username $globalPerceptiveVars.uname -Password $globalPerceptiveVars.password -TrustServerCertificate $TRUE
            $querySelection = $NULL
            $querySelection = Read-Host "Please provide 1-5 or press enter"
        }
        ELSEIF($querySelection -eq 2)
        {
            Invoke-Sqlcmd -Query $retrieve1Document -Hostname $globalPerceptiveVars.server -Database "INOW" -EncryptConnection -Username $globalPerceptiveVars.uname -Password $globalPerceptiveVars.password -TrustServerCertificate $TRUE
            $querySelection = $NULL
            $querySelection = Read-Host "Please provide 1-5 or press enter"
        }
        ELSEIF($querySelection -eq 3)
        {
            Invoke-Sqlcmd -Query $constructOutPutAgentFile -Hostname $globalPerceptiveVars.server -Database "INOW" -EncryptConnection -Username $globalPerceptiveVars.uname -Password $globalPerceptiveVars.password -TrustServerCertificate $TRUE
            $querySelection = $NULL
            $querySelection = Read-Host "Please provide 1-5 or press enter"
        }
        ELSEIF($querySelection -eq 4)
        {
            Invoke-Sqlcmd -Query $externMessageTable -Hostname $globalPerceptiveVars.server -Database "INOW" -EncryptConnection -Username $globalPerceptiveVars.uname -Password $globalPerceptiveVars.password -TrustServerCertificate $TRUE
            $querySelection = $NULL
            $querySelection = Read-Host "Please provide 1-5 or press enter"
        }
        ELSEIF($querySelection -eq 5)
        {
            Invoke-Sqlcmd -Query $fragmentation -Hostname $globalPerceptiveVars.server -Database "INOW" -EncryptConnection -Username $globalPerceptiveVars.uname -Password $globalPerceptiveVars.password -TrustServerCertificate $TRUE
            $querySelection = $NULL
            $querySelection = Read-Host "Please provide 1-5 or press enter"
        } ELSE {
            $querySelection = $NULL
            $querySelection = Read-Host "Please provide 1-5 or press enter"
        }}
        # Open the connection
        <# $connection.Open()
        Write-Host "Connection opened successfully."
    
        # Create SQL command to execute the stored procedure
        $command = $connection.CreateCommand()
        $command.CommandText = $globalVars.testQuery
        $command.CommandType = [System.Data.CommandType]::TableDirect
    
        # If the stored procedure requires parameters, add them here
        # Example: $command.Parameters.Add((New-Object Data.SqlClient.SqlParameter("@ParameterName", [Data.SqlDbType]::NVarChar, 50))).Value = "ParameterValue"
    
        # Execute the stored procedure
        $reader = $command.ExecuteReader()
        $results = @()
        while ($reader.Read()) {
            $row = @{}
            # Output each field in the result
            for ($i = 0; $i -lt $reader.FieldCount; $i++) {
                #Write-Output ($reader.GetName($i) + ": " + $reader.GetValue($i))
                $row.Add($reader.GetName($i),$reader.GetValue($i))
            }
            $results += New-Object PSObject -Property $row
        }
        $reader.Close() #>
    } catch {
        Write-Error "An error occurred: $_"
    } finally {
        # Close the connection
        <# if ($connection.State -eq [System.Data.ConnectionState]::Open) {
            $connection.Close()
            $results | Format-Table -AutoSize
            Write-Host "Connection closed."
        }
        
        # Dispose of resources
        $command.Dispose()
        $connection.Dispose() #>
    }

} ELSEIF ($configurationActive -eq 2){


$storedProcedureGetAccountsV1 = @"
EXECUTE paca.getAccounts_v1
"@

$storedProcedureGetAccountsV2 = @"
EXECUTE paca.getAccounts_v2 {'ACCOUNT_NUM':'ICA00000004'}
"@

<#

    Proof of Concept
#>
    # Define global variables for connection details
$globalVars = @{
    uname = "pacauser";
    password = "pacauser";
    server = "127.0.0.1";
    database = "PACA";
    trustServerCertificate = "YES";
    encrypt = "YES";
    
    # Name of the stored procedure to execute
    getAccounts = "paca.getAccounts_v1";
}
<# 
# Construct the connection string
$connectionStringActual = "Server=$($globalVars.server);Database=$($globalVars.database);User Id=$($globalVars.uname);Password=$($globalVars.password);Integrated Security=False"

# Load SQL Server .NET Data Provider
Add-Type -AssemblyName "System.Data"

# Create a new SQL connection
$connection = New-Object System.Data.SqlClient.SqlConnection
$connection.ConnectionString = $connectionStringActual #>

try {
    Invoke-Sqlcmd -Query $storedProcedureGetAccountsV1 -Hostname $globalVars.server -Username $globalVars.uname -Password $globalVars.password -Database "PACA" -TrustServerCertificate $TRUE
    Invoke-Sqlcmd -Query $storedProcedureGetAccountsV2 -Hostname $globalVars.server -Username $globalVars.uname -Password $globalVars.password -Database "PACA" -TrustServerCertificate $TRUE
    # Open the connection
   <#  $connection.Open()
    Write-Host "Connection opened successfully."

    # Create SQL command to execute the stored procedure
    $command = $connection.CreateCommand()
    $command.CommandText = $globalVars.getAccounts
    $command.CommandType = [System.Data.CommandType]::StoredProcedure

    # If the stored procedure requires parameters, add them here
    # Example: $command.Parameters.Add((New-Object Data.SqlClient.SqlParameter("@ParameterName", [Data.SqlDbType]::NVarChar, 50))).Value = "ParameterValue"

    # Execute the stored procedure
    $reader = $command.ExecuteReader()
    $results = @()
    while ($reader.Read()) {
        $row = @{}
        # Output each field in the result
        for ($i = 0; $i -lt $reader.FieldCount; $i++) {
            #Write-Output ($reader.GetName($i) + ": " + $reader.GetValue($i))
            $row.Add($reader.GetName($i),$reader.GetValue($i))
        }
        $results += New-Object PSObject -Property $row
    }
    $reader.Close() #>
} catch {
    Write-Error "An error occurred: $_"
} finally {
    # Close the connection
   <#  if ($connection.State -eq [System.Data.ConnectionState]::Open) {
        $connection.Close()
        $results | Format-Table -AutoSize
        Write-Host "Connection closed."
    }
    
    # Dispose of resources
    $command.Dispose()
    $connection.Dispose()
 #>
} # finally closing
}