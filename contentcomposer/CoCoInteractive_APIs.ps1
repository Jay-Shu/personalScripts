<#
    Script Name: CoCoInteractive_APIs.ps1
    Author: Jacob Shuster
    Date Created: 2024-03-24

    Purpose: Enabling Interaction for an Administrator through MWS APIs
    Script resides in:
        E:\scripts\contentcomposer\2024\CoCoInteractive_APIs.ps1
    Functions reside in:
        E:\scripts\contentcomposer\2024\function_libraray

    Changelog:
        2024-03-25: Added the changelog
        2024-03-25: Initial If-blocks for separating the Functions
        2024-03-27: Additional notes for Variables and the Form.
#>

<#
    Module Imports go here:
    These MUST have the FULLPATH to the PSM1 directory.
    Otherwise, the modules will not be found.
    Update these following initial setup.
    Ideally your path will have no spaces.
#>

Import-Module E:\scripts\contentcomposer\2024\function_library\authentication.psm1 -Global -Force;
Import-Module E:\scripts\contentcomposer\2024\function_library\scriptname.psm1 -Global -Force;
Import-Module E:\scripts\contentcomposer\2024\function_library\docsandobj.psm1 -Global -Force;
Import-Module E:\scripts\contentcomposer\2024\function_library\respository.psm1 -Global -Force;
Import-Module E:\scripts\contentcomposer\2024\function_library\users_and_roles.psm1 -Global -Force;
Import-Module E:\scripts\contentcomposer\2024\function_library\utilities.psm1 -Global -Force;


$popUpText = @'
"End Session"
"User Info"
"Clear Cache"
"Health Check"
"Get Repo System List"
"Get System By Name"
"Repo Get Folder Content"
"Repo Get Folder Tree"
"Repo Get Forms"
"Repo Get Printers"
"Repo Get System Content"
"Repo Get Value"
"Get Roles"
"Get Users of Role"
"Get Doc File Mime"
"Set Doc File Mime"
"Get Object Structure"
"Set Object Outputparams"
"Toggle Object"
"Preview Page"
"Create Process"
"Delete Process"
"Get Process Info"
"Get Process List"
"Open Process"
"Set Process Data"
If you do not select one of the following the default is to end the script.
'@


$wshell = New-Object -ComObject Wscript.Shell;
$wshell.Popup($popUpText,15,"Content Composer Options",1);
<#
    Variables:
        contentcomposeriis; This variable is the FQDN, Hostname,
            or IP Address of the Content Composer MWS Server.
        port; This variable is the port number used by MWS
        CoCoUri; This variable is for building the base URI of MWS.
            Do not change this.
            #contentcomposeriis = "contentcomposer.server.domain";
    #port = "9100";
#>
$globalVars = @{
    gCoCoUri = "https://contentcomposer.server.domain:9100";
}

# "https://$($globalVars.contentcomposeriis):$($globalVars.port)"

Add-Type -AssemblyName System.Windows.Forms;
Add-Type -AssemblyName System.Drawing;
<#
    We need to create our Form Object.
    Therefore to establish this
    use "New-Object System.Windows.Forms.Form

#>
$form = New-Object System.Windows.Forms.Form;

<#
    Giving our Form a Title.
    This will be displayed on the top bar of the windows
    created by this script.
    Pixels are used for Drawing. This means
    is used (Width,Heigth). Additionally,
    1 in. = 100 pixels
    Example:
        3.5 x 5.25 = 350 x 525
            Translates to System.Drawing.Point(350,525)
        8.5 x 11.5 = 850 x 1150
            Translate to System.Drawing.Size(850,1150)
#>

$form.Text = 'Content Composer MWS APIs Tester (McGee ECM Solutions, LLC.)';

# New-Object System.Drawing.Size(Width,Heighth)
$form.Size = New-Object System.Drawing.Size(300,220);
$form.StartPosition = 'CenterScreen';

<#
    Standard OK Button to use. This can be anything we want
    it to be. For the time being it will remain as OK.
    Pixels are used for Drawing. This means
    is used (Width,Heigth). Additionally,
    1 in. = 100 pixels
    Example:
        3.5 x 5.25 = 350 x 525
            Translates to System.Drawing.Point(350,525)
        8.5 x 11.5 = 850 x 1150
            Translate to System.Drawing.Size(850,1150)
#>

$okButton = New-Object System.Windows.Forms.Button;
$okButton.Location = New-Object System.Drawing.Point(75,155);
$okButton.Size = New-Object System.Drawing.Size(75,23);
$okButton.Text = 'OK';
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK;
$form.AcceptButton = $okButton;
$form.Controls.Add($okButton);

<#
    Standard Cancel Button to use. This can be anything we want
    it to be. For the time being it will remain as Cancel.
    Pixels are used for Drawing. This means
    is used (Width,Heigth). Additionally,
    1 in. = 100 pixels
    Example:
        3.5 x 5.25 = 350 x 525
            Translates to System.Drawing.Point(350,525)
        8.5 x 11.5 = 850 x 1150
            Translate to System.Drawing.Size(850,1150)
#>

$cancelButton = New-Object System.Windows.Forms.Button;
$cancelButton.Location = New-Object System.Drawing.Point(150,155);
$cancelButton.Size = New-Object System.Drawing.Size(75,23);
$cancelButton.Text = 'Cancel';
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel;
$form.CancelButton = $cancelButton;
$form.Controls.Add($cancelButton);

<#
    We are Requesting which action to Take.
    Pixels are used for Drawing. This means
    is used (Width,Heigth). Additionally,
    1 in. = 100 pixels
    Example:
        3.5 x 5.25 = 350 x 525
            Translates to System.Drawing.Point(350,525)
        8.5 x 11.5 = 850 x 1150
            Translate to System.Drawing.Size(850,1150)
#>

$label = New-Object System.Windows.Forms.Label;
$label.Location = New-Object System.Drawing.Point(10,20);
$label.Size = New-Object System.Drawing.Size(280,20);
$label.Text = 'Please provide the Action you wish to Take: ';
$form.Controls.Add($label);

<# 
    Accompanying Text Box for the Label
        Pixels are used for Drawing. This means
    is used (Width,Heigth). Additionally,
    1 in. = 100 pixels
    Example:
        3.5 x 5.25 = 350 x 525
            Translates to System.Drawing.Point(350,525)
        8.5 x 11.5 = 850 x 1150
            Translate to System.Drawing.Size(850,1150)
#>

$textBox = New-Object System.Windows.Forms.TextBox;
$textBox.Location = New-Object System.Drawing.Point(10,40);
$textBox.Size = New-Object System.Drawing.Size(260,20);
$form.Controls.Add($textBox);

<#
    We are requesting the The Base URI for the Instance
    This means https://contentcomposer.server:port
    Pixels are used for Drawing. This means
    is used (Width,Heigth). Additionally,
    1 in. = 100 pixels
    Example:
        3.5 x 5.25 = 350 x 525
            Translates to System.Drawing.Point(350,525)
        8.5 x 11.5 = 850 x 1150
            Translate to System.Drawing.Size(850,1150)
#>

$label2 = New-Object System.Windows.Forms.Label;
$label2.Location = New-Object System.Drawing.Point(10,60);
$label2.Size = New-Object System.Drawing.Size(280,60);
$label2.Text = 'Please enter your base address to MWS (https://FQDN:PORT) Do not include the end slash "/" of the base addresss.';
$form.Controls.Add($label2);

<#
    We are requesting the following form: https://FQDN:port
        (Generalized version of what is above)
    Pixels are used for Drawing. This means
    is used (Width,Heigth). Additionally,
    1 in. = 100 pixels
    Example:
        3.5 x 5.25 = 350 x 525
            Translates to System.Drawing.Point(350,525)
        8.5 x 11.5 = 850 x 1150
            Translate to System.Drawing.Size(850,1150)
#>#>
$textBox2 = New-Object System.Windows.Forms.TextBox;
$textBox2.Location = New-Object System.Drawing.Point(10,130);
$textBox2.Size = New-Object System.Drawing.Size(260,20);
$form.Controls.Add($textBox2);

$form.Topmost = $true;

$form.Add_Shown({$textBox.Select()});
$result = $form.ShowDialog();

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{   

    $actionToPerform = $textBox.Text;

    if($null -eq $CoCoUri){
        $CoCoUri = $globalVars.gCoCoUri;
    }; # Closing Bracket for CoCoUri If Clause
    $CoCoUri = $textBox2.Text;
    Write-Host "Performing Health Check";
    Write-Host "Using Base URI: $($CoCoUri)";
    Write-Host "Performing Action: $($actionToPerform)";
    $CoCoHealth = healthcheck;

if($null -ne $CoCoHealth){
    $sessionId = loginSession -CoCoUri $CoCoUri;
} else {
    Write-Host $CoCoUri;
    Write-Host $actionToPerform;
    Write-Host "Healthcheck failed. Exiting Script: " -NoNewline | Get-CurrentLineNumber;
    # Wait-Event -Timeout 10;
    # Set to return for now to keep on processing.
    return;
}; # Closing Bracket for else clause

}; # Closing Bracket for Result If Clause.

<#
    Each of the below actions are representative of their
    corresponding MWS API Name aside from removeSession = logout
#>

switch ($actionToPerform) {
    "End Session" {removeSession -sessionId $sessionId -CoCoUri $CoCoUri}
    "User Info" {userInfo -sessionId $sessionId -CoCoUri $CoCoUri}
    "Clear Cache" {clearCache -sessionId $sessionId -CoCoUri $CoCoUri}
    "Health Check" {healthCheck -sessionId $sessionId -CoCoUri $CoCoUri}
    "Get Repo System List" {getRepoSystemList -sessionId $sessionId -CoCoUri $CoCoUri}
    "Get System By Name" {getSystemByName -sessionId $sessionId -CoCoUri $CoCoUri}
    "Repo Get Folder Content" {repGetFolderContent -sessionId $sessionId  -CoCoUri $CoCoUri -filter $folderContentFilter}
    "Repo Get Folder Tree" {repGetFolderTree -sessionId $sessionId  -CoCoUri $CoCoUri -startFolder $startFolder}
    "Repo Get Forms" {repGetForms -sessionId $sessionId -CoCoUri $CoCoUri -usedByPrinterId $usedByPrinterId -usedByPrinterName $usedByPrinterName -printerType $printerType}
    "Repo Get Printers" {repGetPrinters -sessionId $sessionId  -CoCoUri $CoCoUri -containingFormId $containingFormId -containingFormName $containingFormName}
    "Repo Get System Content" {repGetSystemContent -sessionId $sessionId  -CoCoUri $CoCoUri -filter $getSystemContentFilter}
    "Repo Get Value" {repGetValueHelpDefintion -sessionId $sessionId -CoCoUri $CoCoUri}
    "Get Roles" {getRoles -sessionId $sessionId -CoCoUri $CoCoUri}
    "Get Users of Role" {getUsersOfRole -sessionId $sessionId -CoCoUri $CoCoUri -roleName $roleName}
    "Get Doc File Mime" {docGetFileMime -sessionId $sessionId -CoCoUri $CoCoUri}
    "Set Doc File Mime" {docSetFileMime -sessionId $sessionId -CoCoUri $CoCoUri -body $body}
    "Get Object Structure" {objGetStructure -sessionId $sessionId -CoCoUri $CoCoUri -rootReference $rootReference -maxLevel $maxLevel}
    "Set Object Outputparams" {objSetOutputparams -sessionId $sessionId -CoCoUri $CoCoUri -body $body}
    "Toggle Object" {objToggle -sessionId $sessionId -CoCoUri $CoCoUri}
    "Preview Page" {previewPage -sessionId $sessionId -CoCoUri $CoCoUri -docId $docId -pageNo $pageNum}
    "Create Process" {processCreate -sessionId $sessionId -CoCoUri $CoCoUri -body $body}
    "Delete Process" {processDelete -sessionId $sessionId -CoCoUri $CoCoUri}
    "Get Process Info" {processGetInfo -sessionId $sessionId -CoCoUri $CoCoUri -infoType $infoType}
    "Get Process List" {processGetList -sessionId $sessionId -CoCoUri $CoCoUri -startAt $startAt -max $max -listUser $listUser -includeForwarded $includedForwarded -includeNonForwarded $includeNonForwarded -includeState $includeState -shortProcessDescription $shortProcessDescription}
    "Open Process" {processOpen -sessionId $sessionId -CoCoUri $CoCoUri -body $body}
    "Set Process Data" {processSetData -sessionId $sessionId -CoCoUri $CoCoUri -body $body}
    Default{[console]::TreatControlCAsInput = $true;
        [console]::Write = "CTL+C";}
    #{removeSession -sessionId $sessionId -CoCoUri $CoCoUri}
} # Clsoing Bracket for Switch Clause.

# Write-Host $($__);
<#
    $sessionId = getCredentialsAndEstablishSession -CoCoUri $CoCoUri -DONE
    logOut -sessionId $sessionId -CoCoUri $CoCoUri
    userInfo -sessionId $sessionId -CoCoUri $CoCoUri
    clearCache -sessionId $sessionId -CoCoUri $CoCoUri
    healthCheck -sessionId $sessionId -CoCoUri $CoCoUri
    getRepoSystemList -sessionId $sessionId -CoCoUri $CoCoUri
    getSystemByName -sessionId $sessionId -CoCoUri $CoCoUri
    repGetFolderContent -sessionId $sessionId  -CoCoUri $CoCoUri -filter $folderContentFilter
    repGetFolderTree -sessionId $sessionId  -CoCoUri $CoCoUri -startFolder $startFolder
    repGetForms -sessionId $sessionId -CoCoUri $CoCoUri -usedByPrinterId $usedByPrinterId -usedByPrinterName $usedByPrinterName -printerType $printerType
    repGetPrinters -sessionId $sessionId  -CoCoUri $CoCoUri -containingFormId $containingFormId -containingFormName $containingFormName
    repGetSystemContent -sessionId $sessionId  -CoCoUri $CoCoUri -filter $getSystemContentFilter
    repGetValueHelpDefintion -sessionId $sessionId -CoCoUri $CoCoUri
    getRoles -sessionId $sessionId -CoCoUri $CoCoUri
    getUsersOfRole -sessionId $sessionId -CoCoUri $CoCoUri -roleName $roleName
    docGetFileMime -sessionId $sessionId -CoCoUri $CoCoUri
    docSetFileMime -sessionId $sessionId -CoCoUri $CoCoUri -body $body
    objGetStructure -sessionId $sessionId -CoCoUri $CoCoUri -rootReference $rootReference -maxLevel $maxLevel
    objSetOutputparams -sessionId $sessionId -CoCoUri $CoCoUri -body $body
    objToggle -sessionId $sessionId -CoCoUri $CoCoUri
    previewPage -sessionId $sessionId -CoCoUri $CoCoUri -docId $docId -pageNo $pageNum
    processCreate -sessionId $sessionId -CoCoUri $CoCoUri -body $body
    processDelete -sessionId $sessionId -CoCoUri $CoCoUri
    processGetInfo -sessionId $sessionId -CoCoUri $CoCoUri -infoType $infoType
    processGetList -sessionId $sessionId -CoCoUri $CoCoUri -startAt $startAt -max $max -listUser $listUser -includeForwarded $includedForwarded -includeNonForwarded $includeNonForwarded -includeState $includeState -shortProcessDescription $shortProcessDescription
    processOpen -sessionId $sessionId -CoCoUri $CoCoUri -body $body
    processSetData -sessionId $sessionId -CoCoUri $CoCoUri -body $body
#>
#Exit;

<#
while ($true)
{
    write-host "Processing..."
    if ([console]::KeyAvailable)
    {
        $key = [system.console]::readkey($true)
        if (($key.modifiers -band [consolemodifiers]"control") -and ($key.key -eq "C"))
        {
            Add-Type -AssemblyName System.Windows.Forms
            if ([System.Windows.Forms.MessageBox]::Show("Are you sure you want to exit?", "Exit Script?", [System.Windows.Forms.MessageBoxButtons]::YesNo) -eq "Yes")
            {
                "Terminating..."
                break
            }
        }
    }
}
#>