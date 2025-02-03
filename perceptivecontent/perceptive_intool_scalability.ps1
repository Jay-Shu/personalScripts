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

                    Changelog:
                        2025-01-15: Added a form for input as opposed to Console only. This form populates values for the ODBC.
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
        }
        elseif ($_ -match "^([^=]+)=(.*)$") {
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
    }
    else {
        Write-Error "Section or Key not found!"
    }
}
# We need to make our ODBC Connection so that intool can find the Database.

<#
    Staged for the Form
#>
$odbcdbms = "SQL Server"

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

<#
$odbcdsnname = Read-Host "Please Provide a Name for your"
$server = Read-Host "Please Provide the hostname or IPv4 Address: "
$driverName = Read-Host "Please Provide a Driver Name (e.g. ODBC Driver 17 for SQL Server): "
$sqlauthorwindowsauth = Read-Host "Please provide Yes for SQL Auth or No for Windows Auth: "
$database = Read-Host "Please Provide the Name of the Database: "
$port = Read-Host "Please Provide a Port (e.g. 1433): "
$useftmonly = Read-Host "Provide a Yes or No for File Transfer Manager." # This is for metadata Discovery
#>

$form = New-Object System.Windows.Forms.Form
$form.Text = 'ODBC Connection Setup'
$form.Size = New-Object System.Drawing.Size(600, 400)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(400, 330)
$okButton.Size = New-Object System.Drawing.Size(75, 23)
$okButton.Text = 'OK'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(480, 330)
$cancelButton.Size = New-Object System.Drawing.Size(75, 23)
$cancelButton.Text = 'CANCEL'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$odbcdsnlabel = New-Object System.Windows.Forms.Label
$odbcdsnlabel.Location = New-Object System.Drawing.Point(10, 20)
$odbcdsnlabel.Size = New-Object System.Drawing.Size(280, 20)
$odbcdsnlabel.Text = 'Provide the ODBC DSN:'
$form.Controls.Add($odbcdsnlabel)

$odbcdsntext = New-Object System.Windows.Forms.TextBox
$odbcdsntext.Location = New-Object System.Drawing.Point(10, 40)
$odbcdsntext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcdsntext)

$odbcserverlabel = New-Object System.Windows.Forms.Label
$odbcserverlabel.Location = New-Object System.Drawing.Point(10, 60)
$odbcserverlabel.Size = New-Object System.Drawing.Size(280, 20)
$odbcserverlabel.Text = 'Provide the ODBC Server:'
$form.Controls.Add($odbcserverlabel)

$odbcservertext = New-Object System.Windows.Forms.TextBox
$odbcservertext.Location = New-Object System.Drawing.Point(10, 80)
$odbcservertext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcservertext)

$odbcdrivernamelabel = New-Object System.Windows.Forms.Label
$odbcdrivernamelabel.Location = New-Object System.Drawing.Point(10, 100)
$odbcdrivernamelabel.Size = New-Object System.Drawing.Size(280, 30)
$odbcdrivernamelabel.Text = 'Please Provide a Driver Name (e.g. ODBC Driver 17 for SQL Server):'
$form.Controls.Add($odbcdrivernamelabel)

$odbcdrivernametext = New-Object System.Windows.Forms.TextBox
$odbcdrivernametext.Location = New-Object System.Drawing.Point(10, 130)
$odbcdrivernametext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcdrivernametext)

$odbcsqlauthorwindowsauthlabel = New-Object System.Windows.Forms.Label
$odbcsqlauthorwindowsauthlabel.Location = New-Object System.Drawing.Point(10, 150)
$odbcsqlauthorwindowsauthlabel.Size = New-Object System.Drawing.Size(280, 30)
$odbcsqlauthorwindowsauthlabel.Text = 'Please provide Yes for SQL Auth or No for Windows Auth:'
$form.Controls.Add($odbcsqlauthorwindowsauthlabel)

$odbcsqlauthorwindowsauthtext = New-Object System.Windows.Forms.TextBox
$odbcsqlauthorwindowsauthtext.Location = New-Object System.Drawing.Point(10, 180)
$odbcsqlauthorwindowsauthtext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcsqlauthorwindowsauthtext)

$odbcdatabaselabel = New-Object System.Windows.Forms.Label
$odbcdatabaselabel.Location = New-Object System.Drawing.Point(10, 200)
$odbcdatabaselabel.Size = New-Object System.Drawing.Size(280, 20)
$odbcdatabaselabel.Text = 'Please Provide the Name of the Database:'
$form.Controls.Add($odbcdatabaselabel)

$odbcdatabasetext = New-Object System.Windows.Forms.TextBox
$odbcdatabasetext.Location = New-Object System.Drawing.Point(10, 220)
$odbcdatabasetext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcdatabasetext)

$odbcportlabel = New-Object System.Windows.Forms.Label
$odbcportlabel.Location = New-Object System.Drawing.Point(10, 200)
$odbcportlabel.Size = New-Object System.Drawing.Size(280, 20)
$odbcportlabel.Text = 'Please Provide a Port (e.g. 1433):'
$form.Controls.Add($odbcportlabel)

$odbcporttext = New-Object System.Windows.Forms.TextBox
$odbcporttext.Location = New-Object System.Drawing.Point(10, 220)
$odbcporttext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcporttext)

$odbcuseftmonlylabel = New-Object System.Windows.Forms.Label
$odbcuseftmonlylabel.Location = New-Object System.Drawing.Point(10, 240)
$odbcuseftmonlylabel.Size = New-Object System.Drawing.Size(280, 20)
$odbcuseftmonlylabel.Text = 'Provide a Yes or No for File Transfer Manager:'
$form.Controls.Add($odbcuseftmonlylabel)

$odbcuseftmonlytext = New-Object System.Windows.Forms.TextBox
$odbcuseftmonlytext.Location = New-Object System.Drawing.Point(10, 260)
$odbcuseftmonlytext.Size = New-Object System.Drawing.Size(260, 20)
$form.Controls.Add($odbcuseftmonlytext)


$form.Topmost = $true

$form.Add_Shown(
    {
        $odbcdsntext.Select(),
        $odbcservertext.Select(),
        $odbcdrivernametext.Select(),
        $odbcsqlauthorwindowsauthtext.Select(),
        $odbcdatabasetext.Select(),
        $odbcporttext.Select(),
        $odbcuseftmonlytext.Select()
    }
)
#$form.Add_Shown({$odbcdsntext.Activate()})
$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK) {

    # We are Defaulting QuotedIdentifiers to Yes and Description to Created by Powershell Script.

    <#
This needs to be incorporated below:
    Invoke-Command -ComputerName $remoteComputer -ScriptBlock {
    param($remotePath, $destinationPath)

    & 'C:\Program Files\7-Zip\7z.exe' x $remotePath -o$destinationPath
} -ArgumentList $remotePath, $destinationPath
#>

    $folderToCompress = "E:\inserver\bin64"
    $filesToCompress = "intool.exe", "inupgradeutil.exe", "inow.ini", "intool.ini"
    $filesToExclude = "inserver.exe", "inserverWorkflow.exe", "inserverBatch.exe", "inserverAlarm.exe", "inserverFS.exe", "inserverImp.exe", "inserverJob.exe", "inserverNotification.exe", "inserverOSM.exe", "inserverTask.exe", "*.log", "*.zip", "*.txt" # We do not need any other executables outside of intool and inupgradeutil. The rest will not be utilized and take up space.
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

    WHILE ($NULL -ne $delegateComputer) { # While Loop and Read-Host behaviour. Retains last input. We need to null it before asking each time then.
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
    
        Update-IniValue $inowIniFilePath "ODBC" "odbc.dsn" $odbcdsntext.Text
        <#
        [ODBC]
        odbc.dbms=SQL Server
        odbc.dsn=$odbcdsntext.Text
        odbc.user.id=inuser
        odbc.user.password.encrypted=encryptedpassword
        odbc.user.password=
        odbc.use.dddriver=FALSE
        odbc.grid.max.fetch.countodbc.dbms=500

        # It is not recommended to use SQL Auth.
        auth.odbc.dbms=
        auth.odbc.user.id=inuser

        # Oracle Specifics
        odbc.oracle.optimizer_cost_based_transformation=FALSE
        odbc.oracle.optimizer_cost_based_transformation.override.enabled=FALSE
        odbc.oracle.replace_virtual_columns=FALSE
        odbc.oracle.replace_virtual_columns.override.enabled=FALSE
        odbc.oracle.set_client_info.enabled=TRUE
        odbc.oracle.using.function.based.indexes.recommended.defaults=TRUE
        odbc.oracle.views.dynamic.sampling.override.enabled=FALSE
        odbc.oracle.views.dynamic.sampling=2
        recovery.reuse.db.conn=FALSE
    #>
        <#
    The Credential Account must be within the Administrator Group of the Computer being accessed.
#>

        Invoke-Command -Session $s -ScriptBlock { Enable-WSManCredSSP -Role Server -Force }

        $parameters = @{
            ComputerName   = $delegateComputer;
            ScriptBlock    = { Add-OdbcDsn -Name $odbcdsntext.Text -DriverName $odbcdrivernametext.Text -DsnType System -Platform 64-bit -Encrypt -SetPropertyValue @("server=$($odbcservertext.Text)", "Trusted_Connection=$($odbcsqlauthorwindowsauthtext.Text)", "Database=$($odbcdatabasetext.Text)", "UseFTMONLY=$($odbcuseftmonlytext.Text)", "Port=$($odbcporttext.Text)", "QuotedIdentifiers=Yes", "description=Created by Powershell Script.") };
            Authentication = 'CredSSP';
            Credential     = "Domain01\Administrator";
        }

        Invoke-Command @parameters

        Exit-PSSession -ComputerName $delegateComputer
    }
}