<#
                    .SYNOPSIS
                    This script is intended for setting up new intool instances separate from the main application server and any peripheral servers.

                    .DESCRIPTION
                    Intool is a utility for running scripts outside of Workflow or EM or IS (Integration Server is not recommended for iScript execution
                        it is better to execute it server-side). Forms Server and PCR are the only two allowances for serverAction to execute an iScript.
                    Intool requires an ODBC connection to your Database Server or Cluster where INOW is located.
                    Credentials do not need to be stored, I just need to mark it as SQL Login

                    .EXAMPLE
                    Add-OdbcDsn -Name "Perceptive Content 7" -DriverName "ODBC Driver 17 for SQL Server" -DsnType System -Platform 64-bit -Encrypt -SetPropertyValue @{"Server=localhost","Login ID=pacauser","Password=pacauser","Trusted_Connection=No","Database=PACA","UseFTMONLY=Yes","Port=1433"}

                    .NOTES
                    This script is inclusive to intool scalability. Compression, Extraction, and Testing.

                    .INPUTS
                    username: Username that will be performing the promoting and demoting. This must be a current Perceptive Manager.
                    password: Password of the username performing the promoting and demoting. This must be a current Perceptive Manager.
                    inserverBin64: Inserver Installation Directory. This is where your executables live.
                    inserverBin64Old: Inserver Installation Directory for solutions from older versions. Prior to Version 7, it was [drive]:\inserver6
                    #>
    #param (
    #
    #)
    # Get all ODBC DSNs
<# $odbcDsnList = Get-OdbcDsn

# Iterate through each DSN and display its properties
foreach ($dsn in $odbcDsnList) {
    Write-Output "DSN Name: $($dsn.Name)"
    Write-Output "DSN Driver: $($dsn.DriverName)"

    
    # Iterate through each property of the DSN as key-value pairs
    foreach ($property in $dsn.PSObject.Properties) {
        Write-Output "$($property.Name): $($property.Value)"
    }
    
    Write-Output "---------------------------------"
}
 #>


 <#
    Our first objective is to package up the contents for usage elsewhere.
    Additions will need to be made for Add-OdbcDsn
 #>


$destinationLocation = "inserver\bin64"
$folderToCompress = "E:\inserver\bin64"
$filesToCompress = "intool.exe","inupgradeutil.exe","inow.ini","intool.ini"
$filesToExclude = "inserver.exe","inserverWorkflow.exe","inserverBatch.exe","inserverAlarm.exe","inserverFS.exe","inserverImp.exe","inserverJob.exe","inserverNotification.exe","inserverOSM.exe","inserverTask.exe","*.log","*.zip" # We do not need any other executables outside of intool and inupgradeutil. The rest will not be utilized and use up space.
$compressedFolderName = "intoolScalabilityArchive.7z"

$files = Get-ChildItem $folderToCompress -Include $filesToCompress -Exclude $filesToExclude -Recurse | Select-Object -ExpandProperty FullName

& "E:\Program Files\7-Zip\7z.exe" a $compressedFolderName $files

<#
    We need to identify our location for extraction.
#>

$remoteLocation = Read-Host "Provide the Remote Location (do not include the end slash): "

& "E:\Program Files\7-Zip\7z.exe" x "$($remoteLocation)\$($compressedFolderName)" -o"E:\$($destinationLocation)"

# We need to make our ODBC Connection so that intool can find the Database.

$odbcdsnname = Read-Host "Please Provide a Name for your"
$server = Read-Host "Please Provide the hostname or IPv4 Address: "
$driverName = Read-Host "Please Provide a Driver Name (e.g. ODBD Driver 17 for SQL Server): "
$sqlauthorwindowsauth = Read-Host "Please provide Yes for SQL Auth or No for Windows Auth: "
$database = Read-Host "Please Provide the Name of the Database: "
$port = Read-Host "Please Provide a Port (e.g. 1433): "
$useftmonly = Read-Host "Provide a Yes or No for File Transfer Manager." # This is for metadata Discovery

# We are Defaulting QuotedIdentifiers to Yes and Description to Created by Powershell Script.

<#
This needs to be incorporated below:
    Invoke-Command -ComputerName $remoteComputer -ScriptBlock {
    param($remotePath, $destinationPath)

    & 'C:\Program Files\7-Zip\7z.exe' x $remotePath -o$destinationPath
} -ArgumentList $remotePath, $destinationPath
#>


# While Loop
$delegateComputer = 'start'
WHILE($NULL -ne $delegateComputer) # While Loop and Read-Host behaviour. Retains last input. We need to null it before asking each time then.
{
    $delegateComputer = $NULL
    $delegateComputer = Read-Host "Please provide the Server setting intool up at (e.g. Server02,ABC-1234):"
    Enable-WSManCredSSP -Role Client -DelegateComputer $delegateComputer
    $s = New-PSSession $delegateComputer


<#
    The Credential Account must be within the Administrator Group of the Computer being accessed.
#>

Invoke-Command -Session $s -ScriptBlock {Enable-WSManCredSSP -Role Server -Force}
$parameters = @{
ComputerName = $delegateComputer;
ScriptBlock = {Add-OdbcDsn -Name $odbcdsnname -DriverName $driverName -DsnType System -Platform 64-bit -Encrypt -SetPropertyValue @("server=$($server)","Trusted_Connection=$($sqlauthorwindowsauth)","Database=$($database)","UseFTMONLY=$($useftmonly)","Port=$($port)","QuotedIdentifiers=Yes","description=Created by Powershell Script.")};
Authentication = 'CredSSP';
Credential = "Domain01\Administrator";
}

Invoke-Command @parameters
}
