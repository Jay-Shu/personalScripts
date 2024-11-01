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


# Moving to Invoke-Sqlcmd
    try {
        # Each of these can be separate instead of wrapped within 1 try...catch block
        Invoke-Sqlcmd -Query $databaseSchema -Hostname $globalPerceptiveVars.server -Database "INOW" -EncryptConnection -Username $globalPerceptiveVars.uname -Password $globalPerceptiveVars.password -TrustServerCertificate $TRUE
        Invoke-Sqlcmd -Query $retrieve1Document -Hostname $globalPerceptiveVars.server -Database "INOW" -EncryptConnection -Username $globalPerceptiveVars.uname -Password $globalPerceptiveVars.password -TrustServerCertificate $TRUE
        Invoke-Sqlcmd -Query $constructOutPutAgentFile -Hostname $globalPerceptiveVars.server -Database "INOW" -EncryptConnection -Username $globalPerceptiveVars.uname -Password $globalPerceptiveVars.password -TrustServerCertificate $TRUE
        Invoke-Sqlcmd -Query $externMessageTable -Hostname $globalPerceptiveVars.server -Database "INOW" -EncryptConnection -Username $globalPerceptiveVars.uname -Password $globalPerceptiveVars.password -TrustServerCertificate $TRUE
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