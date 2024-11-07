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

                    .LINK
                    https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.4
                    about_Operators
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

 function Get-IniContent {
    param(
        [string]$FilePath
    )

    $iniContent = @{}

    Get-Content $FilePath | ForEach-Object {
        if ($_ -match "^\[(.+)\]$") {
            $sectionName = $matches[1]
            $iniContent[$sectionName] = @{}
        } elseif ($_ -match "^([^=]+)=(.*)$") {
            $key = $matches[1].Trim()
            $value = $matches[2].Trim()
            $iniContent[$sectionName][$key] = $value
        }
    }

    return $iniContent
}

function Update-IniValue {
    param(
        [string]$FilePath,
        [string]$Section,
        [string]$Key,
        [string]$NewValue
    )

    $ini = Get-IniContent $FilePath

    if ($ini.ContainsKey($Section) -and $ini[$Section].ContainsKey($Key)) {
        $ini[$Section][$Key] = $NewValue

        # Write the updated INI file
        $content = ""
        $ini.GetEnumerator() | ForEach-Object {
            $content += "[$($_.Key)]`r`n"
            $_.Value.GetEnumerator() | ForEach-Object {
                $content += "$($_.Key)=$($_.Value)`r`n"
            }
            $content += "`r`n"
        }
        <#
            Encoding argument value list:
                ascii
                ansi
                bigendianunicode
                bigendianutf32
                oem
                unicode
                uft7
                utf8
                utf8bom
                utf8NoBOM
                utf32
        #>
        Set-Content $FilePath $content -Encoding utf8BOM
        <#

Encoding table allows for the Names to be used:
Name               CodePage  BodyName           HeaderName         WebName            Encoding.EncodingName
shift_jis          932       iso-2022-jp        iso-2022-jp        shift_jis          Japanese (Shift-JIS)
windows-1250       1250      iso-8859-2         windows-1250       windows-1250       Central European (Windows)
windows-1251       1251      koi8-r             windows-1251       windows-1251       Cyrillic (Windows)
Windows-1252       1252      iso-8859-1         Windows-1252       Windows-1252       Western European (Windows)
windows-1253       1253      iso-8859-7         windows-1253       windows-1253       Greek (Windows)
windows-1254       1254      iso-8859-9         windows-1254       windows-1254       Turkish (Windows)
csISO2022JP        50221     iso-2022-jp        iso-2022-jp        csISO2022JP        Japanese (JIS-Allow 1 byte Kana)
iso-2022-kr        50225     iso-2022-kr        euc-kr             iso-2022-kr        Korean (ISO)
#>
    } else {
        Write-Error "Section or Key not found!"
    }
}
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

$folderToCompress = "E:\inserver\bin64"
$filesToCompress = "intool.exe","inupgradeutil.exe","inow.ini","intool.ini"
$filesToExclude = "inserver.exe","inserverWorkflow.exe","inserverBatch.exe","inserverAlarm.exe","inserverFS.exe","inserverImp.exe","inserverJob.exe","inserverNotification.exe","inserverOSM.exe","inserverTask.exe","*.log","*.zip","*.txt" # We do not need any other executables outside of intool and inupgradeutil. The rest will not be utilized and use up space.
$compressedFolderName = "intoolScalabilityArchive.7z"

$files = Get-ChildItem $folderToCompress -Include $filesToCompress -Exclude $filesToExclude -Recurse | Select-Object -ExpandProperty FullName

# Compression is only necessary once.
& "E:\Program Files\7-Zip\7z.exe" a $compressedFolderName $files

<#
    We need to identify our location for extraction.
#>

# While Loop
#$decompressedFolderName = $compressedFolderName -replace ".{4}$" # Removing the .zip from the name
$delegateComputer = 'start'

WHILE($NULL -ne $delegateComputer) # While Loop and Read-Host behaviour. Retains last input. We need to null it before asking each time then.
{
    # We need to know where we are going to
    #$remoteLocation = Read-Host "Provide the Remote Location (do not include the end slash): "
    
    # Uncomment the below two lines to include a random number generator with the name.
    # $randomNum = Get-Random  # For a number generator to add to the name
    # $decompressedFolderName += Get-Random

    
    $delegateComputer = $NULL # NULL the value
    $delegateComputer = Read-Host "Please provide the Server intool is being setup at (e.g. Server02,ABC-1234): "
    Enable-WSManCredSSP -Role Client -DelegateComputer $delegateComputer
    $s = New-PSSession $delegateComputer

    Write-Host "Your Destination Location will be appended to the front of \inserver\etc\inow.ini"
    Write-Host "The Inow.ini must be updated to reflect the name of the DSN."
    $destination = Read-Host "Please Provide the destination location (Drive:\folder\path): "
    & "E:\Program Files\7-Zip\7z.exe" x $compressedFolderName -o"$($destination)"
    $inowIniFilePath = "$($destination)\inserver\etc\inow.ini"
    # $inowIni = Get-IniContent "$($remoteLocation)\$($decompressedFolderName)\inserver\etc\inow.ini"
    Update-IniValue $inowIniFilePath "ODBC" "odbc.dsn" $odbcdsnname

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

    Exit-PSSession -ComputerName $delegateComputer
}
